Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5E75D685
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGUVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGUVZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:25:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EBC3A97;
        Fri, 21 Jul 2023 14:25:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb81809ca8so367515ad.3;
        Fri, 21 Jul 2023 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689974710; x=1690579510;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTGORxsrxN9RZGG729FMXCa8oJ9OGght7Ge2MF78D6E=;
        b=QWoW73AGyL+cYA1lbcR1wddOXTnugG27xBKAgMhBCbr88SyFmCZlEt+RYpWiheqZi8
         i/KnW9kO/XER3UVk0CUW++nCN1/SuYGSs2DMkXeAb8Zf01KPobvuGZOuhOtYWWrlzn9b
         cvL1gPAEiilUL1IiIxbr5CfkxsuXSFBxLOrftMIeUOgOZbQpUVubp9t+jMWw4ZzJ4YA7
         GH+6S74PP0jL8wNqrZpyuWYze01BBX50Luvf5hfu6U9yryZNnk3zmoHfcis9qhm7oAQL
         3QkLJnmmkObAhz6WiLEUHQfJlXm5P7yL6LBpRlqTncQ0mK7Bz77RRNAbNjV7HS2jIQ4s
         IRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689974710; x=1690579510;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTGORxsrxN9RZGG729FMXCa8oJ9OGght7Ge2MF78D6E=;
        b=gysDeEV/7WZfk9swY0p7aKu4EEtKJgxgxlQnlG+F9XhGvFs7neztDem2JZ7qaKVvG7
         mvYdBTNO95chj/M6eBswYkFeMLnnQdjBCmuV4D3fjiDAe2Q1pAQKAmvD4L2dMxBBiJuY
         xibeJ4No8fJX6Ea5QqIop+YD0sxOe+tZb3blXTzC6U9JHoGkpVCrkps/GSAVwvVS2Pye
         FX8sFY+TNDYIy+f9JsRd/cx0vGOgNeUfuyRSJ11RGZVM+hH1pBWxfOBO/jvNW+PaOogF
         QsD8guS1SPpAv/kqpv0NQ+SbCGte6YLEYoIc2pHroB36CoJl6kUUN/BduUoimInLDNrW
         JYVg==
X-Gm-Message-State: ABy/qLZ41fLkjVGv9oUV2h5J7u8uZrYC2vxR6EOKYStSbVredfsxsRG+
        TwUqnkGJNhfH6Xdj100bkVcloPIVQ3TPtg==
X-Google-Smtp-Source: APBJJlEpJqXCl9FEtpk+Z2mPIi7Fr+gWrcSB3P6dwJ6tsz2QsUmNFJ22BZwIZmkGmRQFGZmVQei2aA==
X-Received: by 2002:a17:903:4285:b0:1b9:db3d:9f22 with SMTP id ju5-20020a170903428500b001b9db3d9f22mr3062056plb.48.1689974710313;
        Fri, 21 Jul 2023 14:25:10 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170902efd500b001b8a3a0c928sm3963820plb.181.2023.07.21.14.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 14:25:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ED5C700E-0C63-41E5-8A46-F7BC93B2FD42@gmail.com>
Date:   Sat, 22 Jul 2023 05:25:02 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25321527-3040-434D-80EC-82DFD17C710C@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
 <ED9F14A2-533B-471E-9B79-F75CEEE9A216@gmail.com>
 <ED5C700E-0C63-41E5-8A46-F7BC93B2FD42@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>, roman.gushchin@linux.dev,
        "David.Laight@aculab.com" <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 =E4=B8=8A=E5=8D=884:40=EF=BC=8CAlan =
