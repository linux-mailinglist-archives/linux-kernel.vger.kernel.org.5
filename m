Return-Path: <linux-kernel+bounces-96452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE18F875C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45146B21995
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C354728DCA;
	Fri,  8 Mar 2024 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JlRMFKSa"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7D5C8B;
	Fri,  8 Mar 2024 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865270; cv=none; b=bJRKGmS7OgLSG1vcnl6E0+Dw0vzdOJyltomnifg2s5kOan5UGMqg4OEDWGhkIvqfMfhwPxs+IYNWosI3NsRyvzLB10LMyks6mxmya0hftlxyJAohJ60dFpc2ioVAsDL9VvfLI5Calcu4+MvZFT4NtLQtONoDmMZjjLx/cP4Fjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865270; c=relaxed/simple;
	bh=/OWIIQFpbf2fasAZ9xBn+YDkO3H7Gi14U4YTTN4smcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UX8BmAsRLX7TndLV7pvUJVD00Q9YsoIkmGtN061NIYdMchQhFvpTEGyCR1Ai8v9QUs7ND1QB+km0XNtmBsGTYLURDhy6G4ycSPK3+5JXWgijgswZBh1SZsjsNJETx/Nzr5c7xrWOh5gA9d8oplY3KIzD86Ehj71Y1LDir+vshg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JlRMFKSa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709865264;
	bh=Kf8UXhFh2YU8ewlfjHd0N62BfR4AHXodrj1OiY3+N1Q=;
	h=Date:From:To:Cc:Subject:From;
	b=JlRMFKSa9z8PfLqwlX2dM1jIpC7NivHWmV1ABWuaGDXswJo8H/Iq/8zc9Y/cqE0Bp
	 o3an1Bmx87/HykqnASUbLSX/1LvYRtgMO6KtFqMd9ii/JR4JUOAQalspCu7Lz3ftwB
	 3qSjqQzVUEPL7Z9aJmuuDbdLelT/M5y3ImLO/9WU9Bakdwi0oxceujV1Eq1KdjLn+V
	 cxd+I/G22bWBa7Bt8610We5w8dvvygLilBp+cC73M2EulOQ3kz6l5MtF5bZxmEWG9h
	 OhPWL+a5Ujatzqj1GFm5oaxczGxbzgIWjbHOaFxb+wXhuK0IsXTw8rcC/1qZbm7Dje
	 g6rQXYB5XmlSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrVcH5wTrz4wc9;
	Fri,  8 Mar 2024 13:34:23 +1100 (AEDT)
Date: Fri, 8 Mar 2024 13:34:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: linux-next: manual merge of the drivers-x86 tree with Linus' tree
Message-ID: <20240308133423.0f1ac39e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S96XBdrT0g5sPlo.kERvx0p";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/S96XBdrT0g5sPlo.kERvx0p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/amd/pmf/tee-if.c

