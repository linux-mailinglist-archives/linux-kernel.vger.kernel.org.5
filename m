Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3204B76E866
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjHCMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjHCMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:36:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC23A9F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:35:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40fed08b990so2941611cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691066155; x=1691670955;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp3hTgUY18/N/XEQ+iz6TxOXCGZIQfvOaWHcJ1832JY=;
        b=mAGpLqkdsAIdNTZU4KfE/StJqqO8cFzAHfP5rR22fNUTJ1K04+p5IzaaUB18lV2bEA
         jD31hgtZ9UiMtSzPwFY2UnsXqgp/scAfLfdkqydaZLHevRg+FNF/OrL89FTBhnb27XXQ
         fitmfoWY7KaMBQa0bpkRqR7ODBEfPgpx0zsHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066155; x=1691670955;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp3hTgUY18/N/XEQ+iz6TxOXCGZIQfvOaWHcJ1832JY=;
        b=SETZ9vfxfu5geEMn5OPjT7P/+s2T++4VNqySg8r8XQtYML92ebcPwzfXBkGD2ZvNVD
         kafScbCHnlO/T6DtvoeQBr1lslqsBut+PhijB/RYGiQEgV2PN8fNmAD8cBawlWYLuHAF
         H4Ey7fORQYn8Na9apLcH5TjavDRyXRSuaL7kgTkormi+SimxWKuKsTPqeQNVi8ZlKnho
         j9CaORV6pnuEsCfhdjtto+a2oEazllaLoLzHYGVE6epWDitvdXO80b+bFM38Cv4gOuN/
         +xaQo+5FPmhIw3Iy93uQwgTCC9f4h42hji9Jg26yx46rxMljrvPxs6cKERt9BjDD3MJN
         EZlA==
X-Gm-Message-State: ABy/qLa18ilyFcZ+6dWF8TqnmSx29uJ3LqqGZjabUMzDp0WTbf57ZSSc
        ocgHODSz2yTu4Q6mXQUr5qdGjt4dyq3lmlXl4Z4=
X-Google-Smtp-Source: APBJJlGl4AQ6y7e0J3IYSfDfzzNxkT0vrZRXptKFuMR/zJ7g4M+q2wFDT0gctVqr+hr2Qx8RDErVEg==
X-Received: by 2002:ac8:5ad3:0:b0:40f:dc70:fde1 with SMTP id d19-20020ac85ad3000000b0040fdc70fde1mr6847753qtd.18.1691066155123;
        Thu, 03 Aug 2023 05:35:55 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.224])
        by smtp.gmail.com with ESMTPSA id b16-20020ac844d0000000b00406b11a54b8sm6145774qto.7.2023.08.03.05.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 05:35:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
Date:   Thu, 3 Aug 2023 08:35:43 -0400
Message-Id: <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
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
In-Reply-To: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
To:     Alan Huang <mmpgouride@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> wrote:
>=20
> =EF=BB=BF
>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes (Google) <=
joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Add a detailed note to explain the potential side effects of
>> plain-accessing the gp pointer using a plain load, without using the
>> rcu_dereference() macros; which might trip neighboring code that does
>> use rcu_dereference().
>>=20
>> I haven't verified this with a compiler, but this is what I gather from
>> the below link using Will's experience with READ_ONCE().
>>=20
>> Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck=
/
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>>=20
>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Doc=
umentation/RCU/Design/Requirements/Requirements.rst
>> index f3b605285a87..e0b896d3fb9b 100644
>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference counti=
ng
>> .. |high-quality implementation of C11 memory_order_consume [PDF]| replac=
e:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
>> .. _high-quality implementation of C11 memory_order_consume [PDF]: http:/=
/www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
>>=20
>> +Note that, there can be strange side effects (due to compiler optimizati=
ons) if
>> +``gp`` is ever accessed using a plain load (i.e. without ``READ_ONCE()``=
 or
>> +``rcu_dereference()``) potentially hurting any succeeding
>> +``rcu_dereference()``. For example, consider the code:
>> +
>> +   ::
>> +
>> +       1 bool do_something_gp(void)
>> +       2 {
>> +       3   void *tmp;
>> +       4   rcu_read_lock();
>> +       5   tmp =3D gp; // Plain-load of GP.
>> +       6   printk("Point gp =3D %p\n", tmp);
>> +       7
>> +       8   p =3D rcu_dereference(gp);
>> +       9   if (p) {
>> +      10     do_something(p->a, p->b);
>> +      11     rcu_read_unlock();
>> +      12     return true;
>> +      13   }
>> +      14   rcu_read_unlock();
>> +      15   return false;
>> +      16 }
>> +
>> +The behavior of plain accesses involved in a data race is non-determinis=
tic in
>> +the face of compiler optimizations. Since accesses to the ``gp`` pointer=
 is
>> +by-design a data race, the compiler could trip this code by caching the v=
alue
>> +of ``gp`` into a register in line 5, and then using the value of the reg=
ister
>> +to satisfy the load in line 10. Thus it is important to never mix
>=20
> Will=E2=80=99s example is:
>=20
>     // Assume *ptr is initially 0 and somebody else writes it to 1
>     // concurrently
>=20
>     foo =3D *ptr;
>     bar =3D READ_ONCE(*ptr);
>     baz =3D *ptr;
>=20
> Then the compiler is within its right to reorder it to:
>=20
>    foo =3D *ptr;
>    baz =3D *ptr;
>    bar =3D READ_ONCE(*ptr);
>=20
> So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is perfectly legal=
.

Yes, a bad outcome is perfectly legal amidst data race. Who said it is not l=
egal?

>=20
> But the example here is different,

That is intentional. Wills discussion partially triggered this. Though I am w=
ondering
if we should document that as well.

> the compiler can not use the value loaded from line 5
> unless the compiler can deduce that the tmp is equals to p in which case t=
he address dependency
> doesn=E2=80=99t exist anymore.
>=20
> What am I missing here?

Maybe you are trying to rationalize too much that the sequence mentioned can=
not result
in a counter intuitive outcome like I did?

The point AFAIU is not just about line 10 but that the compiler can replace a=
ny of the
lines after the plain access with the cached value.

Thanks.



>=20
>> +plain accesses of a memory location with rcu_dereference() of the same m=
emory
>> +location, in code involved in a data race.
>> +
>> In short, updaters use rcu_assign_pointer() and readers use
>> rcu_dereference(), and these two RCU API elements work together to
>> ensure that readers have a consistent view of newly added data elements.
>> --=20
>> 2.41.0.585.gd2178a4bd4-goog
>>=20
>=20
