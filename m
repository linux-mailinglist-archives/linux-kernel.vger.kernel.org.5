Return-Path: <linux-kernel+bounces-110752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C288633B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FA22869CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C911136676;
	Thu, 21 Mar 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oGVFovrj"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A2136980
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059796; cv=none; b=V/B+o9nU+Z56X+uciGPklq1eQ9VZUusRrkhbOo6MTd2+LlmfdC91nMs7BSzchNhkPHUP1d4pK0EzcLRA7JA73UanZb4pNwUkpSBqJIOQI6RwOS6lAyF6cb/n5FpiVwTLNnfKS9Jog5NAa27LbYKqKgtVYz6JBvNSuC1YYv/YPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059796; c=relaxed/simple;
	bh=NU20P7WmOfIGc97qZsPprgwsBgMXCuHAhTpBT4XCf18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDXj1h9rcqwuQDRWQEsAMCQZovp6ZIseZ990o3EzrIUhmqvhCQFJ1QBX0McxGQ/Q9ex0Xrus9+1LcVrbJpMcdD8oUOPgdCZDSyqfHHDiVvvaUyWoNQBa+dFoSo39oNo0nBpEonbsUMs8806Ynxie4sNHl1GgIo5i/c6q76C2ObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oGVFovrj; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711059792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BkC8XuIKTuUKOaDN8fSurixoB+8r13LjYNJaXfm1bVQ=;
	b=oGVFovrjW70JeOCFG1ijeT2lvhnonEoyMXKz49pNekvyIe9GktpJ5ZiBFseGL7JC+u+0W1
	NU+su6w0n3HaHmG2xtgkoO0+IKKi3nEAT7lmDyU4SaZyr449rPHZfRC0yjugVCGrKFV0DF
	k1qTPjCKSDuE/Vmak7+9XVDIvGY/AbU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/debugfs: Drop conditionals around of_node pointers
Date: Fri, 22 Mar 2024 06:22:58 +0800
Message-Id: <20240321222258.1440130-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Having conditional around the of_node pointer of the drm_bridge structure
turns out to make driver code use ugly #ifdef blocks. Drop the conditionals
to simplify debugfs.

Fixes: d8dfccde2709 ("drm/bridge: Drop conditionals around of_node pointers")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 08fcefd804bc..28a471fe4bc8 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -597,10 +597,10 @@ static int bridges_show(struct seq_file *m, void *data)
 		drm_printf(&p, "\ttype: [%d] %s\n",
 			   bridge->type,
 			   drm_get_connector_type_name(bridge->type));
-#ifdef CONFIG_OF
+
 		if (bridge->of_node)
 			drm_printf(&p, "\tOF: %pOFfc\n", bridge->of_node);
-#endif
+
 		drm_printf(&p, "\tops: [0x%x]", bridge->ops);
 		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
 			drm_puts(&p, " detect");
-- 
2.34.1


