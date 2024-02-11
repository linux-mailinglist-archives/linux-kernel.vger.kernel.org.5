Return-Path: <linux-kernel+bounces-60999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5C850C36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1956F282136
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D722B9C9;
	Sun, 11 Feb 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="G1/AvoMi"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2318032
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693354; cv=none; b=gvoIEodvqYVQak33rzNNdwiUbg96/kRHrHF3KX72oJqVYT/0ePrqqZfOxUShTpM4x7P6AFIIJlSpHij+YsMMFOXh4gpAD4aO8tijJvz/JHals0lBkuWwR3IMfanO0yokG6aUDMo5ubjvmOOS0Ce+daXihFTCGDgqhYtF5A4sJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693354; c=relaxed/simple;
	bh=3EMwRWQVmXFpMULqT0KRcNauX3dUmEoNi+TxEAuDB/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrHfcXkuQDV9z/ieHcsDt6fe/mwumxV3fdS2V56exDgMG6EFEXm8vTuBFVsvRGaOrnKNoAxNpmDoMrUVCHVB/rXhxqIObL43Kfwgc2OcpqDEYNLbgwKeHRxSJShOG41A+amik8z6ZcLhHewhJFaEqqjmzDHqVQ4c8wxpbnH11k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=G1/AvoMi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so4017781a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693350; x=1708298150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=G1/AvoMiYFxT5kzuRBYAAg8YtecErA2NtNeY91K7BP9rFfnKvGNfFUWgPj4SQpLX01
         w09KGgZpCfVCqC3xqNfD1GZmNw0jtqSqof6IxqPLZ04ggDNtZ8k3S+KVRegt8y0rXTfc
         52D/LrPfYRnufK2SGZOoMLuMI/Bl3G2LXNYE35A1Gr5jK+ULtG27JpG0HyiCKck40XU6
         b3RP2cDkzIJpE4/R8KgB3f3HPyYj4VwftTvQPNvKQpdILRFlA02cixPTkBd+YvxpCGLO
         iFBej1wpLl0nGG3KFpSv2hl4+rs0VKJVc0hnPpv6A4Gmbd2pt6Tj3YgH3S9qSZPIuQaZ
         ETuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693350; x=1708298150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=eSwoLVumD+XhhAeEazGMG9isK9IHlRdlE/0f6VuDsIgCBQhiPbyi0o+CkMG2hl0ipc
         Z+o89DZYPuP9C1dQE5XJxbRGs9pYUZL6WldY0DvXk88aOM2+3VbVQ/ZA6u30CDJ7HsJu
         U6pEAarV/+iU+ERFx1dkd6zc1TlFElQClBO6HQRo7l0Xw+hDLMwbquXKQ2DFMu7r6Ptg
         43+EWOzTKMFXBIXPY/whL2u2g745WFqdCMLU2YOcvha2m42lj37GtQjCYP+xyQOTYo0s
         QyRLsnxMFa+B314c0kt7UGM77btz3tUUS0lhOqaq45SfXo4xzsRE+t1wAqI/BB6G4qZf
         aNIw==
X-Gm-Message-State: AOJu0YziUhTaFQpdOUvItOXaOYW3r1D4sIv/ZLYibm8VmSjFIZzq247s
	f9wx1Sto7tCgFtg7yPqD3rN3I2Ed1hth1r22eRG0f/HQxkjH4hnO01DVjrcCJBIhyDa+JHrN5x8
	C
X-Google-Smtp-Source: AGHT+IHAmifdVSLf1cSWsW/F59VovW+T1W8jcE3GUhfcZw67OZHrhyMpPaRUnPUSeMWKv8j6VCxEFg==
X-Received: by 2002:aa7:d6d7:0:b0:55f:4464:d044 with SMTP id x23-20020aa7d6d7000000b0055f4464d044mr4094729edr.6.1707693350163;
        Sun, 11 Feb 2024 15:15:50 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:48 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 18/35] blkdev.h: move blk_op_is_passthrough() to blk_types.h
Date: Mon, 12 Feb 2024 00:15:01 +0100
Message-Id: <20240211231518.349442-19-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
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


