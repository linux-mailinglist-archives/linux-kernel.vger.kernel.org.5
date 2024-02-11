Return-Path: <linux-kernel+bounces-60746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC89850918
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C60B23C88
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5125EE68;
	Sun, 11 Feb 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XnxvytnW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CB5D484
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654638; cv=none; b=uLWwwB7NyF8SPYDYXroddZp93QWUgwcKPp/ZUqhYXbcmjwPfsrI5H+x7JfS3mGz1AtXU2ZO8PUb61joOPS74WvP1AwWyPUZOh3Yc8mDnjLBtEL6aX7hx+PU6lS92lCrfuvoZ7xkZqCC8I4T26oX/yO13uLbtiK306XnvAXoTK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654638; c=relaxed/simple;
	bh=3EMwRWQVmXFpMULqT0KRcNauX3dUmEoNi+TxEAuDB/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCCT1IQAnuGA2UbljvRJadV6Dp/hkX+UCV0C3hWr0roATfc8TwfgM4J8JNUZTPCuOpBlDb0xQHJ0F7LMLmvlj0GbAo/gFaTX9rPY9s26ykD7/H7OPwvHFiWs7KIjiD7iAODRuzkXTndpbax8LTFqOEtFslNPQaKg7YI49JGvhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XnxvytnW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so3136923a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654633; x=1708259433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=XnxvytnWgIFs32whoqYPxb/vSr2RI53+iTjvbGFICxVzhSD83Cg8vsxKgND35EVQ9n
         nnPxxZ19oEoCmxHs7uXHiXsvpDh35KDGBeaAXx2oZmVLql+h3jAtfiEkzzaKeQvtlhUk
         DmSLOHvUbtqiQ/pojXL4Myj8RKhGfTtss3IxvmxZbsk8x8qkmtPhxpJCUCCisQeGW0vJ
         0kRqhyqFvj7sdKjLBSLDcU7oODGM957fE3B5PriKFpDDkwayFDdUzzDFFGvf228teCXP
         l68xtvTVZQxN8ILfCbz/nrnB4kd39wnVgV/wXtuRaHijaQiMYnHD6Bb12LEUhZKsLUy4
         iWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654633; x=1708259433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=p3/8NdgY0JFeyPYpPgUsOZQ9JTG2msVOZ1jLwqP+DuhkXCL6YekQGw9lefBPlhtsf+
         2BuqgEI+Be/CPzzC2E5U38XINO8N72gbpf12Y2h9W35qEISQUM+CYZxPIpkGXyHwgcHS
         2LeoLIM9AAzXYPYM/rD3Xweb8b5saDqhjPtiVQ49pz30PNIuM+UUlg4s+hzT7ERqCxek
         W/Euts+cIUBo4xpEo2dVRFUsquFSZRnRAdxk7e1tyQhPc/lpMsrdUGIY2J6Q41uMwaOB
         W+h/uzyRUqIjtEs2M4M2YEkTxR3GXUKqLEyZH9VGQjeIp+IMd7SPpD3b5radykeun4lP
         QW0w==
X-Gm-Message-State: AOJu0YxpmOhCtIcmcEEx5O+disPl6gSSc94JnUGwPt+QDvY40kXgljoG
	FV6ah+8zh484RC52yGzsmTo2VWcqi50lLsj1G4fsEX8yTTwYkS5olrPhEZZbjRtFkvvIoOx3BVx
	m
X-Google-Smtp-Source: AGHT+IE+1BSLLoWrAdzREqRHqWpfqielI9nRi3l8sfbvJhLdh9ThFWE2YyqJxgVF8ZAd3WkEw2FX6g==
X-Received: by 2002:a05:6402:3c9:b0:560:c70f:9a09 with SMTP id t9-20020a05640203c900b00560c70f9a09mr2604915edw.5.1707654633033;
        Sun, 11 Feb 2024 04:30:33 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:30 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 18/35] blkdev.h: move blk_op_is_passthrough() to blk_types.h
Date: Sun, 11 Feb 2024 13:29:43 +0100
Message-Id: <20240211123000.3359365-19-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a very low-level function without any additional dependencies,
and moving it will allow certain sources to omit the "blkdev.h"
dependency.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/blk_types.h | 6 ++++++
 include/linux/blkdev.h    | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 96a37f399928..ad48c3f5ddd6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -434,6 +434,12 @@ static inline enum req_op bio_op(const struct bio *bio)
 	return bio->bi_opf & REQ_OP_MASK;
 }
 
+static inline bool blk_op_is_passthrough(blk_opf_t op)
+{
+	op &= REQ_OP_MASK;
+	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
+}
+
 static inline bool op_is_write(blk_opf_t op)
 {
 	return !!(op & (__force blk_opf_t)1);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e67298984913..6bfa4b92bb32 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -260,12 +260,6 @@ static inline int blk_validate_block_size(unsigned long bsize)
 	return 0;
 }
 
-static inline bool blk_op_is_passthrough(blk_opf_t op)
-{
-	op &= REQ_OP_MASK;
-	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
-}
-
 /*
  * BLK_BOUNCE_NONE:	never bounce (default)
  * BLK_BOUNCE_HIGH:	bounce all highmem pages
-- 
2.39.2


