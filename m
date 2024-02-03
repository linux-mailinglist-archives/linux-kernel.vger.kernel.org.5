Return-Path: <linux-kernel+bounces-50813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C558F847E3F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435C91F25551
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646B6FCA;
	Sat,  3 Feb 2024 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR4EZgOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC66FB2;
	Sat,  3 Feb 2024 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924692; cv=none; b=UKJD9AfpusPJT6RrvXioR/WJRjTLVOQu4fN8dWV2j2FI9cqD/moeV8YwCbO+zdQ8YPVbiHf5N3H+gXJS/eaMf6etSS6RDrSabHb2OiG8JcHQ0A61pfqNHcyYXGgk751WgoLweKd/rq6Z9vx0ZqGLYYd/84wG/0sx03pRS5/Hvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924692; c=relaxed/simple;
	bh=1rXlYR6MQbjdkUidMNQ2ZgJBtfTvxRl63t/1sfRVxZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSaBPp/EsQX1lEINn/Ut8fGspnp4gJPSeUmSXtpknk2NK8f1h1x9f7EIrglhB5GA1UGBQMqGyfaTfkw5X2Y1RqJB7ToIs4DH4yHvtO3XqfjGlYWjyn9BYPFM0/RTZSOM2otQ41Zl6r1UQRO2co4xiGfZx5sPj4Z6ei1URJ2OUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR4EZgOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D6C433C7;
	Sat,  3 Feb 2024 01:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706924692;
	bh=1rXlYR6MQbjdkUidMNQ2ZgJBtfTvxRl63t/1sfRVxZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BR4EZgOlZlFlR2NaBlozaqPIczL7GyiupaHzVKLuDdSSgHyVeIZloPRGBauI+QwZl
	 5HfHdnYPugfFYHP6P0TAUaVJAcI1vPM5nbzP5sDW9I2ZLH7Az8amnU0ClT7My1P+kj
	 OVXNHe+HD1ktLLM4xru3VDg2M9kG3rP41B6va67EDikTRMoSphkhP04xtgxm22/1eU
	 qq+EpbPBp4St74XfQcfkRoiTryVgWJO74RZ2kfHKY7aFVZ3o0ujOnhXOtedQ6uAEa4
	 DJXf3X1xbKRiW7iUWlNfLh7f8r552n0AoQCt4BLHRg/IJE2gmlljtuzJM7XbNh6S3R
	 srDyhj2/LODaQ==
Date: Fri, 2 Feb 2024 17:44:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf symbols: Slightly improve module file
 executable section mappings
Message-ID: <Zb2akm1MGCv84T-7@google.com>
References: <20240202110130.3553-1-adrian.hunter@intel.com>
 <20240202110130.3553-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202110130.3553-3-adrian.hunter@intel.com>

Hi Adrian,

