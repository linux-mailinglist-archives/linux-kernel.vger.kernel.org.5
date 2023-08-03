Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4707976E4EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjHCJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjHCJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:50:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5730F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:50:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-268541d2947so367243a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691056254; x=1691661054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmLPkSK31CLHo7mNpAKIlWgQitqQntIrgPMbaFaZxTk=;
        b=Z4GF3CUOzYeMCRFmcF/e7n2qCZfO1qxATsmfjhgp7G92kuTEOqwDvG+GepP/poq/NJ
         ihZT8ENmR+gwitZQa04A/atMK7Ue5IXgoIUwdKqwDhjhJYr+qHVKiGjfeeMTmPg+ryrz
         Sgef8v1ZStlUDf2qQgKtWqnfQKI6bD0aUbJOtDsgR300OvXHvu7xzWowx+CtYKEtU+dN
         c2BxPlms8zm1zHMz2CjLhxCfS4MzDi5yIafogzrpKoVVLzo0jlKsF9zj0Sf8Gp4J9XIS
         6VgZfaLCSZ1LcmEzU2ScS2tSmdEw22T+xCMYVNBmUmnGHjJIy/c1e4BlsqXjDiELLqvO
         AIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056254; x=1691661054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmLPkSK31CLHo7mNpAKIlWgQitqQntIrgPMbaFaZxTk=;
        b=L+R7M9ZsruHQ97IhbbM+c/lSU8RWNhhzws2xnDVATeAZkHYEbjd0uKAXOiRF/365oQ
         s2R+3g7UzUHBXNGx6tcox3xf6A4iRxkVGTp0TrW/Vb5uE/08G36kGnXxoJVHVGWlxIMm
         dDX+l0qLgrKqj7PXB9lFDiIJiC6YE5BXRjhf/Pd5ziY/8e+JV7/oDiGrpYsSffmpRcYv
         aiqrPzGYtVBlzluyWbIFAMTkGhCh5EgLaVSWllYSMOEhvcYtPWmUmSfkThnHu06YRID+
         XbubZAxKPszeglfnL00T0oNHEhPFhmirajRqutWuGEHeJssPXw3gM2ZtqMMOFaZjrYnx
         ATlw==
X-Gm-Message-State: ABy/qLb7sEjztW2GFMlxbfzKfBdmSxKiFbNXvWkgDcNrXH17wEr9wH3W
        JHyoEsiojDW5XA2KdEmI9cNkhvr8bOi3n6eJ3Bs5xGhuZYw=
X-Google-Smtp-Source: APBJJlH+DGkrK8H31Ctk5gva1CWtt/MkGtH5gSCnHtvnOoc2wVcAA2vhIxrSxyykY6s6BfpNmD0gyS0HyhPGZd0s9Zg=
X-Received: by 2002:a17:90a:5504:b0:265:8184:5903 with SMTP id
 b4-20020a17090a550400b0026581845903mr14547842pji.40.1691056253934; Thu, 03
 Aug 2023 02:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230803075135.499536-1-yangyingliang@huawei.com>
In-Reply-To: <20230803075135.499536-1-yangyingliang@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 3 Aug 2023 17:50:42 +0800
Message-ID: <CAJhGHyDMoX6MfPiEBgJ_6CCCetCfFsas=TEQU8PfNuUjE9TH0w@mail.gmail.com>
Subject: Re: [PATCH -next] workqueue: use LIST_HEAD to initialize cull_list
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org
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

On Thu, Aug 3, 2023 at 3:54=E2=80=AFPM Yang Yingliang <yangyingliang@huawei=
.com> wrote:
>
> Use LIST_HEAD() to initialize cull_list instead of open-coding it.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> ---
>  kernel/workqueue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 3ddd0d599dab..ae975a7c9f69 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2307,9 +2307,8 @@ static void idle_worker_timeout(struct timer_list *=
t)
>  static void idle_cull_fn(struct work_struct *work)
>  {
>         struct worker_pool *pool =3D container_of(work, struct worker_poo=
l, idle_cull_work);
> -       struct list_head cull_list;
> +       LIST_HEAD(cull_list);
>
> -       INIT_LIST_HEAD(&cull_list);
>         /*
>          * Grabbing wq_pool_attach_mutex here ensures an already-running =
worker
>          * cannot proceed beyong worker_detach_from_pool() in its self-de=
struct
> @@ -3875,10 +3874,8 @@ static void rcu_free_pool(struct rcu_head *rcu)
>  static void put_unbound_pool(struct worker_pool *pool)
>  {
>         DECLARE_COMPLETION_ONSTACK(detach_completion);
> -       struct list_head cull_list;
>         struct worker *worker;
> -
> -       INIT_LIST_HEAD(&cull_list);
> +       LIST_HEAD(cull_list);
>
>         lockdep_assert_held(&wq_pool_mutex);
>
> --
> 2.25.1
>
