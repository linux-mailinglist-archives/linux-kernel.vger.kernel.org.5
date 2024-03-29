Return-Path: <linux-kernel+bounces-124654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC5891B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E34288944
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD716B43D;
	Fri, 29 Mar 2024 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a95gvcLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A416B427;
	Fri, 29 Mar 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715634; cv=none; b=dLudOKk9OAhxWJfLItRCXTMt9dRONyLtXMTGodJwf3uDpTzKwQCwUWl03dbOgPyFwdktu4Ekr/A3F8D6SJ2KV+xm4xIpXWuzQZQbbFiKFvABfSNIDGQ1+ATtoFUEOGFRZ3lJKndhLzbESHHI6h8elqQRs/SOWeIwlulvBrNC+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715634; c=relaxed/simple;
	bh=4mzSwU+rBbD+a3y/qpgN7uKaMCIQtUp9DuawA5aMUxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfgxLaKl6yj0BkMV43A+SIN/ytjD5MwNrEx80AQadDPmIkyVKFaE8YG/gZqgSNHqbSFZf0wb2lNluZBfFUbiR3mSsNfyUWk01MNdNKYoyOPwo9nCbk+RBNHREyvAr50cnfSiLSNI8p1yfimmGez1m6Km2HCCrtKjaujYDlGOV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a95gvcLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2BAC433A6;
	Fri, 29 Mar 2024 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715634;
	bh=4mzSwU+rBbD+a3y/qpgN7uKaMCIQtUp9DuawA5aMUxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a95gvcLGNUZznuINoqSxGxCAautWqmEv3gT1emJ2qL3U+aOnvsVhNivSSzyTSvoc7
	 wM9SufRT5ur1/VxzMQ+fQnbK+kFBN/MHJoQFwmv/N9UPCOE7awc2mlBszwEIBqpAeO
	 n+WIT29XmYvDDh2oHE8agIbcIdY+ntZ/bIKxyE2UE7X4j8tSw/BBVu221YPeOwfGXV
	 e7IMpesrWfImUfmnkrHzZT+Jw6YKJ5gCbsTlflJ3v2ur2eDhc4ZSzj909ofPn5bD8T
	 XytUZwx9Ijrk3kFSEmnKTnQtdB5dzzmJtL5HL2hOktcTF65MLP/C+shBfE1VtA9P9t
	 ftFbl34GKX61A==
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
Subject: [PATCH AUTOSEL 5.15 20/20] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:33:08 -0400
Message-ID: <20240329123316.3085691-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 2a4cc5d8c2d40..75623302d00e7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -405,7 +405,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


