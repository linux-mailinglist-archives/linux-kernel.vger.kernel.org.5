Return-Path: <linux-kernel+bounces-102596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9687B460
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26DA1F22DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0E25C8EC;
	Wed, 13 Mar 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JxAR7SLr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EC1A38ED;
	Wed, 13 Mar 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369020; cv=none; b=X+IU4GVnA3JqQOaPlgQgtuhQgbrJrny8OEVJv73VyBmz1oj6zvFhljB0W+4rQGQZLBLrVfjOuj/h/3WXHdY8W6ZjCgE/zm3aopVvf8LqI5j8c8B7986/SsZ79x5y9jx1yrDcQo1g9yp9AXUm88KKIYpcHOqcFVwRIfdaHwhD9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369020; c=relaxed/simple;
	bh=CCIs2EhXWX9ha6OhlSM03eisveA0v/CDu7Xhq3qO7/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrs0Sykpl/UI5rO/61OPCJCvS6zlAbzExbWgJQd2/WWq3H4FKCVtWIxMqf+lIc0wAOXi4KeP4ItVy7YnM9+2GQ14/Opx35v3SfPYiJHOUPJRvItb9yJi7n8norjapn+Xn5WhVPQGRDbHLzjituNFzMAtzmxJk6iBRUNP2qt75Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JxAR7SLr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710369015;
	bh=6Sc7A23YGrKfvDPxXLh29IDC/guj7D4h0krd4QzL1DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxAR7SLrFiXaB4tuxeUeSsxGfq835w9kPqkN+x4fe4NYU0PXmB5I2oiGhDHzD6N/T
	 Zf6jw4U97alpslDuqE07jxT/RZF02fvzN6tB4Rhnm2WL0+NG19FQVSy9gKvWHyEbdl
	 gwmKKuA7/3SKy5DOji8qSPYqt2N4ANdfFkPH9i5pPsoZzZIsJZw+HpgPhQRZwa8EXI
	 clHWS6xY+ZBaE8yC4ujvTg9gbmtxzsxKffVppxZIVacc75TfBH8DiMi1mX74G+D/xZ
	 +OvMeEMFKcIV4r8hbRYRi58w00nYCEK0ZmgVehWSBhLZTBTkiFTSutUm+ZO4jJahB0
	 wmDFDJolO4+ww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw4vp0MVGz4wck;
	Thu, 14 Mar 2024 09:30:14 +1100 (AEDT)
Date: Thu, 14 Mar 2024 09:30:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Networking <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 mm-stable tree
Message-ID: <20240314093012.3dba692a@canb.auug.org.au>
In-Reply-To: <20240313105117.699dc720@canb.auug.org.au>
References: <20240307123619.159f1c4c@canb.auug.org.au>
	<20240313105117.699dc720@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X.LwiEanwP1pFLelG86SM1D";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/X.LwiEanwP1pFLelG86SM1D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 13 Mar 2024 10:51:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 7 Mar 2024 12:36:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >=20
