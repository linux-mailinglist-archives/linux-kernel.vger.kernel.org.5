Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1775CB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGUPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGUPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:22:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63A4211;
        Fri, 21 Jul 2023 08:22:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687446eaccso1815031b3a.3;
        Fri, 21 Jul 2023 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689952931; x=1690557731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b96Yds/aQ6m9sjATDOT3D72vDFAPpeGAK4iIlmZPEk=;
        b=CrFonG/fTjyuXUYCQTKQkLaHl8mVRCTCI2whp+UEAK29c6jgKRukIEAMFnBUSAIlx0
         MkEDf8Lk3wlhq5FSwQJo4M4zSRpPlU5HAXnFPbvhoSZIaNIx9/RLC6bIqmA546ktD+0F
         s4NVIJWob9X3aH+cOKiOIePaYe6hpInNMR2rNtolODf/TZpdRmB+sWvvQzq9igQIzwP/
         KNFhHbvrxry6n+yuC8sjzZ47vRJ/ASey849KytOpkqKdR482fN9Di4ZIsLlvFGguhq37
         I641beAmzO9awfza7S0fy9ALfnV19qGg2xYWs3kgrjl9qaK7sDkRZmA41SGLsekvGZl7
         QZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952931; x=1690557731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b96Yds/aQ6m9sjATDOT3D72vDFAPpeGAK4iIlmZPEk=;
        b=NWJZV7jk24lQp9mKjwZdcxIF/yG+pHA3a8Bg6HGE2mBXpvZuu0l7B/6a0q5JAlgt1E
         CL3lxstFOlUZov13W+6xjMP6owLiw7GqSB6IDk2psxEkC/aAutqcL/qaBXtSdi/sNdaE
         MNvW9i/4dRNRp+fgwHHaIHH8IbYOBewOQEiMTwGI/TbO60gntjbthxHx3u87dvrMseeZ
         RK0rq7st2Occ5GsftUFBVU1K9FCG3AwUAycBwwmt0Fi1E5TNhc6/Um6DwxZzDWrW6MEk
         C4cX2LDqy5hkYAZ4ty2me9A9Y+XvP6LN04Qe2MtJ5VaYPwQFww3GmfireIoQGYc3KAQP
         pyLA==
X-Gm-Message-State: ABy/qLaU7z34FcDQA46LqGVHHP5WlIdD8qyQOrgFSrfsPIVXpPLZp7Z+
        k9YIkzbYX3/QzNjJBvbvgHg=
X-Google-Smtp-Source: APBJJlHwDiwChgFArU+ABqubLCi+ve9YBR306/8gDwMIMwIBPOtJ2y2iWH+l1a2Ut87X0+sEXkvssg==
X-Received: by 2002:a05:6a20:1614:b0:132:f61e:7d41 with SMTP id l20-20020a056a20161400b00132f61e7d41mr2596615pzj.5.1689952931435;
        Fri, 21 Jul 2023 08:22:11 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b0068288aaf23esm3118541pfa.100.2023.07.21.08.22.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:22:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CANn89iL47bu8bWu2EziK2gCJDBDb4Z5LAZJt1xhb_jQMaieG-g@mail.gmail.com>
Date:   Fri, 21 Jul 2023 23:21:51 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E722F06F-FB78-4566-B5BD-754C1F6BD641@gmail.com>
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
 <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
 <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <CANn89iLqU=huOuCt2kXmrXf68TUU-N90aQnMykkYcZ+Arx9-aA@mail.gmail.com>
 <EDE1C0AE-B479-49F9-995D-DA9CC1A6EA57@gmail.com>
 <CANn89iL47bu8bWu2EziK2gCJDBDb4Z5LAZJt1xhb_jQMaieG-g@mail.gmail.com>
