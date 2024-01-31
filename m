Return-Path: <linux-kernel+bounces-46650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04284425D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC588B2DE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3412FF69;
	Wed, 31 Jan 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MxkNGR+V"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CA12CD9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712637; cv=none; b=GS1O99NEPLf/oqmsdC7NEdRtU0NeOZR62klct3NqWFawLfOxZdiTV/wJuMqAshdK1PVF64sUJ93dJjqzVH6i0v9XytldVb470edD2aTXKvHFcdhyWfOcE2qvnsd81rP6HbFLcceMcRVJxR+5DZebHUSMtjCPCHl/qMri2+uAuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712637; c=relaxed/simple;
	bh=6/y0RKR7g9worsePTPRSST8SmwmbabeGMZ/hQjJ+S8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFIrBsFDrMHkQTRmu+ny0/eK2VdHyjQz7BeQQt0TwiYswY26CS6jkDUvbiy0sbHCDfWwjyDcc6ZGyW5h/ApOv/UCzwilvqoVp687PVzJwiwps03ldBWEjc+0S1FrlZYQzuu1L6BaG/t4zRDSyjjs5GC7qjtNlm+7YylLMOOv/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MxkNGR+V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33af40493f4so1832224f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712631; x=1707317431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=MxkNGR+Vm1kv6dDSLCe4WZKJwdD2arigdg5i2j+xFYEks1P5J5lUh76sycBJZL3eDw
         XJE4ziF3v+l3ubq0NiBBnYyNjgJN3MMn63tiLV35Djx+H4rBKYiLH0RdbYEDECQ2sEV6
         uh7pewJsPc7jYrmMBVuordcwscT3fa5lpgpsH1GuTaUR/WZMWskXdPpsERZ0AToPNxjY
         udmpB+bY1SUwhMFsHPCy0ccrUMRBr+umNur0UNBOrNKclm78qo5RxDRSlJCTjT5GYKKu
         Aw4huEX5igUQV5sZnGq9Cu0V8N1nSYR5ZR5TpE67lttQwO+xoRB0xoTIfUXnBE1feU5A
         iygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712631; x=1707317431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=AMi6IPpRMWxkEWfaBToUTrBySiRwmRNr/u6sH4T75fiO/zHfTUJJ+1vbqJjU4ldzKW
         7P6N9/vzyHp4GCTPkHg9NZXqmNtwx+O6+7J6FekRP6RlPDtxTfcmaqzfaJZZB+QasRCo
         RlHDnTD2ODP3f0JcYTy3cekqvt3B4kGvN1zhzxjgE6R/RsvdaKhceYHzJlpfesLK3KnW
         gQJjrTTvokMOA038ZYG3KWASf2h8tjOSoIiI286QQhgAZilglLe5HC9N/RhinJzbfPOQ
         cd1PZ/ZwKbhcQ6KomHIpPlo5m+EJvgrJwpfdTMxNqraZvDwu9sRITYEi68u4o+rnp6zL
         T7gg==
X-Gm-Message-State: AOJu0YzYsJ6wn1U0UXcfpJLuoE51RAWFXNfXpQRx+IJ37wMB64dTvbl6
	gF609IaI/CxK4RVqq8T2u5x7OnAZvX1mcg/a02zGurU8VPeonYbg6kvIHQloSfJ98SqiIJ48Tbs
	d
X-Google-Smtp-Source: AGHT+IGBctW3tPOEpgsuoY0CYKWa2BYWQraJM5YhYoziwHq9TRegn1fDIx68G8RRU69L+yJeWP6qFw==
X-Received: by 2002:a5d:4ac4:0:b0:337:7086:b6f3 with SMTP id y4-20020a5d4ac4000000b003377086b6f3mr1346308wrs.21.1706712631671;
        Wed, 31 Jan 2024 06:50:31 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:31 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 19/28] bio.h: move bio_has_data() and bio_no_advance_iter() to blk_types.h
Date: Wed, 31 Jan 2024 15:49:59 +0100
Message-Id: <20240131145008.1345531-20-max.kellermann@ionos.com>
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


