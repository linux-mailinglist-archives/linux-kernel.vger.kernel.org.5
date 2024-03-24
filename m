Return-Path: <linux-kernel+bounces-113572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A9F888565
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445B4283FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBE51C8808;
	Sun, 24 Mar 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGTk0a8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F813E8BC;
	Sun, 24 Mar 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320375; cv=none; b=aWfTWAxYhZhG7LcE3P0aF1XPt1c69LFtnqXRmSTXmzRPxL1e/ATAZ8GDQ4r5WUFki3XwbXxzDdajiC3e61Ze/087giu91zFo5WWdj2VNyBGEN+faxzPzsFRBon+HU/81P5kFDweZBKnQPww7JBJHdK2/IN0Eml7/zBEU7yAvDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320375; c=relaxed/simple;
	bh=CHvIGZoy1lKp51lgMJA/2rQsWMnoPJipLMus7XjzkAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqQ8eQJ5vTZ+SovDMMQ9KRTWmmI7WCK8WpVgOJ+zvZrB0FmQYg6Z2ot0KcU0fc+6zlufFY8+jVEs9209oDZeCpFCE87imlLcyB7g9eZOolA7ojBd3gnQT6s96ky1A414xPSRGQ14HBrTDOL89urU8emm3+H0LIShABNXucFXo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGTk0a8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53047C43390;
	Sun, 24 Mar 2024 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320375;
	bh=CHvIGZoy1lKp51lgMJA/2rQsWMnoPJipLMus7XjzkAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGTk0a8W+PLN5Gzhwa6EFAeeS18HX28gD9IkKwTwaE/QEmrVXloh6vjhhLVYHkM8M
	 H2eTLaBdhiD7pJPSeXzeJQx1GAYWBfYd/lzYNphKiFHNvSG14fiMP04xIn6fqyKXd/
	 47uVo4nGL39MfhyjCEnPIpea2ceAPT8T9CzFa8jtNeidioG1bfQAsm170I/wBSTfB7
	 zHd9jAdhv/hy9OO+0C3mJ7hIaBjSwZkfJ3MnfROKCu26SEaQYRnoj+P6GmY8/2LFfG
	 9eMAC9a99VlpJ+TMj3pMfTDp7OiSUSope1uPvKj23ZaxS19v2CktMqHF6HlOlD3YN+
	 YZcRFByUpS2xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Coco Li <lixiaoyan@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 681/715] net: move dev->state into net_device_read_txrx group
Date: Sun, 24 Mar 2024 18:34:20 -0400
Message-ID: <20240324223455.1342824-682-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f6e0a4984c2e7244689ea87b62b433bed9d07e94 ]

dev->state can be read in rx and tx fast paths.

netif_running() which needs dev->state is called from
- enqueue_to_backlog() [RX path]
- __dev_direct_xmit()  [TX path]

Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240314200845.3050179-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 include/linux/netdevice.h                              | 2 +-
 net/core/dev.c                                         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index dceb49d56a911..70c4fb9d4e5ce 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -13,7 +13,7 @@ struct_dev_ifalias*                 ifalias
 unsigned_long                       mem_end                                                         
 unsigned_long                       mem_start                                                       
 unsigned_long                       base_addr                                                       
-unsigned_long                       state                                                           
+unsigned_long                       state                   read_mostly         read_mostly         netif_running(dev)
 struct_list_head                    dev_list                                                        
 struct_list_head                    napi_list                                                       
 struct_list_head                    unreg_list                                                      
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 78a09af89e39b..dba428b3a87a5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2144,6 +2144,7 @@ struct net_device {
 		struct pcpu_sw_netstats __percpu	*tstats;
 		struct pcpu_dstats __percpu		*dstats;
 	};
+	unsigned long		state;
 	unsigned int		flags;
 	unsigned short		hard_header_len;
 	netdev_features_t	features;
@@ -2189,7 +2190,6 @@ struct net_device {
 	 *	part of the usual set specified in Space.c.
 	 */
 
-	unsigned long		state;
 
 	struct list_head	dev_list;
 	struct list_head	napi_list;
diff --git a/net/core/dev.c b/net/core/dev.c
index f56f81e587236..439419d912eb0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11631,11 +11631,12 @@ static void __init net_dev_struct_check(void)
 
 	/* TXRX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, lstats);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, state);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, flags);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, hard_header_len);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, features);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ip6_ptr);
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 38);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 46);
 
 	/* RX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific);
-- 
2.43.0


