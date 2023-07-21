Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026F375D55A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGUUJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:09:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034EC358B;
        Fri, 21 Jul 2023 13:09:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ecf9a081so2025122b3a.2;
        Fri, 21 Jul 2023 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689970166; x=1690574966;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glItj7+G0Uf+3TXCFD17x/kcBvbeMtBhJY/eSR1CNg8=;
        b=F5SBeoRg0yQXOOTgi8JzCY7ajdswQJQM3//eXk6gOsCETEEw1MkcDLZD9DZApf7hoV
         9n43fwmBtFCvM4PtEtYQW4gQfQHLn0ou+2ABvGCKSSxrFFxM/JVM7hN94LleB700NKhq
         fySLbhbkmjIlOUpFI5EEMs0tL1JLbp+WGI+0k5axp8OArlIoLpDlqtoyIpyLtQ9xbBEX
         ZJPji8OLVYhp66Htpwis0kkzzv2M+TbhS+YVt+jo01xM/+YQrjoAyKe0cGSpzloI4fM/
         BXgmqbLF96a6FfDMSpokTwha2FyrkNRBUAA9ODRK3fBe8krjRf2CNz4YMZipZXMLhbmY
         QQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970166; x=1690574966;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glItj7+G0Uf+3TXCFD17x/kcBvbeMtBhJY/eSR1CNg8=;
        b=dCz5iLkenDpL2C/oznl6b33Z8fb95J87aPVeCH9zkNHpV0Ba36/if6l1XQUBvnWnuS
         CxLBLfo17Lihv2idgbGgZjDaCVN33wjgivExBfnvznn/R20YFbp48MRhQGyelCwkKr6I
         oypqYxhkLfP7736cUiqZtS5aoxI3/wvXpor5N4J4x8OCnFxhpKiH/rU8X73t9t4Kzktv
         OFIR+EImJ7IG6O6ZJmPt+ZFic9VSmpSxClojZ2f+pgBPc2oRf9mOeLDztnjWMSMVsqF7
         VpWQFU+ysaeTFoVCbTf7garHOLGPdclpoFFbEYZtgcHfs7n2yQ6mCJ92o/bC9V8zsbkA
         iUHg==
X-Gm-Message-State: ABy/qLaXwB9llL5r6/3qH4i/evDKtoc1weYz1GUvbaqZklJjJzP/1Vt7
        p+f9NUj25stgHZSHo7gd7N8=
X-Google-Smtp-Source: APBJJlGKTX4UhpIb6FRkaYN/QI0HITHIvnGgmCBNIyTGFe0VXQ/Hj+tRjrMvpgLWCWTx/Ei8iUOssA==
X-Received: by 2002:a05:6a20:429b:b0:133:21c3:115e with SMTP id o27-20020a056a20429b00b0013321c3115emr3787192pzj.48.1689970166387;
        Fri, 21 Jul 2023 13:09:26 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id z129-20020a633387000000b005633c9493d0sm3482557pgz.21.2023.07.21.13.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 13:09:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
Date:   Sat, 22 Jul 2023 04:08:15 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED9F14A2-533B-471E-9B79-F75CEEE9A216@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>, roman.gushchin@linux.dev,
        "David.Laight@aculab.com" <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 =E4=B8=8B=E5=8D=8811:21=EF=BC=8CJoel =
Fernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
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
>> =09
>> 	READ_ONCE(head->first);
>> 	barrier();
>> 	READ_ONCE(head->first);
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
>    READ_ONCE(head->first);
>=20
>    free(head);
>    return 0;
> }
>=20
> On ARM 32-bit, 64-bit and x86_64, with -Os and then another experiment =
with -O2 on new gcc versions.

Well, when I change the code as below:

#include <stdlib.h>

#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
#define barrier() __asm__ __volatile__("": : :"memory")

typedef struct list_head {
   struct list_head *next;
   int first;					// difference here
} list_head;

int main() {
   list_head *head =3D (list_head *)malloc(sizeof(list_head));
   head->first =3D 1;
   head->next =3D 0;

   READ_ONCE(head->first);
   READ_ONCE(head->first);

   free(head);
   return 0;
}

GCC 8, GCC 10, GCC 11 generate the following code (with -O2):

main:
        subq    $8, %rsp
        movl    $16, %edi
        call    malloc
        movl    $1, 8(%rax)
        movq    %rax, %rdi
        call    free
        xorl    %eax, %eax
        addq    $8, %rsp
        ret


The READ_ONCE has been optimized away. The difference in the source code =
is that I put ->first to the second member.

That means, GCC 8, 10, 11 have the bug!




