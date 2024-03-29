Return-Path: <linux-kernel+bounces-124594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07C891A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F45B25651
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08D1586D7;
	Fri, 29 Mar 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY1a+4sZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE19158219;
	Fri, 29 Mar 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715494; cv=none; b=uSfpn1eanD8jEgZPxgstFO52m9ROXysQg6F3vDupgc/YYshnWqidnIncaqT6py6oQ8JMPrWF4JTIkUVThSR55oT/m2atlNz2xrnZlt6qZdICEkEZQ12VpQQpxVtz73j6vr9HGuOhbsoisIyUHZugwpG696l55kaqX8XzUbDNLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715494; c=relaxed/simple;
	bh=n/uICVJ6Bgvbb8Rpae0SEo3n3fwG85SVdYwilNORbzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6d71/21X8Iqdgd7IWUwIXOT8dzzkVu6ukzqXJ5evrLuMACF3PRkZJqv0TxLTTA58vfAtDLYuuI96ZyC+ufTwgGFV5WxZgy+9lfkTUibytHHc0toPZhv47sBvHVl60+h+RH56VcS1UJoN5ulBYINUTXg7QaWJ2mY+93vwiDsCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY1a+4sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A418C43399;
	Fri, 29 Mar 2024 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715493;
	bh=n/uICVJ6Bgvbb8Rpae0SEo3n3fwG85SVdYwilNORbzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DY1a+4sZjU+aOcfcuKClhVvS0UffwBCT/F8ofoIwrQ2e7rwmXQoKvER4VlWlB0xOZ
	 DZAfIystlZapzn6fbyjlpyTRbOmXKy2W02e2AI95+zPiyphHdCktbHmhL8goOneyEB
	 W1VRe2dhPkzz9lVJB0FmoMBz8uye2fM+NMaTWVdhZeJh8I+giWLhaTfoF9Jo6tp85T
	 33JgBgyrQ51yA9SRLiqBzKcps1xQwPMOcueJPErJ1rpKpAWZ6l9ZZfx2cJdHY0C+So
	 2E1Ejaci2EMbAzUvblaEYy9w9mNDA/fmyORFdcX5JCSTW8ni4JqtCox89SX5ZnezRA
	 E8utCKt+ekL6w==
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
Subject: [PATCH AUTOSEL 6.6 43/52] wifi: cfg80211: check A-MSDU format more carefully
Date: Fri, 29 Mar 2024 08:29:13 -0400
Message-ID: <20240329122956.3083859-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 1783ab9d57a31..9aa7bdce20b26 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -797,15 +797,19 @@ ieee80211_amsdu_subframe_length(void *field, u8 mesh_flags, u8 hdr_type)
 
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
 
@@ -813,7 +817,6 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 						      mesh_hdr);
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
-		remaining = skb->len - offset;
 
 		if (subframe_len > remaining)
 			return false;
@@ -831,7 +834,7 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 {
 	unsigned int hlen = ALIGN(extra_headroom, 4);
 	struct sk_buff *frame = NULL;
-	int offset = 0, remaining;
+	int offset = 0;
 	struct {
 		struct ethhdr eth;
 		uint8_t flags;
@@ -845,10 +848,14 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
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
@@ -858,7 +865,6 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		padding = (4 - subframe_len) & 0x3;
 
 		/* the last MSDU has no padding */
-		remaining = skb->len - offset;
 		if (subframe_len > remaining)
 			goto purge;
 		/* mitigate A-MSDU aggregation injection attacks */
-- 
2.43.0


