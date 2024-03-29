Return-Path: <linux-kernel+bounces-124678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2D891B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37B71F2B503
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EBA17164E;
	Fri, 29 Mar 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrRAJDX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8CF170A37;
	Fri, 29 Mar 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715677; cv=none; b=eE4Zqzft1uzSd7amDueYM3MpkvRHEM3ElllSnbzqbZ8YWMPyOzQ0bKzO4WxaAXfvzPmSlWCpCBBnld5q6D35wkRIabyJEoAIwFG4lLGz+74YoaMjWjag44Z8t7VypmIcNN9wsutElBal8SADrQI15XBO1lRmhVUc/KWsIcY5Fgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715677; c=relaxed/simple;
	bh=+pqdtc5gZl4V8x0tseAHCNgJBG+66RpWtx6kCdmusWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYEGSLlIZP9uFeBL/R2RyQG9tBheItsfpIgV0P5c9817Wzxn/bKtMd6Fam2+Qx2fK1e6H4xXHsHTh7w+VJcTKQlb/2vSK4icMvWyJf0qBPQJHFKUEgYRBH/bePtXYmHB7nYgABq5mBDer8jWKq8396+Rt9xaqvf3mnWL6QIhuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrRAJDX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FEFC43390;
	Fri, 29 Mar 2024 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715676;
	bh=+pqdtc5gZl4V8x0tseAHCNgJBG+66RpWtx6kCdmusWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrRAJDX19+SsokEe2qdSX6gajRK4rmktGY43zRrMEtcILd4ghH9GwuZuwx6wkt9Z9
	 ZUvRWARqxc+ybQURtqm0HrrFOeQcjZWaL+H/zLXwKP+eIs5apvx4tootPFaRwCOP/5
	 BK7FMjIaIYMmPl31KM3bRHQdYo5s8IxVmJn5ERD4E/nGdr8FXoxxVMHDdearxVtAdd
	 hm3Nh2fzpbd47NY2UXUImsBnxYu/XG9XMcqqZUbZ7Ks0u8r7BHj14FhTDDRwWKI/uz
	 nXqy+sIg2WuEM0Zw9Gq1xFBCz0J4KQusSHesErlGYfrLhszBgOaXJopsB1LK1KG4YS
	 1ibsElxMtFGRA==
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
Subject: [PATCH AUTOSEL 5.10 17/17] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:33:56 -0400
Message-ID: <20240329123405.3086155-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 88ce5f0ffc4ba..e1daf6ebd3ada 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -344,7 +344,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


