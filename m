Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B680FA73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377868AbjLLWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377804AbjLLWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:33:05 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B67BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:33:10 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ca0d14976aso84279631fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702420389; x=1703025189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CgZAVpyJIJhbzb2eIflM/ttNtq4S4QTfNgTsx0ak7I=;
        b=sbOLz5kfVNsdL566CfQ3eqf5W18Is7/K2Y2dMAPNdrz+IOHmJZdw1VdCiOgIoOz+yo
         KrQ6sESflHtRvIf1knUTbezIGNDvi0GMIZg8ZfqmAB7lfithqZu1I2BvVUEfLAr7nIQc
         Lh8P6nPh7lsD3kfc1s0NmwV3/6AHCC3E2pZd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702420389; x=1703025189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CgZAVpyJIJhbzb2eIflM/ttNtq4S4QTfNgTsx0ak7I=;
        b=LAQ/p4Faa3MPiQuT953oI+lUjTcU0wEnrC8pAgIydFaLezXntp4hpIG3COWBUa0so1
         z7LRZLEpOcgdO02qq+8ZiQoqAvLznvmJGh4ogxyIEMLXXuWQDwauoaKo+ZVO2pA5NutA
         gcpZnHuRFlzHE946Tmnw5F8/Hm1oQBWXeSCXz/VNHJNIJ+1FfSlvyEgpYSlAgGTxr6ST
         cXTcmINsDMi65rYtXQ7DXpPMpyGl2tnLMVdcyNw8GsqL1lbOujjCMp/afJUP3knM2BnS
         JZo4xjo5HhL73/+Oj1GUpDLTrOjSYrWMh5RVgRFwYZ1qmeBoVPcPhxyG3MkrisuYgkCB
         HwyQ==
X-Gm-Message-State: AOJu0YysE1VrFE7YrsUoeKBJL8cJYUvszyDNjZLZJt2p97geQ9hED24u
        IJefh/J4KksXo/52U3G5wHVY1U5njAe59R8faDQKCw==
X-Google-Smtp-Source: AGHT+IHa0DyM23UFd7kxQ7tlTSAPnhwgMiZf5fQdtZb0lUFLgn6WDER7s7wXVJtDBV7GsvplhqSNwEib3ze3KRcGdcs=
X-Received: by 2002:a2e:a615:0:b0:2cc:5a4:655f with SMTP id
 v21-20020a2ea615000000b002cc05a4655fmr2161581ljp.55.1702420389050; Tue, 12
 Dec 2023 14:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20231203011252.233748-1-qyousef@layalina.io> <20231205162043.GA2558193@google.com>
 <20231207172032.kto27hfdxa4juq7b@airbuntu> <0d531690-1240-4356-a647-b4c71a56b31d@joelfernandes.org>
 <20231212120555.wradm57buz7ckv4p@airbuntu>
In-Reply-To: <20231212120555.wradm57buz7ckv4p@airbuntu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 12 Dec 2023 17:32:57 -0500
Message-ID: <CAEXW_YTe1Djj8+bZO8_W68stD6wV=j9KEnPGMBrwhqy5WB=5Bg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
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

On Tue, Dec 12, 2023 at 7:05=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 12/09/23 01:26, Joel Fernandes wrote:
> > On 12/7/23 12:20, Qais Yousef wrote:
> > > On 12/05/23 16:20, Joel Fernandes wrote:
> > >
> > >> I think a better approach is not do an anti-CONFIG option and instea=
d do
> > >> a shorter parameter "rcutree.lazy=3D0". If CONFIG_RCU_LAZY is set, t=
hen we can
> > >> just default to keeping lazy on. I'd like to avoid proliferation of =
already
> > >> large number of RCU config options and more chances of errors.
> > >
> > > The issue is that we don't want to ship with default on :-)
> >
> > Yes, so you can ship with rcutree.enable_lazy=3D0 which this patch adds=
, no? In
> > theory, you can accomplish this by simply CONFIG_RCU_LAZY=3Dy and
> > rcutree.enable_lazy=3D0 or rcutree.lazy=3D0.
> >
> > However, I see the inconvenience factor (you have to set a boot paramet=
er
> > without making this a purely .config affair) so I am not terribly oppos=
ed with
> > this patch (I am also guilty of adding a CONFIG option to avoid having =
to set a
> > boot parameter (for unrelated feature), but in my defense I did not kno=
w a boot
> > parameter existed for the said feature). ;-)
>
> It is more than inconvenience. The GKI doesn't ship with a specific users=
pace.
> So we can't guarantee the boot parameter will be set and have to rely on =
no one
> missing the memo to add this additional parameter.

Yes, I see that now. Looks like Android also needs to be supplying a
"GKI boot parameter" requirement to their GKI supplied kernels ;-).
But I see the issue you are referring to now.

It would be good to add these details to your respin.

> > > Not allowing this
> > > in upstream means I'll either have to resort to keep it disabled, or =
carry out
> > > of tree patch to get what I want. Both of which would be unfortunate.
> >
> > There is already precedent for building things into the kernel but keep=
ing them
> > default off, so I don't have an issue with the experimentation use case=
. I was
> > just discussing whether the additional CONFIG is really needed when you=
 already
> > have added a boot param to keep it default-off. If you have an argument=
 for why
> > that would be really helpful [1].
> >
> > Also, nit: rcutree.enable_lazy is probably better than rcutree.enable_r=
cu_lazy.
> > The 'rcu' is redundant.
>
> It matches the config option so feels natural to have them both named the=
 same?

Ok, either is fine with me.

> > Other than that, the patch LGTM but if you could update the commit log =
with
> > details about [1], that would be great. And while at it, you could add =
my tag:
>
> You forgot to include [1]? Or I'm just blind today?

Heh, if you search "[1]" you see it above where I said "helpful". ;-).
But apologies if I caused confusion.

thanks,

 - Joel


>
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Thanks!
>
> --
> Qais Yousef
