Return-Path: <linux-kernel+bounces-134485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E389B210
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FEF282A72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2214137906;
	Sun,  7 Apr 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNWdoHfu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0E137762;
	Sun,  7 Apr 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495646; cv=none; b=n3a5fNS7Y7piepcSAV6PRvhZ9n8oQCs3Oe4mX/0VAv23VBvThYQjNdtbxpOJ7eoQX2atuP3OVcm+PfcDwY9nM/tJ5JoOUjaFL8jfe8RyTOn/qIeecCjsOmtTR7KM9FpkxMG/ITPYYNaqY4f/kZ0ATuu4BcrX8H+ftdveYAPTl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495646; c=relaxed/simple;
	bh=q5pCXGbofXzgmJh8XdfswXd9pt3yAaN6CMywf7QJ5zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szvRmDzcnEZRHGyhdRngRypon07IvbtBBKmH9H3U3G3LCh2WqMliAJsgrclecebYNaEMGhdIdQsBJa/W9d/IJd+TiE/ZtpE3t/6Iotl+0oUUh1dPOgEbdA1wrxhKB2rD3REgH6atvQYbpM3Ao3YjZfsIkwbr4yjdm78+OOz4cXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNWdoHfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA024C433F1;
	Sun,  7 Apr 2024 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495646;
	bh=q5pCXGbofXzgmJh8XdfswXd9pt3yAaN6CMywf7QJ5zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNWdoHfuYSoL3GfAmWZ4dGzhM7GQ17X2hWFFTWADCOEx124gqrLl8gXBcoF5Xja8v
	 J6wo3+JRAlJajK7RDTLYAqiuiws019YQnhwEVAuJXTaHquFMMnkVIRrY5V2FK51Rgi
	 kmV7SxO9sDSES50xrU4Tjdj4Jyj+DEKEZJaeOchspXaDzqg2KbL31Q/LOBXykBlWq6
	 +dPMo5EGU19ydSnm6280HC3sFdLhZeMUlpf0AMTU4mwwjo7lmmwQBjv3631XKULNwu
	 ShvscKFR31PcIWDX+SIHQYCWTV4APNdnwUaVhiOACeQoqecy1Ofk3g9X/H5Yb5SsKF
	 2zcIeDVHozo4g==
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
Subject: [PATCH AUTOSEL 5.10 4/7] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Sun,  7 Apr 2024 09:13:55 -0400
Message-ID: <20240407131400.1053377-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131400.1053377-1-sashal@kernel.org>
References: <20240407131400.1053377-1-sashal@kernel.org>
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
index 6e218a0acd4e3..edc824c103e83 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -968,7 +968,7 @@ TRACE_EVENT(rdev_get_mpp,
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


