Return-Path: <linux-kernel+bounces-94833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD78745B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571CE1C233A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AB5C82;
	Thu,  7 Mar 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rrTElCvX"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DCF4C6C;
	Thu,  7 Mar 2024 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775388; cv=none; b=CDTcqaqTuiDih3QbFA6F2nEi8w3qRVWQ9ydNRO1GQB6xgsbVIuy9yQ8JSWm6ZuCiclg6WROfe67b4Yj7KUbh9PS8fjRUXUWqkbYVERyNrjJmem5SJGZ3vr9D9TlvwcKpUlAWM5mMsktVwq2NLzEk7Fa3TOs8EtGniyCSzQ9K2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775388; c=relaxed/simple;
	bh=DGvZGr1IjTXNmLu/v0BjlBPqV6VOcPWZhaTsHSCk+tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dA00CP7q8KDf5N8Lv+fmdulCr4nLO/iZNt7TTimaYZ9foIUnuqH20M+ge+DDweexT9vbp4gvPARmtU7qe2nErKpBpgFKXATL6Rcm24G5uYehhSJc/2u6y9E337ub9Kzu5XUb4VwAiDWzl5bfIOKwyhpcOqbwVIGkW+pZO0oDp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rrTElCvX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709775383;
	bh=uRHTG0L933W49rR7eLKbmUyiReuzr8JXVYf13P4Er+Q=;
	h=Date:From:To:Cc:Subject:From;
	b=rrTElCvXas/WiNo+f1N65FbgNlU7mB11ugnVirlWtEHb3B4xgr5r/O2gPm1/2FzZl
	 FrzXBlkf38spshsYkA+1L87m0S7rK3Ol68f7phITkwXauziCqkfJrtKdqt8NljcP7u
	 GDGn7IVpXXQB54yHSzFvW7kh+X4JR+Su4zMl4ubdOwNJWm2Wf9GQrpzWykOIgOuHyu
	 YqQ4HRmLsl4XyEqIZ62v5iq4E4ulJKUqBk5USreOKLwALUshSwXlK2lV9LBUIuXzyB
	 v95RNmInFJVRPSWDqE8kdA1T1/w3YcY3mDqTy7nJHGPf6DWiRYm2SyR1o2q2Jbfz1+
	 BmaWdSgG8d2fg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqsMp2znkz4wc7;
	Thu,  7 Mar 2024 12:36:22 +1100 (AEDT)
Date: Thu, 7 Mar 2024 12:36:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Uladzislau Rezki (Sony)"
 <urezki@gmail.com>
Subject: linux-next: manual merge of the bpf-next tree with the mm-stable
 tree
Message-ID: <20240307123619.159f1c4c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0XTsu3vubCij2IEjsa0+JF6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0XTsu3vubCij2IEjsa0+JF6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  mm/vmalloc.c

between commit:

  8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")

from the mm-stable tree and commit:

  e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().")

