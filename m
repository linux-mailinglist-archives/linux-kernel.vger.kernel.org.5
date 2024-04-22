Return-Path: <linux-kernel+bounces-153859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C458AD442
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F851F22F91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81955155720;
	Mon, 22 Apr 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FjFAOJNQ"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD56155338
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811567; cv=none; b=A/ECORZyVjCS7lnCYtSQ2WBvATi8phoL9HaBktxyEPft1t19jR21G4lSCdu0hno4I1cwuOcPENcWgsKa6XFQTYWCby2ygMwi5cjJHyfWA2HMlV9gN5I74hGg/v9/LrWGP3ipSw7dJXTCIqeEYg7dUsdQV4ZqdlWG5VER+i4xJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811567; c=relaxed/simple;
	bh=qJbgCk06f9EtuLexxSqQY46VeC7RtShUsiMcajZAVyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hcds3Fyp0Syc6dL5QYzQm5Xz2hHGgMYLTXXEcYEZ5evap99/UogC8C70tLjUtop6lpY/jFD65JsFRQN7p9uw6mX6R9DFSJRzzYhD8JjfAY06R1Bb9xDJdGO3tSAAugiHZ5zkfB/XN/LipN7sf0bRZgbkXXha0k12eEvssrzzbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FjFAOJNQ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkXpb3WGgKk2uvjAts1YPyhK3aCecX0hWFuIJkiMFIA=;
	b=FjFAOJNQRo3DddcCHr4Qlx+yQXOB0rP4S40SGrVgimmMg1I3iSVvSyb1LvPPHL1Sw97lcg
	DmwXevAQXLY8MVNnzJrdgsPVr7IuyUcolxx/xZJ3v/pNnxZDe3JWXkQAlWkGslJptOZvSM
	739Bk8o7ZCV4nEx+ke6xzBd11ymbbT8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 03/13] drm: zynqmp_dp: Downgrade log level for aux retries message
Date: Mon, 22 Apr 2024 14:45:43 -0400
Message-Id: <20240422184553.3573009-4-sean.anderson@linux.dev>
In-Reply-To: <20240422184553.3573009-1-sean.anderson@linux.dev>
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
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
index a0606fab0e22..98a32e6a0459 100644
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


