Return-Path: <linux-kernel+bounces-17610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3853825022
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871461F227FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B122EF5;
	Fri,  5 Jan 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mOVYCs12"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066622EE5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TZQ3khfsKLf+AmeAaE2I1LPoTpEix5mNeFyVVHSxfZc=;
	t=1704444152; x=1705653752; b=mOVYCs12sxUTXTBcTcVxjWKSKB9y73HD9X4HBRsR7LWRLsk
	AHdFpQOUqobCYTkoGH54cTAW9hvcdJEAxyi3PkOAnyq5sIdgHZ6+IWX7qDZqIoNr3I88GfFqY1COO
	Hp3SCaXw9QHOg4uaZZir7KDniR6BluTD/fmdkqV5Iu94OCDETyuGtodGzZnS/g9O8kEz7hQcxM89H
	J2t+eSrNWHX0YNqbWJgcmppvN7pQZcC5iUD4NBk3M6pv4DLVLZEVg8hNnTm2QW93Ju8q09NroOFNK
	9SBzMXWrxDtWoyGbV7z0L99octbX7t9k2Yo0ediVSQNai0z1lxuHLtyV9sPCnz4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLfmP-00000005vmz-2A4u;
	Fri, 05 Jan 2024 09:42:14 +0100
Message-ID: <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Weinberger <richard.weinberger@gmail.com>, Ma Ke
	 <make_ruc2021@163.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, xiangyang3@huawei.com, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Jan 2024 09:42:12 +0100
In-Reply-To: <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
References: <20231006122717.3984017-1-make_ruc2021@163.com>
	 <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-04 at 22:05 +0100, Richard Weinberger wrote:
> On Fri, Oct 6, 2023 at 2:28=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote=
:
> >=20
> > In vector_legacy_rx, to avoid an unexpected result returned by
> > pskb_trim, we should check the return value of pskb_trim().
> >=20
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  arch/um/drivers/vector_kern.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_ker=
n.c
> > index 131b7cb29576..822a8c0cdcc1 100644
> > --- a/arch/um/drivers/vector_kern.c
> > +++ b/arch/um/drivers/vector_kern.c
> > @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *=
vp)
> >                                         skb->ip_summed =3D CHECKSUM_UNN=
ECESSARY;
> >                                 }
> >                         }
> > -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
> > +                       if (pskb_trim(skb, pkt_len - vp->rx_header_size=
))
> > +                               return 0;
>=20
> I think this adds a memory leak. Also, can pskb_trim() really fail in
> this scenario?
> The function controls skb creation and knows all lengths.
>=20
We had pretty much the exact same discussion in the other patch ...

https://patchwork.ozlabs.org/project/linux-um/patch/20231007005104.3994678-=
1-make_ruc2021@163.com/


No point arguing with people who care about static checkers only, I
guess. This person here never even came back to respond to the comments,
my take is they're throwing patches over the wall they didn't think
about, just to see what sticks.

johannes

