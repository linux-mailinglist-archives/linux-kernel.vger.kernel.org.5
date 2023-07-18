Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B4758016
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjGROtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjGROsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:48:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A861990;
        Tue, 18 Jul 2023 07:48:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-263374f2f17so3116291a91.0;
        Tue, 18 Jul 2023 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689691711; x=1692283711;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUw5Mm2oXwxg84uGwsGw4ZLlhNaz5ntFgDG+mnRamvA=;
        b=T3CO4ZBz1I2r3PMgq/Ovbpdra/G5WU+iFPicS7uFmTU4mQ+ji695uXZMtAcCnQBZEx
         KRrQqRTUQykztktUAI+205VOEaVmiZ/eiv4OHjyoEtg39z/eNrVElk0Uu5XU8TcH54tf
         kM2ZrpvrFInSsCEOJxrQ+dEmMCuFqcjGHbzrvBmiM8kpvR8Nc8VVxYBu6bj7av9xEFd8
         a6CWv3apgb4S4ydlO03UUqjKe4J5QIWW70RFoFCJU4lTf1Nchwdd4wIvbISjanKlNxJT
         ZlRjJIBFLiVCFKGkwBnjevLkwEfUgfLwrj6n9yyEpQfHwCGJXOEFQjIhciqMD8CnwLHh
         B2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691711; x=1692283711;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUw5Mm2oXwxg84uGwsGw4ZLlhNaz5ntFgDG+mnRamvA=;
        b=l6yn19z57/cumymCI/bpVjK+GFq1NFnuZ/aXXcepC1FyE82GjTdLdvrshCoWx13Tzr
         T+6lv8+Oc11rjigfHDgwB2bACmnm0cuWvXawy8rNGEHqocGT4w07GXMvEVeHgO7pVxrf
         3moKkVXflTBiVUBYyW3u2fj6devEZES1joYyy0e8mkUBC24A+lG+GMq2d5h467VnvZGv
         E8OrPNvFmsaK5yGE71sBkKNuKgvqfTi2gxRPjjSPb+YFmXKiSCDnsDjXwXBzcsYQm22v
         1HN4P089aS93eMcyGPeW4h/SC5wN8ZTspgaB2DIlE3SrC4O09+4OH//BiLOn/uSxurAU
         AeLA==
X-Gm-Message-State: ABy/qLZLIlEpPspQqBHZXuhlfvOKv8eCwG6RMCGlKR7MP6t1REl5ENv0
        naz55MBPA1HkyCMmm2/GIb4=
X-Google-Smtp-Source: APBJJlGvsau9o9zkP7cCHrv64AQ5PRxZSUz4ClsSh+sJDPerYMCl5FjioAAyapPv3e/3IPaAnH0Akg==
X-Received: by 2002:a17:90b:48c:b0:263:5eea:e820 with SMTP id bh12-20020a17090b048c00b002635eeae820mr11890191pjb.26.1689691710815;
        Tue, 18 Jul 2023 07:48:30 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a598b00b002657aa777f1sm6539196pji.19.2023.07.18.07.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:48:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
Date:   Tue, 18 Jul 2023 22:48:07 +0800
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
 <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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


> 2023=E5=B9=B47=E6=9C=8818=E6=97=A5 21:49=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 7/17/23 14:03, Paul E. McKenney wrote:
>> From: Alan Huang <mmpgouride@gmail.com>
>> When the objects managed by rculist_nulls are allocated with
>> SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an =
object
>> even though it is just now being added, which means the modification =
of
>> ->next is visible to readers.  This patch therefore uses WRITE_ONCE()
>> for assignments to ->next.
>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> Did we ever conclude that the READ_ONCE() counterparts were not =
needed? ;-)

Read-side is already protected by rcu_dereference_raw() in =
hlist_nulls_for_each_entry_{rcu, safe}.

>=20
> But incremental progress and all, so this LGTM:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>=20
> thanks,
>=20
> - Joel
>=20
>=20
>> ---
>>  include/linux/rculist_nulls.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
>> index ba4c00dd8005..89186c499dd4 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -101,7 +101,7 @@ static inline void =
hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>>  {
>>   struct hlist_nulls_node *first =3D h->first;
>>  - n->next =3D first;
>> + WRITE_ONCE(n->next, first);
>>   WRITE_ONCE(n->pprev, &h->first);
>>   rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
>>   if (!is_a_nulls(first))
>> @@ -137,7 +137,7 @@ static inline void =
hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>>   last =3D i;
>>     if (last) {
>> - n->next =3D last->next;
>> + WRITE_ONCE(n->next, last->next);
>>   n->pprev =3D &last->next;
>>   rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>>   } else {
>=20

