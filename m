Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70378E16A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbjH3V3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjH3V3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:29:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CCACF0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:28:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bce552508fso4371411fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693430871; x=1694035671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5DJzy56A/nwYm3Fh8L0N2T0VZK9ewMIuVyotil1TqE=;
        b=J+qYIIEffkrCex2YqgOd6mgpdut8p54nm9mIBqIlueCFRojv/0VGSnrkGNSiYkY/Sx
         UTOW13xmQ4O9yaQwgfc3gdjjcRJ3hxArHtW6Tu8AGFs3/d2KdAU5qzPiLO7+7CMUd1qp
         fEpWVaO8SgagZ7Cl5kxM/qe7jJZPc9oq42Xk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430871; x=1694035671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5DJzy56A/nwYm3Fh8L0N2T0VZK9ewMIuVyotil1TqE=;
        b=JHk0rXGBlraT4wRZW1t4jc591lV8nlQ8fDu1P8+fZ0yecO3CJQ/cLIJIAz24Hh15nO
         EShJc2N5h2yxavqUcJsoXS+bdWZtXplwz6dxgLA1WYFcYXk87B5EYXvud+UsXaPIngUz
         KUhyv47Pql8/5KQLESCZh8IYuzoK8KJZMd+258qYWGs4URZsYiPH85XWjlIuQpDO8mK1
         YNo6El6ZVNmakTDguiSRspQWtrb13Hrr7wsZyJS+kbvMVrYvvPpYHfYF3SEW8XtMJigI
         aOaqUpSWSMC3DkmKWGmaUapflLYTfZNE6GcFmUBcbJuCp8FV8A/gdWSAp50qfu67RRxz
         kavQ==
X-Gm-Message-State: AOJu0YzZd+YqcUxQ77KrHgkTQ5siGsD31hlJgsPeKp6Z2kqptEuIfVh3
        PW5xwidPKFqIiVJ2bXfZlF/1FaIxwEzHNo+Gls4Q0g==
X-Google-Smtp-Source: AGHT+IH0q0mDwWYyHqx0XTJ/0WX+KbgZ/mMfiBziyqml/CVcnPVo81k3hfHqZRcz7ObX/cg2PXCEUpH12fZr0OZ+f+Q=
X-Received: by 2002:a2e:b6c2:0:b0:2bb:9781:1a4c with SMTP id
 m2-20020a2eb6c2000000b002bb97811a4cmr3108409ljo.27.1693430871551; Wed, 30 Aug
 2023 14:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230729142738.222208-1-joel@joelfernandes.org>
 <20230729142738.222208-5-joel@joelfernandes.org> <ZO4EdIM/JtelKHFH@lothringen>
In-Reply-To: <ZO4EdIM/JtelKHFH@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 17:27:43 -0400
Message-ID: <CAEXW_YS-0X7TEr0n4p1VYx0VvqVWVWRrm45ydaQkrcHhQ0uM2w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tree/nocb: Improve readability of nocb_gp_wait()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:45=E2=80=AFAM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> On Sat, Jul 29, 2023 at 02:27:34PM +0000, Joel Fernandes (Google) wrote:
> >  /*
> >   * No-CBs GP kthreads come here to wait for additional callbacks to sh=
ow up
> >   * or for grace periods to end.
> >   */
> >  static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  {
> > -     bool bypass =3D false;
> >       int __maybe_unused cpu =3D my_rdp->cpu;
> >       unsigned long cur_gp_seq;
> >       unsigned long flags;
> >       bool gotcbs =3D false;
> > -     unsigned long j =3D jiffies;
> > -     bool lazy =3D false;
> >       bool needwait_gp =3D false; // This prevents actual uninitialized=
 use.
> >       bool needwake;
> >       bool needwake_gp;
> > +     int defer_wake_type =3D RCU_NOCB_WAKE_NOT;
> >       struct rcu_data *rdp, *rdp_toggling =3D NULL;
> >       struct rcu_node *rnp;
> >       unsigned long wait_gp_seq =3D 0; // Suppress "use uninitialized" =
warning.
> > @@ -712,44 +758,24 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >        * won't be ignored for long.
> >        */
> >       list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) =
{
> > -             long bypass_ncbs;
> > -             bool flush_bypass =3D false;
> > -             long lazy_ncbs;
> > +             int defer_wake_type_one =3D RCU_NOCB_WAKE_NOT;
>
> No need to initialize it, nocb_gp_flush_wake() always returns a value, an=
d
> it will avoid mistakes in the future if nocb_gp_flush_wake() is moved and
> accidentally not called.

Compiler does not like that if it is not initialized:
tree_nocb.h:821:51: error: =E2=80=98defer_wake_type=E2=80=99 is used uninit=
ialized
[-Werror=3Duninitialized]

> > +             bool flushed;
> > +             bool empty;
> >
> > -             trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"=
));
> >               rcu_nocb_lock_irqsave(rdp, flags);
> > -             lockdep_assert_held(&rdp->nocb_lock);
> > -             bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > -             lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
> > +             defer_wake_type_one =3D nocb_gp_flush_wake(rdp, &empty, &=
flushed);
> >
> > -             if (bypass_ncbs && (lazy_ncbs =3D=3D bypass_ncbs) &&
> > -                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + ji=
ffies_till_flush) ||
> > -                  bypass_ncbs > 2 * qhimark)) {
> > -                     flush_bypass =3D true;
> > -             } else if (bypass_ncbs && (lazy_ncbs !=3D bypass_ncbs) &&
> > -                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1)=
 ||
> > -                  bypass_ncbs > 2 * qhimark)) {
> > -                     flush_bypass =3D true;
> > -             } else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cbli=
st)) {
> > -                     rcu_nocb_unlock_irqrestore(rdp, flags);
> > -                     continue; /* No callbacks here, try next. */
> > -             }
> > +             // We may need to do a deferred wakeup later for bypass/l=
azy
> > +             // So note down what we learnt from the rdp.
> > +             defer_wake_type =3D max(defer_wake_type_one, defer_wake_t=
ype);
> >
> > -             if (flush_bypass) {
> > -                     // Bypass full or old, so flush it.
> > -                     (void)rcu_nocb_try_flush_bypass(rdp, j);
> > -                     bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypas=
s);
> > -                     lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
> > +             // Did we make any updates to main cblist? If not, no
> > +             // non-deferred wake up to do for this rdp.
> > +             if (!flushed && empty) {
>
> Can you ever have (flushed && empty) ? If not you should be able to remov=
e the
> flushed parameter.

We can return 3 different states from the new nocb_gp_flush_wake():
1. flushed =3D true and empty =3D false
2. flushed =3D false and empty =3D true
3. flushed =3D false and empty =3D false

I guess you mean, we don't care about case #1 and #3 ?

That's a good point. What I will do then is pass a single bool
"wakeup" and and set it for case #2 from within the
nocb_gp_flush_wake().

Thanks!

 - Joel
