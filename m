Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B37897A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjHZPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjHZPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:07:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DD010D7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:07:44 -0700 (PDT)
X-QQ-mid: bizesmtp67t1693062427tn000v0e
Received: from linux-lab-host.localdomain ( [116.30.128.222])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 26 Aug 2023 23:07:05 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: 5q30pvLz2ieEBQx0nw4AwVbcsW2lf9AQtedbunJNKIq0umdPrlU1WYxaGQJTB
        /xLXCQ64QjlcZRbHq7jhW5yGut+QHQxkQLr84/OH3jNGS3VC4CvpOYAXkK3GwhuwTU/bs5S
        4CIxMZVwLFJD8lTUd8VJVS0vT/6OK9GGgP92Ibn+qJmHJR06X7qysw0X82SmfEhUSO+4I0F
        9PHtDB68M6Acop+iZMlDFXG44X0MXdosR2aJjI6hAHs63iTFNdOnCn0YOwdjZNRaE5Q288R
        BrM2F0ZzLFMqM7A359j3T2MaoxvUgn3x7XRLUJBgX/18FaEaa0aY3BWk+kdA3XlJdQpIeoV
        u4oom7NNpcEcKGPaz/KoRX/xYyHsgZ2mpFQ6hzlDnJpa4wFUjMZsCdhVS/rWJRRgzGF/Q5U
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7776601677145500224
From:   Zhangjin Wu <falcon@tinylab.org>
To:     ammarfaizi2@gnuweeb.org
Cc:     falcon@tinylab.org, gwml@vger.gnuweeb.org, inori@vnlx.org,
        linux-kernel@vger.kernel.org, linux@weissschuh.net,
        moe@gnuweeb.org, w@1wt.eu
Subject: Re: [PATCH v1 1/1] tools/nolibc: i386: Fix a stack misalign bug on _start
Date:   Sat, 26 Aug 2023 23:07:04 +0800
Message-Id: <20230826150704.7588-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
References: <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ammar, Hi, Nicholas

Thanks very much for your report and fixup, sorry for the missing alignment for
the new single one push instruction.

> The ABI mandates that the %esp register must be a multiple of 16 when
> executing a call instruction.
> 
> Commit 2ab446336b17 simplified the _start function, but it didn't take
> care of the %esp alignment, causing SIGSEGV on SSE and AVX programs that
> use aligned move instruction (e.g., movdqa, movaps, and vmovdqa).
> 
> Ensure the %esp is a multiple of 16 when executing the call instruction.
> 
> Cc: Zhangjin Wu <falcon@tinylab.org>
> Fixes: 2ab446336b17aad362c6decee29b4efd83a01979 ("tools/nolibc: i386: shrink _start with _start_c")
> Reported-by: Nicholas Rosenberg <inori@vnlx.org>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>  tools/include/nolibc/arch-i386.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
> index 64415b9fac77f996..4edf238eeac67aa2 100644
> --- a/tools/include/nolibc/arch-i386.h
> +++ b/tools/include/nolibc/arch-i386.h
> @@ -167,7 +167,8 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
>  	__asm__ volatile (
>  		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
>  		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
> -		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
> +		"and  $-16, %esp\n"       /* align stack to 16 bytes                             */
> +		"sub  $12, %esp\n"        /* last pushed argument must be 16-byte aligned        */

Ammar, the new call of _start_c() only requires a single push, it pushes
the argument and minus %esp by 4, so, the alignment of %esp requires to
minus 12 to reserve 16-byte alignment, is this description right?

If so, What about further?

    "and  $-16, %esp\n"       /* align stack to 16 bytes                             */
    "sub ($16 - $4), %esp"    /* the 'push %eax' breaks stack alignment, fix up it   */

Thanks,
Zhangjin Wu

>  		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
>  		"call _start_c\n"         /* transfer to c runtime                               */
>  		"hlt\n"                   /* ensure it does not return                           */
> -- 
> Ammar Faizi
