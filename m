Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16BB81321E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573256AbjLNNti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573297AbjLNNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:49:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD34137;
        Thu, 14 Dec 2023 05:49:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so7385829f8f.0;
        Thu, 14 Dec 2023 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702561776; x=1703166576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz4v/GlOIwynmVpkuyg76jXkQ9B94i1i3JqKLEq9zcc=;
        b=gB8USD0I+8E+cTNHyWkIQsK7WBA9zT7EX84JKpexDj7gQ8jklrmyrWVV3evoHJ0BwP
         6b2kURYOE4wtYSDct8K5Mq88TBCaYG727mELQz5raVoLQtJc9n00hGgBjPmxzZLUSYYS
         QAK20MUtqKXeQO4+/uaL/SlvLaNaRdGBvkAIJJotpuAH6bI74cz7O1hHp3MrV8SAEvM6
         kdJAD35T3hEmBMGp4r0voAPd0W3bUdcBUfup2QRJ4gBSVwSjMY4Qi4uQTl+FLBefFSRE
         mVcvRFIGqQ0NZzCBmtLR1zWQlSqkS9991fNHO+tf8tf6fpt9iyesXrrhrxse5JN+lpR2
         8uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561776; x=1703166576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz4v/GlOIwynmVpkuyg76jXkQ9B94i1i3JqKLEq9zcc=;
        b=YZblfFNCFplLkG6Xkbt+zQQt5DE7rN+Fz/aPIwauDALKW4L44x9eswkADnqC8tl3pB
         ERfh8au76IoP64QZmHrPBu9Scd0VulnAEpPDm6xDCh8r4yIUiygtWtcVlIC2RVY0UJSb
         SMvf/+bJ7ED0y/ds4BfTm/Ru0ZbfRLQS/7RR5tRHCqXp6KhwrTm6AWU3BjNyazuGQVCu
         gCNBnys5zgTXlIWreXEYVlNB+K3v6ZffI2InUmKIodWQ9wW9Uah9GOrm/7+Ljem8SUy9
         R1GQk80Dsr7i5o6w1wQJOvheWeLUwsTz+9qGVoF4U7TqcTnMj+ME6BqxnmD872+gbgCJ
         yscw==
X-Gm-Message-State: AOJu0YyLDLkrD2RJ2ehiK5HuowZ7zVPPR46s5b7IqJH6b53ntUDxKC8i
        NZnRfeDL+3iAZ+x0Sa+4kSyswVRtH1IfuGhOarQeTJbGLQs=
X-Google-Smtp-Source: AGHT+IGLVNeGM1q3z2hDPkZO/p1o3AnImQuLmOEyFq36N4qnFj8I21f63DvWxhm0mct6WgUtBEp4QdiZrYPuZ8MmxkA=
X-Received: by 2002:a5d:6208:0:b0:333:2fd2:6f54 with SMTP id
 y8-20020a5d6208000000b003332fd26f54mr4654191wru.94.1702561775638; Thu, 14 Dec
 2023 05:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20231214062434.3565630-1-menglong8.dong@gmail.com> <20231214062434.3565630-2-menglong8.dong@gmail.com>
In-Reply-To: <20231214062434.3565630-2-menglong8.dong@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Dec 2023 05:49:24 -0800
Message-ID: <CAADnVQ+kKxj2hg33CzH_iXdH5fs8wjwpkPP-Jjh41weqf9BEwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not
 equal" for regs
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:28=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
>
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }

Please craft a selftest from above with inline asm
(C might not work as compiler might optimize it)

Also we call:
        /* fallthrough (FALSE) branch */
        regs_refine_cond_op(false_reg1, false_reg2,
rev_opcode(opcode), is_jmp32);
        /* jump (TRUE) branch */
        regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);

so despite BPF_JNE is not handled explicitly it still should have
caught above due to rev_opcode() ?
