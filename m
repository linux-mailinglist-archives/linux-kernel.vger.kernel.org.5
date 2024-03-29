Return-Path: <linux-kernel+bounces-124633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849D5891ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B629F1C25C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D815F32E;
	Fri, 29 Mar 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsElp6gW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6315F306;
	Fri, 29 Mar 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715584; cv=none; b=BGm8WJSosFjoNq/mFikHgZjIDV/UxgAGHiGF80TuzwVsy7JREl4UMFWpVGgaoRJJ1VMLGRBhShWXoRwjEgVlsbZIYigI7nlbV9viwiYf+Y0DtGNeN0kT8VDwDtMQ29GW9/6KPhoXgsfOk4qoj7PcC05lAskW18cCx9SLQLm2KFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715584; c=relaxed/simple;
	bh=TmFIMTZbI423B22N6Purza9qEzTFucilnbCzm34PcbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYIhA/Fa4mhcFOsa/oSMpufe+9SGeX1Tk7VWzOeF9xRVjWS54j8jaJEnCppDI4TbXPbyCNriOK+Y2N7bzDEHyeL6aXz7qDX86LZBBqRKmEOl5TJqT0EM9yznR5Tt1la/WI2m8xyTVF1GvYqKdn7/jqB2UfSkL/JggUmsrrmRVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsElp6gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08EDC433F1;
	Fri, 29 Mar 2024 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715584;
	bh=TmFIMTZbI423B22N6Purza9qEzTFucilnbCzm34PcbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsElp6gW+A0nrwbU2IH0ELqYvO4Y6nMrxBPKG+SEhbLwc5WB4KMgPLYua9yg/OAip
	 XrAgx9/tLYLO/BxKzHMD9srG7/fAwvF0eReXAysSVbNAEWwR0OQkhOg8rEjmOsjHt0
	 LJgyP8LV75gjMOpx3s9FD/9hfs/msIXl4T/nQwJ2HEErDaGBzT1jY0dlEwUaTUfvV5
	 5tLUgkFOQ8QW/WS+aBptTEsWF0mV0vLPehddixiKr/W9mUYKUTprER2Ht+MzpclA7H
	 a2pHMV1fLU1rP1CmExyBpxbCjmwHNZ6b+JZNyIO9VbN7l9+LxocxDegaAPpKSzMkoY
	 N22bXYfXP/9bQ==
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
Subject: [PATCH AUTOSEL 6.1 30/31] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:31:49 -0400
Message-ID: <20240329123207.3085013-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index bbad1207cdfd8..c77c06b84d86c 100644
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