On Fri, Feb 02, 2024 at 01:01:30PM +0200, Adrian Hunter wrote:
> Currently perf does not record module section addresses except for
> the .text section. In general that means perf cannot get module section
> mappings correct (except for .text) when loading symbols from a kernel
> module file. (Note using --kcore does not have this issue)
> 
> Improve that situation slightly by identifying executable sections that
> use the same mapping as the .text section. That happens when an
> executable section comes directly after the .text section, both in memory
> and on file, something that can be determined by following the same layout
> rules used by the kernel, refer kernel layout_sections(). Note whether
> that happens is somewhat arbitrary, so this is not a final solution.
> 
> Example from tracing a virtual machine process:
> 
>  Before:
> 
>   $ perf script | grep unknown
>          CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  ffffffffc13e8a70 [unknown] (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko)
>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.text\|ffff'
>   Map: 0-7e0 41430 [kvm_intel].noinstr.text
>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
> 
>  After:
> 
>   $ perf script | grep 203.511270
>          CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  ffffffffc13e8a70 vmx_vmexit+0x0 (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko)
>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.text\|ffff'
>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
> 
> Reported-by: Like Xu <like.xu.linux@gmail.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/symbol-elf.c | 75 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 9e7eeaf616b8..98bf0881aaf6 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -23,6 +23,7 @@
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
> +#include <linux/string.h>
>  #include <symbol/kallsyms.h>
>  #include <internal/lib.h>
>  
> @@ -1329,6 +1330,58 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>  	return -1;
>  }
>  
> +static bool is_exe_text(int flags)
> +{
> +	return (flags & (SHF_ALLOC | SHF_EXECINSTR)) == (SHF_ALLOC | SHF_EXECINSTR);
> +}
> +
> +/*
> + * Some executable module sections like .noinstr.text might be laid out with
> + * .text so they can use the same mapping (memory address to file offset).
> + * Check if that is the case. Refer to kernel layout_sections(). Return the
> + * maximum offset.
> + */
> +static u64 max_text_section(Elf *elf, GElf_Ehdr *ehdr)
> +{
> +	Elf_Scn *sec = NULL;
> +	GElf_Shdr shdr;
> +	u64 offs = 0;
> +
> +	/* Doesn't work for some arch */
> +	if (ehdr->e_machine == EM_PARISC ||
> +	    ehdr->e_machine == EM_ALPHA)
> +		return 0;
> +
> +	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
> +	if (!elf_rawdata(elf_getscn(elf, ehdr->e_shstrndx), NULL))
> +		return 0;
> +
> +	while ((sec = elf_nextscn(elf, sec)) != NULL) {
> +		char *sec_name;
> +
> +		if (!gelf_getshdr(sec, &shdr))
> +			break;
> +
> +		if (!is_exe_text(shdr.sh_flags))
> +			continue;
> +
> +		/* .init and .exit sections are not placed with .text */
> +		sec_name = elf_strptr(elf, ehdr->e_shstrndx, shdr.sh_name);
> +		if (!sec_name ||
> +		    strstarts(sec_name, ".init") ||
> +		    strstarts(sec_name, ".exit"))
> +			break;

Do we really need this?  It seems my module has .init.text section
next to .text.

  $ readelf -SW /lib/modules/`uname -r`/kernel/fs/ext4/ext4.ko
  There are 77 section headers, starting at offset 0x252e90:
  
  Section Headers:
    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
    [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
    [ 1] .text             PROGBITS        0000000000000000 000040 079fa7 00  AX  0   0 16
    [ 2] .rela.text        RELA            0000000000000000 13c348 04f0c8 18   I 74   1  8
    [ 3] .init.text        PROGBITS        0000000000000000 079ff0 00060c 00  AX  0   0 16
    ...


ALIGN(0x40 + 0x79fa7, 16) = 0x79ff0, right?

Thanks,
Namhyung

> +
> +		/* Must be next to previous, assumes .text is first */
> +		if (offs && PERF_ALIGN(offs, shdr.sh_addralign ?: 1) != shdr.sh_offset)
> +			break;
> +
> +		offs = shdr.sh_offset + shdr.sh_size;
> +	}
> +
> +	return offs;
> +}
> +
>  /**
>   * ref_reloc_sym_not_found - has kernel relocation symbol been found.
>   * @kmap: kernel maps and relocation reference symbol
> @@ -1368,7 +1421,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  				      struct maps *kmaps, struct kmap *kmap,
>  				      struct dso **curr_dsop, struct map **curr_mapp,
>  				      const char *section_name,
> -				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
> +				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel,
> +				      u64 max_text_sh_offset)
>  {
>  	struct dso *curr_dso = *curr_dsop;
>  	struct map *curr_map;
> @@ -1425,6 +1479,17 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  	if (!kmap)
>  		return 0;
>  
> +	/*
> +	 * perf does not record module section addresses except for .text, but
> +	 * some sections can use the same mapping as .text.
> +	 */
> +	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
> +	    shdr->sh_offset <= max_text_sh_offset) {
> +		*curr_mapp = map;
> +		*curr_dsop = dso;
> +		return 0;
> +	}
> +
>  	snprintf(dso_name, sizeof(dso_name), "%s%s", dso->short_name, section_name);
>  
>  	curr_map = maps__find_by_name(kmaps, dso_name);
> @@ -1499,6 +1564,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	Elf *elf;
>  	int nr = 0;
>  	bool remap_kernel = false, adjust_kernel_syms = false;
> +	u64 max_text_sh_offset = 0;
>  
>  	if (kmap && !kmaps)
>  		return -1;
> @@ -1586,6 +1652,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		remap_kernel = true;
>  		adjust_kernel_syms = dso->adjust_symbols;
>  	}
> +
> +	if (kmodule && adjust_kernel_syms)
> +		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
> +
>  	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
>  		struct symbol *f;
>  		const char *elf_name = elf_sym__name(&sym, symstrs);
> @@ -1675,7 +1745,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  
>  		if (dso->kernel) {
>  			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
> -						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
> +						       section_name, adjust_kernel_syms, kmodule,
> +						       &remap_kernel, max_text_sh_offset))
>  				goto out_elf_end;
>  		} else if ((used_opd && runtime_ss->adjust_symbols) ||
>  			   (!used_opd && syms_ss->adjust_symbols)) {
> -- 
> 2.34.1
> 

