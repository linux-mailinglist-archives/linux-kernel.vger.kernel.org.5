Return-Path: <linux-kernel+bounces-60747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F4850919
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF72B23CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ADA5EE81;
	Sun, 11 Feb 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fH8H1nJ3"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FF5D72A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654638; cv=none; b=EQKFtDREf3Qzlnar44Dx+IpbPEca9RmPg/XmUD41VLdS0i3sirTGSKrZOjLdLpXfctvtDmlZ4FvBtuojLHrO7O1T/WNDgHUIgRgn9jU1e+wSbaTE7ziz2k6zY34751kleTRdM6E5PPsnZJulWFPevbCvUShIUJq4SY/zaCxhny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654638; c=relaxed/simple;
	bh=6/y0RKR7g9worsePTPRSST8SmwmbabeGMZ/hQjJ+S8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VR/EOc09/22wAhHKj4mSZFqUM3ft+tTRMjQ800yo9iT5IiKyNbUunzsnE1JVlqns6phfCvYZHZBzXqdoltPfk+L5y1Q+fxChfwU4rtnXXbUJg3wJdnBCHNmLyTjp7pZLHbd2UKrMohxlc2wU0dt89Qk/vFaNFPtRoT+OHB4CU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fH8H1nJ3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3114387a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654633; x=1708259433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=fH8H1nJ3Trj2cOILSqgxZ8aDJjj6YfaWvPKoKG4M0FlGkxTebs6gX4/i6kB9CcinoI
         uC2esMSCwERXLrKifvFLB1Ei4xXboe3SmGUUn808QzlEejsjobz010Olo1XqJ4LHQaWo
         DAFk751m85Ggi4XycDPLtxcQeLJ6W9Jrw6E//WsAXCViRnuFduQKt9ySthydG8j1RMMA
         rDTzJsF3oIX18T9vgH48WzO8dd3zWRFpQ4wvyvzyPQguPbtLjAhmFMXBAy7vwM9RmF7f
         LWiAU1CINg+SjDCidUdWFKkqs8qSAAK943kUcrKTFBzccfTOTRk2r3LDNSwAycLHrdZG
         I5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654633; x=1708259433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=r12pT6/12HflFMUeIBlnx+f6RuSQxHYRs8OO6fW/NFRXrZI6XDrnXdimNID7cDzulx
         eydf3zWHizbbw+jkDk8ukC35OcTL7nTGmPUDmIEv22IUFoCaPjnXz/Bpbyy3PWLKW64r
         39k2eOxPhw7Df5PdBWfACQ4c1i0x06y3tNlnvJLX8PCgyMf7vXKf7aaz+/xBX3wPmJlc
         1kw9GcmWY9vn7+8wzMPgTyHGU95jJ96lpLRknTvsZ7kHnymbD7FQ1RsFlcTHduRCQ7NV
         0Y25ahf7s2vnGh7BXsewZmCVTv/cj5VhdsXwBGWhCVnUyr1wXrmWROvHh6nEePItxXr2
         Mk7A==
X-Gm-Message-State: AOJu0YwZ+ekIvbVqQEbg0sXwXmQQLoR4QaMeeyp0urPttVFMVK/zv0PO
	sTIoqvD/EX2TfORqkp+8w1CnKFz9GmgFocHpfLs+5s1HHEzIabIPyxIYyLxVvyxayUWnnp7CtFS
	N
X-Google-Smtp-Source: AGHT+IE1Rkg9YsjYCZgcEbN0n74NVLRjKsU7CuPPjH4L0jC4LHii+pfeyIfDaJ5g5qvyO6lGB1m7Sg==
X-Received: by 2002:aa7:c71a:0:b0:560:4e6:c442 with SMTP id i26-20020aa7c71a000000b0056004e6c442mr2683680edq.1.1707654633627;
        Sun, 11 Feb 2024 04:30:33 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:33 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 19/35] bio.h: move bio_has_data() and bio_no_advance_iter() to blk_types.h
Date: Sun, 11 Feb 2024 13:29:44 +0100
Message-Id: <20240211123000.3359365-20-max.kellermann@ionos.com>
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


