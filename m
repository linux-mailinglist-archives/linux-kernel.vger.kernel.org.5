Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F980FB42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378015AbjLLXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjLLXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:22:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46217AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:22:46 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso94629171fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702423364; x=1703028164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no1hU0qMSuRSxx9sOYrSnjnOEvLJ8QjMRFYjlFqCCek=;
        b=BEj3u0tvCRJPFXhezmen454eoyW4Gw3Ci8nPnHkqKMDX7zeDl1M2JpN/rb0gzbTIyG
         bKb7HwyfFjr+zpnPVLrncekK0bbPDhVmWZHCepZ0iLz8b3OvOqWPq9TN8WW+jpw5jwWe
         RoQrVZTve7mhbHQW/RWPrZIre1blC057jLs5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423364; x=1703028164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no1hU0qMSuRSxx9sOYrSnjnOEvLJ8QjMRFYjlFqCCek=;
        b=sKinmKqkY3E8H3/Qz52t9QI6RJo3yfmkBzqLoDZ8JlIcxWkfWS7KCMm4rpmPWRrFUO
         vvH647cfMCIvPT7L54zPkhnofEnCFL5dR2Rj9r6uIvcWXa3sqwEA7rJe+ALkDVOxHbUd
         OgMOWHCdlkrIsQKjuqih6EumJb3r8nnKjNUQamm8DAH63RKm2DPOwv9BfdzM5a00/ZII
         fEipTqF/NuFnAxIzn3ayvDfFzmbHwswtEV8w8C4b73RohRGNXDtzfk/dStQ70XfouQ7w
         jDOcm8I9Bn4q0ORKzm3qo6DwyLlBWeseMfTs4HPcOuDkwgSNzEIu1lGHJd3om29RekJj
         FE9Q==
X-Gm-Message-State: AOJu0YwaiDDQhBI0H2HvVHGEJmmhFxk+lOqTu9bU3FGcbzG7ny0zXi+t
        5jZeSLIO12wXQGsFXpn1dNb/3oASkscmQYFxW3neyQ==
X-Google-Smtp-Source: AGHT+IEQ6wtktPNRubmE3KWVpopyvCvh2KeO22rY2zJ3zKe33/47PK6BbVMmMeCeMiJSAWlxlclHVJ3rxT0GKarkw7Q=
X-Received: by 2002:a2e:a808:0:b0:2cc:1ec0:a75a with SMTP id
 l8-20020a2ea808000000b002cc1ec0a75amr4618551ljq.104.1702423364396; Tue, 12
 Dec 2023 15:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20231212173948.GA11724@neeraj.linux> <20231212174004.11754-3-neeraj.iitr10@gmail.com>
In-Reply-To: <20231212174004.11754-3-neeraj.iitr10@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 12 Dec 2023 18:22:33 -0500
Message-ID: <CAEXW_YQSPfv50=KNKp-rBVNDPw+XkQ5tUxbVZUL5TW0VVUvVuA@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] rcu: Force quiescent states only for ongoing
 grace period
To:     "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, paulmck@kernel.org,
        Neeraj.Upadhyay@amd.com, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:40=E2=80=AFPM Neeraj Upadhyay (AMD)
<neeraj.iitr10@gmail.com> wrote:
>
> From: Zqiang <qiang.zhang1211@gmail.com>
>
> If an rcutorture test scenario creates an fqs_task kthread, it will
> periodically invoke rcu_force_quiescent_state() in order to start
> force-quiescent-state (FQS) operations.  However, an FQS operation
> will be started even if there is no RCU grace period in progress.
> Although testing FQS operations startup when there is no grace period in
> progress is necessary, it need not happen all that often.  This commit
> therefore causes rcu_force_quiescent_state() to take an early exit
> if there is no grace period in progress.
>
> Note that there will still be attempts to start an FQS scan in the
> absence of a grace period because the grace period might end right
> after the rcu_force_quiescent_state() function's check.  In actual
> testing, this happens about once every ten minutes, which should
> provide adequate testing.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..1ae851777806 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
>         struct rcu_node *rnp;
>         struct rcu_node *rnp_old =3D NULL;
>
> +       if (!rcu_gp_in_progress())
> +               return;

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

(Probably no need to resend with the tag, just update the patch in the PR).

Thanks.
