Return-Path: <linux-kernel+bounces-25419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B827E82CFFE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683D1282A15
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00D28F6;
	Sun, 14 Jan 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="gtlWSyFg"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BED1FDA;
	Sun, 14 Jan 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 7FB8138A05D5;
	Sun, 14 Jan 2024 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1705220072; bh=Rmzy1x+mMdFJmxVODKg4KIE69NMRMaiDq+QZxWJb4mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtlWSyFg9LeO0Y7Vwfvw0BsNxp36ffBwrtBw9p+PyHgRfIVujsCSN+k7gizo9kwS/
	 DSG3T5/VbzdbkCq4t3N/k8O9mW5aWRi1QbFakpsZDxBMvV01hZcTa04Ar7fTIp7Ez5
	 aYvLBBj/nuuhlf3sbeZEHVI6oAKo5cSNSk9+0vgicr8Wn4IrMLRhn5/MizdiH1f7tb
	 JyeC9WwadaeJXGhz0NmMpcpXcqyxojaXf9np07OQ3nT22c1ACwyghnnTE/hizxSTuE
	 EEsOuBJ+YG5lGTmEZ1R1CFW/MRxqlOlaEdUbcftZx2uG+1GZNCEezgxyCBfqTQ0Hr+
	 kVLKqQLtm1A2PLbu2GFerI9ggbZwGwwJhz/vQWwJ7c72rLCki0M6fOxiZ76IbQkAhY
	 68ViuhsqGvCYKPsUuWEseYjIuqocYJn2n4cPbzfU5GDqNHfSLj849ktnyBS6caJt1I
	 N3GCrL5RP7QrZwqtl7EOgeqgGgiJxLg6pFZ9O+EWyK13ahaJuas3JXI5EBIiouCYIi
	 h2L4coJnynvLZjFj8hHpqEQBDzEY3UJ3y+6npOnqczLkpz0kCtXYazBw+tFH2V0FFV
	 OIC6GIa4N7m8+MKCFdb8hWEUJhMGcm+Vm9/F3QRuHitJK1hUBjyjjmhzkfqLI7tTyz
	 HRQnOwHjEk+oarQJpl9FMejc=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hLczUb6rZvRM; Sun, 14 Jan 2024 08:14:29 +0000 (UTC)
Received: from xtexx.eu.org (unknown [120.230.214.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sun, 14 Jan 2024 08:14:29 +0000 (UTC)
From: Zhang Bingwu <xtex@envs.net>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhang Bingwu <xtexchooser@duck.com>
Subject: [PATCH v2 2/2] kbuild: find kernel/configs/ for merged fragments
Date: Sun, 14 Jan 2024 16:14:00 +0800
Message-ID: <20240114081400.12452-3-xtex@envs.net>
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

kernel/configs consists of several arch-independent config fragments,
which should also be searched for by merge_into_defconfig.

When using 'make xxx_defconfig xxx.config' to merge fragments,
scripts/kconfig/Makefile also searches kernel/configs/*.config
for fragments. This behaviour should also be in merge_into_defconfig.

Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
---
 scripts/Makefile.defconf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.defconf b/scripts/Makefile.defconf
index 226ea3df3..777be9bf7 100644
--- a/scripts/Makefile.defconf
+++ b/scripts/Makefile.defconf
@@ -10,7 +10,7 @@
 define merge_into_defconfig
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
 		-m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
+		$(foreach config,$(2),$(wildcard $(srctree)/kernel/configs/$(config).config $(srctree)/arch/$(SRCARCH)/configs/$(config).config))
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
 
@@ -24,6 +24,6 @@ endef
 define merge_into_defconfig_override
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
 		-Q -m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
+		$(foreach config,$(2),$(wildcard $(srctree)/kernel/configs/$(config).config $(srctree)/arch/$(SRCARCH)/configs/$(config).config))
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
-- 
2.43.0


