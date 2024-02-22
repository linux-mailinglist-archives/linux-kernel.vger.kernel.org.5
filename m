Return-Path: <linux-kernel+bounces-76062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5F885F279
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09F01C214A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75D17BAC;
	Thu, 22 Feb 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KCdZEJyW"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AB290A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589329; cv=none; b=fByArtnps0UU8Gs6vwKQHSy0x34hcKn2S45FPCL+GnwYeEVaCrr6VjRBXWUAE6UB6zY0SFnOIU1ZbyB+lUmQM34q0LJhmT4Xpjwq5q4KNIIGUDBX7rhEfo2vPS6/6W3xDMkybZ19SWt2+F72xLR1qMDBhgLopXTttWGyGMl3C2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589329; c=relaxed/simple;
	bh=6uQZyNQBDfK/Q2MJsvb89cQpkDZn71u/ixkGYNhY+lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CY7gXDmDe9MwZ+wvTwV/BKuQllpERRHwgisaoEu3VUDk2c9voeGLiiPvmqjBJ/1MU8GS513UEcTbuGcW6ckOwL7sDlHztY4QATY1ufsxbfuNv/FrbkTc2Ws50fI3u8JhaWuR7q4dO7Uy8jhENi9YHogsvV/XSzP9+FlnIWA6uNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KCdZEJyW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e46cfe4696so280364a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708589326; x=1709194126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jiioa07cgkgC3rBe2WxD4CHl26Y2JVgv/alcGcefyf8=;
        b=KCdZEJyWkaFWzGjmhmiWx1DvEk3Ew7X4vvWZbX81+lfZMPmAyHRMRNU8Je2tNJ7tlw
         tYSYLDGyJoHHTHTESPxo9nmDL+n8o373TCFcBS+n4F7MvXviwDf1bVP6Qfcm8woHukMq
         7OLNszY8csQgYiaE7WBgOvlLF0Sp92BE0gRBWRGb7mVRWYyD2UZE+FD9ETUtvyyjsWS2
         Ea4SftqtRRoNlazeWENErYuLBe4zawyZvXsKzW0ZVSgCjv7TEreWp6x53zqclFJLwTMZ
         221gYOQ/8Y6AUHzLOE5TFhic30bvE0XPqeAQbO2wmDB+hmOFAserXQu46IjV9VrBahDM
         c3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589326; x=1709194126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jiioa07cgkgC3rBe2WxD4CHl26Y2JVgv/alcGcefyf8=;
        b=uWG28tMh5bi5sCuAQneUmeMa6VksXAdKSPhtvh0JfN1NTxJ4A2FQu8xubA5qJpyVHM
         PKiUq1om8E6j+eKdsFDrHT3yVGKV5Liu5wqWBX7ZSCRmv2O5FQ9tgL48qnQcvfbF3eff
         NHKv6WcQxefPAcSRbTYuZJ/s4KdF5OEPhI2eB26ossQkIvcsENxBOj+HyOQqvc+R/ITQ
         0iUqjLvcUzNxlBZ+rvmrUoGV2LsTE1xqRZQMkUx/cncaNUUiMfhBjWMNRvNp4B+nkZyu
         a3R7NuLw96Gg2oca/cqpwbpYDjqJ1ZlANK1SYgVeRAJPk+f/Cag/sz6Aa/FJ99U8sa/C
         c/rw==
X-Forwarded-Encrypted: i=1; AJvYcCWL5n5evrvKn/oWAh43N20vAt4SkPhRr/keZ5gqvuk1AtDyBx68ThIdubkgXV2giGhBp1539uKwlQ6v5ta+ow3H5XwuTpU4UCphgNfr
X-Gm-Message-State: AOJu0YwJAzKPMCo0IgMJQ2w9WFBcBRj3uOo6mj/J9Rv/CKE1dEuuFY3x
	LPWF3BRNa6vjsIfbt49KQL2itb2kO0LBiifOQAXEn4zq+pbhG/EYOH+A4HSDSmk=
X-Google-Smtp-Source: AGHT+IH+9nNrSC0y7Upc3eli/kDFSR81+YsEAYLGSXBh7rYjW/RCRQTT4fM5+3Diy/npRha8UB/oZA==
X-Received: by 2002:a05:6358:e49a:b0:178:9f1d:65e3 with SMTP id by26-20020a056358e49a00b001789f1d65e3mr19766252rwb.0.1708589326343;
        Thu, 22 Feb 2024 00:08:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id a3-20020a056a000c8300b006e4cf04e501sm659058pfv.13.2024.02.22.00.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:08:45 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	aarcange@redhat.com,
	surenb@google.com,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: userfaultfd: fix unexpected change to src_folio when UFFDIO_MOVE fails
Date: Thu, 22 Feb 2024 16:08:15 +0800
Message-Id: <20240222080815.46291-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After ptep_clear_flush(), if we find that src_folio is pinned we will fail
UFFDIO_MOVE and put src_folio back to src_pte entry, but the change to
src_folio->{mapping,index} is not restored in this process. This is not
what we expected, so fix it.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/userfaultfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4744d6a96f96..503ea77c81aa 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1008,9 +1008,6 @@ static int move_present_pte(struct mm_struct *mm,
 		goto out;
 	}
 
-	folio_move_anon_rmap(src_folio, dst_vma);
-	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
-
 	orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
 	/* Folio got pinned from under us. Put it back and fail the move. */
 	if (folio_maybe_dma_pinned(src_folio)) {
@@ -1019,6 +1016,9 @@ static int move_present_pte(struct mm_struct *mm,
 		goto out;
 	}
 
+	folio_move_anon_rmap(src_folio, dst_vma);
+	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+
 	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
 	/* Follow mremap() behavior and treat the entry dirty after the move */
 	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
-- 
2.30.2


