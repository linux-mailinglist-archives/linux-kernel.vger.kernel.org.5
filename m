Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAD37B40A6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjI3Nml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3Nmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:42:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C2FA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:42:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053f24c900so27225e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696081355; x=1696686155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qivCUZhy6lAFuZ1oBQ49JNnd+cCewonCcuWY722LTPk=;
        b=gyqmPxtSsltvxyj2PC+lbeFjJLcYRsBZmIjX06fl7xhmauBCPFiCzgZsuRLiKA/t6P
         oadX9QJ1OrCvH3XAqfJrbSfn6BKTbRDbGDPwBWDBxPGdBaVzCL7mdwmIS4BUMZ1nZ4y7
         a6AZWIiDkHikkkyG5b63/hf872udpdqy3kfqSSO/gMEopDX1kTemS1cLOZfS4ZtWJ7Nq
         22k18O+/rk7TFi2NEq1YB3EoKPWDeflhSGN5sQj9cK9gstol/w53hBv9UIE6+4Me1eUV
         dhSVGGJn2hDk0lIYaTTRGpTVIeUECiJF5c8P1HivbXXOH4cU58nLFVMlF6YHz4j9oYCQ
         A+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696081355; x=1696686155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qivCUZhy6lAFuZ1oBQ49JNnd+cCewonCcuWY722LTPk=;
        b=i88CTiPCRMTS+ntAo6JQowWV+kTSt056MqyocDxUXfUve7WMdvkmKHiRghQCNJ+5Z3
         lw6Wl/rY788UXJuROEMQQ644Dw9EfoOjRsKAnxpAcccd/7EUexxrpJgZbD218ZA7oTIG
         Q0cNOCZa4REOnMODMd6bolqUb1m+6c7vsRGyD8UHv6C2wUh0EuAf2AcCkQtGXBRNpQMR
         n9ahwc3e8z4TGv/vyHIzGA097LtGxaq/Zh78Ft8xurVT22pz9Bzfm+VSQf+9Q6cfE8UK
         TU8lbcXOcDrGySYbIIXW2rsTwoqstRcuWRLE6HZeoMfoK0hzguAwpFegJthLMOURfJUH
         ubcA==
X-Gm-Message-State: AOJu0YzMC8jAieNhjHB3finiCQJL3++Q4Fm/hwDMgwfXKRwGpluFUHIJ
        +1sFkU65JZC4O7tAy6zZz79KSBKoyt9dWSnlvJbm6Q==
X-Google-Smtp-Source: AGHT+IHqRkx/gAS2S5RC6GHs/8vmoxRgjTiL5gGoKF2bLwsNEnTM280fDgx99b++cQTWemEC+CB23w+pNf8u/xGVARQ=
X-Received: by 2002:a05:600c:4f47:b0:405:38d1:e146 with SMTP id
 m7-20020a05600c4f4700b0040538d1e146mr35473wmq.4.1696081354580; Sat, 30 Sep
 2023 06:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com>
In-Reply-To: <65181064.050a0220.7887c.c7ee@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 30 Sep 2023 15:42:20 +0200
Message-ID: <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
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

On Sat, Sep 30, 2023 at 2:11=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Sat, Sep 30, 2023 at 01:59:53PM +0200, Eric Dumazet wrote:
> > On Fri, Sep 22, 2023 at 1:13=E2=80=AFPM Christian Marangi <ansuelsmth@g=
mail.com> wrote:
> > >
> > > We currently have napi_if_scheduled_mark_missed that can be used to
> > > check if napi is scheduled but that does more thing than simply check=
ing
> > > it and return a bool. Some driver already implement custom function t=
o
> > > check if napi is scheduled.
> > >
> > > Drop these custom function and introduce napi_is_scheduled that simpl=
y
> > > check if napi is scheduled atomically.
> > >
> > > Update any driver and code that implement a similar check and instead
> > > use this new helper.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
> > >  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
> > >  include/linux/netdevice.h                 | 5 +++++
> > >  net/core/dev.c                            | 2 +-
> > >  4 files changed, 7 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/e=
thernet/chelsio/cxgb3/sge.c
> > > index 2e9a74fe0970..71fa2dc19034 100644
> > > --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > > +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > > @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct =
*napi, int budget)
> > >         return work_done;
> > >  }
> > >
> > > -/*
> > > - * Returns true if the device is already scheduled for polling.
> > > - */
> > > -static inline int napi_is_scheduled(struct napi_struct *napi)
> > > -{
> > > -       return test_bit(NAPI_STATE_SCHED, &napi->state);
> > > -}
> > > -
> > >  /**
> > >   *     process_pure_responses - process pure responses from a respon=
se queue
> > >   *     @adap: the adapter
> > > diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/=
wireless/realtek/rtw89/core.c
> > > index 133bf289bacb..bbf4ea3639d4 100644
> > > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > > @@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct rt=
w89_dev *rtwdev,
> > >         struct napi_struct *napi =3D &rtwdev->napi;
> > >
> > >         /* In low power mode, napi isn't scheduled. Receive it to net=
if. */
> > > -       if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
> > > +       if (unlikely(!napi_is_scheduled(napi)))
> > >                 napi =3D NULL;
> > >
> > >         rtw89_core_hw_to_sband_rate(rx_status);
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index db3d8429d50d..8eac00cd3b92 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct =
napi_struct *n)
> > >         return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
> > >  }
> > >
> >
> >
> > In which context is it safe to call this helper ?
> >
>
> test_bit is atomic so it should be always safe. Also the idea of this
> check (and from what I can see this apply also to the other 2 user) is
> somehow best effort, we check if in the current istant there is a napi
> scheduled and we act.

I think testing a bit here is not enough to take any kind of useful decisio=
n,
unless used in a particular context.

>
> > I fear that making this available will add more bugs.
> >
> > For instance rspq_check_napi() seems buggy to me.
> >
>
> Mhhh why? Am I opening a can of worms?

Yes I think :/

Because only the thread that has grabbed the bit can make any sense of it.

Another thread reading it would not really know if the value is not going t=
o
change immediately. So what would be the point ?

It seems rspq_check_napi() real intent was maybe the following,
but really this is hard to know if the current race in this code is okay or=
 not.

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c
b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 2e9a74fe0970df333226b80af8716f30865c01b7..e153c9590b36b38e430bc936601=
46b428e9b3347
100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -2676,8 +2676,10 @@ static int rspq_check_napi(struct sge_qset *qs)

        if (!napi_is_scheduled(&qs->napi) &&
            is_new_response(&q->desc[q->cidx], q)) {
-               napi_schedule(&qs->napi);
-               return 1;
+               if (napi_schedule_prep(&qs->napi)) {
+                       __napi_schedule(&qs->napi);
+                       return 1;
+               }
        }
        return 0;
 }
