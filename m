Return-Path: <linux-kernel+bounces-30526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB9831FED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAA31C20FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2C2E630;
	Thu, 18 Jan 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3zBoLq8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427D29438
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607608; cv=none; b=Vns88hCMz4jhEzaOa3QNFN4p+v1fe4i3UBtTNt8eVlDEg/Bh9NOBZkM/JmcyPBmrCFQPmK3s0v85+3/aaT3SZYGG8ijqYSSrTR+fOHSocC8dMophodbP1vy53SMWNkmqP32COv5q0NYaA9Hj0pbuCW445SqqM2WU6yGVryrraKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607608; c=relaxed/simple;
	bh=ePXeyzFZc4C49wzR3oENG78fjC6VcRFcvWg3hVa5eyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gG78iZ655//ntHHP9Q4J3dHPdrSha3aBfraJqLyXCM8Gxa33Y5ffpS5S3ROqcVyqNKkbK8ZMK45seI6KLjboTFtzw3dgjP41B+etJqvzLrW24EwpSX6Sq1v2quWWx/KurnkKsh93eTzTx0/1b2cdV+Cv+7V3q6ZCZvQnx/Fnpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3zBoLq8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2901ac9ba23so60697a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607605; x=1706212405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZGu56SQkPq5onYvWGLXuBppyU+oGKlhQFwb+ijLfmY=;
        b=E3zBoLq85OWnbe3fb7J1MONR3TC6NDVHj4dASxvdmX8EKjEnGUDvnURqDedsUzqWQR
         M9h5OmtuuWiWW5CAL9+95U13AcM3UxX1EjKirntM4mBCBP0aR1hAgM2vGljMiubCbe5r
         bs0P2D59JBURWadp4fmkb1fsI8oK9DOgKXWpkA7B970imuj05VNsNrzjHxmcwl2UqgFT
         di1jx5hEQkC4H4PcYkob0LVHFZnnJsCNcnM2PeW75XP1K9pYcECY9e3K5FOKydqozNfa
         SI2D6H5+sVUUpxcwAfOWWX6GNHsEJrAvbKHFkAcbUpuNPmSILbKmH7VsjWDRI3/EztTl
         SRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607605; x=1706212405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZGu56SQkPq5onYvWGLXuBppyU+oGKlhQFwb+ijLfmY=;
        b=mn7pOp252CM02tNGn7Wb4I5dg+n2a41qs18YKe9cejS2a4US6YIcdCol1QbuHasgqY
         Nka+Rzkdl/HjVLTidhWslZE4vr7mGBnAD9zfwgYGnbboQ/KhgfmpKzSMvz9GT/Icus4V
         YN5+urH3uBJmVmRnPzaWkCrp6ZHSf0sxYqt5Jd0dPcPMAITPVVGq1CsqYfgxEjpmC8Up
         9WNNN13CXjqDWTwoMHxgdHCX5HJSNpWPzpIVfGcrCKoEMFyH65dziWj7UvcXPpR1WIiR
         yAwEh7LdkHOCqtQVNXJJeptQTqQNhan9j5RX+y76TPfMgznvyW+qJQpTLzILh6krqQJD
         BeWg==
X-Gm-Message-State: AOJu0Yx/PoE4gnnUvhxA6GaZ7a7tCDUgEiX/GOoMNgnKySz2s3FzpW2/
	lQdSZnXPN4cnRm/PJJZxYoYuGRyUWcBzRH3P/4m1n/6nubCYYtA7
X-Google-Smtp-Source: AGHT+IGupQ8PU7Fa42u1C/IqqWB8MyHGZKGwJuxOH+hIX+ZSLySKufDFO7aZHyUgiK3OvCOu6aLdhw==
X-Received: by 2002:a17:90b:1043:b0:28f:f82f:1881 with SMTP id gq3-20020a17090b104300b0028ff82f1881mr1085121pjb.54.1705607604959;
        Thu, 18 Jan 2024 11:53:24 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id nc15-20020a17090b37cf00b0028feef1f7adsm2251388pjb.50.2024.01.18.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:53:24 -0800 (PST)
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
Date: Thu, 18 Jan 2024 05:35:04 -0800
Message-Id: <20240118133504.2910955-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
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

[1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab95
[2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb1d

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
 mm/huge_memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b459..e9fbaccbe0c0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -37,6 +37,7 @@
 #include <linux/page_owner.h>
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
+#include <linux/compat.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	loff_t off_align = round_up(off, size);
 	unsigned long len_pad, ret;
 
+	/*
+	 * It doesn't make too much sense to froce huge page alignment on
+	 * 32 bit system or compat userspace due to the contrained virtual
+	 * address space and address entropy.
+	 */
+	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
+		return 0;
+
 	if (off_end <= off_align || (off_end - off_align) < size)
 		return 0;
 
-- 
2.41.0


