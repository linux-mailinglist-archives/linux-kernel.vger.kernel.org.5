Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00A077A21E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjHLUAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjHLUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8F2D5B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:59:45 -0700 (PDT)
Message-ID: <20230812195727.719202319@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ggxYi+OZBvt+3ot3vhQxZ5PJuR5IZeB1koCPjiEIzL0=;
        b=SabdeBlyiFCniJKKuHlwAfi9r84M8G2kZh3SCHGFPWIjDU0CTpM1PzJmZs/Zp+xlXsn56G
        Q3zm2indR+18Ui6jdT2w+oAJA3Yv9XxZaV3LF7aOAdckUIQC7+ISB2oUDFzrG9+EQ2Zovk
        QQKH3dQ/1BjwoL/l/8HwE5p8QWRZ3R8oE3J3RjAPIb6ISxO14896uKIh/EQ+tcs/nRFjFN
        VWlf3cSDFZaPRbb/wbRlDVeq90fmRItApjmgHgxdFin8YAwag4d3KuyK+UZHBQWmvGlaNC
        286q3GsqYZLWdsHDftV1Hij5iCUnnjrQ87RZlcLqojECtOtnH+mpnvk1gPN8aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ggxYi+OZBvt+3ot3vhQxZ5PJuR5IZeB1koCPjiEIzL0=;
        b=ya/M02C6qqyLvjgaAHACXIFm/lGyN7D3E+M0iMUto8N1Vc/5j99SIqJhOAIUKDKfoYdDh3
        a1oMPgD+H7NERWCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 03/37] x86/microcode/intel: Move microcode functions out of
 cpu/intel.c
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:41 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is really no point to have that in the CPUID evaluation code. Move it
into the intel specific microcode handling along with the datastructures,
defines and helpers required by it. The exports need to stay for IFS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move the structs, defines and helpers into intel.c
---
 arch/x86/include/asm/microcode_intel.h |   28 ----
 arch/x86/kernel/cpu/intel.c            |  174 ----------------------------
 arch/x86/kernel/cpu/microcode/intel.c  |  202 +++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 200 deletions(-)

--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -23,39 +23,15 @@ struct microcode_intel {
 	unsigned int            bits[];
 };
 
-/* microcode format is extended from prescott processors */
-struct extended_signature {
-	unsigned int            sig;
-	unsigned int            pf;
-	unsigned int            cksum;
-};
-
-struct extended_sigtable {
-	unsigned int            count;
-	unsigned int            cksum;
-	unsigned int            reserved[3];
-	struct extended_signature sigs[];
-};
-
-#define DEFAULT_UCODE_DATASIZE	(2000)
-#define MC_HEADER_SIZE		(sizeof(struct microcode_header_intel))
-#define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
-#define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
-#define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
+#define MC_HEADER_SIZE			(sizeof(struct microcode_header_intel))
 #define MC_HEADER_TYPE_MICROCODE	1
 #define MC_HEADER_TYPE_IFS		2
-
-#define get_totalsize(mc) \
-	(((struct microcode_intel *)mc)->hdr.datasize ? \
-	 ((struct microcode_intel *)mc)->hdr.totalsize : \
-	 DEFAULT_UCODE_TOTALSIZE)
+#define DEFAULT_UCODE_DATASIZE		(2000)
 
 #define get_datasize(mc) \
 	(((struct microcode_intel *)mc)->hdr.datasize ? \
 	 ((struct microcode_intel *)mc)->hdr.datasize : DEFAULT_UCODE_DATASIZE)
 
