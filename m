Return-Path: <linux-kernel+bounces-48460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C90845C61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C471F2D523
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED94626AD;
	Thu,  1 Feb 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgxXoyMV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1D5F47B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803044; cv=none; b=FdHPlaS3aupcPgVUWCGtZ3AFVGwLd2o4k6/sVsemtbjjBOUmw5BwLiVTicvQxPenQyhKIsrUyFZqAbHRpFSnI8SaD15y5NfGR5+agJl2cyzwinMWc3LEoC9o1gq7k+uUIkiF65nVYIP5YSPFubu6o6UJJKOgfhnrJ4ReqYtH4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803044; c=relaxed/simple;
	bh=Ct9xSYNdsoUYPlLCIr1Z8RBdDVFWjZUVGlWdpOnjEPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyrnGfCSweb3nMMiGpWR5TML/OUV3EknU5tRtUxQIlpKvfJerVOj+VP4xJeBjtDJQ9j0VN5Q6jA3a+s34WnxWTcaLkZFQe7SbTESEaLEeP4TNg67Ipczw+uEzG31wtBlwmQmDnEpa/MSeksHkdbg/dYxDbBAnu0Xi0w7laBQExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgxXoyMV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706803042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=maGHN87wG8MBtliTQkYWRfmgkGSGFEAxdtgNEgO8IZs=;
	b=UgxXoyMVr+kpoYiJ2/c9Udil7WsOFk8Ze395n8VS05Ipll/pkCArJGlsZS5Zokthtpz4Uh
	DBR8RuSXKrnTrOauQW8dQO4W9NdZtiCwuootn2yCUEsinNB/mWhdY8iBu6MBpUVkr1T31O
	lkEuPfB2V+pkdx0q/WKV/w5AHcKUWH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-6BuI5t01MJykcrcq8J1Acg-1; Thu, 01 Feb 2024 10:57:20 -0500
X-MC-Unique: 6BuI5t01MJykcrcq8J1Acg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ef75bea84so6229465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803039; x=1707407839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maGHN87wG8MBtliTQkYWRfmgkGSGFEAxdtgNEgO8IZs=;
        b=dRiK0429+uUyNrr5NowzEtGwvIGCCOQdvAPud1L5HoWYjYbMzj8QckXqXq2t802d28
         r8r1d99B0Fmevkc3bHogiCtg1R3yE2z2RSn1gYDE/3iT1LAwVNtIfZu4faK9EtmNKsbD
         5Y2GdwdOglRNvQoRUXdU+h8Oq8jMSBuo91vTEELXvlCcQK0XtMf8jO+AaEDHtMJnYcKB
         PDo53FQ2BN2MVUbqhZp27bXG7nE6mQuPzmgdc9IfR3YhTMAqNJSlzsVqSpNFRTxiBzFK
         iC3hgnjnmgImJGLo1DmleU8wp7WPy0p4e1pC8i4J8PjQK8rCTJ2DFDJzmQ44yvOG7PgC
         LJbg==
X-Gm-Message-State: AOJu0Yy2uO6GJX4PNN/g8eLA0hTL+cOKxdPNSsvhPAfKwG//Yv5d/U0J
	+ENudgA4ux2CBVHFseuaN7jbZPT1aTMQuEJV3HC8fpE1ynWjJ9UTmKHe3CUwQ9XTB3H/5G/G4YU
	QLA0hI+PIUDSz6gw37NbmIvCGv0li9ZYomZEjU8xdwmSo4CkCvhcpKnbIRUpp
X-Received: by 2002:a05:600c:314b:b0:40f:993e:35ae with SMTP id h11-20020a05600c314b00b0040f993e35aemr4442924wmo.14.1706803039759;
        Thu, 01 Feb 2024 07:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0W0gGAxhS7AvbYOR9IEMsbmKNAe1JnmjE9uWIlOec2Coqj66ic87Sx6Ko0Th2X1uXOusXgg==
X-Received: by 2002:a05:600c:314b:b0:40f:993e:35ae with SMTP id h11-20020a05600c314b00b0040f993e35aemr4442906wmo.14.1706803039457;
        Thu, 01 Feb 2024 07:57:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVL2cyWQ+Jf0SpCRWNSmfCwuUPXNMVjyTUc7J9FC2UlhRkR+a2gh3QC4k94e6OappUvffd+ushGyqs8r0EsvRO/mmZ9tPh5KB+vCQhj/wqPvw0lVp06H6006DvZPfLw+NEyZGaxH0K97AMtex95t5Q9YaW2gsC/5MKO2OZks9jKEOWGKPFk+pQVhZgcqWg5KZL3M6pjrJzxisPuO7rdpo=
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b0040e54f15d3dsm4849557wmn.31.2024.02.01.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:57:19 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: remove redundant checks for bridge ops
Date: Thu,  1 Feb 2024 16:57:12 +0100
Message-ID: <20240201155713.82898-1-marpagan@redhat.com>
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

v2:
- removed ops check also in state_show()

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a024be2b84e2..79c473b3c7c3 100644
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
@@ -296,7 +296,7 @@ static ssize_t state_show(struct device *dev,
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
 	int state = 1;
 
-	if (bridge->br_ops && bridge->br_ops->enable_show) {
+	if (bridge->br_ops->enable_show) {
 		state = bridge->br_ops->enable_show(bridge);
 		if (state < 0)
 			return state;
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


