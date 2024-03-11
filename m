Return-Path: <linux-kernel+bounces-98384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE54877947
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477FA1C20DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1664F;
	Mon, 11 Mar 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="Ug/TvaBx"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0546382
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710116487; cv=none; b=lQ2MGPBrfPd7Q0g9TJC8rs9gwzj3GchYnt3UEdiYUra9hMDFTaJH4hYc9IwIHXWioVW78zE9YgBX5aLqPVX0ohG9Y6Jiql1u565T/l1GF1nZfoWbiiKIzGlaPcqsSjGPgbCxqYTT+YdolC4rlJ5hNpc9KAk8oadJSdclPIDkRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710116487; c=relaxed/simple;
	bh=U+sxRRHPcpCTUp9Fy/kQzoAU3jSMw5ywh6nROufz+zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQdlkoESpx+cQSldDZSusEYF+l+pF8qfQY+dBPScf0DPIS0VXc9Bfl5fUw+smaPaoL7xebg6MohLdyD/Ze362bBqxLzNOtGZe8bdRoQpv+wSBMifP4ApwsqlYqq2RTuOTO/ymH4tP3hA4ROMtM8gMetHw+qYuy9XY060QamU0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=Ug/TvaBx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1710116476; x=1710721276; i=j.neuschaefer@gmx.net;
	bh=U+sxRRHPcpCTUp9Fy/kQzoAU3jSMw5ywh6nROufz+zs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Ug/TvaBxp+kz8KuaVU8O3X+kLj/R0zXkBti/xkje89GKMIcf04ilWR26/FgI3zBA
	 Z+50hVCa+FWZ4K7LpwATrlfWdtmBXbghHVSBlX5mobATmIL61DnrLmrZgT6ltVQbg
	 0xLACTfLw1t0DMclq6myvPBiXB9Rmn33qYZcydcoqgavJXwmeJpQKyTB1ZQCZipiT
	 x3/vtgxL26+MAJb8pfIhI4INhwQNNwGPVv7Jrpqaw4fhlpoWyn1kw7QgkO1v+7lXU
	 BjCjjHhDaFqo7ZyMBDeI60P8TijYyZvkekRQZAvDEYXXpR5Ah5xM91lL//FiCzeDd
	 McQLSk6JTtxLMeyYlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.216.168]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1qgOMF2KNT-013zfW; Mon, 11
 Mar 2024 01:21:16 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: openbmc@lists.ozlabs.org,
	Joel Stanley <joel@jms.id.au>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v6 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
Date: Mon, 11 Mar 2024 01:20:59 +0100
Message-ID: <20240311002104.2829298-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kUuwesSoIoTkia1ovBbz6lZETCKVQRyngZikpSKFzmdu99ATNVs
 QcMXLBDlWFLz2v707upXcCAUX1y9gI5Naq7jWD/p9LDmNT8rWfIDIdeTphrDa7RrPOBroPa
 ogwlKumg96QtW0Po7krBD7ho422LnpFHtBZ0B6/ksT1R9lbP5SAplMhcgFYEViTxFeQQZlO
 clxKXskFp2ejxLijggMmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LJ17IaWkbrM=;3zEqmJio95wLAbDJgUu14/E9N4W
 6w95NL807o3c9MImNJ7DL4qa1JGF1fA7V/92mbVe06OztD2W/LFXrhuOQurr+U8ynct/eOj69
 fx4ajdnhlPA6oGsqBv/zq7jqC4HFDkm4YznDOJ+GxmHCyfXU1PI8vxrtSJbGaPWaJpj1l4515
 QbIyT+jHlPY6BsXcTbdfYcghJv/y/14vx/vXQok887j9Nqsduya3KuhanbYQOQzTbZFrLFmRS
 TFaUcED80cbc1SXhRx0h5NoGXjGNqlWQPZ+SFSnA24dBc0pO+rExXfpcNe/EEkVnv4PQ25Vhn
 /NX/BZegoLxbIhYnc8smjT2WSvIhJ7hjTSfdRrhTTM2qO4uveYJJRoaDqTmEQ6TbrskmheKP7
 TtzRtfhUp9pJXhIWduW5N7Yx8AXUFa/w1WZ9gZAVm+yM9jbMx1YIJi7lHpLB83mgdlYRNN/Ud
 yhsYDFf84irkkqeYCP0bXAqVFAlEtb9Q/SDndLBstY5ozNGauym9uecwTsm9d411SzMdJlOfI
 +H7yCzVAuYrsQzPfdBZxWs5QQ3UkAYZLFMlK4oTeKyY98HiyiSfbhEJBAWhRJEwvysK5AFVpD
 rRghoajQb7nkF3A4gURI5C+vF2qbiwjO0Bwav3fgRAtp+MpajghZwoA03zB74BLAVrosLVdEk
 uSPUpgvlctQy/X/aicNRFiKRRer0gJ25E91mgJ1Yb62JS8SRHM357STyBGi91Q9cnIJaMg9FN
 Bxg/gp/GcLkeoSz4OE4lfPrwBoh0F5CswyvUWt4LYngAJRRxEN4hUS09PJsZkWMGva8rS5SOM
 fGcM8U3+Q0shhfwwBnR0auXsMbqksCZwV9fPQbzZEst4Q=

Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
driver when configuring a kernel without support for Nuvoton SoCs.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQ=
mQ5u+4Q8c7-wYQ@mail.gmail.com/
Fixes: 7dbb4a38bff3 ("soc: nuvoton: Add SoC info driver for WPCM450")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
=2D--
v6:
- no changes

v5:
- Rebase on 6.6-rc2

v4:
- Add Geert's tag
- Fix commit reference
- Change Link tag to Closes

v3:
- Split the commit into two
- Reword the commit messages a bit

v2:
- https://lore.kernel.org/lkml/20230212215234.2608565-1-j.neuschaefer@gmx.=
net/
- Commit message improvements, as suggested by Geert Uytterhoeven.
- Add Link after Reviewed-by, as checkpatch.pl now suggests
=2D--
 drivers/soc/nuvoton/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index df46182088ec21..853392c8a9151a 100644
=2D-- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig WPCM450_SOC
+menu "Nuvoton SoC drivers"
+	depends on ARCH_NPCM || COMPILE_TEST
+
+config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
@@ -9,3 +12,5 @@ menuconfig WPCM450_SOC

 	  This driver provides information such as the SoC model and
 	  revision.
+
+endmenu
=2D-
2.43.0


