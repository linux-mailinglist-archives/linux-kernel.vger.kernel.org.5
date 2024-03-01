Return-Path: <linux-kernel+bounces-89219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8186ECB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D674D283430
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20095EE7A;
	Fri,  1 Mar 2024 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RncOxs9e"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1254273
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334566; cv=none; b=L3RMFdcTWVAZ6sCmz2ml1+Y+0/gYtCrbTgt52HmhTt1CThuG5IeyZ9HB58MMACaOpwwE8iBl6BZJxi/a4xsPR8SJCv1inf9/+HqZMT40grQF7znhLdQbJ3VnMgkrKy3L8MRAA2q/PrN0spdG5gqnoYEcqUybXZ51zcCxR8YBLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334566; c=relaxed/simple;
	bh=UEhiR0jtRmVH9tnub8DcCdKOCm+M1Xk2IcoEwXI0hN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8ndyCCX9F+XhXPm36bjImD0ESSTe6/Ykn0s+zBJNl3ULc/s9WUXKHOqNwtoS0wZvD6wugHurMLTRTanexzV1XSuw/eydmV7RIGBFSmZWvYTGRYz53Xx3keqfjenHVCnycxKzhUUmxpJL8ScxUo54KEzbTF9XB5dsHsB1vVdBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RncOxs9e; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2137840a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709334564; x=1709939364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOZA8JIxILGqvM6CHZHHbg/5cKwIFudQyVhIk0Vrhx8=;
        b=RncOxs9e29yBeOOKMweBuyWnCe1byN5gX91pSCGItDYd3vWTAK92WFgWEy+M/sWv7i
         DkL6xKhWqv9uQlFVz8K8MD9L1nbgPiieVkfu/prsQ/1HU2Wfr2RE71OeUR16pHX97msQ
         bZ98ESzgyxP8j9W/5gPy1vhUTrroFVnrkEtu7b0Nn5AiWMw0bU9ID1TcCZwF3BJEeOww
         KQzpIPs887rdRwcnlUq+/ESekzW14f/8ShKkl2hnoXDiR/3Nxg0nXQ7VgokJ7CDOnZ7n
         3+VcAzDRiqOdPVCIXKLSo3mZshoti0AqWDfrhy44lX9qYtg3Iw13KxMqqus5pFLLJEQz
         5OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709334564; x=1709939364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOZA8JIxILGqvM6CHZHHbg/5cKwIFudQyVhIk0Vrhx8=;
        b=GYvSKo4jonNAY3O829TDtBze3yVqXlII0yQgd2qFGFwF7+R/8iyaLSPlGdkObn7rqj
         wLjMNMQCQdWyYk/XwTvxOE+jfq67u+S6unAY64KxTSBl+VL+kOqF4D4tP8sZcl+W1mDa
         WTBOp2PDZiQ5eQjnkfR2S8XvNZQmpfD4zdWOISQUMs6dlfACXtzBpy2uHP4p3D4Va893
         6pyjue41iJffH9QkooW1SfSqvkx2PafisjEPenYtIzACMUiq/TUvO2G48LscBM9hKB4+
         pDOz8KPb8kOmVwWBFlgjJaulBOKsrSB+pkiP3aCUWhIWOxAakB1YWr9M9xQAOrAiDNN2
         s2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXJrpmUs4c1C1SW8KtJoP+sByw7fuowxCMBOZmwy9MIVA2OrCaeZK6eq6M5kYrW8IKJC6a1G1z5UKwaRuq7AXswZAd0u10ZkGyhySKF
X-Gm-Message-State: AOJu0YygzZzslUTTwr7gDCaypOqaYCAZ8yUG7Y5UhhF5w3KY5xie59gd
	ifu3PHdng59sD4RsYiQP8yZHtpDO5WgFLAm0miKq387kZvZbP/AJ
X-Google-Smtp-Source: AGHT+IFHkeyNWpybeq4a22FDxFp6UqZiwsIeqK9MG7n2w8VMSaVh1OkCVzjissadAlByTDJzMhSjTA==
X-Received: by 2002:a05:6a20:7aaf:b0:1a1:2ff0:4e2f with SMTP id u47-20020a056a207aaf00b001a12ff04e2fmr2553411pzh.60.1709334563529;
        Fri, 01 Mar 2024 15:09:23 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:c1d2:28d4:fa3c:e071])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b006e4362d0d8csm3487509pfn.36.2024.03.01.15.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 15:09:23 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] iov_iter: call kmap on each page even for lowmem if CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is enabled
Date: Sat,  2 Mar 2024 12:09:08 +1300
Message-Id: <20240301230908.7507-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

copy_page_from_iter_atomic() has the assumption lowmem will only
need one kmap to get start page_address() for all pages. This is
wrong if the debug option CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is
enabled. This patch fixes it in the same way with skbuff.h by
always applying kmap one by one even for lowmem,

 static inline bool skb_frag_must_loop(struct page *p)
 {
 #if defined(CONFIG_HIGHMEM)
 	if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) || PageHighMem(p))
  		return true;
 #endif
 	return false;
 }

Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
Closes: https://lore.kernel.org/all/ZeGtrvm9WGv5cxQV@gondor.apana.org.au/
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v1:
 Herbert found and pointed out this problem when he reviewed my patch
 in crypto/scompress.c;
 99.9% of the credit for this patch goes to Herbert.

 lib/iov_iter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..2e8a5b32f152 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -490,7 +490,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		char *p;
 
 		n = bytes - copied;
-		if (PageHighMem(page)) {
+		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) || PageHighMem(page)) {
 			page += offset / PAGE_SIZE;
 			offset %= PAGE_SIZE;
 			n = min_t(size_t, n, PAGE_SIZE - offset);
@@ -501,7 +501,8 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;
-	} while (PageHighMem(page) && copied != bytes && n > 0);
+	} while ((IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) || PageHighMem(page))
+		 && copied != bytes && n > 0);
 
 	return copied;
 }
-- 
2.34.1


