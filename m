Return-Path: <linux-kernel+bounces-39594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09183D357
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DE5B2308A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E2BE49;
	Fri, 26 Jan 2024 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BT/lZ8WD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B2B647
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706242253; cv=none; b=DfRC0uHtz04rM3qg+o2VBa9WNnc1SXDr96dEfCSjomSFQjl4YLinfEN45fUyOS8raF5JN6D3r+gVQx3CFrBgA/lO4ZuIWwRF25Io0qGc9t3E/EXcSkwq3JV/VH3Bmbk6GRHZ5foCJRXT0sh44b7k5NystwLOQL9EJ6ZHTiZsfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706242253; c=relaxed/simple;
	bh=4W7SncTE5nlYZ6yVmwW0fgvVI6EKAy6c0i/7v898CBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9NEkCcLorrgrP2XxQ34PwJBFPUNzca+rmbCN1LaWYL7bOYGz3/i6RhwPhfPA3DCIeUJI8KJjheoMYwhjnFvpgnckxBb5UQ423FTKjh6QuSCLRkgbx244paSfQXh4+q30EP7V4ke8bP4Ss3oIysn0eYGw0mhl5nTIYv9Zr4BqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BT/lZ8WD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d750660a0aso28608035ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706242250; x=1706847050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5dCLh7jF+475pXd7scOrhGTGo8G6O3hfrwh69idnc8=;
        b=BT/lZ8WDD3Iap0FNctBWEtpEAoQldHlpB+5vTZDoa6lq6UZZNyWu4wVEsj9Y4PnOZS
         /+ajPN8zrZ9FXJk/UMMj7T9osb0l5IOf7nfO3PLNdGMMfHIqsDPSIi7JX/ZViBgOwhvB
         LMknfLWWqVhc2YMwjdncYy/SJFJ85DGqJhpmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706242250; x=1706847050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5dCLh7jF+475pXd7scOrhGTGo8G6O3hfrwh69idnc8=;
        b=ubRN4Qax5SsN/JFLB1LMqNw4D5cEOPTu1hc6cwG48BPleUWPtL58TKKc+IxkBxLoi6
         gcsbHZNKK5crS86aemtqsH/keZABhkdTRNfAvED3k0OKoW/fJJj120gI0aWBojiZtSA0
         bWRV+XBI592NLVBv9QDvGBc6W4GD61SRKrMaDK0PnLad3ktJq6wabaaQ+JZDNZDgT7AG
         CWyhr1IXo1g4Hv43fTsofTU7pQlepqNIDFstDJGkZ0JxE81eyy3Z0tVUfa9vUrpeT0NT
         ZacYQky2drsQ+u7IIwMoTJjKjB5TtLr68K+E9WbBU9UlYqEky1EqpgzvZu2z5zt6V0EJ
         zruA==
X-Gm-Message-State: AOJu0Yz6tZ5F+aCsD3KsA8A55hhJSNEO2B7wXxd/zg13dUjqf3gL0Wzo
	XCgFFb4GlHG2+CI0FXgF7dWI9P3eb/FmCyy683MjwPL3EpwYxBhbTc+nK3TTHw==
X-Google-Smtp-Source: AGHT+IG6P7+//dziV1Qhm9ExMtehYhok6tv2sQQKaffVL017ZSrUaivyJsmM4cXCEkIXw/zycWc8pw==
X-Received: by 2002:a17:903:247:b0:1d7:5b9a:c125 with SMTP id j7-20020a170903024700b001d75b9ac125mr1201243plh.36.1706242250560;
        Thu, 25 Jan 2024 20:10:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001d720a6a4b0sm264334plw.24.2024.01.25.20.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 20:10:50 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Ariel Elior <aelior@marvell.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] bnx2x: Fix firmware version string character counts
Date: Thu, 25 Jan 2024 20:10:48 -0800
Message-Id: <20240126041044.work.220-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5209; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4W7SncTE5nlYZ6yVmwW0fgvVI6EKAy6c0i/7v898CBs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlszDIbDQxUzki+ZpnvH4QAMs2eowRffpkj87tq
 1MnSyr9ueCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbMwyAAKCRCJcvTf3G3A
 Jh1ZEACa3bz3ymSQNMT5ODTsbqtWTbInqwWyg7804CWMJxczE8w8u2zoR5Xar/xIKq6fYa5I2B3
 zmrLMFM75+g22xPJGTtRfPPBYA0VBZGqT95u3OLu7wKvBX4wvkVZrVg98cGwtfftGVrQQLuhJ/D
 yNMFrC2rjwo84j+LYX9kkwMl9QPyhgVb7XaDnytZuhbdwLY1MXJJHlu7IRBemS5mqRi3dUyg2qH
 WSc97xzgLCgpiA10YCzYRxkGH/Ggop94/B22bXKa6weKH8jSSzh4l/Gjt4DPDS97FUQ3L6ui7La
 DithhZm47y9yXVCa0NCIkz/1BozwUZ/0I1tfLUjNCCCKKR5zmNG1fnwiNHvEuJQJw91qjYFoiaV
 sLt5lntQ9O3LALKqTZ9ch3aPjS0hT42/gzRo9N4BudCiX3hcNHY+NtB/gpejU3u4Ba0e+30f/5V
 aXBwZ2YNgots+P5ZEKc9xwIoS2lcaCH4NjbsZ+O9wLOJuOXEh0EjQVHMRpkcQfXM5Us/6tdXAg7
 RIIG8e9N1u5vxLYO/6gOABju+V+5StpBehpydIAETTyeMItblCkYgPb5z7sPWQFHyFZE0erALGj
 1Wx0qHJv/WtmvUmW198wof4KOyT6eb52SDxnBC72p7g7Mf8SyyN5NP7oj2u0mEQhrWVoyORCsqg
 mkDCsUf b/uNkOVg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

A potential string truncation was reported in bnx2x_fill_fw_str(),
when a long bp->fw_ver and a long phy_fw_ver might coexist, but seems
unlikely with real-world hardware.

Use scnprintf() to indicate the intent that truncations are tolerated.

While reading this code, I found a collection of various buffer size
counting issues. None looked like they might lead to a buffer overflow
with current code (the small buffers are 20 bytes and might only ever
consume 10 bytes twice with a trailing %NUL). However, early truncation
(due to a %NUL in the middle of the string) might be happening under
likely rare conditions. Regardless fix the formatters and related
functions:

- Switch from a separate strscpy() to just adding an additional "%s" to
  the format string that immediately follows it in bnx2x_fill_fw_str().
- Use sizeof() universally instead of using unbound defines.
- Fix bnx2x_7101_format_ver() and bnx2x_null_format_ver() to report the
  number of characters written, not including the trailing %NUL (as
  already done with the other firmware formatting functions).
- Require space for at least 1 byte in bnx2x_get_ext_phy_fw_version()
  for the trailing %NUL.
- Correct the needed buffer size in bnx2x_3_seq_format_ver().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401260858.jZN6vD1k-lkp@intel.com/
Cc: Ariel Elior <aelior@marvell.com>
Cc: Sudarsana Kalluru <skalluru@marvell.com>
Cc: Manish Chopra <manishc@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  9 +++++----
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   | 14 +++++++-------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index e9c1e1bb5580..528441b28c4e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -147,10 +147,11 @@ void bnx2x_fill_fw_str(struct bnx2x *bp, char *buf, size_t buf_len)
 
 		phy_fw_ver[0] = '\0';
 		bnx2x_get_ext_phy_fw_version(&bp->link_params,
-					     phy_fw_ver, PHY_FW_VER_LEN);
-		strscpy(buf, bp->fw_ver, buf_len);
-		snprintf(buf + strlen(bp->fw_ver), 32 - strlen(bp->fw_ver),
-			 "bc %d.%d.%d%s%s",
+					     phy_fw_ver, sizeof(phy_fw_ver));
+		/* This may become truncated. */
+		scnprintf(buf, buf_len,
+			 "%sbc %d.%d.%d%s%s",
+			 bp->fw_ver,
 			 (bp->common.bc_ver & 0xff0000) >> 16,
 			 (bp->common.bc_ver & 0xff00) >> 8,
 			 (bp->common.bc_ver & 0xff),
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 81d232e6d05f..0bc7690cdee1 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -1132,7 +1132,7 @@ static void bnx2x_get_drvinfo(struct net_device *dev,
 	}
 
 	memset(version, 0, sizeof(version));
-	bnx2x_fill_fw_str(bp, version, ETHTOOL_FWVERS_LEN);
+	bnx2x_fill_fw_str(bp, version, sizeof(version));
 	strlcat(info->fw_version, version, sizeof(info->fw_version));
 
 	strscpy(info->bus_info, pci_name(bp->pdev), sizeof(info->bus_info));
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 02808513ffe4..ea310057fe3a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6163,8 +6163,8 @@ static void bnx2x_link_int_ack(struct link_params *params,
 
 static int bnx2x_null_format_ver(u32 spirom_ver, u8 *str, u16 *len)
 {
-	str[0] = '\0';
-	(*len)--;
+	if (*len)
+		str[0] = '\0';
 	return 0;
 }
 
@@ -6173,7 +6173,7 @@ static int bnx2x_format_ver(u32 num, u8 *str, u16 *len)
 	u16 ret;
 
 	if (*len < 10) {
-		/* Need more than 10chars for this format */
+		/* Need more than 10 chars for this format */
 		bnx2x_null_format_ver(num, str, len);
 		return -EINVAL;
 	}
@@ -6188,8 +6188,8 @@ static int bnx2x_3_seq_format_ver(u32 num, u8 *str, u16 *len)
 {
 	u16 ret;
 
-	if (*len < 10) {
-		/* Need more than 10chars for this format */
+	if (*len < 9) {
+		/* Need more than 9 chars for this format */
 		bnx2x_null_format_ver(num, str, len);
 		return -EINVAL;
 	}
@@ -6208,7 +6208,7 @@ int bnx2x_get_ext_phy_fw_version(struct link_params *params, u8 *version,
 	int status = 0;
 	u8 *ver_p = version;
 	u16 remain_len = len;
-	if (version == NULL || params == NULL)
+	if (version == NULL || params == NULL || len == 0)
 		return -EINVAL;
 	bp = params->bp;
 
@@ -11546,7 +11546,7 @@ static int bnx2x_7101_format_ver(u32 spirom_ver, u8 *str, u16 *len)
 	str[2] = (spirom_ver & 0xFF0000) >> 16;
 	str[3] = (spirom_ver & 0xFF000000) >> 24;
 	str[4] = '\0';
-	*len -= 5;
+	*len -= 4;
 	return 0;
 }
 
-- 
2.34.1


