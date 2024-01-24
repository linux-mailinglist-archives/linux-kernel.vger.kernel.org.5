Return-Path: <linux-kernel+bounces-37242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33883AD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B592820B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CC7A71A;
	Wed, 24 Jan 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBCFQQWu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAF2BAE5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109881; cv=none; b=L9qiUdfc/e2XZDFaMm3/6OhSOY2dezXlFMxNHGgonEBC0dhjtm5rYvB4gHsq6rY0LKsRb+sJFHX1FVRWARZtZSiZ2lxnaYJRoXexxYAM4W2HCsWGmRoZcZJwNLHvSOzqhu22V9IMkIgwqEVlN63jY+hDwqUItV/fn+NOOKJO40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109881; c=relaxed/simple;
	bh=TIoLI0NOg9IhGkDnZ07u3QedeQaS0I76rjo0TfaQbW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRoYapbPgKw80Hzo6MBXFgNR3iNuZ0LB91QRfAx6FI0tLz+gXt595793Ac21c8cCSQkUJshF++RNVngrpQ06AsOQOF6u9gPGwHL01O+GFU3I2Y8QPIA+F/i2wZvjMlZBEaDFlVcIhJ1n21B0G5UXt8138kqy/aj63uDMH7zEJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBCFQQWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706109877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+IWdzfKReTN2PlVowzK8vMbbI1VNfdZNNhWBnWl7Hmk=;
	b=hBCFQQWuMf48OjUr1SSOpkR/4xOwyGp15CJ6XlNsq60j5Id7FbQasL9Q63Cws59gAVKihp
	u8gtbzKsoqbnoCGFW6ZKYqFjnmKkJCsFjrvFsYolhQ5NfCHC2WHIGiisdHhFAKYrhzetwC
	GNaXC/nenrYGnYA3T4g3UULy3nuPQbg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-KkuuzhNRMUeijUvHYh02Ug-1; Wed, 24 Jan 2024 10:24:36 -0500
X-MC-Unique: KkuuzhNRMUeijUvHYh02Ug-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7832a94b051so744388185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109875; x=1706714675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IWdzfKReTN2PlVowzK8vMbbI1VNfdZNNhWBnWl7Hmk=;
        b=Gy8aLK12841Ug1sPhEJxj9rjsH2MeemR84eJ2ttxk4YfP18YgAk1gvMHtfuy4Q1jcs
         myYMT0Zpy4Fog0qBTcXg2KgFKyj2gXJo3TvBRlFnHipysMUIH772cgNUuqEyz0A3YaHy
         GDg2G6O7k3FFKy7R0R9SNPKRVqz25hXYydff4jtxHt0PY30e7VghDliQsSZGQ8Hoz0as
         EfEHqbxcBy+heOmbtyRwxzx8IXefzlESa1EolsBjIc0MNqwuF58dIxbmVPpxucDZxMdG
         JlFyMu6JzQGJp91RmLTuq9IfCbxMZi+JvQycq9KSAROdbGpXzVIr9EcD/tx3rTNP3sF9
         c//A==
X-Gm-Message-State: AOJu0YzWG3ezDrubrI/xPlaG+Bj/+8Kmf0YuV+fdYcoDMQ/16ROZcFq9
	mrkiKOg+ZOfxXfG6wUGNs8xt5OH+a3XTSkxwthFgwjPSeBl0felOLqJDq7vCvZU+eZY4JZa/jLg
	79k9F4bG4v8QSywrfpwH9UT3VpmqKvGhG0chZj5cJuZjfj149L84QHGmGS1Sg
X-Received: by 2002:a05:620a:b09:b0:781:4d22:da3 with SMTP id t9-20020a05620a0b0900b007814d220da3mr8139814qkg.138.1706109875718;
        Wed, 24 Jan 2024 07:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2BfiDB5CsRVcuehc5tORKDkuTL/4NqMavF8HAKOEJDcAoQ4Tj24hFb/oste1KOxPQfa0OQQ==
X-Received: by 2002:a05:620a:b09:b0:781:4d22:da3 with SMTP id t9-20020a05620a0b0900b007814d220da3mr8139801qkg.138.1706109875523;
        Wed, 24 Jan 2024 07:24:35 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id pa15-20020a05620a830f00b007815b84dbb3sm4126401qkn.49.2024.01.24.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:24:35 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: remove redundant checks for bridge ops
Date: Wed, 24 Jan 2024 16:24:07 +0100
Message-ID: <20240124152408.88068-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
driver") introduced a check in fpga_bridge_register() that prevents
registering a bridge without ops, making checking on every call
redundant.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a024be2b84e2..e0a5ef318f5e 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -30,7 +30,7 @@ int fpga_bridge_enable(struct fpga_bridge *bridge)
 {
 	dev_dbg(&bridge->dev, "enable\n");
 
-	if (bridge->br_ops && bridge->br_ops->enable_set)
+	if (bridge->br_ops->enable_set)
 		return bridge->br_ops->enable_set(bridge, 1);
 
 	return 0;
@@ -48,7 +48,7 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 {
 	dev_dbg(&bridge->dev, "disable\n");
 
-	if (bridge->br_ops && bridge->br_ops->enable_set)
+	if (bridge->br_ops->enable_set)
 		return bridge->br_ops->enable_set(bridge, 0);
 
 	return 0;
@@ -401,7 +401,7 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 	 * If the low level driver provides a method for putting bridge into
 	 * a desired state upon unregister, do it.
 	 */
-	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
+	if (bridge->br_ops->fpga_bridge_remove)
 		bridge->br_ops->fpga_bridge_remove(bridge);
 
 	device_unregister(&bridge->dev);

base-commit: c849ecb2ae8413f86c84627cb0af06dffce4e215
-- 
2.43.0


