Return-Path: <linux-kernel+bounces-57678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63084DC1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE86B1C243CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8086E2DC;
	Thu,  8 Feb 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQWyBQi5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C106DCE7;
	Thu,  8 Feb 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382428; cv=none; b=FwXfTW6r+kv9iqLSYgXKo/WzyuwYl0c5MvkYShr0Yvk86SOOBAzrwdnokNqYavvm8EabAJjuvuag40s3+Wxlu6GTUeQC1KV3rvza84fJSo7I5SsKN8tux8idnK7l2MdBXskz/O5Z7eV2bmEs8xslIea/cba39XET448z8LSIokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382428; c=relaxed/simple;
	bh=2bjtfbzdJTQ7+Qlt6V6ZtgveJ+Fx8SxEWOXXM8bfX8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/X3boPhoh2Cl3mbE8gK3yLXHwSzPa6r3KnoT2S07Nmx7+Y2lsS0N6zoGnDGS7VOl2DUPOGzTJgylfTrdDlcoBF0SWwUo5vv820FWqbQYANrks760UMhr4PMe9BZ0QNvA5zPikTsta+4Dg+oFJM7PwFo3SENjH4sYQbtfdX6vDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQWyBQi5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382426; x=1738918426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bjtfbzdJTQ7+Qlt6V6ZtgveJ+Fx8SxEWOXXM8bfX8Q=;
  b=cQWyBQi5kCLEt0WoQqU6pEkrfHCm75oY+qMesNe0uWHfaCUCJb6RMo0G
   MK42how321IwvVdEIQIqXq59/BNPiXIwDOxosrf06zXMJrW6QKABXHr4V
   aqxbUSrty9cG1cK6jLwGyJIvoCGlNvn4G2qwNiqoTTwvJ0W3aAGrWkJdX
   SWOhsymwkzUjo0C5Bt6oEM2J22QBcTydDuHPvIOlCp9TC22be/11DN9+9
   yp+neikhj6g0CCj1sucEyIlJt7FSaeXES+5sid5FVX9aKwhS8sagu/9TI
   HlOFcSNQsT/8uo79O4UGS/MPaA3BaotKCHY3DpuDjm9fxIfCHy8xT7ONf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1329216"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1329216"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1589498"
Received: from lnielsex-mobl.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:42 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V3 2/2] perf symbols: Slightly improve module file executable section mappings
Date: Thu,  8 Feb 2024 10:53:26 +0200
Message-Id: <20240208085326.13432-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208085326.13432-1-adrian.hunter@intel.com>
References: <20240208085326.13432-1-adrian.hunter@intel.com>
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
index 4b934ed3bfd1..95773c32796d 100644
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
@@ -1424,6 +1478,17 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
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
@@ -1497,6 +1562,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	Elf *elf;
 	int nr = 0;
 	bool remap_kernel = false, adjust_kernel_syms = false;
+	u64 max_text_sh_offset = 0;
 
 	if (kmap && !kmaps)
 		return -1;
@@ -1584,6 +1650,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
@@ -1673,7 +1743,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
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


