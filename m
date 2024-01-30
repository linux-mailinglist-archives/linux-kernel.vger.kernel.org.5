Return-Path: <linux-kernel+bounces-43861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53208419A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6049D2839D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D136B1C;
	Tue, 30 Jan 2024 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DlGg72ta"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7036AE5;
	Tue, 30 Jan 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583268; cv=none; b=UFkPlYwaZ0BCsL9IM30qVo6Umvs3s0JSX9BemJSuh0PYg+jVKLgbZwdqpVf0QlRy9WYD2sZ+bVe8vGViMkNWlytiCZ11y/izf1tthPLgNFjj464lRjK3DSwrXJtjK4hEhL3fv1DfH+O+ec05II6qaoHFW+zpARtR4YDq+4ncvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583268; c=relaxed/simple;
	bh=IA86VqfqIchBE1MfUFXV8Wpr2UKabu8+tu6XaU/XXPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=odVX7se/lBrXu/MYnuxC4hjmqtFSzZzEFmFKnbwOX0tGvDqEvL6dgZ8WRec2vB5eRLbG1A5+xtr2r0UVKQQEcbsPrOEEtC7wYvsx+3laho/WjloBPccuvSys7AY40lsQTQpdp/Er4DnMFqKJOTE7I3heVHO68vfPzlwWxhW2Z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DlGg72ta; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706583263;
	bh=EdAkFP733cEuXQh07GTpPK4SF6dq0gAnpERjGKXV280=;
	h=Date:From:To:Cc:Subject:From;
	b=DlGg72taDiLeh1r9jSxB0mO0yUeB/mDCafrC0kg1EVOixpBoB0zgzJkpql03hZ8GH
	 heTEiP1rGqHDxUHmYBFopKtWGIYFxj4t7O0FiApXk+BDE33veJAbJHDJIqFbfYQqIT
	 6vBJRlAJZlxLLlCp7NiagUp9Yu8OBPhHUbwCjn9O0GCdjKUaCUWkRve7aja/YpYmwH
	 Kf4f9GPIIgSbiV+m7hjk2JKteY1laZcdZtor9uC17YegqUEpLTy8LswyhIVuICxGfg
	 2I0AnB4mezT0z4vO0z6RmyhmUIK7eaV77eX6BlT0rlZtkUzc945Tjhl9ODxDYPXDFI
	 RmFmSLBvaESwg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TP8rv2TdBz4wc3;
	Tue, 30 Jan 2024 13:54:23 +1100 (AEDT)
Date: Tue, 30 Jan 2024 13:54:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Dave Airlie <airlied@redhat.com>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20240130135421.19907631@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lcOaDuwG8rKF.1zDt96NBeM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lcOaDuwG8rKF.1zDt96NBeM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comme=
nts found
drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comme=
nts found

Introduced by commit

  0fba33311e63 ("Documentation/gpu: Add entry for OPP in the kernel doc")

--=20
Cheers,
Stephen Rothwell

--Sig_/lcOaDuwG8rKF.1zDt96NBeM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW4ZN0ACgkQAVBC80lX
0GwSpwgAh79BjBH9g/ynPZZz7rkRnVZ6rrKNoABbWxrbQ972ZvtpmH/2bKkEoJNJ
RJO729SVqwJEJW2IW5KO0ZhrnQYQfMiwJPJ5XaftUgEomRJz6YcuAIVeZdxjKf9P
Y+1BV37+GVES/ZEX00fVME+Hr8F1P4omWNJH/lq6pYHtECO2XfBLKgCemFZgUQXF
BRKVlv7EdHhYtp9zbgrKjj+QfOEI5BIvxbf+vr8ckFwzAKHXqgoKn1K6HFj6EJ2n
pugUVFp1XcSbvwQDRs55r6UxBTnldUczp3Gcetw27z7QFE8TuE0+hPG45nmkjIJ9
ZjjqvGCSVgc4iDdPjknl33fhcmg5Sg==
=BD5s
-----END PGP SIGNATURE-----

--Sig_/lcOaDuwG8rKF.1zDt96NBeM--

