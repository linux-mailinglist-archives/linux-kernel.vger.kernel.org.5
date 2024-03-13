Return-Path: <linux-kernel+bounces-102079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6C87AE39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270AD1C2319C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052B15E5B1;
	Wed, 13 Mar 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILcwp6b3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A615E5A1;
	Wed, 13 Mar 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348461; cv=none; b=Xjo7VpSzOGpRuzpI/zsowAgtHdphoYsTIfSMbfPytnmX+gCMzQdqSm4Hsq6cQGJ2R44Gci8kmxOmeJlSmo7UtoC/z6XtK41O+yF+g8P94qY7Ak5JqTbRiAE2wlofFEkojWhOx+ZFcxzlitorP29rcMrUjawg+Tt3O+c/YaAPuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348461; c=relaxed/simple;
	bh=vgRMZG9xgkjHsd1YI558si+2khyZ0254KjZZLGoJkFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCSZ5oWL4fslqCUok+yU8pYAlcDgw/BHWUhNM8yUUF4zii72mxpwEcdGYb2nMgjYZvEk8HIbDHUGc8K0f4TwC+t6DBkT55ldJ0hSN7U4oJfs5D701S7XQaHg5vSPm04oyeYetIGF25i4EpeVEPHMYN6tW/CRVr8wPrWW9F0gbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILcwp6b3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F44EC433C7;
	Wed, 13 Mar 2024 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348461;
	bh=vgRMZG9xgkjHsd1YI558si+2khyZ0254KjZZLGoJkFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILcwp6b3HQdhsAsoUN1vYeHcON7Q7g+ZMnqwg2TKki3sDBZpIo/mW4h3jaYDQfeMg
	 eSBfRaZ+5NXsJZFKYhrkeoajuyziLlIdx6bJprzFXI0dE6ZQ8Y37DzALMmQXsp7SEf
	 yLH635V2BLFOuyMBVBFEiWFtyh3urGSi4XWKcnUwkGnuQH3gB5MQL355cv8sLJ0CXt
	 J0v4ySt9V9b0eIvi9ZGdVFY7ZcAVXsfj55eTeJ4Znfb512Th9HsgA4MXm6j86uUG6m
	 /wvqANhT1yaICVeLN/TkAbYlgpUKjomLV2U0MJxEXJx88JbT6UctykA0ZmaW+1Wzw5
	 uvhh9CArBJl/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	kernel test robot <lkp@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 53/73] hv_netvsc: Wait for completion on request SWITCH_DATA_PATH
Date: Wed, 13 Mar 2024 12:46:20 -0400
Message-ID: <20240313164640.616049-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Long Li <longli@microsoft.com>

[ Upstream commit 8b31f8c982b738e4130539e47f03967c599d8e22 ]

The completion indicates if NVSP_MSG4_TYPE_SWITCH_DATA_PATH has been
processed by the VSP. The traffic is steered to VF or synthetic after we
receive this completion.

Signed-off-by: Long Li <longli@microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc.c     | 37 ++++++++++++++++++++++++++++++---
 drivers/net/hyperv/netvsc_drv.c |  1 -
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index c9b73a0448813..03333a4136bf4 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -37,6 +37,10 @@ void netvsc_switch_datapath(struct net_device *ndev, bool vf)
 	struct netvsc_device *nv_dev = rtnl_dereference(net_device_ctx->nvdev);
 	struct nvsp_message *init_pkt = &nv_dev->channel_init_pkt;
 
+	/* Block sending traffic to VF if it's about to be gone */
+	if (!vf)
+		net_device_ctx->data_path_is_vf = vf;
+
 	memset(init_pkt, 0, sizeof(struct nvsp_message));
 	init_pkt->hdr.msg_type = NVSP_MSG4_TYPE_SWITCH_DATA_PATH;
 	if (vf)
@@ -50,8 +54,11 @@ void netvsc_switch_datapath(struct net_device *ndev, bool vf)
 
 	vmbus_sendpacket(dev->channel, init_pkt,
 			       sizeof(struct nvsp_message),
-			       VMBUS_RQST_ID_NO_RESPONSE,
-			       VM_PKT_DATA_INBAND, 0);
+			       (unsigned long)init_pkt,
+			       VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	wait_for_completion(&nv_dev->channel_init_wait);
+	net_device_ctx->data_path_is_vf = vf;
 }
 
 /* Worker to setup sub channels on initial setup
@@ -757,8 +764,31 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   const struct vmpacket_descriptor *desc,
 				   int budget)
 {
-	const struct nvsp_message *nvsp_packet = hv_pkt_data(desc);
+	const struct nvsp_message *nvsp_packet;
 	u32 msglen = hv_pkt_datalen(desc);
+	struct nvsp_message *pkt_rqst;
+	u64 cmd_rqst;
+
+	/* First check if this is a VMBUS completion without data payload */
+	if (!msglen) {
+		cmd_rqst = vmbus_request_addr(&incoming_channel->requestor,
+					      (u64)desc->trans_id);
+		if (cmd_rqst == VMBUS_RQST_ERROR) {
+			netdev_err(ndev, "Invalid transaction id\n");
+			return;
+		}
+
+		pkt_rqst = (struct nvsp_message *)(uintptr_t)cmd_rqst;
+		switch (pkt_rqst->hdr.msg_type) {
+		case NVSP_MSG4_TYPE_SWITCH_DATA_PATH:
+			complete(&net_device->channel_init_wait);
+			break;
+
+		default:
+			netdev_err(ndev, "Unexpected VMBUS completion!!\n");
+		}
+		return;
+	}
 
 	/* Ensure packet is big enough to read header fields */
 	if (msglen < sizeof(struct nvsp_message_header)) {
@@ -766,6 +796,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 		return;
 	}
 
+	nvsp_packet = hv_pkt_data(desc);
 	switch (nvsp_packet->hdr.msg_type) {
 	case NVSP_MSG_TYPE_INIT_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 790bf750281ad..57a5ec098e7e0 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2429,7 +2429,6 @@ static int netvsc_vf_changed(struct net_device *vf_netdev)
 
 	if (net_device_ctx->data_path_is_vf == vf_is_up)
 		return NOTIFY_OK;
-	net_device_ctx->data_path_is_vf = vf_is_up;
 
 	if (vf_is_up && !net_device_ctx->vf_alloc) {
 		netdev_info(ndev, "Waiting for the VF association from host\n");
-- 
2.43.0


