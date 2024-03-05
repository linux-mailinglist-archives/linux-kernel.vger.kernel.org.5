Return-Path: <linux-kernel+bounces-92838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D708726AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4518B25345
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E77199BC;
	Tue,  5 Mar 2024 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV1/mXbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76E8F7A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663891; cv=none; b=G4n6x5kF2Q6W5hlVh3S5Yt7K/rzJD2KlBZsiobaQ/q1RCxTttAcuVGsh4SCqXH0F9BKum2YsnM2VYWEcFQGsnhYyaX9+DrT4rLPd+H/zvNFT2bb4zSaePWsbnqiWiIHsJyC8I8P/2wtPYX+EQaDmoYtNxo4r1kIo5C2CPVipy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663891; c=relaxed/simple;
	bh=Qvezb1qrdamuG9xcPUPJNIpdId4nIvMHCKBp3bs3C8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7o6U87UfL0RkMYmOD25gqW1NeloRa5IcU/gTN4uePWg+O/5+sSMTk0r938V6bv5qs3LFkFfjhzhKJ5rAwOujMI6sUQNjSrMyuhoLSHGyoCHH/Qi8sIMK63caqpyUwnxF7jP1Nf+jkaUbjHdRXbYZJpMOEEC0SPIlcC1DqRuhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV1/mXbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A844C433C7;
	Tue,  5 Mar 2024 18:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709663891;
	bh=Qvezb1qrdamuG9xcPUPJNIpdId4nIvMHCKBp3bs3C8g=;
	h=From:To:Cc:Subject:Date:From;
	b=nV1/mXbRTqzIPYNZBTXlh4VxwKZd0ArbtgsY2WeJBPy3wsA2fL9hj49pJMF7btlcC
	 +M8hoN1p0YtJlko3jR6LD8fvofNJ5Qzg8+kmfajD1MVX00c39ZT5vm0L8HCcRS+gfc
	 asojmmZAl/dXkjOSeA8eeJNklXKkeCGEMO95JgM8319NTrUp15t3DBCmpHXaxgPvf4
	 iFRR+1KtOGDxcGXeek/Pw28gxnP7+A8qq+oTNk7KJawgGOFrxSSuA1eaIVjFVrN9J8
	 DTFVWiBwYA19n2ZkRTD2NXkNG6w4O3zksj/X36WxFIpRu4hGZJtxlmkqo6wRtTpqqf
	 KNMG0GiNVn7oA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] RISC-V: drop SOC_SIFIVE for ARCH_SIFIVE
Date: Tue,  5 Mar 2024 18:37:05 +0000
Message-ID: <20240305-praying-clad-c4fbcaa7ed0a@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SM7nOTJXX+qrLLcvJVgdRw4VuMgbiO6iZuP9vGJ6kMI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnP0wK/781xqwiKfHr2oYbbxcOP4ybP39nz9mf/osxbf 7XPa9yc0lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJXD/E8L9gm5x2R5FURVvY kYPVgql3Z6yfE36gYWdp9oSmJK+/XHMY/kdyfVqbqP/hk2PGcs9Kjp4ZV6evmhL6qdlfd6r7mrp pQYwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

All the users in the kernel are gone and generated .config files from
previous LTS kernels will contain ARCH_SIFIVE. Drop SOC_SIFIVE and
update the defconfig.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/Kconfig.socs      | 3 ---
 arch/riscv/configs/defconfig | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e08e91c49abe..e85ffb63c48d 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -14,9 +14,6 @@ config ARCH_RENESAS
 	  This enables support for the RISC-V based Renesas SoCs.
 
 config ARCH_SIFIVE
-	def_bool SOC_SIFIVE
-
-config SOC_SIFIVE
 	bool "SiFive SoCs"
 	select ERRATA_SIFIVE if !XIP_KERNEL
 	help
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 89a009a580fe..ab3bab313d56 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -27,7 +27,7 @@ CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_SOC_SIFIVE=y
+CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
-- 
2.43.0


