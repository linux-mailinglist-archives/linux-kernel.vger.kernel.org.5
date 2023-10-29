Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A07DAD2A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJ2QFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2QFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:05:01 -0400
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Oct 2023 09:04:58 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6CD8AC;
        Sun, 29 Oct 2023 09:04:58 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id ABF7240A00; Sun, 29 Oct 2023 16:53:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org ABF7240A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1698594786;
        bh=vjgtNdp09F9UOhfV3Gr3oRE9ICiZm0+VKnTWsGj5CNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfHfnPJx9JODnaKZyjSqjaZqEAb+QUTye1x5oBuiQtUORKX7RM5+izy5mS45KnJOW
         MzUCsKDaVAa893gJ1jMTi6y1VD52OwfK7kNcyrDMMVJor8AcaHaISMva12E1zRyKRB
         Xi1mCSjl468uIluNw/xHcYcY547LT0cWmQE44fhU=
Date:   Sun, 29 Oct 2023 16:53:06 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Message-ID: <20231029155306.GA5887@www.linux-watchdog.org>
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
 <ZSpbfXzFeaoUJRZ3@Fedora>
 <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
 <ZTqfQJiEMRD0Xc9S@Fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTqfQJiEMRD0Xc9S@Fedora>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

> On Sun, Oct 22, 2023 at 09:58:26AM -0700, Guenter Roeck wrote:
> > On 10/14/23 02:12, Darren Hart wrote:
> > > On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
> > > > On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
> > > > > Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > > > > introduced new timer math for watchdog revision 1 with the 48 bit offset
> > > > > register.
> > > > > 
> > > > > The gwdt->clk and timeout are u32, but the argument being calculated is
> > > > > u64. Without a cast, the compiler performs u32 operations, truncating
> > > > > intermediate steps, resulting in incorrect values.
> > > > > 
> > > > > A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
> > > > > timeout of 600s writes 3647256576 to the one shot watchdog instead of
> > > > > 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
> > > > > 
> > > > > Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
> > > > > the order of operations explicit with parenthesis.
> > > > > 
> > > > > Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > > > > Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > > > > Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> > > > > Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: linux-watchdog@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > Cc: <stable@vger.kernel.org> # 5.14.x
> > > > 
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
> > > you already picked it up? Anything more needed from me?
> > > 
> > > Thanks,
> > > 
> > 
> > Sorry, I am suffering from what I can only describe as a severe case of
> > maintainer/reviewer PTSD, and I have yet to find a way of dealing with that.
> > 
> 
> I'm sorry to hear it Guenter, it can be a thankless slog of a treadmill
> sometimes. I found having a co-maintainer a huge help to even out the human
> factors while maintaining the x86 platform drivers (in the before times).
>
> In the short term, should I ask if one of the Arm maintainers would be willing
> to pick this patch up?

I'm picking this one up right now. So no need to ask it to the Arm maintainers.

Kind regards,
Wim.

