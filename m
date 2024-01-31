Return-Path: <linux-kernel+bounces-46649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90927844247
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3FF2928A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6912FF63;
	Wed, 31 Jan 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QoR8q9om"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434C84A40
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712636; cv=none; b=gEkAWHa2DETMxtgwxOeQBIuZ06YY7uVGIrzrTCEcd8b7AUCCFQErgMiQG5Haav5gA18Rspcsib4RFeGarA/PLGmZxqBdcQCykMoGXkWG5VD6VUXPVfDNoiDmYMSbomY/mwfJFMUO9QAlStNSEeT34KcPlR7KKchEZdKI++6MJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712636; c=relaxed/simple;
	bh=nKk/y25uTEBLSW/GB/hBFVugbtV2eXB0vBG1lhYY0WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luY83VnJeCaLQjrUV6SSpWVEvCxu2QL8oFx4PcAytiHioi0XtYP6p5FDbP45WDwJ+LCTfBT9l2nOID61MlzoGSK5dsr+ZFB0Or+7RiMfvNb3OAaUuLvum4egfpRY5P2aZkUzhRDKihzFuKRfJRRBUWOyksvnJpujql/nRKITw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QoR8q9om; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so28231165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712630; x=1707317430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mbaZiKy2gj/Ag7nIoIhu2w4coHbnrCERj0vQ/xP9W4=;
        b=QoR8q9omoVLlekYAK4rm3BefQv3Fl7OjepnlUYl+MDdlZnDcyOo7LDz0MAkztBCqXc
         eSeX2DKP3BVKprp9pKLMTAg3oV5tjp2Y4axVy+zFhTuy3vCeZg4srQ4ekC5DFTtFUTjj
         HJswlgsTCTmNAcDp+crufZsVI4UiJx2teijR5e0L7P6ISlR9IoXkNf0rUNH11TOMXh71
         TWUUhZ3fnwKlS1gblI5eEpnK/0mM23APzj3dkTl3MkaCXWbuHP7X0v4dZgXfihTxO784
         1FIRlvWmgrIoxfeGVl0DJEPN/ADJSZi0xTvhEIJ05LLWQTx6slLq8kAMkQR1Zud6ZlQU
         63Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712630; x=1707317430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mbaZiKy2gj/Ag7nIoIhu2w4coHbnrCERj0vQ/xP9W4=;
        b=qtL5mOJwrGmMI3V0Cm5husQduBddqWZseVlkPwk4lJ2xQiJ4l81IXUE3It2BlM7zlx
         SpTlBbyw8E20B4KLTJ6k2jdSXW4Z1ZkWLt891d1Pl9y2cp8RIxqsybVXE6GQUCfbeELf
         +RrrFj+ydMZ9siL0Sfvk7tcSUcYtWWaFjVtGdLqLpDz+hlLxHLn/VNa1Rf5wFgr0e0vd
         SZmvvm3vlyER5BXbfNvUNVAkFPhOrVH90Dr2UbJqhZAFwAssSbTiHJLKXGfiiBJvL5D7
         BobOerDyPjo79XEM9HZv2W/OTf+h9zZhQnu3UfauwpSkN4e7hpvADufZhHGi6XPNfWAx
         uY7A==
X-Gm-Message-State: AOJu0YyEVMAc18NQPC81cgwpJYitFwy3AGEOnVRme1K6Ci3I1YVAkXEj
	eCaRn+vVrza7PI5b3yY2ukb6ShB+w4p7kU47xsHlRxs01utaX8wYXqNmQbEw1MVx+q9OGwN30l3
	o
X-Google-Smtp-Source: AGHT+IFWiH+fokSiZefCR4ZUlTwt8+JB5rKd1sDBfj5iFxCcjqPprY3c1PtHJyYLXCSLedQxdx8i3A==
X-Received: by 2002:a05:600c:1c9c:b0:40e:88be:ec58 with SMTP id k28-20020a05600c1c9c00b0040e88beec58mr1376079wms.31.1706712630796;
        Wed, 31 Jan 2024 06:50:30 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:30 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 18/28] blkdev.h: move blk_op_is_passthrough() to blk_types.h
Date: Wed, 31 Jan 2024 15:49:58 +0100
Message-Id: <20240131145008.1345531-19-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
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
index d2c0934a7224..a5e41a54de18 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -259,12 +259,6 @@ static inline int blk_validate_block_size(unsigned long bsize)
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


