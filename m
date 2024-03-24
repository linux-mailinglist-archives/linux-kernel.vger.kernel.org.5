Return-Path: <linux-kernel+bounces-115785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F98897C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C490B29DF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22666262045;
	Mon, 25 Mar 2024 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BET6T8pv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C6145332;
	Sun, 24 Mar 2024 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321977; cv=none; b=KrQw6hWbhCY8z9XyptyDE9g/KO0afNt5g4JjUCEMd20Rh8/WM2BD5oIW8dDadWjGxgBPXnXAhEQMKvys2Ij0GEL22Jm6e9oGT+ryXq2CQ3pEqdgYopARHIVTmWBlmm3bQRFWZSDdZ0SqCHWA0RrJPBF7/ful2mbyj1BU5/19dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321977; c=relaxed/simple;
	bh=MumbKthU2I5zBp+rLx2CGii9NjmVEaYSOt6WCIXxHLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZLveWBkQLvoewxxaLCCgnqDFXIf5DswSHkUIPN6aUqZy6MVDi5ct6lh/Ahrdv+2ehXD6L4nxLT3tcussPsQgxkpd3HHWVyfN1G+E11C1qnzXghlwJxXdfQfzGa4xrcNGqkUd3zXTESNhPGUAH27VXR2dwXO4S60kNLYmiKMIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BET6T8pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C229C43394;
	Sun, 24 Mar 2024 23:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321977;
	bh=MumbKthU2I5zBp+rLx2CGii9NjmVEaYSOt6WCIXxHLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BET6T8pvX8Vh/aSmy9c0vwVUNZkGKEwDXEBquYKpvtxr0a/s3tfz31mRSFm+fC+Um
	 DZRLwUBuV+DqW2HLRZ7p+na5MSy+I7zwwdCoX7EkgL63O0ymvfCeco/dwVu+fdseJq
	 Y5+Is4ujxeln3aJP4r0pDfTp0CdPlpJKYjfu6EbERNDFrTBydaF/GjXdx41HyY9wL5
	 U1nTgX8sdG8osHA1MpnC83bOqVNggqBBrSq4BwFyu2lgixra/n2EZq2VQ9RLYsngq1
	 7HKin83m9e448cngJPwqvUEohaNTuCj237R4NpXDLLjq9l5bH/CNBf06o0KZ3QzXU8
	 uXELI2L2w2JGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/451] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Sun, 24 Mar 2024 19:05:26 -0400
Message-ID: <20240324231207.1351418-51-sashal@kernel.org>
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

[ Upstream commit 0bd1fb586235224048c726922db048d1bce6354a ]

LIMITED_DISCOVERABLE flag is not reset from Class of Device and
advertisement on limited discoverable timeout. This prevents to pass PTS
test GAP/DISC/LIMM/BV-02-C

Calling set_discoverable_sync as when the limited discovery is set
correctly update the Class of Device and advertisement.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6d631a2e60166..ab63f807e3c80 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1039,6 +1039,8 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static int set_discoverable_sync(struct hci_dev *hdev, void *data);
+
 static void discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1057,7 +1059,7 @@ static void discov_off(struct work_struct *work)
 	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 	hdev->discov_timeout = 0;
 
-	hci_update_discoverable(hdev);
+	hci_cmd_sync_queue(hdev, set_discoverable_sync, NULL, NULL);
 
 	mgmt_new_settings(hdev);
 
-- 
2.43.0


