Return-Path: <linux-kernel+bounces-104562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64F87CFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2581C22AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166C3D0CA;
	Fri, 15 Mar 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PKpN2rau"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7353FB9B;
	Fri, 15 Mar 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515597; cv=none; b=eIfVxoEkJmk4gliloumlTmOsv4w956tuFWmze14LzSIidTfqXDi5KEf7dZYaFSUu3rVGHIY4c9OThsDIAjM2d3qmAlfrJ6o2M23zfE4kr38tkvG8+UEb7gbC+u5JMk+VpXq+B3PeXc/hk9R38uvglrKahBmkWjRUVI4BKBeOPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515597; c=relaxed/simple;
	bh=2AY7wYosMxBui4A42bvOIbiacHDPC4Ah4GJYSEqnQaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjUIEpzFNYDFbNBrX732L5avXa8JDCxSB66avCWhwy5t293y2T1+odka9l59amajx86w1A81j7zj2tkM4Wn1KW3ilgyYVfRQoX+aOSk3IcpoVOFtFmWYROuJ3Yu8B869oYfVar0yh2gntTAHSIvZy3ubE4mEMJOXIJXX3rKMlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PKpN2rau; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 939F8667;
	Fri, 15 Mar 2024 16:12:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710515562;
	bh=2AY7wYosMxBui4A42bvOIbiacHDPC4Ah4GJYSEqnQaU=;
	h=From:Date:Subject:To:Cc:From;
	b=PKpN2raut8DNOs3YfqiY4blBMZuBtVZJZuC27S4NoRpDn+FdQvnnHlkR+Va6Vin7Q
	 DKqXhoSnWSpaowbRE37H9IUsi7Rc6GYQ2sCNjWO/JjuZzq2et0afrj9vFfZNn+rBE7
	 esazCMT0WwhsiKhas2V+6KnW8GOJG2AXOmTTJJtc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 15 Mar 2024 17:12:34 +0200
Subject: [PATCH] media: mc: Fix graph walk in media_pipeline_start
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-mc-graph-fix-v1-1-91d59d752614@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAGFl9GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NT3dxk3fSixIIM3bTMCl2LRKNEIxPTFHNjEzMloJaColSgMNi46Nj
 aWgDekPkPXgAAAA==
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2AY7wYosMxBui4A42bvOIbiacHDPC4Ah4GJYSEqnQaU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl9GV+oFot4EkmaQ52+4akIzZirGjR+EhB4uiRD
 pdBdA/H4OCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfRlfgAKCRD6PaqMvJYe
 9SwEEACeK/O22ZhDSCCpBN7bCF0ey7nr5IRKrxsvbSOfD2+sJdSofhMXpyEiNX/31lyZYSMYIjT
 3QRtEu4vSjFLk10dbdC8cPyO8V22V5Y0OkmTNM0F1RDwOYCMEnUstsUBvMo5ZpImjdBpilGeEtn
 id3fbi6h+1ZPfxf5fv5QXtHTUygiQtxupi7ZW6pjXX/A2OuKeL4bOsn1ZjjyooJgj0WB6AEWhva
 XM5yUZYrv30eBDvvX0RYGjDQ7O3ZjGXZj4jw1HH5fpLlr6GespXGY+DrlfT093f79dWRSDgy+TV
 310oRg22M+1bsb8k/s44Imr56fsdOBe+i7UZ2FzDQ42LtwSbZDJeWDOn6Q/w13vE2TL8qamOevh
 42jCkeo6fMd4O4GOl0oUb7V7IH3GUk6EkfakdTdHJ3La2vbnOk9U36qsBRvavbpEX3Oj0lZVbVJ
 JHI71ZJWu8K9yagOr2e8QixAsOOoMCtb7eq7qzwbmXtWA6sHWvn4yqxTC4JCYG6vDedHjbD04nq
 71PS+3LSI8dKhNY1t76jzKrbn7aiBNWuQ63ZYdeK4/YQQHPdY+ucU0jaV//vlJlWYAkfNqDB4yQ
 UJAGg+4OMIpiwPOjcng9BSimvcO7PD3OMGCgha5wMvdzfdU3+yNluyV+I0OG9S6/R52CxlSeYfr
 ZEzm9EOCcaW2Riw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The graph walk tries to follow all links, even if they are not between
pads. This causes a crash with, e.g. a MEDIA_LNK_FL_ANCILLARY_LINK link.

Fix this by allowing the walk to proceed only for MEDIA_LNK_FL_DATA_LINK
links.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Fixes: ae219872834a ("media: mc: entity: Rewrite media_pipeline_start()")
---
 drivers/media/mc/mc-entity.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 543a392f8635..fcafe5c59052 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -627,6 +627,12 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 		return 0;
 	}
 
+	if ((link->flags & MEDIA_LNK_FL_LINK_TYPE) != MEDIA_LNK_FL_DATA_LINK) {
+		dev_dbg(walk->mdev->dev,
+			"media pipeline: skipping link (not data-link)\n");
+		return 0;
+	}
+
 	/* Get the local pad and remote pad. */
 	if (link->source->entity == pad->entity) {
 		local = link->source;

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240315-mc-graph-fix-8a2a245d7346

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


