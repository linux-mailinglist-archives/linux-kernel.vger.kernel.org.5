Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5675D5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGUUlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUUlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:41:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913851701;
        Fri, 21 Jul 2023 13:41:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66c729f5618so2078405b3a.1;
        Fri, 21 Jul 2023 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972065; x=1690576865;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImLa8ONPpTHPAqO8VYbOK8F9i8X8tlHTl//QuM3zPjY=;
        b=Vx9Fhnsyrc3oK9hp3v+HvctHzLuvOhBQOG57yfvo8QmcBf1ykueWkegXjq+lMq7mZt
         pSRP03jrH5rz7uFt0Q/BxCnYZQ100wUHxNxK/+9EnEwiKfi9ZiO4Eh+zJuESAXOVQSwt
         x3xuWUQ1idgOhq+gqmXTfEDQ/xNvxSHPQ8EnIu3CgSDWWCHG2TnvKjXNuuOctf8umtNl
         vxecj5cLDJzgrnZx6jxfMX1dOKArXxdYrnDfqoKY0Z20vJ1oKqvymx0x0Yy1hd+zTb3c
         y84O7Up3AfgXI+znt87sOvJN9NmA06VT9tP4hPskwtQCL2s6ddn6m1/3jCXFhKgE5NWC
         ej0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972065; x=1690576865;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImLa8ONPpTHPAqO8VYbOK8F9i8X8tlHTl//QuM3zPjY=;
        b=LvfO+y2sRFmVgTRN74k0Dj83gc528E5K2Mt6i6UwtDqDTtHqgqhWnOqVY0UkQ9mU84
         WecauATVGKVD3ZosUirfHlpCg5ycmSXgrMt44HwuQJzBTfqnzNLioN4VAhhF9xpX38LQ
         iLdNog6BF5wKBd7Uilxry0JYZ7ujY1S7hJxfVb+T5BPcT0MIog7dATQXFdSv/RtoXrcz
         FtxIuGkSyUrv2ZWv5wO3B1CCE7xCD3R1yAQn/52FZeK6rKnQoXgc2Lnoyijsdl/kYep1
         JU6hX5jjyIm4LvUAwlYX5CZh8tl/NmZUmcAMh2B9LVpVuJ+VDEU0wpnUMxBz3B6QMIYa
         idCw==
X-Gm-Message-State: ABy/qLbEbFhi0l50is2mQlMt1vBY6dlppq50mh8UkXghS0qmHs5yjQSM
        Zt1794X2mvkwSWxjDMRjw4M=
X-Google-Smtp-Source: APBJJlFjj7wrah+iAxO7FPtB7Aeqe2vy+dOdV3YVJqt1HZIx3VaBthd8GAObCojao144Xz7I8HBj6g==
X-Received: by 2002:a05:6a20:7fa3:b0:12b:6898:2986 with SMTP id d35-20020a056a207fa300b0012b68982986mr4077347pzj.1.1689972064969;
        Fri, 21 Jul 2023 13:41:04 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id p5-20020a63ab05000000b00563590be25esm3508415pgf.29.2023.07.21.13.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 13:41:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ED9F14A2-533B-471E-9B79-F75CEEE9A216@gmail.com>
Date:   Sat, 22 Jul 2023 04:40:56 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED5C700E-0C63-41E5-8A46-F7BC93B2FD42@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
 <ED9F14A2-533B-471E-9B79-F75CEEE9A216@gmail.com>
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


> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 =E4=B8=8A=E5=8D=884:08=EF=BC=8CAlan =
Huang <mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 =E4=B8=8B=E5=8D=8811:21=EF=BC=8CJoel=
 Fernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On 7/21/23 10:27, Alan Huang wrote:
