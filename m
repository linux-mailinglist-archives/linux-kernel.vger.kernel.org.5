Return-Path: <linux-kernel+bounces-101843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB087AC12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C912D28B518
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1771B3D;
	Wed, 13 Mar 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us7dx6S1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6667175E;
	Wed, 13 Mar 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347879; cv=none; b=Bij6vQRs/abRT8abGDYl41myjsCeeNAXH2vI4MXTuD0uRzxqc7omdhPpbMhgWzpZ/kzz34bAHT2YgjrVycwQJytr7qwByOLsnv+RFycEiFBfJfnMJUGTsAOl6eZMrZB9gUGFKIwmje+lmop/B6fW9kzmrx5vq1/lSUNvHOTp5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347879; c=relaxed/simple;
	bh=sMKE9+q0Dh0q2fgAnNSJaMiGGhkv/VNO3lY3K/oikNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx7MQ8MV1ENKw9wmKd7xZC6+d7HZKuN5qUDdXo7++SJDKsQge3V2igdVJoDGexNMOWBhLxxvttiGmZW5ggsAK4zxYouoxYxdxuKQWvIhG37mUHq1+BzzWbGVRug3yllRgkyNhJIBMt4O1aZmRya8qhaN4gYwPSMQ1gameS3MAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us7dx6S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7F9C433F1;
	Wed, 13 Mar 2024 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347879;
	bh=sMKE9+q0Dh0q2fgAnNSJaMiGGhkv/VNO3lY3K/oikNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Us7dx6S1puzQieRzS0XCtq34VdTyGblqP9bR43+vzAA/sf5JDjvMfBhHFg+KR/8ki
	 T5HeQ5PCLKm5n4bPX/kIUy7Jis4x0N3OfUMoyoqdaeIY2e9jFiwBX8CKyPxeAY6t0d
	 HjuWs7mthvOZWQqY2yFhHj26ScNZfQykEBhid5+RwCBAfLTr15f+g47ub3oMfDbrNm
	 cBO1nAQItG7R/zVZvA2mI1+15kC+zfAd+fWo22eG3kfVFvrOKThX4bfS8QM1uocIrH
	 9yilSuJlNTIJck+HJ9FiTDoX0r+UKkmtJY8IokJZTfyYAPuzGnll30hEQRJCe64dES
	 /q4/ak/a4zj4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 40/60] netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
Date: Wed, 13 Mar 2024 12:36:47 -0400
Message-ID: <20240313163707.615000-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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


