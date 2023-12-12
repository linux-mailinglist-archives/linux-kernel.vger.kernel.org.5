Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815380F1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjLLQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjLLQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:04:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72976B4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:04:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13117a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702397066; x=1703001866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EySWR5HSLbEbAwQsmlzOeqMwViU2YPMZzWbEWm+2Kgo=;
        b=CyFnmGD2rNk5SCz1aAqC1E7TtP9XCZ33skehfnNwi+ZaWcFr86n/Zd5eOrmUn+VJus
         1LycG+H33eTazpAKP/mUcshd1rKFOJZDLl7qdH/6FYPYmIFETEtSk9vJNqWh8mWinaxx
         s65ZzTqop1r2pojI49Npz0UdXno/8d6SGi20g5kgcbzMfStQOLmpq8xCBiENB496iDZc
         HyP4xbQ92y6K8c5oNn2+1oKDMLv64D+yQNo/zE1quy+/xxqvZdHxJNwc5WU+BufmLc6k
         VXTXnn83/jW3niInfbENmoy3iivoYHIITKVkxCwtbcSDOgSD1dD9uf50pUabpY33xa3i
         UdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397066; x=1703001866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EySWR5HSLbEbAwQsmlzOeqMwViU2YPMZzWbEWm+2Kgo=;
        b=GqIvIMafCILx/OhDqaMBcd6WJ8sIpX2VJ9jkYswQS3qRtvYkWYsTAGt21KuuM+Tqzu
         AVlYDQGUJcqhrthkavsjzLXDWmlCRtyLMy3rNvigIY8j3kmb2BjDE39WtQ51Rq7iwzd9
         jBaW0QQKM3zlDcSO03ge2Ues9fWYHg6gVFqaZk1HWqlk1/zoZdqgCip63HUs1O2FtXNy
         T+Pf7u+SfaDzU57z0W+bklW5Z9d5gflGLw7pT0yPNzbL1/gkSj5r119UK8P3YH5xqbXS
         3dOenDtnI8it7xAowySHlcIOpU3WNXvLLD4Y4QSS2i95/DC4ybWgWR4CN1F4Fdh0TEkh
         dA4w==
X-Gm-Message-State: AOJu0YyMB2qlpsUvUXHcjzf9bVgPjpKdfMh4usjoVyYZr60cuQQj9Ynd
        jpj2HBf5kfT3adr6PZaCx9hm9mdrvJB/2hOkLkg3Yw==
X-Google-Smtp-Source: AGHT+IF6ELk9g2qcWWxJGDlTRcFmjUjaR5fvEaQA2WmaGK9QRAgfMLfPXv+AWfS1Jd1b6KSiMglq9KaODFhNn+IyQcI=
X-Received: by 2002:a50:9fc6:0:b0:551:de83:557 with SMTP id
 c64-20020a509fc6000000b00551de830557mr18211edf.2.1702397065602; Tue, 12 Dec
 2023 08:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20231208220545.7452-1-frederic@kernel.org> <20231208220545.7452-4-frederic@kernel.org>
In-Reply-To: <20231208220545.7452-4-frederic@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 12 Dec 2023 11:04:13 -0500
Message-ID: <CAC_TJvcODXd71icqTLs5fkCKswML5huK-2V2=R2-D9-Fc0R1MA@mail.gmail.com>
Subject: Re: [PATCH 3/8] rcu/exp: Fix RCU expedited parallel grace period
 kworker allocation failure recovery
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 5:06=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Under CONFIG_RCU_EXP_KTHREAD=3Dy, the nodes initialization for expedited
> grace periods is queued to a kworker. However if the allocation of that
> kworker failed, the nodes initialization is performed synchronously by
> the caller instead.
>
> Now the check for kworker initialization failure relies on the kworker
> pointer to be NULL while its value might actually encapsulate an
> allocation failure error.
>
> Make sure to handle this case.
>
> Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kt=
hread_worker")
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 82f8130d3fe3..055f4817bc70 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4723,6 +4723,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
>         rcu_exp_par_gp_kworker =3D kthread_create_worker(0, par_gp_kworke=
r_name);
>         if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
>                 pr_err("Failed to create %s!\n", par_gp_kworker_name);
> +               rcu_exp_par_gp_kworker =3D NULL;
>                 kthread_destroy_worker(rcu_exp_gp_kworker);

Hi Frederic,

Thanks for catching this. I think we need to remove the
kthread_destroy_worker() in this case too.

Otherwise,

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

--Kalesh

>                 return;
>         }
> --
> 2.42.1
>
