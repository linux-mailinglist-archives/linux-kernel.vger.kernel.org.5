Return-Path: <linux-kernel+bounces-113224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1B888272
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094CD1C2287F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E610181D07;
	Sun, 24 Mar 2024 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpmyfhTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C078181CE9;
	Sun, 24 Mar 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320025; cv=none; b=T8j1Oari7sCU3jUN/VYip3h9P03amoKrbrCBdeacbWJfmIdoDFCYdR6Hs9WoveVDZeJo5cF4Z8NxDL9A1ZfZId+ePhGAygWKhBRTXQjBastbmuYn1TSUoP9gSv0k9+qmHKpO7d/RtAjas/LAFxZU6BJSjj9IXhx2UqDcpG7W4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320025; c=relaxed/simple;
	bh=4mF4V8TS65Jj2vD7gHAcMiY35vWWyWzZ99pCIrEaiwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfgLKYCNBE6311KAsBzQ6ZqzW6vasJshiH4Nurn/eA9KgcYzvQEuJKT1SR9qU61AKuN5bLG/FgDG8TXqJO0cdoE1AcG2CtsEyDUWCi+rjrmZdK13OcP1jxTomvL8ZmZ5nUJ9U1JrX0Q780Ov0hCjKmXZ7we/P4A6hJsUM1yjHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpmyfhTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936DFC433C7;
	Sun, 24 Mar 2024 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320025;
	bh=4mF4V8TS65Jj2vD7gHAcMiY35vWWyWzZ99pCIrEaiwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpmyfhTLQlylJbHSFKvRBeQMnX8KEPbY5VHxRf9+rYBa9jGut1/WUTD1bX3sb1pvz
	 qgnL3t7FiD0uTASUyN1SPWFNq14L5yxLTaTIt83bo+txgmdGIgtofqDqkjoyM+3T16
	 CT//kBtdXvhocyFQYVOStlq1OGxXcil1MQVh/bOCI08EtrIAV+PJSGbt9a6q7pwMMK
	 lERAZQTMW45O5xE+2MsAW0xFCjxZTZJmH5HJ5URW4cid60rQPRXgzTz7/KEiites/w
	 3bHghHJm8Nqp56+gQdLMIfoDbGJcc3T3Pi85sk2Oo7rfhYBDYre3NhMYvXG0EjlFO8
	 X5uepvuiQ7I0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 333/715] Bluetooth: Fix eir name length
Date: Sun, 24 Mar 2024 18:28:32 -0400
Message-ID: <20240324223455.1342824-334-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index cc8efdc4ad431..640d6d54ac6ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8400,7 +8400,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 static u8 calculate_name_len(struct hci_dev *hdev)
 {
-	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 3];
+	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 2]; /* len + type + name */
 
 	return eir_append_local_name(hdev, buf, 0);
 }
-- 
2.43.0