-#define exttable_size(et) ((et)->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE)
-
 static inline u32 intel_get_microcode_revision(void)
 {
 	u32 rev, dummy;
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -184,180 +184,6 @@ static bool bad_spectre_microcode(struct
 	return false;
 }
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci)
-{
-	unsigned int val[2];
-	unsigned int family, model;
-	struct cpu_signature csig = { 0 };
-	unsigned int eax, ebx, ecx, edx;
-
-	memset(uci, 0, sizeof(*uci));
-
-	eax = 0x00000001;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	csig.sig = eax;
-
-	family = x86_family(eax);
-	model  = x86_model(eax);
-
-	if (model >= 5 || family > 6) {
-		/* get processor flags from MSR 0x17 */
-		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig.pf = 1 << ((val[1] >> 18) & 7);
-	}
-
-	csig.rev = intel_get_microcode_revision();
-
-	uci->cpu_sig = csig;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_cpu_collect_info);
-
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
-int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
-{
-	struct microcode_header_intel *mc_hdr = mc;
-	struct extended_sigtable *ext_hdr;
-	struct extended_signature *ext_sig;
-	int i;
-
-	if (intel_cpu_signatures_match(csig, cpf, mc_hdr->sig, mc_hdr->pf))
-		return 1;
-
-	/* Look for ext. headers: */
-	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
-		return 0;
-
-	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
-	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
-
-	for (i = 0; i < ext_hdr->count; i++) {
-		if (intel_cpu_signatures_match(csig, cpf, ext_sig->sig, ext_sig->pf))
-			return 1;
-		ext_sig++;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_find_matching_signature);
-
-/**
- * intel_microcode_sanity_check() - Sanity check microcode file.
- * @mc: Pointer to the microcode file contents.
- * @print_err: Display failure reason if true, silent if false.
- * @hdr_type: Type of file, i.e. normal microcode file or In Field Scan file.
- *            Validate if the microcode header type matches with the type
- *            specified here.
- *
- * Validate certain header fields and verify if computed checksum matches
- * with the one specified in the header.
- *
- * Return: 0 if the file passes all the checks, -EINVAL if any of the checks
- * fail.
- */
-int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
-{
-	unsigned long total_size, data_size, ext_table_size;
-	struct microcode_header_intel *mc_header = mc;
-	struct extended_sigtable *ext_header = NULL;
-	u32 sum, orig_sum, ext_sigcount = 0, i;
-	struct extended_signature *ext_sig;
-
-	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
-
-	if (data_size + MC_HEADER_SIZE > total_size) {
-		if (print_err)
-			pr_err("Error: bad microcode data file size.\n");
-		return -EINVAL;
-	}
-
-	if (mc_header->ldrver != 1 || mc_header->hdrver != hdr_type) {
-		if (print_err)
-			pr_err("Error: invalid/unknown microcode update format. Header type %d\n",
-			       mc_header->hdrver);
-		return -EINVAL;
-	}
-
-	ext_table_size = total_size - (MC_HEADER_SIZE + data_size);
-	if (ext_table_size) {
-		u32 ext_table_sum = 0;
-		u32 *ext_tablep;
-
-		if (ext_table_size < EXT_HEADER_SIZE ||
-		    ((ext_table_size - EXT_HEADER_SIZE) % EXT_SIGNATURE_SIZE)) {
-			if (print_err)
-				pr_err("Error: truncated extended signature table.\n");
-			return -EINVAL;
-		}
-
-		ext_header = mc + MC_HEADER_SIZE + data_size;
-		if (ext_table_size != exttable_size(ext_header)) {
-			if (print_err)
-				pr_err("Error: extended signature table size mismatch.\n");
-			return -EFAULT;
-		}
-
-		ext_sigcount = ext_header->count;
-
-		/*
-		 * Check extended table checksum: the sum of all dwords that
-		 * comprise a valid table must be 0.
-		 */
-		ext_tablep = (u32 *)ext_header;
-
-		i = ext_table_size / sizeof(u32);
-		while (i--)
-			ext_table_sum += ext_tablep[i];
-
-		if (ext_table_sum) {
-			if (print_err)
-				pr_warn("Bad extended signature table checksum, aborting.\n");
-			return -EINVAL;
-		}
-	}
-
-	/*
-	 * Calculate the checksum of update data and header. The checksum of
-	 * valid update data and header including the extended signature table
-	 * must be 0.
-	 */
-	orig_sum = 0;
-	i = (MC_HEADER_SIZE + data_size) / sizeof(u32);
-	while (i--)
-		orig_sum += ((u32 *)mc)[i];
-
-	if (orig_sum) {
-		if (print_err)
-			pr_err("Bad microcode data checksum, aborting.\n");
-		return -EINVAL;
-	}
-
-	if (!ext_table_size)
-		return 0;
-
-	/*
-	 * Check extended signature checksum: 0 => valid.
-	 */
-	for (i = 0; i < ext_sigcount; i++) {
-		ext_sig = (void *)ext_header + EXT_HEADER_SIZE +
-			  EXT_SIGNATURE_SIZE * i;
-
-		sum = (mc_header->sig + mc_header->pf + mc_header->cksum) -
-		      (ext_sig->sig + ext_sig->pf + ext_sig->cksum);
-		if (sum) {
-			if (print_err)
-				pr_err("Bad extended signature checksum, aborting.\n");
-			return -EINVAL;
-		}
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
-
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -45,6 +45,208 @@ static struct microcode_intel *intel_uco
 /* last level cache size per core */
 static int llc_size_per_core;
 
+/* microcode format is extended from prescott processors */
+struct extended_signature {
+	unsigned int	sig;
+	unsigned int	pf;
+	unsigned int	cksum;
+};
+
+struct extended_sigtable {
+	unsigned int			count;
+	unsigned int			cksum;
+	unsigned int			reserved[3];
+	struct extended_signature	sigs[];
+};
+
+#define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
+#define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
+#define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
+
+static inline unsigned int get_totalsize(struct microcode_header_intel *hdr)
+{
+	return hdr->datasize ? : DEFAULT_UCODE_TOTALSIZE;
+}
+
+static inline unsigned int exttable_size(struct extended_sigtable *et)
+{
+	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
+}
+
+int intel_cpu_collect_info(struct ucode_cpu_info *uci)
+{
+	unsigned int val[2];
+	unsigned int family, model;
+	struct cpu_signature csig = { 0 };
+	unsigned int eax, ebx, ecx, edx;
+
+	memset(uci, 0, sizeof(*uci));
+
+	eax = 0x00000001;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	csig.sig = eax;
+
+	family = x86_family(eax);
+	model  = x86_model(eax);
+
+	if (model >= 5 || family > 6) {
+		/* get processor flags from MSR 0x17 */
+		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
+		csig.pf = 1 << ((val[1] >> 18) & 7);
+	}
+
+	csig.rev = intel_get_microcode_revision();
+
+	uci->cpu_sig = csig;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_cpu_collect_info);
+
+/*
+ * Returns 1 if update has been found, 0 otherwise.
+ */
+int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
+{
+	struct microcode_header_intel *mc_hdr = mc;
+	struct extended_sigtable *ext_hdr;
+	struct extended_signature *ext_sig;
+	int i;
+
+	if (intel_cpu_signatures_match(csig, cpf, mc_hdr->sig, mc_hdr->pf))
+		return 1;
+
+	/* Look for ext. headers: */
+	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
+		return 0;
+
+	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
+	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
+
+	for (i = 0; i < ext_hdr->count; i++) {
+		if (intel_cpu_signatures_match(csig, cpf, ext_sig->sig, ext_sig->pf))
+			return 1;
+		ext_sig++;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_find_matching_signature);
+
+/**
+ * intel_microcode_sanity_check() - Sanity check microcode file.
+ * @mc: Pointer to the microcode file contents.
+ * @print_err: Display failure reason if true, silent if false.
+ * @hdr_type: Type of file, i.e. normal microcode file or In Field Scan file.
+ *            Validate if the microcode header type matches with the type
+ *            specified here.
+ *
+ * Validate certain header fields and verify if computed checksum matches
+ * with the one specified in the header.
+ *
+ * Return: 0 if the file passes all the checks, -EINVAL if any of the checks
+ * fail.
+ */
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
+{
+	unsigned long total_size, data_size, ext_table_size;
+	struct microcode_header_intel *mc_header = mc;
+	struct extended_sigtable *ext_header = NULL;
+	u32 sum, orig_sum, ext_sigcount = 0, i;
+	struct extended_signature *ext_sig;
+
+	total_size = get_totalsize(mc_header);
+	data_size = get_datasize(mc_header);
+
+	if (data_size + MC_HEADER_SIZE > total_size) {
+		if (print_err)
+			pr_err("Error: bad microcode data file size.\n");
+		return -EINVAL;
+	}
+
+	if (mc_header->ldrver != 1 || mc_header->hdrver != hdr_type) {
+		if (print_err)
+			pr_err("Error: invalid/unknown microcode update format. Header type %d\n",
+			       mc_header->hdrver);
+		return -EINVAL;
+	}
+
+	ext_table_size = total_size - (MC_HEADER_SIZE + data_size);
+	if (ext_table_size) {
+		u32 ext_table_sum = 0;
+		u32 *ext_tablep;
+
+		if (ext_table_size < EXT_HEADER_SIZE ||
+		    ((ext_table_size - EXT_HEADER_SIZE) % EXT_SIGNATURE_SIZE)) {
+			if (print_err)
+				pr_err("Error: truncated extended signature table.\n");
+			return -EINVAL;
+		}
+
+		ext_header = mc + MC_HEADER_SIZE + data_size;
+		if (ext_table_size != exttable_size(ext_header)) {
+			if (print_err)
+				pr_err("Error: extended signature table size mismatch.\n");
+			return -EFAULT;
+		}
+
+		ext_sigcount = ext_header->count;
+
+		/*
+		 * Check extended table checksum: the sum of all dwords that
+		 * comprise a valid table must be 0.
+		 */
+		ext_tablep = (u32 *)ext_header;
+
+		i = ext_table_size / sizeof(u32);
+		while (i--)
+			ext_table_sum += ext_tablep[i];
+
+		if (ext_table_sum) {
+			if (print_err)
+				pr_warn("Bad extended signature table checksum, aborting.\n");
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Calculate the checksum of update data and header. The checksum of
+	 * valid update data and header including the extended signature table
+	 * must be 0.
+	 */
+	orig_sum = 0;
+	i = (MC_HEADER_SIZE + data_size) / sizeof(u32);
+	while (i--)
+		orig_sum += ((u32 *)mc)[i];
+
+	if (orig_sum) {
+		if (print_err)
+			pr_err("Bad microcode data checksum, aborting.\n");
+		return -EINVAL;
+	}
+
+	if (!ext_table_size)
+		return 0;
+
+	/*
+	 * Check extended signature checksum: 0 => valid.
+	 */
+	for (i = 0; i < ext_sigcount; i++) {
+		ext_sig = (void *)ext_header + EXT_HEADER_SIZE +
+			  EXT_SIGNATURE_SIZE * i;
+
+		sum = (mc_header->sig + mc_header->pf + mc_header->cksum) -
+		      (ext_sig->sig + ext_sig->pf + ext_sig->cksum);
+		if (sum) {
+			if (print_err)
+				pr_err("Bad extended signature checksum, aborting.\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
+
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */

