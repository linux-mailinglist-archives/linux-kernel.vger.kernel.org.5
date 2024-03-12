Return-Path: <linux-kernel+bounces-100937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4AB879FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD741F22887
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B99347A4C;
	Tue, 12 Mar 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bYEbldRC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66E47A52;
	Tue, 12 Mar 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287483; cv=none; b=s8/BqeLUKrLdPugBBX9urQ+wChjV7gMNJujsEPUFO5LcNoX0nQdNX/zNEQChM5dXhbr5bBPhZDR3z5oI6uetGkZm7aCakX/aT25anCPxLdtOuLmCNQIYsE4B2xdX8NpcEAH+8PdlB3YAhHEszvzs2CHu1ec7qt9PB4EcIpQ5eiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287483; c=relaxed/simple;
	bh=X7Pm5RoAdj55evPiJMvqxK1W5YPJTErKGzSKaroow58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF+QJyyU9/DSCgfXZNOCnVNh1vZz7GJGtihZfEA4mrPM1FYY6j0P93xD7iU8h32Vo6Q0oTzk0w6y+HBDkBs3jZ15h5v74eiPEqgSnfxiywYZSLguFlJs07bcbf/jHHiR2Mbq6VYZ4pYYZd64lAMOR9Vwq1O83A33Nuv6/eYdP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bYEbldRC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710287479;
	bh=UodvkJ5UEPNHTE1gtYxLGz+q1xnZJ07gSgPcwxaWF9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYEbldRCdLIt6oYNRPPF8TYvU+vJr/g49398b/QE5R+asPhOYeT/wQ377CZwVhjVZ
	 4o3EwmKCXZd87SILQ6mNGSNVEd4icyqmTFFq8KWzVt1FxbMUhycBwvzXd7RFIuP6yy
	 BzJn8yRcIb5T8Ym1OGTKlrATz0yO++vgiSGjFvjFEDBYxoGlrYYEAYzsrHACwLednn
	 ggaSp7qgM2FdavlBYipLsURqyRq7lFDpoCGCeuNPMp+pEpUaa42uhBvBWwW3L8N0Uc
	 0r3pAu56QedBToNWym5rohNm3w5pHv031FN7a7AxBjwQmltWF0r3n4RfTd+GNzloTW
	 FWkdJ7U36T3ZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvVlp0bKyz4wcJ;
	Wed, 13 Mar 2024 10:51:17 +1100 (AEDT)
