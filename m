Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4A78C071
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjH2Iiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjH2IiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:38:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84720FF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:38:09 -0700 (PDT)
X-QQ-mid: bizesmtp71t1693298254t31b16n2
Received: from linux-lab-host.localdomain ( [116.30.128.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 29 Aug 2023 16:37:33 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: CR3LFp2JE4ky7+uTGvZzZpYYBVmQR83udOiXazEP9GOTcJyPyjz/9uewK3Leg
        LtilKXp6eUbLM1mNtJa7/Md6m4VOa91+Dr+O61h10eoBCfiqpwx5Z9l5durFnD+KjWg7MNj
        DLJPimsWNG4sihvdPYBtR4osBiis+6BJ5xM4uXFOTolZ8VwLqgcPgUZwyNDWGFE1kdCPxc4
        VsZh7dbq6+PeuSJWOm+EUSiQM0dVNCw7NrTpStFR28N/oMxa0By2SibU8fWSDrDkKqptuf8
        eT9NfkU+4L3Emrb5OCqLoScY0vMJSBXsF0d2ByVlgRTsKsMKWhrgs00kGIFwnTWLwo5DmG4
        NPvM//T3ytExpXQn2swWcqSiYQGo8b745VPql0HuDW8mmoMwTSFF4HfY6k6EQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18399361335853712054
From:   Zhangjin Wu <falcon@tinylab.org>
To:     ammarfaizi2@gnuweeb.org
Cc:     falcon@tinylab.org, gwml@vger.gnuweeb.org, inori@vnlx.org,
        linux-kernel@vger.kernel.org, linux@weissschuh.net,
        moe@gnuweeb.org, w@1wt.eu
Subject: [PATCH v2 1/1] tools/nolibc: i386: Fix a stack misalign bug on _start
Date:   Tue, 29 Aug 2023 16:37:32 +0800
Message-Id: <20230829083732.5981-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
References: <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ammar

> The ABI mandates that the %esp register must be a multiple of 16 when
> executing a 'call' instruction.
> 
> Commit 2ab446336b17 ("tools/nolibc: i386: shrink _start with _start_c")
> simplified the _start function, but it didn't take care of the %esp
> alignment, causing SIGSEGV on SSE and AVX programs that use aligned move
> instruction (e.g., movdqa, movaps, and vmovdqa).
>

As Thomas suggested and you replied, since there is no public report
link, what about uses the link which has test code at the end of above
paragraph.

    ...
    instruction (e.g., movdqa, movaps, and vmovdqa) [1].

> The 'and $-16, %esp' aligns the %esp at a multiple of 16. Then 'push
> %eax' will subtract the %esp by 4; thus, it breaks the 16-byte
> alignment. Make sure the %esp is correctly aligned after the push by
> subtracting 12 before the push.
> 

And at the end of commit message:

    [1]: https://lore.kernel.org/lkml/ZOoindMFj1UKqo+s@biznet-home.integral.gnuweeb.org/

This test code may be important for future change verification.

Thanks,
Zhangjin

> Cc: Zhangjin Wu <falcon@tinylab.org>
> Fixes: 2ab446336b17aad362c6decee29b4efd83a01979 ("tools/nolibc: i386: shrink _start with _start_c")
> Reported-by: Nicholas Rosenberg <inori@vnlx.org>
> Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>  tools/include/nolibc/arch-i386.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
> index 64415b9fac77f996..8079974424fa18b0 100644
> --- a/tools/include/nolibc/arch-i386.h
> +++ b/tools/include/nolibc/arch-i386.h
> @@ -167,7 +167,8 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
>  	__asm__ volatile (
>  		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
>  		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
> -		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
> +		"and  $-16, %esp\n"       /* align stack to 16 bytes                             */
> +		"sub  $(16 - 4), %esp\n"  /* push %eax breaks 16-byte alignment, so sub 12 bytes */
>  		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
>  		"call _start_c\n"         /* transfer to c runtime                               */
>  		"hlt\n"                   /* ensure it does not return                           */
> -- 
> Ammar Faizi
