Return-Path: <linux-kernel+bounces-142610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63968A2DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A3B1C21640
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D155C08;
	Fri, 12 Apr 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4U1NLp8"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68E3FE55
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922572; cv=none; b=ca8P0UTIHbPvLVVj24jIYyUJoMscKPGV4tpZc08o7yr9yo/p420R3M1/L2QWmVOzsHlVE1CvTUrRnbyiDXm5rDGr/8xtT0PnIAtyP1KSxIBhyrhTUftMGsReIpjsmhmLxrUBe4bYYQ8iaEcZ7BPazAOIxp76dWOXvEUlTNuxC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922572; c=relaxed/simple;
	bh=ttBpAQxgjjw4lzD2Bvn2GcELVPDXaZwZiKdPqI4o07g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2IInc0Hp/hW6zGdfDg/RrW6eL6Qn2CORz0tFai2RRYV3hFC5y6PCsj0xzOVEaY864rlKz7WBqolAQrIdUADNCGA86R4jLu1RAjdV3aWoEhRJoCoLQdJMNC/ciVQULXJafPXCQaWXGTumHtKFdOCNgs0Wv+D4JCTx3dH1XI/FXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4U1NLp8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa25e99414so554437eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712922570; x=1713527370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh6hvogc8WrNbjngKn7rl7SAnmLGjB7yuHqyvbwFdGE=;
        b=X4U1NLp8LUNjVtL0MckGrHi3kJSnIACcGO1vvohfYvbEW8TS2XVrZlr3amggTlPh8W
         5G5J82IpD+vKw48/9jk4agYdocaXW1EoUZbh27dMBojW+V1ExRGgiMm2/2vBesmjkWlN
         XxzZ88+n2OWykamW42eX3TWF41j6tim6j3FIX2aj5C9iHkDaZOjVBkyFA3G/NSt+FKvp
         q8RdTRXChkGNUFW9dzGLDGWpZ4XgyRYSFHj57v56urIxGp1Ui1gs8MdCrbHxJ+UNwZHC
         J+pmX4pYv/lW2/k1/LWe7oIjmcPMJ7UdY9XUNEsDBwJZMLyLDphj45Ex/LDAE1EpRewX
         24YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922570; x=1713527370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh6hvogc8WrNbjngKn7rl7SAnmLGjB7yuHqyvbwFdGE=;
        b=wpJgwH+iTX6tslJsni5hz4FxzPdFGYHYDGQQihaGgTDRtf2F0J/nxrbWloo/qVF3c6
         y1Jbr8ufAaoAeDgOmLidk8qps/e1utVLNltiyNQvLTvpWECuzqT/o1w2cxmlLMyOjldT
         8Z8fzduXYv6jQcxZB0CBlRyWCaduaGVe4cejI4O/94owHlLSnFmo0luqpML9yirEKOwv
         8yPIRAgqXyBEgC5heY31gDzKVn9NmsICGMUhxTADGrk/QHsT94A1+D7iZQxBnko6Tkmh
         nToX3ucnMnzixt58ec5wej3eQoxQ8VDdRjtHgqEXpAcShnz0pvkc9MLuuLQ9ZwQeOLN+
         pOyA==
X-Forwarded-Encrypted: i=1; AJvYcCWssDb5u/rVcHT5viOmHnlEDI6kslcdbxDRiHZEpjWUDhTOhq5TsDHdVGyVcOHPwGUYhrvRUfb+dLWeoYRKe5+hc1k/ZLh2ehmSjALE
X-Gm-Message-State: AOJu0YyMIf0YP4PZqCRZTcJiOeGj8TbI9gPEu5CpH3lpheqBryky45xw
	GMOetqlCIHs/2mI6EqB7ERytey0reZBn4XRu5PFElLWxb5PhB4qmOEScjGkO
X-Google-Smtp-Source: AGHT+IHSbMtHAQIh+PfqRG0gW0Y1lSnuI10KtMX9wyKQO0P5Kw6DL1x3fzgwy290LKu7YQyO4BqMtg==
X-Received: by 2002:a05:6359:4608:b0:186:2a96:a5b9 with SMTP id my8-20020a056359460800b001862a96a5b9mr2626632rwb.6.1712922569322;
        Fri, 12 Apr 2024 04:49:29 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id q1-20020a634301000000b005e43cce33f8sm2541048pga.88.2024.04.12.04.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:49:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	corbet@lwn.net
Subject: [PATCH v6 3/4] mm: add docs for per-order mTHP counters and transhuge_page ABI
Date: Fri, 12 Apr 2024 23:48:57 +1200
Message-Id: <20240412114858.407208-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412114858.407208-1-21cnbao@gmail.com>
References: <20240412114858.407208-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch includes documentation for mTHP counters and an ABI file
for sys-kernel-mm-transparent-hugepage, which appears to have been
missing for some time.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 .../sys-kernel-mm-transparent-hugepage        | 17 +++++++++++
 Documentation/admin-guide/mm/transhuge.rst    | 28 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage

diff --git a/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage b/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
new file mode 100644
index 000000000000..33163eba5342
--- /dev/null
+++ b/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
@@ -0,0 +1,17 @@
+What:		/sys/kernel/mm/transparent_hugepage/
+Date:		April 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:
+		/sys/kernel/mm/transparent_hugepage/ contains a number of files and
+		subdirectories,
+			- defrag
+			- enabled
+			- hpage_pmd_size
+			- khugepaged
+			- shmem_enabled
+			- use_zero_page
+			- subdirectories of the form hugepages-<size>kB, where <size>
+			  is the page size of the hugepages supported by the kernel/CPU
+			  combination.
+
+		See Documentation/admin-guide/mm/transhuge.rst for details.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 04eb45a2f940..e0fe17affeb3 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -447,6 +447,34 @@ thp_swpout_fallback
 	Usually because failed to allocate some continuous swap space
 	for the huge page.
 
+In /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats, There are
+also individual counters for each huge page size, which can be utilized to
+monitor the system's effectiveness in providing huge pages for usage. Each
+counter has its own corresponding file.
+
+anon_fault_alloc
+	is incremented every time a huge page is successfully
+	allocated and charged to handle a page fault.
+
+anon_fault_fallback
+	is incremented if a page fault fails to allocate or charge
+	a huge page and instead falls back to using huge pages with
+	lower orders or small pages.
+
+anon_fault_fallback_charge
+	is incremented if a page fault fails to charge a huge page and
+	instead falls back to using huge pages with lower orders or
+	small pages even though the allocation was successful.
+
+anon_swpout
+	is incremented every time a huge page is swapped out in one
+	piece without splitting.
+
+anon_swpout_fallback
+	is incremented if a huge page has to be split before swapout.
+	Usually because failed to allocate some continuous swap space
+	for the huge page.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
-- 
2.34.1


