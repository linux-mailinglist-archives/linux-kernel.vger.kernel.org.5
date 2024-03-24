Return-Path: <linux-kernel+bounces-114518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AB888AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CE51F26B55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0E18270D;
	Sun, 24 Mar 2024 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0oFoybi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62959149DEB;
	Sun, 24 Mar 2024 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322145; cv=none; b=IzlYACZVE/xPYKPhlu9G1XOghSB7ciryeJAYo9fFyZb7KrCEQ3ujOYtxV1YR4WrGEm1ZS1zZMlzqe1+JdLr9CkeWD2YT2d32qRbJ6Y08OQ1R2YNiaL2UMu2o8djVpLUFTPh8dXQNO266LhA3vb6M2VvOSflgZEVc4xTAkjzg2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322145; c=relaxed/simple;
	bh=cpHQl2U6XX5lZOCEkpT458uk/SmfHyyclBjqSxRJwOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAN+cDWXpyMcvU1WvM+ejTwJpNtA422nwDvNfOKim0nKgHp6SW43YmpNhpd/AyPVadTO7MiKQzmHtKLupanJud14g71XX8q3fTXhZEw1V2940mURapO9CZe4O4VYbXJN9m1avV1EEun+OuHdgFbKRF0okwbN6nOl9YQfzj+pusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0oFoybi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D30C433C7;
	Sun, 24 Mar 2024 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322144;
	bh=cpHQl2U6XX5lZOCEkpT458uk/SmfHyyclBjqSxRJwOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0oFoybiazUJ4Te1iK3IMfrC1F5KNFInxbdXMfchX929eKAnGvRSn14mgtDhhtDlh
	 LVigsWaSXZDwLrfdeBeqvcTlfKuV9SAh5Lv20la3aoCnyq/Ef9D/x6HuEar++/j2+c
	 qXIqSqoOxi8LayR+LvTriSptsU6CcAzHpShU6zmauIly9/2KpZ4UJ3OJdcy9XEFoIv
	 8LdwJ+qEeJz39BJm8HN+8HlPOGqSwxhWa9P6SBNpfnBp55zZQrXH9AZsBodT427NGd
	 LvaayL5LLfxUxbbjPFgCyjbqHMgbH4hVK4W963jdkvrr4KPDKVzjcOFl78wjhosGGZ
	 ea8BArde1TOEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 221/451] Bluetooth: Fix eir name length
Date: Sun, 24 Mar 2024 19:08:17 -0400
Message-ID: <20240324231207.1351418-222-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis@collabora.com>

[ Upstream commit 2ab3e8d67fc1d4a7638b769cf83023ec209fc0a9 ]

According to Section 1.2 of Core Specification Supplement Part A the
complete or short name strings are defined as utf8s, which should not
include the trailing NULL for variable length array as defined in Core
Specification Vol1 Part E Section 2.9.3.

Removing the trailing NULL allows PTS to retrieve the random address based
on device name, e.g. for SM/PER/KDU/BV-02-C, SM/PER/KDU/BV-08-C or
GAP/BROB/BCST/BV-03-C.

Fixes: f61851f64b17 ("Bluetooth: Fix append max 11 bytes of name to scan rsp data")
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/eir.c  | 29 +++++++----------------------
 net/bluetooth/mgmt.c |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 9214189279e80..1bc51e2b05a34 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -13,48 +13,33 @@
 
 #define PNP_INFO_SVCLASS_ID		0x1200
 
-static u8 eir_append_name(u8 *eir, u16 eir_len, u8 type, u8 *data, u8 data_len)
-{
-	u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
-
-	/* If data is already NULL terminated just pass it directly */
-	if (data[data_len - 1] == '\0')
-		return eir_append_data(eir, eir_len, type, data, data_len);
-
-	memcpy(name, data, HCI_MAX_SHORT_NAME_LENGTH);
-	name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
-
-	return eir_append_data(eir, eir_len, type, name, sizeof(name));
-}
-
 u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
 	size_t short_len;
 	size_t complete_len;
 
-	/* no space left for name (+ NULL + type + len) */
-	if ((max_adv_len(hdev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
+	/* no space left for name (+ type + len) */
+	if ((max_adv_len(hdev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 2)
 		return ad_len;
 
 	/* use complete name if present and fits */
 	complete_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
 	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
-		return eir_append_name(ptr, ad_len, EIR_NAME_COMPLETE,
-				       hdev->dev_name, complete_len + 1);
+		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
+				       hdev->dev_name, complete_len);
 
 	/* use short name if present */
 	short_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
 	if (short_len)
-		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
 				       hdev->short_name,
-				       short_len == HCI_MAX_SHORT_NAME_LENGTH ?
-				       short_len : short_len + 1);
+				       short_len);
 
 	/* use shortened full name if present, we already know that name
 	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
 	 */
 	if (complete_len)
-		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
 				       hdev->dev_name,
 				       HCI_MAX_SHORT_NAME_LENGTH);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 21c0924787e22..716f6dc4934b7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8465,7 +8465,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 static u8 calculate_name_len(struct hci_dev *hdev)
 {
-	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 3];
+	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 2]; /* len + type + name */
 
 	return eir_append_local_name(hdev, buf, 0);
 }
-- 
2.43.0


