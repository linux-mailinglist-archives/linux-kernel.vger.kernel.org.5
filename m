Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486B7C8EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMV1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJMV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:27:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DD95;
        Fri, 13 Oct 2023 14:27:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso4542618a12.3;
        Fri, 13 Oct 2023 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697232453; x=1697837253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtsbovs15s43CkdO6JUReym2p8ycE9LPuxt+485Y15w=;
        b=EJbm9wWF08yNmkfzXOZ9cxxOV8Ct97T32kIsyxgVUrcAOd8krAJm96J5ADnQ5idGyN
         WGrSSwGsvp/Sd0A0DKpkhGPfeggWbN6DIPUOvlo7H/KLAUEJ9yTGYmpt4t9lubZstuVf
         1LVjXKtWBQxW7faKc0g7kQlPhqfjYK8E9dpDJMV/3XXcabGk2XGTCCw2o1PDvUIa1bH8
         XLr1ripUTlp3W+WumpFHc7eB409u9+kTuy3gPg/cayOz7Qi6fF3KY6VLnZWuEvvN0axT
         tqCSdHwAbC2DpkPKy7OicZkSNik93fJhbc+ynDA0Lg/XCC2fn85ZX5+EB4fMz1bKZg4p
         LVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232453; x=1697837253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtsbovs15s43CkdO6JUReym2p8ycE9LPuxt+485Y15w=;
        b=dnhCzPfoGSdKlO7oNuFUxCFqoF3W+PgaDmRmmqtk5eMVjuME7pxBgPS/jDgfySx0fs
         vif0hjdNyahO1oc7CuIyfm4cOZavws7gZbkVJDEgfsfAkQIC38EHn2jGXB+Dlu29tn4G
         C7emNzvErasv9OaRCX45bwNY5ncYjlPY4qRDvkffSiA2sExnoCaoEwZbp5aYgRVDrqNa
         qipp8q905M9SzLx7Sg9Ug+RvR8vNjmlmVCTFFGbtH7sPHPKydSvw0+WNYGJ9bRQNB7s5
         Wwqct/SZkrKUDDJ4IiadXLabBq2j5uJQsAYepBnAnFBa4RBd6Zrv9ZbQDG0CZCtqCosG
         AL4A==
X-Gm-Message-State: AOJu0YyUk3UTwVwKnBATAK1o/4RxDDSouYEW5Hyt4mfzlc6faN+dsEHZ
        z27Oz0lxWQKu0ZwvXlvI5ofZfbnu7jWf37oujkQ=
X-Google-Smtp-Source: AGHT+IEg/79KFgGxI5JstzCY2q8A1dvRLIjk6T6lB/KZW4Fo9kdh/7seKlc4ybffOS0WdZ2jNvytuWx11SZA1rQV+bM=
X-Received: by 2002:a05:6402:f25:b0:53d:d4e7:af5f with SMTP id
 i37-20020a0564020f2500b0053dd4e7af5fmr9178654eda.13.1697232453169; Fri, 13
 Oct 2023 14:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231011120857.251943-1-zhouchuyi@bytedance.com> <20231011120857.251943-6-zhouchuyi@bytedance.com>
In-Reply-To: <20231011120857.251943-6-zhouchuyi@bytedance.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Oct 2023 14:27:21 -0700
Message-ID: <CAEf4BzbxG_tqD+zeGiuGPfwu4q6_JUoMGfEHJSMbcd99AmH1XA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/8] bpf: teach the verifier to enforce
 css_iter and task_iter in RCU CS
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
> css_iter and task_iter should be used in rcu section. Specifically, in
> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
> use them directly.
>
> This patch adds a new a KF flag KF_RCU_PROTECTED for bpf_iter_task_new an=
d
> bpf_iter_css_new. It means the kfunc should be used in RCU CS. We check
> whether we are in rcu cs before we want to invoke this kfunc. If the rcu
> protection is guaranteed, we would let st->type =3D PTR_TO_STACK | MEM_RC=
U.
> Once user do rcu_unlock during the iteration, state MEM_RCU of regs would
> be cleared. is_iter_reg_valid_init() will reject if reg->type is UNTRUSTE=
D.
>
> It is worth noting that currently, bpf_rcu_read_unlock does not
> clear the state of the STACK_ITER reg, since bpf_for_each_spilled_reg
> only considers STACK_SPILL. This patch also let bpf_for_each_spilled_reg
> search STACK_ITER.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/linux/bpf_verifier.h | 19 ++++++++------
>  include/linux/btf.h          |  1 +
>  kernel/bpf/helpers.c         |  4 +--
>  kernel/bpf/verifier.c        | 50 ++++++++++++++++++++++++++++--------
>  4 files changed, 53 insertions(+), 21 deletions(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
