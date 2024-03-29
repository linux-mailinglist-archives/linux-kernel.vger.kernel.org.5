Return-Path: <linux-kernel+bounces-124548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF0E8919B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AD61C24D79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566614B097;
	Fri, 29 Mar 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hobRJMzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8514B082;
	Fri, 29 Mar 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715356; cv=none; b=cypMo+giCMq6PEsfNVSQ/CpHqPdxUM2M09D3X0kMGvzvClRTgtoXjIkG3YLUKDzv0DZtK7G2LqIlVnL/emNx4R7Z+mqTpVBmW/n1y2RDbtmxdwWmhp8yJW32yZsUAx9uZnNqnshQq5o+7I7Ju4gq7+6gR6mUxGJxpf/CnQD+RxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715356; c=relaxed/simple;
	bh=ITUVufZq4qdkZCwidWSmVs97w4BrTt9A9ToKNeVFCVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpy584v9U1RpoVhsELS3aenFv5dJsOHlHgmgXRKJQy064/OlsNZRR6Nf/p9TLTlJpAXcAh61G3mbBZtVgBCG1/uCjSzmHJGrfqca08jn+iLC4qiqZ8alunWHZgrzaMq8UXB2Ie9yCDKx5ra7BBGkVDvWCYqQ8KudcxuWHwGL5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hobRJMzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE13BC43609;
	Fri, 29 Mar 2024 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715355;
	bh=ITUVufZq4qdkZCwidWSmVs97w4BrTt9A9ToKNeVFCVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hobRJMzRHzZRs2IFcWIyEqCjPIayfP/xiqYzT72wpGpzGQdHQuMYO3I3G2oQkj5tk
	 InhUbc9px1w4bRNNKZ9u3QPV9HFHnr+AJCOWHYJvG2KF1dluukca+dh6S4TSkAHtvV
	 KAtjDxKh7VFDr/8+5QXXNkaF8/M1Y6ybZ8tL/qr7hh0KMJt2kGom2eSmjWCbSOWiW1
	 4ftq50RzRDMYMCqyKwOodMBFbAzlb0ihsj9qiYn/aKrHo7ypEwIniSeD1+oLRVI6A1
	 1Hb4f7IMSQ5zvx4W0zVW0KqImxmydjmP+kKIFcvSVkBKfXl/4Yli14XxGM6birTBLV
	 YoktmOoVr+dQg==
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
Subject: [PATCH AUTOSEL 6.8 66/68] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:26:02 -0400
Message-ID: <20240329122652.3082296-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index cdc5c08824a0a..e5b043d962073 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -435,7 +435,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


