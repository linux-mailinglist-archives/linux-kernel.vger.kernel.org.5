Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0975CA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGUObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGUObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:31:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98B92D51;
        Fri, 21 Jul 2023 07:31:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5577900c06bso1358243a12.2;
        Fri, 21 Jul 2023 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689949889; x=1690554689;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq7yoJPxdCpRcPNPemoFiyQn39JZwO5mSUTsStV/p0s=;
        b=HmWJMVpBx+a8gA5lztX8VEHw8K7zNgC8/Kx97dGfQSuyT2eB/oSiGX9rIagVyAx8x5
         0gne7LKRZKARdM7mJKC4eobhCD11Z/D2weZS2whTOaGvamJpm1CuEjlBbG9xwkK+uGZS
         wQ6/wsiUnQZ3kZLdXfzf2tbvD0+yC4Fo1jqrNd4PsUPu/SSfeEe9qIUDeAN1aR3kew7L
         lpBsZJTWt0gxveBbpKFBNel5BIRCEIBId+Hs13i1cphFCB7x44vdIkoG2/s2VZuuGs0r
         CMc2dJUq1FptUXFJkjInRYPNqFvoU08wAEssjlE1ekbb9Ko9xSr5rXrUqmuvIypyTtIe
         mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949889; x=1690554689;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq7yoJPxdCpRcPNPemoFiyQn39JZwO5mSUTsStV/p0s=;
        b=A0kCDqX6QSSNb1aaGovghfaFpbWR7t9QXkqyyry0XYj4gWF6krwYiXZoMrOG011orm
         FtgcjCrUt0Dgw6H3zL9JsZDNS1OeWf/xmREEi3NYNjmn0Of/7sr3l97Bqcdf7wZs1NyY
         7dqUO7MlH/GmVDBzc5PA0tApzSASV47y7P4Gy+CUvEemfKuCgvgLh/7DPbUqTh64WtzK
         tcrRpKhPYAk17tem5Ck7SScwnVwjIZTNk9GUG6I32msGnX+PcuUaeWIsFcsoIFPR1oUF
         yti1N3U42eOc2V28j7vCuuGmJ0Mdila8b8e+3pRCkhZLRQG2PB/IsZEiifnlgDNCH/jv
         m/Uw==
X-Gm-Message-State: ABy/qLZ6mWtNRb7zlONUsjveiN0azrTCNhbwXa1+X5+Qe6C4U2y1N5L0
        ougKS++11CXabCYsdDpjVpc=
X-Google-Smtp-Source: APBJJlEzpiHUM3fh6dGeDvxYMh6dMlRTyHCd9VOnRyIic7rI7vv4UcmDLFSqSJosST7EZq8t6YtqmA==
X-Received: by 2002:a17:90a:a65:b0:263:62ae:37aa with SMTP id o92-20020a17090a0a6500b0026362ae37aamr1920718pjo.47.1689949889223;
        Fri, 21 Jul 2023 07:31:29 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090a6b8100b00265cdfa3628sm4607007pjj.6.2023.07.21.07.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:31:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CANn89iLqU=huOuCt2kXmrXf68TUU-N90aQnMykkYcZ+Arx9-aA@mail.gmail.com>
Date:   Fri, 21 Jul 2023 22:31:13 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDE1C0AE-B479-49F9-995D-DA9CC1A6EA57@gmail.com>
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
 <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
 <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <CANn89iLqU=huOuCt2kXmrXf68TUU-N90aQnMykkYcZ+Arx9-aA@mail.gmail.com>
To:     Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 05:11=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 20, 2023 at 10:00=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>>=20
>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of =
first item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>> and a related discussion [1].
>>>>=20
>>>> After reading the whole discussion, it seems like that ptr->field =
was cached by gcc even with the deprecated
>>>> ACCESS_ONCE(), so my question is:
>>>>=20
>>>>       Is that a compiler bug? If so, has this bug been fixed today, =
ten years later?
>>>>=20
>>>>       What about READ_ONCE(ptr->field)?
>>>=20
>>> Make sure sparse is happy.
>>=20
>> It caused a problem without barrier(), and the deprecated =
ACCESS_ONCE() didn=E2=80=99t help:
>>=20
>>        https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>=20
>> So, my real question is: With READ_ONCE(ptr->field), are there still =
some unusual cases where gcc
>> decides not to reload ptr->field?
>=20
> I can not really answer without seeing an actual patch...

The content of the potential patch:

diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
index 89186c499dd4..bcd39670f359 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -158,15 +158,9 @@ static inline void hlist_nulls_add_fake(struct =
hlist_nulls_node *n)
  * @pos:       the &struct hlist_nulls_node to use as a loop cursor.
  * @head:      the head of the list.
  * @member:    the name of the hlist_nulls_node within the struct.
- *
- * The barrier() is needed to make sure compiler doesn't cache first =
element [1],
- * as this loop can be restarted [2]
- * [1] Documentation/memory-barriers.txt around line 1533
- * [2] Documentation/RCU/rculist_nulls.rst around line 146
  */
 #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)         =
               \
-       for (({barrier();}),                                             =
       \
-            pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
+       for (pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
                (!is_a_nulls(pos)) &&                                    =
       \
                ({ tpos =3D hlist_nulls_entry(pos, typeof(*tpos), =
member); 1; }); \
                pos =3D rcu_dereference_raw(hlist_nulls_next_rcu(pos)))
@@ -180,8 +174,7 @@ static inline void hlist_nulls_add_fake(struct =
hlist_nulls_node *n)
  * @member:    the name of the hlist_nulls_node within the struct.
  */
 #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)        =
       \
-       for (({barrier();}),                                             =
       \
-            pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
+       for (pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
                (!is_a_nulls(pos)) &&                                    =
       \
                ({ tpos =3D hlist_nulls_entry(pos, typeof(*tpos), =
member);        \
                   pos =3D =
rcu_dereference_raw(hlist_nulls_next_rcu(pos)); 1; });)


>=20
> Why are you asking ? Are you tracking compiler bug fixes ?

The barrier() here makes me confused.
=20
If we really need that, do we need:

	READ_ONCE(head->first);
	barrier();
	READ_ONCE(head->first);

?

>=20
>>=20
>>>=20
>>> Do you have a patch for review ?
>>=20
>> Possibly next month. :)
>>=20
>>>=20
>>>=20
>>>>=20
>>>>=20
>>>> [1] =
https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glaptop/
>>>>=20
>>>> Thanks,
>>>> Alan


