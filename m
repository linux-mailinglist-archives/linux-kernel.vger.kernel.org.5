Return-Path: <linux-kernel+bounces-37530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8883B14D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7E71C22D61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207B013172C;
	Wed, 24 Jan 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9zednOA"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC7131729
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121479; cv=none; b=He6XkJRCG25qZwx0RnLc1d58absARp0Dz2m/w/gqcUqini3/dgA1KGalpJMAn5y+KJUea8YnPzt8qXLjOolRgNwmQEaDkCpKUxuWTv5bdpPbsBbF3HMTYG/xbGjPps0UhkfM9Cy1Y6JSEhKJx9qSkcMgqVxukt3ZkuGYyyP7rcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121479; c=relaxed/simple;
	bh=Xyb5CKMj+NvIbbsu1uryZ5g8Ev7TOk4OhIHNmRBnZg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPdtnvMNTfHOPL64phM7XQ/bfgOXvmjupJqP2zf87Ly2Vm/eKC5aFrDPnj8UguchZlnPtMjakW0qEtCnZQwPxoWv5bjbAjs8QkXzG6mIwoT85bVRXPeZJei6E/hME0m0wpTolistZ35DbB/32lOFvUFG1pG9Sf1RJj6FnqaMe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9zednOA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d73066880eso36233975ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121477; x=1706726277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uy1zbE7Ow0ZllWQflOItrn5r6MhCAv/GdXD6u9M4X4w=;
        b=e9zednOA6agMto/5t+gKbvzJBK0x06SDr1UNDBoYvHcX8hKhBZVUepC67P0tzFkRVp
         Smwki7PVafIs2oX2fciPK5NLjy99/iKLhzIvjxFPSIqUGppcUPa6Nf2UdGp8x/xvMPdS
         KGyFZRE199RIYyesIT9ebQ6TDE6YppazCm+nLZR/lOur/cZ7dDxY32fZrQJCMscMcPbX
         iwDQF9MjklzX++nRkBqciuFrwpq5ZIbuV35VkrwUDJEYOQaJirrYr4IhjL1HDXPrrXVC
         MSpEjetvxBeRmaW06wsjQhe13RYFl9sBtE4iCO04kSBjIj1Kn5v4l6L71DeN/vAVE7ME
         s5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121477; x=1706726277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uy1zbE7Ow0ZllWQflOItrn5r6MhCAv/GdXD6u9M4X4w=;
        b=spjwVCyl+RHq0bKxdS9Ar9rIEPTF/GWhIzsFULpRcHcSKKpPLeTRRP9AIwhlYhhNFh
         9ZPt/7nruCcgEtoy4BnpSROeHSMB8GXBaukSAkiS2jRLa2JO11C13d2B4GQuLFwUZgDt
         j/rAyGmjOl//nusmQRtQlfkL2uuBZpD2x2Kz1KOvi5H6bmkEIq9RSawVcT9ONwB30jWN
         n0c7ovg+ZEyTgXdQ97Z4UGAvS8g90VNfgfTY3JclITw1qXlUo4D3S9Vmkql9vj34PA5G
         UbaRC9+UlYL+xgX7hUdYm14fe/BFRDiNiWJ/dIiGN8PtGEHsaRsqnQToVQzasz9c7ywG
         X8oQ==
X-Gm-Message-State: AOJu0YwF2y0Gk29NGlja90bH3FoVSAd3aMSIUYXWkh3GaO+QDCGgzdmh
	Zy2VTNODzDU3FYIR4ITT2voZ9Xlf2eGuS0TzV9jWXF6Y9JeVSclJ
X-Google-Smtp-Source: AGHT+IEEtOOn3AthjBuyeWZtT1koM4VgPdfcfUM6YWfT8gLBjkbiB9Zl/25bjS2JgSgzdfT2MElqLA==
X-Received: by 2002:a17:903:4295:b0:1d5:7220:9ff with SMTP id ju21-20020a170903429500b001d5722009ffmr1204364plb.117.1706121477275;
        Wed, 24 Jan 2024 10:37:57 -0800 (PST)
Received: from kousik.local ([2405:201:c006:31fd:9614:de6d:cab9:f490])
        by smtp.gmail.com with ESMTPSA id mm14-20020a1709030a0e00b001d7222d8caasm8729214plb.50.2024.01.24.10.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:37:56 -0800 (PST)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] gpu: drm: display: indent fix in comment
Date: Thu, 25 Jan 2024 00:05:56 +0530
Message-ID: <20240124183659.511731-1-five231003@gmail.com>
X-Mailer: git-send-email 2.43.0.370.g8962b674a6.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments explaining the function "drm_dp_mst_atom_check_mgr()" had
uneven indentation which made "make htmldocs" complain:

	Documentation/gpu/drm-kms-helpers:296:
	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5496:
	ERROR: Unexpected indentation.

	Documentation/gpu/drm-kms-helpers:296:
	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5500:
	WARNING: Block quote ends without a blank line; unexpected unindent.

Fix this by getting the indent right.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index bd6c24d4213c..f26cc85e7dbf 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5490,15 +5490,15 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_enable_dsc);
  * Returns:
  *   - 0 if the new state is valid
  *   - %-ENOSPC, if the new state is invalid, because of BW limitation
- *         @failing_port is set to:
- *         - The non-root port where a BW limit check failed
- *           with all the ports downstream of @failing_port passing
- *           the BW limit check.
- *           The returned port pointer is valid until at least
- *           one payload downstream of it exists.
- *         - %NULL if the BW limit check failed at the root port
- *           with all the ports downstream of the root port passing
- *           the BW limit check.
+ *     @failing_port is set to:
+ *
+ *       - The non-root port where a BW limit check failed with all the ports
+ *         downstream of @failing_port passing the BW limit check.
+ *         The returned port pointer is valid until at least one payload
+ *         downstream of it exists.
+ *       - %NULL if the BW limit check failed at the root port with all the
+ *         ports downstream of the root port passing the BW limit check.
+ *
  *   - %-EINVAL, if the new state is invalid, because the root port has
  *     too many payloads.
  */
-- 
2.43.0.370.g8962b674a6.dirty


