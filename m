Return-Path: <linux-kernel+bounces-123923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCDF890FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13219293853
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175938FB6;
	Fri, 29 Mar 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9Pv8F9v"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAB38384
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672853; cv=none; b=VyV6f92Pbkvgal6XVr+FVp7Iv3oOPp2GP6kIw8SG62OXQCdISCRaXvIdF+MTZB0kfa1oYTE3ug/f/EqOtu7VYUe6RdizLiGSrFVNytaPmuZ4Z8bFRXRNYpEcl/vWQzV7NcK74mD9dd6tKZGkOE7VCtJCEM9yaeQJa8+OYtpbUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672853; c=relaxed/simple;
	bh=+bAuhnv5ztlMtsCbhgujhU7lsWw+qA+HQ0jw4pbPpNA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfaduccdH7hNkrDMMcBZofl5pCJvyVMGZcwEWpEQe3Dh3Qgilb+mCWJ6OUCJ9MXpJdHsoT/rn7r5xSDuLuh2bNpHwc4y4zasQmwSTwraXA927e/Y6ytYl4XvHvy3wlu8QCm1Zhk6ojXSFkMKV5SPHQxBANUNpPw1vNIarodTqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J9Pv8F9v; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e134f73aso1833577e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711672850; x=1712277650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wi1ZNjaokpo1/2/WGAYx2F1Noa8brMlLmLxb7LsoaM=;
        b=J9Pv8F9vWDneqZU1kkROGaC5Rp/EXlFp4sFt+3w0NYzQ8xAiT0otxpFw3ATHeYbqvD
         HZilD6BqbANU1lz850xH/nXvcjvIL4ccDZBpInoNNwyOKkJYoDliMCzauedBN8uiJpRa
         fbZ3RhYzwIb0oMlDbskqyh6hqNeMpfT+YROjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672850; x=1712277650;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wi1ZNjaokpo1/2/WGAYx2F1Noa8brMlLmLxb7LsoaM=;
        b=LFXw/XhTeAXBpRQf+jyYdxaTaIk31qB215bWvdMGo7e8gw+RRtSsp2PJOSEzqtXwcf
         QPCyN3dZld2YFbgWGN1N7waOmdyGXDPCQP55ryTg6HDVkZVwCfKcqr4DCvyCfyUx9b7H
         VlPg6sfF7n45dzjSOF0sbPvtvcHtTRC8DPVASHTvmtiRPyLL/8DI5DgG0J8nbvmBNzIv
         3WfDK1K0f+jpq5ZZMNh4wCjplgswatQFk082GIlLRoFor9XNRQih+YRHvc25S63YWKgg
         dHC9RslDPLrTeYGdUqTO91DtVDBA/8VSwI/tlmG6953Jln5sd77xvxICtjPCAHy5PgZS
         aZVA==
X-Forwarded-Encrypted: i=1; AJvYcCVXe22c3ekv+okzkDv8AU3gbHcl2UW9qZEqtZrhaqyRWELT49To/uiFXQ6t5/Jd7km8nuCqzyoUtXBuVUdOPvgzvEh9rB6i1TZNj0PL
X-Gm-Message-State: AOJu0YyHP9tWgtPo8msXcwbehwhyzJHUsyaNzV4A94p7KOCSzB0vkakh
	Jatpqcud3gvHjMHr3g1MErpl++xt1QSRyDu2gE/FGltgTuQcnwHkSVQPnVMJJJkGonjmul8I7pn
	uRS4kEK3F28YCj7y6niXAtn17xLR0qz/dN6KY
X-Google-Smtp-Source: AGHT+IEsbKY2aRvY5yWihO7/+jcjcpxM6ugrZbZSLKPkJmxYyn0oQJdVeEkFZ+TDLC4qf1QQoTU2xrs2RS0Q1lOd+o8=
X-Received: by 2002:ac2:5dc8:0:b0:513:aef9:7159 with SMTP id
 x8-20020ac25dc8000000b00513aef97159mr634579lfq.39.1711672849780; Thu, 28 Mar
 2024 17:40:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Mar 2024 19:40:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgU_YDUhBeyS5wuh@gerhold.net>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org> <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org> <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
 <ZgU_YDUhBeyS5wuh@gerhold.net>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 28 Mar 2024 19:40:49 -0500
Message-ID: <CAE-0n50BGLccCTDfCmOd0Bcbmp7SMwsJd8qTVPWioKvbaD0A0w@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
To: Caleb Connolly <caleb.connolly@linaro.org>, Stephan Gerhold <stephan@gerhold.net>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Bjorn Andersson <andersson@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephan Gerhold (2024-03-28 02:58:56)
>
> FWIW: This old patch series from Stephen Boyd is closely related:
> https://lore.kernel.org/linux-arm-msm/20190910160903.65694-1-swboyd@chromium.org/
>
> > The main use case I have is to map the command-db memory region on
> > Qualcomm devices with a read-only mapping. It's already a const marked
> > pointer and the API returns const pointers as well, so this series
> > makes sure that even stray writes can't modify the memory.
>
> Stephen, what was the end result of that patch series? Mapping the
> cmd-db read-only sounds cleaner than trying to be lucky with the right
> set of cache flags.
>

