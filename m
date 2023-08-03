Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2E76EEEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjHCQB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbjHCQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:01:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C166420B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:01:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso16939021fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691078489; x=1691683289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfOnbChenoT5iUdGZzWD598G4NpVZQLyrs3i3PDfkUE=;
        b=yBrykV1+Yxz+dXM/ChGYwIaUnstIEPzc7oJ7TPM5G+TZFhy1FEQP1OmF5e40VzG6+j
         Tadl5c2C/X2sltV7chfOLmghgsIWGY0Qup8JoV0+LtVyFOumgVZzImUOYfQDAXuO8M6U
         RKtgW/dKlyMQLyOMtHRN7TWRlqUMETY3dx5PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691078489; x=1691683289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfOnbChenoT5iUdGZzWD598G4NpVZQLyrs3i3PDfkUE=;
        b=FcrM1Ag7NskIy4e4Gm3RI/6UWXBoLm1u9W4HokHvdtA2ULnkIsYUDQ5A8S8fgL6MRv
         7U1yFEyUa467+mggXCDqwr7vhkJbGdnIAZhx5qsdjGBdMqCWZsEIQfm1ARiKMwo5uaPe
         MlIK0/DV15odAaO2dl+OIEHgcdK/OLSH3gkY+xksxjSP/fNLmNgA1QMtkqh564XO8tig
         eB40OadfHtGC9UqsvpS2SpKD3IVeJRAiMPSUVBVg6j4P/P5/UuO/hflqa59x0LdL66BK
         RT5qOR3HrXNVRH+mVmik+0NHQHIJ4aC2kZOrHrwXi+qypeYJWrGzuRbFxAgSVDyRnFlG
         mWSA==
X-Gm-Message-State: ABy/qLYLNllUGPp9RIb0yV2q1LXEggTkzcx2FgYES/ijyni1BkUF2paX
        avbP9KEIid3PZjnQLc/lD4h+Yb+ECbvbkC7IOaxmVg==
X-Google-Smtp-Source: APBJJlFb08qaQRE1j3kJJp15KjayjW/jMbn9rTirig0FlWYqntK1TuEvZPecPKOvcPfV0R08QFj2zVE5Rthv0C1WzKc=
X-Received: by 2002:a2e:9192:0:b0:2b9:4418:b46e with SMTP id
 f18-20020a2e9192000000b002b94418b46emr8813701ljg.21.1691078488934; Thu, 03
 Aug 2023 09:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
 <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org> <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
In-Reply-To: <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Aug 2023 12:01:18 -0400
Message-ID: <CAEXW_YRXA3j3k9VRuZJ7d=yo6__TRpeE6igrQ+GEZiyKtFmUOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
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

On Thu, Aug 3, 2023 at 9:36=E2=80=AFAM Alan Huang <mmpgouride@gmail.com> wr=
ote:
>
>
> > 2023=E5=B9=B48=E6=9C=883=E6=97=A5 =E4=B8=8B=E5=8D=888:35=EF=BC=8CJoel F=
ernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> >> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> wrote:
> >>
> >> =EF=BB=BF
> >>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes (Googl=
e) <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> Add a detailed note to explain the potential side effects of
> >>> plain-accessing the gp pointer using a plain load, without using the
> >>> rcu_dereference() macros; which might trip neighboring code that does
> >>> use rcu_dereference().
> >>>
> >>> I haven't verified this with a compiler, but this is what I gather fr=
om
> >>> the below link using Will's experience with READ_ONCE().
> >>>
> >>> Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the-t=
ruck/
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>> ---
> >>> .../RCU/Design/Requirements/Requirements.rst  | 32 ++++++++++++++++++=
+
> >>> 1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b=
/Documentation/RCU/Design/Requirements/Requirements.rst
> >>> index f3b605285a87..e0b896d3fb9b 100644
> >>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> >>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> >>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference co=
unting
> >>> .. |high-quality implementation of C11 memory_order_consume [PDF]| re=
place:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
> >>> .. _high-quality implementation of C11 memory_order_consume [PDF]: ht=
tp://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
> >>>
> >>> +Note that, there can be strange side effects (due to compiler optimi=
zations) if
> >>> +``gp`` is ever accessed using a plain load (i.e. without ``READ_ONCE=
()`` or
> >>> +``rcu_dereference()``) potentially hurting any succeeding
> >>> +``rcu_dereference()``. For example, consider the code:
> >>> +
> >>> +   ::
> >>> +
> >>> +       1 bool do_something_gp(void)
> >>> +       2 {
> >>> +       3   void *tmp;
> >>> +       4   rcu_read_lock();
> >>> +       5   tmp =3D gp; // Plain-load of GP.
> >>> +       6   printk("Point gp =3D %p\n", tmp);
> >>> +       7
> >>> +       8   p =3D rcu_dereference(gp);
> >>> +       9   if (p) {
> >>> +      10     do_something(p->a, p->b);
> >>> +      11     rcu_read_unlock();
> >>> +      12     return true;
> >>> +      13   }
> >>> +      14   rcu_read_unlock();
> >>> +      15   return false;
> >>> +      16 }
> >>> +
> >>> +The behavior of plain accesses involved in a data race is non-determ=
inistic in
> >>> +the face of compiler optimizations. Since accesses to the ``gp`` poi=
nter is
> >>> +by-design a data race, the compiler could trip this code by caching =
the value
> >>> +of ``gp`` into a register in line 5, and then using the value of the=
 register
