Return-Path: <linux-kernel+bounces-10020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB281CED2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8492C1C22AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056B2E848;
	Fri, 22 Dec 2023 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C7LGG8WO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DB2EAF0;
	Fri, 22 Dec 2023 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273825; x=1734809825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FgoPrKrTf/fInUIvTT5Pn4UuSoOGQTffwp30B9kCFRs=;
  b=C7LGG8WO2Q9VRZ53erAlM6EkmXskETDEyV17WnzGy+Wp/yE6zWP4avTJ
   yDD6AlcOali94BantwBaiMvb9FsG6MyFEvlKkkLFhwx09o6ryp9WYek5f
   /+CsfAdw7mkiABQQioBp7liUKSLtj1HqLct+ltTJ6TcEz+8YB33soxQ7B
   o=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="693393942"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:36:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 8AC0B40D5B;
	Fri, 22 Dec 2023 19:36:55 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:44832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.220:2525] with esmtp (Farcaster)
 id 21261db6-5ae1-4e8c-a141-2ca568fe2657; Fri, 22 Dec 2023 19:36:55 +0000 (UTC)
X-Farcaster-Flow-ID: 21261db6-5ae1-4e8c-a141-2ca568fe2657
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:55 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:51 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH v2 05/17] kexec: Add KHO support to kexec file loads
Date: Fri, 22 Dec 2023 19:35:55 +0000
Message-ID: <20231222193607.15474-6-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kexec has 2 modes: A user space driven mode and a kernel driven mode.
For the kernel driven mode, kernel code determines the physical
addresses of all target buffers that the payload gets copied into.

With KHO, we can only safely copy payloads into the "scratch area".
Teach the kexec file loader about it, so it only allocates for that
area. In addition, enlighten it with support to ask the KHO subsystem
for its respective payloads to copy into target memory. Also teach the
KHO subsystem how to fill the images for file loads.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/kexec.h  |   9 ++
 kernel/kexec_file.c    |  41 ++++++++
 kernel/kexec_kho_out.c | 210 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 765f71976230..39a2990007a8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -362,6 +362,13 @@ struct kimage {
 	size_t ima_buffer_size;
 #endif
 
+#ifdef CONFIG_KEXEC_KHO
+	struct {
+		struct kexec_buf dt;
+		struct kexec_buf mem_cache;
+	} kho;
+#endif
+
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_sz;
@@ -543,6 +550,7 @@ static inline bool is_kho_boot(void)
 
 /* egest handover metadata */
 void kho_reserve_scratch(void);
+int kho_fill_kimage(struct kimage *image);
 int register_kho_notifier(struct notifier_block *nb);
 int unregister_kho_notifier(struct notifier_block *nb);
 bool kho_is_active(void);
@@ -560,6 +568,7 @@ static inline bool is_kho_boot(void) { return false; }
 
 /* egest handover metadata */
 static inline void kho_reserve_scratch(void) { }
+static inline int kho_fill_kimage(struct kimage *image) { return 0; }
 static inline int register_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
 static inline int unregister_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
 static inline bool kho_is_active(void) { return false; }
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..d895d0a49bd9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -113,6 +113,13 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->ima_buffer = NULL;
 #endif /* CONFIG_IMA_KEXEC */
 
+#ifdef CONFIG_KEXEC_KHO
+	kvfree(image->kho.mem_cache.buffer);
+	image->kho.mem_cache = (struct kexec_buf) {};
+	kvfree(image->kho.dt.buffer);
+	image->kho.dt = (struct kexec_buf) {};
+#endif
+
 	/* See if architecture has anything to cleanup post load */
 	arch_kimage_file_post_load_cleanup(image);
 
@@ -249,6 +256,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
+	/* If KHO is active, add its images to the list */
+	ret = kho_fill_kimage(image);
+	if (ret)
+		goto out;
+
 	/* Call image load handler */
 	ldata = kexec_image_load_default(image);
 
@@ -518,6 +530,24 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#ifdef CONFIG_KEXEC_KHO
+static int kexec_walk_kho_scratch(struct kexec_buf *kbuf,
+				  int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+
+	struct resource res = {
+		.start = kho_scratch_phys,
+		.end = kho_scratch_phys + kho_scratch_len,
+	};
+
+	/* Try to fit the kimage into our KHO scratch region */
+	ret = func(&res, kbuf);
+
+	return ret;
+}
+#endif
+
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 static int kexec_walk_memblock(struct kexec_buf *kbuf,
 			       int (*func)(struct resource *, void *))
@@ -612,6 +642,17 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
+#ifdef CONFIG_KEXEC_KHO
+	/*
+	 * If KHO is active, only use KHO scratch memory. All other memory
+	 * could potentially be handed over.
+	 */
+	if (kho_is_active() && kbuf->image->type != KEXEC_TYPE_CRASH) {
+		ret = kexec_walk_kho_scratch(kbuf, locate_mem_hole_callback);
+		return ret == 1 ? 0 : -EADDRNOTAVAIL;
+	}
+#endif
+
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 	else
diff --git a/kernel/kexec_kho_out.c b/kernel/kexec_kho_out.c
index 765cf6ba7a46..2cf5755f5e4a 100644
--- a/kernel/kexec_kho_out.c
+++ b/kernel/kexec_kho_out.c
@@ -50,6 +50,216 @@ int unregister_kho_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_kho_notifier);
 
