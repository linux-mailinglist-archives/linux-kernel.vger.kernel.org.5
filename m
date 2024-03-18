Return-Path: <linux-kernel+bounces-105918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93E87E65E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5C21F209B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1C2E64B;
	Mon, 18 Mar 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AeGSMcSO"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD52D059;
	Mon, 18 Mar 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755479; cv=none; b=aPgjqnlFiUezLz33ortKfmdxES6UR4NzK3cfo2X5yBtXowHNtRs+3HKggGR5Qnexkq+cPOod1V0zF4Vm2JDXTUGTtFwmAP66A/zDAOhtEosUxO3yp4hZpuxcmDEddJN/fjjik7bkch8wySfv7Fl4bxLpq3F9IvYDuCg75fWzEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755479; c=relaxed/simple;
	bh=WMYH0EFd48hByDNbMOqGjMtK7I1OeZsQbvStS1jV3V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ez40H4T6pmaRVJnZq3SCxWu/L0aSCLhLvIEdvaoYLpztECysMBAsSllI/F5dvV0jPd6BHPlXSDPixq4dtnWVmVqKTTGZBQpbhllrfNIUCCm2ZPe2C2riFOh7o1Q3PQCO/Ifgsgra6ossY8YlGeqfPcRS32BCqFHCc7+iYG6b1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AeGSMcSO; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 899377E9;
	Mon, 18 Mar 2024 10:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710755448;
	bh=WMYH0EFd48hByDNbMOqGjMtK7I1OeZsQbvStS1jV3V4=;
	h=From:Date:Subject:To:Cc:From;
	b=AeGSMcSOjyL7wHBJvSADZo+0GZk4EsSwk0p/SYrTdioS86SY7YhVnj/hIXFq/4a4v
	 JShWt+K+KXyQtYJScnXn5+E1CcF7ET5banIJh+GMhggKbT+4DoO31Dcsrpnc49IOfU
	 FV+dWR+GVQ5+WmfqXXIYpz/W5bobK7UwBUCP7RVo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 18 Mar 2024 11:50:59 +0200
Subject: [PATCH v2] media: mc: Fix graph walk in media_pipeline_start
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-mc-graph-fix-v2-1-416a22bf7ce8@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAIIO+GUC/3WMQQ7CIBAAv9Ls2TWFQms9+Q/TwwpY9tDSgCGah
 r+LvXucSWZ2SC6yS3Btdoguc+KwVpCnBoyndXbItjLIVqq2ExoXg3OkzeOT33ghSVJpO3Sqh5p
 s0VV97O5TZc/pFeLnuGfxs39GWaDAUVg92kHLXqgbW0cprI9A0Z5NWGAqpXwBSc8t7q8AAAA=
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Naushir Patuck <naush@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=WMYH0EFd48hByDNbMOqGjMtK7I1OeZsQbvStS1jV3V4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+A6RqDpNvE4DCA0yX22yUxG50nVbACAzzHz5p
 HW0ow+JGZ2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfgOkQAKCRD6PaqMvJYe
 9aqTD/4y9/SjKbMaalcj5au3ilLw/G2bj6jw5moo/Eb4BdfjP+LLhF6SpMpdHpzAfvZn/lY6GLe
 ggaqK6xycbu6OyduHCXo+fk6P43g/EBVaFBfcPrze5sVMxarbbokLMNSysCWi7qOIuKLBG30gp6
 cC8y6PxE5yrlKWLhm8yxYSYpz9DBz4gPtl7AuoVB3Ozd+kSUp9d+EYVdblRUeW7A5QhXHuTHvCq
 LOglbTtXCo8uAf/cjayWMossioLhbR4Bj8hpJ1zjA3Es+ary4IT9ZxrGAunkgMYKlCbMShlvuB5
 CrSeT61/QS8frpoRGfpuqGz460iKtKCu24s9l1qyJaksRctFjT3E9eF8PUJz1F5D3CqHwaUzCsU
 D1bhRgJBWfUQFrd66NBzERgyMzWQWz476p5HF94dk+Er2vIYqzTctzcTfAzCvBvEoHfJzQNIpx3
 YQr8rGGDt3kLfA5FN4mRAG0ogqZGzSRmRmiJjTeFadFMSfU6KeTgpeI0OnfP8oPPY0P0XSI1jgi
 tq7M2zxfy8WvzPiJ2ZEeG5wkTAa8ECagjRbDaJ7oxg0eizWmI3hLWhFSCk/s003qKis3O4jJ1rq
 9h0rgTuCcOLu+0YAEB/lUzdDhCY8cEpWJz5nV9NqXTs4olcWKU/pX8KiGreMoqfTWACXZOWqLUR
 zXSBicX9EhJjrfQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The graph walk tries to follow all links, even if they are not between
pads. This causes a crash with, e.g. a MEDIA_LNK_FL_ANCILLARY_LINK link.

Fix this by allowing the walk to proceed only for MEDIA_LNK_FL_DATA_LINK
links.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Fixes: ae219872834a ("media: mc: entity: Rewrite media_pipeline_start()")
---
Changes in v2:
- Move the check a bit earlier, so that we don't do a debug print for
  ancillary links using data link fields.
- Link to v1: https://lore.kernel.org/r/20240315-mc-graph-fix-v1-1-91d59d752614@ideasonboard.com
---
 drivers/media/mc/mc-entity.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 543a392f8635..3fd3dab81ea1 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -615,6 +615,12 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 	link = list_entry(entry->links, typeof(*link), list);
 	media_pipeline_walk_pop(walk);
 
+	if ((link->flags & MEDIA_LNK_FL_LINK_TYPE) != MEDIA_LNK_FL_DATA_LINK) {
+		dev_dbg(walk->mdev->dev,
+			"media pipeline: skipping link (not data-link)\n");
+		return 0;
+	}
+
 	dev_dbg(walk->mdev->dev,
 		"media pipeline: exploring link '%s':%u -> '%s':%u\n",
 		link->source->entity->name, link->source->index,

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240315-mc-graph-fix-8a2a245d7346

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


