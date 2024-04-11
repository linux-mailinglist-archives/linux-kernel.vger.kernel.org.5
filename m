Return-Path: <linux-kernel+bounces-140766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F3B8A18D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C781C21B85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C33D39B;
	Thu, 11 Apr 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pcrC4wDK"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BE38DF7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849506; cv=none; b=tZEe7kDNmG3H4aCv+D5YmBDVVU48nLjWWAvYQ0sVA0cxuDRcbrcUxRvyqTVUKwRqKjEHDw5U9giEz+MVe5p11/KKSpQMwSVxc5q+If2L4SCG/U7FYAGxTgs+5x+w4VhknQDnxyCThwTmAL5SAboxINE4K9qQsdkRStOmB5/kpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849506; c=relaxed/simple;
	bh=U22C9D/LInc7C2oeWdLmF/wXFNRG/xDLkpPjGRcoAec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHMDmYf3B/XrpFTGxsr0WXKLqLj599eDqjBFjQdXgDNHCvSumVJG139uoqVztSBPAWI/wgt+wbbqmuLafN7aonMakcZH1tCFfCqzfjmbWJP2Cp5Q5sN8Njx8ZLr6GisDQ6DeY8VRS1+L19PbBlZaO2GhXp429prbGMJVSoGlkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pcrC4wDK; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8841739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849504; x=1713454304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE+vEDqkpaPZEXq5NJ/4gSUFtsdV5kd2xHyDuYSLUuY=;
        b=pcrC4wDKn5fT39q1+k71o8+1wxXnPqic50WJTzuoG1ALz+BVlWY/q5tIIhmTwSLu6Q
         /V4XFVRSoajgQiOe8lqjYNzRCDMXfbkjxjSfyB+vtBfwx3lmXzKdl+AxNuMHmH2AJ2bH
         aOn/jVd23IZ9L1iBz7w+KZ4n/yk+TdYctidCCWucVK3KTXkBJ3ooizmNdPCdToWJ8R1O
         6ZQwuUYxBCndfRnBvAoI9d+XqFRmPxufTd8Db+VslUtRyoJFEovhKcLsUYoNb2TxVmFh
         Qvkl3xy9OuqSQzAKf/K2ojiqK8PDbDSk2HgZ4khSEuSgi4bkMPKivBxaI7HMxlXTDoQZ
         15hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849504; x=1713454304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE+vEDqkpaPZEXq5NJ/4gSUFtsdV5kd2xHyDuYSLUuY=;
        b=GsyRIth0PG+BS3OWuppxz3yTV9eW+ohH6vzwhRCi0Mck1S+78a2zJGB37OXWCBYscK
         WLpjMNZoSeM0CPlt91vbpTqdeE+u/Zjzdpk8oyeRQfezw7RL4urzqgO9LA21QzEtMhs/
         QZRINQrj45zq1KP5GBzZR8EcdGUtmu3LdmR8VD628JbZxZwShQgZI2/MzQd+P5T/G4VD
         UqmyjKwcbLe1c8jSC3O0J9oXlK4R4UfvxDpRS9YoZ8as1qXFzAp4ccOO14adnwepJHo3
         49krFNTMytMmF6/uCkqxZRiNGn1ezx2r6VRvXTY7gFKsA4GV/LPj8XWgndoZAvtKl2TD
         Ntiw==
X-Gm-Message-State: AOJu0YxW8lqbu2R462UrEMany2kaM3OIwC1ci8CQj25UKKvWa+Xu701I
	hGJdPIHP+KOb56U3Zd2FlVkpzowmAJaCrxBOFWlQa7jHMkYl1wPFmbFAHLzgCP1fQDlec960K3i
	z
X-Google-Smtp-Source: AGHT+IF+9ZzyNb1WG/5Th9vkX/4w9kckmlgMyAQDznwI6RY2aBU5XzpQINIUy0oJU+iZFBQhGBYblQ==
X-Received: by 2002:a92:d352:0:b0:36a:1275:4aeb with SMTP id a18-20020a92d352000000b0036a12754aebmr5871283ilh.1.1712849504197;
        Thu, 11 Apr 2024 08:31:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 009/437] lib/string_helpers: split __parse_int_array() into a helper
Date: Thu, 11 Apr 2024 09:12:29 -0600
Message-ID: <20240411153126.16201-10-axboe@kernel.dk>
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

No functional changes, just in preparation for providing an iter based
version.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/string_helpers.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 69ba49b853c7..77f942809556 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -138,29 +138,11 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 }
 EXPORT_SYMBOL(string_get_size);
 
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
+static int __parse_int_array(char *buf, int **array)
 {
 	int *ints, nints;
-	char *buf;
 	int ret = 0;
 
-	buf = memdup_user_nul(from, count);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
 	get_options(buf, 0, &nints);
 	if (!nints) {
 		ret = -ENOENT;
@@ -180,6 +162,30 @@ int parse_int_array_user(const char __user *from, size_t count, int **array)
 	kfree(buf);
 	return ret;
 }
+
+/**
+ * parse_int_array_user - Split string into a sequence of integers
+ * @from:	The user space buffer to read from
+ * @count:	The maximum number of bytes to read
+ * @array:	Returned pointer to sequence of integers
+ *
+ * On success @array is allocated and initialized with a sequence of
+ * integers extracted from the @from plus an additional element that
+ * begins the sequence and specifies the integers count.
+ *
+ * Caller takes responsibility for freeing @array when it is no longer
+ * needed.
+ */
+int parse_int_array_user(const char __user *from, size_t count, int **array)
+{
+	char *buf;
+
+	buf = memdup_user_nul(from, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	return __parse_int_array(buf, array);
+}
 EXPORT_SYMBOL(parse_int_array_user);
 
 static bool unescape_space(char **src, char **dst)
-- 
2.43.0


