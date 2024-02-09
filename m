Return-Path: <linux-kernel+bounces-59637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF2984F9D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38701F21B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750318612E;
	Fri,  9 Feb 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aQ/XmkdQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C0823AA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496869; cv=none; b=SvSJhuZkAD+IOggXcDdk9M7smB95hF1XcHOp7+9NA+/ogGtDG8lh73OKRvnDFHTLnGkPuECrMDIJ3HyzwofQpptGunebYpLI2R8MMxJ27KAgbJOJM4fJuh8FBzRTKls2EDR/NciTVeI2BNeJ7lXqH7NGwkcIB+Cz/E3eM9Xfj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496869; c=relaxed/simple;
	bh=6/y0RKR7g9worsePTPRSST8SmwmbabeGMZ/hQjJ+S8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8qDl+Sr7VAv97t7ZYve2lvg3UZixAMOFAiSO/Nk1e8/2P6R/c1ySBQemdKjdt73nngPQKAYQP6NOmi8nlL8RhvnSm3i8Xwq0XcJNq3M/5hoOeO/8IICGjuz7twZdLgiMOfzsbKi+nmazawwRnIpzbU/TeYi3Lj9LEolDtN5sXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aQ/XmkdQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3bf9012637so89502666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496864; x=1708101664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=aQ/XmkdQ8jefAforhzGRI9ZcfeOgA7Rba8JHpvbcavul8Qk0cG01WSuU6jdVIFlPaG
         PjYg6OiQozxnEcy+pLeZu8fK8g1GgJ1XKEm1eNQyNH8Vs+RzhYzlKBTw2f3QJqQ3HVI/
         SJOOFtj6vsWrRNwEWliwAgiVxakEwcDLSiklhObW2e56Gr1W3r/sycorltVa3C2Ny6Ai
         9ytXM08IDCK0U2EFXrvdkNwPU6jcGAqj+nwaMaLxlNAf5XFDIhYgBgOsrhPfLgiYG929
         UwFxBjbOim0E3fww7IYyWCDjlVHF18n6ZwjyFnNfRSVRqZELHU/hAGkSJWandGFDfJcY
         Ib4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496864; x=1708101664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFeTZjQEhgBEZLUg6ibjUuFIwmiiAedXiRWCbx5Msz4=;
        b=NW3mV7qM5SlDs5hhqPVR7leW22EzhbTVp9on06p4h6lByqVBHUe7DRwjnwWxqcpTsH
         GSWMUu8ZAoBYnWSe9Az64+iokuQql6k0WVIMPhHTv/AWoWB5i2K0UnY0RbM5R8Bi5sWe
         hD5TXFKZmqelrdbWPhkq/mawpwFv9Pir7tjGQiuLr/nWq/wvwMFfxkmRMYJ5JJWxzjqY
         /U1Oak/9ztFSsbRwQNhQ8mqfll/M48mYoNZg0O5kg5+P4yXbQDdnc8TFlqSih2G7cJwt
         THEIXJXmgNQvArWaTiSgj37+uPj4u2aLektV+0FnOTn4RnTKqTLqt18WXXfICQ5jgPDE
         yWJA==
X-Gm-Message-State: AOJu0YyFXJpcru0Yzl5OqwmRwHRzE8VNom5xHygpkcYBgBkB0jSS4Ceb
	KKqFFInyXY0VBT5PRdsKGAITUeQupdNgplCz6uEjCn5MEOE03u9s2KzEYDQ+gjD+cNvLofbEYyE
	B
X-Google-Smtp-Source: AGHT+IEJ4RUsrqNkCaSq00JPF2wJ/BJfUZp405H1X3dpfU7jFchXpOUNSWAuPk4zaQ5K5+AhlRcqZQ==
X-Received: by 2002:a17:906:789:b0:a3c:17c:1e48 with SMTP id l9-20020a170906078900b00a3c017c1e48mr1180454ejc.31.1707496864061;
        Fri, 09 Feb 2024 08:41:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:03 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 19/35] bio.h: move bio_has_data() and bio_no_advance_iter() to blk_types.h
Date: Fri,  9 Feb 2024 17:40:11 +0100
Message-Id: <20240209164027.2582906-20-max.kellermann@ionos.com>
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