To:     Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 22:47=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 21, 2023 at 4:31=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>>=20
>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 05:11=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Thu, Jul 20, 2023 at 10:00=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>=20
>>>>=20
>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of =
first item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>>>> and a related discussion [1].
>>>>>>=20
>>>>>> After reading the whole discussion, it seems like that ptr->field =
was cached by gcc even with the deprecated
>>>>>> ACCESS_ONCE(), so my question is:
>>>>>>=20
>>>>>>      Is that a compiler bug? If so, has this bug been fixed =
today, ten years later?
>>>>>>=20
>>>>>>      What about READ_ONCE(ptr->field)?
>>>>>=20
>>>>> Make sure sparse is happy.
>>>>=20
>>>> It caused a problem without barrier(), and the deprecated =
ACCESS_ONCE() didn=E2=80=99t help:
>>>>=20
>>>>       https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>>=20
>>>> So, my real question is: With READ_ONCE(ptr->field), are there =
still some unusual cases where gcc
>>>> decides not to reload ptr->field?
>>>=20
>>> I can not really answer without seeing an actual patch...
>>=20
>> The content of the potential patch:
>>=20
>> diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
>> index 89186c499dd4..bcd39670f359 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -158,15 +158,9 @@ static inline void hlist_nulls_add_fake(struct =
hlist_nulls_node *n)
>>  * @pos:       the &struct hlist_nulls_node to use as a loop cursor.
>>  * @head:      the head of the list.
>>  * @member:    the name of the hlist_nulls_node within the struct.
>> - *
>> - * The barrier() is needed to make sure compiler doesn't cache first =
element [1],
>> - * as this loop can be restarted [2]
>> - * [1] Documentation/memory-barriers.txt around line 1533
>> - * [2] Documentation/RCU/rculist_nulls.rst around line 146
>>  */
>> #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)       =
                 \
>> -       for (({barrier();}),                                          =
          \
>> -            pos =3D =
rcu_dereference_raw(hlist_nulls_first_rcu(head));            \
>> +       for (pos =3D =
rcu_dereference_raw(hlist_nulls_first_rcu(head));            \
>>                (!is_a_nulls(pos)) &&                                  =
         \
>>                ({ tpos =3D hlist_nulls_entry(pos, typeof(*tpos), =
member); 1; }); \
>>                pos =3D =
rcu_dereference_raw(hlist_nulls_next_rcu(pos)))
>> @@ -180,8 +174,7 @@ static inline void hlist_nulls_add_fake(struct =
hlist_nulls_node *n)
>>  * @member:    the name of the hlist_nulls_node within the struct.
>>  */
>> #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)      =
         \
>> -       for (({barrier();}),                                          =
          \
>> -            pos =3D =
rcu_dereference_raw(hlist_nulls_first_rcu(head));            \
>> +       for (pos =3D =
rcu_dereference_raw(hlist_nulls_first_rcu(head));            \
>>                (!is_a_nulls(pos)) &&                                  =
         \
>>                ({ tpos =3D hlist_nulls_entry(pos, typeof(*tpos), =
member);        \
>>                   pos =3D =
rcu_dereference_raw(hlist_nulls_next_rcu(pos)); 1; });)
>>=20
>>=20
>>>=20
>>> Why are you asking ? Are you tracking compiler bug fixes ?
>>=20
>> The barrier() here makes me confused.
>>=20
>> If we really need that, do we need:
>>=20
>>        READ_ONCE(head->first);
>>        barrier();
>>        READ_ONCE(head->first);
>>=20
>=20
> Nope, the patch you want to revert (while it did fix (by pure luck
> ???) a real bug back in the days) was replacing
>=20
> ACCESS_ONCE()
>=20
> by
>=20
> barrier();
> ACCESS_ONCE();

Yeah.

The commit message and related discussions all indicate
that the compiler cached a value accessed through volatile.

That=E2=80=99s why I asked here.

>=20
> (There is one ACCESS_ONCE(), not two of them)
>=20
> BTW,
>  barrier();
>  followed by an arbitrary number of barrier(); back to back,
> translates to one barrier()
>=20
> Frankly, I would not change the code, unless someone can explain what
> was the issue.
> (Perhaps there was a missing barrier elsewhere)

Fair enough, although I feel like this is masking the real issue.

(I feel like no one will know the real issue ten years later, when no =
one knew it ten years ago.)

Anyway, thanks for your time.




