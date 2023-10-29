Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698F97DAD32
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2QR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2QR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:17:26 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 129DFBA;
        Sun, 29 Oct 2023 09:17:23 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 734AC40A00; Sun, 29 Oct 2023 17:10:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 734AC40A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1698595856;
        bh=K01uBZjOi6MJBggCB1PXyOP/1H5GeP1Q9SQyHlNOR9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiwAXl6cid4H//9jwshG3o0P+lziIRrfSk7HMNHElnfRGqIJ+kEj82SF9MWkReqmD
         lRxDl09YSMlRRd3BVsCCAICgp13QqRrE09MGmjrzTozlGeqxBYo9dVAO8awWOLFRcl
         Dtlti4dwJ76pOqmfT+yN8GyKNYaV+yDUn/QEmsVI=
Date:   Sun, 29 Oct 2023 17:10:56 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Message-ID: <20231029161056.GB5887@www.linux-watchdog.org>
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
 <ZSpbfXzFeaoUJRZ3@Fedora>
 <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> On 10/14/23 02:12, Darren Hart wrote:
> >On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
> >>On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
> >>>Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> >>>introduced new timer math for watchdog revision 1 with the 48 bit offset
> >>>register.
> >>>
> >>>The gwdt->clk and timeout are u32, but the argument being calculated is
> >>>u64. Without a cast, the compiler performs u32 operations, truncating
> >>>intermediate steps, resulting in incorrect values.
> >>>
> >>>A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
> >>>timeout of 600s writes 3647256576 to the one shot watchdog instead of
> >>>300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
> >>>
> >>>Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
> >>>the order of operations explicit with parenthesis.
> >>>
> >>>Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> >>>Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> >>>Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> >>>Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> >>>Cc: Guenter Roeck <linux@roeck-us.net>
> >>>Cc: linux-watchdog@vger.kernel.org
> >>>Cc: linux-kernel@vger.kernel.org
> >>>Cc: linux-arm-kernel@lists.infradead.org
> >>>Cc: <stable@vger.kernel.org> # 5.14.x
> >>
> >>Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> >Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
> >you already picked it up? Anything more needed from me?
> >
> >Thanks,
> >
> 
> Sorry, I am suffering from what I can only describe as a severe case of
> maintainer/reviewer PTSD, and I have yet to find a way of dealing with that.

I can imagine what it is like. And I do know that if you wouldn't have been there, 
that I would have allready stopped being a maintainer. So I hope you can find the 
right cooping mechanisms. I also had to work non-stop the last 4 to 5 weeks and it was hell.
So I wish you all the best.

PS: picking up all patches that have your review-by tag on it as we speack.

Kind regards,
Wim.

