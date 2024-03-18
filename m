Return-Path: <linux-kernel+bounces-106821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BD87F42B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CB91C21112
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549A5F86C;
	Mon, 18 Mar 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRxQxe1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712655F859;
	Mon, 18 Mar 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805145; cv=none; b=AuQp2vawRqTbW1j3sdmUNtrryyUVomPepuhgnZ3S0Rsv/jlMpm8nKhDbveBp2EMCdK6frS0y6oQywY2GC5Zc9gbM5rov35N6WClS2WdOOYFoLvI+S66kl+XdLkxTaDw84aokJW3FC0lpdq17TzHzMSMG2BQ31acZvClALvQ33qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805145; c=relaxed/simple;
	bh=vNPV+Zm1jo6GQke9UBMxQprrLogWyW6mK1dZOZf+eZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AASBViRejV7jwIgjj+TW5gZgGwB0qUAp1iLUrDulUylYjECAxz/P/xpSgTfAUl/s/DVSzj0cigz0oLs0XeTXN6N3BBd4sm2vTBkmJ5Q52ofxcE2psyFY/eZLXg2fcYhj22p24gXlNMaK7ZmO2ngODUV+TXWPlMqnAeml/QHT4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRxQxe1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A9FC433F1;
	Mon, 18 Mar 2024 23:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710805144;
	bh=vNPV+Zm1jo6GQke9UBMxQprrLogWyW6mK1dZOZf+eZ4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fRxQxe1vX8gFA4H4/tqhTxyx1PTwtyNbL63yiwezOezdjGrGu2yUxdzdrO6YfwvDJ
	 Gy2MYnigaGTllxZyONLD/zOrf14lQ9QxcUqxZc4DwlWfec16z2A2zYb3Ja7d2ggEAj
	 SDGtivMXm0puj/iglEDdFF7AJBHiljiYpaCvuaopqHnubCGqrkbs+ijVyhNaALqQpb
	 jFacRouvnfhdEc9PNNd1FFZquD0pWYM6LXBh7iot2GreTyHec1jci00jEH0FwPmum/
	 C8QpZe/h539LeIGNqtwghhAZzX2XYyqzRk3f2Hd6ddNmiBkELNZuQjVwWXXvGPs1JW
	 6Z436URGh79cA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 01:39:00 +0200
Message-Id: <CZX9T3TU6YU0.3JE9M7M3ENUE0@kernel.org>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>
Subject: Re: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roman Smirnov" <r.smirnov@omp.ru>, "David Howells"
 <dhowells@redhat.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, "Andrew Zaborowski"
 <andrew.zaborowski@intel.com>
X-Mailer: aerc 0.15.2
References: <20240315103320.18754-1-r.smirnov@omp.ru>
In-Reply-To: <20240315103320.18754-1-r.smirnov@omp.ru>

On Fri Mar 15, 2024 at 12:33 PM EET, Roman Smirnov wrote:
> With the current code, in case all NULLs are passed in id_{0,1,2},

"current code" is not unambigious reference of any part of the kernel
tree. Please just write down the function name instead.

> the kernel will first print out a WARNING and then have an oops
> because id_2 gets dereferenced anyway.

Would be more exact":

s/print out a WARNING/emit WARN/

> Note that WARN_ON() is also considered harmful by Greg Kroah-
> Hartman since it causes the Android kernels to panic as they
> get booted with the panic_on_warn option.

Despite full respect to Greg, and agreeing what he had said about
the topic (which you are lacking lore link meaning that in all
cases the current description is incomplete), the only thing that
should be documented should be that since WARN_ON() can emit
panic when panic_on_warn is set in the *kernel command-line*
(not "option") this condition should be relaxed.

>
> Found by Linux Verification Center (linuxtesting.org) with Svace.

I'm not sure if this should be part of the commit message.

>
> Fixes: 7d30198ee24f ("keys: X.509 public key issuer lookup without AKID")
> Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Should be reported-by.

> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  crypto/asymmetric_keys/asymmetric_type.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric=
_keys/asymmetric_type.c
> index a5da8ccd353e..f5cbd6ff14e2 100644
> --- a/crypto/asymmetric_keys/asymmetric_type.c
> +++ b/crypto/asymmetric_keys/asymmetric_type.c
> @@ -60,17 +60,17 @@ struct key *find_asymmetric_key(struct key *keyring,
>  	char *req, *p;
>  	int len;
> =20
> -	WARN_ON(!id_0 && !id_1 && !id_2);
> -

Weird, I recall discussing about this issue in the past. Unfortunately
could not find the thread from lore.

Anyway I agree with the code change.

>  	if (id_0) {
>  		lookup =3D id_0->data;
>  		len =3D id_0->len;
>  	} else if (id_1) {
>  		lookup =3D id_1->data;
>  		len =3D id_1->len;
> -	} else {
> +	} else if (id_2) {
>  		lookup =3D id_2->data;
>  		len =3D id_2->len;
> +	} else {
> +		return ERR_PTR(-EINVAL);
>  	}
> =20
>  	/* Construct an identifier "id:<keyid>". */


BR, Jarkko

