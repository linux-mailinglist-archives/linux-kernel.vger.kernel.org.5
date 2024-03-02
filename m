Return-Path: <linux-kernel+bounces-89403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555686EFE8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C5A1C21167
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FD1156E4;
	Sat,  2 Mar 2024 09:49:05 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D513FF1;
	Sat,  2 Mar 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709372945; cv=none; b=DyLQbiaoWU9my1nDqiq9yFU3EFAS+5RBBuIuqGWm000hCNrPzex/g9RWOInCSl07a6ws8RmpLgHrKcu9fVWN/ckV7+V80Ljd2J2HyJSzviNrmy7N50KTlaP3x0mz6e3H2vS6q8g+bgBKJQSidCqZXz9e1ywISRm5F/GPY0ZRCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709372945; c=relaxed/simple;
	bh=25G4CnMZXN8FjED1jmnlV5PfqYFZXUzZOn0xZchUcf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axpWTQ06GsJfn4cBBO75rJwADEFXtlfUzNbPWnQtC+U+lZUSdh3oS/09MmbEgr1NWscTQbUJVStIUy2oyGwJCSDVoGNX9dmJVkByUu1oKfht97qow+U2krP4H9BD1P8znMVGtPwjtgYztWbjifvnPqKl6rO4PvjlOHS7KY3+fVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=40434 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rgLz7-008oxI-F4; Sat, 02 Mar 2024 10:48:51 +0100
Date: Sat, 2 Mar 2024 10:48:47 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "fw@strlen.de" <fw@strlen.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net v2] netfilter: Add protection for bmp length out of
 range
Message-ID: <ZeL1_-Pdq6Kw0NIO@calendula>
References: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>
X-Spam-Score: -1.9 (-)

On Fri, Mar 01, 2024 at 03:12:24PM +0000, Lena Wang (王娜) wrote:
> From: Lena Wang <lena.wang@mediatek.com>
> 
> UBSAN load reports an exception of BRK#5515 SHIFT_ISSUE:Bitwise shifts
> that are out of bounds for their data type.
> 
> vmlinux   get_bitmap(b=75) + 712
> <net/netfilter/nf_conntrack_h323_asn1.c:0>
> vmlinux   decode_seq(bs=0xFFFFFFD008037000, f=0xFFFFFFD008037018,
> level=134443100) + 1956
> <net/netfilter/nf_conntrack_h323_asn1.c:592>
> vmlinux   decode_choice(base=0xFFFFFFD0080370F0, level=23843636) + 1216
> <net/netfilter/nf_conntrack_h323_asn1.c:814>
> vmlinux   decode_seq(f=0xFFFFFFD0080371A8, level=134443500) + 812
> <net/netfilter/nf_conntrack_h323_asn1.c:576>
> vmlinux   decode_choice(base=0xFFFFFFD008037280, level=0) + 1216
> <net/netfilter/nf_conntrack_h323_asn1.c:814>
> vmlinux   DecodeRasMessage() + 304
> <net/netfilter/nf_conntrack_h323_asn1.c:833>
> vmlinux   ras_help() + 684
> <net/netfilter/nf_conntrack_h323_main.c:1728>
> vmlinux   nf_confirm() + 188
> <net/netfilter/nf_conntrack_proto.c:137>
> 
> Due to abnormal data in skb->data, the extension bitmap length
> exceeds 32 when decoding ras message. Then get_bitmap uses the
> length to make a shift operation. It will change into negative
> after several loop.
> 
> UBSAN load can detect a negative shift as an undefined behaviour
> and reports an exception.
> 
> So we should add the protection to avoid the length exceeding 32.
> If it exceeds it will return out of range error and stop decoding
> ras message.
> 
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
> v2:
>   - add length protecton for another get_bitmap call.
>   - update commit message to trim stacktrace.
> ---
> ---
>  net/netfilter/nf_conntrack_h323_asn1.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/netfilter/nf_conntrack_h323_asn1.c
> b/net/netfilter/nf_conntrack_h323_asn1.c
> index e697a824b001..540d97715bd2 100644
> --- a/net/netfilter/nf_conntrack_h323_asn1.c
> +++ b/net/netfilter/nf_conntrack_h323_asn1.c
> @@ -533,6 +533,8 @@ static int decode_seq(struct bitstr *bs, const
> struct field_t *f,
>  	/* Get fields bitmap */
>  	if (nf_h323_error_boundary(bs, 0, f->sz))
>  		return H323_ERROR_BOUND;
> +	if (f->sz > 32)
> +		return H323_ERROR_RANGE;

Could you possibly place this in get_bitmap()? IIRC these are the only
two calls to this function.

Thanks.

>  	bmp = get_bitmap(bs, f->sz);
>  	if (base)
>  		*(unsigned int *)base = bmp;
> @@ -589,6 +591,8 @@ static int decode_seq(struct bitstr *bs, const
> struct field_t *f,
>  	bmp2_len = get_bits(bs, 7) + 1;
>  	if (nf_h323_error_boundary(bs, 0, bmp2_len))
>  		return H323_ERROR_BOUND;
> +	if (bmp2_len > 32)
> +		return H323_ERROR_RANGE;
>  	bmp2 = get_bitmap(bs, bmp2_len);
>  	bmp |= bmp2 >> f->sz;
>  	if (base)
> -- 
> 2.18.0

