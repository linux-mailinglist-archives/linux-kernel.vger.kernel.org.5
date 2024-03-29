Return-Path: <linux-kernel+bounces-124540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BE891990
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464271F21FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B9149C65;
	Fri, 29 Mar 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA1ttXm9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359E1494DA;
	Fri, 29 Mar 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715341; cv=none; b=PgAKlW6dBdNn/AnOneGnG+CnsTMCciP47QvGt1PNUeXdOoe8b/eUYpnLiwo1jWtB+LmSMZaohkwXnX+2ylkqEFC9+JTn5LLRJAKaxulRcCmSEnefCF+OIk0K9CCWP9aRfXTJa1lA25vMoYyRbpBM1FSeh4y0Qt5YVWq+LW19pA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715341; c=relaxed/simple;
	bh=VBbr5zV+DGiCnpCpxIGYBmWTVXJfvphyBATaBXAmY8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiJNsYADNvd/QmYdBfvohMZqrCuW4lFTKr5sTMKetUvWSvK/q3uhxtYBqfVYByN4tyK39wyZVQHdtxpd9+wqomkh8Z7CFBvsaueT/QLWfn7scb3ZOAIXxPur9Dbf3YIp+W/EmH4c2HfgSMX/ILcYluWDJvpmoHdaykm5DYL5/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA1ttXm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA0C433A6;
	Fri, 29 Mar 2024 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715341;
	bh=VBbr5zV+DGiCnpCpxIGYBmWTVXJfvphyBATaBXAmY8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nA1ttXm9PKt3XZj729XZD22+k9T98SG4dFAnpAo9Iey9W72Ip38tn5P7f3PjEUwAp
	 Pkid58TI2m2FKLxK1lwH/HFU1eZqEY9NSVWN2FOqlDriA/tm3Y+z8X1IemCLW07XZt
	 7QdXTEtSokD9Qf1HcPFt8Pj3pDCK7lcEqCt/xo2idkDUynIg7SqzOTRnWnn6auv9wc
	 qYMVZXuSTMkAS6WVFi7Eeni8n2WsIPgc91+Mcgj86ANrVsMXn6KoCadYd3c5ffxm1v
	 GSyHZ5f0/M+byGTr+CQ0nbuINpQBbvk6nd15hWuPbL3mJ275J/tdo803sWs/5pd7ws
	 BvEs6h/XaVfAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 58/68] wifi: cfg80211: check A-MSDU format more carefully
Date: Fri, 29 Mar 2024 08:25:54 -0400
Message-ID: <20240329122652.3082296-58-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 9ad7974856926129f190ffbe3beea78460b3b7cc ]

If it looks like there's another subframe in the A-MSDU
but the header isn't fully there, we can end up reading
data out of bounds, only to discard later. Make this a
bit more careful and check if the subframe header can
even be present.

Reported-by: syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com
Link: https://msgid.link/20240226203405.a731e2c95e38.I82ce7d8c0cc8970ce29d0a39fdc07f1ffc425be4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index d1ce3bee27973..b9d15f369378b 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -791,15 +791,19 @@ ieee80211_amsdu_subframe_length(void *field, u8 mesh_flags, u8 hdr_type)
 
 bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 {
-	int offset = 0, remaining, subframe_len, padding;
+	int offset = 0, subframe_len, padding;
 
 	for (offset = 0; offset < skb->len; offset += subframe_len + padding) {
+		int remaining = skb->len - offset;
 		struct {
 		    __be16 len;
 		    u8 mesh_flags;
 		} hdr;
 		u16 len;
 
+		if (sizeof(hdr) > remaining)
+			return false;
+
 		if (skb_copy_bits(skb, offset + 2 * ETH_ALEN, &hdr, sizeof(hdr)) < 0)
 			return false;
 
@@ -807,7 +811,6 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 						      mesh_hdr);
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
-		remaining = skb->len - offset;
 
 		if (subframe_len > remaining)
 			return false;
@@ -825,7 +828,7 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 {
 	unsigned int hlen = ALIGN(extra_headroom, 4);
 	struct sk_buff *frame = NULL;
-	int offset = 0, remaining;
+	int offset = 0;
 	struct {
 		struct ethhdr eth;
 		uint8_t flags;
@@ -839,10 +842,14 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		copy_len = sizeof(hdr);
 
 	while (!last) {
+		int remaining = skb->len - offset;
 		unsigned int subframe_len;
 		int len, mesh_len = 0;
 		u8 padding;
 
+		if (copy_len > remaining)
+			goto purge;
+
 		skb_copy_bits(skb, offset, &hdr, copy_len);
 		if (iftype == NL80211_IFTYPE_MESH_POINT)
 			mesh_len = __ieee80211_get_mesh_hdrlen(hdr.flags);
@@ -852,7 +859,6 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		padding = (4 - subframe_len) & 0x3;
 
 		/* the last MSDU has no padding */
-		remaining = skb->len - offset;
 		if (subframe_len > remaining)
 			goto purge;
 		/* mitigate A-MSDU aggregation injection attacks */
-- 
2.43.0


