Return-Path: <linux-kernel+bounces-99158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3087844B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4902B2833DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC9245943;
	Mon, 11 Mar 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="imN2A/yH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4A3D57A;
	Mon, 11 Mar 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172653; cv=none; b=UQPIH+lJCdA1ai6kcB4vTMMsTKAgP5UK0V5Gp35LmxVRRwqaxbHrruV4EOwavQVezX0BITrZmgp7O795F7YRlSa55lQFVXr8q4SwnAMXjKe6Sd1eLIEXHZMxQZeOu70LCoLBAX75+loUak4Qbcc0E5HkJxWWQn4xJzUslshi7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172653; c=relaxed/simple;
	bh=+JzLhUHlznDSPhMmybaDQJjRbxgOMb9QjNIs1IIzdnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tMFkpIE3C4FBxfCgdxo3y1z8DgIra++QjavBF2iyL8+GS4nHV5moOx/XOTTy8Qi7zCiAtXrxPr1+mXSVSlJksqJMykbj2EKXt7zNIzrHm7OJ93DBnIyouULl2FxDMvVZoubDx34b/47oNTBEbKi1lulJHQKjbRARJON3oB/dCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=imN2A/yH reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1B7E40E016C;
	Mon, 11 Mar 2024 15:57:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IcmgLqOfcd0G; Mon, 11 Mar 2024 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710172641; bh=4UcCZrez3KOXdj+RqoFy/4ZD2HYEO1uqfdsR63iT0ww=;
	h=Date:From:To:Cc:Subject:From;
	b=imN2A/yH8qcUcdLiqGDtnIaP7fn/F32xaaWYl2n08zuq3YsKWdI8vxLY6JJWJGEzT
	 TgQGd8CDGxSU7daY3bBHCaIDy1Jn55YDQYN8FsUq8RI+tB2WXRb1naQWzCf47Od4x4
	 7oRAUeIzKczODiwI0OTXQwKRk+ef42T2gitrGsFTXJHm4MbcLSZEuTxnMbLZmy8sCL
	 Ik/uFeHPvT+g+IRyVOflyrQRwL84oTaAz9AoYnGP4fFa+d1DAumYZysaBHt5m7yDQL
	 g9N2186JSmK4i+YfvBdGWad04fNkei0G6uHb4+5m1KQFZWSUMa1etVtL9COawDwsKD
	 6dRdy1Q0Y5WWi8FbBcRb6Rf6E1lciMyCDbieq/Bx52fZQydxETfJTaBWsSap4v2lWx
	 0rsonVYSsuwAmNCe7vQEU5zS/G5buKTg16LI1DHhF51vhcyMUEcNazU4QkPfI9cgIR
	 yoj/RzkvG9APwIrCSdYgHZgNrimCTSM0WKvghYOc6lDQHD8y8nC8SvMIU+4OcqFoG8
	 fgNIYQX/wdKKWQda58lSw7y2+6VqnkEkEd3Gm+Tkpy7+EEf7x3sRudDbNjh5DyCr6r
	 YUJfTxOmOZ503CuPvKJwfYEL5Y/96fONKWxFTVEpV+lL5ynNXE5hNfkS4gsbG937/d
	 XxKpAA1DXbiet/g/1uUHFjlI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B176340E0028;
	Mon, 11 Mar 2024 15:57:17 +0000 (UTC)
Date: Mon, 11 Mar 2024 16:57:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.9
Message-ID: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull EDAC updates for 6.9.

Due to the topology changes from tip, a oneliner is needed to be applied
as part of the merge commit:

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 08c6dbd44c62..59b6169093f7 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -315,7 +315,7 @@ static u8 get_die_id(struct atl_err *err)
 	 * For CPUs, this is the AMD Node ID modulo the number
 	 * of AMD Nodes per socket.
 	 */
-	return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
+	return topology_amd_node_id(err->cpu) % topology_amd_nodes_per_pkg();
 }
=20
 #define UMC_CHANNEL_NUM	GENMASK(31, 20)
---

Linux-next did test with a similar diff carried on forwards:

https://lore.kernel.org/r/20240227134352.6deda860@canb.auug.org.au

but we very recently realized that
s/topology_die_id/topology_amd_node_id/ needs to happen too.

That's not a big deal, though, as these are all new drivers for new
hardware which pretty much no one has yet so there's no risk of breaking
any existing machines out there.

Thx.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_upd=
ates_for_v6.9

for you to fetch changes up to af65545a0f82d7336f62e34f69d3c644806f5f95:

  Merge remote-tracking branches 'ras/edac-drivers', 'ras/edac-misc' and =
'ras/edac-amd-atl' into edac-updates-for-v6.9 (2024-03-11 16:24:20 +0100)

----------------------------------------------------------------
 - Add a FRU (Field Replaceable Unit) memory poison manager which
   collects and manages previously encountered hw errors in order to
   save them to persistent storage across reboots. Previously recorded
   errors are "replayed" upon reboot in order to poison memory which has
   caused said errors in the past.

   The main use case is stacked, on-chip memory which cannot simply be
   replaced so poisoning faulty areas of it and thus making them
   inaccessible is the only strategy to prolong its lifetime.

 - Add an AMD address translation library glue which converts the
   reported addresses of hw errors into system physical addresses in
   order to be used by other subsystems like memory failure, for
   example. Add support for MI300 accelerators to that library.

 - igen6: Add support for Alder Lake-N SoC

 - i10nm: Add Grand Ridge support

 - The usual fixlets and cleanups

