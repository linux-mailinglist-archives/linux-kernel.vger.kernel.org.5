Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9D811CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjLMSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjLMSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:35:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED830D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:35:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so71972901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702492534; x=1703097334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv+5XsUdJVuk8GOh1DuytA+yuMqTKKF6sR66teLcGMU=;
        b=qv7D4Gyg7PjuBe8+/3qFwd8oRLfSAXelbFfnSkV+PDSmr9rJ7sypzaGeFiVb4vmwjn
         03zTxKHs4E8X3uQuKChdTGFeX7Dki0eaW6/7Ta5q1dVpVI4NUaipTWv8a/5rccMowBC8
         1LzzFvgm9bWC0anuRpGLRQj4yP4SwAReNcT88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492534; x=1703097334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv+5XsUdJVuk8GOh1DuytA+yuMqTKKF6sR66teLcGMU=;
        b=iVm4ZNXAhBqIGemzSGZ/iLdiJw6DWMANU1364exyp7skdYLgcboe817cdW2tasKU6A
         +ttkCBYmqYK5KWHrCNSHRCrrPj89HTQsrnuaYDTzGC06c7uINzfOM2owE5gTeh1GvCWP
         PP0yLScD+aEpJ1bkvRpBVKSaNqhFmr9q9bLN3qHOoa7zC6XUN+n86Vw1c+o1sECa5URw
         eErRsdfv3gPGS3JtoMcF8UOyg3ZESvB4FAHmWf4OKtI+xfoTuAEXjCZfdJgRP/eqEiy0
         1CPUuil2PPlKXX6xAVJb6KNoJLlG7A2Vj+lh6qq+V9W7Gko8b0OpYQxwPgs7CPdmBFyi
         cGkA==
X-Gm-Message-State: AOJu0YyG8wwiveRefkelRnD4oYsUZSPHLHNkWErQEoirveiT7AE5SPVH
        sgW2ctVnvuDLSckOS7UtNe51fw+c4GPkB2jTKY4eKgDl/khT9s6v
X-Google-Smtp-Source: AGHT+IF98/Eb//7DFZtThhYC5gn2eqT/lGOfRQfhM6QVrDzFFDAch/dR4KHz4VQs4C66M1mY9YscTVbF02261clQEW0=
X-Received: by 2002:a2e:9f4a:0:b0:2cc:3dac:2e8 with SMTP id
 v10-20020a2e9f4a000000b002cc3dac02e8mr351771ljk.26.1702492534092; Wed, 13 Dec
 2023 10:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20231212174750.GA11886@neeraj.linux> <20231212174817.11919-3-neeraj.iitr10@gmail.com>
 <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com> <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop>
In-Reply-To: <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 13 Dec 2023 13:35:22 -0500
Message-ID: <CAEXW_YQnR51F9xnODZd3iE+S5Jpd2NHRBTk6Jt2WHTSdB9H8kA@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't run concurrently
To:     paulmck@kernel.org
Cc:     "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:52=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Dec 13, 2023 at 09:27:09AM -0500, Joel Fernandes wrote:
> > On Tue, Dec 12, 2023 at 12:48=E2=80=AFPM Neeraj Upadhyay (AMD)
> > <neeraj.iitr10@gmail.com> wrote:
> > >
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > >
> > > If an SRCU barrier is queued while callbacks are running and a new
> > > callbacks invocator for the same sdp were to run concurrently, the
> > > RCU barrier might execute too early. As this requirement is non-obvio=
us,
> > > make sure to keep a record.
> > >
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> > > ---
> > >  kernel/rcu/srcutree.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 2bfc8ed1eed2..0351a4e83529 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_=
struct *work)
> > >         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_N=
EXT_TAIL));
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp=
_seq));
> > > +       /*
> > > +        * Although this function is theoretically re-entrant, concur=
rent
> > > +        * callbacks invocation is disallowed to avoid executing an S=
RCU barrier
> > > +        * too early.
> > > +        */
> >
> > Side comment:
> > I guess even without the barrier reasoning, it is best not to allow
> > concurrent CB execution anyway since it diverges from the behavior of
> > straight RCU :)
>
> Good point!
>
> But please do not forget item 12 on the list in checklist.rst.  ;-)
> (Which I just updated to include the other call_rcu*() functions.)

I think this is more so now with recent kernels (with the dynamic nocb
switch) than with older kernels right? I haven't kept up with the
checklist recently (which is my bad).

My understanding comes from the fact that the RCU barrier depends on
callbacks on the same CPU executing in order with straight RCU
otherwise it breaks. Hence my comment. But as you pointed out, that's
outdated knowledge.

I should just shut up and hide in shame now.

:-/

 - Joel
