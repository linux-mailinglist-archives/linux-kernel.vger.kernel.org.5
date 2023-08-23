Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA4786003
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbjHWSnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbjHWSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:43:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436AE6C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:43:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-407db3e9669so41511cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692816188; x=1693420988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+XSIvloO52/PerpGIhD9DOTdAIwJk+Ck8XFoQL2ICM=;
        b=U3enfibZ7MUvZOLPvMsjhrEqUopH4bVD4f0QMW/QXQ2sQL9XmhV1FZ1SlM79vy4Te8
         I8io/Z5/7oSIbu5ghh8ykVDj/JSQv0Zx4VfUlrEIJavElN4aZElpSYBSJn/uHHDPgDKH
         oDitURq+84XUHRAF7wjLtIx8wOgcOLI6aIss2ZTIymKr3iO9AfV2e84Wv8j7wYl21YaJ
         zzFQnyL4/Wag1ee7UdOBnCcR6eyiCKTUHwPep0R/M3UBQDWuR2gj966L1NEEgJpMu7Ki
         yuBtopBRl80wC3JXvdcus+oe8yngzrBEZjBPi4cxTbUZ23d8WNoqO5Ena5O8qscAm460
         Q1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692816188; x=1693420988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+XSIvloO52/PerpGIhD9DOTdAIwJk+Ck8XFoQL2ICM=;
        b=FGBXDxBsWzLSlJCiP6UTsQ1Llv92eF7VIjfT1PLgdOLTWxgrYBfbYhU+KxP3NwqzoR
         6C4vye1cNUURLPlgMhivBepVnmUU0MwrcXlq4szXe78weUXJdrsuePn1DyW/lbrd3dcC
         kKj8i1ndpmBDlWWsIBRfKyQqZNP8Ct3TwDthya3otSAyg2sdXrmudk0bOOxynAb5QB9c
         0f8sf3yGQDADO56aYDMFSU6O/rUQccV+07a7F4WFG2AcxUvFKmMCeaQHFSeoOWiA+neA
         GxdGt/IpIPKZYrnI8E/QgC5HEJYNPlLy7gj+w90sWaTNH/kEXZAmRF7fwD7rD1tC/AiH
         xvgw==
X-Gm-Message-State: AOJu0YyTks5KvqfLqYfECi2gXpTEh7JFfSDA6/gGA5JFD9UiOvkzNpXu
        aX7WMQZcM+NZuZX+TjQ20vpfrCw9Pasm/oiPbAqNIw==
X-Google-Smtp-Source: AGHT+IENjXj5MwD0FjyqaHCxv/R/C1JZAejGWgv7ImlKmPWRbkiQxZENqzpnsbXnZEOwp8LzZHHCpx4DLbGtuwg0Jh4=
X-Received: by 2002:a05:622a:2d3:b0:3de:1aaa:42f5 with SMTP id
 a19-20020a05622a02d300b003de1aaa42f5mr599446qtx.15.1692816188425; Wed, 23 Aug
 2023 11:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817121513.1382800-1-jackmanb@google.com>
In-Reply-To: <20230817121513.1382800-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 23 Aug 2023 11:42:56 -0700
Message-ID: <CA+i-1C2JjKRNJQhsaXk0kYfre40X61iC9807V+Zu-4iBKNF0Hw@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/entry: Don't write to CR3 when restoring to
 kernel CR3
To:     luto@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, laijs@linux.alibaba.com,
        yosryahmed@google.com, reijiw@google.com, oweisse@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, just noticed I didn't put +Peter in the recipients.

On Thu, 17 Aug 2023 at 05:15, Brendan Jackman <jackmanb@google.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Skip resuming KERNEL pages since it is already KERNEL CR3
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>
> While staring at paranoid_exit I was confused about why we had this CR3
> write, avoiding it seems like a free optimisation. The original commit
> 21e94459110252 ("x86/mm: Optimize RESTORE_CR3") says "Most NMI/paranoid
> exceptions will not in fact change pagetables" but I didn't't understand
> what the "most" was referring to. I then discovered this patch on the
> mailing list, Andy said[1] that it looks correct so maybe now is the
> time to merge it?
>
> Note there's another patch in [1] as well, the benefit of that one is
> not obvious to me though.

Also expanding on this a bit: the main purpose of this code is to
switch back to the user address space after handling one of these
"paranoid" exceptions. When one of those exceptions interrupts kernel
mode, we didn't switch from user to kernel address space so the
restore isn't needed.

There's no other reason to change CR3 here; context switches don't
happen in these exceptions but even if they did we would restore CR3
from the returning context_switch path. In fact in that case doing it
in paranoid_exit would potentially use the wrong PCID if it had been
reallocated by choose_new_asid. (And on the other side of the coin if
the restore was needed, it would be needed under !KPTI too).

> We've tested an equivalent patch in our internal kernel.
>
> [1] https://lore.kernel.org/lkml/20200526043507.51977-3-laijs@linux.alibaba.com/
> -- >8 --
>  arch/x86/entry/calling.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index f6907627172b..b2458685d56e 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -236,14 +236,13 @@ For 32-bit we have the following conventions - kernel is built with
>  .macro RESTORE_CR3 scratch_reg:req save_reg:req
>         ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>
> -       ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
> -
>         /*
> -        * KERNEL pages can always resume with NOFLUSH as we do
> -        * explicit flushes.
> +        * Skip resuming KERNEL pages since it is already KERNEL CR3.
>          */
>         bt      $PTI_USER_PGTABLE_BIT, \save_reg
> -       jnc     .Lnoflush_\@
> +       jnc     .Lend_\@
> +
> +       ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
>
>         /*
>          * Check if there's a pending flush for the user ASID we're
> @@ -261,10 +260,6 @@ For 32-bit we have the following conventions - kernel is built with
>         SET_NOFLUSH_BIT \save_reg
>
>  .Lwrcr3_\@:
> -       /*
> -        * The CR3 write could be avoided when not changing its value,
> -        * but would require a CR3 read *and* a scratch register.
> -        */
>         movq    \save_reg, %cr3
>  .Lend_\@:
>  .endm
> --
> 2.41.0.694.ge786442a9b-goog
>
