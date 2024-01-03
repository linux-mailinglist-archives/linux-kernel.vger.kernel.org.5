Return-Path: <linux-kernel+bounces-15464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEB822C55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475E6B22F97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF318EC0;
	Wed,  3 Jan 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf4DKVDs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3818EB6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F35C433C7;
	Wed,  3 Jan 2024 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704282506;
	bh=TN4lVGjd6QgiOjbr2X4wDvGDWbLRLSblB4xYrWWI6lw=;
	h=From:To:Cc:Subject:Date:From;
	b=Kf4DKVDsaGBDnt0o7IU4upkaXehBOSF80PmZtgxGgRffIJ1uxSqOP1/tZyXSBswG+
	 1REoSI3SpAFR6jT2GFB2HtuZtLsi6w8pNyFOw8FPN3Cpmja0Ymiy3gZYTAzwTxKIhl
	 WR/7PQFUdC5BRh/5Dzlb9TwWA/cXneE//2OMWKuyxbO8xY5HOPdfgnDXVg38oVwsX/
	 lUury3x+DdDfHLNMhtIVnEgtYhqFTAPJTTXuPANGO+F6TsEpbeAErEo8BNzzbv9IAO
	 bVNsCnj7LORrfJ8sm6rPqMj5rVx9xwfCT35Dcbt0UrW8Gmerqs+trqLYZSmECGDRJ8
	 vhQ+2tVYB/KUw==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Roper <matthew.d.roper@intel.com>,
	Brian Welty <brian.welty@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: circumvent bogus stringop-overflow warning
Date: Wed,  3 Jan 2024 12:48:02 +0100
Message-Id: <20240103114819.2913937-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-13 warns about an array overflow that it sees but that is
prevented by the "asid % NUM_PF_QUEUE" calculation:

drivers/gpu/drm/xe/xe_gt_pagefault.c: In function 'xe_guc_pagefault_handler':
include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of size 0 [-Werror=stringop-overflow=]
include/linux/fortify-string.h:689:26: note: in expansion of macro '__fortify_memcpy_chk'
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/xe/xe_gt_pagefault.c:341:17: note: in expansion of macro 'memcpy'
  341 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
      |                 ^~~~~~
drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object 'tile' of size 8

I found that rewriting the assignment using pointer addition rather than the
equivalent array index calculation prevents the warning, so use that instead.

I sent a bug report against gcc for the false positive warning.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113214
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_gt_pagefault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 59a70d2e0a7a..78dc08cc2bfe 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -332,7 +332,7 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
 		return -EPROTO;
 
 	asid = FIELD_GET(PFD_ASID, msg[1]);
-	pf_queue = &gt->usm.pf_queue[asid % NUM_PF_QUEUE];
+	pf_queue = gt->usm.pf_queue + (asid % NUM_PF_QUEUE);
 
 	spin_lock_irqsave(&pf_queue->lock, flags);
 	full = pf_queue_full(pf_queue);
-- 
2.39.2


