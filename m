Return-Path: <linux-kernel+bounces-114517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14CE88903D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EB31F2ADF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF6182705;
	Sun, 24 Mar 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDhMsVqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676D229D9F;
	Sun, 24 Mar 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322144; cv=none; b=PpEI8a2gvj/JaoYr+xGUJsDzOAviv6nrAa5UkLRHrc9MJZzPA2S8srvnmzmKriCm4a5HipkaxUZE/2J0g06/GPTNbWx198Oph1HzE6Kb6EIptlRYr8scQwJ60R/a4ROCxLRsU2ooOwq91LZIRmLEpbhg4yt+MwgA1zJ4MXpD9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322144; c=relaxed/simple;
	bh=kfXkjTP31j7etGaIsLsHiZobHHvwuXXdZmmHkitp3zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyzsafkhkuqOOSsp1U92wGHqNWWnpUI0jybsn3Hag+LROwV0bI+hzEkm93zJrJRo7Na66UyPGzJhhuWlLcJHBgB0e0l/7Sy85kPtEL16ULZxwDRY8MybrSUvo94VZ+idu8CybMg4X9XMsptJto334HroV+IwL+vDGC6SjDKxv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDhMsVqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12E4C43390;
	Sun, 24 Mar 2024 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322143;
	bh=kfXkjTP31j7etGaIsLsHiZobHHvwuXXdZmmHkitp3zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDhMsVqCD2BTCjmDsvFawbAf8wE/11TbrQp2eemKdfkuXczJ/WNdI0hc/Winxp8zY
	 yECl+nV6pvjkWbjevEvb2l9ykiwVipYTJKf8uJFrLjLk9FTL2YC8mV753vX+EDXONk
	 eYqZYHrJb6uXzGiLgEu32gmqtnnY3wFA+n/5kw4PcWo9r+54zs+F2IyiUf2iUzWR0y
	 +z/evjozbrgeibtyCYcQZFlC3+NyOnVn+KfPu8c+ZQ22TsoQIKE+keLiy3Z7tlgr4l
	 nkUs6j1G8H2jKegMObIMfrsSAk0uvfkoRJ70tTUhIWm6TH4t/bhLljhl/mjx9wJVtl
	 pfua+AxE+GGUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 220/451] Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
Date: Sun, 24 Mar 2024 19:08:16 -0400
Message-ID: <20240324231207.1351418-221-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit db08722fc7d46168fe31d9b8a7b29229dd959f9f ]

There a few instances still using HCI_MAX_AD_LENGTH instead of using
max_adv_len which takes care of detecting what is the actual maximum
length depending on if the controller supports EA or not.

Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2ab3e8d67fc1 ("Bluetooth: Fix eir name length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 6 +++---
 net/bluetooth/eir.c              | 2 +-
 net/bluetooth/mgmt.c             | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 53155cb703b5d..c50a41f1782a4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -81,7 +81,7 @@ struct discovery_state {
 	u8			last_adv_addr_type;
 	s8			last_adv_rssi;
 	u32			last_adv_flags;
-	u8			last_adv_data[HCI_MAX_AD_LENGTH];
+	u8			last_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	u8			last_adv_data_len;
 	bool			report_invalid_rssi;
 	bool			result_filtering;
@@ -293,7 +293,7 @@ struct adv_pattern {
 	__u8 ad_type;
 	__u8 offset;
 	__u8 length;
-	__u8 value[HCI_MAX_AD_LENGTH];
+	__u8 value[HCI_MAX_EXT_AD_LENGTH];
 };
 
 struct adv_rssi_thresholds {
@@ -727,7 +727,7 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
-	__u8		le_adv_data[HCI_MAX_AD_LENGTH];
+	__u8		le_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8		le_adv_data_len;
 	__u8		le_per_adv_data[HCI_MAX_PER_AD_LENGTH];
 	__u8		le_per_adv_data_len;
diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 8a85f6cdfbc16..9214189279e80 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -33,7 +33,7 @@ u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 	size_t complete_len;
 
 	/* no space left for name (+ NULL + type + len) */
-	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
+	if ((max_adv_len(hdev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
 		return ad_len;
 
 	/* use complete name if present and fits */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1486fb9bb78f7..21c0924787e22 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5378,9 +5378,9 @@ static u8 parse_adv_monitor_pattern(struct adv_monitor *m, u8 pattern_count,
 	for (i = 0; i < pattern_count; i++) {
 		offset = patterns[i].offset;
 		length = patterns[i].length;
-		if (offset >= HCI_MAX_AD_LENGTH ||
-		    length > HCI_MAX_AD_LENGTH ||
-		    (offset + length) > HCI_MAX_AD_LENGTH)
+		if (offset >= HCI_MAX_EXT_AD_LENGTH ||
+		    length > HCI_MAX_EXT_AD_LENGTH ||
+		    (offset + length) > HCI_MAX_EXT_AD_LENGTH)
 			return MGMT_STATUS_INVALID_PARAMS;
 
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
-- 
2.43.0


