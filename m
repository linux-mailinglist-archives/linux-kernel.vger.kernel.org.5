Return-Path: <linux-kernel+bounces-99070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F387831E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF5D1F25483
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9158113;
	Mon, 11 Mar 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsgEJTJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC05730A;
	Mon, 11 Mar 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169984; cv=none; b=oePduNeWzm06e6MPXpXFnhJMPj2mxHTMhzcEd4MdPTXnqz16p3F0mhzZcbO9veeUn4ITxweJ62LWS7cKbGD7xnraotoL2w5zN1eMkexjv0zZ6KE2k18lri2DALcJp5TPmXmrh5jqV201v//+NYdEfhIAU26frUc+nvAz30+Ino8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169984; c=relaxed/simple;
	bh=ee4JVX+b0jEgqSk/X+DrWDhtXvtITEYxbWllb2TfOyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Is+xZdCVOPBkG4WQWFpzpHaq8lJgIlDNXpkGubJ2Ss8bVNqbCTYQnUdOMDCVBbHq6nUoAxvj0wtRejau+d8UMxgZ7rBt6VJTSbUdKoncO+wcbLyt7ClhAfPe0GWaRGxpzhsknh/OqZZ+kBO8nECNOfQdRAQ5eEVO6nkvG9MxAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsgEJTJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C35C43394;
	Mon, 11 Mar 2024 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169984;
	bh=ee4JVX+b0jEgqSk/X+DrWDhtXvtITEYxbWllb2TfOyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsgEJTJIj4JKKU2pr37YhNxNGNcyUhUHOcZ570UmFNVaRS0FZXuL41cBu0J1X42YP
	 ASkrWvtOwCmUobpCtCDRomba7ASQcNNPwI66kTBd54HZtNuENQQUi/j9ClYPVY2rl5
	 iqGwfn6vsv/poxPgjrx5wJNv+bmmJEl+qRbIBh7uHO7phTs2v3L+ut/bhx21hF9gE8
	 /QGgzlERdqCJaIYw4vcn49p53DSF5KumwQZl7128K9NqK4qvq0iSqQsmqQMki0fBda
	 EqYXlsbCaYUTC3Wy1BwaVxx9ShbxaWneoj1a/KgMRYf37u/29zQXWj+i1rrUr2EsGC
	 17LcXZSoKIv5A==
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
Subject: [PATCH AUTOSEL 6.7 21/23] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Mon, 11 Mar 2024 11:12:01 -0400
Message-ID: <20240311151217.317068-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


