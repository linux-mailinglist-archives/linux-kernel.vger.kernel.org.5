Return-Path: <linux-kernel+bounces-134421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F37989B14A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B3DB2148A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BD5647F;
	Sun,  7 Apr 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcNR9xy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202D54F96;
	Sun,  7 Apr 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495507; cv=none; b=oqDYIMf4/34n1LfmwYzi9Lq6SUL5Jgh1DbYd79+mPXW3o6zMtjhOivO3O0J37hAwBTslxtkpJK/o75xVe7teudxnrGZbTbOq8e1ZrCF9mMcNisTufSkrVQAvxwaghwXHIR+YRpbJCtUq/+FVk2+Mvh+iZsTA8yvOcyzhnsbMZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495507; c=relaxed/simple;
	bh=eaLfuijtjak5nckSFYKHhB04Sy4fY9ECwMfiH4Sq+O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZmUOLKRLPQfVbno8U5jwMfC6vXacLev7N0QEQrR5KxR71xR2DT5DxBjwrhfdhN3jU4SSTh0GrrUoO5H3L8ZIA0LbzUd713NBi8RGE+4bahrY8silNihkJYxPt7M/Pt7zcT1v/NfKDgrn34D7OIbqdIDcM742tbJbkzJPtCJLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcNR9xy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6D6C433F1;
	Sun,  7 Apr 2024 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495507;
	bh=eaLfuijtjak5nckSFYKHhB04Sy4fY9ECwMfiH4Sq+O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcNR9xy/ZwP/+Yp+3CSmxZIPJMt+YzgWFNeFhppBVfMRWs3LKPznACfClsnDg1L0U
	 QKd+eVqwHypYAqOkH+5lZCV9Wu19mP4ar/J4jvqzgG9Lm6kwyG9ePugzlFGpRFx61m
	 uv3+l5lfGMNHkQmLp99LzI6ZmMspVkA0E/eigtIrrkoXxXE07FdODi67pJUroQdAmQ
	 Qi9UMFQ1i/r+G9P/abnoJm+pXRuWXx8E4OH1CNw/dlfuO5nluvyJQK004awVywmtmM
	 hr2YptyBpybDaOI1o1tMAXXq56sO1btAAf17Bl1xzoX0EVr/WWpZTsCqttTpVdbYD+
	 KJAXeQP9eANwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 11/25] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Sun,  7 Apr 2024 09:10:59 -0400
Message-ID: <20240407131130.1050321-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit ec50f3114e55406a1aad24b7dfaa1c3f4336d8eb ]

Fix the order of arguments in the TP_ARGS macro
for the rdev_dump_mpp tracepoint event.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240311164519.118398-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a50..cc3fd4177bcee 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1013,7 +1013,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-- 
2.43.0


