Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C17C8F02
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJMV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:27:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F0C2;
        Fri, 13 Oct 2023 14:27:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso4702304a12.1;
        Fri, 13 Oct 2023 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697232458; x=1697837258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJgKNcLe9ypaGXDIMva2X8A8N9NipZYbejGYh3VdRME=;
        b=Yrrk2u9Ewz5IuZ/z0KhOdBTkJVJY9aeZzEnoIuvPdomCQyzr/m+XEfN1Gw21+exbSL
         3me084BiqOhMwI1UNV0w9HHLP/WUqOjLCtbSfkbcYdpBLgyJ/Ikreiq27QtRapwbpyuQ
         HirQ1nrrOFP1YBZ1C4xjrfA9H+thpZKddTftUtVijEvmsoMAWE8txrWCq56efhT8Cwmp
         djslKioQf1vaMlU4FxdTMihkIuvZSapgnVei3wXxdLC1hFM1vHF7xf1lsq1uXeobdFhe
         dXZWBun/fNlHluAKIcoO07Nq+REaySaJnRJWbe2MzCKEG2k0fA2yQoIgc/kIxryR9Bzw
         0sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232458; x=1697837258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJgKNcLe9ypaGXDIMva2X8A8N9NipZYbejGYh3VdRME=;
        b=EBf5q7ErKbRdVz2UA0LGLY0jpbRPOc/xNNx3ZsjRuKJtlcOQ2a6bBMb3pGqISjtlRN
         QG8yPdiMr/0L40ijNu93m7RsN/dhEkMlDNkg8+0fUYOa2CDn9hS+qKkmFw24EM7fkH0R
         l3GtTlYE3vTv8tZF91TcSyrp4wqWalF5LqxlEXCM9EPsIexUaq/ObeNq5wqwakNhEN1O
         pTnmDbeJRhWqQysXRPjoGrcrPjPDljF8NWtuAEQmLzuhXn/YE4J5QhY1OnPdOuBfw+ff
         ZCWpBpjgQ+CTKVyejbChlxVcf2bwVOh20FozDywEIUJkrPUR4OGEUMtfkacLbij3GMZP
         HAng==
X-Gm-Message-State: AOJu0YwRl/K6E9jeJGejc9FETGARx8qqqJjRit3AZ7vYD9MZa6VMDQ7y
        NB76MblalTaLkiUH7Jvi9dRiCexyB/aPVUv5cHI=
X-Google-Smtp-Source: AGHT+IHcL4iI0gZMXFBsQoArEAU6J+RyuDCkwN9uosaSPn29aiUBmIJlMWYGf0eWB0lMLdM2m96iqiwV3ThNMqL2CcE=
X-Received: by 2002:a05:6402:2694:b0:53e:6624:5aeb with SMTP id
 w20-20020a056402269400b0053e66245aebmr685480edd.11.1697232457849; Fri, 13 Oct
 2023 14:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231011120857.251943-1-zhouchuyi@bytedance.com> <20231011120857.251943-7-zhouchuyi@bytedance.com>
In-Reply-To: <20231011120857.251943-7-zhouchuyi@bytedance.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Oct 2023 14:27:26 -0700
Message-ID: <CAEf4BzbWQPxm3in9LBeKq50xT1rNLaZ_8X931FqrK=PEatxAfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/8] bpf: Let bpf_iter_task_new accept null
 task ptr
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 5:09=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> When using task_iter to iterate all threads of a specific task, we enforc=
e
> that the user must pass a valid task pointer to ensure safety. However,
> when iterating all threads/process in the system, BPF verifier still
> require a valid ptr instead of "nullable" pointer, even though it's
> pointless, which is a kind of surprising from usability standpoint. It
> would be nice if we could let that kfunc accept a explicit null pointer
> when we are using BPF_TASK_ITER_ALL_{PROCS, THREADS} and a valid pointer
> when using BPF_TASK_ITER_THREAD.
>
> Given a trival kfunc:
>         __bpf_kfunc void FN(struct TYPE_A *obj);
>
> BPF Prog would reject a nullptr for obj. The error info is:
> "arg#x pointer type xx xx must point to scalar, or struct with scalar"
> reported by get_kfunc_ptr_arg_type(). The reg->type is SCALAR_VALUE and
> the btf type of ref_t is not scalar or scalar_struct which leads to the
> rejection of get_kfunc_ptr_arg_type.
>
> This patch add "__nullable" annotation:
>         __bpf_kfunc void FN(struct TYPE_A *obj__nullable);
> Here __nullable indicates obj can be optional, user can pass a explicit
> nullptr or a normal TYPE_A pointer. In get_kfunc_ptr_arg_type(), we will
> detect whether the current arg is optional and register is null, If so,
> return a new kfunc_ptr_arg_type KF_ARG_PTR_TO_NULL and skip to the next
> arg in check_kfunc_args().
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/task_iter.c |  7 +++++--
>  kernel/bpf/verifier.c  | 13 ++++++++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
>

Looks good to me, but someone better versed in kfunc internals should
double-check.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index caeddad3d2f1..0772545568f1 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -873,7 +873,7 @@ enum {
>  };
>

[...]