I dropped it because I got busy with other stuff. Feel free to pick it
back up. It looks like the part where I left off was where we had to
make the API fallback to mapping the memory as writeable if read-only
isn't supported on the architecture. I also wanted to return a const
pointer. The other weird thing was that we passed both MEMREMAP_RO and
MEMREMAP_WB to indicate what sort of fallback we want. Perhaps that can
be encoded in the architecture layer so that you get the closest thing
to read-only memory (i.e. any sort of write side caching is removed) and
you don't have to pass a fallback mapping type.

Here's my stash patch on top of the branch (from 2019!).

---8<----
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 14 May 2019 13:22:01 -0700
Subject: [PATCH] stash const iounmap

---
 arch/arm64/include/asm/io.h   |  2 +-
 arch/arm64/mm/ioremap.c       |  9 +++++----
 arch/x86/mm/ioremap.c         |  2 +-
 drivers/firmware/google/vpd.c | 22 +++++++++++-----------
 drivers/soc/qcom/rmtfs_mem.c  |  5 ++---
 include/asm-generic/io.h      |  2 +-
 include/linux/io.h            |  2 +-
 include/linux/mmiotrace.h     |  2 +-
 kernel/iomem.c                |  2 +-
 9 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 245bd371e8dc..0fd4f1678300 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -178,7 +178,7 @@ extern void __memset_io(volatile void __iomem *,
int, size_t);
  * I/O memory mapping functions.
  */
 extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size,
pgprot_t prot);
-extern void __iounmap(volatile void __iomem *addr);
+extern void __iounmap(const volatile void __iomem *addr);
 extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);

 #define ioremap(addr, size)		__ioremap((addr), (size),
__pgprot(PROT_DEVICE_nGnRE))
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index c4c8cd4c31d4..e39fb2cb6042 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -80,16 +80,17 @@ void __iomem *__ioremap(phys_addr_t phys_addr,
size_t size, pgprot_t prot)
 }
 EXPORT_SYMBOL(__ioremap);

-void __iounmap(volatile void __iomem *io_addr)
+void __iounmap(const volatile void __iomem *io_addr)
 {
-	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
+	const unsigned long addr = (const unsigned long)io_addr & PAGE_MASK;
+	const void *vaddr = (const void __force *)addr;

 	/*
 	 * We could get an address outside vmalloc range in case
 	 * of ioremap_cache() reusing a RAM mapping.
 	 */
-	if (is_vmalloc_addr((void *)addr))
-		vunmap((void *)addr);
+	if (is_vmalloc_addr(vaddr))
+		vunmap(vaddr);
 }
 EXPORT_SYMBOL(__iounmap);

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..e9a2910d0c63 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -392,7 +392,7 @@ EXPORT_SYMBOL(ioremap_prot);
  *
  * Caller must ensure there is only one unmapping for the same pointer.
  */
-void iounmap(volatile void __iomem *addr)
+void iounmap(const volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index c0c0b4e4e281..7428f189999e 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -48,7 +48,7 @@ struct vpd_section {
 	const char *name;
 	char *raw_name;                /* the string name_raw */
 	struct kobject *kobj;          /* vpd/name directory */
-	char *baseaddr;
+	const char *baseaddr;
 	struct bin_attribute bin_attr; /* vpd/name_raw bin_attribute */
 	struct list_head attribs;      /* key/value in vpd_attrib_info list */
 };
@@ -187,19 +187,19 @@ static int vpd_section_create_attribs(struct
vpd_section *sec)
 	return 0;
 }

