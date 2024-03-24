Return-Path: <linux-kernel+bounces-115314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBF889AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ED31C33526
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6D1DE124;
	Mon, 25 Mar 2024 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsoityMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F7482FE;
	Sun, 24 Mar 2024 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320506; cv=none; b=UlweVP9HYCiOp7HDHIQrEZZZ15K4TIjmYYhChEPOUPuRB0twd3qIAW0CUQ6GiuKPcYLMuPVeT9vePknQ5XNe5CfgNx5LThwAo+WO8OBexQKLb/bip7HR9/KC0Iz+2pKH8IofXLEb3ihTax52ctU2/l+UKvPG6ibCesJW+3SfPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320506; c=relaxed/simple;
	bh=ee4JVX+b0jEgqSk/X+DrWDhtXvtITEYxbWllb2TfOyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGUKFffFPFmDfzqs/KaQtxnJft0PJ5c4HemImW+pzv9lLYzFH12Fbl9gTyyBYY20Po8NsmleEsGzyOJVLDd8+oBdgL6EUsFqGZzhHJEuWn9J491k4Uo4SkjcaMjs4uDg1cpa5yc4G4vDGDr0SfAMPZ4xyhYje43Elz5Z4ADQLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsoityMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C0EC43394;
	Sun, 24 Mar 2024 22:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320506;
	bh=ee4JVX+b0jEgqSk/X+DrWDhtXvtITEYxbWllb2TfOyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsoityMVqZqaRAEbiBQjWKtniBDMalntjZFX6s32+Oi8dtH27Nzdikyyx4ZMVg47S
	 ZLt0FwgMXX8kR5REOxw1DqwbXJgg/dSdHOKhFvzADbbvUegIZmv+//EDqh+dyhegnQ
	 92SYoRSZzWbRBFX12THhPcL2ElVTAKOc0CCFbjPZyb9v6lPRwZfLY9ScaXbX+nzHr8
	 VnR6EiewscHkGxFDBEbrhtUWgD7fQgB62oflEPD3hLMdc7LSHu3ruZ8uJUcgUWexnS
	 Qoh2N+wBI5kd1JA/4v3o9nfQjSkHIc1hJdDDgWjrpc+CgRP6a3ZWhEsSGJci+hPFAE
	 d0a3BNE90xqwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 066/713] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Sun, 24 Mar 2024 18:36:32 -0400
Message-ID: <20240324224720.1345309-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 9dd815b6603fe..2448a154a4069 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1045,6 +1045,8 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static int set_discoverable_sync(struct hci_dev *hdev, void *data);
+
 static void discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1063,7 +1065,7 @@ static void discov_off(struct work_struct *work)
 	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 	hdev->discov_timeout = 0;
 
-	hci_update_discoverable(hdev);
+	hci_cmd_sync_queue(hdev, set_discoverable_sync, NULL, NULL);
 
 	mgmt_new_settings(hdev);
 
-- 
2.43.0


