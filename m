Return-Path: <linux-kernel+bounces-116399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11353889AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE281C3343A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8A1422C1;
	Mon, 25 Mar 2024 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAWmFaTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D514EC76;
	Mon, 25 Mar 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332548; cv=none; b=kxK3ibjRULrb7qvDiuM8m86dxh5E474/PXL/5dCMvYc05rly7p3FVdpowy2+wSZbCjosFhhLSYN5jWWeV3Dc+GcKvGqoHWZgxrnGj4uyYiHTBVZ8MK63muQfchC7DNz/E5nmF0RVYhK5QAqR8g6C6bohE9STPiFQdjKAnfgyWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332548; c=relaxed/simple;
	bh=u/1j4flFxi+I6DOq8mNIbiPB5wxZJTmcxqCsqq85lik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ADOeEtsvWPS8/pmOrQ6lDVXhqnfwOBmv+b3d041nbEEt30ffvu8cH13dXHHV1z3mk6fxF1I1CGLAbSNuh4R0dOCqTag0dl4WzoDc6AjuCWcjqutVF498rAOaLkhiUgwe3phusXWx8EFTxF5nb9ZW0g5kcUKDqCePPNozEQ+A2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAWmFaTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB40C433C7;
	Mon, 25 Mar 2024 02:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332547;
	bh=u/1j4flFxi+I6DOq8mNIbiPB5wxZJTmcxqCsqq85lik=;
	h=Date:From:To:Cc:Subject:From;
	b=YAWmFaTPqOhcE45JyCSlinrGe3kfkmiw2XxET3K27hTXzeutJdSOAG8N5ldereYFG
	 3OKaPirSPoCxeau0ZakuffX33E6uZTfEBGDDMZ6X8YQ8pY0HB13Yymrvr729ngIlEt
	 xZI1Y/ehFc0ppREkH3+YqUp96mE51GiZKDZbTr0I2cbcA15Atjnugfv6XBwutWImdz
	 3uNzdCJXSMU4qlgZ9N5MAuo/kpVTQXReHvJYrHa/PAmYOKitvqRfYBwr0lykr1VE9t
	 FbqD0HS2VBGoThEbjpmeo+TWQ50sIU/M3M5mqXMlp/uuEdP/911PMmmyEx0VMySJdV
	 rkQOYrDH+68Ag==
Date: Sun, 24 Mar 2024 20:09:04 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: ti: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZgDcwIgxkhs6ZVdY@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Remove unused flexible-array members in multiple structures, and fix
a hundred -Wflex-array-member-not-at-end warnings[1] in
drivers/wireless/ti/

Link: https://gist.github.com/GustavoARSilva/fbf63c114d01319bbd19baf95b4d704b [1]
Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ti/wl1251/cmd.h          | 2 --
 drivers/net/wireless/ti/wl1251/wl12xx_80211.h | 1 -
 drivers/net/wireless/ti/wlcore/cmd.h          | 2 --
 drivers/net/wireless/ti/wlcore/wl12xx_80211.h | 1 -
 4 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/cmd.h b/drivers/net/wireless/ti/wl1251/cmd.h
index e5874186f9d7..39159201b97e 100644
--- a/drivers/net/wireless/ti/wl1251/cmd.h
+++ b/drivers/net/wireless/ti/wl1251/cmd.h
@@ -89,8 +89,6 @@ enum wl1251_commands {
 struct wl1251_cmd_header {
 	u16 id;
 	u16 status;
-	/* payload */
-	u8 data[];
 } __packed;
 
 struct  wl1251_command {
diff --git a/drivers/net/wireless/ti/wl1251/wl12xx_80211.h b/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
index 7e28fe435b43..3d5b0df5b231 100644
--- a/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
+++ b/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
@@ -65,7 +65,6 @@ struct ieee80211_header {
 	u8 sa[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
 	__le16 seq_ctl;
-	u8 payload[];
 } __packed;
 
 struct wl12xx_ie_header {
diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index f2609d5b6bf7..4c2f2608ef3b 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -208,8 +208,6 @@ enum cmd_templ {
 struct wl1271_cmd_header {
 	__le16 id;
 	__le16 status;
-	/* payload */
-	u8 data[];
 } __packed;
 
 #define WL1271_CMD_MAX_PARAMS 572
diff --git a/drivers/net/wireless/ti/wlcore/wl12xx_80211.h b/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
index 1dd7ecc11f86..602915c4da26 100644
--- a/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
+++ b/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
@@ -66,7 +66,6 @@ struct ieee80211_header {
 	u8 sa[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
 	__le16 seq_ctl;
-	u8 payload[];
 } __packed;
 
 struct wl12xx_ie_header {
-- 
2.34.1


