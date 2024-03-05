Return-Path: <linux-kernel+bounces-91936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9C8718C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC591C218F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AA535AB;
	Tue,  5 Mar 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="H/j5i58F"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B54F613
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629182; cv=none; b=awmDvqw/rBu/11MMeR0gKYVWZIUsxc5ZKur1QlID2i4pJCm1AoYu/t/NAetQyBmRzEjOHsH3H3VuC6gvpYP1Hrd7MMdYnyvcdHscD1GageVE5SaPIZ+caX3ToX5XocJJGHIyRM/wqlHGFToZog6HyNFmpEcHT3q5FXA0H9nBw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629182; c=relaxed/simple;
	bh=WbgrH40EXEUiQSR1Yyn9b7sUNNxFQNIbVUvs4s+s9y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAclSrPPonRIvDf8jU4LOjbZxPh+HusNWuvIkr8HapKCIODvWLFyj7S2hnDZwcAbjHmnnbs4dyFlgQhwYpjX1l40ktwodp6WCJyxGrDgnmWc3GOo6VgKWo6R8+R1T9i9RGnMQb8Tz+fyoQ0ivrepz4zLWOBgy9VwIc/c/gRIedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=H/j5i58F; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a450615d1c4so399291866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629178; x=1710233978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wE2HsEwQuIKqCaqriShH9hKkj+cYk+gvkRx/+6+3to=;
        b=H/j5i58F5d6+JwQmTL4vK1SY2m/f3ZgbJYujReQEdA3kNiIjxk4mEVrjAnoQm+X0jJ
         9vymzw9OWABGj67ZT5FG+EftuhmO3IJX4hiLTcst04lYA71+NZ02DxmInPYohs2LGaud
         ZakuF+ByQPPaT6dSoSQc8XfWhRDpihotG89IW1yC5ZwwV2ARmym9AO6GTBeA8zwlY+wH
         9Mjjy9QJm9QwL0BdZBSz2ngA46hDOakw4J3vKpi8NFAMPmLQDI57F7mBWcMMQ8TtmJnH
         0/6crAJbOQ4LZPNkAcTX2yIIUrfQb6ko+789ZVVJ5dR9dX7cztdAOw3gHplu2ImC2wf0
         0VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629178; x=1710233978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wE2HsEwQuIKqCaqriShH9hKkj+cYk+gvkRx/+6+3to=;
        b=AeNip4Gc2bRPRI01SLZQL1PDiNvG9lzGJ2Oqsc9ZYgcCwXK4TJ5gkDQeD9x+8yFnVf
         hIuc/9M5jcG5V/MZFuasNwl+HnkfKJxefG37uBwAP/DFbE3X+ocbbpfEtGbb8vRCYGMq
         J8Le0xo32oCR2CgdGnU9g8OHa9WFixvt7jzfIT9Pd8uWl6xFzm/IqNRcuuz1sHxwCJ3l
         2Va72SgNxt23DIUvYR/1Z72qcQ7BLumhnKB+RaaYePMxPbEUFuXUhF6QrVm4uFeXq3bY
         K56rs55qTzqsDXNlLDWd+AB4n4H4hRh2nm2SIxZlhcT6VMzO/lbvE6nxZbMTW3zz6FM0
         RLRw==
X-Forwarded-Encrypted: i=1; AJvYcCWqgZp+qxwaud2eye/jFzaOXb2IOmhmo18cBJWh1oiMiCd59s3S35ppfVjDDKogmEE3jAGCWBDlmPjltpmPr3jqxrP+kCTZHMP/HvJ6
X-Gm-Message-State: AOJu0YyLglfMowhtSSvgbXvL+xEcQjTW19uLSjlzpVbN44yPBvuaxh1W
	RvlrsClK5KBTrb6yQQIhF992sfjzG8dk1vUNl3hgIeBGdwfMrH9+YQZYBrsvjQer/aqJYsOzRBL
	3
X-Google-Smtp-Source: AGHT+IGclT8SPmvhKpvWUoSnvxxkyS58f2fpOwNpOo6zfJOP/D8VtwzwkRcJh8gYClLS0+CBEo/eNw==
X-Received: by 2002:a17:906:6806:b0:a43:67fe:d484 with SMTP id k6-20020a170906680600b00a4367fed484mr2236562ejr.22.1709629178518;
        Tue, 05 Mar 2024 00:59:38 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 04/14] linux/mm.h: move section functions to mm/page_section.h
Date: Tue,  5 Mar 2024 09:59:09 +0100
Message-Id: <20240305085919.1601395-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305085919.1601395-1-max.kellermann@ionos.com>
References: <20240305085919.1601395-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to reduce dependencies on linux/mm.h.

page_to_section() is used by __page_to_pfn() (but
asm-generic/memory_model.h does not include linux/mm.h).  Thus, in
order to be able to use anything that calls page_to_pfn(), linux/mm.h
needs to be included.

This would prevent us from moving page_address() to a separate header,
because it calls lowmem_page_address() which in turn calls
page_to_virt() and then page_to_pfn().  To prepare for this move, we
move page_to_section() out of linux/mm.h into a separate lean header.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 18 +-----------------
 include/linux/mm/page_section.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/mm/page_section.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e140ee45f49c..79c1f924d4b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1637,10 +1638,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define SECTION_IN_PAGE_FLAGS
-#endif
-
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
@@ -1838,19 +1835,6 @@ static inline pg_data_t *folio_pgdat(const struct folio *folio)
 	return page_pgdat(&folio->page);
 }
 
-#ifdef SECTION_IN_PAGE_FLAGS
-static inline void set_page_section(struct page *page, unsigned long section)
-{
-	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
-	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
-}
-
-static inline unsigned long page_to_section(const struct page *page)
-{
-	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
-}
-#endif
-
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/page_section.h b/include/linux/mm/page_section.h
new file mode 100644
index 000000000000..e4558c2691b8
--- /dev/null
+++ b/include/linux/mm/page_section.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_SECTION_H
+#define _LINUX_MM_PAGE_SECTION_H
+
+#include <linux/mm_types.h> // for struct page
+#include <linux/mmzone.h> // for SECTIONS_*
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define SECTION_IN_PAGE_FLAGS
+
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+}
+
+static inline unsigned long page_to_section(const struct page *page)
+{
+	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
+}
+#endif
+
+#endif /* _LINUX_MM_PAGE_SECTION_H */
-- 
2.39.2


