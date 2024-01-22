Return-Path: <linux-kernel+bounces-33304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F583682A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F9283B25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6725F84B;
	Mon, 22 Jan 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vApEiu8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C45F868;
	Mon, 22 Jan 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935722; cv=none; b=G57wvIk0kYKNqdiBxxSRSd7ZE3eRWdj2HfWsxJvkz0+5XL4yNdEdjIWF+478Ro9xWgU8WRIWVUELvNzQ0XL0tX4hwWraTGK0mOcXc57p0i1VBS60e+zu352Fi7C5YcS2qG+TBV+npZFJHIWlXEiz11NUpQc8g03IwCnysTP2QZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935722; c=relaxed/simple;
	bh=m3q+ToFjWwnp4WpJ/Dy/2htLcjii7Ow9i0kIm95oHuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMyvdqNtmLSYJGngp2sXfyxtKrhjA2wryjvhz1ho2mBg9Rt7Md5p/T2TI5o99gKSXxEICuVw+q2T4KJsS1iYQvbfSNbHVyvCuYf0l7uSUTPmhOpkoSbjswlbKUV3fSA0tGatnR+agrVOQUKUoYLAvDPq5U8H/Vbn1/FrqlPjrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vApEiu8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB06BC433C7;
	Mon, 22 Jan 2024 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935722;
	bh=m3q+ToFjWwnp4WpJ/Dy/2htLcjii7Ow9i0kIm95oHuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vApEiu8CZDbT0UWpEKSuJT4fdK2xH6bDQReFXEALAbX66/UqWavRmgpnJhpAO3zs3
	 x5ebo1K85oN7wUnPyiUT6q3ysn2ZxtJOh5irWouLdfa6fkXIzdv+Dxi9FzoDofMCAW
	 VsdBNm9lRxgAFw5ecCQJuKtBILOFDJlKbcby55InVJr9Wn2oXefqW0GP/7g/3HfItR
	 rnuJmHu2HgXfYIF9DBo0MoEVZ8k1Xr/dwmM6ATXg7kC8hojgs9lDJfCjuSE/eKxtf3
	 o3U6lR4C0Fx/vCpabphL7R8v/E34Mkk2zMaezr/5B7cZRuQYbcVYW9K4rvQasEJ1tL
	 XH6gch07DioaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 82/88] drm/amdkfd: Fix iterator used outside loop in 'kfd_add_peer_prop()'
Date: Mon, 22 Jan 2024 09:51:55 -0500
Message-ID: <20240122145608.990137-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit b1a428b45dc7e47c7acc2ad0d08d8a6dda910c4c ]

Fix the following about iterator use:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1456 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 24 ++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 057284bf50bb..d18dff7bb889 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1449,17 +1449,19 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 		/* CPU->CPU  link*/
 		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
 		if (cpu_dev) {
-			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
-				if (iolink3->node_to == iolink2->node_to)
-					break;
-
-			props->weight += iolink3->weight;
-			props->min_latency += iolink3->min_latency;
-			props->max_latency += iolink3->max_latency;
-			props->min_bandwidth = min(props->min_bandwidth,
-							iolink3->min_bandwidth);
-			props->max_bandwidth = min(props->max_bandwidth,
-							iolink3->max_bandwidth);
+			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list) {
+				if (iolink3->node_to != iolink2->node_to)
+					continue;
+
+				props->weight += iolink3->weight;
+				props->min_latency += iolink3->min_latency;
+				props->max_latency += iolink3->max_latency;
+				props->min_bandwidth = min(props->min_bandwidth,
+							   iolink3->min_bandwidth);
+				props->max_bandwidth = min(props->max_bandwidth,
+							   iolink3->max_bandwidth);
+				break;
+			}
 		} else {
 			WARN(1, "CPU node not found");
 		}
-- 
2.43.0


