Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDD7A1F57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjIOM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjIOM5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:57:52 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81C1713
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:57:47 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41761e9181eso241831cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694782666; x=1695387466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcuMOBJNB817DaLLKwvFYiTctCwx4E0hPvxhRSMQXLw=;
        b=Sd4ylr/w4b27Y4Jud2xK80qzK/420nsiKmEpXDe/X62IHlKuvOjUaVycOrk7bq2StU
         h/CNAZHA8PjLBDvMnZYFbXrlU6C83iCqs5td7kszQYMW8if8MqKOZx+5QpDexG+RKVgl
         aHlgTcLyzUTEEmMSw7ed80hN9vi4UXg7FguwegeOTh0u5KqJSekqLKezOoNQ95TiZHjf
         x1Z+aFxfw0mB0/6jBWB8rHHbhPxsFF33DqueinyzbBBf0HTD/j4NaQ8pciep0MsZX0rT
         M9FhwG7gxWPImfXAJSPfYooOvOM7NvbVvb7o4HyeAmHxvKLApOXUjF/r/dS0iTmforvF
         sX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782666; x=1695387466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcuMOBJNB817DaLLKwvFYiTctCwx4E0hPvxhRSMQXLw=;
        b=uYRq2isD1HMpYCtAbFZpfSs9L/zn6zUG7BKQaBmT1bYdp/p45N62jbiDbd3QqPNXPS
         YJeZRJJ9vA/c5ahBPVqxQfT0JNQxGTtDvZhCEkyqg+EYq0F7UmUZmOCVaiLYlFGQjdts
         Vr/NKVapdjBTimRLnXwanBMRPge7X+FIUM+pDXtl4CqZt4YoeA8OTKqapTfR08Gpm+z4
         fLYYPZ3r22oNy+EfkUR9gIZSU6BrH9blRcmhuRR1owNaQYm0Cepwz2bC3Ob52nhjQv4i
         6yLF/wfN5W1TLHu5uK0zKd3dfvPx8w/wN80hgmbcWdpfz/PG3vN/1L5mhGGFN8IZ3Oyu
         UOjg==
X-Gm-Message-State: AOJu0YydGbUDBKnJ86XxzJJSFLVh9b4auaY57aorqL59GV6Kdr7oi5Tp
        gzLz9a51hfMxJzxFVXEH0EMcK0M76VBbq+ECRWLD1g==
X-Google-Smtp-Source: AGHT+IFDWurUxsATW6ZkJU2jWTzRExmBqyruiH6PNf63aYT6X5hSh71/C44VxTzWd/Ia1G+b29WsfByZ8Hi35ZJminE=
X-Received: by 2002:a05:622a:60c:b0:405:47aa:7ffd with SMTP id
 z12-20020a05622a060c00b0040547aa7ffdmr174104qta.19.1694782666113; Fri, 15 Sep
 2023 05:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230915121841.3408778-1-make_ruc2021@163.com>
In-Reply-To: <20230915121841.3408778-1-make_ruc2021@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Sep 2023 14:57:35 +0200
Message-ID: <CANn89i+hM_eHSPUNwPCQZdtkk7O31GhaQ4AmhfBuZ=wQ3psb7w@mail.gmail.com>
Subject: Re: [PATCH] net: sched: hfsc: dont intepret cls results when asked to drop
To:     Ma Ke <make_ruc2021@163.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 2:37=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to assume
> res.class contains a valid pointer.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/sched/sch_hfsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 3554085bc2be..2a76027b14e6 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1135,6 +1135,8 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sc=
h, int *qerr)
>         head =3D &q->root;
>         tcf =3D rcu_dereference_bh(q->root.filter_list);
>         while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +               if (result =3D=3D TC_ACT_SHOT)
> +                       return NULL;
>  #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> --
> 2.37.2
>

Same comment, already handled at iine 1145
