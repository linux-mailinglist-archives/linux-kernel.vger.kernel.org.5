Return-Path: <linux-kernel+bounces-124694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9C891B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271E6290E68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83738174960;
	Fri, 29 Mar 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5uadi1m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770B17494B;
	Fri, 29 Mar 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715715; cv=none; b=qAw8HrRhUwj7KkHB9Fu1R6GqQ07PgVmGlnAJCv9wNEDyQ5PTcYCuIQJbDM0mz44b/M7J4R8CBaWTkIvSJI0Nd4/aIkhE3lgQnidF4V7agNiwjVu9r7zlJUVsGdwlhrMYR4HNwrV6AjFXcUrQ5f0Fi3bFxCCZWzzMJInPbM5JEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715715; c=relaxed/simple;
	bh=VuhDQ16JS8wiurFZRtJ3I1+nWANqiOZRiHZEQmjBnOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btKcyfA5Bxb+YAtrI8LqyKNF+nrOp04tEkTQpYIedjlXKRccDIO8Rw61/K7fKiywho7QcnD6aYZNEHb9Vl1CmxmrV6/JGDuzvBRjUSnZWF6HDdg/64vhOuvNyJ5KLV2+6hv7qBDMTB/8RZ7w5IWdVqg+4p1Y71XjA4e/S+OpfyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5uadi1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DC1C43394;
	Fri, 29 Mar 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715715;
	bh=VuhDQ16JS8wiurFZRtJ3I1+nWANqiOZRiHZEQmjBnOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5uadi1mD+sEzQ/xdV6c2JGmrEVFhoVHG3hCag1IUvMTEBDbdrxnwovRex2dzP826
	 aKlkzERCdXWQ4sUnwzOpDFc0CVcTblWsh2dzwqzxh5s9kyZqeCWmSlTADRA3ePS1lq
	 aMl0tyWwruB8idNu9hMuk7+v98LGxlbVlpCfgpauZxAesibBIGtAeqU3u3Ek2k3pnj
	 nNhheU2pHPSPzqIsrEJ7a6dZ7GbOTCPROQaPAT2hD9M4klSmNzQ2oMfHnAxzzF30Zh
	 zJMWJqVlNmomnn54t5oGPJXGR73Y8Yipje2eBPfbM9DY3d2X6xQeqpWt8GY//Ku8bh
	 qN5blpeed7esw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/15] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:34:38 -0400
Message-ID: <20240329123445.3086536-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit b79e040910101b020931ba0c9a6b77e81ab7f645 ]

If hci_cmd_sync_complete() is triggered and skb is NULL, then
hdev->req_skb is NULL, which will cause this issue.

Reported-and-tested-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bb99c8653aabf..5694dd63c1459 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -340,7 +340,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


