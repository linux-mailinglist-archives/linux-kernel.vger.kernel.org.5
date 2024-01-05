Return-Path: <linux-kernel+bounces-17613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94288825036
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB391C22BB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FE22308;
	Fri,  5 Jan 2024 08:52:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DE21A14
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 82308626FB14;
	Fri,  5 Jan 2024 09:52:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rlU9WQ8SCSZB; Fri,  5 Jan 2024 09:52:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B43AD6342D56;
	Fri,  5 Jan 2024 09:52:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zaz2zALr2Fu4; Fri,  5 Jan 2024 09:52:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8E620626FB14;
	Fri,  5 Jan 2024 09:52:45 +0100 (CET)
Date: Fri, 5 Jan 2024 09:52:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ma Ke <make_ruc2021@163.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	xiangyang3@huawei.com, linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <16453028.200994.1704444765347.JavaMail.zimbra@nod.at>
In-Reply-To: <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
References: <20231006122717.3984017-1-make_ruc2021@163.com> <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com> <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: vector: fix return value check in vector_legacy_rx
Thread-Index: ThfY3S6SUQd1Spc5i/7CHHF5qkPNtw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "Ma Ke" <make_ru=
c2021@163.com>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, xiangyang3@huawei.com, "linux-um"
> <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.=
org>
> Gesendet: Freitag, 5. Januar 2024 09:42:12
> Betreff: Re: [PATCH] um: vector: fix return value check in vector_legacy_=
rx

> On Thu, 2024-01-04 at 22:05 +0100, Richard Weinberger wrote:
>> On Fri, Oct 6, 2023 at 2:28=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrot=
e:
>> >=20
>> > In vector_legacy_rx, to avoid an unexpected result returned by
>> > pskb_trim, we should check the return value of pskb_trim().
>> >=20
>> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
>> > ---
>> >  arch/um/drivers/vector_kern.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_ke=
rn.c
>> > index 131b7cb29576..822a8c0cdcc1 100644
>> > --- a/arch/um/drivers/vector_kern.c
>> > +++ b/arch/um/drivers/vector_kern.c
>> > @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private =
*vp)
>> >                                         skb->ip_summed =3D CHECKSUM_UN=
NECESSARY;
>> >                                 }
>> >                         }
>> > -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
>> > +                       if (pskb_trim(skb, pkt_len - vp->rx_header_siz=
e))
>> > +                               return 0;
>>=20
>> I think this adds a memory leak. Also, can pskb_trim() really fail in
>> this scenario?
>> The function controls skb creation and knows all lengths.
>>=20
> We had pretty much the exact same discussion in the other patch ...
>=20
> https://patchwork.ozlabs.org/project/linux-um/patch/20231007005104.399467=
8-1-make_ruc2021@163.com/

Yeah, I saw that discussion after commenting to this patch.
(My fault, I scanned patchwork bottom up)=20

>=20
> No point arguing with people who care about static checkers only, I
> guess. This person here never even came back to respond to the comments,
> my take is they're throwing patches over the wall they didn't think
> about, just to see what sticks.

Drive-by fixes are often a waste of everyone's time. :-(

Thanks,
//richard

