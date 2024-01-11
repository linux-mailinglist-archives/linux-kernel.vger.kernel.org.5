Return-Path: <linux-kernel+bounces-23775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377B82B183
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3891C21DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC674C60C;
	Thu, 11 Jan 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MJB8zfnS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327174EB33;
	Thu, 11 Jan 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704986087;
	bh=UQawPUBSwtTExT/RYPtLtcnQmAVsJX1wiKs2v5V+ZEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJB8zfnSbDED0CXfaz6U+MqvWWIRFlXDS2s/kH1Fse+PulrYbrF9xPOxrdC84+dKP
	 CpGdJyXH5Kpwpd4FG3181aj9pxVTdjVMqn9F5VLGot8p8ZgjZobn//xSkPon23HEJ3
	 8Uz3MTY7FUkUrZ49VqLAbMVK3ZhF/zAX70yu2jzXgsrV170eS/lEsXUMDzjwLmHfP+
	 VPfbB7pRp72qlKumOPHwJmYdyFbnRqIoYo65Hn2qMpFIc4HRew+b7GQC24VX7Fpuvv
	 yIT2DYVAGZ60gZ9rWdiwEwYWrldgxLYEzKcwBBZlWN2g7sXAApcl43lyrfUOE6ogEj
	 p5FDaB94WvimQ==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC9FF3782011;
	Thu, 11 Jan 2024 15:14:42 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] firmware: coreboot: Generate aliases for coreboot modules
Date: Thu, 11 Jan 2024 12:11:47 -0300
Message-ID: <20240111151226.842603-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111151226.842603-1-nfraprado@collabora.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generate aliases for coreboot modules to allow automatic module probing.

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


