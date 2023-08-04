Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5E77004B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjHDMeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjHDMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:34:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C9EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:34:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76c8dd2ce79so173760785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691152447; x=1691757247;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWux1r+D+alsxr+DPQy9/21YSv+9P1gbAPb9G/B4bWI=;
        b=A3s1a9FAn0qYCE5faYO/Xek0ZLenUdAYQVCMPrPh2g0apapmCdE4tApV9Cjrsh4ePy
         DnY0ByJtvsjXERYB7FCzpt5p8+BcaA3Omoq/WLKSe36r+bixPJG53jwnbA9+AtKtOxrO
         5ES8YCPgAFU5hj7T65rn7oeFfL4SQI/aRzL/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691152447; x=1691757247;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWux1r+D+alsxr+DPQy9/21YSv+9P1gbAPb9G/B4bWI=;
        b=fJ5kp7U2Fqs94erw0JoOuL7qkgwKcZeNrQsUSEs2dEr5y1SfxzDTG66LYxPj8WoyhJ
         IdO9P49Jm2zjSQ0DXKjbqjErkenQBS2J7nIPk5MB6Lqj5QoB63e1D0P5Igy9pNmJ/Stp
         7+ZWxv+03tulo/AEud6ViBH2lt05G8n0ABU4RilelFf3UZGep8X7sTiP2p95q3fExnzp
         D49UTyqAGc2zQnSMJ6cuKGgIh44hEZ7l+lsG+LdZHagS6UDLcN6m78vYkvr4+YDLC4Q8
         TgYEZz7oiHheL3p2QZ9MtOLXejCeloZBo40pN+dDRbFf/EwJQmvBO3smudDY5lXp2XeC
         l1JQ==
X-Gm-Message-State: AOJu0YwBv/uTLFw3UNVaCbLDOQRpkGEa+kVUFgugmXlu11MCOUyK5AVo
        l9+jdb9oL45fEy2XPV+U3NsLDg==
X-Google-Smtp-Source: AGHT+IHoan1070Qw1Y0smmGvFg4wpMKqGx2qf6pytY6pl1l0915WGAURJJ1phfe3BDKzzH1pvKffLw==
X-Received: by 2002:a05:6214:1788:b0:630:463:3676 with SMTP id ct8-20020a056214178800b0063004633676mr1333312qvb.61.1691152446651;
        Fri, 04 Aug 2023 05:34:06 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.222])
        by smtp.gmail.com with ESMTPSA id u14-20020a0cdd0e000000b006375f9fd170sm636715qvk.34.2023.08.04.05.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 05:34:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
Date:   Fri, 4 Aug 2023 08:33:55 -0400
Message-Id: <D594A2D8-0C46-402D-B186-39DE7B65ED61@joelfernandes.org>
References: <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
Cc:     Alan Huang <mmpgouride@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 3, 2023, at 8:01 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, Aug 04, 2023 at 03:25:57AM +0800, Alan Huang wrote:
>>> 2023=E5=B9=B48=E6=9C=884=E6=97=A5 00:01=EF=BC=8CJoel Fernandes <joel@joe=
lfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>> On Thu, Aug 3, 2023 at 9:36=E2=80=AFAM Alan Huang <mmpgouride@gmail.com>=
 wrote:
>>>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 =E4=B8=8B=E5=8D=888:35=EF=BC=8CJoel =
Fernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> wrote:=

>>>>>>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes (Goo=
gle) <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>> Add a detailed note to explain the potential side effects of
>>>>>>>> plain-accessing the gp pointer using a plain load, without using th=
e
>>>>>>>> rcu_dereference() macros; which might trip neighboring code that do=
es
>>>>>>>> use rcu_dereference().
>>>>>>>>=20
>>>>>>>> I haven't verified this with a compiler, but this is what I gather f=
rom
>>>>>>>> the below link using Will's experience with READ_ONCE().
>>>>>>>>=20
>>>>>>>> Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the=
-truck/
>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>>>> ---
>>>>>>>> .../RCU/Design/Requirements/Requirements.rst  | 32 ++++++++++++++++=
+++
>>>>>>>> 1 file changed, 32 insertions(+)
>>>>>>>>=20
>>>>>>>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst=
 b/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>>>>> index f3b605285a87..e0b896d3fb9b 100644
>>>>>>>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>>>>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>>>>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference c=
ounting
>>>>>>>> .. |high-quality implementation of C11 memory_order_consume [PDF]| r=
eplace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
>>>>>>>> .. _high-quality implementation of C11 memory_order_consume [PDF]: h=
ttp://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
>>>>>>>>=20
>>>>>>>> +Note that, there can be strange side effects (due to compiler opti=
mizations) if
>>>>>>>> +``gp`` is ever accessed using a plain load (i.e. without ``READ_ON=
CE()`` or
>>>>>>>> +``rcu_dereference()``) potentially hurting any succeeding
>>>>>>>> +``rcu_dereference()``. For example, consider the code:
>>>>>>>> +
>>>>>>>> +   ::
>>>>>>>> +
>>>>>>>> +       1 bool do_something_gp(void)
>>>>>>>> +       2 {
>>>>>>>> +       3   void *tmp;
>>>>>>>> +       4   rcu_read_lock();
>>>>>>>> +       5   tmp =3D gp; // Plain-load of GP.
>>>>>>>> +       6   printk("Point gp =3D %p\n", tmp);
>>>>>>>> +       7
>>>>>>>> +       8   p =3D rcu_dereference(gp);
>>>>>>>> +       9   if (p) {
>>>>>>>> +      10     do_something(p->a, p->b);
>>>>>>>> +      11     rcu_read_unlock();
>>>>>>>> +      12     return true;
>>>>>>>> +      13   }
>>>>>>>> +      14   rcu_read_unlock();
>>>>>>>> +      15   return false;
>>>>>>>> +      16 }
>>>>>>>> +
>>>>>>>> +The behavior of plain accesses involved in a data race is non-dete=
rministic in
>>>>>>>> +the face of compiler optimizations. Since accesses to the ``gp`` p=
ointer is
>>>>>>>> +by-design a data race, the compiler could trip this code by cachin=
g the value
>>>>>>>> +of ``gp`` into a register in line 5, and then using the value of t=
he register
>>>>>>>> +to satisfy the load in line 10. Thus it is important to never mix
>>>>>>>=20
>>>>>>> Will=E2=80=99s example is:
>>>>>>>=20
>>>>>>>  // Assume *ptr is initially 0 and somebody else writes it to 1
>>>>>>>  // concurrently
>>>>>>>=20
>>>>>>>  foo =3D *ptr;
>>>>>>>  bar =3D READ_ONCE(*ptr);
>>>>>>>  baz =3D *ptr;
>>>>>>>=20
>>>>>>> Then the compiler is within its right to reorder it to:
>>>>>>>=20
>>>>>>> foo =3D *ptr;
>>>>>>> baz =3D *ptr;
>>>>>>> bar =3D READ_ONCE(*ptr);
>>>>>>>=20
>>>>>>> So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is perfectly=
 legal.
