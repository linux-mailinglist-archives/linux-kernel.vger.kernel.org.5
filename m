Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20867A1F50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjIOM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjIOM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:56:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA0310E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:56:26 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41761e9181eso241441cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694782585; x=1695387385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POzX7W8BdLozOP6jMEbD1FJiIlYH4jYiXUDV3kPwj2A=;
        b=4oUuiIgBJX8CCHZaLRQsCQnKf1CUrHMxySXrBX29xfOr2vDsvR9D6ECmEhb7qsYVBs
         +QnQpF3yJcJJ1Tn6JE6BvyFR8TS9U7jlKglu7sCJUGvnfJhSaQz7kKYefvuHEYsu7meT
         8kmDge9EWosB3+3SWqsHLZZ/WUXAjmHla50dmu6fNeaQTHZpXun9ZG8R0uwrqqOGwi5J
         yjQaNrPlO5bjQktWx9ReWUxj6m1f5iydLCQb35fmaxclso9OhYRIJpJSeAkw+vK9Rqa3
         88tDEk6vUS871y4t1G08zP1w0QKnr6OvC0cAeZ2uOD7HO1idd1CRcj2j0+FDCgvMxknp
         7ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782585; x=1695387385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POzX7W8BdLozOP6jMEbD1FJiIlYH4jYiXUDV3kPwj2A=;
        b=p2wnsP8d/sPbPNoBBL8jEBbe1XYDGfMtS9Ath4+wUoxlo0Kl/0TO69oVsN3x8NhKx8
         yPqjQ7TC2iQKuGJ2fbeAnqDpzZtUDHWPLTOW3IRQlFXuG7D0rnRD2KPYzk8I8cv1IfDW
         vw9S35IGwjeGrwjlBXEjE5CJnR3XupCMDY1d+q6mS2Fo2+NvPpk6M6tbdKKcutonqMzc
         ON+esvQilWeTQP9roPAxGO0PUX15GCitJ9jEjErl3OENuM1G8CbbbERF5RzaQKST4Rdm
         jdGHtzGIr/ssWRCDz0Zc73FZF8G13KLuGm2dX9ixwReeWpmMcHu/vODFuznMQxYyGD4o
         74DQ==
X-Gm-Message-State: AOJu0Yygmv0WqnzNAjDABmntsoTR1vlRqCpA8QBGQqOHAKS+k6fLi/0v
        JusCzS9l9B6Kakei5oe7fUM8BSk3TpCFh5LekDRW/g==
X-Google-Smtp-Source: AGHT+IEBO2PWMF56UV0o0XFzzvl3p5wa/2hiGnEufkAATdc1riorwCp2tXZ4FHLdUicqUGrNwtSr8L7GdgG/ywhe4Bo=
X-Received: by 2002:ac8:5b53:0:b0:410:653f:90ea with SMTP id
 n19-20020ac85b53000000b00410653f90eamr165544qtw.1.1694782585290; Fri, 15 Sep
 2023 05:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105036.3406718-1-make_ruc2021@163.com>
In-Reply-To: <20230915105036.3406718-1-make_ruc2021@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Sep 2023 14:56:14 +0200
Message-ID: <CANn89i+On15D1y92SusrAbMZB9qrNCXZE-PwjzDaF3zpQb7d2g@mail.gmail.com>
Subject: Re: [PATCH] net: sched: qfq: dont intepret cls results when asked to drop
To:     Ma Ke <make_ruc2021@163.com>
Cc:     xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 15, 2023 at 1:08=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_qfq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 546c10adcacd..20d52dc484b6 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -695,6 +695,8 @@ static struct qfq_class *qfq_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         fl =3D rcu_dereference_bh(q->filter_list);
>         result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       if (result =3D=3D TC_ACT_SHOT)
> +               return NULL;
>         if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> --
> 2.37.2
>

Same comment, it seems already handled at line 706
