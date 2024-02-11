Return-Path: <linux-kernel+bounces-61000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B50850C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6321C20F50
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D638DFC;
	Sun, 11 Feb 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ze4kKcAV"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC26182AF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693355; cv=none; b=aGazBu3H+7Nw/cJFrxWcNcu4A1EwwFR+sGG/do7C1Czfvgo5wfsyQI3kJB1bh5MuNY+BUehgwZECk9cijJkxWlk2UX1Ms4UCfNSc01QuyO2lgsBhroYZW7eJXhudkqD0xlk/BEMHwbgfQW70oE7AuW41rXXl/TNFwU0wwdGmsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693355; c=relaxed/simple;
	bh=6/y0RKR7g9worsePTPRSST8SmwmbabeGMZ/hQjJ+S8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuGAOCLr4QOr81GkrpJ/DECjaGRLNY4HqJ7P7XDkCYCxFzvWDkjIJydnXVs3X6phTcKCF0xSEopb/tW10pwJ0wS1QVwEhD/7UZaJ2HIp+1jTYZMpcE57T5VHSbL2x6sq+uDMLNsoafMypnlm37v7fairytAiISU+KPWg4gV225s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ze4kKcAV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0ed7cbd76so14174191fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693350; x=1708298150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=Ze4kKcAVQG0ODm9rEJ0w+g1ovkAqr8rr5s2CCDVopn6rqdc/CaXIos+OMMlle2TxFN
         LcsSIpgTlezOan0N5cN7/6sXaUNVrNQm9UWJOpkC1apjtuqFZeHFpYc/UMcuDLz+a7V9
         dT5YvyXJrTZAWK/Q0xyU1wTS7bn7rfkcoBH/70J+Gp+WFFOXk17edhx9El32OY22bvy6
         i0ORSS3quSHPdxhmdaPmaBWs9gFZhWsMJFYO3MYZeinuW6DfE3hP5mb7X0Wf3wKcJpMQ
         o7low8T6+GKNyKrrJzx9Qv+9CSpuL//miHmZTOikioshIiCOuS1/xuYGbawfprM2EFWc
         tuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693350; x=1708298150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=eYMwR0C4EWrGPBuMB62wgUZOCEDpEK04RBjvcGzpUZcy5s/Fov48/oyim3Rao+JxQm
         vsK2w7k9ivY9op/PehVOw6ApIgrY0GiWA+vUhVnQXcy8OGTJPG/yMFBMWf4Qw6VupF5/
         X5HQyMsLFa/JeV4q06wCwqcC+m31k0/xeLKJOw3Np49mfmJgOwTKSS4r/43lNP4F1pc0
         2YIYWNp3v4LIfeCUrmEgdSQ+RDtkDZD3/lmNXfTiaegoCZcZrPFsMjiLjiVoi/LJLQA1
         YpTx2YXW1+mBOyiDze2pRkvnLeYdYMYaRIySab2e/UP1K38udc6giBf3QVk/4KsZ5b3C
         l5vQ==
X-Gm-Message-State: AOJu0YzG11B9270C4132OADd+z0Yx3d8DYwVnCUryQQPyKW1RuA5+SEz
	Ry4XpYxUjipEpzHZZ24qLw+zmbcGgfkjoe1mSFjXx0uFxMZYgRLjCWXdVIjWxLLXLueiZNv7mb+
	x
X-Google-Smtp-Source: AGHT+IEuvdkwEJSMELB+16mu3t6QAhd/iZTo63WiccyyeJ7qCIa38Lswo1ipfP0DpI9VQv1b/OMcdA==
X-Received: by 2002:a2e:b751:0:b0:2d0:822a:6740 with SMTP id k17-20020a2eb751000000b002d0822a6740mr3190864ljo.46.1707693350744;
        Sun, 11 Feb 2024 15:15:50 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:50 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 19/35] bio.h: move bio_has_data() and bio_no_advance_iter() to blk_types.h
Date: Mon, 12 Feb 2024 00:15:02 +0100
Message-Id: <20240211231518.349442-20-max.kellermann@ionos.com>
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