from the bpf-next tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/vmalloc.c
index 25a8df497255,e5b8c70950bc..000000000000
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@@ -4755,81 -4423,70 +4820,84 @@@ static void show_numa_info(struct seq_f
 =20
  static void show_purge_info(struct seq_file *m)
  {
 +	struct vmap_node *vn;
  	struct vmap_area *va;
 +	int i;
 =20
 -	spin_lock(&purge_vmap_area_lock);
 -	list_for_each_entry(va, &purge_vmap_area_list, list) {
 -		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
 -			(void *)va->va_start, (void *)va->va_end,
 -			va->va_end - va->va_start);
 -	}
 -	spin_unlock(&purge_vmap_area_lock);
 -}
 +	for (i =3D 0; i < nr_vmap_nodes; i++) {
 +		vn =3D &vmap_nodes[i];
 =20
 -static int s_show(struct seq_file *m, void *p)
 -{
 -	struct vmap_area *va;
 -	struct vm_struct *v;
 -
 -	va =3D list_entry(p, struct vmap_area, list);
 -
 -	if (!va->vm) {
 -		if (va->flags & VMAP_RAM)
 -			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
 +		spin_lock(&vn->lazy.lock);
 +		list_for_each_entry(va, &vn->lazy.head, list) {
 +			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
  				(void *)va->va_start, (void *)va->va_end,
  				va->va_end - va->va_start);
 -
 -		goto final;
 +		}
 +		spin_unlock(&vn->lazy.lock);
  	}
 +}
 =20
 -	v =3D va->vm;
 +static int vmalloc_info_show(struct seq_file *m, void *p)
 +{
 +	struct vmap_node *vn;
 +	struct vmap_area *va;
 +	struct vm_struct *v;
 +	int i;
 =20
 -	seq_printf(m, "0x%pK-0x%pK %7ld",
 -		v->addr, v->addr + v->size, v->size);
 +	for (i =3D 0; i < nr_vmap_nodes; i++) {
 +		vn =3D &vmap_nodes[i];
 =20
 -	if (v->caller)
 -		seq_printf(m, " %pS", v->caller);
 +		spin_lock(&vn->busy.lock);
 +		list_for_each_entry(va, &vn->busy.head, list) {
 +			if (!va->vm) {
 +				if (va->flags & VMAP_RAM)
 +					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
 +						(void *)va->va_start, (void *)va->va_end,
 +						va->va_end - va->va_start);
 =20
 -	if (v->nr_pages)
 -		seq_printf(m, " pages=3D%d", v->nr_pages);
 +				continue;
 +			}
 =20
 -	if (v->phys_addr)
 -		seq_printf(m, " phys=3D%pa", &v->phys_addr);
 +			v =3D va->vm;
 =20
 -	if (v->flags & VM_IOREMAP)
 -		seq_puts(m, " ioremap");
 +			seq_printf(m, "0x%pK-0x%pK %7ld",
 +				v->addr, v->addr + v->size, v->size);
 =20
 -	if (v->flags & VM_SPARSE)
 -		seq_puts(m, " sparse");
 +			if (v->caller)
 +				seq_printf(m, " %pS", v->caller);
 =20
 -	if (v->flags & VM_ALLOC)
 -		seq_puts(m, " vmalloc");
 +			if (v->nr_pages)
 +				seq_printf(m, " pages=3D%d", v->nr_pages);
 =20
 -	if (v->flags & VM_MAP)
 -		seq_puts(m, " vmap");
 +			if (v->phys_addr)
 +				seq_printf(m, " phys=3D%pa", &v->phys_addr);
 =20
 -	if (v->flags & VM_USERMAP)
 -		seq_puts(m, " user");
 +			if (v->flags & VM_IOREMAP)
 +				seq_puts(m, " ioremap");
 =20
 -	if (v->flags & VM_DMA_COHERENT)
 -		seq_puts(m, " dma-coherent");
++			if (v->flags & VM_SPARSE)
++				seq_puts(m, " sparse");
+=20
 -	if (is_vmalloc_addr(v->pages))
 -		seq_puts(m, " vpages");
 +			if (v->flags & VM_ALLOC)
 +				seq_puts(m, " vmalloc");
 =20
 -	show_numa_info(m, v);
 -	seq_putc(m, '\n');
 +			if (v->flags & VM_MAP)
 +				seq_puts(m, " vmap");
 +
 +			if (v->flags & VM_USERMAP)
 +				seq_puts(m, " user");
 +
 +			if (v->flags & VM_DMA_COHERENT)
 +				seq_puts(m, " dma-coherent");
 +
 +			if (is_vmalloc_addr(v->pages))
 +				seq_puts(m, " vpages");
 +
 +			show_numa_info(m, v);
 +			seq_putc(m, '\n');
 +		}
 +		spin_unlock(&vn->busy.lock);
 +	}
 =20
  	/*
  	 * As a final step, dump "unpurged" areas.

--Sig_/0XTsu3vubCij2IEjsa0+JF6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpGhMACgkQAVBC80lX
0GyulQf/cE1To1a/iTynPNiIw/MuF/ez+0lLzyXqxJCfduHst/Bz0PRYwaJm85tH
I2KEy153199aJrR5nbgdaeY7EDYvuijcImpDE3uKT4dIVBr193DRBmul7fQX9uTm
541NS/iDRJ6x/xOsEUvBaud/LRvOSixTdb1jiypaFL1MBbtOHPDgq9oShgqFOsAB
o3TgqXV8SyUJiDtwD8aUWTjtbEAfi1IeDekJPvb2oZZf1hSvLu2hKYAgyTcd7f6j
ctYZMJfzKhYugPT7mdS35q2XmybnP/B7Dk4WXu/4W1dJGk/O9BLbATra+XpwPH58
K+k/PR7THaX+tNTyMYBYWeTqCcCfJw==
=U7Ep
-----END PGP SIGNATURE-----

--Sig_/0XTsu3vubCij2IEjsa0+JF6--

