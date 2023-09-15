Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D77A2135
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjIOOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbjIOOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:40:35 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D412A1713
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:40:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41513d2cca7so345751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694788829; x=1695393629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ian4KdZXmKFMo5ATT66+8ryOQHatJUEavAax22/9xtM=;
        b=L3qVWDW1dbmk8GpWmRPl0hqNX2AGqrzf4fsv7AvEWCnSyfdgcrgiCZz/fUEERA40ay
         Hqu0RFaz1cNIyejGluY2McxJXGiHtnw7tFMDsA6GthLJudivDlvopP6aY+6G156T2T6U
         v+F6HaKLtO6KOxbXl/XLmi81WQb3gBm07u5iUyeu33pU6RByqShfAEd90POP/p/lv47A
         kDLZ+1BHyVkoL0zk4oLXXo1DrKw8lPxoMqaAwH0+l7c7o/Q+JAIFaOPXRvwET3MbNuZX
         TFtw0iXWAJf2rHPyfJ4mtGP8rOns5PgLcTbtrqCwrvrRCeHtn2uWNtsZoGUqV/qmEB+2
         s+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788829; x=1695393629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ian4KdZXmKFMo5ATT66+8ryOQHatJUEavAax22/9xtM=;
        b=rJzyfcj06QsIAwFhtAnjMZ1JVkiqXDBgYmCxyfNrvfxrMqZDSIGBkT1vR2IV1mD7fk
         85jvaHMvYKHznMtYOUKIRrcH47hdtwEcV/xeL/VpFBcIsyJeZ55uOMDrL9P/FRU/4BZF
         zLrtkGhZPm0XYzQdsNXKj6wK4946vWeTIWWhkmwUXNt4Ql8uNZHRsClHXIifP3xsThYD
         sVMPlCm9QAxjK7ba9ry0io0gFJdosT8lcRY9dCwI57M4d/Rq5GVauAAn08JYVYiSKthJ
         3SjT9II69TT9Y6HFDiVWJtV8OZMZlggJACGK3FBHA1R9ai8V7nbTPTfvBosj12sOg2Ig
         t9PA==
X-Gm-Message-State: AOJu0YwdTx3Cc/kdCRQRWIiy1Yk95wMat33KA75w/2FbimHrm7voNWRG
        VTzxHr3ncNCZ1lcOHgeBKKhJBIz5Khahfr2wequVoQ==
X-Google-Smtp-Source: AGHT+IEvTGUFvnjnnBA1AteMbyFSqSQVTo/tJ9sREckup1RnXB1Q25mSsTPQKnY1pjk3jEb1DZA3eESSv+sSMHy9O6w=
X-Received: by 2002:ac8:598e:0:b0:40f:d1f4:aa58 with SMTP id
 e14-20020ac8598e000000b0040fd1f4aa58mr247843qte.8.1694788828644; Fri, 15 Sep
 2023 07:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230915142719.3411733-1-make_ruc2021@163.com>
In-Reply-To: <20230915142719.3411733-1-make_ruc2021@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Sep 2023 16:40:17 +0200
Message-ID: <CANn89iJVM4J8DG4V3MdPcyimuKsbiko_vB=wYRyxnwzp_SiMTA@mail.gmail.com>
Subject: Re: [PATCH] net: sched: htb: dont intepret cls results when asked to drop
To:     Ma Ke <make_ruc2021@163.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:27=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_htb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 0d947414e616..7b2e5037b713 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -243,6 +243,8 @@ static struct htb_class *htb_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +               if (result =3D=3D TC_ACT_SHOT)
> +                       return NULL;
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> @@ -250,8 +252,6 @@ static struct htb_class *htb_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>                 case TC_ACT_TRAP:
>                         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>                         fallthrough;
> -               case TC_ACT_SHOT:
> -                       return NULL;
>                 }
>  #endif
>                 cl =3D (void *)res.class;

Can you please stop sending patches that are not needed,
as already pointed out ?
