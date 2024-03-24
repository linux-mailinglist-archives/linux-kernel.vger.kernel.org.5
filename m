Return-Path: <linux-kernel+bounces-115768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09988978F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80521F2F29C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508B2618DB;
	Mon, 25 Mar 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbVS5Y98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3B145323;
	Sun, 24 Mar 2024 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321971; cv=none; b=emlWo5wl9mtlMKOkTTLXQhMRf/ttntMxIa+XDZCu58XnRbk/SspAXNxl+f3MMTgdVbQ3aIT2vPjjEsmmbE4Xy61SEpYLCEOLvxbJJ5xrXq4KRNAlSeBSxzjoCJhgPPU2gfIx2Z52bPi2mr8MOqaQubffT4aeRcRl6mSLBe4UBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321971; c=relaxed/simple;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXY3jWZT02nggqLbQtAPMnbNXkelSaMYQBtYxFIjzTGTpekjLKuSZNINpADx5wDCopeqCf/BrV6DCXG728FB2FtjDfYPUV6mSyX9g+bzOPI7XF0HZ1T5T32uuI2C4kC3W0G/01bf26/kDwaaon0Is/JjCQwsAO51QlvJ/Ropv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbVS5Y98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4CFC43390;
	Sun, 24 Mar 2024 23:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321971;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbVS5Y98jZPtumrEtneMHJXzI8B+VXCF2glZTaDkTLvoBgEFrd/r2lDWIRk8iDiIN
	 p3DDzv71HwInwf5OVmcU7/hMcaap7DGNhlpMrIUKSezRdQBfGwO6vA2RVtQo01Id5j
	 q3pOlrQ2xxT7ju6E19+aHsEQYlpZqSkAdkceoUaFnDHtMlWJIFxfiDf/dnyKXTWAqp
	 CRDcC71XMIXodoy9vaFih8p8SkciI8AUeyu7XLmH8fUZOrE0w6K/Fv3Te2Ls3KQP0C
	 ZncwH/hfBHfXO+OLrrlSf4ChuUwDp0vAu8A5geMXZPvp6TU8oMAXRZ4IY/C7b9be7P
	 D68EdQnk4UQqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/451] wifi: mac80211: only call drv_sta_rc_update for uploaded stations
Date: Sun, 24 Mar 2024 19:05:19 -0400
Message-ID: <20240324231207.1351418-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 413dafc8170fcb925fb17af8842f06af305f8e0b ]

When a station has not been uploaded yet, receiving SMPS or channel width
notification action frames can lead to rate_control_rate_update calling
drv_sta_rc_update with uninitialized driver private data.
Fix this by adding a missing check for sta->uploaded.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://msgid.link/20240221140535.16102-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index d5ea5f5bcf3a0..9d33fd2377c88 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -119,7 +119,8 @@ void rate_control_rate_update(struct ieee80211_local *local,
 		rcu_read_unlock();
 	}
 
-	drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
+	if (sta->uploaded)
+		drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
 }
 
 int ieee80211_rate_control_register(const struct rate_control_ops *ops)
-- 
2.43.0


