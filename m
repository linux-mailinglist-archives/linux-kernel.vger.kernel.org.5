Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E863811491
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441916AbjLMO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441849AbjLMO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:27:16 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6934EB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:27:22 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2cc3647bf06so9444011fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702477641; x=1703082441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2tUcIBSYXXfAdv/AVfpRmmC9S7RY2jXn+X6NSmZ8AA=;
        b=KZ11MPuq44aMOtWEpezE+8BgwdGQFRdMsFC5TBVE+SAnPtWRaAwJxR+0UPbfveY8oW
         HvA9GctCp/UtSJpb6tJIMROZZpUPLpZuLXdX8PvlnIbrnR2RTWC+enX/SlVmjqjK9Ufw
         goz/TJTMuctiWLv8ehkKfYNNUKJZtX0wq2LFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477641; x=1703082441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2tUcIBSYXXfAdv/AVfpRmmC9S7RY2jXn+X6NSmZ8AA=;
        b=m3+Cjwb8c9NzV9B2jTo4cwiXKm89rvYsJc5o6soJmf7P9kM+Bigwc1PyIqPzVVwbcX
         CXuc2YJkwOMD8DFnTYK3ZGEKefflwRmFUqR5gWUw3DkwL5+HVOkgQl5JYBs0Ie6FJJea
         C69vfhWsud28x7bRGps7pvBmEeRgg7pL9JYszyKLejBOdgtD+O2YoebGUAA7p7lB9NEY
         VEtxFAPfcPycI0jEXKRTWmfOalkbTeiiz9lgB5vfMJjM8I1UBVRXzugxnMfzizzAiw7g
         7VdEIx20rr2MaZOYeVtMixP4tnXI+44zsj8ll2lUM4vZC5g4golBclrEQj2+hd7AWx5+
         dPUw==
X-Gm-Message-State: AOJu0YwtX+AL6AMIUTFT+JOlwZNZSVWImEMtvTDxIlfUXOta93uIHcY3
        DU2hXLtvFaIzGjLn3nGTEsCRx180MaHRUq92oAAxsA==
X-Google-Smtp-Source: AGHT+IHT03d1DXLukck9LtNvbDpns22/gtml49FfERt7jVvq4qDj15BjHeoMGvO+xT+KBOvtfaDXuKNTV+10Lpue9es=
X-Received: by 2002:a05:651c:b23:b0:2cb:2c27:593c with SMTP id
 b35-20020a05651c0b2300b002cb2c27593cmr2670296ljr.20.1702477640535; Wed, 13
 Dec 2023 06:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20231212174750.GA11886@neeraj.linux> <20231212174817.11919-3-neeraj.iitr10@gmail.com>
In-Reply-To: <20231212174817.11919-3-neeraj.iitr10@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 13 Dec 2023 09:27:09 -0500
Message-ID: <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't run concurrently
To:     "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, paulmck@kernel.org,
        Neeraj.Upadhyay@amd.com, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:48=E2=80=AFPM Neeraj Upadhyay (AMD)
<neeraj.iitr10@gmail.com> wrote:
>
> From: Frederic Weisbecker <frederic@kernel.org>
>
> If an SRCU barrier is queued while callbacks are running and a new
> callbacks invocator for the same sdp were to run concurrently, the
> RCU barrier might execute too early. As this requirement is non-obvious,
> make sure to keep a record.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> ---
>  kernel/rcu/srcutree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2bfc8ed1eed2..0351a4e83529 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_stru=
ct *work)
>         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_=
TAIL));
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
> +       /*
> +        * Although this function is theoretically re-entrant, concurrent
> +        * callbacks invocation is disallowed to avoid executing an SRCU =
barrier
> +        * too early.
> +        */

Side comment:
I guess even without the barrier reasoning, it is best not to allow
concurrent CB execution anyway since it diverges from the behavior of
straight RCU :)

  - Joel
