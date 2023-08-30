Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5D78D205
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbjH3CZY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 22:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbjH3CZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:25:14 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ADFFCD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:25:09 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.128.177])
        by gateway (Coremail) with SMTP id _____8AxTeuCqO5kMfYcAA--.53800S3;
        Wed, 30 Aug 2023 10:25:07 +0800 (CST)
Received: from mail-yw1-f177.google.com (unknown [209.85.128.177])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM5_qO5kUudmAA--.52386S3;
        Wed, 30 Aug 2023 10:25:05 +0800 (CST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59254e181a2so57171547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:25:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywi5OlVcCzXKytvW1H1mGSzwSeQdInfSrT5DWu3Upf1Tdzl0q62
        jAtJXJyUI3xx35ERh9vCPsAxCg2gh230Xa66WIhx5g==
X-Google-Smtp-Source: AGHT+IHwn3cnwbRbMtDklB0MxCXJuVfILjzfHk14nmRQkuifQSiZdsDYSve+CjViqkipLWbpIVFH0w8x/jg4DlRT1Cs=
X-Received: by 2002:a0d:d4c9:0:b0:595:863:3852 with SMTP id
 w192-20020a0dd4c9000000b0059508633852mr837392ywd.19.1693362303032; Tue, 29
 Aug 2023 19:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230830010435.2969785-1-liweihao@loongson.cn>
In-Reply-To: <20230830010435.2969785-1-liweihao@loongson.cn>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 30 Aug 2023 10:24:51 +0800
X-Gmail-Original-Message-ID: <CAHirt9i0tcUCuQ5ZL657MOZ4CUg0bpfiNbo01WLhPAwsLjgM+g@mail.gmail.com>
Message-ID: <CAHirt9i0tcUCuQ5ZL657MOZ4CUg0bpfiNbo01WLhPAwsLjgM+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] LoongArch: adjust copy/clear_user exception handler behavior
To:     liweihao <liweihao@loongson.cn>
Cc:     chenhuacai@kernel.org, kernel@xen0n.name, masahiroy@kernel.org,
        yijun@loongson.cn, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8BxrM5_qO5kUudmAA--.52386S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFykZFW5ZF45tr4rCw45Jwc_yoW5WFy3pr
        yYy3Z3KF4rWayfXa1Y9F1Dtr9xZr40grWDAr4xJryrJ3WUurnYkry5J39agFnxt3ykXryj
        qayrKF1rCF48trbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello weihao,

On Wed, Aug 30, 2023 at 9:04 AM liweihao <liweihao@loongson.cn> wrote:
>
> The copy/clear_user function should returns number of bytes that could
> not be copied/cleared. So, try to copy/clear byte by byte when ld.d/w/h
> and st.d/w/h trapped into an exception.
>
> Signed-off-by: liweihao <liweihao@loongson.cn>
> ---
>  arch/loongarch/lib/clear_user.S |  87 ++++++++---------
>  arch/loongarch/lib/copy_user.S  | 161 ++++++++++++++++----------------
>  2 files changed, 127 insertions(+), 121 deletions(-)
>
> diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
> index 0790eadce166..9b6eef569f89 100644
> --- a/arch/loongarch/lib/clear_user.S
> +++ b/arch/loongarch/lib/clear_user.S
> @@ -11,19 +11,6 @@
>  #include <asm/cpu.h>
>  #include <asm/regdef.h>
>
> -.irp to, 0, 1, 2, 3, 4, 5, 6, 7
> -.L_fixup_handle_\to\():
> -       sub.d   a0, a2, a0
> -       addi.d  a0, a0, (\to) * (-8)
> -       jr      ra
> -.endr
> -
> -.irp to, 0, 2, 4
> -.L_fixup_handle_s\to\():
> -       addi.d  a0, a1, -\to
> -       jr      ra
> -.endr
> -
>  SYM_FUNC_START(__clear_user)
>         /*
>          * Some CPUs support hardware unaligned access
> @@ -51,7 +38,7 @@ SYM_FUNC_START(__clear_user_generic)
>  2:     move    a0, a1
>         jr      ra
>
> -       _asm_extable 1b, .L_fixup_handle_s0
> +       _asm_extable 1b, 2b
>  SYM_FUNC_END(__clear_user_generic)
>
>  /*
> @@ -173,33 +160,47 @@ SYM_FUNC_START(__clear_user_fast)
>         jr      ra
>
>         /* fixup and ex_table */
> -       _asm_extable 0b, .L_fixup_handle_0
> -       _asm_extable 1b, .L_fixup_handle_0
> -       _asm_extable 2b, .L_fixup_handle_1
> -       _asm_extable 3b, .L_fixup_handle_2
> -       _asm_extable 4b, .L_fixup_handle_3
> -       _asm_extable 5b, .L_fixup_handle_4
> -       _asm_extable 6b, .L_fixup_handle_5
> -       _asm_extable 7b, .L_fixup_handle_6
> -       _asm_extable 8b, .L_fixup_handle_7
> -       _asm_extable 9b, .L_fixup_handle_0
> -       _asm_extable 10b, .L_fixup_handle_1
> -       _asm_extable 11b, .L_fixup_handle_2
> -       _asm_extable 12b, .L_fixup_handle_3
> -       _asm_extable 13b, .L_fixup_handle_0
> -       _asm_extable 14b, .L_fixup_handle_1
> -       _asm_extable 15b, .L_fixup_handle_0
> -       _asm_extable 16b, .L_fixup_handle_0
> -       _asm_extable 17b, .L_fixup_handle_s0
> -       _asm_extable 18b, .L_fixup_handle_s0
> -       _asm_extable 19b, .L_fixup_handle_s0
> -       _asm_extable 20b, .L_fixup_handle_s2
> -       _asm_extable 21b, .L_fixup_handle_s0
> -       _asm_extable 22b, .L_fixup_handle_s0
> -       _asm_extable 23b, .L_fixup_handle_s4
> -       _asm_extable 24b, .L_fixup_handle_s0
> -       _asm_extable 25b, .L_fixup_handle_s4
> -       _asm_extable 26b, .L_fixup_handle_s0
> -       _asm_extable 27b, .L_fixup_handle_s4
> -       _asm_extable 28b, .L_fixup_handle_s0
> +.Llarge_fixup:
> +       sub.d   a1, a2, a0
> +
> +.Lsmall_fixup:
> +29:    st.b    zero, a0, 0
> +       addi.d  a0, a0, 1
> +       addi.d  a1, a1, -1
> +       bgt     a1, zero, 1b

I'm sure the jump target here is 29b.

-- 
WANG Rui

