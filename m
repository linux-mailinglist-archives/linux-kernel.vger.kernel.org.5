Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F47A1F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjIOMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjIOMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:55:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F71713
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:55:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41761e9181eso241161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694782520; x=1695387320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPHy6FbUY6qMDmcdSpgvW83WHD8MuvuLRYVKW+S0nuI=;
        b=FYbllhMbbEtVzEYLkr5eCj8ggR9cnp3YNPCc/t5Av80CURgM5FSLvPSmnrpV43ox96
         2G6wFsboNZmFUbx8g7lqr3rM/8rGgTC+D9mX4+ZVFde0iCYHxgoN+4J8UHXMaj27w2Nc
         K76nL2KL2ag8CqMDB9iFi9udkxG8VKxE+FYDdeoKs3EHgbRpw0yBHnW6J7YDIcnTFSLu
         gBu3QBWYuXn8FopcNXJfcriJnig8NA0yemexJWxvgqNI5+Ii0J1ym4i97niGmdXwIv+X
         2OmeXntdnDyaCLjQ9rqNwykFHaUl/nVke4YCgMwzyfovAjsxUcg9OlLXgRU70Hx/Qf1W
         /UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782520; x=1695387320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPHy6FbUY6qMDmcdSpgvW83WHD8MuvuLRYVKW+S0nuI=;
        b=EoD4IE7ZBPHlleQXx92cxmaDTgdUIhwzpzpYifn3mWhHY9vTPhaTMCc7SsweKP0w3B
         rcG5v4ih6PyyymdlGx6r2V3wSLAWrCxHe/PfFxpffMOZCS0ZtowI50NBtOzss9WNaNm2
         kS3GJxTwXYu7O5hyt3UonncqvcbyO2JBNzTvjHoa23poqnfqLUkJ62lkxziqKRhpo2RD
         j3L1ADeDvZVrTq74ddf/SaLGkOOTD+C34xQLIt7GUPiiMONG8FN8xThBnUlU6abIi8zA
         U3NmwPmbf7an4c36Pbi1JO5kmi7zXUUgCGvFGos76ZHbFoGrA4MVd/4OO9KIRsDJesT7
         7/4A==
X-Gm-Message-State: AOJu0YzvVJc6qP08zP80toiSvmRroMUAOmHIcNIkLXLBT1NohXP0JScy
        jqBjcGoMz2kEQVYaakL3Nj6QxiWcn94YezmIXsvEjQrJLrtz+xrKdMI=
X-Google-Smtp-Source: AGHT+IGQo6Ocl0mq1s8C1s55rpOfzpETFjdpA0DIog96ZmkP65gu2xfgg5C8jNL1i4mKojDFDv16uHfi4OY7OUM2Qoc=
X-Received: by 2002:a05:622a:1a86:b0:3f2:1441:3c11 with SMTP id
 s6-20020a05622a1a8600b003f214413c11mr236689qtc.2.1694782519819; Fri, 15 Sep
 2023 05:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915104156.3406380-1-make_ruc2021@163.com>
In-Reply-To: <20230915104156.3406380-1-make_ruc2021@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Sep 2023 14:55:08 +0200
Message-ID: <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to drop
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

On Fri, Sep 15, 2023 at 12:42=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote=
:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_drr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 19901e77cd3b..2b854cb6edf9 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c
> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_buff =
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

 I do not see a bug, TC_ACT_SHOT is handled in the switch (result) just fin=
e
at line 320 ?