between commits:

  3da01394c0f7 ("platform/x86/amd/pmf: Remove smart_pc_status enum")
  20545af302bb ("platform/x86/amd/pmf: Add debugging message for missing po=
licy data")
  e70961505808 ("platform/x86/amd/pmf: Fixup error handling for amd_pmf_ini=
t_smart_pc()")

from Linus' tree and commits:

  6ed210504a18 ("platform/x86/amd/pmf: Add missing __iomem attribute to pol=
icy_base")
  98cfcece0ab8 ("platform/x86/amd/pmf: Fix return value of amd_pmf_start_po=
licy_engine()")
  a87d92223084 ("platform/x86/amd/pmf: Use struct for cookie header")
  1e7a14ee259e ("platform/x86/amd/pmf: Fix possible out-of-bound memory acc=
esses")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/amd/pmf/tee-if.c
index dcbe8f85e122,75370431a82e..000000000000
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@@ -246,19 -246,22 +246,24 @@@ static void amd_pmf_invoke_cmd(struct w
 =20
  static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
  {
- 	u32 cookie, length;
+ 	struct cookie_header *header;
  	int res;
 =20
- 	cookie =3D readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
- 	length =3D readl(dev->policy_buf + POLICY_COOKIE_LEN);
+ 	if (dev->policy_sz < POLICY_COOKIE_OFFSET + sizeof(*header))
+ 		return -EINVAL;
 =20
- 	if (cookie !=3D POLICY_SIGN_COOKIE || !length) {
+ 	header =3D (struct cookie_header *)(dev->policy_buf + POLICY_COOKIE_OFFS=
ET);
+=20
 -	if (header->sign !=3D POLICY_SIGN_COOKIE || !header->length)
++	if (header->sign !=3D POLICY_SIGN_COOKIE || !header->length) {
 +		dev_dbg(dev->dev, "cookie doesn't match\n");
  		return -EINVAL;
 +	}
 =20
+ 	if (dev->policy_sz < header->length + 512)
+ 		return -EINVAL;
+=20
  	/* Update the actual length */
- 	dev->policy_sz =3D length + 512;
+ 	dev->policy_sz =3D header->length + 512;
  	res =3D amd_pmf_invoke_cmd_init(dev);
  	if (res =3D=3D TA_PMF_TYPE_SUCCESS) {
  		/* Now its safe to announce that smart pc is enabled */
@@@ -270,8 -273,8 +275,8 @@@
  		schedule_delayed_work(&dev->pb_work, msecs_to_jiffies(pb_actions_ms * 3=
));
  	} else {
  		dev_err(dev->dev, "ta invoke cmd init failed err: %x\n", res);
 -		dev->smart_pc_enabled =3D PMF_SMART_PC_DISABLED;
 +		dev->smart_pc_enabled =3D false;
- 		return res;
+ 		return -EIO;
  	}
 =20
  	return 0;
@@@ -436,46 -458,13 +441,46 @@@ int amd_pmf_init_smart_pc(struct amd_pm
  		return ret;
 =20
  	INIT_DELAYED_WORK(&dev->pb_work, amd_pmf_invoke_cmd);
 -	amd_pmf_set_dram_addr(dev, true);
 -	amd_pmf_get_bios_buffer(dev);
 -	dev->prev_data =3D kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 -	if (!dev->prev_data)
 -		return -ENOMEM;
 =20
 -	return dev->smart_pc_enabled;
 +	ret =3D amd_pmf_set_dram_addr(dev, true);
 +	if (ret)
 +		goto error;
 +
 +	dev->policy_base =3D devm_ioremap(dev->dev, dev->policy_addr, dev->polic=
y_sz);
 +	if (!dev->policy_base) {
 +		ret =3D -ENOMEM;
 +		goto error;
 +	}
 +
 +	dev->policy_buf =3D kzalloc(dev->policy_sz, GFP_KERNEL);
 +	if (!dev->policy_buf) {
 +		ret =3D -ENOMEM;
 +		goto error;
 +	}
 +
- 	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
++	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
 +
 +	amd_pmf_hex_dump_pb(dev);
 +
 +	dev->prev_data =3D kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 +	if (!dev->prev_data) {
 +		ret =3D -ENOMEM;
 +		goto error;
 +	}
 +
 +	ret =3D amd_pmf_start_policy_engine(dev);
 +	if (ret)
 +		goto error;
 +
 +	if (pb_side_load)
 +		amd_pmf_open_pb(dev, dev->dbgfs_dir);
 +
 +	return 0;
 +
 +error:
 +	amd_pmf_deinit_smart_pc(dev);
 +
 +	return ret;
  }
 =20
  void amd_pmf_deinit_smart_pc(struct amd_pmf_dev *dev)

--Sig_/S96XBdrT0g5sPlo.kERvx0p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqeS8ACgkQAVBC80lX
0GzdiQf/T2BOMvKQbMHbRZx2RvMUHun76ECGuJVWcU7A9BXLDlfn1640o+i5Dj9j
OVRg8jPfND3VcvPBLVGvaV8DYU7MQpFWa4UHSLJ7EE0RVBwyH+Bna/Gl/FvX760U
JPJyv40rrZrGCJho1bYUtUVorpjZu0FRG9HdTRTdKeUCA0f8JLjCYwV6MwgS5tEq
iuL1YnmfEuJBNojRKVy/qsN+LZRADH/uaJTNj+oIdo1xnb7YA1auv7tiSa5OHypH
NrOca/jqZTo/KvZdzKoNXBwhHVnum0WL1vf8j8OMoUG3QAx91NR91BEYyERx9nOr
ETDUHnqvom/jtwHpwdkpoyjNPbWrYA==
=l/0D
-----END PGP SIGNATURE-----

--Sig_/S96XBdrT0g5sPlo.kERvx0p--

