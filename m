Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A994B7897E1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjHZPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHZPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:55:17 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB31BCC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693065315;
        bh=uOQFWUNdySX8EeZpY0WLS5LqmI/KGm+C1Y7SHtvTH3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=c0VkS6sWy6DJUQrn0fUHjaRasfarNGujlOjfUMAa0hDV1tG4FWC2Hw1GqttO1fhq7
         ks3fYfiZyYWp+SCEgH+EQcZA4bj0dGmK9IEDDFahFTGI+NdI/PQr+7Unx4tqIJoxI+
         BcKPH0IWKe1o+M5U+m1zdsEkYJM9vg4NQ61mEOoyga5xPTVJqb49LMDaqCl5XlXfIS
         qzHQuEOvpADvOZmOuUKQrx2p+I5S/bn1Kw9oY6ythCPF9G9WKKDHM9Dtt4fh9Gx+2E
         9rGSeUr97JJWPqEM5VGShj4v6Oex/Si4jQA+JC5Vg9hkj6+cs7arOaWOvnjt8MbtFj
         VAdXcqkV6InfA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id E408624B175;
        Sat, 26 Aug 2023 22:55:11 +0700 (WIB)
Date:   Sat, 26 Aug 2023 22:55:07 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] tools/nolibc: i386: Fix a stack misalign bug on
 _start
Message-ID: <ZOogWznEtMBZc5iE@biznet-home.integral.gnuweeb.org>
References: <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
 <20230826150704.7588-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826150704.7588-1-falcon@tinylab.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:07:04PM +0800, Zhangjin Wu wrote:
> > @@ -167,7 +167,8 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
> >  	__asm__ volatile (
> >  		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
> >  		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
> > -		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
> > +		"and  $-16, %esp\n"       /* align stack to 16 bytes                             */
> > +		"sub  $12, %esp\n"        /* last pushed argument must be 16-byte aligned        */
> 
> Ammar, the new call of _start_c() only requires a single push, it pushes
> the argument and minus %esp by 4, so, the alignment of %esp requires to
> minus 12 to reserve 16-byte alignment, is this description right?

Yes, that's correct.

> If so, What about further?
> 
>     "and  $-16, %esp\n"       /* align stack to 16 bytes                             */
>     "sub ($16 - $4), %esp"    /* the 'push %eax' breaks stack alignment, fix up it   */

The sub part should have been:

    "sub  $(16 - 4), %esp\n"

It's fine to me writing it that way too.

-- 
Ammar Faizi