-static int vpd_section_init(const char *name, struct vpd_section *sec,
+static int vpd_section_init(struct device *dev, const char *name,
struct vpd_section *sec,
 			    phys_addr_t physaddr, size_t size)
 {
 	int err;

-	sec->baseaddr = memremap(physaddr, size, MEMREMAP_WB);
-	if (!sec->baseaddr)
-		return -ENOMEM;
+	sec->baseaddr = devm_memremap(physaddr, size, MEMREMAP_RO | MEMREMAP_WB);
+	if (IS_ERR(sec->baseaddr))
+		return PTR_ERR(sec->baseaddr);

 	sec->name = name;

 	/* We want to export the raw partition with name ${name}_raw */
-	sec->raw_name = kasprintf(GFP_KERNEL, "%s_raw", name);
+	sec->raw_name = devm_kasprintf(GFP_KERNEL, "%s_raw", name);
 	if (!sec->raw_name) {
 		err = -ENOMEM;
 		goto err_memunmap;
@@ -252,11 +252,12 @@ static int vpd_section_destroy(struct vpd_section *sec)
 	return 0;
 }

-static int vpd_sections_init(phys_addr_t physaddr)
+static int vpd_sections_init(struct coreboot_device *cdev)
 {
 	struct vpd_cbmem __iomem *temp;
 	struct vpd_cbmem header;
 	int ret = 0;
+	phys_addr_t physaddr = cdev->cbmem_ref.cbmem_addr;

 	temp = memremap(physaddr, sizeof(struct vpd_cbmem), MEMREMAP_WB);
 	if (!temp)
@@ -269,7 +270,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
 		return -ENODEV;

 	if (header.ro_size) {
-		ret = vpd_section_init("ro", &ro_vpd,
+		ret = vpd_section_init(&cdev->dev, "ro", &ro_vpd,
 				       physaddr + sizeof(struct vpd_cbmem),
 				       header.ro_size);
 		if (ret)
@@ -294,10 +295,9 @@ static int vpd_probe(struct coreboot_device *dev)
 	int ret;

 	vpd_kobj = kobject_create_and_add("vpd", firmware_kobj);
-	if (!vpd_kobj)
-		return -ENOMEM;
+	if (!vpd_kobj) return -ENOMEM;

-	ret = vpd_sections_init(dev->cbmem_ref.cbmem_addr);
+	ret = vpd_sections_init(dev);
 	if (ret) {
 		kobject_put(vpd_kobj);
 		return ret;
diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 6f5e8be9689c..137e5240d916 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -212,10 +212,9 @@ static int qcom_rmtfs_mem_probe(struct
platform_device *pdev)
 	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
 	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;

-	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
-					rmtfs_mem->size, MEMREMAP_WC);
+	rmtfs_mem->base = devm_memremap_reserved_mem(&pdev->dev,
+						     MEMREMAP_WC);
 	if (IS_ERR(rmtfs_mem->base)) {
-		dev_err(&pdev->dev, "failed to remap rmtfs_mem region\n");
 		ret = PTR_ERR(rmtfs_mem->base);
 		goto put_device;
 	}
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 303871651f8a..d675a574eeb3 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -982,7 +982,7 @@ static inline void __iomem *__ioremap(phys_addr_t
offset, size_t size,
 #ifndef iounmap
 #define iounmap iounmap

-static inline void iounmap(void __iomem *addr)
+static inline void iounmap(const void __iomem *addr)
 {
 }
 #endif
diff --git a/include/linux/io.h b/include/linux/io.h
index 16c7f4498869..82e6c4d6bdd3 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -163,7 +163,7 @@ enum {
 };

 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
-void memunmap(void *addr);
+void memunmap(const void *addr);

 /*
  * On x86 PAT systems we have memory tracking that keeps track of
diff --git a/include/linux/mmiotrace.h b/include/linux/mmiotrace.h
index 88236849894d..04607c468b73 100644
--- a/include/linux/mmiotrace.h
+++ b/include/linux/mmiotrace.h
@@ -47,7 +47,7 @@ extern int kmmio_handler(struct pt_regs *regs,
unsigned long addr);
 /* Called from ioremap.c */
 extern void mmiotrace_ioremap(resource_size_t offset, unsigned long size,
 							void __iomem *addr);
-extern void mmiotrace_iounmap(volatile void __iomem *addr);
+extern void mmiotrace_iounmap(const volatile void __iomem *addr);

 /* For anyone to insert markers. Remember trailing newline. */
 extern __printf(1, 2) int mmiotrace_printk(const char *fmt, ...);
diff --git a/kernel/iomem.c b/kernel/iomem.c
index 8d3cf74a32cb..22d0fa336360 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -130,7 +130,7 @@ void *memremap(resource_size_t offset, size_t
size, unsigned long flags)
 }
 EXPORT_SYMBOL(memremap);

-void memunmap(void *addr)
+void memunmap(const void *addr)
 {
 	if (is_vmalloc_addr(addr))
 		iounmap((void __iomem *) addr);

base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
prerequisite-patch-id: 62119e27c0c0686e02f0cb55c296b878fb7f5e47
prerequisite-patch-id: bda32cfc1733c245ae3f141d7c27b18e4adcc628
prerequisite-patch-id: b8f8097161bd15e87d54dcfbfa67b9ca1abc7204
prerequisite-patch-id: cd374fb6e39941b8613d213b4a75909749409d63
prerequisite-patch-id: d8dbc8485a0f86353a314ab5c22fc92d8eac1cc0
prerequisite-patch-id: e539621b0eccf82aabf9891de69c30398abf76a0
prerequisite-patch-id: 59d60033b80dec940201edd5aefed22726122a37
prerequisite-patch-id: 0d16b23cec20eaab7f45ee84fd8d2950657dc72e
-- 
https://chromeos.dev

