Return-Path: <linux-kernel+bounces-141221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD78A1B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2F21F280D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D982049FF;
	Thu, 11 Apr 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MIzfvxo+"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042B2049E6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850229; cv=none; b=WSEf6LSBu8rvlICZXtrBUWE6lwfAu2T+H/nxXlI8Gnhxvg7KoFVnA8oWeJONYXpkZGhprkiCjJyldChubT8zUA/wSrTmwevYTXgdd3Wzm6gEiGkM/7DULiFYtSM17xrSSDTIdCyESfVPNjqlO4Ut87L7YB29Uw8O583Xm2Afz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850229; c=relaxed/simple;
	bh=sv+Gy7cP78hJU/E9MRKEv2Jk7PK6pCxYpgtnsPuhQ9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqMAiqB/QR/2mNPwBaVvVYlhMBFCKEOsqcODPzePzdkIHGEJF3QoUJNCOp2XeZAdCZzovNjIdleYokczhqiY5vV+NvuoSXFakQwdKn52NZJC8ESaasQBVQG8qK6WW32p/NOMvJy1HlPRYbr9N6hfVaZgTCmpSA+lKTwZ6KyrsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MIzfvxo+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58297839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850227; x=1713455027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=824kdpvNQEIg3JNyqLD6HhMGF1p3p7yQd55ATdhdNV4=;
        b=MIzfvxo+y6fUVIbKE7P0VtLAg5TOqui2CVzW6n9d1UAJ4p4tm5Jjuo8cbSwYEgenhk
         AjFvHJ7oEMXzLAGGdnysMyUfqGW12wWdUmTvc4+bXWe/X4O98JZu5fNncCaEXkY3Yk8q
         2l/wYYwI49aC38kRUcEXt8tQBxgrnGkTZ9SBdXqq5Hqh2r6u+CR8nV7PZ+PJuCin3ciJ
         2L6HHPfY0exDGMC/poQzws4PhJ4rj094oMZwdMatzKoOQSNivgSsakRRb6Ejv2+2tM3h
         /0IGGVHxSQI0sDGD15gyzW6vV91ycZHhhFcvnuNNZzgQlPSSteI680NxJes00wikgsVY
         EFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850227; x=1713455027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=824kdpvNQEIg3JNyqLD6HhMGF1p3p7yQd55ATdhdNV4=;
        b=q6NqIjOO5mHHnC2/DhjJI7JXum7m4LC/DOPAD8Oat1cR/BkW+mmtyO5U2uMJZ10n8S
         vpVrNLOFxH942oh2wulb4f9sK32xlZ0PGbtnNZO5pnruCbldEm/7olrr3W7+Sqr1EGiv
         ItAZKbpDV1dAG1Mr3Lo3viWY4vfd+u1k6DFYDwff58NmZKsQNj3CeV91peK9UZkg724K
         tlwcl6Ds5K5BX6r/rIWQQ7NTs5ojczzt8JnRWtJOyvqTH1v0cQn2acULShO6npocR1zm
         SpBWOasiaBILsNIfX48F3DZ9le+r6OYGqlxAwA2dC/a5GCmsuXA3Nflrb3ueO5M2OebG
         gmtw==
X-Gm-Message-State: AOJu0Yw5QTU8579wbHpBiZ+T0bVycYYchzyNEULt+Uwn6eBFJiVKpQd6
	7bxvecdpFp5XNnA1ctFALIKqvCLXNV7gdRUK4ihJPeQjtYK97IU+R5ihUTuatDuuR7djjCGVqpR
	x
X-Google-Smtp-Source: AGHT+IHqzU7puz4UtLND2YpZCz3Xtb1Qczy4JVmbVtWC3C7R8Kk6z1Gvy7cc2GXD6NSAbTLiGAwKfA==
X-Received: by 2002:a92:60b:0:b0:369:f53b:6c2 with SMTP id x11-20020a92060b000000b00369f53b06c2mr5354910ilg.1.1712850227027;
        Thu, 11 Apr 2024 08:43:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 434/437] lib/string_helpers: kill parse_int_array_user()
Date: Thu, 11 Apr 2024 09:19:34 -0600
Message-ID: <20240411153126.16201-435-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer used, get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/string_helpers.h |  1 -
 lib/string_helpers.c           | 61 ++++++++++------------------------
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index f38157114fc0..5e913f1fad60 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -32,7 +32,6 @@ enum string_size_units {
 int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 		    char *buf, int len);
 
-int parse_int_array_user(const char __user *from, size_t count, int **array);
 int parse_int_array_iter(struct iov_iter *from, int **array);
 
 #define UNESCAPE_SPACE		BIT(0)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index ced4f77dc5e8..8582f9adfa76 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -138,10 +138,27 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 }
 EXPORT_SYMBOL(string_get_size);
 
-static int __parse_int_array(char *buf, int **array)
+/**
+ * parse_int_array_iter - Split string into a sequence of integers
+ * @from:	The iov_iter buffer to read from
+ * @array:	Returned pointer to sequence of integers
+ *
+ * On success @array is allocated and initialized with a sequence of
+ * integers extracted from the @from plus an additional element that
+ * begins the sequence and specifies the integers count.
+ *
+ * Caller takes responsibility for freeing @array when it is no longer
+ * needed.
+ */
+int parse_int_array_iter(struct iov_iter *from, int **array)
 {
 	int *ints, nints;
 	int ret = 0;
+	char *buf;
+
+	buf = iterdup_nul(from, iov_iter_count(from));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	get_options(buf, 0, &nints);
 	if (!nints) {
@@ -161,49 +178,7 @@ static int __parse_int_array(char *buf, int **array)
 free_buf:
 	kfree(buf);
 	return ret;
-}
-
-/**
- * parse_int_array_user - Split string into a sequence of integers
- * @from:	The user space buffer to read from
- * @count:	The maximum number of bytes to read
- * @array:	Returned pointer to sequence of integers
- *
- * On success @array is allocated and initialized with a sequence of
- * integers extracted from the @from plus an additional element that
- * begins the sequence and specifies the integers count.
- *
- * Caller takes responsibility for freeing @array when it is no longer
- * needed.
- */
-int parse_int_array_user(const char __user *from, size_t count, int **array)
-{
-	char *buf;
-
-	buf = memdup_user_nul(from, count);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	return __parse_int_array(buf, array);
-}
-EXPORT_SYMBOL(parse_int_array_user);
-
-/**
- * parse_int_array_iter - Split string into a sequence of integers
- * @from:	The iov_iter buffer to read from
- * @array:	Returned pointer to sequence of integers
- *
- * See @parse_int_array_user, this is just the iov_iter variant.
- */
-int parse_int_array_iter(struct iov_iter *from, int **array)
-{
-	char *buf;
-
-	buf = iterdup_nul(from, iov_iter_count(from));
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
 
-	return __parse_int_array(buf, array);
 }
 EXPORT_SYMBOL(parse_int_array_iter);
 
-- 
2.43.0


