Return-Path: <linux-kernel+bounces-54989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3431584B5EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ABA1F26C01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCD13172E;
	Tue,  6 Feb 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGSn1DpT"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFE130AFC;
	Tue,  6 Feb 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224719; cv=none; b=slZe4I6LALdCB19dVG0VoB6LzA6Jvn531rAa+x43yXhySk/VWklkkIHhOSEbNZyC7aei2k/mWivThpLPmOhDDqF8VmW/W7XMTJ9fcAc+2pHziF7qwIbhP1IHbvZG/TWEmx1gSoc6xX69WJ67gYoXwvmx0eUSnYzTUr1lIb+WiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224719; c=relaxed/simple;
	bh=dc2O85R1+54lcZQTbhpdideOJEc3GjHDCDPyDd2m00A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LE8IYB6T1SPHiUUHR2cWL3Z4B65hxuNfYX9oizjcDK7v+QvAeLfu8eK9k6+6R8AdaIJwcNSx6RM5ofeqflxIFlkPXE1VngvHs9nYzFtiWOg43QTO8weAn5FA5bdbygy482ua9DAcxGrbvkjeTwcOgLcj4Ah/FvcZLuuRC2Q6Lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGSn1DpT; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707224717; x=1738760717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dc2O85R1+54lcZQTbhpdideOJEc3GjHDCDPyDd2m00A=;
  b=lGSn1DpT0a7XHH7001oB/ys3DBjRD1lEUNxhGb3FFokw2Ydkz8xTvnHc
   i2xzTkALJRvImf3t4pAz2X8gTNLWk0ANvWhyBGy7Ee9k+IiyipbHCavlM
   E8Q2D60COgPKvQVyr/ALeu9MPX+ZfbtzWVrJY0+Yf8CpcjP5loe+W+DMm
   RaNGdC89iQ5LTZeFW86oPaLGCpIaNQe+0+dSBmEXJJEiTuyceCeu+Eb+6
   7cr5vJG0hBPCDPxOZ8U/LwCMgs8DWQKjSOyBIpGIcDmUHAx0jJ4KfN3CU
   /iLf7FQSGpGtaV/FKm/AHKt5ZqYxk52OSKKf4O5OsCeqevZhFzyCRLEKs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="395161873"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="395161873"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="999425"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:05:15 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V2 2/2] perf symbols: Slightly improve module file executable section mappings
Date: Tue,  6 Feb 2024 15:04:58 +0200
Message-Id: <20240206130458.8867-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206130458.8867-1-adrian.hunter@intel.com>
References: <20240206130458.8867-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Currently perf does not record module section addresses except for
the .text section. In general that means perf cannot get module section
mappings correct (except for .text) when loading symbols from a kernel
module file. (Note using --kcore does not have this issue)

Improve that situation slightly by identifying executable sections that
use the same mapping as the .text section. That happens when an
executable section comes directly after the .text section, both in memory
and on file, something that can be determined by following the same layout
rules used by the kernel, refer kernel layout_sections(). Note whether
that happens is somewhat arbitrary, so this is not a final solution.

Example from tracing a virtual machine process:

 Before:

  $ perf script | grep unknown
         CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  ffffffffc13e8a70 [unknown] (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko)
  $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.text\|ffff'
  Map: 0-7e0 41430 [kvm_intel].noinstr.text
  Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko

 After:

  $ perf script | grep 203.511270
         CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  ffffffffc13e8a70 vmx_vmexit+0x0 (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko)
  $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.text\|ffff'
  Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko

Reported-by: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 75 +++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e7eeaf616b8..98bf0881aaf6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
+#include <linux/string.h>
 #include <symbol/kallsyms.h>
 #include <internal/lib.h>
 
@@ -1329,6 +1330,58 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	return -1;
 }
 
+static bool is_exe_text(int flags)
+{
+	return (flags & (SHF_ALLOC | SHF_EXECINSTR)) == (SHF_ALLOC | SHF_EXECINSTR);
+}
+
+/*
+ * Some executable module sections like .noinstr.text might be laid out with
+ * .text so they can use the same mapping (memory address to file offset).
+ * Check if that is the case. Refer to kernel layout_sections(). Return the
+ * maximum offset.
+ */
+static u64 max_text_section(Elf *elf, GElf_Ehdr *ehdr)
+{
+	Elf_Scn *sec = NULL;
+	GElf_Shdr shdr;
+	u64 offs = 0;
+
+	/* Doesn't work for some arch */
+	if (ehdr->e_machine == EM_PARISC ||
+	    ehdr->e_machine == EM_ALPHA)
+		return 0;
+
+	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
+	if (!elf_rawdata(elf_getscn(elf, ehdr->e_shstrndx), NULL))
+		return 0;
+
+	while ((sec = elf_nextscn(elf, sec)) != NULL) {
+		char *sec_name;
+
+		if (!gelf_getshdr(sec, &shdr))
+			break;
+
+		if (!is_exe_text(shdr.sh_flags))
+			continue;
+
+		/* .init and .exit sections are not placed with .text */
+		sec_name = elf_strptr(elf, ehdr->e_shstrndx, shdr.sh_name);
+		if (!sec_name ||
+		    strstarts(sec_name, ".init") ||
+		    strstarts(sec_name, ".exit"))
+			break;
+
+		/* Must be next to previous, assumes .text is first */
+		if (offs && PERF_ALIGN(offs, shdr.sh_addralign ?: 1) != shdr.sh_offset)
+			break;
+
+		offs = shdr.sh_offset + shdr.sh_size;
+	}
+
+	return offs;
+}
+
 /**
  * ref_reloc_sym_not_found - has kernel relocation symbol been found.
  * @kmap: kernel maps and relocation reference symbol
@@ -1368,7 +1421,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      struct maps *kmaps, struct kmap *kmap,
 				      struct dso **curr_dsop, struct map **curr_mapp,
 				      const char *section_name,
-				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
+				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel,
+				      u64 max_text_sh_offset)
 {
 	struct dso *curr_dso = *curr_dsop;
 	struct map *curr_map;
@@ -1425,6 +1479,17 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	if (!kmap)
 		return 0;
 
+	/*
+	 * perf does not record module section addresses except for .text, but
+	 * some sections can use the same mapping as .text.
+	 */
+	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
+	    shdr->sh_offset <= max_text_sh_offset) {
+		*curr_mapp = map;
+		*curr_dsop = dso;
+		return 0;
+	}
+
 	snprintf(dso_name, sizeof(dso_name), "%s%s", dso->short_name, section_name);
 
 	curr_map = maps__find_by_name(kmaps, dso_name);
@@ -1499,6 +1564,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	Elf *elf;
 	int nr = 0;
 	bool remap_kernel = false, adjust_kernel_syms = false;
+	u64 max_text_sh_offset = 0;
 
 	if (kmap && !kmaps)
 		return -1;
@@ -1586,6 +1652,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		remap_kernel = true;
 		adjust_kernel_syms = dso->adjust_symbols;
 	}
+
+	if (kmodule && adjust_kernel_syms)
+		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
+
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1675,7 +1745,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		if (dso->kernel) {
 			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
-						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
+						       section_name, adjust_kernel_syms, kmodule,
+						       &remap_kernel, max_text_sh_offset))
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
-- 
2.34.1


