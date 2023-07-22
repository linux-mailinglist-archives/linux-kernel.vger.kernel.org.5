Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0419475DCC6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGVNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 09:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGVNc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 09:32:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C84E47;
        Sat, 22 Jul 2023 06:32:55 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34896a1574dso15497425ab.0;
        Sat, 22 Jul 2023 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690032775; x=1690637575;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFVDXv2D7sWZUmHyufFhaQUMrCjeUslkjY6PdPoGRZY=;
        b=qpvC1AsbeQA4qlCRCXiCYE7Joe9UruOopossHc3u+yEqozc8gWZozjh/A3px2Isnt3
         tVmu8v4qrgqBmTYIWoyk8cpSEjiLetHkon6A5Joch0lKEyyDeT2ObBmJKOUFRL3y3uCf
         GTMvnEr8hiEQIJMh9osGdtBX6jhaeD9Lfn/JhYtaBed7Nb308/sppEhJqGSWhNbe205s
         xPfxQqmnKHMleL8aQfM4EF+UujsBJSMjAoWJh4vPOJy+HuTVwPZIRozbMF74cq7jxQDs
         vzTroff42sdn8JSwgwU2gLopKjr+3VRckxIEU9dCB64TGt9Tc02t/LKCSE/TFtdErVCt
         ZHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690032775; x=1690637575;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFVDXv2D7sWZUmHyufFhaQUMrCjeUslkjY6PdPoGRZY=;
        b=kyyuSmUWkZzm0a1QkUcn0WNmq3rbtMP1Ihlpb+KtXDtExgBFi4BULNu/Qzjy1RAbdG
         AqKli4SvajC8kW9FQBUeQqBHYpJc13sYtoOHAYk1PFHrtZ76Fe9fnFWwWjroBgMXQ0tU
         EtrtAoeENZDZq86ks4UXyjRAu6MpPsjhePsSIpr59YTObN+AYl6EfObq64Jyd54nDzzu
         Ozdx1GqhDtMyTOQD4lfDnPtUnr/2RpXOurBnrGlmX4iYne19+mhfjm4Tnf0VhLIN3J60
         GDkwRCu8sJ+eo2zUcAPPnfSmAF7z9HWS4ySsTJaIelayB66XEpprCXUDjCKLJIoANGD4
         DLYA==
X-Gm-Message-State: ABy/qLb1m18/OxLKgqz75oNQAdQso4yXpbBjsVwe0gXrGNjZ+MAPxvO/
        A5vEX5FdcQZv9In6oP0vSpw=
X-Google-Smtp-Source: APBJJlEro5jXuQX2hLCT7E7OXdctLY8DI+WNw7E3sXmUsmNVrDB8kc5at7gpUyWt9NcEP+3isQNngw==
X-Received: by 2002:a92:cacb:0:b0:348:7d72:86f4 with SMTP id m11-20020a92cacb000000b003487d7286f4mr2368411ilq.31.1690032774076;
        Sat, 22 Jul 2023 06:32:54 -0700 (PDT)
Received: from smtpclient.apple ([111.0.233.213])
        by smtp.gmail.com with ESMTPSA id b26-20020a63a11a000000b00563962dbc70sm1406674pgf.58.2023.07.22.06.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jul 2023 06:32:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ED5C700E-0C63-41E5-8A46-F7BC93B2FD42@gmail.com>
Date:   Sat, 22 Jul 2023 21:32:01 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <76552616-5DF1-4A05-BA5A-AE0677F861FC@gmail.com>
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
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 04:40=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
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
>>>>=20
>>>> READ_ONCE(head->first);
>>>> barrier();
>>>> READ_ONCE(head->first);
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
>>  int first; // difference here
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
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102714
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

No need.

I put the following code into a kernel module:

typedef struct list_head_shit {
	int next;
	struct list_head *first;
} list_head_shit;

static void noinline so_shit(void) {
	list_head_shit *head =3D (list_head_shit =
*)kmalloc(sizeof(list_head_shit), GFP_KERNEL);
	head->first =3D 0;
	head->next =3D 1;

	READ_ONCE(head->first);
	READ_ONCE(head->first);

	kfree(head);
}

x86_64-linux-gnu-gcc-11 generate the following code:

0000000000000000 <so_shit>:
   0:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 7 =
<so_shit+0x7>
   7:	ba 10 00 00 00       		mov    $0x10,%edx
   c:	be c0 0c 00 00      	 	mov    $0xcc0,%esi
  11:	e8 00 00 00 00      	 	call   16 <so_shit+0x16>
  16:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1d:	00
  1e:	48 89 c7             		mov    %rax,%rdi
  21:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  27:	48 8b 47 08          		mov    0x8(%rdi),%rax	  # =
READ_ONCE here
  2b:	48 8b 47 08          		mov    0x8(%rdi),%rax	  # =
READ_ONCE here
  2f:	e9 00 00 00 00      	 	jmp    34 <so_shit+0x34>
  34:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  3b:	00 00 00 00
  3f:	90                   			nop

The conclusion is that we can rely on READ_ONCE when writing kernel =
code.

The kernel=E2=80=99s READ_ONCE is different with the one Joel wrote =
yesterday. (Joel=E2=80=99s is the same as the old ACCESS_ONCE)=20

The compiler does have the bug when using simple volatile access:

	https://lwn.net/Articles/624126/

The C standard before the upcoming C23 only says accessing volatile =
object,=20
So I think volatile access (_ONCE) is implemented differently by GCC, =
that=E2=80=99s why the simple ACCESS_ONCE didn=E2=80=99t work.

With the upcoming C23, they will have the same side effect (Section =
5.1.2.3):

	https://open-std.org/JTC1/SC22/WG14/www/docs/n3096.pdf

I think we can remove the barrier() now. :)

Thanks,
Alan


