Return-Path: <linux-kernel+bounces-162737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F648B5FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C551F22A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31284E1A;
	Mon, 29 Apr 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONnyqKhu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060386626;
	Mon, 29 Apr 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410960; cv=none; b=Xhc3N9rmoXqzQyNIY++JSPNsVdDa4N3NKfR3CDEvX72Awkc7SfJ+hSDQKWebu43AaEnLKYlduci77mdgnPIvXmrPMcA7aghTinjdBdPHaEmEVz5G0CK66rY/M3NJKo+thTBldrCscu4wyUvD4IiKu0Mb5cQ4eIT9nuF5uqxUfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410960; c=relaxed/simple;
	bh=a44/BSmG3RBpZbPjmIXq4XJfaUsc1AETKifkN/jhmU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kq3QW4wKlcjKbialo5ojxvuKVzD8ZsUcupvEiOtFEe+A2q5QiUSncqDjFn+euScOqvFflUWyTFx0WzrY8ETcGKomkajf9YOe0kG5tZFtC3N5ztm7rnEz0N5z3FD9Q+JQyVhbxulATbUn8rSU7Pup/hrJAUrj3UXox8GV51Pb1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONnyqKhu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecec796323so4495867b3a.3;
        Mon, 29 Apr 2024 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410958; x=1715015758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVaastLuiUoz2XHZ9eDginCg+npialPTvah0q9bKA9k=;
        b=ONnyqKhuxGtEBcRe1+GCzMfTthmC7gXt10q6MDz5cGMgkPYnkSleFRhw506rM0T0UB
         ksmnb7AJNPfpkSZIFC9/4wfMhqiwAZHx93I2UtAR6FikvYqbyBtv6SajpSq5Q2WkCT+5
         1p2U8NEfT62yoajcFs+vgXt04Utfkm6nM3CoJQyo7itR5ATKl2OTWLl8MyhjJg8QJXMU
         hpbNAF4ZZ59pqIRtN5urHRYkbh8pvMBIKG+FjKdE/pMg9Wiiw8YHg/cHfr6Iw4GE9jla
         rlDhVmJaFs107zTJsXO1jtlFGxpIe4hEM2exolB67N8zB4F3hln7qBftx01S7FmqlLlB
         WjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410958; x=1715015758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVaastLuiUoz2XHZ9eDginCg+npialPTvah0q9bKA9k=;
        b=TotfGMXpfeNiO/5maNULO59AoTte+WQAOgzpQwn++JHh7v4T1F0nnGKUJPMq5Kik4i
         HzEVJmYjLb5PX5admm1uvv3Vlah1P0dqLM0BpTMr17TpIF3Sodf+GTRkVJlKPAWTEUJh
         p/mtHmm4BLp9hB7Lfus8slo2b8OiK1zp33W596r0M+LTKikAmD6NxDUI8YFnF4csOJsM
         GoQk4xubnvQEtIRd0n8iVSie0LlY1HJbYQ9/STTAd/9geiyDEY3A+/MqWNe38+EGhAcF
         4iulQyNkCIybTJ6gqiJEO3/x2MduYbAJRplybHHvkCb2Om4mKB98pzZoJlZnJeCaNeCW
         2VOA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ18aOiwzp1OTw3fUh3TNBxzvksd8e1sU8JFm8kelVR6FdBw6FkJ/IQFabwrm2/UCv0wSXMhIrO4+wAS5n3IzrDS/9tN/t6IFe745T
X-Gm-Message-State: AOJu0YwNokUJL1A7Ymcz+YZoO3JeMf3lGPPr57SKsT6TEaNj/7VHgWrw
	MIuih6USnGjDk2khiivCA+2LLbUsEh3z8jn7eZsqMsYIvjyU7aCQ
X-Google-Smtp-Source: AGHT+IGbAQIKG6CNvuNdecrgw2pq5aamlFEwnyBkM6dmNuhC/YgjId0qnj3RkgktkcGrLFI+5hWW4A==
X-Received: by 2002:a05:6a00:92a0:b0:6ea:bf1c:9dfd with SMTP id jw32-20020a056a0092a000b006eabf1c9dfdmr14531935pfb.27.1714410958017;
        Mon, 29 Apr 2024 10:15:58 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:9744:8dfe:8ee3:9c0a])
        by smtp.gmail.com with ESMTPSA id gu8-20020a056a004e4800b006f3eee787d5sm4386210pfb.18.2024.04.29.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:15:57 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: mripard@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] media:cdns-csi2tx: replace of_node_put() with __free
Date: Mon, 29 Apr 2024 22:45:43 +0530
Message-Id: <20240429171543.13032-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release when they get out of scope.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 drivers/media/platform/cadence/cdns-csi2tx.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c b/drivers/media/platform/cadence/cdns-csi2tx.c
index 3d98f91f1bee..88aed2f299fd 100644
--- a/drivers/media/platform/cadence/cdns-csi2tx.c
+++ b/drivers/media/platform/cadence/cdns-csi2tx.c
@@ -496,48 +496,43 @@ static int csi2tx_get_resources(struct csi2tx_priv *csi2tx,
 static int csi2tx_check_lanes(struct csi2tx_priv *csi2tx)
 {
 	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
-	struct device_node *ep;
 	int ret, i;
-
-	ep = of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
+	struct device_node *ep __free(device_node) =
+		of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
+
 	if (!ep)
 		return -EINVAL;
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &v4l2_ep);
 	if (ret) {
 		dev_err(csi2tx->dev, "Could not parse v4l2 endpoint\n");
-		goto out;
+		return ret;
 	}
 
 	if (v4l2_ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
 		dev_err(csi2tx->dev, "Unsupported media bus type: 0x%x\n",
 			v4l2_ep.bus_type);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	csi2tx->num_lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
 	if (csi2tx->num_lanes > csi2tx->max_lanes) {
 		dev_err(csi2tx->dev,
 			"Current configuration uses more lanes than supported\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	for (i = 0; i < csi2tx->num_lanes; i++) {
 		if (v4l2_ep.bus.mipi_csi2.data_lanes[i] < 1) {
 			dev_err(csi2tx->dev, "Invalid lane[%d] number: %u\n",
 				i, v4l2_ep.bus.mipi_csi2.data_lanes[i]);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	}
 
 	memcpy(csi2tx->lanes, v4l2_ep.bus.mipi_csi2.data_lanes,
 	       sizeof(csi2tx->lanes));
 
-out:
-	of_node_put(ep);
 	return ret;
 }
 
-- 
2.34.1