Date: Wed, 13 Mar 2024 10:51:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Networking <netdev@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 mm-stable tree
Message-ID: <20240313105117.699dc720@canb.auug.org.au>
In-Reply-To: <20240307123619.159f1c4c@canb.auug.org.au>
References: <20240307123619.159f1c4c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yT0EdgRsoNW8+yPN=MLDvoO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yT0EdgRsoNW8+yPN=MLDvoO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 Mar 2024 12:36:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the bpf-next tree got a conflict in:
>=20
>   mm/vmalloc.c
>=20
> between commit:
>=20
>   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
>=20
> from the mm-stable tree and commit:
>=20
>   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages()=
")
>=20
> from the bpf-next tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc mm/vmalloc.c
> index 25a8df497255,e5b8c70950bc..000000000000
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@@ -4755,81 -4423,70 +4820,84 @@@ static void show_numa_info(struct seq_f
>  =20
>   static void show_purge_info(struct seq_file *m)
>   {
>  +	struct vmap_node *vn;
>   	struct vmap_area *va;
>  +	int i;
>  =20
>  -	spin_lock(&purge_vmap_area_lock);
>  -	list_for_each_entry(va, &purge_vmap_area_list, list) {
>  -		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
>  -			(void *)va->va_start, (void *)va->va_end,
>  -			va->va_end - va->va_start);
>  -	}
>  -	spin_unlock(&purge_vmap_area_lock);
>  -}
>  +	for (i =3D 0; i < nr_vmap_nodes; i++) {
>  +		vn =3D &vmap_nodes[i];
>  =20
>  -static int s_show(struct seq_file *m, void *p)
>  -{
>  -	struct vmap_area *va;
>  -	struct vm_struct *v;
>  -
>  -	va =3D list_entry(p, struct vmap_area, list);
>  -
>  -	if (!va->vm) {
>  -		if (va->flags & VMAP_RAM)
>  -			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
>  +		spin_lock(&vn->lazy.lock);
>  +		list_for_each_entry(va, &vn->lazy.head, list) {
>  +			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
>   				(void *)va->va_start, (void *)va->va_end,
>   				va->va_end - va->va_start);
>  -
>  -		goto final;
>  +		}
>  +		spin_unlock(&vn->lazy.lock);
>   	}
>  +}
>  =20
>  -	v =3D va->vm;
>  +static int vmalloc_info_show(struct seq_file *m, void *p)
>  +{
>  +	struct vmap_node *vn;
>  +	struct vmap_area *va;
>  +	struct vm_struct *v;
>  +	int i;
>  =20
>  -	seq_printf(m, "0x%pK-0x%pK %7ld",
>  -		v->addr, v->addr + v->size, v->size);
>  +	for (i =3D 0; i < nr_vmap_nodes; i++) {
>  +		vn =3D &vmap_nodes[i];
>  =20
>  -	if (v->caller)
>  -		seq_printf(m, " %pS", v->caller);
>  +		spin_lock(&vn->busy.lock);
>  +		list_for_each_entry(va, &vn->busy.head, list) {
>  +			if (!va->vm) {
>  +				if (va->flags & VMAP_RAM)
>  +					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
>  +						(void *)va->va_start, (void *)va->va_end,
>  +						va->va_end - va->va_start);
>  =20
>  -	if (v->nr_pages)
>  -		seq_printf(m, " pages=3D%d", v->nr_pages);
>  +				continue;
>  +			}
>  =20
>  -	if (v->phys_addr)
>  -		seq_printf(m, " phys=3D%pa", &v->phys_addr);
>  +			v =3D va->vm;
>  =20
>  -	if (v->flags & VM_IOREMAP)
>  -		seq_puts(m, " ioremap");
>  +			seq_printf(m, "0x%pK-0x%pK %7ld",
>  +				v->addr, v->addr + v->size, v->size);
>  =20
>  -	if (v->flags & VM_SPARSE)
>  -		seq_puts(m, " sparse");
>  +			if (v->caller)
>  +				seq_printf(m, " %pS", v->caller);
>  =20
>  -	if (v->flags & VM_ALLOC)
>  -		seq_puts(m, " vmalloc");
>  +			if (v->nr_pages)
>  +				seq_printf(m, " pages=3D%d", v->nr_pages);
>  =20
>  -	if (v->flags & VM_MAP)
>  -		seq_puts(m, " vmap");
>  +			if (v->phys_addr)
>  +				seq_printf(m, " phys=3D%pa", &v->phys_addr);
>  =20
>  -	if (v->flags & VM_USERMAP)
>  -		seq_puts(m, " user");
>  +			if (v->flags & VM_IOREMAP)
>  +				seq_puts(m, " ioremap");
>  =20
>  -	if (v->flags & VM_DMA_COHERENT)
>  -		seq_puts(m, " dma-coherent");
> ++			if (v->flags & VM_SPARSE)
> ++				seq_puts(m, " sparse");
> +=20
>  -	if (is_vmalloc_addr(v->pages))
>  -		seq_puts(m, " vpages");
>  +			if (v->flags & VM_ALLOC)
>  +				seq_puts(m, " vmalloc");
>  =20
>  -	show_numa_info(m, v);
>  -	seq_putc(m, '\n');
>  +			if (v->flags & VM_MAP)
>  +				seq_puts(m, " vmap");
>  +
>  +			if (v->flags & VM_USERMAP)
>  +				seq_puts(m, " user");
>  +
>  +			if (v->flags & VM_DMA_COHERENT)
>  +				seq_puts(m, " dma-coherent");
>  +
>  +			if (is_vmalloc_addr(v->pages))
>  +				seq_puts(m, " vpages");
>  +
>  +			show_numa_info(m, v);
>  +			seq_putc(m, '\n');
>  +		}
>  +		spin_unlock(&vn->busy.lock);
>  +	}
>  =20
>   	/*
>   	 * As a final step, dump "unpurged" areas.

This is now a conflict between the net-next tree and the mm-stable tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/yT0EdgRsoNW8+yPN=MLDvoO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXw6nUACgkQAVBC80lX
0Gya7Af/eanjo0KqtUdKrpWYcPSmSO1QHXGP9/SE4P3qCeVYHvN19R2jZLzaou9a
fGAjvSvop62RTF22Fz4qHDee9W7Lv/fIWb8ZP6Qf+z9heyPqLHl848oRFK7iIOzb
f9Z3AnUz7iwg8aBxn42HNA1i+wHXH/r/QdNtKLLDnIhQTGeH17Cv1TJRx32hWlOj
4yPWa8QtzZLIq1fwaWY487mXIjALPrFC6lIZ4gbtZpQ/AxT3+lfZbi515nIm6kMk
F68Qb61VEuwWHW120bsVzogE0ZSKxGrNHQchW6CEOfC8QEYh+8eaKD8RT/Kuduro
ufS2iZdqvtdej+4JXPBQhj+QTH4eNw==
=4mUn
-----END PGP SIGNATURE-----

--Sig_/yT0EdgRsoNW8+yPN=MLDvoO--

