Return-Path: <linux-kernel+bounces-30645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F0A832271
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17455B21097
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855725772;
	Fri, 19 Jan 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P488q9wP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1F20B0A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622565; cv=none; b=UxgFcmQsLAP7FV5KM6j0IFB2GJxbogeEW/hrJ9c5eonHe20Bijmm86BC8Wv3XfIwn6QrNj4kMGG4GshKGtDaC4EmdHzgtWGD6tXCTQ5pTATd0FhWzzCMv8iUu7mCHhwQb1W4yH88632YqyTkkPYG1+9a4P5xmeuGlGbjdsL7ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622565; c=relaxed/simple;
	bh=MtMdqj96rsjPzsEnYRg4Ac1eL3hsM5JZU42UDnZssdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/dKI5GeLl+96rvgzrygMbksHDKsa46Py4mgMSeg8b3MXeBxzEAIl1aBZ7ar4mdph5CxPZIHNGK0ZtFSm4qGBEpjtN8yrWhZeNT3jACbctE87XfNpW7qzqXcMH1Wwz13nmuW0sdY2bsKfq9AUxoOQEzFfJycqQWwmtK3tg/Iwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P488q9wP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db79e11596so231411b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705622564; x=1706227364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuVI82N8U3mum68Zeo3r0N8ktAUFrixqZFP4tV0YfIY=;
        b=P488q9wPbr0u6Zc1yBNVnH8w5Q5zPrE41/slNbV/yI7G6XUMzrGRN9bFAgRmp9Mun/
         e3kG4skg1G5JhY2jLcc4zlwTU1uHr1cJ6HQK8+A0svOE2tu9QjJy678wePanu29dwGV9
         9SP/iBwPaQKnRamC1Jbv+w6H/cvn6Pa02BBuYVIsDezCZdwF0bl3qs1WFAvLbnFoFWl2
         eP6FU2HGp87vWPrkPgHMeT+BCPFJzQGJwk6IhZrVnbITP65xfxpGpJ+lTAILkSMFJhJ1
         K1FpaGljvfYaBgdgMre6loCqBMk7vV55hVjnBTinweRE5WyTMZTwcO16THuJ7iy+Jv7U
         57VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622564; x=1706227364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuVI82N8U3mum68Zeo3r0N8ktAUFrixqZFP4tV0YfIY=;
        b=t6LdD8YeG8KsDf21KsMg9Qcq95Q1oNRhlzOr0ihxrQLZ1I6hvA2rYT9v8zd8CQDZzK
         xZrEYBcv8HNzw1UNIjvBTUxldu7UNmqNkzk5Gn9AectUvjJ3bwhORlTChpfSdwbELsRD
         naCAlracfmni3bX32da5sgoR6E3DrZbF9sIT8ASYSt7f77CpaF1lEZBWU8m2vRjN2iVa
         6M0ba8j2ymWBF5myk9gOGevbKxUDF+kktpxJv3VgawdxCvIZaQigxYYXHyp/hjiiYbLR
         C1Xd8zexdsBtJKa2Z5tAM9na8SQLWaXr8Llk+zsbyHSySgbKKQnmbO0LZ0C8puFdayFf
         6hcQ==
X-Gm-Message-State: AOJu0YyrtjqUWDcYW2jYEgFRKKxNHEnvJNWDInPCi8B4H8qbCGPyX8LX
	alGU+DA2fZmkyP9PJOPvkK6QNvkAIHyuvPZQaZHPwvMtO5STDXC/
X-Google-Smtp-Source: AGHT+IHTvP+5p5EJsvMOtO65Mw12dgFv7upmWt2R8NYaoV/i2TvLaRecMBvx+b/SXq/ew2L4vvYuQg==
X-Received: by 2002:a05:6a20:6709:b0:19a:9973:2b22 with SMTP id q9-20020a056a20670900b0019a99732b22mr166093pzh.40.1705622562335;
        Thu, 18 Jan 2024 16:02:42 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id a20-20020a62bd14000000b006da8f6650a2sm3833051pff.155.2024.01.18.16.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:02:41 -0800 (PST)
From: Yang Shi <shy828301@gmail.com>
To: jirislaby@kernel.org,
	surenb@google.com,
	riel@surriel.com,
	willy@infradead.org,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: huge_memory: don't force huge page alignment on 32 bit
Date: Thu, 18 Jan 2024 10:05:05 -0800
Message-Id: <20240118180505.2914778-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240118133504.2910955-1-shy828301@gmail.com>
References: <20240118133504.2910955-1-shy828301@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Shi <yang@os.amperecomputing.com>

The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries") caused two issues [1] [2] reported on 32 bit system or compat
userspace.

It doesn't make too much sense to force huge page alignment on 32 bit
system due to the constrained virtual address space.

[1] https://lore.kernel.org/linux-mm/d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org/
[2] https://lore.kernel.org/linux-mm/CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com/

Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Reported-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Suren Baghdasaryan <surenb@google.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b459..66adecdc509b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -37,6 +37,7 @@
 #include <linux/page_owner.h>
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
+#include <linux/compat.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -811,6 +812,9 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	loff_t off_align = round_up(off, size);
 	unsigned long len_pad, ret;
 
+	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
+		return 0;
+
 	if (off_end <= off_align || (off_end - off_align) < size)
 		return 0;
 
-- 
2.41.0


