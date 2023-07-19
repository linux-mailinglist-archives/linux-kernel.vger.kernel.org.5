Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22896759E55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGSTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:18:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A191BF7;
        Wed, 19 Jul 2023 12:18:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8baa836a5so57166615ad.1;
        Wed, 19 Jul 2023 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689794296; x=1692386296;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAwDIYHwLc+Xj27zzKl9lhwsFCjNoPTFqoz1deZ/UnU=;
        b=W4C/qtU+KQcteUJ8wTKkr1eaI7Vi0ybjTHHReI44+81f8jtkvyUcuO9Z1nU6lh37U1
         krRxDiPE9dQDcCkNXBEdCvPYbdb8csURt9qUki0mIDE/tztNBg+WUC000Vrd7T+KN38j
         YMNe6uxCCEGHWcIkyra0JxJ/RegzuuC9C8sJDHj/6gBVmVm9uCrGQxjwLOjM33NFP45u
         +gYg84znqJ8WUQngQm4CpjIMr37AJHI1hanjA4FpDXb+HHecK74u6Mp0QC+zIOC8tl32
         hnavcoFCiqgf+cFn/vRIda4p32/OAspaVPzUqA0MpFtIHfp5VX8mHX8TfDD3sBaTGz6l
         m99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794296; x=1692386296;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAwDIYHwLc+Xj27zzKl9lhwsFCjNoPTFqoz1deZ/UnU=;
        b=DJUaMXDeYplG6HJ0DiBTjXdJ6iRVPL086msgmjVhWTmZ+ElnDxfU/bkeUMqpqJI494
         rFCEb+xz4W8v2XrYvZ4Z7ND/wO66ZhKoomSsd7Xbvk8sJ5CT3DsXb8PhHUjbQ9J//HQy
         NHkkkZBDp8L/N3BMwFDjuVcbGPbGM+Yi8TQjWew5wpCi2+MWJeiro/fwkWsV+pVHxvQi
         iRGKFaEh3kqng4XDt/e3jPYexAJtcZkUkcrDc3Dn0fZ1yfZtpIJmIdj08UyvWaCs/Udg
         8ZrkOW394k1+ryw7DluF5yeXmbVVUdoQ5HDfXtK/lah+ooKFQ/Dl3PjIXCaUGaj78i72
         5R9Q==
X-Gm-Message-State: ABy/qLbAvs+SQZwkzWXvtJPCQHH8roPKyPuQrSzVSsOlFNscy8TL/LL2
        pAESD8xtWuG5CSkNbXheZ0I=
X-Google-Smtp-Source: APBJJlHgbivOunptU2yauUXiHDEEH7aus0WsX3ZWh+X/g44yaDdtTx8tsjSOnJ1huDk3uL92H/eFUQ==
X-Received: by 2002:a17:902:7293:b0:1b8:73a4:706a with SMTP id d19-20020a170902729300b001b873a4706amr16637327pll.69.1689794296018;
        Wed, 19 Jul 2023 12:18:16 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b9daaffd26sm4314303plw.304.2023.07.19.12.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 12:18:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <50bc6e0d-7d9b-4634-999a-2ee8f503e86a@paulmck-laptop>
Date:   Thu, 20 Jul 2023 03:17:58 +0800
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <129BFB2B-1A19-437E-B04E-16B16AA4C838@gmail.com>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
 <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
 <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
 <3f6b04b3-af22-49f0-8d3c-269640f9f762@paulmck-laptop>
 <449d0d48-ac98-659b-4d03-e75c318605d4@joelfernandes.org>
 <50bc6e0d-7d9b-4634-999a-2ee8f503e86a@paulmck-laptop>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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


> 2023=E5=B9=B47=E6=9C=8820=E6=97=A5 02:20=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jul 18, 2023 at 09:48:59PM -0400, Joel Fernandes wrote:
>>=20
>>=20
>> On 7/18/23 14:32, Paul E. McKenney wrote:
>>> On Tue, Jul 18, 2023 at 10:48:07PM +0800, Alan Huang wrote:
>>>>=20
>>>>> 2023=E5=B9=B47=E6=9C=8818=E6=97=A5 21:49=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>> On 7/17/23 14:03, Paul E. McKenney wrote:
>>>>>> From: Alan Huang <mmpgouride@gmail.com>
>>>>>> When the objects managed by rculist_nulls are allocated with
>>>>>> SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an =
object
>>>>>> even though it is just now being added, which means the =
modification of
>>>>>> ->next is visible to readers.  This patch therefore uses =
WRITE_ONCE()
>>>>>> for assignments to ->next.
>>>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>=20
>>>>> Did we ever conclude that the READ_ONCE() counterparts were not =
needed? ;-)
>>>>=20
>>>> Read-side is already protected by rcu_dereference_raw() in =
hlist_nulls_for_each_entry_{rcu, safe}.
>>>=20
>>> It turns out that different traversal synchronization designs want
>>> different pointers using WRITE_ONCE().
>>=20
>> Thank you Alan and Paul,
>>=20
>> Btw, I don't see any users of hlist_nulls_unhashed_lockless(), maybe =
it can
>> be removed?
>=20
> Either that or the people who removed uses injected bugs...

It has never been used.

That said, the data race has been there almost for four years.

And the network people use sk_unhashed() for both hlist_node and =
hlist_nulls_node.
So, I plan to use hlist_unhashed_lockless() in sk_unhashed(), that will =
be one of my future patches.

>=20
> But if this one really does go away, do we need ->pprev to be
> protected by _ONCE()?

The ->pprev thing is what I=E2=80=99m currently working on. :)

>=20
> Thanx, Paul


