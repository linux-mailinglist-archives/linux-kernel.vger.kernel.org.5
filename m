Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C954776F5FA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHCXG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHCXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:06:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC6C213F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:06:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40ddc558306so11237801cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691103968; x=1691708768;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU2Tak4FV3b6LJpZuOHRxW52FQqMy9yZygFfXqU8WA4=;
        b=IjAZVNRgHzYr5Ug0TnYxVg8ruHh/uj4tzKgh8FhEU5kHckIT4ra024N38qEQI7vdBG
         zlaFPh37htUEXfYCdsPcyyZbF+3N9TOykE1o+/Cug6aR7iU5D3hcvH/1S+sS1+0gwe3V
         DXzoVv1PLipx81ovlDq1ykqnsUAQwzeuivd4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691103968; x=1691708768;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU2Tak4FV3b6LJpZuOHRxW52FQqMy9yZygFfXqU8WA4=;
        b=WNfrR6Bjc5PG1Sj+lQ3a/AEjNsN3oZ2VmvnonUzCQl+xfZyJS+YtZxCQW5iqzdLZ7F
         dlgR63aldVwTGtWrSDq98HKg1bsWdPVlkh/6O7DOnPBb6h0o0znrWmhwBOKKoSB/CJpt
         UzD1K/eyoW2+55YaJkzufoM1C9IRfaLvZOGmVTRVBkWZQI3OdF0kqP3dhetNPx8jpiHF
         M4a9FYqrBdrbE+hqPvvvz1ypUZb4MGYQ1Mh2uyBOxtdfOslR9KOV2l1OC9q8p1Ly7juw
         TeB4Ro0pE+/FgPdi8X82GcYJmaZWuV9QdHY1u721PSzxsMwB4YSa80B2bqrhfdCwTeHb
         yWOg==
X-Gm-Message-State: AOJu0Yxnbu2pWSHXcxMB8L2edwyscaMHFSyHXuHwyHtvelE/eBOK5JUn
        EE7I0n+PSsJfgwzXrEU3xyzSJg==
X-Google-Smtp-Source: AGHT+IEtv2neeCvvH4oLhLI6dbu5PEfP72RyNnSlb9DcLZIuM+ynhaGQ3O7i30BWnaLbsmDY1xpm/w==
X-Received: by 2002:ac8:5bcc:0:b0:40e:6142:baf with SMTP id b12-20020ac85bcc000000b0040e61420bafmr220686qtb.26.1691103968412;
        Thu, 03 Aug 2023 16:06:08 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.222])
        by smtp.gmail.com with ESMTPSA id js2-20020a05622a808200b003e0945575dasm259736qtb.1.2023.08.03.16.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 16:06:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
Date:   Thu, 3 Aug 2023 19:05:57 -0400
Message-Id: <6B0A9441-5DB5-476B-B94C-F0BDF1505095@joelfernandes.org>
References: <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
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
In-Reply-To: <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
To:     Alan Huang <mmpgouride@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 3, 2023, at 3:26 PM, Alan Huang <mmpgouride@gmail.com> wrote:
>=20
> =EF=BB=BF
>> 2023=E5=B9=B48=E6=9C=884=E6=97=A5 00:01=EF=BC=8CJoel Fernandes <joel@joel=
fernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>> On Thu, Aug 3, 2023 at 9:36=E2=80=AFAM Alan Huang <mmpgouride@gmail.com>=
 wrote:
>>>=20
>>>=20
>>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 =E4=B8=8B=E5=8D=888:35=EF=BC=8CJoel Fe=
rnandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>>=20
>>>>=20
>>>>> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> wrote:
>>>>>=20
>>>>> =EF=BB=BF
>>>>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes (Googl=
e) <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>=20
>>>>>> Add a detailed note to explain the potential side effects of
>>>>>> plain-accessing the gp pointer using a plain load, without using the
>>>>>> rcu_dereference() macros; which might trip neighboring code that does=

>>>>>> use rcu_dereference().
>>>>>>=20
>>>>>> I haven't verified this with a compiler, but this is what I gather fr=
om
>>>>>> the below link using Will's experience with READ_ONCE().
>>>>>>=20
>>>>>> Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the-t=
ruck/
>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>> ---
>>>>>> .../RCU/Design/Requirements/Requirements.rst  | 32 ++++++++++++++++++=
+
>>>>>> 1 file changed, 32 insertions(+)
>>>>>>=20
>>>>>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b=
/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>>> index f3b605285a87..e0b896d3fb9b 100644
>>>>>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference co=
unting
>>>>>> .. |high-quality implementation of C11 memory_order_consume [PDF]| re=
place:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
>>>>>> .. _high-quality implementation of C11 memory_order_consume [PDF]: ht=
tp://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
>>>>>>=20
>>>>>> +Note that, there can be strange side effects (due to compiler optimi=
zations) if
>>>>>> +``gp`` is ever accessed using a plain load (i.e. without ``READ_ONCE=
()`` or
>>>>>> +``rcu_dereference()``) potentially hurting any succeeding
>>>>>> +``rcu_dereference()``. For example, consider the code:
>>>>>> +
>>>>>> +   ::
>>>>>> +
>>>>>> +       1 bool do_something_gp(void)
>>>>>> +       2 {
>>>>>> +       3   void *tmp;
>>>>>> +       4   rcu_read_lock();
>>>>>> +       5   tmp =3D gp; // Plain-load of GP.
>>>>>> +       6   printk("Point gp =3D %p\n", tmp);
>>>>>> +       7
>>>>>> +       8   p =3D rcu_dereference(gp);
>>>>>> +       9   if (p) {
>>>>>> +      10     do_something(p->a, p->b);
>>>>>> +      11     rcu_read_unlock();
>>>>>> +      12     return true;
>>>>>> +      13   }
>>>>>> +      14   rcu_read_unlock();
>>>>>> +      15   return false;
>>>>>> +      16 }
>>>>>> +
>>>>>> +The behavior of plain accesses involved in a data race is non-determ=
inistic in
>>>>>> +the face of compiler optimizations. Since accesses to the ``gp`` poi=
nter is
>>>>>> +by-design a data race, the compiler could trip this code by caching t=
he value
>>>>>> +of ``gp`` into a register in line 5, and then using the value of the=
 register
