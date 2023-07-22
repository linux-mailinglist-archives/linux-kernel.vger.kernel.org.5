Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4A75DD0B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGVPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:00:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2321999;
        Sat, 22 Jul 2023 08:00:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b895a06484so17703785ad.1;
        Sat, 22 Jul 2023 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690038036; x=1690642836;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5ncd2/FYlQXl3gknimMlFI7PpI0cGxp5I6NZ5Y7HdA=;
        b=L9By1tZdT51hCmdH+qnCO3iGNJzJo8BA5SYDM1YZz1SUPZJQsIA6WvILJzSwc2YE9A
         XgIa88CtNrKlyXwMMrlJ5pO8SjWXdydWAE1F8Lw/L6brPvZDe/DuLMskOqB7J7RXl1m7
         1V76i4eiP6fZ579XAkfpPU7jkSxOI8PBZK4253JhEbzSCZBXoygEtOXViY1w1a0M8g9B
         DM137/2sBGNhaYyqjB1aWAi9QYQi8GHFhz/GlgNO4RLN01DkUf00l5NoU96hwlAraogG
         oPA9grrsApXZZQlYYutq1M04Dwg2a86Kpg35NHFmhldqC+s3ArjOic3l5LHKBBq1Rayr
         dDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690038036; x=1690642836;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5ncd2/FYlQXl3gknimMlFI7PpI0cGxp5I6NZ5Y7HdA=;
        b=OLLhtuUySVfqO9hBbWAUd/BOBQl8EdbbgSFtsOZ8H/wBw3Ak90NQr0bRXpPRyJ6KXu
         87S9QXcbMqpDAZuthbn3Kp8AZotrwD3TM93UrqHC2dmT0Xtq8zIQpElZh8FR7IJ1mWeO
         A1oD6bEzzMnB2EVAmVs9TMXyMVeYj09Jl1oTKg84h9pauqcvZmge8Go5c8b3NifGmSse
         0b9WrutYyyPw940EWEnzmcN77nf0BhKdjLWBxwIDVnyi0K+6uxDQxmyiRhcg8RuDxMnm
         5h/Z9noBXD8GD+feiyIShlRv2VRAqqLS47P1Bg0tdpJRSkdpR7oq8PNdAbgeq03B1PV1
         87jg==
X-Gm-Message-State: ABy/qLb4lvlOkNhIsAbmIbdKc2jOl0JmL0V5o1mPcMQHkog/DXCKIq2X
        balDu01A0QNRiHAU6LJdS5w=
X-Google-Smtp-Source: APBJJlGB32DeYkZGjAgUQzkgfP2HLV5uPfInt0sXrdM/oeZ2D89nZVdHfPKFKqLffAtbIXjA0G0M+Q==
X-Received: by 2002:a17:903:2349:b0:1b7:f611:a66b with SMTP id c9-20020a170903234900b001b7f611a66bmr4836866plh.31.1690038035837;
        Sat, 22 Jul 2023 08:00:35 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902a70400b001aaf2e8b1eesm5449520plq.248.2023.07.22.08.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jul 2023 08:00:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <8e1885b62d124cca9198ff6cdb52c7f5@AcuMS.aculab.com>
Date:   Sat, 22 Jul 2023 23:00:18 +0800
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04197578-4FD6-48B7-A132-2A8539E35E56@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
 <ED9F14A2-533B-471E-9B79-F75CEEE9A216@gmail.com>
 <ED5C700E-0C63-41E5-8A46-F7BC93B2FD42@gmail.com>
 <76552616-5DF1-4A05-BA5A-AE0677F861FC@gmail.com>
 <8e1885b62d124cca9198ff6cdb52c7f5@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
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


> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 22:06=EF=BC=8CDavid Laight =
<David.Laight@ACULAB.COM> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ....
>>> Found a related discussion:
>>>=20
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102714
>>>=20
>>> Looks like GCC 10, 11 have been backported, not sure whether GCC 8 =
has been backported.
>>>=20
>>> So, I have the following questions:
>>>=20
>>> Given that some people might not update their GCC, do they need to =
be notified?
>>>=20
>>> Do we need to CC Linus?
>>=20
>> No need.
>>=20
>> I put the following code into a kernel module:
>>=20
>> typedef struct list_head_shit {
>> int next;
>> struct list_head *first;
>> } list_head_shit;
>>=20
>> static void noinline so_shit(void) {
>> list_head_shit *head =3D (list_head_shit =
*)kmalloc(sizeof(list_head_shit), GFP_KERNEL);
>> head->first =3D 0;
>> head->next =3D 1;
>>=20
>> READ_ONCE(head->first);
>> READ_ONCE(head->first);
>>=20
>> kfree(head);
>> }
>>=20
>> x86_64-linux-gnu-gcc-11 generate the following code:
>>=20
>> 0000000000000000 <so_shit>:
>>   0: 48 8b 3d 00 00 00 00 mov    0x0(%rip),%rdi        # 7 =
<so_shit+0x7>
>>   7: ba 10 00 00 00        mov    $0x10,%edx
>>   c: be c0 0c 00 00       mov    $0xcc0,%esi
>>  11: e8 00 00 00 00       call   16 <so_shit+0x16>
>>  16: 48 c7 40 08 00 00 00 movq   $0x0,0x8(%rax)
>>  1d: 00
>>  1e: 48 89 c7              mov    %rax,%rdi
>>  21: c7 00 01 00 00 00     movl   $0x1,(%rax)
>>  27: 48 8b 47 08           mov    0x8(%rdi),%rax  # READ_ONCE here
>>  2b: 48 8b 47 08           mov    0x8(%rdi),%rax  # READ_ONCE here
>>  2f: e9 00 00 00 00       jmp    34 <so_shit+0x34>
>>  34: 66 66 2e 0f 1f 84 00 data16 cs nopw 0x0(%rax,%rax,1)
>>  3b: 00 00 00 00
>>  3f: 90                    nop
>>=20
>> The conclusion is that we can rely on READ_ONCE when writing kernel =
code.
>>=20
>> The kernel=E2=80=99s READ_ONCE is different with the one Joel wrote =
yesterday. (Joel=E2=80=99s is the same as the old
>> ACCESS_ONCE)
>=20
> You do need to reproduce the error with code that looks like
> the loop in the (old) udp.c code.
>=20
> Then see if changing the implementation of READ_ONCE() from
> a simple 'volatile' access the newer variant makes a difference.
>=20
> You also need to check with the oldest version of gcc that is
> still supported - that is much older than gcc 11.
>=20
> In the udp code the volatile access was on a pointer (which should
> qualify as a scaler type) so it may well be the inlining bug you
> mentioned earlier, not the 'volatile on non-scaler' feature that
> READ_ONCE() fixed.
> That fix hasn't been back-ported to all the versions of gcc
> that the kernel build supports.

Well, the same compiler, the kernel=E2=80=99s READ_ONCE:

static int noinline foo(int a, int b, int c) {
	b =3D a + 1;
	c =3D READ_ONCE(b) + 1;
	a =3D c + 1;
	return a;
}

0000000000000040 <foo.constprop.0>:
  40:	b8 04 00 00 00       	mov    $0x4,%eax
  45:	c3                   		ret

Example from:

	=
https://stackoverflow.com/questions/70380510/non-conforming-optimizations-=
of-volatile-in-gcc-11-1

Change the code to:

static int noinline foo(int a, volatile int b, int c) {
	b =3D a + 1;
	c =3D b + 1;
	a =3D c + 1;
	return a;
}

Doesn=E2=80=99t help.

BTW, Clang works fine, even the function is inlined.

>=20
> David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, =
MK1 1PT, UK
> Registration No: 1397386 (Wales)

