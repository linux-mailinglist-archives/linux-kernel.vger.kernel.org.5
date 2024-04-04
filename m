Return-Path: <linux-kernel+bounces-131811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC777898C12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D712A1C22A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2477812C554;
	Thu,  4 Apr 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EM4QM3FG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08F12AAD4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247929; cv=none; b=aACYnN3rJRWSn36DVcyAqr+CXwTaqjmBBcFJgFy2TPNR/AHqDhmUUjO+6iw2iIzT9FercR51QgGdeuFRxFLO6/jZL5grzgfHDiyVSueukRHeh8G79FHSd5LIlUV2Sqcs6XJ6T+2uBDPUz4WjlknLS6RUvOcNZDlt/AYFpalfUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247929; c=relaxed/simple;
	bh=0aIL9maycDHUTdtm4Lrkh8jedQpB7zPT7Vt6Qm5JBQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuhB1KvoS3XUrSej0r9AuY8Yfa2vOCaeDIrLMulZr5ASZ8RouN4MJVPyGgvRfFQsEKKPNbXJtRiUileDtWjLIwE+3uohOag98tUMlUUQy/EOO7rHINpYXjVJ0OvpWdSW2ipnaq3Xx4C6ykHpspZ/R2yMX0K4XOg3JY0QfpH1kqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EM4QM3FG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a214b01eeaso850881a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712247927; x=1712852727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHGbNzitA9ppM5Ku65CkqnyMFJ83UqBlfpZsb+skPp4=;
        b=EM4QM3FGCQiNx6s43MyeChaNpqdVqSL6KuviQXSLa3TKWp6JdA2YZmB399UOlJrZmV
         uC9Lsd4q9PZDsLx1XC3Sv9GOaF9t0QChH32T+RjHqUMlzdt1JMl+Ixsy/pHORi4NT4oE
         +1q83vAxnBIUybqDcwtVg0BvQgYpwh/5iqIL8PlOIGH1NSc6M+T4COssOStUab/LKRcD
         eQdGjDvYyGPUiX+1hIIa3wMlYaJKkBXcrmfOH9oHdOl5Sd+nnRDyHunNqjE17b+b+BN4
         TpEhMCDb7w9Ph/O50VlWgc/ehE3F/Xc8KcyPodqH1HXqcbojAmfCV91/m2O8o5U6N5v6
         mfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247927; x=1712852727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHGbNzitA9ppM5Ku65CkqnyMFJ83UqBlfpZsb+skPp4=;
        b=qfNzqTq0QpF54cVdIXh6hHWwidLg8OaI/KdRBg+4eTSjnFEzkSYgE93nC38LU5xGSp
         M1AzBlrg72Mayxjwht43Y5e0AZxcER0r+MFcc/a50146t6rGgpz1dsKGg07fQA45U4YC
         mJjvuyjhszq3UXTbN6vRxN4VPJa6Y6cuXI63SIxdtBrrkUJUUxgTxt0nPS4FQmM/xS8C
         APY638VjXvl4njptgDIIBF4lobTXDH4HLaBjXADZfSJS638KWnWcXut1DwLQgkCcCVcO
         OoUJl9cCjFAlAhCvjMPIyMOpchUW93qVho4DQ14eFgsk4WF1i+ZdkG2fJmaTJAXiqcVM
         8o5g==
X-Gm-Message-State: AOJu0YwhMCH9G95tffOCLttKeeEkPxDUACfL1/xhti4mLPOXbuSWlc4w
	JbmP3qGqFrPdZXv+8yfUfQmq0gowPCr2iOtKSeWsLKlsmeyDyrDvYMd4k2UyHLIOTefiGg==
X-Google-Smtp-Source: AGHT+IGXnTdJEgMY2tAcjsPsMJtWw5f7/a3l2Iy2vxpUruJLqcHR32OpW+y0OGvqY2PVU1UyXbfKojhA
X-Received: from fvdl-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:46ab])
 (user=fvdl job=sendgmr) by 2002:a17:90a:6d64:b0:2a2:1014:58be with SMTP id
 z91-20020a17090a6d6400b002a2101458bemr363pjj.7.1712247927255; Thu, 04 Apr
 2024 09:25:27 -0700 (PDT)
Date: Thu,  4 Apr 2024 16:25:15 +0000
In-Reply-To: <20240404162515.527802-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404162515.527802-2-fvdl@google.com>
Subject: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid
From: Frank van der Linden <fvdl@google.com>
To: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

The hugetlb_cma code passes 0 in the order_per_bit argument to
cma_declare_contiguous_nid (the alignment, computed using the
page order, is correctly passed in).

This causes a bit in the cma allocation bitmap to always represent
a 4k page, making the bitmaps potentially very large, and slower.

So, correctly pass in the order instead.

Signed-off-by: Frank van der Linden <fvdl@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
---
 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 23ef240ba48a..6dc62d8b2a3a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7873,9 +7873,9 @@ void __init hugetlb_cma_reserve(int order)
 		 * huge page demotion.
 		 */
 		res = cma_declare_contiguous_nid(0, size, 0,
-						PAGE_SIZE << HUGETLB_PAGE_ORDER,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
+					PAGE_SIZE << HUGETLB_PAGE_ORDER,
+					HUGETLB_PAGE_ORDER, false, name,
+					&hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
 				res, nid);
-- 
2.44.0.478.gd926399ef9-goog


