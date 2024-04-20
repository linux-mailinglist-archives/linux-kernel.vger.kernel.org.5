Return-Path: <linux-kernel+bounces-152105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838488AB933
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D8DB21E90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16E08C1D;
	Sat, 20 Apr 2024 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jb3n1Qnc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D22563
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713583484; cv=none; b=cvWQP9jJk2oAqsPWWOoZZNRwnnUXcReSwwGkfIoxz0A/ybXS6yfgQo7I7nMf3BTtRuJi1NcPWUko+7pzDHSTXVyX6LafvbdoYrDE4A7f0VxUHtXCxkFMcZRamkdiKLSJG097V+hppUS1/yRY0GwK5UOE1VZbbNqtEWuiekXGRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713583484; c=relaxed/simple;
	bh=gIluYYYuzua86iS61bGW9en/WaGHePRXMIdz5GXcUG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LhhhDGqdm/XedMQxm/jnXRp2V54Pk5nsdBdUTZuXoveIeTmSE6iagrxchOzwmwQncI6/tjsc0jN+63MwIWqWIHKLawJ3s8gx04ZXEmwjlQjMYm+b0fq6++rcuxyKXUBzAi51GpJGb4k9y7LdzpGjMrE+CblqTQZ8Stp052LRGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=jb3n1Qnc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713583478;
	bh=QSEFJcDkqnsnAMU/Ge1i+z1kKqo7SuN9MsF+v00cPIs=;
	h=From:To:Cc:Subject:Date:From;
	b=jb3n1QncF9hFFcPfMacNi+/OzL6WOoN3nW+lwLJbbm1K9IzVbaDb0Fij33SVwwmo+
	 LrhaJFdWyU+kEfn5D5P6aRCqikn7u5RegbHm8ZvDyUwLUkgt8+YT7iFODZydZz+3w5
	 UNVImiihAdqeIv4M94gHs/awrDzzLquk1C80bAy/+RHzzZ3+ru/7eOHwpQR7mLJbR8
	 QYA3T7dP982ZnUEWqZkIucJ8eyntMD+29wfUOpF4JKkj7Requ2vyHRxJ7uLjkJwAPW
	 dy5+A5WTVrULsZU4SFeeEilzaBZi9d31IGlznOPc86K2/q+RA3xC8P2tY4nKJAiZR/
	 qZkiC9Y36y8TQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLxhP5P1kz4wcF;
	Sat, 20 Apr 2024 13:24:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nathanl@linux.ibm.com, sbhat@linux.ibm.com,
 msuchanek@suse.de
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-3 tag
Date: Sat, 20 Apr 2024 13:24:34 +1000
Message-ID: <87jzksaf7x.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.9:

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.9-3

for you to fetch changes up to 210cfef579260ed6c3b700e7baeae51a5e183f43:

  selftests/powerpc/papr-vpd: Fix missing variable initialization (2024-04-=
12 14:40:07 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.9 #3

 - Fix wireguard loading failure on pre-Power10 due to Power10 crypto routi=
nes.

 - Fix papr-vpd selftest failure due to missing variable initialization.

 - Avoid unnecessary get/put in spapr_tce_platform_iommu_attach_dev().

Thanks to: Geetika Moolchandani, Jason Gunthorpe, Michal Such=C3=A1nek, Nat=
han Lynch,
Shivaprasad G Bhat.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc/crypto/chacha-p10: Fix failure on non Power10

Nathan Lynch (1):
      selftests/powerpc/papr-vpd: Fix missing variable initialization

Shivaprasad G Bhat (1):
      powerpc/iommu: Refactor spapr_tce_platform_iommu_attach_dev()


 arch/powerpc/crypto/chacha-p10-glue.c               | 8 +++++++-
 arch/powerpc/kernel/iommu.c                         | 7 +++----
 tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c | 2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmYjNHwACgkQUevqPMjh
pYCbuA//VsCCZotHFjCuEMX4hKFE+FS7doJ6HAaj1lysJLVQsXW94pEufcy53hXX
y4DQ06Y2vV/zJTrbYk/3vukeMDcc7ZSE9IKZlnSvZP1GizGF2dQE/AjsqNfJ5iV4
1YcE22fmjoSIL2pbD337r1BHqEwGvcd47Rm0SET6yIxQamTKHLAa7Q9OIindDMaq
Qu/g6LFoa856idDkXRY96xNWRodGzNyhZ3+16F4jsE2pbGiYNbjqyua3ke8leWgI
DInYs9KholNeg285Qbjq6VaXcMjJG6po8N/MDJDxdysVhF+9GTXlyKSN9oURDUtf
IDWpbrF3n7WE3iUllucKWNXBQbfX5yoFlZ7PnOj+Tjm1RcyBZDBhoq05DNcosFY0
Mgbg7hKluxUP7ijSMOOKKYasMrNqJofo+f3S78L3sBDjIW2w/j6+ZP6EQ515t7he
/oac+WfFr6m0rEtQtZuf0TMPWv60odfjkLuGFomcd5qpldXesMfR62rT+RSN3M7m
7kJj4duYpKJJZEdOdj9PzVMqQd/dd5cpeO2b1vJef7G6lHXRaB0tTaDMnvZBNtlL
7etRE5g1ErvOFGnoAzeXcU3GFU2ZO49cpKMjqwubivufNXDwZ7VKJfPjIsb4cfm0
lsquI0A5FhkIDr1G/0wL4VyCisKYCAuYj9NCSf9F9iM+92w+fKo=3D
=3DgaHh
-----END PGP SIGNATURE-----

