Return-Path: <linux-kernel+bounces-59636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3784F9D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E741C24651
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39886126;
	Fri,  9 Feb 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NyduFacq"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE67BAF1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496868; cv=none; b=rvWMkX0n/5O+mpq4ePPLbCe8avwEo04Npy1PS4GbPy8/sjpzmwt+aXuQTIo6T70Ixfwu9Vk6kzf0TpzXwNDu9WCst0pKatHx83M17LYAHNlcsE6SWZRKMa6E8SjsRcjYfzhr+RP8wgJt17gTyuGlxh3Xjm2elIjyWFy7TxjMb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496868; c=relaxed/simple;
	bh=3EMwRWQVmXFpMULqT0KRcNauX3dUmEoNi+TxEAuDB/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtjKHBqzju6rnx1MI9mUzZLE5EG6moO+BnU7ciQxz7Xcy+bsiyi7b6/EqHUK7SMik4i09mTBG9w/XCxcxTavhEn6R3Co8V4PuPwtB6l5w3CUFlLnUc0e83tsFW/ytk0hhkLNH1MGr+L42IEpL47LJdNmUdtar5niWDBxOPzeDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NyduFacq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3be744df3fso107077966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496863; x=1708101663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=NyduFacq0vaZ3tpqLroB1nI2SKZnhb05PwtacMqddIU9Sqk8F3+cieZwbkDnTx88On
         W66o6RWKhbRAJsAbRbxYzvhm46D6Vga6+Pw9+POXEto5J1hL1ZG0wIrQt9SqFI4KTWbU
         TlB54qyS8LXpUW7x4Ee3EgqwjPlZI17TSZZz+wrV8ena3rZTMovchB/q4RhU7pw0FYdZ
         P0d6J5STppY1DW5kc16vlEek5AhIYSOzn0kuq/GGxtjUAaGdU1FteCTaxgRCkWw2fuCZ
         jmi7q6M+Zy1yE1NpceN/4i0Ms2OvSdQGImeIcSR+7yT/p/8CpfcbIOHoF0H92LbQcncy
         D7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496863; x=1708101663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=rv5Qx84Odba3RiJy/8J3RNxZVcS5HJdkIOMqc+VpcmvEcf1YMw2HV4aEESQw1PHn4M
         gEHsLwF8JLn7pDrRvGQQOXu6IPYDIGC26QloY/PHwzhdgoL6OCUTtjkmaatnoyA9amus
         zPL83zrOKT2IJ4tWpinihkvcFAvTwKCSHkIcSieYwhiqCGsYtpD+8XHOLxhykQEvovDc
         yITU6npOiPzWAr3V9AwoiQE+Rj8kIeJ0EhIhnJrmz3IFU+L8YVQEbsg3bhQwktRUSP9t
         gZo1YhPEPZEkaD4E8JXXWG+NvydItFxR5YZHxMvLLoge1eRqkvihiqM9hUmstpFvdWXr
         FWqA==
X-Gm-Message-State: AOJu0YzrvoGs792TmTtpq0SYAqpBjxF9y5na58OijtO64SgrbTIFGoPM
	UWdMGqcbZscs3Zpwm5/dnP3JNZEOUY49GhCFZFXGHFMRy4A99Bv70L0yammDSOXQS4CrxMFbwYw
	Q
X-Google-Smtp-Source: AGHT+IGRE7iKEsB0hRMZJew3xU4qi9Bd38rT3eRcBwrHNratzwYbZSYSyhNQ51ZHf5UW8kb7BoVSuw==
X-Received: by 2002:a17:906:169a:b0:a3c:1638:b069 with SMTP id s26-20020a170906169a00b00a3c1638b069mr137148ejd.75.1707496863287;
        Fri, 09 Feb 2024 08:41:03 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:01 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 18/35] blkdev.h: move blk_op_is_passthrough() to blk_types.h
Date: Fri,  9 Feb 2024 17:40:10 +0100
Message-Id: <20240209164027.2582906-19-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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


