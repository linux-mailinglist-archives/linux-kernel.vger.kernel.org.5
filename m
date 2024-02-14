Return-Path: <linux-kernel+bounces-64719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204488541E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6B21C21FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998510A28;
	Wed, 14 Feb 2024 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LXtpSq19"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0910A01;
	Wed, 14 Feb 2024 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883049; cv=none; b=mV7dGzPHogot5/6WdXyEI62med4gLu/+cBMacUtHHlUzREtT9dBrQJ8PW/nEo2HkXhEZPMIfjrPBYDXM9VxB/DcMnun22EL2G4SweTfkCtYKfTnIuMahurXH5H5lNh4pLIYwgRq6ZbIFhxnDLKOkFLnMXuJ3ttzwHPLt2uh6eFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883049; c=relaxed/simple;
	bh=zxY1NxVAn1nisbl4u0hUZB9a6MbHKB4+qhF4vQzJKEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qEuJOBag7RNdiHqteFL3YJdwdsLv5IhnVm/XgkEtV25g9irvEHO7h6CONyQVU+wRSDLvN9lDdknQmqgoKS2jglWrrAzGdmNmG6zgLSr1II4TL+c+tc1pZ5blW6jP2Iqa2vN6ZPKAv6X4QtG3xzkUqUt9ZzHTnauIaI5lkC3DqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LXtpSq19; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707883041;
	bh=dgyYgFmzQ5NK1gmtTNsr2ZOvUhuMhwO/DsPxh4kzAB8=;
	h=Date:From:To:Cc:Subject:From;
	b=LXtpSq194mFCvFGuq+9DaNsa10nnzCJuqOLSRjGOqkXBI2G2PTFfCuH4rSohZcfrf
	 wgYsh1iazM43nlF6r/xpz2IIdkS+rzxf60DOE8JZCyVYn9w4QmT3/lGN23xKBIjZ69
	 iLyeTaXnk+R2VwOjXey8Vxs4LsHcHn4EluIrEQQjHW4kx26VjVCLHlslhZJZgWuAut
	 qa09W5CCz+WUYCGxBaxx25DvJDvOTWRxc82TbtlwGhvhGA0NiRLG/y6x9q/UNga96r
	 MEsb/J9v9teeAYo3Be9oNQ0ZEEi6d4yoT7a3UrXFY8+x8Av9hyDuTE7ERpVFJGmpCm
	 6F5qVRGFIlcVg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZPXc4pJyz4wcH;
	Wed, 14 Feb 2024 14:57:20 +1100 (AEDT)
Date: Wed, 14 Feb 2024 14:57:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240214145719.1cc4f320@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x=FO2pFdhLcvjk2f/1RDr7H";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/x=FO2pFdhLcvjk2f/1RDr7H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc defconfig)
failed like this:

In file included from include/linux/page_ext.h:7,
                 from include/linux/mm.h:22,
                 from fs/sysfs/file.c:18:
include/linux/stackdepot.h:59:39: error: 'CONFIG_STACKDEPOT_MAX_FRAMES' und=
eclared here (not in a function)
   59 |                 unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES]=
;    /* Frames */
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

(and many more)

Caused by commit

  18d4230bb372 ("lib/stackdepot: move stack_record struct definition into t=
he header")

from the mm-unstable branch of the mm tree.

$ grep CONFIG_STACKDEPOT .config=20
$=20

I have reverted the following commits for today:

  7e56cf9a7f10 ("mm: add swappiness=3D arg to memory.reclaim")
  6290011d1ce1 ("mm: add defines for min/max swappiness")
  afb37edbd1e3 ("mm: optimization on page allocation when CMA enabled")
  0b222ac0b19c ("userfaultfd: use per-vma locks in userfaultfd operations")
  f8b7d8e37cb3 ("userfaultfd: protect mmap_changing with rw_sem in userfaul=
fd_ctx")
  cd8df983e066 ("userfaultfd: move userfaultfd_ctx struct to header file")
  292f31cdb470 ("mm,page_owner: update Documentation regarding page_owner_s=
tacks")
  76d2da5f4805 ("mm,page_owner: filter out stacks by a threshold")
  37781739c4ad ("mm,page_owner: display all stacks and their count")
  525a88caf59c ("mm,page_owner: implement the tracking of the stacks count")
  18d4230bb372 ("lib/stackdepot: move stack_record struct definition into t=
he header")

(from 18d4230bb372 to the end of mm-unstable)

--=20
Cheers,
Stephen Rothwell

--Sig_/x=FO2pFdhLcvjk2f/1RDr7H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXMOh8ACgkQAVBC80lX
0Gzz6QgAm8mse8caKBXOUVR9cMX7DiEmDZOnhdLrMCnm+TELuZN9/ACTgM/YT493
b/eZdYOY4h3Vb5MKeRdScmfWlCIaLSRhE11zVe6bpZ3VMo0PTsJdA62BROdl6Kqz
rILeTTd10drL6grQRXCKsscZmJr/LZlR0u9f3nmA8CcDwPipco9gfY81p2hTpK+F
MCMRadzLBtfXf1riWz+UrvTwh58bpE9MkMj+El0gabqJDB1fwk5Z221TwlxUqxqp
fwyNMCQ113W+QdmORrLjB7CqEzbrXirbKeMgDS2RaiKCR2+eH1E767hyygVs6qON
kmTIvSXmKonW7Gs3tNlrvDCKptxkeg==
=9p0r
-----END PGP SIGNATURE-----

--Sig_/x=FO2pFdhLcvjk2f/1RDr7H--