>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 20:54=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>>=20
>>>>=20
>>>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> =
wrote:
>>>>>=20
>>>>> =EF=BB=BF
>>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>=20
>>>>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of =
first item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>>>>> and a related discussion [1].
>>>>>>>=20
>>>>>>> After reading the whole discussion, it seems like that =
ptr->field was cached by gcc even with the deprecated
>>>>>>> ACCESS_ONCE(), so my question is:
>>>>>>>=20
>>>>>>>     Is that a compiler bug? If so, has this bug been fixed =
today, ten years later?
>>>>>>>=20
>>>>>>>     What about READ_ONCE(ptr->field)?
>>>>>>=20
>>>>>> Make sure sparse is happy.
>>>>>=20
>>>>> It caused a problem without barrier(), and the deprecated =
ACCESS_ONCE() didn=E2=80=99t help:
>>>>>=20
>>>>>  https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>>>=20
>>>>> So, my real question is: With READ_ONCE(ptr->field), are there =
still some unusual cases where gcc
>>>>> decides not to reload ptr->field?
>>>>=20
>>>> I am a bit doubtful there will be strong (any?) interest in =
replacing the barrier() with READ_ONCE() without any tangible reason, =
regardless of whether a gcc issue was fixed.
>>>>=20
>>>> But hey, if you want to float the idea=E2=80=A6
>>> We already had the READ_ONCE() in rcu_deference_raw().
>>> The barrier() here makes me think we need write code like below:
>>> =09
>>> 	READ_ONCE(head->first);
>>> 	barrier();
>>> 	READ_ONCE(head->first);
>>> With READ_ONCE (or the deprecated ACCESS_ONCE),
>>> I don=E2=80=99t think a compiler should cache the value of =
head->first.
>>=20
>>=20
>> Right, it shouldn't need to cache. To Eric's point it might be risky =
to remove the barrier() and someone needs to explain that issue first =
(or IMO there needs to be another tangible reason like performance etc). =
Anyway, FWIW I wrote a simple program and I am not seeing the =
head->first cached with the pattern you shared above:
>>=20
>> #include <stdlib.h>
>>=20
>> #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
>> #define barrier() __asm__ __volatile__("": : :"memory")
>>=20
>> typedef struct list_head {
>>   int first;
>>   struct list_head *next;
>> } list_head;
>>=20
>> int main() {
>>   list_head *head =3D (list_head *)malloc(sizeof(list_head));
>>   head->first =3D 1;
>>   head->next =3D 0;
>>=20
>>   READ_ONCE(head->first);
>>   barrier();
>>   READ_ONCE(head->first);
>>=20
>>   free(head);
>>   return 0;
>> }
>>=20
>> On ARM 32-bit, 64-bit and x86_64, with -Os and then another =
experiment with -O2 on new gcc versions.
>=20
> Well, when I change the code as below:
>=20
> #include <stdlib.h>
>=20
> #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> #define barrier() __asm__ __volatile__("": : :"memory")
>=20
> typedef struct list_head {
>   struct list_head *next;
>   int first;					// difference here
> } list_head;
>=20
> int main() {
>   list_head *head =3D (list_head *)malloc(sizeof(list_head));
>   head->first =3D 1;
>   head->next =3D 0;
>=20
>   READ_ONCE(head->first);
>   READ_ONCE(head->first);
>=20
>   free(head);
>   return 0;
> }
>=20
> GCC 8, GCC 10, GCC 11 generate the following code (with -O2):
>=20
> main:
>        subq    $8, %rsp
>        movl    $16, %edi
>        call    malloc
>        movl    $1, 8(%rax)
>        movq    %rax, %rdi
>        call    free
>        xorl    %eax, %eax
>        addq    $8, %rsp
>        ret
>=20
>=20
> The READ_ONCE has been optimized away. The difference in the source =
code is that I put ->first to the second member.
>=20
> That means, GCC 8, 10, 11 have the bug!
>=20
>=20

Found a related discussion:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102714

Looks like GCC 10, 11 have been backported, not sure whether GCC 8 has =
been backported.

So, I have the following questions:

Given that some people might not update their GCC, do they need to be =
notified?

Do we need to CC Linus?


