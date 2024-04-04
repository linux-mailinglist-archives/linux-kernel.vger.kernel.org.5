Return-Path: <linux-kernel+bounces-131810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09B898C10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD181C2297A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF912BEAC;
	Thu,  4 Apr 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejz7Z1bc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E411718
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247923; cv=none; b=XCuh8bEQ2NrfRDyC0KaYWGOxsD0nIwQSghXdw5G205bTf0dqVI4LjRR5ysOS7dyKqAuC1RmsYBbTihNuieumRi1B5IbVsBgf97dYXDZkNJqMDoVGVwSh77QHSPGMvjmeCTssSEZZ/T0gUj4Ub50ctFf3e+FjTd+y/T6DiWZjj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247923; c=relaxed/simple;
	bh=x7wQnVcgMHd/FE/gLgA8O+7VtbS+2sVyMf2xLUDm+Pc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F5GJC0d6AwGQg13yFPtGKZktsJRvVEaBjZmaQGXRebLJnF3oDaTYLYa+gDVkfST5Ea4h1zpKOuPN3eknfSR9XskCBOWBV/oNruPNeEfMn2cGL5IAhY4eX2jUFQKist8J270jabWeEGzSr03s3HqvGnN1c3Foi0ONUQA4pfO0PxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ejz7Z1bc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6fb338247so1147145b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712247921; x=1712852721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JwgqNuPbWd+ghf0eHeFjaoIaXwCHA/FmnPhXROWNzvU=;
        b=Ejz7Z1bcVqbk80pnV9HPfJ+sb+ZzkKs7gqxTsTs+RGBRCCAOsmOwHKhUGojHFul5z4
         zBWPFPkTFxzS91ypZqVKEZkgKu/VDYOmBXxFi7t9ZYey3JY+ggJWWlhXjleDtKp9ZETE
         OblVqAUAPtaT+TJ5A2F136hcUWkrqebQTFsltcCX5Dp0npZ6/sibaW4pwj5dWoF10Vgp
         VyNkeqtCiZAYWffj9MQ+oa6V01Tf4T/RKHaphBCN2hOCqRD6LDz33aeJgWj9UfCgSD7x
         9A0hk9EM54nyt2Lt9n3hAWrOEoPje0esb893XMTDMxE3BNmvKVIiY/jk1xp8boBxVZi/
         XpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247921; x=1712852721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwgqNuPbWd+ghf0eHeFjaoIaXwCHA/FmnPhXROWNzvU=;
        b=P7MQsJkEc2bP9OJAvC/MTIHZbeYzLhevT923WV+5xhthYISN55uI2eNvwRJaKynePW
         WdfZjAn5L/JHGf774O9azkYeazG35hKEm87kHXo5aViwE2+Jx3+lpjyzdRdz2T28LQGV
         HuQUNPFbw+l427uWQACMh+288DflSYHoVN2rouU349e3/IEcUb0f+Ov0XrtqbnFbCb79
         /7tsdXi4XqjsZXOrTAIV0GE9fdu9BJMkFFNGS0aDjWb944DBdd4i8eQPbCLZNNyWlAT4
         /A6qptMcfYbEPQAiOh3/NkBFA1/YmTEUA5q0toft7fyD+GiVEI225EUgWJcgxxkYfluy
         VymA==
X-Gm-Message-State: AOJu0YxHqZ2smE5Gik2m+SGXjPW8lpiqvP0Pmk9jjUxwSk+OLsUlSJCC
	79nucPws5BXCOx7WDkk/FJPvCnCsbSsDHLO374b+5H60ZKzKs2rI/U+LIvkHBAT9Hizfsw==
X-Google-Smtp-Source: AGHT+IGmTy0ApIn2dhH0LzN26X146CIvoiU4QSzU9JW23Tz+Bp1C3JdAh55IZ1CT3/6jCiShvd/YXKP2
X-Received: from fvdl-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:46ab])
 (user=fvdl job=sendgmr) by 2002:a05:6a00:9a8:b0:6ea:8ece:3b3a with SMTP id
 u40-20020a056a0009a800b006ea8ece3b3amr198pfg.4.1712247921520; Thu, 04 Apr
 2024 09:25:21 -0700 (PDT)
Date: Thu,  4 Apr 2024 16:25:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404162515.527802-1-fvdl@google.com>
Subject: [PATCH 1/2] mm/cma: drop incorrect alignment check in cma_init_reserved_mem
From: Frank van der Linden <fvdl@google.com>
To: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

cma_init_reserved_mem uses IS_ALIGNED to check if the size
represented by one bit in the cma allocation bitmask is
aligned with CMA_MIN_ALIGNMENT_BYTES (pageblock size).

However, this is too strict, as this will fail if
order_per_bit > pageblock_order, which is a valid configuration.

We could check IS_ALIGNED both ways, but since both numbers are
powers of two, no check is needed at all.

Signed-off-by: Frank van der Linden <fvdl@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: David Hildenbrand <david@redhat.com>
Fixes: de9e14eebf33 ("drivers: dma-contiguous: add initialization from device tree")
---
 mm/cma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 01f5a8f71ddf..3e9724716bad 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -182,10 +182,6 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
-	/* alignment should be aligned with order_per_bit */
-	if (!IS_ALIGNED(CMA_MIN_ALIGNMENT_PAGES, 1 << order_per_bit))
-		return -EINVAL;
-
 	/* ensure minimal alignment required by mm core */
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
-- 
2.44.0.478.gd926399ef9-goog


