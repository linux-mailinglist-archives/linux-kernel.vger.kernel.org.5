Return-Path: <linux-kernel+bounces-101958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4C287AD16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ECB284E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77B6311B;
	Wed, 13 Mar 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edRCbHWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34013B7A3;
	Wed, 13 Mar 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348167; cv=none; b=hOe8c05L5pottobUyMhGckheBAVti1yuYITefeQaLmHG3DqCd1VYN1dGdDLQ3LZjhxQYggi6WOPiKKoCXy0C95AUzFB6zbdrKuQg3QCV/9tsvwB2uJuUvv5U3eHekvQN2W8SrzmGRWzhqU6zyRU+yUX3LgWPrtYy74g1yjzu65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348167; c=relaxed/simple;
	bh=gnQIEhthbcxCrWwdE1rXnIZF674rQKVPTnmEWr6Yt1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVIXrhzSpElEtnqtQarpofSCXyyjQEnultM/YiD6WnR5jSdM5j/zrnpo+HdiKp/mQ28zGbFj7/H/yVotqaZ9CrCGBf68goHpDlBCgIekp9MqWt+fp+G5oayU+V8KFn/Urjt+5SA+JdXNGqXcSXZh9INqIyyF9iBDRAemMaE1eow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edRCbHWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A992C43390;
	Wed, 13 Mar 2024 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348167;
	bh=gnQIEhthbcxCrWwdE1rXnIZF674rQKVPTnmEWr6Yt1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edRCbHWCvc98WanTg/7NWHOxQJRzJabJ5o1PG0IU2nUp6TEdKwFbpe2SadjGmQ+kX
	 rVXtTo9L0D+CXmQ8NEUtDr53uxDFDG+k4V1vzkOHvZtsaJ9m8lrzK3ks3vElhCBIWH
	 inbd81PzAEPFjbNe8l5lQHw79dpFPLUv+Hga0MrSSFwZ46HiUb4UnuyubVGaF1sTfc
	 AefENY0nWjDr2OUsgAQGdXCKDero6la5jWkfNA10arGxKCfaFNA38UitD23ASaPNP7
	 9OItHhc/OCGewJRsX94+rPXIFssFKBKrMJWLqj9APDSU8s0vBpSvHoah3Gq6noPloD
	 v5P0+67C+YjSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 18/76] netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
Date: Wed, 13 Mar 2024 12:41:25 -0400
Message-ID: <20240313164223.615640-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 29e418c8c6c30..4caee8754b794 100644
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


