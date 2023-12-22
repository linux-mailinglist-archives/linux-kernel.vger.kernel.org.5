Return-Path: <linux-kernel+bounces-10024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A301381CEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E13284160
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288572EAE4;
	Fri, 22 Dec 2023 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iNs5oLIu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8162E833;
	Fri, 22 Dec 2023 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273878; x=1734809878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GaYoJtOeVSzgmYS5gukWExN0RDseJvcoWD78p448UjE=;
  b=iNs5oLIuEH2H3RiMbo/mmhZ/5k1WHgHiQ/PG3XqdJqyac0ySrJLVtUiA
   IhmiF4eAIeAxedOnaQOfsdPOQfAIz5JgwJuT4exaJ3wW8R1anvT9FzbeK
   zp7e7RBbl313coBjEezKNQo9wyvXpfs1HgOqH7P1QuG6OwtSk7ECZRK2L
   A=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="53450946"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:37:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 78634A0ABC;
	Fri, 22 Dec 2023 19:37:54 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:14564]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.23:2525] with esmtp (Farcaster)
 id 78760084-28fe-498e-84c2-ddc497dcf85c; Fri, 22 Dec 2023 19:37:54 +0000 (UTC)
X-Farcaster-Flow-ID: 78760084-28fe-498e-84c2-ddc497dcf85c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:54 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:50 +0000
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
Subject: [PATCH v2 09/17] x86: Add KHO support
Date: Fri, 22 Dec 2023 19:35:59 +0000
Message-ID: <20231222193607.15474-10-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We now have all bits in place to support KHO kexecs. This patch adds
awareness of KHO in the kexec file as well as boot path for x86 and
adds the respective kconfig option to the architecture so that it can
use KHO successfully.

In addition, it enlightens it decompression code with KHO so that its
KASLR location finder only considers memory regions that are not already
occupied by KHO memory.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
---
 arch/x86/Kconfig                      |  3 ++
 arch/x86/boot/compressed/kaslr.c      | 55 +++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h | 15 +++++++-
 arch/x86/kernel/e820.c                |  9 +++++
 arch/x86/kernel/kexec-bzimage64.c     | 39 +++++++++++++++++++
 arch/x86/kernel/setup.c               | 46 ++++++++++++++++++++++
 arch/x86/mm/init_32.c                 |  7 ++++
 arch/x86/mm/init_64.c                 |  7 ++++
 8 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..9aa31b3dcebc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2094,6 +2094,9 @@ config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
 config ARCH_SUPPORTS_KEXEC_JUMP
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_KHO
+	def_bool y
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index dec961c6d16a..93ea292e4c18 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -29,6 +29,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/ctype.h>
+#include <uapi/linux/kexec.h>
 #include <generated/utsversion.h>
 #include <generated/utsrelease.h>
 
@@ -472,6 +473,60 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 			}
 		}
 
+#ifdef CONFIG_KEXEC_KHO
+		if (ptr->type == SETUP_KEXEC_KHO) {
+			struct kho_data *kho = (struct kho_data *)ptr->data;
+			struct kho_mem *mems = (void *)kho->mem_cache_addr;
+			int nr_mems = kho->mem_cache_size / sizeof(*mems);
+			int i;
+
+			/* Avoid the mem cache */
+			avoid = (struct mem_vector) {
+				.start = kho->mem_cache_addr,
+				.size = kho->mem_cache_size,
+			};
+
+			if (mem_overlaps(img, &avoid) && (avoid.start < earliest)) {
+				*overlap = avoid;
+				earliest = overlap->start;
+				is_overlapping = true;
+			}
+
+			/* And the KHO DT */
+			avoid = (struct mem_vector) {
+				.start = kho->dt_addr,
+				.size = kho->dt_size,
+			};
+
+			if (mem_overlaps(img, &avoid) && (avoid.start < earliest)) {
+				*overlap = avoid;
+				earliest = overlap->start;
+				is_overlapping = true;
+			}
+
+			/* As well as any other KHO memory reservations */
+			for (i = 0; i < nr_mems; i++) {
+				avoid = (struct mem_vector) {
+					.start = mems[i].addr,
+					.size = mems[i].len,
+				};
+
+				/*
+				 * This mem starts after our current break.
+				 * The array is sorted, so we're done.
+				 */
+				if (avoid.start >= earliest)
+					break;
+
+				if (mem_overlaps(img, &avoid)) {
+					*overlap = avoid;
+					earliest = overlap->start;
+					is_overlapping = true;
+				}
+			}
+		}
+#endif
+
 		ptr = (struct setup_data *)(unsigned long)ptr->next;
 	}
 
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..013af38a9673 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -13,7 +13,8 @@
 #define SETUP_CC_BLOB			7
 #define SETUP_IMA			8
 #define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+#define SETUP_KEXEC_KHO		10
+#define SETUP_ENUM_MAX			SETUP_KEXEC_KHO
 
 #define SETUP_INDIRECT			(1<<31)
 #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
@@ -181,6 +182,18 @@ struct ima_setup_data {
 	__u64 size;
 } __attribute__((packed));
 
+/*
+ * Locations of kexec handover metadata
+ */
+struct kho_data {
+	__u64 dt_addr;
+	__u64 dt_size;
+	__u64 scratch_addr;
+	__u64 scratch_size;
+	__u64 mem_cache_addr;
+	__u64 mem_cache_size;
+} __attribute__((packed));
+
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf953380d..c891b83f5b1c 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1341,6 +1341,15 @@ void __init e820__memblock_setup(void)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
+
+		/*
+		 * At this point with KHO we only allocate from scratch memory
+		 * and only from memory below ISA_END_ADDRESS. Make sure that
+		 * when we add memory for the eligible range, we add it as
+		 * scratch memory so that we can resize the memblocks array.
+		 */
+		if (is_kho_boot() && (end <= ISA_END_ADDRESS))
+			memblock_mark_scratch(entry->addr, end);
 	}
 
 	/* Throw away partial pages: */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..0cb8d0650a02 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kexec.h>
 #include <linux/kernel.h>
