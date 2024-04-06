Return-Path: <linux-kernel+bounces-134037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660789AC68
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE392821EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EF3FBA5;
	Sat,  6 Apr 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA7D2gep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226E3FBB0;
	Sat,  6 Apr 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423839; cv=none; b=E/CZoG29jZVxNFRE5PHYAH86UTNGgQqwaKQphs0qrXN+GV53ulsCbNXZu095owVNhc+5ERBAT4msOXczC8p1oQuNLSwQJv+4UO0DzHpjr7v8J0hpAYkm4Xkl8iMzDOnsiElY2bgDoJ0pfmfLnuOjfxtAWRovx8drPuUblTxqcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423839; c=relaxed/simple;
	bh=EqXMvyGb0Uh8hGtYMmGhNvHq0O5FmIgaRTXqqLJhFmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jy6MveiPERGWMsOJ9qGa4079Uag/UlvYrxXcXFx/4nb7+/cKPIVhbz4XSbbsFbNmguFeS/P4kDmkgKRO4GbPLTwAiraVyau5OeNZoqoKJC1Hf9+p6v6OZopGzLQh6YUsgbgd13TLEWtEopTBsgw+Mri/tGIFH1FvJysnK9cZGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA7D2gep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27D5C433F1;
	Sat,  6 Apr 2024 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712423838;
	bh=EqXMvyGb0Uh8hGtYMmGhNvHq0O5FmIgaRTXqqLJhFmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BA7D2gepyiEROLhdEcaPAuxXPGYoRqYoo07mlrbWPHJmU2nf3or0wO64SGDWwQq/K
	 DWPSzHfkLEwYnx2ePsvfRGvsMiT5qjg44yV312cij91X+0FqOmik8V0d4XUjrJZDCP
	 bbWf8ktid380CU2hB6oDtUGbehE0AaupcHae7xTav3OapZqWrRzLHG/NXvZB0s/+Ue
	 ftnn5L7RLy5smE1NnljSUH6cSXn4Qyt4JkzPGFu3lFa+6jNDvZ3lf3I5iA71vCYi6L
	 RiiA4dn0JZkTwm6ffbi5//TKIySX1wg9gQ3Dq3aynf+F/ub1gnkMluDjqkKNpS0HJ4
	 mqBq008hUIiWQ==
Date: Sat, 6 Apr 2024 18:17:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] of: Use scope based of_node_put() cleanups
Message-ID: <20240406181704.2e48dd17@jic23-huawei>
In-Reply-To: <20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org>
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
	<20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Apr 2024 09:15:12 -0500
Rob Herring <robh@kernel.org> wrote:

> Use the relatively new scope based of_node_put() cleanup to simplify
> function exit handling. Doing so reduces the chances of forgetting an
> of_node_put() and simplifies error paths by avoiding the need for goto
> statements.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Hi Rob,

Looks good in general. A few suggestions inline.
First one is a little more complex, but I think will give you a better end =
result

The others are readability improvements enabled by the changes you've made
that I think you could validly change in this same patch.

Jonathan

> ---
>  drivers/of/address.c  | 60 ++++++++++++++++-----------------------------=
------
>  drivers/of/property.c | 22 ++++++-------------
>  2 files changed, 26 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index ae46a3605904..f7b2d535a6d1 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -491,7 +491,6 @@ static u64 __of_translate_address(struct device_node =
*dev,
>  				  const __be32 *in_addr, const char *rprop,
>  				  struct device_node **host)
>  {
> -	struct device_node *parent =3D NULL;
>  	struct of_bus *bus, *pbus;
>  	__be32 addr[OF_MAX_ADDR_CELLS];
>  	int na, ns, pna, pns;
> @@ -504,7 +503,7 @@ static u64 __of_translate_address(struct device_node =
*dev,
> =20
>  	*host =3D NULL;
>  	/* Get parent & match bus type */
> -	parent =3D get_parent(dev);
> +	struct device_node *parent __free(device_node) =3D get_parent(dev);

This is an order change as we'll put this node after dev

Whilst probably fine, I'd call that out in the patch description or just th=
row
in an earlier
struct device_node *dev_node __free(device_node) =3D of_node_get(dev);


Obviously the release order doesn't actually matter but a reader has to thi=
nk
about it briefly to be sure.

Bonus if you do that is that you get to do direct returns at the error cond=
ition
and potentially in the breaks out of the loop. To my eye that's a readabili=
ty
advantage.

In at least one place you could also steal the pointer rather than
getting another reference to dev (taking it to at least 2) then dropping
one of them in the exit path. Can use no_free_ptr() for that.

=46rom readability point of view you'd only want to do that with a direct ret=
urn.
 	=09
			*host =3D no_free_ptr(dev_node);
			return result;
		}




>  	if (parent =3D=3D NULL)
>  		goto bail;
>  	bus =3D of_match_bus(parent);
> @@ -573,7 +572,6 @@ static u64 __of_translate_address(struct device_node =
*dev,
>  		of_dump_addr("one level translation:", addr, na);
>  	}
>   bail:
> -	of_node_put(parent);
>  	of_node_put(dev);
> =20


> @@ -1016,11 +999,9 @@ phys_addr_t __init of_dma_get_max_cpu_address(struc=
t device_node *np)
>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
> -	struct device_node *node;
> +	struct device_node *node __free(device_node) =3D of_node_get(np);
>  	bool is_coherent =3D dma_default_coherent;
> =20
> -	node =3D of_node_get(np);
> -
>  	while (node) {
>  		if (of_property_read_bool(node, "dma-coherent")) {
>  			is_coherent =3D true;

			return true;

and same in the other branch given you break out the loop and return it dir=
ectly.


> @@ -1032,7 +1013,6 @@ bool of_dma_is_coherent(struct device_node *np)
>  		}
>  		node =3D of_get_next_dma_parent(node);
>  	}
> -	of_node_put(node);
>  	return is_coherent;
With above early returns

	return dma_default_coherent;

and drop the is_coherent variable as no longer used.

This sort of related cleanup is one reason I really like the cleanup.h magi=
c.


>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> @@ -1049,19 +1029,17 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>   */
>  static bool of_mmio_is_nonposted(struct device_node *np)
>  {
> -	struct device_node *parent;
>  	bool nonposted;
> =20
>  	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
>  		return false;
> =20
> -	parent =3D of_get_parent(np);
> +	struct device_node *parent __free(device_node) =3D of_get_parent(np);
>  	if (!parent)
>  		return false;
> =20
>  	nonposted =3D of_property_read_bool(parent, "nonposted-mmio");
> =20
> -	of_node_put(parent);
>  	return nonposted;

	return of_property_read_bool()

>  }
> =20