> > Today's linux-next merge of the bpf-next tree got a conflict in:
> >=20
> >   mm/vmalloc.c
> >=20
> > between commit:
> >=20
> >   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
> >=20
> > from the mm-stable tree and commit:
> >=20
> >   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages=
().")
> >=20
> > from the bpf-next tree.
> >=20
> > I fixed it up (I think - see below) and can carry the fix as necessary.
> > This is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> >=20
> > diff --cc mm/vmalloc.c
> > index 25a8df497255,e5b8c70950bc..000000000000
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@@ -4755,81 -4423,70 +4820,84 @@@ static void show_numa_info(struct se=
q_f
> >  =20
> >   static void show_purge_info(struct seq_file *m)
> >   {
> >  +	struct vmap_node *vn;
> >   	struct vmap_area *va;
> >  +	int i;
> >  =20
> >  -	spin_lock(&purge_vmap_area_lock);
> >  -	list_for_each_entry(va, &purge_vmap_area_list, list) {
> >  -		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
> >  -			(void *)va->va_start, (void *)va->va_end,
> >  -			va->va_end - va->va_start);
> >  -	}
> >  -	spin_unlock(&purge_vmap_area_lock);
> >  -}
> >  +	for (i =3D 0; i < nr_vmap_nodes; i++) {
> >  +		vn =3D &vmap_nodes[i];
> >  =20
> >  -static int s_show(struct seq_file *m, void *p)
> >  -{
> >  -	struct vmap_area *va;
> >  -	struct vm_struct *v;
> >  -
> >  -	va =3D list_entry(p, struct vmap_area, list);
> >  -
> >  -	if (!va->vm) {
> >  -		if (va->flags & VMAP_RAM)
> >  -			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> >  +		spin_lock(&vn->lazy.lock);
> >  +		list_for_each_entry(va, &vn->lazy.head, list) {
> >  +			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
> >   				(void *)va->va_start, (void *)va->va_end,
> >   				va->va_end - va->va_start);
> >  -
> >  -		goto final;
> >  +		}
> >  +		spin_unlock(&vn->lazy.lock);
> >   	}
> >  +}
> >  =20
> >  -	v =3D va->vm;
> >  +static int vmalloc_info_show(struct seq_file *m, void *p)
> >  +{
> >  +	struct vmap_node *vn;
> >  +	struct vmap_area *va;
> >  +	struct vm_struct *v;
> >  +	int i;
> >  =20
> >  -	seq_printf(m, "0x%pK-0x%pK %7ld",
> >  -		v->addr, v->addr + v->size, v->size);
> >  +	for (i =3D 0; i < nr_vmap_nodes; i++) {
> >  +		vn =3D &vmap_nodes[i];
> >  =20
> >  -	if (v->caller)
> >  -		seq_printf(m, " %pS", v->caller);
> >  +		spin_lock(&vn->busy.lock);
> >  +		list_for_each_entry(va, &vn->busy.head, list) {
> >  +			if (!va->vm) {
> >  +				if (va->flags & VMAP_RAM)
> >  +					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> >  +						(void *)va->va_start, (void *)va->va_end,
> >  +						va->va_end - va->va_start);
> >  =20
> >  -	if (v->nr_pages)
> >  -		seq_printf(m, " pages=3D%d", v->nr_pages);
> >  +				continue;
> >  +			}
> >  =20
> >  -	if (v->phys_addr)
> >  -		seq_printf(m, " phys=3D%pa", &v->phys_addr);
> >  +			v =3D va->vm;
> >  =20
> >  -	if (v->flags & VM_IOREMAP)
> >  -		seq_puts(m, " ioremap");
> >  +			seq_printf(m, "0x%pK-0x%pK %7ld",
> >  +				v->addr, v->addr + v->size, v->size);
> >  =20
> >  -	if (v->flags & VM_SPARSE)
> >  -		seq_puts(m, " sparse");
> >  +			if (v->caller)
> >  +				seq_printf(m, " %pS", v->caller);
> >  =20
> >  -	if (v->flags & VM_ALLOC)
> >  -		seq_puts(m, " vmalloc");
> >  +			if (v->nr_pages)
> >  +				seq_printf(m, " pages=3D%d", v->nr_pages);
> >  =20
> >  -	if (v->flags & VM_MAP)
> >  -		seq_puts(m, " vmap");
> >  +			if (v->phys_addr)
> >  +				seq_printf(m, " phys=3D%pa", &v->phys_addr);
> >  =20
> >  -	if (v->flags & VM_USERMAP)
> >  -		seq_puts(m, " user");
> >  +			if (v->flags & VM_IOREMAP)
> >  +				seq_puts(m, " ioremap");
> >  =20
> >  -	if (v->flags & VM_DMA_COHERENT)
> >  -		seq_puts(m, " dma-coherent");
> > ++			if (v->flags & VM_SPARSE)
> > ++				seq_puts(m, " sparse");
> > +=20
> >  -	if (is_vmalloc_addr(v->pages))
> >  -		seq_puts(m, " vpages");
> >  +			if (v->flags & VM_ALLOC)
> >  +				seq_puts(m, " vmalloc");
> >  =20
> >  -	show_numa_info(m, v);
> >  -	seq_putc(m, '\n');
> >  +			if (v->flags & VM_MAP)
> >  +				seq_puts(m, " vmap");
> >  +
> >  +			if (v->flags & VM_USERMAP)
> >  +				seq_puts(m, " user");
> >  +
> >  +			if (v->flags & VM_DMA_COHERENT)
> >  +				seq_puts(m, " dma-coherent");
> >  +
> >  +			if (is_vmalloc_addr(v->pages))
> >  +				seq_puts(m, " vpages");
> >  +
> >  +			show_numa_info(m, v);
> >  +			seq_putc(m, '\n');
> >  +		}
> >  +		spin_unlock(&vn->busy.lock);
> >  +	}
> >  =20
> >   	/*
> >   	 * As a final step, dump "unpurged" areas. =20
>=20
> This is now a conflict between the net-next tree and the mm-stable tree.

 ... and now a conflict between te mm-stable tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/X.LwiEanwP1pFLelG86SM1D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXyKPQACgkQAVBC80lX
0GwlxQf/eCrMYHEYG7MSNkVQBOK/HNe6zEdclVJJ9hZMYItowVZn+cAtXqMfMl98
XimL1lFZVTMWBTCvPTvVWcle8LDPDX/RymqePh2S/roMVI31uPKHV6YnA0zm86sn
nkgsaJyiuRqHj0wQzAS+X5UUnOW1wYw9C1fEchCXLiFkzBoz3fJul/k7v0DvS5Zi
iCRSvYDFAEE1wVf7DkWjZ5J2B0W/+fORMWzf8ljakfi4KH+HRTF6mpLlRPnKI7gw
n1tc6lv3ZJsycrZf2h3D48jw8CQ1FwSdReWioCZZaq2fUH63318j3A4wiiOUm3DD
KEs+PRyq44sMFcT18czjvkX9kL6iCA==
=A/F9
-----END PGP SIGNATURE-----

--Sig_/X.LwiEanwP1pFLelG86SM1D--

