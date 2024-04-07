Return-Path: <linux-kernel+bounces-134652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F689B479
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C66B20FD7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13044C85;
	Sun,  7 Apr 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EfizJiwh"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D526AE3;
	Sun,  7 Apr 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712527781; cv=none; b=cHUe0cBTJ7Djug+H/CwrQV2vQYbH7/U5Q+HDj6wAdbLH3DIEDgxqg4cQlCyx6havm0Fy1Dxq3+D3q3VVwuXFtPW6pbnkNvposeGHm65m7vMg9a86GVHNbiYm0DPO5kTU41BxPr4wZWYcjoC4kpyO4PETuh1CVr9kmIZ1g17AmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712527781; c=relaxed/simple;
	bh=G+rISRl5eWcpvlB08D23avmK4EbyeKyo3bjKlJLrs5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mspQ5fLWfP1IKBhYSYrHtMz87A6fOhmNqDOdbhinwKy39QNIRzZ9Wad7UrmTpdVIYL83qEFHPFvf5H/IsAjuyhY+YaUe7ir+aMzf765QqUB6JiHQSH3Am4/PBsAK2PTAhW9GoIh9wWXy7drnLxanJYuL5eE9KsjDEsw+Z7KcoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EfizJiwh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712527776;
	bh=G+rISRl5eWcpvlB08D23avmK4EbyeKyo3bjKlJLrs5o=;
	h=Date:From:To:Cc:Subject:From;
	b=EfizJiwhJ9BFz4rzJ0iBS5pHbnHE51FSemcarfBQMLorA05hG1zhNotx6gDyc7PJ+
	 K6PdotHTNlv4RA+76qNeEtint6kRjS6rJJozxLZwAkmZjO1DnXJVKCvJ8eJlrqIyO6
	 oNb4b9qiokc3GI4qx1K+mfzkv+gL4e57YogyS5dGsWqSS7PiqDOiY6iTX5z005JzNN
	 23TI5rXfAmM6FQesD0y2pdX39BrP/GYwtLuT+d6mKtvbioW+j5Tx0yfhJSQ31uSCBn
	 4NMVQWQtalPY/uZG8jb7Lzz2rqyZH38Sp1vZTfs/6b3j8uZcBnU+ddNsZe/VdvZWE/
	 Ylp3g5JzMcljQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCRGS5dFJz4wcR;
	Mon,  8 Apr 2024 08:09:36 +1000 (AEST)
Date: Mon, 8 Apr 2024 08:09:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error when fetching the exportfs tree
Message-ID: <20240408080936.47d5da45@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e4k+0QS=DPp4P.M2XZPMd.8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e4k+0QS=DPp4P.M2XZPMd.8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the exportfs tree produces this error:

fatal: couldn't find remote ref refs/heads/exportfs-next

--=20
Cheers,
Stephen Rothwell

--Sig_/e4k+0QS=DPp4P.M2XZPMd.8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYTGaAACgkQAVBC80lX
0GxpNAf+LKoKCDF9r9WwSJsTC9tZCMcvkpfTcADF5jakknHt/7BK0UEgXJ598D1X
6K9GReS/Hc+HbbHj2qj24foFqVNAm5LL9yKwrFOv8nZrGe5HtcKn+N/JOSilFr31
04n+wUeWkSnv2lOMHHuLIcoUXQSyV3Tr+7eNmPP9MshGRos364M0lBUwNxnHbejQ
DEAScD6eJL3n5J0kFgtlfvw64sEglXyxv8mLOtRLEvKREkkKUdgOClXqfY5atWBm
x7CTN8sZZ/YzGuW19ULZv8sf8vHJmfVIJodeQzZ10pB8Egh4RXvboPBJd7KpmHZ2
TTcwA45Eaq59GaV+otyKasq0BtCQOQ==
=Vnj2
-----END PGP SIGNATURE-----

--Sig_/e4k+0QS=DPp4P.M2XZPMd.8--

