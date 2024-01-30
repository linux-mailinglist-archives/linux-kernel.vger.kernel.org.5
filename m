Return-Path: <linux-kernel+bounces-43745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB884188C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267821F283B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2137711;
	Tue, 30 Jan 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="I8huMrMS"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C23717B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578944; cv=none; b=NroGca9N0Ogy3v/YWr/cxz4JWgP5EX/SQ+swUB/sriV/kfNejECntscf7ua5vsryH88s9hLyEOBlJNeq0fIt8w65hg4oFwABisRpa0ilAOKJxBBtLDhKum+MKzsJBoYFdv75Qffr2yINCSRylRg0sPfSg5j5NAhML8Vpc3zfJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578944; c=relaxed/simple;
	bh=7Sg36xLhS/7ztOMWSohpnTa28wJGbBuqneQH8Ps943I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3buZgHWH1QQDR5zB2+CkDRbchUJRJ7OAuGQxd0fJg2x9YH6p5PzsFve8806SK7kzEWkuG7OU4ys5qbgj+wWX3s7gwqulRhGYK6+klHQhQK816qyTqTJvqEqWoTHvIaQlnorYvDI9Tih/bmWB6VnHcdNU/d8rnRrBNBPtrSq/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=I8huMrMS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8a398cb2so31843891cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578941; x=1707183741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQR6B9VdWNRnJssZsaOhbSU079VyNfF2R3mXiYKEIjI=;
        b=I8huMrMSNNIcGB1PySBr4ptK0XSU9eyaFH0YaDNc2lYbyJtDNftnHOeJbPYIziqYTo
         bynYJkzGvYc5cPSALWKzaFCbVTMA3XBRcG2fZcz3QRey5EMM3ZcXk16xx0Ik3Y14y28B
         /lorDlSiLr1/k8qx7+C/FvgRCbpCQk3PSugi0ki5nhVhvmItywrw7hl0f2MS5Bi+UlQW
         xsZp4NthSGDNNPRQIrVVuFl5U3XEmuPwXCLgM+3KFOKbJluWqq4jAxnTycUvqynlKrVY
         /v6mbczVwJn1l5EIus7gpsBrna8a0rj8p/HxA+LDCK22uEU2AKr9vnIp9b1UJiNKiboF
         9EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578941; x=1707183741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQR6B9VdWNRnJssZsaOhbSU079VyNfF2R3mXiYKEIjI=;
        b=bgotAJY7um2KSxQlazM6lBTLO5C+xhXYVWJ29EhR7PRoPv7H5p1IXwew+gEBIi8B1e
         oWScFTqfxo73eEh2gFnKn34Xtyph1QidplYBUIy0tCEEehesO5i1YR+HSNlZzdfUIxph
         8wzCUI/BJaZOB7SG2dMM0JLA/bEpma5WLyq/slp4ROLwPZqHZJC7Bv+jHnzxPe0rL01f
         KxFjbC/0+fSmWFQNqF6Wteg+H2QzUdstZfQbzn8gQdJXIRoWx7OD1rQWOm6p6UkAvqGX
         RBxT2tJdmDGy0td3n+ginkARH0YntNDno4T/RFspMX7heiQW12nST4mqqDocVRcrzMlP
         6HsQ==
X-Gm-Message-State: AOJu0Yw7VJFYaI2P5oR12ROqljGDKovnouYrZ/oy2vXW6q088u6zlmpz
	zqInvOM7LcLsRaPvUTxdsNd+gaDtKJUWZs2ckbWUUy+Abnd9sByOA5QHayXj/zw=
X-Google-Smtp-Source: AGHT+IErWm9kcg1l0jaG/xKO+cFOv3Pm8kp13SmDYTiZeddMh6ZfVthab4Aji7BCAsCUkY1gLrj0kw==
X-Received: by 2002:a05:622a:40d:b0:42a:b079:e665 with SMTP id n13-20020a05622a040d00b0042ab079e665mr1722772qtx.12.1706578941087;
        Mon, 29 Jan 2024 17:42:21 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id bw21-20020a05622a099500b00427f8c50f31sm4145530qtb.46.2024.01.29.17.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:20 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] mm: zswap: rename __zswap_load() to zswap_decompress()
Date: Mon, 29 Jan 2024 20:36:42 -0500
Message-ID: <20240130014208.565554-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7a7e8da2b4f8..bdc9f82fe4b9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1316,7 +1316,7 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
-static void __zswap_load(struct zswap_entry *entry, struct page *page)
+static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 {
 	struct zpool *zpool = zswap_find_zpool(entry);
 	struct scatterlist input, output;
@@ -1411,7 +1411,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
-	__zswap_load(entry, &folio->page);
+	zswap_decompress(entry, &folio->page);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1702,7 +1702,7 @@ bool zswap_load(struct folio *folio)
 	spin_unlock(&tree->lock);
 
 	if (entry->length)
-		__zswap_load(entry, page);
+		zswap_decompress(entry, page);
 	else {
 		dst = kmap_local_page(page);
 		zswap_fill_page(dst, entry->value);
-- 
2.43.0


