Return-Path: <linux-kernel+bounces-26703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54BE82E562
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339CDB24457
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B842C6A6;
	Tue, 16 Jan 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPuipjFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA762C1A5;
	Tue, 16 Jan 2024 00:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FACC433C7;
	Tue, 16 Jan 2024 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364134;
	bh=VIvXnPu5/EKReOm8GMTR/HSxzftEx8b5EEcARxT5R5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPuipjFPGA2WUdc2GslcOZrh+Qd8bujiMxd2E7An9eke+jC35qWNiVpneohDkAa3s
	 vqCLZnOwaAC+LyJjuB9T+nLDc6vuFZE0Lgr6lVn2HqkntbRRYTl0tfx2ur8mdGjXfP
	 R56keDHFhvDp+C5hCG3kzgscyPWXGXHG02bCzl49VwMFbauleccm+JCJ6YCD/Ips4v
	 7761f8lo+8wzB7WspaDhacQM0L6FxxbFHsYSsBGTVaM1AsFgH1gBhOFSryAlzhEaFC
	 kINtjsnjlaGPnaVgmiFahw+fHU6kYrUAkui9xfi/XldWmBJULznIXS4ai7oZUcH4po
	 CHDfagAPBJj3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	masahiroy@kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/5] selftests/nolibc: use EFI -bios for LoongArch qemu
Date: Mon, 15 Jan 2024 19:15:25 -0500
Message-ID: <20240116001526.214354-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001526.214354-1-sashal@kernel.org>
References: <20240116001526.214354-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit bdeeeaba83682225a7bf5f100fe8652a59590d33 ]

qemu for LoongArch does not work properly with direct kernel boot.
The kernel will panic during initialization and hang without any output.

When booting in EFI mode everything work correctly.

While users most likely don't have the LoongArch EFI binary installed at
least an explicit error about 'file not found' is better than a hanging
test without output that can never succeed.

Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20231031-nolibc-out-of-tree-v1-1-47c92f73590a@weissschuh.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fc7bc81130dc..40c860f1c0a3 100644
--- a/Makefile
+++ b/Makefile
@@ -548,6 +548,13 @@ ifeq ($(config-targets),1)
 # *config targets only - make sure prerequisites are updated, and descend
 # in scripts/kconfig to make the *config target
 
+QEMU_BIOS_DIR = /usr/share/edk2/
+QEMU_BIOS_loongarch = $(QEMU_BIOS_DIR)/loongarch64/OVMF_CODE.fd
+
+ifneq ($(QEMU_BIOS_$(XARCH)),)
+QEMU_ARGS_BIOS = -bios $(QEMU_BIOS_$(XARCH))
+endif
+
 # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
@@ -1303,7 +1310,7 @@ _modinst_:
 	fi
 	@cp -f $(objtree)/modules.order $(MODLIB)/
 	@cp -f $(objtree)/modules.builtin $(MODLIB)/
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+	$(Q)$(MAKE) $(QEMU_ARGS_BIOS) -f $(srctree)/scripts/Makefile.modinst
 
 # This depmod is only for convenience to give the initial
 # boot a modules.dep even before / is mounted read-write.  However the
-- 
2.43.0