> >>> +to satisfy the load in line 10. Thus it is important to never mix
> >>
> >> Will=E2=80=99s example is:
> >>
> >>    // Assume *ptr is initially 0 and somebody else writes it to 1
> >>    // concurrently
> >>
> >>    foo =3D *ptr;
> >>    bar =3D READ_ONCE(*ptr);
> >>    baz =3D *ptr;
> >>
> >> Then the compiler is within its right to reorder it to:
> >>
> >>   foo =3D *ptr;
> >>   baz =3D *ptr;
> >>   bar =3D READ_ONCE(*ptr);
> >>
> >> So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is perfectly l=
egal.
> >
> > Yes, a bad outcome is perfectly legal amidst data race. Who said it is =
not legal?
>
> My understanding is that it is legal even without data race, and the comp=
iler only keeps the order of volatile access.

Yes, but I can bet on it the author of the code would not have
intended such an outcome, if they did then Will wouldn't have been
debugging it ;-). That's why I called it a bad outcome. The goal of
this patch is to document such a possible unintentional outcome.

> >> But the example here is different,
> >
> > That is intentional. Wills discussion partially triggered this. Though =
I am wondering
> > if we should document that as well.
> >
> >> the compiler can not use the value loaded from line 5
> >> unless the compiler can deduce that the tmp is equals to p in which ca=
se the address dependency
> >> doesn=E2=80=99t exist anymore.
> >>
> >> What am I missing here?
> >
> > Maybe you are trying to rationalize too much that the sequence mentione=
d cannot result
> > in a counter intuitive outcome like I did?
> >
> > The point AFAIU is not just about line 10 but that the compiler can rep=
lace any of the
> > lines after the plain access with the cached value.
>
> Well, IIUC, according to the C standard, the compiler can do anything if =
there is a data race (undefined behavior).
>
> However, what if a write is not protected with WRITE_ONCE and the read is=
 marked with READ_ONCE?
> That=E2=80=99s also a data race, right? But the kernel considers it is Ok=
ay if the write is machine word aligned.

Yes, but there is a compiler between the HLL code and what the
processor sees which can tear the write. How can not using
WRITE_ONCE() prevent store-tearing? See [1]. My understanding is that
it is OK only if the reader did a NULL check. In that case the torn
result will not change the semantics of the program. But otherwise,
that's bad.

[1] https://lwn.net/Articles/793253/#Store%20Tearing

thanks,

 - Joel


>
> >
> > Thanks.
> >
> >
> >
> >>
> >>> +plain accesses of a memory location with rcu_dereference() of the sa=
me memory
> >>> +location, in code involved in a data race.
> >>> +
> >>> In short, updaters use rcu_assign_pointer() and readers use
> >>> rcu_dereference(), and these two RCU API elements work together to
> >>> ensure that readers have a consistent view of newly added data elemen=
ts.
> >>> --
> >>> 2.41.0.585.gd2178a4bd4-goog
>
