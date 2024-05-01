Return-Path: <linux-kernel+bounces-164941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C44EB8B8547
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645331F22A75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349444361;
	Wed,  1 May 2024 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OEnKf3Bv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86F2576B;
	Wed,  1 May 2024 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540776; cv=none; b=E7x7mH9KA+xF6yQSc1Rx6dfL0iqNxjBOAVhBuZmCG6DwQ/muQmkGZzFr+KEw3n66Fgr8mMhR3MPYxd50i+npUdRgmuu60xenvM3E8ufcTE99qhPUVbLxLCUjWzwAdiRh+qkkCNdDyAPUMJDP6epOKtL4ODaOdov3LNMqPXCh/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540776; c=relaxed/simple;
	bh=rZOVMkjacxk6ggX2MZ0ySIKeOu+bur476T2sZGzGrI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=quDqmlc4xm2FC6qP//fw8yNxyQlD06V2Ofw6scCqxX5zifz7hgAik6VBvGOuQcWcwqXRTMNuHzU+0fTOIjn6LwXfETQpB9n/pPrnJMs4K5zp+cVfLF+dXv9fGrRGQC0JI7l++PnlH5rcOltrWR+FiK7GCGeSVBzszT3YeqZdVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OEnKf3Bv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714540770;
	bh=qIOMi5cZWSDGMcCVi4MgiYeL0Wgytoc+x8bs5oC5YgA=;
	h=Date:From:To:Cc:Subject:From;
	b=OEnKf3Bv4CmkjWVQpyVhJR8IU9hmp3QnGVs8GcO81IE/iYHQZXH8CR3cU7itiOfE5
	 WCSJlUCRUN2alsLkNZoeUPM3WVsGz+Ub/C98uuw+Hn8/IhCzySNKQnc0rBqOTnJQTy
	 AN69gdnWfUKoMcv3oQfS6tq+Y5VjIvsmOFA1DHx4uYtne4D9uWjB9jb1WJ/AYHsb11
	 cMCexrqGej4+8TWLsTlCCvVnF7nTdOqBH0owMl+f2EAiy50Fr0mDbz1AFAjbZw3Pf7
	 2gmb8MlL8JTGEB+Wf0mcwusYJ2bJJzq5zPoeVt0X3TrP6n/jDEc08BWy0C7iMgTMFm
	 PR21C0NaLoUuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTljt3FFSz4wxf;
	Wed,  1 May 2024 15:19:30 +1000 (AEST)
Date: Wed, 1 May 2024 15:19:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20240501151929.219916ee@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//XGt8rXHGLsv+32atP6I7T1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//XGt8rXHGLsv+32atP6I7T1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:581: warning: Function pa=
rameter or struct member 'idle_workqueue' not described in 'amdgpu_display_=
manager'

Introduced by commit

  afca033f10d3 ("drm/amd/display: Add periodic detection for IPS")

--=20
Cheers,
Stephen Rothwell

--Sig_//XGt8rXHGLsv+32atP6I7T1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYx0OEACgkQAVBC80lX
0GxqKAf/d30FYXwhVSxsM1+mBP3YLfd+W/gOhfsAW/B/ksEkT8rQISKzlrxKcY2K
vJkXDF22v0AYS/qBvrEj50tvhzgSKcsyr7jGwQZ8wydj+uPzOrqyQdG9ul71rs5C
gEoJLc4ULBLUGXt/t6gJSPHrtIsbFezgTJ24DV6WDtQ0+62Ey439Cs81U7YlcGoA
x2sKaPd4rqKiOJELt8Y7YhyrzarKuEp7JYBeOR2iv1kxh1c+SFXYR8CruNBJqave
kropRFHN6lzHDYml+6tBSpGjOkGMW9HZzYzfY+jGEcemHcRr6dzG9GenbEHK8V+m
Wzic4L/kCg+QuAeMqmrKsjRqcH9LtQ==
=//8Z
-----END PGP SIGNATURE-----

--Sig_//XGt8rXHGLsv+32atP6I7T1--

