Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9580DFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjLLAGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjLLAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:05:46 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F3DD0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:05:53 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d84ddd642fso3863085a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702339552; x=1702944352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mXLZeR4Bg70XdW95zE9udRxRkmyhgCjX63YmFmBgJY=;
        b=I1P1vBC2y1xnzHr6TPfK0gbpktiKUxQaO3B/P5rGs8DmzOUcfXcrALOxJ/U4+Bkqz4
         t6dKGs53hmuQpptkshvyoleiYshkUTOz9ZCy+3q5+j6uwIu3+YJ0uso6lV1FkBdpw0UQ
         qv5OaoRQkwEXg0EetHodqJUueoOM/4VzaTTpPYzZm4zviAPiQijYqD4BImdX6YjpqCo5
         f5buPjaNFn9gAbQAOke9qtgjjYyUlSyRPg3g7+vKOROo8KmRDH57ADa+iWbRv14wosUl
         HYgKX0jjv99YorX+/yWPl4uVbv68HManvxgD+fQvAQT7JJ1mf4Pr9F8JJhgiPJBgBHOL
         jjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702339552; x=1702944352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mXLZeR4Bg70XdW95zE9udRxRkmyhgCjX63YmFmBgJY=;
        b=gAxQ0kpE2biQJ/Sn6/gVJ/nNDorAxaipxywxGc/jsWmIcNsOPMdoGn8P7datTTgCku
         rW72gwHmpeulEOl6xlDLbQOe9TeP5JF6VqvVKpDa1TyKoZ2ZH/IRD1iWg7HJAHif6RIY
         TPw6XvaE4hEuwm8MUn68zzWBOYpF8iSFEmGDDVc4TxYsoRMHcVy+xz+cIrg5dvZX26uL
         Zan7hj5l0PgGLq+YXOaNRTMbA432+TIMgbKQ3/0M+XO0ekL1Qz8dDo0NEujw2bbBFSdx
         xgFuC2aX68vV0+NySY8q4hQIpWACe4FS8tT6zK9mHH434eP6mj98k4Hb+SP+gf2Bcv9m
         U7kg==
X-Gm-Message-State: AOJu0YyMpK8O8EbblIJl/+8DHp0VfSq/3DBO5Ladi8NUaLKTveMR2AnO
        bTCDvQRGLUJUz6h67vP4vgvpak3Ndb0QW6CHGCqv/0L7uA3e9537ehFCfA==
X-Google-Smtp-Source: AGHT+IHDoY5nf+90uQxFaXK754uPjRArDu8vpXBwoVdMNLofQd6HViktA0h5szWRpceKnwYEklVGY/k+rpioz2etP2Y=
X-Received: by 2002:a9d:7981:0:b0:6d8:5421:1e0c with SMTP id
 h1-20020a9d7981000000b006d854211e0cmr5520995otm.34.1702339552335; Mon, 11 Dec
 2023 16:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20231211-removeasmgeneric-v1-1-a0274e802789@google.com>
In-Reply-To: <20231211-removeasmgeneric-v1-1-a0274e802789@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Dec 2023 16:05:35 -0800
Message-ID: <CAKwvOdnEKyR7+c_tZOoS2aVb3WQceMdctHmgyh0cNKmm-UFS4A@mail.gmail.com>
Subject: Re: [PATCH] arch/riscv/kernel/sys_riscv.c: removed asm-generic
To:     tanzirh@google.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <nnn@google.com>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 2:52=E2=80=AFPM <tanzirh@google.com> wrote:
>
> arch/riscv/kernel/sys_riscv.c builds without using anything
> from asm-generic/mman-common.h. There seems to be no reason
> to include this file.
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>
> ---
>  arch/riscv/kernel/sys_riscv.c | 1 -

If you run `git log arch/riscv/kernel/sys_riscv.c`, you'll find the
prefix used on the oneline of the commit for this file is generally
one of:

- RISC-V:
- riscv:

You should choose one of the above rather than
`arch/riscv/kernel/sys_riscv.c:`.  Sorry I missed that in internal
code review, but would you mind please sending a v2 with that fixed?
I'd expect something like:

riscv: remove unused header

+Conor who pointed this out to me on IRC

>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.=
c
> index a2ca5b7756a5..ebcaf386ea62 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -14,7 +14,6 @@
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> -#include <asm-generic/mman-common.h>
>  #include <vdso/vsyscall.h>
>
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231211-removeasmgeneric-f6be13a42b6b
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>


--
Thanks,
~Nick Desaulniers