>>>>>>=20
>>>>>> Yes, a bad outcome is perfectly legal amidst data race. Who said it i=
s not legal?
>>>>>=20
>>>>> My understanding is that it is legal even without data race, and the c=
ompiler only keeps the order of volatile access.
>>>=20
>>> Yes, but I can bet on it the author of the code would not have
>>> intended such an outcome, if they did then Will wouldn't have been
>>> debugging it ;-). That's why I called it a bad outcome. The goal of
>>> this patch is to document such a possible unintentional outcome.
>>>=20
>>>>>> But the example here is different,
>>>>>=20
>>>>> That is intentional. Wills discussion partially triggered this. Though=
 I am wondering
>>>>> if we should document that as well.
>>>>>=20
>>>>>> the compiler can not use the value loaded from line 5
>>>>>> unless the compiler can deduce that the tmp is equals to p in which c=
ase the address dependency
>>>>>> doesn=E2=80=99t exist anymore.
>>>>>>=20
>>>>>> What am I missing here?
>>>>>=20
>>>>> Maybe you are trying to rationalize too much that the sequence mention=
ed cannot result
>>>>> in a counter intuitive outcome like I did?
>>>>>=20
>>>>> The point AFAIU is not just about line 10 but that the compiler can re=
place any of the
>>>>> lines after the plain access with the cached value.
>>>>=20
>>>> Well, IIUC, according to the C standard, the compiler can do anything i=
f there is a data race (undefined behavior).
>>>>=20
>>>> However, what if a write is not protected with WRITE_ONCE and the read i=
s marked with READ_ONCE?
>>>> That=E2=80=99s also a data race, right? But the kernel considers it is O=
kay if the write is machine word aligned.
>>>=20
>>> Yes, but there is a compiler between the HLL code and what the
>>> processor sees which can tear the write. How can not using
>>> WRITE_ONCE() prevent store-tearing? See [1]. My understanding is that
>>> it is OK only if the reader did a NULL check. In that case the torn
>>=20
>> Yes, a write-write data race where the value is the same is also fine.
>>=20
>> But they are still data race, if the compiler is within its right to do a=
nything it likes (due to data race),
>> we still need WRITE_ONCE() in these cases, though it=E2=80=99s semantical=
ly safe.
>>=20
>> IIUC, even with _ONCE(), the compiler is within its right do anything acc=
ording to the standard (at least before the upcoming C23), because the stand=
ard doesn=E2=80=99t consider a volatile access to be atomic.
>=20
> Volatile accesses are not specified very well in the standard.  However,
> as a practical matter, compilers that wish to be able to device drivers
> (whether in kernels or userspace applications) must compile those volatile=

> accesses in such a way to allow reliable device drivers to be written.

Agreed.

>=20
>> However, the kernel consider the volatile access to be atomic, right?
>=20
> The compiler must therefore act as if a volatile access to an aligned
> machine-word size location is atomic.  To see this, consider accesses
> to memory that is shared by a device driver and that device's firmware,
> both of which are written in either C or C++.

Btw it appears TSAN complaints bitterly on even volatile 4 byte data races.
Hence we have to explicitly use atomic API for data race accesses in Chrome.=


Thanks,
Joel



> Does that help?
>=20
>                            Thanx, Paul
>=20
>> BTW, line 5 in the example is likely to be optimized away. And yes, the c=
ompiler can cache the value loaded from line 5 from the perspective of undef=
ined behavior, even if I believe it would be a compiler bug from the perspec=
tive of kernel.
>>=20
>>> result will not change the semantics of the program. But otherwise,
>>> that's bad.
>>>=20
>>> [1] https://lwn.net/Articles/793253/#Store%20Tearing
>>>=20
>>> thanks,
>>>=20
>>> - Joel
>>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>> Thanks.
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>> +plain accesses of a memory location with rcu_dereference() of the s=
ame memory
>>>>>>> +location, in code involved in a data race.
>>>>>>> +
>>>>>>> In short, updaters use rcu_assign_pointer() and readers use
>>>>>>> rcu_dereference(), and these two RCU API elements work together to
>>>>>>> ensure that readers have a consistent view of newly added data eleme=
nts.
>>>>>>> --
>>>>>>> 2.41.0.585.gd2178a4bd4-goog
>>=20
>>=20