+static int kho_mem_cache_add(void *fdt, struct kho_mem *mem_cache, int size,
+			     struct kho_mem *new_mem)
+{
+	int entries = size / sizeof(*mem_cache);
+	u64 new_start = new_mem->addr;
+	u64 new_end = new_mem->addr + new_mem->len;
+	u64 prev_start = 0;
+	u64 prev_end = 0;
+	int i;
+
+	if (WARN_ON((new_start < (kho_scratch_phys + kho_scratch_len)) &&
+		    (new_end > kho_scratch_phys))) {
+		pr_err("KHO memory runs over scratch memory");
+		return -EINVAL;
+	}
+
+	/*
+	 * We walk the existing sorted mem cache and find the spot where this
+	 * new entry would start, so we can insert it right there.
+	 */
+	for (i = 0; i < entries; i++) {
+		struct kho_mem *mem = &mem_cache[i];
+		u64 mem_end = (mem->addr + mem->len);
+
+		if (mem_end < new_start) {
+			/* No overlap */
+			prev_start = mem->addr;
+			prev_end = mem->addr + mem->len;
+			continue;
+		} else if ((new_start >= mem->addr) && (new_end <= mem_end)) {
+			/* new_mem fits into mem, skip */
+			return size;
+		} else if ((new_end >= mem->addr) && (new_start <= mem_end)) {
+			/* new_mem and mem overlap, fold them */
+			bool remove = false;
+
+			mem->addr = min(new_start, mem->addr);
+			mem->len = max(mem_end, new_end) - mem->addr;
+			mem_end = (mem->addr + mem->len);
+
+			if (i > 0 && prev_end >= mem->addr) {
+				/* We now overlap with the previous mem, fold */
+				struct kho_mem *prev = &mem_cache[i - 1];
+
+				prev->addr = min(prev->addr, mem->addr);
+				prev->len = max(mem_end, prev_end) - prev->addr;
+				remove = true;
+			} else if (i < (entries - 1) && mem_end >= mem_cache[i + 1].addr) {
+				/* We now overlap with the next mem, fold */
+				struct kho_mem *next = &mem_cache[i + 1];
+				u64 next_end = (next->addr + next->len);
+
+				next->addr = min(next->addr, mem->addr);
+				next->len = max(mem_end, next_end) - next->addr;
+				remove = true;
+			}
+
+			if (remove) {
+				/* We folded this mem into another, remove it */
+				memmove(mem, mem + 1, (entries - i - 1) * sizeof(*mem));
+				size -= sizeof(*new_mem);
+			}
+
+			return size;
+		} else if (mem->addr > new_end) {
+			/*
+			 * The mem cache is sorted. If we find the current
+			 * entry start after our new_mem's end, we shot over
+			 * which means we need to add it by creating a new
+			 * hole right after the current entry.
+			 */
+			memmove(mem + 1, mem, (entries - i) * sizeof(*mem));
+			break;
+		}
+	}
+
+	mem_cache[i] = *new_mem;
+	size += sizeof(*new_mem);
+
+	return size;
+}
+
+/**
+ * kho_alloc_mem_cache - Allocate and initialize the mem cache kexec_buf
+ */
+static int kho_alloc_mem_cache(struct kimage *image, void *fdt)
+{
+	int offset, depth, initial_depth, len;
+	void *mem_cache;
+	int size;
+
+	/* Count the elements inside all "mem" properties in the DT */
+	size = offset = depth = initial_depth = 0;
+	for (offset = 0;
+	     offset >= 0 && depth >= initial_depth;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		const struct kho_mem *mems;
+
+		mems = fdt_getprop(fdt, offset, "mem", &len);
+		if (!mems || len & (sizeof(*mems) - 1))
+			continue;
+		size += len;
+	}
+
+	/* Allocate based on the max size we determined */
+	mem_cache = kvmalloc(size, GFP_KERNEL);
+	if (!mem_cache)
+		return -ENOMEM;
+
+	/* And populate the array */
+	size = offset = depth = initial_depth = 0;
+	for (offset = 0;
+	     offset >= 0 && depth >= initial_depth;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		const struct kho_mem *mems;
+		int nr_mems, i;
+
+		mems = fdt_getprop(fdt, offset, "mem", &len);
+		if (!mems || len & (sizeof(*mems) - 1))
+			continue;
+
+		for (i = 0, nr_mems = len / sizeof(*mems); i < nr_mems; i++) {
+			const struct kho_mem *mem = &mems[i];
+			ulong mstart = PAGE_ALIGN_DOWN(mem->addr);
+			ulong mend = PAGE_ALIGN(mem->addr + mem->len);
+			struct kho_mem cmem = {
+				.addr = mstart,
+				.len = (mend - mstart),
+			};
+
+			size = kho_mem_cache_add(fdt, mem_cache, size, &cmem);
+			if (size < 0)
+				return size;
+		}
+	}
+
+	image->kho.mem_cache.buffer = mem_cache;
+	image->kho.mem_cache.bufsz = size;
+	image->kho.mem_cache.memsz = size;
+
+	return 0;
+}
+
+int kho_fill_kimage(struct kimage *image)
+{
+	int err = 0;
+	void *dt;
+
+	mutex_lock(&kho.lock);
+
+	if (!kho.active)
+		goto out;
+
+	/* Initialize kexec_buf for mem_cache */
+	image->kho.mem_cache = (struct kexec_buf) {
+		.image = image,
+		.buffer = NULL,
+		.bufsz = 0,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = 0,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+
+	/*
+	 * We need to make all allocations visible here via the mem_cache so that
+	 * kho_is_destination_range() can identify overlapping regions and ensure
+	 * that no kimage (including the DT one) lands on handed over memory.
+	 *
+	 * Since we conveniently already built an array of all allocations, let's
+	 * pass that on to the target kernel so that reuse it to initialize its
+	 * memory blocks.
+	 */
+	err = kho_alloc_mem_cache(image, kho.dt);
+	if (err)
+		goto out;
+
+	err = kexec_add_buffer(&image->kho.mem_cache);
+	if (err)
+		goto out;
+
+	/*
+	 * Create a kexec copy of the DT here. We need this because lifetime may
+	 * be different between kho.dt and the kimage
+	 */
+	dt = kvmemdup(kho.dt, kho.dt_len, GFP_KERNEL);
+	if (!dt) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Allocate target memory for kho dt */
+	image->kho.dt = (struct kexec_buf) {
+		.image = image,
+		.buffer = dt,
+		.bufsz = kho.dt_len,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = kho.dt_len,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+	err = kexec_add_buffer(&image->kho.dt);
+
+out:
+	mutex_unlock(&kho.lock);
+	return err;
+}
+
 bool kho_is_active(void)
 {
 	return kho.active;
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




