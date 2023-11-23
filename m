Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825207F63F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjKWQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:32:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146810C6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:32:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso11926a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700757145; x=1701361945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHnx14cr1yCK8qle9tu2EE/pgUOBSdUP8QNopUBV1ok=;
        b=pTAB8MJVLfCdKrBFt3EDg5XJN+BVkaCDpdEBi6MO4zb45FMBKy+MXcjfoRdWcpYcB6
         9kHJ+ZHf/sBinz8UeEqoBleBmmzneFnTJcRxBtYx9Ht34zhCroTZoVgHibgyjrlTwIKB
         zQgsjxRdrFZFF/wBeDXXhhjpmDbxzrzA+Ln1VPP+hs5VAmbzU3BXaMCxpTLHYRcgtZRU
         NiWEo4aRf/qHUx3C/JXxXEyRfZI7C4mNIi0PnFpXhXxikU6xF2QdTy7ZJlFnPSHCHVJG
         0+bhYEUmdICIRUuhX0dJr0GpDqRv097OgbWFkGy55fOOBL4zzJlMS7CSifvzSy+ZVUl7
         m4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757145; x=1701361945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHnx14cr1yCK8qle9tu2EE/pgUOBSdUP8QNopUBV1ok=;
        b=JpIUJiCtXTJEn+KjwDmIcj833L3AKyK8qriDdPlOnhp1QQLEVKpYOI8kKKeutbj0OM
         PJ2hP6zbbonxS5NSReeL8TM0Xrt5TGm+wNuDapxbT1IQaaLHbk2yDYwe9hTDjtueN/th
         v02rV16u49LePQIaIwjsb99MOIoc/Y+I/Fal1izLZMivjN7zWAIvHLraerxqQg5A+DJI
         BdfKv5BRZq5niWomaY3YSeWhNcK2AHcAfVm5Cc7eBgEuE0O0nZPucApaAPOE9yVnabho
         2IkWOXuSwP1znFDQL3ZAyBaHG+GojI18mnEEkBtuxY88lXvTNM1rPVCtYUfueGSd1BzY
         ee3Q==
X-Gm-Message-State: AOJu0Yw/p2kL939JEEEkJ0q7h/c2ddBoP0hNxavckUGrjK8P/tX5t++L
        QlCN93Y3+d+kHWe7brFs6OVAXNCB6G8tV+wdAWV+QA==
X-Google-Smtp-Source: AGHT+IERAzT2DH14wnLepk/HR1XspkDfoaCAepJVb9iyd7gTXAqiNiKYOdIkOlYeflAbx8t1ArAm/oe72C+mWNV5/sc=
X-Received: by 2002:a05:6402:35ca:b0:544:24a8:ebd with SMTP id
 z10-20020a05640235ca00b0054424a80ebdmr390780edc.4.1700757144364; Thu, 23 Nov
 2023 08:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com> <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
In-Reply-To: <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 23 Nov 2023 17:32:10 +0100
Message-ID: <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 3:34=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> Hi Eric,
>
> On Mon, 20 Nov 2023 at 18:56, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 10:05=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
> > >
> > > @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, i=
nt timeo)
> > >                 if (state =3D=3D DCCP_TIME_WAIT)
> > >                         timeo =3D DCCP_TIMEWAIT_LEN;
> > >
> > > -               /* tw_timer is pinned, so we need to make sure BH are=
 disabled
> > > -                * in following section, otherwise timer handler coul=
d run before
> > > -                * we complete the initialization.
> > > -                */
> > > -               local_bh_disable();
> > > -               inet_twsk_schedule(tw, timeo);
> > > -               /* Linkage updates.
> > > -                * Note that access to tw after this point is illegal=
.
> > > -                */
> > > +              local_bh_disable();
> > > +
> > > +               // Linkage updates
> > >                 inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> > > +               inet_twsk_schedule(tw, timeo);
> >
> > We could arm a timer there, while another thread/cpu found the TW in
> > the ehash table.
> >
> >
> >
> > > +               // Access to tw after this point is illegal.
> > > +               inet_twsk_put(tw);
> >
> > This would eventually call inet_twsk_free() while the timer is armed.
> >
> > I think more work is needed.
> >
> > Perhaps make sure that a live timer owns a reference on tw->tw_refcnt
> > (This is not the case atm)
> >
>
> I thought that was already the case, per inet_twsk_hashdance():
>
> /* tw_refcnt is set to 3 because we have :
>  * - one reference for bhash chain.
>  * - one reference for ehash chain.
>  * - one reference for timer.
>
> and
>
> tw_timer_handler()
> `\
>   inet_twsk_kill()
>   `\
>     inet_twsk_put()
>
> So AFAICT, after we go through the hashdance, there's a reference on
> tw_refcnt held by the tw_timer.
> inet_twsk_deschedule_put() can race with arming the timer, but it only
> calls inet_twsk_kill() if the timer
> was already armed & has been deleted, so there's no risk of calling it
> twice... If I got it right :-)
>

Again, I think you missed some details.

I am OOO for a few days, I do not have time to elaborate.

You will need to properly track active timer by elevating
tw->tw_refcnt, or I guarantee something wrong will happen.
