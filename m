Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04B75CCED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGUQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGUQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:00:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184612D79
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:00:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76ae0784e0bso34042185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689955229; x=1690560029;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL2Q32PhNXRdScnQT0em97lodS45ZR022eb9UobD11w=;
        b=uyVAkm4gzZW/4vJAsm10ROTMOlhoWqrMqcDR+qVre6Ttr8RjN9V/28wYVq86J6uupX
         iOgcyqyJthPejjx8dqiMTVglx9r3K7xoZSdP7RlvV7OnG7W1zxa5fIj3wOFrTan1eByn
         Vs8zWS7PkE1upMDE/NndWg67YgIBjsrhdIAOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955229; x=1690560029;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL2Q32PhNXRdScnQT0em97lodS45ZR022eb9UobD11w=;
        b=MCPeKrmdsxYKck2iHK/UxcBeG9jAvqvJ/I1gjWuD4eBphVF57NuozyI8t69J/C4Jbl
         9ur/ZybKseLf7AFDCXZ2x0RcFdKqL+aTF26vdjm5pkBwF6iFWLhJf05RhB0J/r90lRq5
         8F7wNGHQWVkoLVv3QWfhMal/NSFKg2INSsBYx+LWH8Qtebtbc1Cq3ACZCVMxsX1UmSl1
         vOWi/Sp1MCxrBAI44joCTzOy+9YQP1XXu6ZLosOiouuMEnvPrNUJlkQtB5Y2eA/4b2lo
         u7F2pFrZgkVWXyD7UiSMPsny76w4IVo1jah5h4mps3vhG9OfVLuGz4v/qF9lMI5lPf+/
         U2NA==
X-Gm-Message-State: ABy/qLbO//wtacUtgwxGxpe43z5h4axBzt7QYPk2/FACFqmmJ8d6tRAU
        fbhsCjCFKSbRXzN+CfmQkW0s4Q==
X-Google-Smtp-Source: APBJJlG3f6Ore0qvAvU7CtWKldN/iuoMI+r8ahFclMMCRNdbBLJSvBrDfqPgbPA17HhquA6Q9rOCRA==
X-Received: by 2002:a05:620a:4501:b0:765:467e:133a with SMTP id t1-20020a05620a450100b00765467e133amr379433qkp.23.1689955229104;
        Fri, 21 Jul 2023 09:00:29 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.68])
        by smtp.gmail.com with ESMTPSA id ow4-20020a05620a820400b007682af2c8aasm1185169qkn.126.2023.07.21.09.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 09:00:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Date:   Fri, 21 Jul 2023 12:00:17 -0400
Message-Id: <8EE165A3-B6C9-4FE7-8C50-F6D75E250B8B@joelfernandes.org>
References: <7D269BDF-102C-46B8-B31C-A559D2E410E0@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, roman.gushchin@linux.dev
In-Reply-To: <7D269BDF-102C-46B8-B31C-A559D2E410E0@gmail.com>
To:     Alan Huang <mmpgouride@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 21, 2023, at 11:55 AM, Alan Huang <mmpgouride@gmail.com> wrote:
>=20
> =EF=BB=BF
>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 23:21=EF=BC=8CJoel Fernandes <joel@joe=
lfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On 7/21/23 10:27, Alan Huang wrote:
>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 20:54=EF=BC=8CJoel Fernandes <joel@j=
oelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>>=20
>>>>=20
>>>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> wrote:
>>>>>=20
>>>>> =EF=BB=BF
>>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet <edumaz=
et@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>=20
>>>>>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang <mmpgouride@gmai=
l.com> wrote:
>>>>>>>>=20
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of fir=
st item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>>>>>> and a related discussion [1].
>>>>>>>>=20
>>>>>>>> After reading the whole discussion, it seems like that ptr->field w=
as cached by gcc even with the deprecated
>>>>>>>> ACCESS_ONCE(), so my question is:
>>>>>>>>=20
>>>>>>>>     Is that a compiler bug? If so, has this bug been fixed today, t=
en years later?
>>>>>>>>=20
>>>>>>>>     What about READ_ONCE(ptr->field)?
>>>>>>>=20
>>>>>>> Make sure sparse is happy.
>>>>>>=20
>>>>>> It caused a problem without barrier(), and the deprecated ACCESS_ONCE=
() didn=E2=80=99t help:
>>>>>>=20
>>>>>>  https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>>>>=20
>>>>>> So, my real question is: With READ_ONCE(ptr->field), are there still s=
ome unusual cases where gcc
>>>>>> decides not to reload ptr->field?
>>>>>=20
>>>>> I am a bit doubtful there will be strong (any?) interest in replacing t=
he barrier() with READ_ONCE() without any tangible reason, regardless of whe=
ther a gcc issue was fixed.
>>>>>=20
>>>>> But hey, if you want to float the idea=E2=80=A6
>>> We already had the READ_ONCE() in rcu_deference_raw().
>>> The barrier() here makes me think we need write code like below:
>>>=20
>>> READ_ONCE(head->first);
>>> barrier();
>>> READ_ONCE(head->first);
>>> With READ_ONCE (or the deprecated ACCESS_ONCE),
>>> I don=E2=80=99t think a compiler should cache the value of head->first.
>>=20
>>=20
>> Right, it shouldn't need to cache. To Eric's point it might be risky to r=
emove the barrier() and someone needs to explain that issue first (or IMO th=
ere needs to be another tangible reason like performance etc). Anyway, FWIW I=
 wrote a simple program and I am not seeing the head->first cached with the p=
attern you shared above:
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
>=20
> Thanks for your time!
>=20
> However, what I'm trying to say here is that without this barrier(), GCC w=
ouldn't cache this value either.
>=20

Yes that is what I tried too, removing the barrier.

Apologies for confusing, the code I shared did have it but I had also tried r=
emoving it.

Thanks,

 - Joel


> So, I removed the barrier() and tested, GCC didn=E2=80=99t cache the value=
 of head->first.
> (Only tested on x86-64 (all the possible versions of gcc that Compiler Exp=
lorer has) where the original issue occurred [1].)
>=20
> Therefore, the commit message and the related discussion ten years ago is m=
isleading.
>=20
> Thanks again!
>=20
> [1] https://lkml.org/lkml/2013/4/16/371
>=20
>=20
>>   READ_ONCE(head->first);
>>=20
>>   free(head);
>>   return 0;
>> }
>>=20
>> On ARM 32-bit, 64-bit and x86_64, with -Os and then another experiment wi=
th -O2 on new gcc versions.
>=20
>=20
