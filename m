Return-Path: <linux-kernel+bounces-102199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CFB87AF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98782285DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475419E7E0;
	Wed, 13 Mar 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBwpyGpE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6019E7C7;
	Wed, 13 Mar 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349494; cv=none; b=nwyGz7NIJ0XluIGzU9BferNpkH4AiFs0JH98G981eTm70HGuwst+Y+MHtNvdXUgbw2fuG28kFo0a46MASSN4rGZsoUvVbGmT3e1czgrR2sLPxolHByTdKc5LkVHZ5QYfcuiXhTzR4DzpO/S7bXrD6baM/CttIaOqFBO5lxczLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349494; c=relaxed/simple;
	bh=JEZJQknV6mzm+2QPtcxWEj1uDj/pFPSSD4AzOWtkYW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnP5hq1sW3kQ0ZjDOahzXvDQE37Si6O4DAhcvz/jO5qbesnPJodfwQYA+f1ZTmdwSn9ERKZzfuoSI2TKnVbVDty+N1MvmNu6VoexBrYoj70rsURrAMwfcOMihBKOImtLlCOEevqPcjLXUbTHF86hOFgjBjHOc38/2kBRMC1U6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBwpyGpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3521AC43394;
	Wed, 13 Mar 2024 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349493;
	bh=JEZJQknV6mzm+2QPtcxWEj1uDj/pFPSSD4AzOWtkYW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBwpyGpEMO8dFsK0MtQPZc3UnbdSUdY/0krAVPoGf9hpWRFUTyuZGwiyIhqNfgIiP
	 jIxBE2WhT46tdsprN5zcsJeidSYx0Ed+6BTOSQm9zfqdHpdzhxV7sPFXs4F5WU/5Af
	 xJHk4jUakEvEDj50LtneZvo8WHcBy46M1ExwPZMjRXLVIyDyvGDQy61YBYiiPcLSVe
	 V1jHnzc2/3P5bjwAj25vty9z+M49+TL5lHE5A+Nq2y9gaK2Ip5Nr30rs2/HVmyY9/u
	 cZR4pzFDGW+WfE2ywPbgeCWTiiCHpQv3pEaSHOOrVIEjlzGPMZGx8o+bihHTRtCg+x
	 axCuwocVPp8zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/41] netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
Date: Wed, 13 Mar 2024 13:04:08 -0400
Message-ID: <20240313170435.616724-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 119cae5ea3f9e35cdada8e572cc067f072fa825a ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_dev.c  | 2 +-
 net/netrom/nr_out.c  | 2 +-
 net/netrom/nr_subr.c | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/netrom/nr_dev.c b/net/netrom/nr_dev.c
index 988f542481a83..fa845edad7bf6 100644
--- a/net/netrom/nr_dev.c
+++ b/net/netrom/nr_dev.c
@@ -84,7 +84,7 @@ static int nr_header(struct sk_buff *skb, struct net_device *dev,
 	buff[6] |= AX25_SSSID_SPARE;
 	buff    += AX25_ADDR_LEN;
 
-	*buff++ = sysctl_netrom_network_ttl_initialiser;
+	*buff++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	*buff++ = NR_PROTO_IP;
 	*buff++ = NR_PROTO_IP;
diff --git a/net/netrom/nr_out.c b/net/netrom/nr_out.c
index 00fbf1419ec6b..213bddab6e74f 100644
--- a/net/netrom/nr_out.c
+++ b/net/netrom/nr_out.c
@@ -207,7 +207,7 @@ void nr_transmit_buffer(struct sock *sk, struct sk_buff *skb)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (!nr_route_frame(skb, NULL)) {
 		kfree_skb(skb);
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index a7d3a265befb9..b5cee72b8c985 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -185,7 +185,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		*dptr++ = nr->my_id;
 		*dptr++ = frametype;
 		*dptr++ = nr->window;
-		if (nr->bpqext) *dptr++ = sysctl_netrom_network_ttl_initialiser;
+		if (nr->bpqext)
+			*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 		break;
 
 	case NR_DISCREQ:
@@ -239,7 +240,7 @@ void __nr_transmit_reply(struct sk_buff *skb, int mine, unsigned char cmdflags)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (mine) {
 		*dptr++ = 0;
-- 
2.43.0


