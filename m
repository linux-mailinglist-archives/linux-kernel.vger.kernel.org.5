Return-Path: <linux-kernel+bounces-101889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACADB87AC76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD40C1C20FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0C7C0A4;
	Wed, 13 Mar 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i58RMqc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7B7C080;
	Wed, 13 Mar 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348025; cv=none; b=lSIt1x4RtktLuMPHZZcA5YgeI2kKyqcVm5RxKS6qjIFG8WeishRy3J68lHIFaQwYPbZqVd2M3e220HrgeuWqIDGa8w4hFdS2fxQKxT7IXGrnjkv+/2/IJ5/RbSrQpC/bmvJ241a7V14pcqpxAyuA5ClYBkgv03QkUADIjMer+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348025; c=relaxed/simple;
	bh=sMKE9+q0Dh0q2fgAnNSJaMiGGhkv/VNO3lY3K/oikNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBgAErvuK1290rz4qvuPIdu9Ua7JB7GGFXaH3lXSj4vfkDlzoRNiAKmkjydkRnSv61Zn//1fhCna8vsVgJEqXtpr1Ak+noF8VwCyYWBMLBS5uvMBksRcGDflJnlhZkUS1rksRhGO3dVYjj4ZgH3JUbI5ClIykLQyZLruCpQu/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i58RMqc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA73C43394;
	Wed, 13 Mar 2024 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348024;
	bh=sMKE9+q0Dh0q2fgAnNSJaMiGGhkv/VNO3lY3K/oikNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i58RMqc+zcX9CJD1dCBadlIMM4LVAKXmNG1fylDJjD+e0duwIfSlmhS314GbfN3io
	 QyLh2ap62tM+vm09YAZvLybp+UKp4afvAJcnqETI82SmiLmH5WhRLsIJbJxcpPhdiV
	 sf914U7hd65BJl8tBl8KaqQ/fgQ0lJTK2Ro5V/++y/V4cQP34tyOytSql38ESfWXEu
	 dKA7m7Gm5rEV3tj7UUe84UpF6CQNUHj5J1Oot8prYbWPQq6Rh3VEw9CN/eUrjTTG/g
	 tX+XZ01N7t1MuKLccVFLuSCidpe/PH49w6r74NUZB1aELVKOW0HaW6l//+EgZ3uBNc
	 irlYBesLYD02w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 21/71] netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
Date: Wed, 13 Mar 2024 12:39:07 -0400
Message-ID: <20240313163957.615276-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index 3aaac4a22b387..2c34389c3ce6f 100644
--- a/net/netrom/nr_dev.c
+++ b/net/netrom/nr_dev.c
@@ -81,7 +81,7 @@ static int nr_header(struct sk_buff *skb, struct net_device *dev,
 	buff[6] |= AX25_SSSID_SPARE;
 	buff    += AX25_ADDR_LEN;
 
-	*buff++ = sysctl_netrom_network_ttl_initialiser;
+	*buff++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	*buff++ = NR_PROTO_IP;
 	*buff++ = NR_PROTO_IP;
diff --git a/net/netrom/nr_out.c b/net/netrom/nr_out.c
index 44929657f5b71..5e531394a724b 100644
--- a/net/netrom/nr_out.c
+++ b/net/netrom/nr_out.c
@@ -204,7 +204,7 @@ void nr_transmit_buffer(struct sock *sk, struct sk_buff *skb)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (!nr_route_frame(skb, NULL)) {
 		kfree_skb(skb);
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index e2d2af924cff4..c3bbd5880850b 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -182,7 +182,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		*dptr++ = nr->my_id;
 		*dptr++ = frametype;
 		*dptr++ = nr->window;
-		if (nr->bpqext) *dptr++ = sysctl_netrom_network_ttl_initialiser;
+		if (nr->bpqext)
+			*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 		break;
 
 	case NR_DISCREQ:
@@ -236,7 +237,7 @@ void __nr_transmit_reply(struct sk_buff *skb, int mine, unsigned char cmdflags)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (mine) {
 		*dptr++ = 0;
-- 
2.43.0


