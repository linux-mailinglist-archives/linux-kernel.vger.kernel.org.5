Return-Path: <linux-kernel+bounces-29348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CA830D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176431C24351
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB262249E0;
	Wed, 17 Jan 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GXop1/AP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59924B2D;
	Wed, 17 Jan 2024 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518362; cv=none; b=IlFgx7P/jSQHNJItg6rSQr8qauL4st7v4kbqDLJdi41/4ub7BfDKuSaxmFpEYLy49GKeTL/6kTvL4dp7JUvqT47r3nUeWlpgwh4mNB+eHCbSLLVry5dDs1qPDc/U54h96L0T9+d9/9J1LTBKWninydN7VHhPwJRvLuRnG1qJxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518362; c=relaxed/simple;
	bh=eOeOU3x614lsawB+rslBo/giR4eO6xhTQjWM2UWOobU=;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer; b=RBS3V0wFOT+XXY9evCpDm4JHeNE6zcdVylpAfkLMuCFEeesy7A1DDC2TgUZoZ95ECOZFQGTKT3erSE7WjhWm90hOFQ7uuc4vIQXSwqLrD1YRAS7C4rbH8VHyiXzGB2/Qkz+D5dvGDid0Jj3IyHUe0mM5xkYRkpJLJb7QvUyhswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GXop1/AP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705518358;
	bh=eOeOU3x614lsawB+rslBo/giR4eO6xhTQjWM2UWOobU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GXop1/APn+/hjPS2SlNEWm1M7m5jGZ1Ar+IYRFjIvHr/W5ryRiPW/BokDnimXt5lp
	 PZM1pHH/SPsEMdYfu95Zg1/K8gN6V1W2A9p069azSnp3M0upE4yFSjd8wl7jloLaxn
	 5HNjMw5QlU81epDaBPj27tbGAxMpY4T+WmKau4Jc+8cBE+hZjqhh2LwgNWqppEotCh
	 N0BZnvm+h0G7Wl1FGNsJ1ep7fVIxNdyN+qkoGy+PCO6b23lwVI/5U7uqOCnDc9ZmRq
	 tSfr+OtvQOXYZLzIhEq1fjkQd+lgAYWA4V0R/WEADLmiDAgRNfTP8eyBOb2U2AeCW4
	 ZU6KttHP/8QbQ==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6DD643782066;
	Wed, 17 Jan 2024 19:05:53 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Jan 2024 16:03:23 -0300
Subject: [PATCH v3 2/4] firmware: coreboot: Generate aliases for coreboot
 modules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-coreboot-mod-defconfig-v3-2-049565a27bba@collabora.com>
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
In-Reply-To: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kernel@collabora.com, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Generate aliases for coreboot modules to allow automatic module probing.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 include/linux/mod_devicetable.h   |  8 ++++++++
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index f458469c5ce5..24e0dcfde809 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -960,4 +960,12 @@ struct vchiq_device_id {
 	char name[32];
 };
 
+/**
+ * struct coreboot_device_id - Identifies a coreboot table entry
+ * @tag: tag ID
+ */
+struct coreboot_device_id {
+	__u32 tag;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index e91a3c38143b..518200813d4e 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -274,5 +274,8 @@ int main(void)
 	DEVID(vchiq_device_id);
 	DEVID_FIELD(vchiq_device_id, name);
 
+	DEVID(coreboot_device_id);
+	DEVID_FIELD(coreboot_device_id, tag);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 4829680a0a6d..5d1c61fa5a55 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1494,6 +1494,15 @@ static int do_vchiq_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: coreboot:tN */
+static int do_coreboot_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, coreboot_device_id, tag);
+	sprintf(alias, "coreboot:t%08X", tag);
+
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1575,6 +1584,7 @@ static const struct devtable devtable[] = {
 	{"ishtp", SIZE_ishtp_device_id, do_ishtp_entry},
 	{"cdx", SIZE_cdx_device_id, do_cdx_entry},
 	{"vchiq", SIZE_vchiq_device_id, do_vchiq_entry},
+	{"coreboot", SIZE_coreboot_device_id, do_coreboot_entry},
 };
 
 /* Create MODULE_ALIAS() statements.

-- 
2.43.0


