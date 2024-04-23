Return-Path: <linux-kernel+bounces-155652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAFD8AF53D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6CEB22764
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB013E3F3;
	Tue, 23 Apr 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UvaMa5/d"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276813D8BB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892759; cv=none; b=CaSBRivR+WDILTh3s/B3H+X9Lesl/2/EYCcPZChyyzolglCJ9BckC+NxkredNESdmiYSticsQhoIipFXp4t1/eyiHxLlbtYhHHOIGraU2nceWCbfqN/ozH+L+qQK6SP1n2p4VrgMSBIxtS6ax4uynr5ZCOea0Y36r8AvK0gSMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892759; c=relaxed/simple;
	bh=IHnII5Qkq8rGZ+soT10LxOWcu0pttyCxRaJkeJjdC3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogtGCC2T/0vk+eimXPzxs0Qy2nc/Xa1vo3oU1cBMmKUP343JktKAa2zIgJ9eRryUlIjKQhDnmR3uebSBF9A5t1xRxaj85LbayTm4WhbU/S2JEfo2uirmdnC0O+FEdPDhbhOtz5tgzyYjV96d14NPOoKNuP2VP/9acEs8UZzDqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UvaMa5/d; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR1mE2byZvgd8XMIJjs6doiZygvimg31wz7VNCMIkH8=;
	b=UvaMa5/dSSe/34q/bwwR7ASBx1OWo9/LShCgk9kAZXdoP1kxfeE0a0hpZUCID/7Lk85MeF
	jOVs0FY+cNhw+4GQMruPGCmJ8uLQgt2rGJvStC4ky0zWthYfD+ns92cBoTAHBkXeOUHhj6
	odsFrTKI5bm2WT+FHI/g5qZRXyrzk6I=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 03/13] drm: zynqmp_dp: Downgrade log level for aux retries message
Date: Tue, 23 Apr 2024 13:18:49 -0400
Message-Id: <20240423171859.3953024-4-sean.anderson@linux.dev>
In-Reply-To: <20240423171859.3953024-1-sean.anderson@linux.dev>
References: <20240423171859.3953024-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Enable this message for verbose debugging only as it is otherwise
printed after every AUX message, quickly filling the log buffer.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

(no changes since v1)

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 8a15d18a65a6..fdea1a9710de 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1006,7 +1006,7 @@ zynqmp_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 					       msg->buffer, msg->size,
 					       &msg->reply);
 		if (!ret) {
-			dev_dbg(dp->dev, "aux %d retries\n", i);
+			dev_vdbg(dp->dev, "aux %d retries\n", i);
 			return msg->size;
 		}
 
-- 
2.35.1.1320.gc452695387.dirty


