Return-Path: <linux-kernel+bounces-99103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F8E878376
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90A228414C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E72657A0;
	Mon, 11 Mar 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOCmpApN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643E65197;
	Mon, 11 Mar 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170060; cv=none; b=e0vMgnaPRVSTBTwhqIBAO5Vu/QZ+si3ZitQ69STzQpOMEhHpaZBKt6NB9A1rhDqkf04t3+7YP3MZpuYy2BsoBW01pSPzkJ3UuV4tsrVjdfYCRUf+qzFgUi+OfJ8Sot2HGGRneoMcnX5C8kApuUoxPl7V9iDwaai+gDC+qBtXen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170060; c=relaxed/simple;
	bh=MumbKthU2I5zBp+rLx2CGii9NjmVEaYSOt6WCIXxHLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJUqpQe+2rUlDA16dvIDdmVAKzXwc0hrv1jKETTBRx065LhEuBgBIB5gH20odnbq0Lo34lzJC9GHs4wwwMvBnVYLYWUHDG7OWoPLAEOhkRRXpb2wcXjy3/gy9/geojRJrCk70VjKgsElla/QXJShdT4KXKVHHe2aH8NViHKl/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOCmpApN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D84C433C7;
	Mon, 11 Mar 2024 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170060;
	bh=MumbKthU2I5zBp+rLx2CGii9NjmVEaYSOt6WCIXxHLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOCmpApN8hjqn89EC+JtkwHL1jELW/4bTlWYriMtm0SwuY41UWoar4DQ+FtHWg7Qe
	 CXvdsr3D4TqfpnSVXJ9SaASHmqUlxNVp8wgyiws6ER2ZoDlHIYUPRjUer0Ew2lejPs
	 X15FKHWZ7e/6B7zX+OTRtVgDLZ2cOxGOBrtuqYSDZ8cVm3PUzvKCCkf+srJkaUncrS
	 7yMDMRLABuvMBRxKH3YrzxbUpR7NJHICj4yJ2dhWnL8sWHyUlisTdYGGr30inb3fbC
	 /xFGIJIPoXABKqAV5e+uVTdqBKoN3dCeYho/vmwwEgMwI3KfrNmw6Fb/3+jtAeHT2Q
	 Vd9LPUFZp5wgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/13] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Mon, 11 Mar 2024 11:13:47 -0400
Message-ID: <20240311151354.318293-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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


