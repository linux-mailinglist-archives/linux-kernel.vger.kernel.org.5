Return-Path: <linux-kernel+bounces-25418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7582CFFC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764AF1C20D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAB20E4;
	Sun, 14 Jan 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="aEml6NKH"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58801866;
	Sun, 14 Jan 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id EE04E38A05BF;
	Sun, 14 Jan 2024 08:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1705220068; bh=lZ5hHvBKyu37fI6reraXZf4MZHBd00kMbGtcCThfZSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEml6NKHlCx1geYs/mJXyEf9ofqTDH9o4PcSwW8HeZNCIbC+x3rZUZf3e9nT8Q6rX
	 0q7fQTyYzK5KID0+Tc1rHFbzQJrsAuT3DtwyRTVMz0YHc20M84Ycqor8a16FpGvXVF
	 OUBArbI6uYCoOmIsUXTAfKvoGx0qz7MJNq1XbzjdqPXB/EGi7BuAF/eRgtdSsabC1T
	 rtitBxR91Se6OY1rA+piJtUfyI6VQR66XljS8Rb7hOuMjmb6DZNkrvXQT1wTxrZUxE
	 D2nJ/QmvTNQimIZ53T7LZ9cBKcP950PlSADSj8yjbNlsw8/hi1UfTQBFtgW2IZ8mGI
	 CChH0SXq8FoozCwXJvrhmsvwyBW8Bi9O5fj/n95UUs2G3vjM0R0ETJX1rWdzPtZSpg
	 z4lT99lzm6jQzOLnjqajA6X0P3EaGSEvodxMs50ro2C20pLrTLYEoIyKZnk7OpPuMq
	 Y0FK/fTEMOD0BPagOSeOBRWLVDqfDt5y4wbc07sBTP66RDcToXHuG2sa3C2LRCsKL0
	 RncyqY61yuYhWZ/itsrBjIdux1AZwg8N3JiyCS/tAWOg/ZUtmEEAW71G1sYjGRoqLw
	 sI1FDmyX8+U0PFD8k/JnTY1PgVvbjmRqultKQNkP1iwaAwDpvExeusMQ88/5CGV1V6
	 npK1JpMfGwrjAEevX+EVow2k=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YBM1NF2qmNFu; Sun, 14 Jan 2024 08:14:25 +0000 (UTC)
Received: from xtexx.eu.org (unknown [120.230.214.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sun, 14 Jan 2024 08:14:24 +0000 (UTC)
From: Zhang Bingwu <xtex@envs.net>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhang Bingwu <xtexchooser@duck.com>
Subject: [PATCH v2 1/2] kbuild: defconf: use SRCARCH to find merged configs
Date: Sun, 14 Jan 2024 16:13:59 +0800
Message-ID: <20240114081400.12452-2-xtex@envs.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114081400.12452-1-xtex@envs.net>
References: <20240113001135.7781-1-xtex@envs.net>
 <20240114081400.12452-1-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Bingwu <xtexchooser@duck.com>

For some ARCH values, SRCARCH, which should be used for finding arch/
subdirectory, is different from ARCH.

Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
---
 scripts/Makefile.defconf | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.defconf b/scripts/Makefile.defconf
index ab271b205..226ea3df3 100644
--- a/scripts/Makefile.defconf
+++ b/scripts/Makefile.defconf
@@ -9,8 +9,8 @@
 # Input config fragments without '.config' suffix
 define merge_into_defconfig
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
+		-m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) \
+		$(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
 
@@ -23,7 +23,7 @@ endef
 # Input config fragments without '.config' suffix
 define merge_into_defconfig_override
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-Q -m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
+		-Q -m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) \
+		$(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
-- 
2.43.0