Huang <mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 =E4=B8=8A=E5=8D=884:08=EF=BC=8CAlan =
Huang <mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>=20
>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 =E4=B8=8B=E5=8D=8811:21=EF=BC=8CJoe=
l Fernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On 7/21/23 10:27, Alan Huang wrote:
>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 20:54=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> =
wrote:
>>>>>>=20
>>>>>> =EF=BB=BF
>>>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>=20
>>>>>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>>>>>=20
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of =
first item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>>>>>> and a related discussion [1].
>>>>>>>>=20
>>>>>>>> After reading the whole discussion, it seems like that =
ptr->field was cached by gcc even with the deprecated
>>>>>>>> ACCESS_ONCE(), so my question is:
>>>>>>>>=20
>>>>>>>>    Is that a compiler bug? If so, has this bug been fixed =
today, ten years later?
>>>>>>>>=20
>>>>>>>>    What about READ_ONCE(ptr->field)?
>>>>>>>=20
>>>>>>> Make sure sparse is happy.
>>>>>>=20
>>>>>> It caused a problem without barrier(), and the deprecated =
ACCESS_ONCE() didn=E2=80=99t help:
>>>>>>=20
>>>>>> https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>>>>=20
>>>>>> So, my real question is: With READ_ONCE(ptr->field), are there =
still some unusual cases where gcc
>>>>>> decides not to reload ptr->field?
>>>>>=20
>>>>> I am a bit doubtful there will be strong (any?) interest in =
replacing the barrier() with READ_ONCE() without any tangible reason, =
regardless of whether a gcc issue was fixed.
>>>>>=20
>>>>> But hey, if you want to float the idea=E2=80=A6
>>>> We already had the READ_ONCE() in rcu_deference_raw().
>>>> The barrier() here makes me think we need write code like below:
>>>> =09
>>>> 	READ_ONCE(head->first);
>>>> 	barrier();
>>>> 	READ_ONCE(head->first);
>>>> With READ_ONCE (or the deprecated ACCESS_ONCE),
>>>> I don=E2=80=99t think a compiler should cache the value of =
head->first.
>>>=20
>>>=20
>>> Right, it shouldn't need to cache. To Eric's point it might be risky =
to remove the barrier() and someone needs to explain that issue first =
(or IMO there needs to be another tangible reason like performance etc). =
Anyway, FWIW I wrote a simple program and I am not seeing the =
head->first cached with the pattern you shared above:
>>>=20
>>> #include <stdlib.h>
>>>=20
>>> #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
>>> #define barrier() __asm__ __volatile__("": : :"memory")
>>>=20
>>> typedef struct list_head {
>>>  int first;
>>>  struct list_head *next;
>>> } list_head;
>>>=20
>>> int main() {
>>>  list_head *head =3D (list_head *)malloc(sizeof(list_head));
>>>  head->first =3D 1;
>>>  head->next =3D 0;
>>>=20
>>>  READ_ONCE(head->first);
>>>  barrier();
>>>  READ_ONCE(head->first);
>>>=20
>>>  free(head);
>>>  return 0;
>>> }
>>>=20
>>> On ARM 32-bit, 64-bit and x86_64, with -Os and then another =
experiment with -O2 on new gcc versions.
>>=20
>> Well, when I change the code as below:
>>=20
>> #include <stdlib.h>
>>=20
>> #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
>> #define barrier() __asm__ __volatile__("": : :"memory")
>>=20
>> typedef struct list_head {
>>  struct list_head *next;
>>  int first;					// difference here
>> } list_head;
>>=20
>> int main() {
>>  list_head *head =3D (list_head *)malloc(sizeof(list_head));
>>  head->first =3D 1;
>>  head->next =3D 0;
>>=20
>>  READ_ONCE(head->first);
>>  READ_ONCE(head->first);
>>=20
>>  free(head);
>>  return 0;
>> }
>>=20
>> GCC 8, GCC 10, GCC 11 generate the following code (with -O2):
>>=20
>> main:
>>       subq    $8, %rsp
>>       movl    $16, %edi
>>       call    malloc
>>       movl    $1, 8(%rax)
>>       movq    %rax, %rdi
>>       call    free
>>       xorl    %eax, %eax
>>       addq    $8, %rsp
>>       ret
>>=20
>>=20
>> The READ_ONCE has been optimized away. The difference in the source =
code is that I put ->first to the second member.
>>=20
>> That means, GCC 8, 10, 11 have the bug!
>>=20
>>=20
>=20
> Found a related discussion:
>=20
> 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102714

And this:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D47409

So, the compiler had the bug ten years ago.

>=20
> Looks like GCC 10, 11 have been backported, not sure whether GCC 8 has =
been backported.
>=20
> So, I have the following questions:
>=20
> Given that some people might not update their GCC, do they need to be =
notified?
>=20
> Do we need to CC Linus?
>=20
>=20

