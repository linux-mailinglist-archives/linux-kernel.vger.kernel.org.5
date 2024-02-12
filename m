Return-Path: <linux-kernel+bounces-61479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584798512C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D841F240A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261A3BB2E;
	Mon, 12 Feb 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hSlTjr5e"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05A3A8E9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738937; cv=none; b=IGAAyZtjHvB8yYNPA2UhuhIduxzkIoSviudYGGZNHSRy0hMkEmcOZjTFvCv+JQ90janaG+vAryZ7xdPhvJJB2JFfm/2eX9RGiLqkwDMGpQnwBL8LfpkLnJgCIVYu6C2mvYdB9B3FpX58MIsEwL8cvjTI+REMF0yT2WKzk+yo0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738937; c=relaxed/simple;
	bh=6/y0RKR7g9worsePTPRSST8SmwmbabeGMZ/hQjJ+S8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHBrWPmEvxCX6i0k0iZ+LPQ5uD8hWbyYHsG0u/+ixZHKA8MBB6SUlz9tZqFOKBlun6mCYghn+nr9bCtcWuS71O70Mu1H6B4/qZHHjlC6zRo0hTGCcLp5uHvFnqyj4BIVnR0+WFoNfafHcVCN5awP/i/iDyfp75bu9EWmiWCr13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hSlTjr5e; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so4087146a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738933; x=1708343733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=hSlTjr5eQNT2ciwu7y62u7RL5VbiVlrmKJV0CfD+RAdh4tDZHhx5wmFDw5f4NZhSZX
         opVj+c3GPdXL/bmPRh8i5moijNHXU/exO5+EVcnHWyrnWIncgAzH0B2Bq7L+lMg6cqoQ
         Z5mGRRxeVr6vG9Erv/2lLhhZTn7dwJ4liFkH+JF1EfzKL1Tw9N//q3pNNodrhIwP05jJ
         iFRpFf3dMnbfwpTESfjiWy26PBjdh7ih0TeLyWshIwcZylewRFGdxo6GWn8tlqXQ7svv
         AL3jhtkqdg5F/QeQG+Lnofdcluk/yCyRPL3dUSpDj5Uqg7c6p3sOnjdO3XuxXbfcxDiH
         3z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738933; x=1708343733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=kzLaou7krtFAWpawHcunkdv718fhydwxx2Be8rTODROYOQNx9hTSC3+6b2LWUZ5iCx
         dA0MtIhrgMJaMLrpsUG+QPMAkfAp5OSz9M2SGS5qniFcX6dWY0aCA0CcG6/6cBQEx33Y
         AU4hDAAoLwEhvXfa65q9hBXDBSHZgIQiSb8JkzAnQuqHBAzejEH1WvdWFXXoKt2Wehyh
         VfgBH0gbMRGJyWkZo2/SlVDr3uSov7Oo97qctOzou5py3JRS0sZRysA2tneZzYPpnL9k
         DLXjli/fn4uV5RCk+P6NDzS4OBD+XYhrthQAWTVYwlfXH/qMExCUQvWnWCH0TDvwXp/o
         9wCg==
X-Gm-Message-State: AOJu0YwG4SXtWICFahfjtpYKSOhwAHub7RrffSrOe8vWhhwdNZuMr7aX
	rw4BmliEAfPfZvr2oe9CkbkrBAVTewghW2m2KwmLmzB8dtcjH6UZ5D86ojJXg2aI3Td1J0YRQ4y
	h
X-Google-Smtp-Source: AGHT+IHNmXTA+8e8LcR1FRVtZRHM92eVuEFrDR9bEQIiUKfDuLgGOjwazYNDaEB/m7pRn1fQ3+PQGg==
X-Received: by 2002:a17:906:f6d0:b0:a3c:12f1:2383 with SMTP id jo16-20020a170906f6d000b00a3c12f12383mr4883035ejb.57.1707738933069;
        Mon, 12 Feb 2024 03:55:33 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:32 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 19/35] bio.h: move bio_has_data() and bio_no_advance_iter() to blk_types.h
Date: Mon, 12 Feb 2024 12:54:44 +0100
Message-Id: <20240212115500.2078463-20-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct bio" has nothing to do with "bio.h", the naming is just
confusing.  This move will allow narrowing other dependencies later.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/bio.h       | 22 ----------------------
 include/linux/blk_types.h | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index afae5a73b7cd..b8562d4b57b2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -49,28 +49,6 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
-/*
- * Check whether this bio carries any data or not. A NULL bio is allowed.
- */
-static inline bool bio_has_data(struct bio *bio)
-{
-	if (bio &&
-	    bio->bi_iter.bi_size &&
-	    bio_op(bio) != REQ_OP_DISCARD &&
-	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
-		return true;
-
-	return false;
-}
-
-static inline bool bio_no_advance_iter(const struct bio *bio)
-{
-	return bio_op(bio) == REQ_OP_DISCARD ||
-	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
-}
-
 static inline void *bio_data(struct bio *bio)
 {
 	if (bio_has_data(bio))
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ad48c3f5ddd6..313db4b9b49e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -284,6 +284,7 @@ struct bio {
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
 #define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
 
+
 /*
  * bio flags
  */
@@ -434,6 +435,28 @@ static inline enum req_op bio_op(const struct bio *bio)
 	return bio->bi_opf & REQ_OP_MASK;
 }
 
+/*
+ * Check whether this bio carries any data or not. A NULL bio is allowed.
+ */
+static inline bool bio_has_data(struct bio *bio)
+{
+	if (bio &&
+	    bio->bi_iter.bi_size &&
+	    bio_op(bio) != REQ_OP_DISCARD &&
+	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+		return true;
+
+	return false;
+}
+
+static inline bool bio_no_advance_iter(const struct bio *bio)
+{
+	return bio_op(bio) == REQ_OP_DISCARD ||
+	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+}
+
 static inline bool blk_op_is_passthrough(blk_opf_t op)
 {
 	op &= REQ_OP_MASK;
-- 
2.39.2


