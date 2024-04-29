Return-Path: <linux-kernel+bounces-162618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE8F8B5E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD631C21825
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4C8288C;
	Mon, 29 Apr 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="AIwu5D34"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8367BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405869; cv=none; b=FvB8N9yxNwCshnkLRZvKHJKHQT5U1d6h1UWdELeQRnW3Kdx49hPWAtx3NKunvf/e4ZzYtn8HsTgc73f5rl/2rcSSsgzNkjPdUC1yS2PHtiwDyQ72v+SOUSWpbNbJbtCkrVldyMLpOZti8v371CyLxwtn01HcN4DBbRK3XVUU1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405869; c=relaxed/simple;
	bh=4L/xz6g8G1LZubWy37AQl45FsQs/gIYMPrZnLauK9DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q7pnJOk7c7+zt+gy6acoaHBhE9oQknVXisOEVwjo8GNo3v/NuSPs7lQK80CpYjiZKZGlf0S3nyPe2ajSpICM4GW+F0PMV3muDXBzU1hemjpreO47+ZdhVHY38olOadEQ7uAksYddRCNwiswE/t41RE0dwNsV4rmUV3kZ6ylFJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=AIwu5D34; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c86f066256so227990b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1714405867; x=1715010667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ed9b0C/5Kj3ZHFxbEvye8lhJMXnRT844TUGU67xG3Zg=;
        b=AIwu5D34hKGylM8qxiEpe1jxcPbSB0H9vKxyqDllZFSM7dV+Xlu5UoP3zM2nkWOJ8f
         NGPLOC9G//PE4A4LUPeBEdUzYBqYG1YrTIrGpt+sF+UgmV16SGlgg+XvBOMhJfJ0uPS0
         g4m8EJrAUDT67JACecmdaTSdjPWbtfc4/LNfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405867; x=1715010667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ed9b0C/5Kj3ZHFxbEvye8lhJMXnRT844TUGU67xG3Zg=;
        b=VfURpNss2VJclvXMvlOvwolvwsdXq6qqGKTKMeb7M51LwomKW8ovhH0glJNB2Vc/N6
         33jdZb3hAoJrL8E78aW5qMdAKikmnuS6dotgcmA86D7tahHjwqy0ThNENhG/BfcZUG8d
         8PlJMpgs/2IcsJ1smVNkrso6sDTTxyMHYtH1pevVFVsPFaHl48UHXA+qwq+YK5vFKw1+
         CoSYDd8qInlfSNHkQGbSJy49jRMzIWGppHuPaDvPBMmP2zaVSGa/3YUozfkt2jKMPweZ
         8s7V+w1Q9gvnHNBJWFP98Eq6bKzaFtdQadVlmKj/A8aDcfqjxgaZHIV1DFp5FmcwZyWr
         S5lg==
X-Forwarded-Encrypted: i=1; AJvYcCU3fnGh7J4pOZZPCNxD+9DAQaespp7MUdZCOAWI0VDzCfGf3YsjKQr9gfCIKo2c23lSumYmziyhc/MmTHuchFk4SueK6efyxN/Rm9bV
X-Gm-Message-State: AOJu0Yyl3iZBEA/cPHjLQfrg13MlWgOFiKMOLUR1CCBCeaLzpRAsY5Ce
	rHKIDHe7E7rkWWLZaxyfDYLXXGIT22GrEGI837MlffrHQU3Brii5q/Lj3SZqXEFdlJYpjOZxZTb
	V
X-Google-Smtp-Source: AGHT+IHivBVkXz7CXEUnqa3U7gqZFVhDdfCDt22I/t+pgSq1wOaDjqNoi5HvY/E/+iUDYuSA4jJq8g==
X-Received: by 2002:a05:6808:f86:b0:3c7:ef1:483e with SMTP id o6-20020a0568080f8600b003c70ef1483emr251037oiw.39.1714405867438;
        Mon, 29 Apr 2024 08:51:07 -0700 (PDT)
Received: from localhost ([213.195.114.223])
        by smtp.gmail.com with ESMTPSA id bz4-20020ad44c04000000b006a067efb28fsm9221277qvb.43.2024.04.29.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:51:07 -0700 (PDT)
From: Roger Pau Monne <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] xen/x86: add extra pages to unpopulated-alloc if available
Date: Mon, 29 Apr 2024 17:50:53 +0200
Message-ID: <20240429155053.72509-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 262fc47ac174 ('xen/balloon: don't use PV mode extra memory for zone
device allocations') removed the addition of the extra memory ranges to the
unpopulated range allocator, using those only for the balloon driver.

This forces the unpopulated allocator to attach hotplug ranges even when spare
memory (as part of the extra memory ranges) is available.  Furthermore, on PVH
domains it defeats the purpose of commit 38620fc4e893 ('x86/xen: attempt to
inflate the memory balloon on PVH'), as extra memory ranges would only be
used to map foreign memory if the kernel is built without XEN_UNPOPULATED_ALLOC
support.

Fix this by adding a helpers that adds the extra memory ranges to the list of
unpopulated pages, and zeroes the ranges so they are not also consumed by the
balloon driver.

This should have been part of 38620fc4e893, hence the fixes tag.

Note the current logic relies on unpopulated_init() (and hence
arch_xen_unpopulated_init()) always being called ahead of balloon_init(), so
that the extra memory regions are consumed by arch_xen_unpopulated_init().

Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
There's a lot of duplication between the unpopulated allocator and the balloon
driver.  I feel like the balloon driver should request any extra memory it
needs to the unpopulated allocator, so that the current helpers provided by the
XEN_BALLOON_MEMORY_HOTPLUG option could be replaced with wrappers around the
unpopulated handlers.

However this is much more work than strictly required here, and won't be
suitable for backport IMO.  Hence the more contained fix presented in this
patch.
---
 arch/x86/xen/enlighten.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index a01ca255b0c6..b88722dfc4f8 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -382,3 +382,36 @@ void __init xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns)
 
 	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
 }
+
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
+int __init arch_xen_unpopulated_init(struct resource **res)
+{
+	unsigned int i;
+
+	if (!xen_domain())
+		return -ENODEV;
+
+	/* Must be set strictly before calling xen_free_unpopulated_pages(). */
+	*res = &iomem_resource;
+
+	/*
+	 * Initialize with pages from the extra memory regions (see
+	 * arch/x86/xen/setup.c).
+	 */
+	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
+		unsigned int j;
+
+		for (j = 0; j < xen_extra_mem[i].n_pfns; j++) {
+			struct page *pg =
+				pfn_to_page(xen_extra_mem[i].start_pfn + j);
+
+			xen_free_unpopulated_pages(1, &pg);
+		}
+
+		/* Zero so region is not also added to the balloon driver. */
+		xen_extra_mem[i].n_pfns = 0;
+	}
+
+	return 0;
+}
+#endif
-- 
2.44.0


