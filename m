Return-Path: <linux-kernel+bounces-71098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7685A095
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B91C21669
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A102C194;
	Mon, 19 Feb 2024 10:09:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721428E22
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337378; cv=none; b=fwIWMG8KZ47XVfJb5xkI7aMwdvXBofHNP7+w3KrgY2H0UcJPAsZ1BUt/J/uJ1dJMNIgfkTTsWdJHKPKe9AfDWwwaplXSOMBoseNYYyOg0eOF8A2bQV9IHBDUxlkD+V9xRqoNluflBJwFdn1wIWefbp6wrTBI5wNoAKEGlm4Gg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337378; c=relaxed/simple;
	bh=D+5MITGSTIWZmg+eDLdAq8eiW/paDZ2Wz+SdaFAiXlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sr7inpt1zeWfI+4DbJnDZXKlH9gk3TyJp352562kO7YpJ1BB/ERV4s57+pwFzflVPABuMFucItDVjkJvG42bmFk4/EIDEjAWHygNo+WufUydqnW2G/Nj6qp7pWtGJP3w/RMVhUuUeMusL6Zw0zQKGBz8qikrIKCbh1Mbfc0RynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 009491FB;
	Mon, 19 Feb 2024 02:10:16 -0800 (PST)
Received: from a077854.blr.arm.com (a077854.arm.com [10.162.41.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 801233F762;
	Mon, 19 Feb 2024 02:09:33 -0800 (PST)
From: Faiz Abbas <faiz.abbas@arm.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Faiz Abbas <faiz.abbas@arm.com>
Subject: [PATCH 2/3] drm/arm/komeda: Move pipeline prints to after the entire pipeline has been enabled
Date: Mon, 19 Feb 2024 15:39:14 +0530
Message-Id: <20240219100915.192475-3-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219100915.192475-1-faiz.abbas@arm.com>
References: <20240219100915.192475-1-faiz.abbas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The komeda driver prints a pretty verbose log in komeda_pipeline_dump()
detailing the components of each of the two pipelines. This gets printed
multiple times during boot as komeda EPROBE_DEFERs waiting for the
remote bridge drivers to come up. Move this log to after this has
happened indicating that the printed pipeline is actually completely up.

Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c     | 2 ++
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h      | 1 +
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index b645c5998230..92ac09dc033b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -667,6 +667,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
 
 	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
 
+	komeda_pipeline_dump(pipe);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index a4048724564d..83e61c4080c2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -191,5 +191,6 @@ void komeda_crtc_flush_and_wait_for_flip_done(struct komeda_crtc *kcrtc,
 struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev);
 void komeda_kms_detach(struct komeda_kms_dev *kms);
 void komeda_kms_shutdown(struct komeda_kms_dev *kms);
+void komeda_pipeline_dump(struct komeda_pipeline *pipe);
 
 #endif /*_KOMEDA_KMS_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 4b7d94961527..4b64ed9e9df5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -9,6 +9,7 @@
 #include <drm/drm_print.h>
 
 #include "komeda_dev.h"
+#include "komeda_kms.h"
 #include "komeda_pipeline.h"
 
 /** komeda_pipeline_add - Add a pipeline to &komeda_dev */
@@ -246,7 +247,7 @@ static void komeda_component_dump(struct komeda_component *c)
 		  c->max_active_outputs, c->supported_outputs);
 }
 
-static void komeda_pipeline_dump(struct komeda_pipeline *pipe)
+void komeda_pipeline_dump(struct komeda_pipeline *pipe)
 {
 	struct komeda_component *c;
 	int id;
@@ -350,7 +351,6 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev)
 		pipe = mdev->pipelines[i];
 
 		komeda_pipeline_assemble(pipe);
-		komeda_pipeline_dump(pipe);
 	}
 
 	return 0;
-- 
2.25.1


