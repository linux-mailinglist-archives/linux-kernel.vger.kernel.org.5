Return-Path: <linux-kernel+bounces-100267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4FB879452
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3551C222EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033BC56B7F;
	Tue, 12 Mar 2024 12:42:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BF811
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247325; cv=none; b=CbY+T3BoLilQskmOtnvtljVFyjStn0jNSEgFRzwSemcPLtl1cB1QeidEuiik3wT3PbZQl2dDmuRKG3IJupdn6M7pIpRR7cb2tmlu7BbWlb7ZIxEYCmXfzpGfLvt6WIjUC0M1M0LJ6wMPzHREQUjvGk5nqY4FtRRwmGD7RN+G1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247325; c=relaxed/simple;
	bh=rzlfGowy5qucAgz9TKASwnEblWyJA1Ow00NPlbCzPSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WbmS18F2pqTRs0aVYNMybPrCNptZMExKGdy/VdTFo41/sBVefMpPC2ZGMpA8EmsWCA6V56YS8ZOLg3TfXLlh/rmaVrpmB6/SRzOKc5ftqDxrIVZFcYXcFqHDGAUILpp+nbGDHYIlKQjMb7G6FV9wdNQzVdsxynDdINBSeW102mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42CCfoGB257095;
	Tue, 12 Mar 2024 18:11:50 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42CCfo67257094;
	Tue, 12 Mar 2024 18:11:50 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add the IP information of the soc
Date: Tue, 12 Mar 2024 18:11:47 +0530
Message-Id: <20240312124148.257067-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add all the IP's information on a SOC to the
devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index a0dbccad2f53..611fdb90a1fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -196,6 +196,25 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
 
+	/* GPU IP's information of the SOC */
+	if (coredump->adev) {
+		drm_printf(&p, "\nIP Information\n");
+		drm_printf(&p, "SOC Family: %d\n", coredump->adev->family);
+		drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->rev_id);
+
+		for (int i = 0; i < coredump->adev->num_ip_blocks; i++) {
+			struct amdgpu_ip_block *ip =
+				&coredump->adev->ip_blocks[i];
+			drm_printf(&p, "IP type: %d IP name: %s\n",
+				   ip->version->type,
+				   ip->version->funcs->name);
+			drm_printf(&p, "IP version: (%d,%d,%d)\n\n",
+				   ip->version->major,
+				   ip->version->minor,
+				   ip->version->rev);
+		}
+	}
+
 	if (coredump->ring) {
 		drm_printf(&p, "\nRing timed out details\n");
 		drm_printf(&p, "IP Type: %d Ring Name: %s\n",
-- 
2.34.1


