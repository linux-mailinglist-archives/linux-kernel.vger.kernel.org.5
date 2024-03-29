Return-Path: <linux-kernel+bounces-124705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498DF891B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA00B26FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B3176A1B;
	Fri, 29 Mar 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o93J3z8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F6175C9D;
	Fri, 29 Mar 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715741; cv=none; b=sLnEuEIPgJjN4vFivHaVb4/UUB/3SqhB3knS74qXAL3Ub6yoVCPpeUsYRhVMqe4GhQnTRIiG/U1Zj0x4eDvd2TJrheacNixcQmyZh5OqXz/SJo+yl3DRkMUnvhjGNd1adcQgibm2GsZdJ1tc5UmcJGaH/md1k6WBDUi/WqimjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715741; c=relaxed/simple;
	bh=y5sLR1F7e4AqMERpcQ07sKZBrNLzvfWoWAKDF3ZJhDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV5yDBrScLTZ8ovLAb73VyUiLQWXJVmUlAv+PvK3G5kb5fyHo0RnSnN+XbYSukxoYllTjddZeMDwJTrYwJvibzaigD1cN7OsnwfipSe1rA7zyv1XlaBGIUCFaUqRJ1Aohci/ZQIML3bviz5H46lnwiB0Cg5Clr1AizdCcVX/f6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o93J3z8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C76CC433F1;
	Fri, 29 Mar 2024 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715741;
	bh=y5sLR1F7e4AqMERpcQ07sKZBrNLzvfWoWAKDF3ZJhDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o93J3z8gWuqH+dtpYyX2hnI/y8xLKk0G36HSp/o84MAteSoIOkPJFAEM2Sr8HCXFg
	 f26D/wy//Dy9BGDzxP2/RK8FAnjnMQZNb6kioY7Au8ixsIYd5L+oO1UzzUNr3RHjtq
	 0l+IBo2fnZxmJviL87WLon3A2O7TVirpMkyzmShw4r3P+5XvNiEiP7Pw0CPOHVjj30
	 4kO/CRUsCS1Ogrm7ptSFIdCvretGXua6YLv6YH1Cxiuu8S7JV4UOBVkfhU6303MZss
	 fkkcOb9A/Pg9OSOM3Ip4wIN4S9njlINWiYv20guzZK4WtlnUhoCDggWV2OgHMQt+x+
	 yHWDI6N9bpDTA==
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
Subject: [PATCH AUTOSEL 4.19 11/11] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:35:17 -0400
Message-ID: <20240329123522.3086878-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 5270d55132015..6a3c0ad9f10ce 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -355,7 +355,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


