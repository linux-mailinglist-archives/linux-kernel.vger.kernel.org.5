Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9047668B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjG1JYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjG1JYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:24:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78D5FC8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:18:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bba48b0bd2so11811785ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690535914; x=1691140714;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFOZyw3a4L5HDpaA5qBNM92wxfMAQCZQe31PNW7OG8k=;
        b=M9AXIZhBJnnJFIAmSai/pU6RNLtgItUBNQAsss/sK4l2Qb7wL7SATBVSQ8PXHeyAp6
         5s+ZI8PnMXqAhLEaTu/GmO7rvl1BPGD2ndIzGmMfyqYew7ERn4mYFmMlMIaI8ey+/MRE
         GXh8XHATUadfihQJ2RXHtkZ4o0SXyzJNIq0V5H0AgE1kXziuLTd9C7J7Nl73VZalsYx8
         YUHccYOKQEuq49MF55S6Kb892nlc916xQT/Td9hfbPl2Qto0DNz2dlhHB6OzCCzL03Bs
         CT7OFhuDrIqRWkBDiOq2KfRLJ27yyzSQPn6iBt32ArP327+ByI2lEPUKWmFQIZHeRDmL
         X3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690535914; x=1691140714;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFOZyw3a4L5HDpaA5qBNM92wxfMAQCZQe31PNW7OG8k=;
        b=S8F5k9JMp9Ot38hhs+3ICly++YM3MrN6pdQ9fV53jqkRXOKYHYS+vVNpeTYcSm8kEC
         N+mprspZEAkBaMEFowCOyndLZygj4AzNDf+5ZRSu2bkTmqERy123zZEh5qC5fhQnN7wy
         tD4q2CmMJQKXdqQrFlUdxGBoDUErTU5XZJ+FQc4E4xs+pl5ib1HhhZSViSOQ9nf6R0Ay
         ts1LWfKxRQn3oqFtotMqxIhh3e+ahsg6Cn9gwcw283i0F7GREAmgI6fXYhQl1LkIZs9w
         ty3hLl11c9WiFB/GytO8emm89eoDJKPMdFWIvQ+7GqHKRf/kjv1Nynk9fkvB9LVjSSpY
         wOUA==
X-Gm-Message-State: ABy/qLabokDgpBgpPgwen/1/zv75oPBCVnY0Av3MgoJDT28WhBVsj8j5
        CzrHLF4HDhbG5TWxWCsR0G8=
X-Google-Smtp-Source: APBJJlE5RdvllvafPXrjpTA1Byjxa4qJYRrOHFSP9A+OKUt8z2E88KMZkT7kc+DDs/LkT6Og/TpUEg==
X-Received: by 2002:a17:903:495:b0:1b7:f99f:63c9 with SMTP id jj21-20020a170903049500b001b7f99f63c9mr887490plb.67.1690535913905;
        Fri, 28 Jul 2023 02:18:33 -0700 (PDT)
Received: from smtpclient.apple (c-73-162-233-46.hsd1.ca.comcast.net. [73.162.233.46])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b864add154sm3088956pld.154.2023.07.28.02.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:18:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <2229115A-23F2-4B6B-800C-7182199DF79D@gmail.com>
Date:   Fri, 28 Jul 2023 02:18:20 -0700
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <802750CF-1C45-4F10-920A-CE7C55DBF3B2@gmail.com>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
 <8EA729DD-F1CE-4C6F-A074-147A6A1BBCE0@gmail.com>
 <CAHk-=wgeMOvL=ko_eruf5St7h0e9dVn4+GMKjcdshTJoxyD8tw@mail.gmail.com>
 <2229115A-23F2-4B6B-800C-7182199DF79D@gmail.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2023, at 1:11 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>=20
>=20
>> On Jul 27, 2023, at 12:39 PM, Linus Torvalds =
<torvalds@linuxfoundation.org> wrote:
>>=20
>> On Thu, 27 Jul 2023 at 12:10, Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>>=20
>>> Interesting. I wonder if you considered adding to READ_ONCE() =
something
>>> like:
>>>=20
>>>       asm volatile("" : "+g" (x) );
>>>=20
>>> So later loads (such as baz =3D *ptr) would reload the updated =
value.
>>=20
>> Not necessarily a bad idea.  Although I suspect you'd want to add
>> *two* of them - on either side - to make sure any previous loads
>> wouldn't be moved around it either.
>=20
> You are right, two are needed.
>=20
> I=E2=80=99ll give it a shot and see if I see changes to the binary.

Just for the record (so nobody will make my mistakes):

I implemented it, but it works poorly. It appears to communicate the
constraints but the generated code is much worse.

The problem is that if the GCC inline asm decides to use a memory =
operand
(e.g. =E2=80=9C+m=E2=80=9D), it computes the address (uses LEA first =
before the MOV) and
allocates a register for the address. Using =E2=80=9C+g=E2=80=9D also =
causes the compiler
to allocate a register.

-- >8 --

---
 include/asm-generic/rwonce.h | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e982..c6a2f8e3013c 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -44,10 +44,34 @@
 #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) =
*)&(x))
 #endif
=20
-#define READ_ONCE(x)							=
\
-({									=
\
-	compiletime_assert_rwonce_type(x);				=
\
-	__READ_ONCE(x);							=
\
+#define as_scalar(x)							=
\
+    __builtin_choose_expr(sizeof(x) =3D=3D sizeof(char),  			=
\
+				(__force char *)&(x), 			=
\
+    __builtin_choose_expr(sizeof(x) =3D=3D sizeof(short),			=
\
+				(__force short *)&(x),			=
\
+    __builtin_choose_expr(sizeof(x) =3D=3D sizeof(int),			=
\
+				(__force int *)&(x), 			=
\
+    __builtin_choose_expr(sizeof(x) =3D=3D sizeof(long),			=
\
+				(__force long *)&(x),			=
\
+    __builtin_choose_expr(sizeof(x) =3D=3D sizeof(long long),		=
\
+				(__force long long *)&(x),		=
\
+    (void*)0)))))
+
+#define READ_ONCE(x)                                                    =
\
+({                                                                      =
\
+    typeof(x) * px =3D &(x);						=
\
+    union {								=
\
+        typeof(x) __orig;						=
\
+        typeof(*as_scalar(x)) __alias;					=
\
+    } __u;								=
\
+									=
\
+    compiletime_assert_rwonce_type(x);					=
\
+    asm volatile ("" :							=
\
+               "+g" (*(__force typeof(*as_scalar(x)) *)(px)));		=
\
+    __u.__alias =3D __READ_ONCE(*as_scalar(*px));				=
\
+    asm volatile ("" :							=
\
+               "+g" (*(__force typeof(*as_scalar(x)) *)(px)));		=
\
+    __u.__orig;								=
\
 })
=20
 #define __WRITE_ONCE(x, val)						=
\
--=20
2.34.1