>>>>>> +to satisfy the load in line 10. Thus it is important to never mix
>>>>>=20
>>>>> Will=E2=80=99s example is:
>>>>>=20
>>>>>  // Assume *ptr is initially 0 and somebody else writes it to 1
>>>>>  // concurrently
>>>>>=20
>>>>>  foo =3D *ptr;
>>>>>  bar =3D READ_ONCE(*ptr);
>>>>>  baz =3D *ptr;
>>>>>=20
>>>>> Then the compiler is within its right to reorder it to:
>>>>>=20
>>>>> foo =3D *ptr;
>>>>> baz =3D *ptr;
>>>>> bar =3D READ_ONCE(*ptr);
>>>>>=20
>>>>> So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is perfectly l=
egal.
>>>>=20
>>>> Yes, a bad outcome is perfectly legal amidst data race. Who said it is n=
ot legal?
>>>=20
>>> My understanding is that it is legal even without data race, and the com=
piler only keeps the order of volatile access.
>>=20
>> Yes, but I can bet on it the author of the code would not have
>> intended such an outcome, if they did then Will wouldn't have been
>> debugging it ;-). That's why I called it a bad outcome. The goal of
>> this patch is to document such a possible unintentional outcome.

Please trim replies if possible.

>>=20
>>>>> But the example here is different,
>>>>=20
>>>> That is intentional. Wills discussion partially triggered this. Though I=
 am wondering
>>>> if we should document that as well.
>>>>=20
>>>>> the compiler can not use the value loaded from line 5
>>>>> unless the compiler can deduce that the tmp is equals to p in which ca=
se the address dependency
>>>>> doesn=E2=80=99t exist anymore.
>>>>>=20
>>>>> What am I missing here?
>>>>=20
>>>> Maybe you are trying to rationalize too much that the sequence mentione=
d cannot result
>>>> in a counter intuitive outcome like I did?
>>>>=20
>>>> The point AFAIU is not just about line 10 but that the compiler can rep=
lace any of the
>>>> lines after the plain access with the cached value.
>>>=20
>>> Well, IIUC, according to the C standard, the compiler can do anything if=
 there is a data race (undefined behavior).
>>>=20
>>> However, what if a write is not protected with WRITE_ONCE and the read i=
s marked with READ_ONCE?
>>> That=E2=80=99s also a data race, right? But the kernel considers it is O=
kay if the write is machine word aligned.
>>=20
>> Yes, but there is a compiler between the HLL code and what the
>> processor sees which can tear the write. How can not using
>> WRITE_ONCE() prevent store-tearing? See [1]. My understanding is that
>> it is OK only if the reader did a NULL check. In that case the torn
>=20
> Yes, a write-write data race where the value is the same is also fine.
>=20
> But they are still data race, if the compiler is within its right to do an=
ything it likes (due to data race),
> we still need WRITE_ONCE() in these cases, though it=E2=80=99s semanticall=
y safe.
>=20
> IIUC, even with _ONCE(), the compiler is within its right do anything acco=
rding to the standard (at least before the upcoming C23), because the standa=
rd doesn=E2=80=99t consider a volatile access to be atomic.
>=20
> However, the kernel consider the volatile access to be atomic, right?
>=20
> BTW, line 5 in the example is likely to be optimized away. And yes, the co=
mpiler can cache the value loaded from line 5 from the perspective of undefi=
ned behavior, even if I believe it would be a compiler bug from the perspect=
ive of kernel.

I am actually a bit lost with what you are trying to say.  Are you saying th=
at mixing
plain accesses with marked accesses is an acceptable practice?=20

I would like others to weight in as well since I am not seeing what Alan is s=
uggesting.
AFAICS, in the absence of barrier(), any optimization caused by plain access=

makes it a bad practice to mix it.

Thanks,

- Joel



>=20
>> result will not change the semantics of the program. But otherwise,
>> that's bad.
>>=20
>> [1] https://lwn.net/Articles/793253/#Store%20Tearing
>>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>>=20
>>>>=20
>>>> Thanks.
>>>>=20
>>>>=20
>>>>=20
>>>>>=20
>>>>>> +plain accesses of a memory location with rcu_dereference() of the sa=
me memory
>>>>>> +location, in code involved in a data race.
>>>>>> +
>>>>>> In short, updaters use rcu_assign_pointer() and readers use
>>>>>> rcu_dereference(), and these two RCU API elements work together to
>>>>>> ensure that readers have a consistent view of newly added data elemen=
ts.
>>>>>> --
>>>>>> 2.41.0.585.gd2178a4bd4-goog
>=20
>=20
