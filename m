Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72A753240
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGNGsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjGNGrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:47:46 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91230F3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=zHLVNT4Ib177dr3Dr0VkglUlA6GRR6rwSc8RKuf20vE=;
        b=JjWKJR1TKMraQKPyb0o1cIyIx1nkuUOkvLCRB769LmWfTe+/QCCx5M2Z2ftVNTnaVW6U8IN2lF99l
         HYOHwwUuDgyhXmSiVZbLpWpanKMBWWglnCB9E0lY9GOp7tCz/U99hBGlyvcD2PyXVSNsRtR+QG2A+K
         OReMdDQwIiio44SvqOUIMURmw/dI2BhuFSHcZabubL+4ei9Pe7M03aB1rQyWmqmuppJFFSHRdnTP1l
         e/n891r7+vuOBZEv+mRFyZkjE8tm47fmWE/mN7YS2CGIUEEw+vdHB1nqAwfUCBpR+Ru3JHPUjYQ79E
         FKwoAxryblPIhSRwI+SCe5MyDlBiUgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=zHLVNT4Ib177dr3Dr0VkglUlA6GRR6rwSc8RKuf20vE=;
        b=m9xlOM3tF8rFO7Yh0b3YBT+kcTTk+KqPvZWhPjEBT4CMLTQmaFG7tDZs2dU2+9AViXPo3QGHoY8UZ
         w1MD83TAQ==
X-HalOne-ID: 541fafe2-2212-11ee-9df5-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 541fafe2-2212-11ee-9df5-99461c6a3fe8;
        Fri, 14 Jul 2023 06:47:42 +0000 (UTC)
Date:   Fri, 14 Jul 2023 08:47:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     liubin001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy:ERROR: missing put_device; call
 of_find_device_by_node on line 589, but without a corresponding object
 release within this function. Add the put_device function before return to
 release memory
Message-ID: <20230714064741.GA53474@ravnborg.org>
References: <tencent_0C9506095848D9427102ED415071D0F3420A@qq.com>
 <0f4dc280605c4700556d88d6f59cd1c4@208suo.com>
 <20230714060655.GA50441@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714060655.GA50441@ravnborg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LiuBin.

On Fri, Jul 14, 2023 at 08:06:55AM +0200, Sam Ravnborg wrote:
> Hi LiuBin
> 
> On Fri, Jul 14, 2023 at 12:56:29PM +0800, liubin001@208suo.com wrote:
> > Signed-off-by: LiuBin <liubin001@208suo.com>
> > ---
> >  arch/sparc/include/asm/floppy_64.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/sparc/include/asm/floppy_64.h
> > b/arch/sparc/include/asm/floppy_64.h
> > index 070c8c1f5c8f..c4c51f494f25 100644
> > --- a/arch/sparc/include/asm/floppy_64.h
> > +++ b/arch/sparc/include/asm/floppy_64.h
> > @@ -588,6 +588,7 @@ static unsigned long __init sun_floppy_init(void)
> > 
> >          op = of_find_device_by_node(dp);
> >          if (!op)
> > +            put_device(op);
> >              return 0;
> 
> This does not look right as the code will always return 0 now,
> independent on the if test. You missed a set of curly braces.

Two more notes.
Please put the description of the fix in the body of the mail.
Right now it is a very long subject - and we try to keep subject shorter
than ~70 chars.

> > Signed-off-by: LiuBin <liubin001@208suo.com>
You are expected to sign-off the patch with you name and not a nickname.
If LiuBin is indeed you name then sorry and ignore this comment.

I look forward to the updated patch.

	Sam
