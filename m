Return-Path: <linux-kernel+bounces-10033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7641F81CEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3C285306
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112272E85D;
	Fri, 22 Dec 2023 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FpTY+Jnc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0E2E852;
	Fri, 22 Dec 2023 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274726; x=1734810726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hs41nrvxXplJ/QyH6HSlHLbtIDrbQgqX7R8fKuobQ4=;
  b=FpTY+JncvKUMGpT3NEOCuAe1G/cDQPVuSZP9i+MA045BnRtU1f14Cih7
   eq08fHxftbCHCUgGh7GjJxtlWryTpdrO/vPgQ3MRC373hQrKrS3In3UxB
   jomGYNgKiVmh+VWsjZWNeFs6OfHhjl9qigS6wav+57CDjirXaujIgAa2b
   o=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="174097104"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:52:05 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 19E84808C4;
	Fri, 22 Dec 2023 19:51:57 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:38232]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.72:2525] with esmtp (Farcaster)
 id 11d71bf8-2bc3-45a5-aa9e-d1953eed09b2; Fri, 22 Dec 2023 19:51:57 +0000 (UTC)
X-Farcaster-Flow-ID: 11d71bf8-2bc3-45a5-aa9e-d1953eed09b2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:51:57 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:51:53 +0000
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
Subject: [PATCH v2 08/17] arm64: Add KHO support
Date: Fri, 22 Dec 2023 19:51:35 +0000
Message-ID: <20231222195144.24532-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222195144.24532-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We now have all bits in place to support KHO kexecs. This patch adds
awareness of KHO in the kexec file as well as boot path for arm64 and
adds the respective kconfig option to the architecture so that it can
use KHO successfully.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - test bot warning fix
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Remove / reduce ifdefs for kho fdt code
---
 arch/arm64/Kconfig        |  3 +++
 arch/arm64/kernel/setup.c |  2 ++
 arch/arm64/mm/init.c      |  8 ++++++
 drivers/of/fdt.c          | 39 ++++++++++++++++++++++++++++
 drivers/of/kexec.c        | 54 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..4a2fd3deaa16 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1495,6 +1495,9 @@ config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
 config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_KHO
+	def_bool y
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..9aa05b84d202 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -346,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	kho_reserve_previous_mem();
+
 	acpi_table_upgrade();
 
 	/* Parse the ACPI tables for possible boot-time configuration */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..1a8fc91509af 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -358,6 +358,8 @@ void __init bootmem_init(void)
 	 */
 	arch_reserve_crashkernel();
 
+	kho_reserve_scratch();
+
 	memblock_dump_all();
 }
 
@@ -386,6 +388,12 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
+	/*
+	 * Now that all KHO pages are marked as reserved, let's flip them back
+	 * to normal pages with accurate refcount.
+	 */
+	kho_populate_refcount();
+
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
 	 * detected at build time already.
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..f9b9a36fb722 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1006,6 +1006,42 @@ void __init early_init_dt_check_for_usable_mem_range(void)
 		memblock_add(rgn[i].base, rgn[i].size);
 }
 
+/**
+ * early_init_dt_check_kho - Decode info required for kexec handover from DT
+ */
+static void __init early_init_dt_check_kho(void)
+{
+	unsigned long node = chosen_node_offset;
+	u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
+	const __be32 *p;
+	int l;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_KHO) || (long)node < 0)
+		return;
+
+	p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);
+	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+		return;
+
+	kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+
+	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
+	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+		return;
+
+	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
+
+	p = of_get_flat_dt_prop(node, "linux,kho-mem", &l);
+	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+		return;
+
+	mem_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+	mem_size = dt_mem_next_cell(dt_root_addr_cells, &p);
+
+	kho_populate(kho_start, scratch_start, scratch_size, mem_start, mem_size);
+}
+
 #ifdef CONFIG_SERIAL_EARLYCON
 
 int __init early_init_dt_scan_chosen_stdout(void)
@@ -1304,6 +1340,9 @@ void __init early_init_dt_scan_nodes(void)
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
+
+	/* Handle kexec handover */
+	early_init_dt_check_kho();
 }
 
 bool __init early_init_dt_scan(void *params)
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 68278340cecf..59070b09ad45 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -264,6 +264,55 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 }
 #endif /* CONFIG_IMA_KEXEC */
 
+static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node)
+{
+	void *dt = NULL;
+	phys_addr_t dt_mem = 0;
+	phys_addr_t dt_len = 0;
+	phys_addr_t scratch_mem = 0;
+	phys_addr_t scratch_len = 0;
+	void *mem_cache = NULL;
+	phys_addr_t mem_cache_mem = 0;
+	phys_addr_t mem_cache_len = 0;
+	int ret = 0;
+
+#ifdef CONFIG_KEXEC_KHO
+	dt = image->kho.dt.buffer;
+	dt_mem = image->kho.dt.mem;
+	dt_len = image->kho.dt.bufsz;
+
+	scratch_mem = kho_scratch_phys;
+	scratch_len = kho_scratch_len;
+
+	mem_cache = image->kho.mem_cache.buffer;
+	mem_cache_mem = image->kho.mem_cache.mem;
+	mem_cache_len = image->kho.mem_cache.bufsz;
+#endif
+
+	if (!dt || !mem_cache)
+		goto out;
+
+	pr_debug("Adding kho metadata to DT");
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-dt",
+				       dt_mem, dt_len);
+	if (ret)
+		goto out;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-scratch",
+				       scratch_mem, scratch_len);
+	if (ret)
+		goto out;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-mem",
+				       mem_cache_mem, mem_cache_len);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
 /*
  * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
  *
@@ -412,6 +461,11 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		}
 	}
 
+	/* Add kho metadata if this is a KHO image */
+	ret = kho_add_chosen(image, fdt, chosen_node);
+	if (ret)
+		goto out;
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