----------------------------------------------------------------
Borislav Petkov (AMD) (3):
      Documentation: Move RAS section to admin-guide
      RAS: Export helper to get ras_debugfs_dir
      Merge remote-tracking branches 'ras/edac-drivers', 'ras/edac-misc' =
and 'ras/edac-amd-atl' into edac-updates-for-v6.9

Dan Carpenter (2):
      RAS/AMD/ATL: Fix array overflow in get_logical_coh_st_fabric_id_mi3=
00()
      RAS/AMD/FMPM: Fix off by one when unwinding on error

Lili Li (1):
      EDAC/igen6: Add one more Intel Alder Lake-N SoC support

Muralidhara M K (1):
      RAS/AMD/ATL: Add MI300 support

Qiuxu Zhuo (1):
      EDAC/i10nm: Add Intel Grand Ridge micro-server support

Shubhrajyoti Datta (1):
      EDAC/versal: Make the bit position of injected errors configurable

Uwe Kleine-K=C3=B6nig (1):
      EDAC/versal: Convert to platform remove callback returning void

Yangtao Li (1):
      EDAC/synopsys: Convert to devm_platform_ioremap_resource()

Yazen Ghannam (9):
      RAS: Introduce AMD Address Translation Library
      EDAC/amd64: Use new AMD Address Translation Library
      Documentation: RAS: Add index and address translation section
      RAS/AMD/ATL: Add MI300 DRAM to normalized address translation suppo=
rt
      RAS/AMD/ATL: Add MI300 row retirement support
      RAS: Introduce a FRU memory poison manager
      RAS/AMD/ATL: Fix bit overflow in denorm_addr_df4_np2()
      RAS/AMD/FMPM: Save SPA values
      RAS/AMD/FMPM: Add debugfs interface to print record entries

 .../admin-guide/RAS/address-translation.rst        |   24 +
 .../ras.rst =3D> admin-guide/RAS/error-decoding.rst} |   11 +-
 Documentation/admin-guide/RAS/index.rst            |    7 +
 .../admin-guide/{ras.rst =3D> RAS/main.rst}          |   10 +-
 Documentation/admin-guide/index.rst                |    2 +-
 Documentation/index.rst                            |    1 -
 MAINTAINERS                                        |   15 +-
 drivers/edac/Kconfig                               |    1 +
 drivers/edac/amd64_edac.c                          |  286 +-----
 drivers/edac/i10nm_base.c                          |    1 +
 drivers/edac/igen6_edac.c                          |    2 +
 drivers/edac/synopsys_edac.c                       |    4 +-
 drivers/edac/versal_edac.c                         |  199 +++-
 drivers/ras/Kconfig                                |   13 +
 drivers/ras/Makefile                               |    3 +
 drivers/ras/amd/atl/Kconfig                        |   21 +
 drivers/ras/amd/atl/Makefile                       |   18 +
 drivers/ras/amd/atl/access.c                       |  133 +++
 drivers/ras/amd/atl/core.c                         |  225 +++++
 drivers/ras/amd/atl/dehash.c                       |  500 ++++++++++
 drivers/ras/amd/atl/denormalize.c                  |  718 ++++++++++++++
 drivers/ras/amd/atl/internal.h                     |  306 ++++++
 drivers/ras/amd/atl/map.c                          |  682 +++++++++++++
 drivers/ras/amd/atl/reg_fields.h                   |  606 ++++++++++++
 drivers/ras/amd/atl/system.c                       |  288 ++++++
 drivers/ras/amd/atl/umc.c                          |  341 +++++++
 drivers/ras/amd/fmpm.c                             | 1013 ++++++++++++++=
++++++
 drivers/ras/cec.c                                  |   10 +-
 drivers/ras/debugfs.c                              |    8 +-
 drivers/ras/debugfs.h                              |    2 +-
 drivers/ras/ras.c                                  |   31 +
 include/linux/ras.h                                |   18 +
 32 files changed, 5164 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/admin-guide/RAS/address-translation.rst
 rename Documentation/{RAS/ras.rst =3D> admin-guide/RAS/error-decoding.rs=
t} (73%)
 create mode 100644 Documentation/admin-guide/RAS/index.rst
 rename Documentation/admin-guide/{ras.rst =3D> RAS/main.rst} (99%)
 create mode 100644 drivers/ras/amd/atl/Kconfig
 create mode 100644 drivers/ras/amd/atl/Makefile
 create mode 100644 drivers/ras/amd/atl/access.c
 create mode 100644 drivers/ras/amd/atl/core.c
 create mode 100644 drivers/ras/amd/atl/dehash.c
 create mode 100644 drivers/ras/amd/atl/denormalize.c
 create mode 100644 drivers/ras/amd/atl/internal.h
 create mode 100644 drivers/ras/amd/atl/map.c
 create mode 100644 drivers/ras/amd/atl/reg_fields.h
 create mode 100644 drivers/ras/amd/atl/system.c
 create mode 100644 drivers/ras/amd/atl/umc.c
 create mode 100644 drivers/ras/amd/fmpm.c


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

