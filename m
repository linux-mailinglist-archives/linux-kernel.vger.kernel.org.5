Return-Path: <linux-kernel+bounces-24327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6166182BB10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88AC289F35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A935C8E2;
	Fri, 12 Jan 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc/1Xz32"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A05C902
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eb6dba1796so115717227b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038786; x=1705643586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgNchHS++prR/h3S2HHor+FAVbRKiDRX1egmYCByUjw=;
        b=dc/1Xz32RIzMrp6QjoBemHExoNQ2PbmRylBdEo1+M89DYNTG7C/ty3KQ6Hg5hD1mG5
         o0owqv4GYQ1dH0rMkWwm1IleZ0C2X8l65IVOJHsdgXPhONQa64kK2rsxMY69AMupWu3/
         izH5TS6ts1zl89PfymLmlkUR1FLS2S4PJPlaGQwqhnLunbLBwfuAtoadIQNy/Zt/n/qF
         SeMAPL6kOHJo2V0WfDYQUUu/nazw3IAzF4+y8Knw2wJatJUAhIRQGKCl+gvhUvG23OX9
         jZEyul7vpJ1hD256r6mMgvD7ATaaaRyf3PwhnyRYMxZfnoqaZyAwbqYXPHqlz3ceNo8E
         /gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038786; x=1705643586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgNchHS++prR/h3S2HHor+FAVbRKiDRX1egmYCByUjw=;
        b=wt7H4KjsqWtXDw5HUyxbOo7VpmkbWH02jHQ+6gs0kGEngSGd/OCOizcPXTkW8RelCV
         Wg/1Px9KM6e8gjlhcEEwn985+fLRf1wZ3zAbom4xPc/RdXpDFUi7XkNBHOduc4XeW6PR
         /ILlzZxzkrRwEACsqT4N6gh8StmUY8jBIQETjkWP32D+BcgLjEenKI1i0GJ80/DtDfBz
         y3n1bNfj3eyUxR8+UQU5bX151ZVKIbwbxYcttqqg7vUMUvVVvzoxX8KOdCnMgXCwOsvg
         48jtvcUiZKisPpNCHBUvEzxJW4Lso/iFadj+l331aAiIRnjOqe1lpemw0loJGiS1AK0j
         4B2w==
X-Gm-Message-State: AOJu0YzqeaNbEHS8fgT8bXZq2WR7BgQ9pCBkseLwnGsjhhv40H4ktrg5
	BfJ99pWSu9z0TlcMfsecZOojlk21hrBavTAXztUc/MU=
X-Google-Smtp-Source: AGHT+IHuDn+1jvl5KUmKWmyATHHZ4Buh8nYfelV4isyKtZemvMzYuO4uYtBD4xP91JEeDNYKvgt54kGnaY4QS31H
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a05:6902:1081:b0:dbd:b6cd:92cf with
 SMTP id v1-20020a056902108100b00dbdb6cd92cfmr144861ybu.11.1705038785851; Thu,
 11 Jan 2024 21:53:05 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:48 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-3-vannapurve@google.com>
Subject: [RFC V1 2/5] swiotlb: Allow setting up default alignment of SWIOTLB region
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow adjusting alignment of SWIOTLB memory. CVMs can use this framework
to align the shared memory regions as needed.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 include/linux/swiotlb.h |  5 +++++
 kernel/dma/swiotlb.c    | 12 +++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 058901313405..450bd82cdb9f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -206,6 +206,7 @@ size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
+void __init swiotlb_adjust_alignment(unsigned long alignment);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
 #else
@@ -247,6 +248,10 @@ static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
 
+void __init swiotlb_adjust_alignment(unsigned long alignment)
+{
+}
+
 static inline phys_addr_t default_swiotlb_base(void)
 {
 	return 0;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a056d2f8b9ee..eeab0607a028 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -97,6 +97,7 @@ static struct io_tlb_mem io_tlb_default_mem;
 #endif	/* CONFIG_SWIOTLB_DYNAMIC */
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+static unsigned long default_alignment = PAGE_SIZE;
 static unsigned long default_nareas;
 
 /**
@@ -223,6 +224,11 @@ void __init swiotlb_adjust_size(unsigned long size)
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }
 
+void __init swiotlb_adjust_alignment(unsigned long alignment)
+{
+	default_alignment = alignment;
+}
+
 void swiotlb_print_info(void)
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
@@ -315,7 +321,7 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 		unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
-	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
+	size_t bytes = ALIGN(nslabs << IO_TLB_SHIFT, default_alignment);
 	void *tlb;
 
 	/*
@@ -324,9 +330,9 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	 * memory encryption.
 	 */
 	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
+		tlb = memblock_alloc(bytes, default_alignment);
 	else
-		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+		tlb = memblock_alloc_low(bytes, default_alignment);
 
 	if (!tlb) {
 		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
-- 
2.43.0.275.g3460e3d667-goog


