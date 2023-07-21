Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C875CCBD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGUPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjGUPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:55:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06403AB0;
        Fri, 21 Jul 2023 08:55:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686708c986so1835723b3a.0;
        Fri, 21 Jul 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954900; x=1690559700;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZxER7TIVhSnV+xmwfN9+r3oqw1Tk9t+HVETN8trMAE=;
        b=g6An1sIieyGlOOXL0byEVOlxStzgXllu0/T3IHHvZl3AOiLqUirmU8/1199okGG8Id
         V406almeeph/BKkxzAq4PljPPSekH/bRwJWwHaEQa/ECD3rrze5dj2zOio2U9nlrpJAx
         NQQmghecokjVtq/pVlCydE5CQk3eDjvgoXEXEVqZ5XzEbMcoq9qA9BP5+qamQCwBBstX
         +PJpabN+2nHM8flz9SW1T6IKoHgpgUlk85Q1cGPxZ5S1efOchFzMNEaThb7RmmQz9yFB
         jWzwR+KgArxD33F7id2ZLpEgc1Rrc1+xTOCm8ye2U/hkA3oS3rRBvJx9rFQwBKflGb/z
         mK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954900; x=1690559700;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZxER7TIVhSnV+xmwfN9+r3oqw1Tk9t+HVETN8trMAE=;
        b=UHe4nU8JrEnfRsOiLp2dl7y5vg+z7poq5DKErv0Sqd+4iT+MS5yW4b7PHw33P8wpUj
         KnXsplfKVoa6dUdI8/h82YX0U1J7jQ3dWvlJ1i+TWK8UM2zWwhneXkk121bckoxfrKYA
         y+gg8Aj8ajYjZR64IOKvX2OahOD99Wi6CpcuyhFKIBJ9mjnm84ARpo+Vo9IkiORZPB+l
         6yG5fF/+JXhFIValIs3LO65X4WB1vhcSJBndNJuRIKSDul2o72k+NjczlMsbZyrfE7Pn
         waFJyZBjfmuoFnsgQRz/fZyS/pnFdtvyl5vCLDu7HyqP82Np7it2yJN4NgghGJZFh0D1
         3U1g==
X-Gm-Message-State: ABy/qLZwr9wd1WK9e9yfo6pJcZiVaajMmB3Y+dbJft9yWnlRBlEhdNWu
        wuAtBHBxa62810KJl+HBXPA=
X-Google-Smtp-Source: APBJJlFJr0PyxT/oCciTOu848MpX3AkcC/p4TwSFmWdXXKpcqAuJF7tp36NbCVrN4CWWBAGfqne3gA==
X-Received: by 2002:a05:6a20:1585:b0:137:2b6f:4307 with SMTP id h5-20020a056a20158500b001372b6f4307mr2994999pzj.27.1689954899988;
        Fri, 21 Jul 2023 08:54:59 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id y8-20020a62b508000000b00663b712bfbdsm3145756pfe.57.2023.07.21.08.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:54:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
Date:   Fri, 21 Jul 2023 23:54:34 +0800
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, roman.gushchin@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D269BDF-102C-46B8-B31C-A559D2E410E0@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 23:21=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 7/21/23 10:27, Alan Huang wrote:
>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 20:54=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>>=20
>>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> =
wrote:
>>>>=20
>>>> =EF=BB=BF
>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
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
>>>>   https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>>=20
>>>> So, my real question is: With READ_ONCE(ptr->field), are there =
still some unusual cases where gcc
>>>> decides not to reload ptr->field?
>>>=20
>>> I am a bit doubtful there will be strong (any?) interest in =
replacing the barrier() with READ_ONCE() without any tangible reason, =
regardless of whether a gcc issue was fixed.
>>>=20
>>> But hey, if you want to float the idea=E2=80=A6
>> We already had the READ_ONCE() in rcu_deference_raw().
>> The barrier() here makes me think we need write code like below:
>>=20
>> READ_ONCE(head->first);
>> barrier();
>> READ_ONCE(head->first);
>> With READ_ONCE (or the deprecated ACCESS_ONCE),
>> I don=E2=80=99t think a compiler should cache the value of =
head->first.
>=20
>=20
> Right, it shouldn't need to cache. To Eric's point it might be risky =
to remove the barrier() and someone needs to explain that issue first =
(or IMO there needs to be another tangible reason like performance etc). =
Anyway, FWIW I wrote a simple program and I am not seeing the =
head->first cached with the pattern you shared above:
>=20
> #include <stdlib.h>
>=20
> #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> #define barrier() __asm__ __volatile__("": : :"memory")
>=20
> typedef struct list_head {
>    int first;
>    struct list_head *next;
> } list_head;
>=20
> int main() {
>    list_head *head =3D (list_head *)malloc(sizeof(list_head));
>    head->first =3D 1;
>    head->next =3D 0;
>=20
>    READ_ONCE(head->first);
>    barrier();

Thanks for your time!

However, what I'm trying to say here is that without this barrier(), GCC =
wouldn't cache this value either.

So, I removed the barrier() and tested, GCC didn=E2=80=99t cache the =
value of head->first.
(Only tested on x86-64 (all the possible versions of gcc that Compiler =
Explorer has) where the original issue occurred [1].)

Therefore, the commit message and the related discussion ten years ago =
is misleading.

Thanks again!

[1] https://lkml.org/lkml/2013/4/16/371


>    READ_ONCE(head->first);
>=20
>    free(head);
>    return 0;
> }
>=20
> On ARM 32-bit, 64-bit and x86_64, with -Os and then another experiment =
with -O2 on new gcc versions.