+#include <linux/libfdt.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/random.h>
@@ -233,6 +234,33 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
 #endif /* CONFIG_IMA_KEXEC */
 }
 
+static void setup_kho(const struct kimage *image, struct boot_params *params,
+		       unsigned long params_load_addr,
+		       unsigned int setup_data_offset)
+{
+#ifdef CONFIG_KEXEC_KHO
+	struct setup_data *sd = (void *)params + setup_data_offset;
+	struct kho_data *kho = (void *)sd + sizeof(*sd);
+
+	sd->type = SETUP_KEXEC_KHO;
+	sd->len = sizeof(struct kho_data);
+
+	/* Only add if we have all KHO images in place */
+	if (!image->kho.dt.buffer || !image->kho.mem_cache.buffer)
+		return;
+
+	/* Add setup data */
+	kho->dt_addr = image->kho.dt.mem;
+	kho->dt_size = image->kho.dt.bufsz;
+	kho->scratch_addr = kho_scratch_phys;
+	kho->scratch_size = kho_scratch_len;
+	kho->mem_cache_addr = image->kho.mem_cache.mem;
+	kho->mem_cache_size = image->kho.mem_cache.bufsz;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = params_load_addr + setup_data_offset;
+#endif /* CONFIG_KEXEC_KHO */
+}
+
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
@@ -305,6 +333,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 				     sizeof(struct ima_setup_data);
 	}
 
+	if (IS_ENABLED(CONFIG_KEXEC_KHO)) {
+		/* Setup space to store preservation metadata */
+		setup_kho(image, params, params_load_addr, setup_data_offset);
+		setup_data_offset += sizeof(struct setup_data) +
+				     sizeof(struct kho_data);
+	}
+
 	/* Setup RNG seed */
 	setup_rng_seed(params, params_load_addr, setup_data_offset);
 
@@ -470,6 +505,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct ima_setup_data);
 
+	if (IS_ENABLED(CONFIG_KEXEC_KHO))
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      sizeof(struct kho_data);
+
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1526747bedf2..bd21f9a601a2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -382,6 +382,29 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 }
 #endif
 
+static void __init add_kho(u64 phys_addr, u32 data_len)
+{
+#ifdef CONFIG_KEXEC_KHO
+	struct kho_data *kho;
+	u64 addr = phys_addr + sizeof(struct setup_data);
+	u64 size = data_len - sizeof(struct setup_data);
+
+	kho = early_memremap(addr, size);
+	if (!kho) {
+		pr_warn("setup: failed to memremap kho data (0x%llx, 0x%llx)\n",
+			 addr, size);
+		return;
+	}
+
+	kho_populate(kho->dt_addr, kho->scratch_addr, kho->scratch_size,
+		     kho->mem_cache_addr, kho->mem_cache_size);
+
+	early_memunmap(kho, size);
+#else
+	pr_warn("Passed KHO data, but CONFIG_KEXEC_KHO not set. Ignoring.\n");
+#endif
+}
+
 static void __init parse_setup_data(void)
 {
 	struct setup_data *data;
@@ -410,6 +433,9 @@ static void __init parse_setup_data(void)
 		case SETUP_IMA:
 			add_early_ima_buffer(pa_data);
 			break;
+		case SETUP_KEXEC_KHO:
+			add_kho(pa_data, data_len);
+			break;
 		case SETUP_RNG_SEED:
 			data = early_memremap(pa_data, data_len);
 			add_bootloader_randomness(data->data, data->len);
@@ -989,8 +1015,26 @@ void __init setup_arch(char **cmdline_p)
 	cleanup_highmap();
 
 	memblock_set_current_limit(ISA_END_ADDRESS);
+
 	e820__memblock_setup();
 
+	/*
+	 * We can resize memblocks at this point, let's dump all KHO
+	 * reservations in and switch from scratch-only to normal allocations
+	 */
+	kho_reserve_previous_mem();
+
+	/* Allocations now skip scratch mem, return low 1M to the pool */
+	if (is_kho_boot()) {
+		u64 i;
+		phys_addr_t base, end;
+
+		__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+				     MEMBLOCK_SCRATCH, &base, &end, NULL)
+			if (end <= ISA_END_ADDRESS)
+				memblock_clear_scratch(base, end - base);
+	}
+
 	/*
 	 * Needs to run after memblock setup because it needs the physical
 	 * memory size.
@@ -1106,6 +1150,8 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	arch_reserve_crashkernel();
 
+	kho_reserve_scratch();
+
 	memblock_find_dma_reserve();
 
 	if (!early_xdbc_setup_hardware())
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index b63403d7179d..6c3810afed04 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/kexec.h>
 #include <linux/pagemap.h>
 #include <linux/pci.h>
 #include <linux/pfn.h>
@@ -738,6 +739,12 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	/*
+	 * Now that all KHO pages are marked as reserved, let's flip them back
+	 * to normal pages with accurate refcount.
+	 */
+	kho_populate_refcount();
+
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
 	 * be detected at build time already.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8ceaf..3ce1a4767610 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
+#include <linux/kexec.h>
 #include <linux/pagemap.h>
 #include <linux/memblock.h>
 #include <linux/proc_fs.h>
@@ -1339,6 +1340,12 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	/*
+	 * Now that all KHO pages are marked as reserved, let's flip them back
+	 * to normal pages with accurate refcount.
+	 */
+	kho_populate_refcount();
+
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
 	 * might set fields in deferred struct pages that have not yet been
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




