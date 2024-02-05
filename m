Return-Path: <linux-kernel+bounces-52100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65C849416
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A5928187B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D2C8DE;
	Mon,  5 Feb 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atBip1CT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9A10A09;
	Mon,  5 Feb 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116292; cv=none; b=CFzDDa8em1CDlbcYlWXt3PqEazp1B6txOEKyFtTB9RaJkU9oj7NtbFFNa5VfzWp801jACXuYEX08PPyCzrT5u5bLypXtSKqdi6lUdT1wfbU2NK+Rw/iMm9MOcW/qhlm3XK8AaqgtmjTk71rZiGpkMYQaPj3axZi9I5rWxezbrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116292; c=relaxed/simple;
	bh=6Q6hd2SRiPtQucQdUaYCthhGjVgi2HUY2NFE6jWtXXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QynSiTfw3w/UWDFjTiY6Nf/1GB6n2zngm/wLhCxEoKoeUBHB2DatrDS49bxK9g6Z6/XqI3CIF/Wl2Hi4TT/PbSd4Bz0HxLc3PIqtp2KdcveUxfUgaEW9eKtTsbS+mAZ+k6eP2S5vPW1+E79R1mfxP5fjOr1VzGk7zBcJiBUoK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atBip1CT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707116291; x=1738652291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Q6hd2SRiPtQucQdUaYCthhGjVgi2HUY2NFE6jWtXXU=;
  b=atBip1CTmSa2WxTKdqIrWsDyAysQSKBtNUafVa82wzLOANUta/7bXMd3
   Xat0Dxmy7/mFMPYnEhv5ZQ/I92IzlvktVehLCd3PXnse/dPt/ZVyHNje+
   b+UdAWAjxOHTIzCvWY05I2b5HRT1A861SqAo2kiy9KbphQS542VWNX5Ws
   LCvI0bAe2xDu/2BNQepUKuS+BUzJwURfWG3e/wegv+u8aSh7krm+UoR2j
   pFfmeBqHG9swtvQ64gZsZ5OI82IogII/uQFfc0u1AL/Mqlw3HGUCIF+KD
   fy8dyCYW2rBCQj2osdaXAH2z1BWh5ZlzZ4zL8cyWlHzXbFx6tETTQ9tn/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="367946"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="367946"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="964423"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:58:08 -0800
Message-ID: <046baaea-217f-4ecc-b340-b5f6f1cee0b9@intel.com>
Date: Mon, 5 Feb 2024 08:58:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf symbols: Slightly improve module file executable
 section mappings
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Like Xu <like.xu.linux@gmail.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240202110130.3553-1-adrian.hunter@intel.com>
 <20240202110130.3553-3-adrian.hunter@intel.com> <Zb2akm1MGCv84T-7@google.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zb2akm1MGCv84T-7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/02/24 03:44, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Fri, Feb 02, 2024 at 01:01:30PM +0200, Adrian Hunter wrote:
>> Currently perf does not record module section addresses except for
>> the .text section. In general that means perf cannot get module section
>> mappings correct (except for .text) when loading symbols from a kernel
>> module file. (Note using --kcore does not have this issue)
>>
>> Improve that situation slightly by identifying executable sections that
>> use the same mapping as the .text section. That happens when an
>> executable section comes directly after the .text section, both in memory
>> and on file, something that can be determined by following the same layout
>> rules used by the kernel, refer kernel layout_sections(). Note whether
>> that happens is somewhat arbitrary, so this is not a final solution.
>>
>> Example from tracing a virtual machine process:
>>
>>  Before:
>>
>>   $ perf script | grep unknown
>>          CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  ffffffffc13e8a70 [unknown] (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko)
>>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.text\|ffff'
>>   Map: 0-7e0 41430 [kvm_intel].noinstr.text
>>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>>
>>  After:
>>
>>   $ perf script | grep 203.511270
>>          CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  ffffffffc13e8a70 vmx_vmexit+0x0 (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko)
>>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.text\|ffff'
>>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>>
>> Reported-by: Like Xu <like.xu.linux@gmail.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/symbol-elf.c | 75 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 9e7eeaf616b8..98bf0881aaf6 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/ctype.h>
>>  #include <linux/kernel.h>
>>  #include <linux/zalloc.h>
>> +#include <linux/string.h>
>>  #include <symbol/kallsyms.h>
>>  #include <internal/lib.h>
>>  
>> @@ -1329,6 +1330,58 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>>  	return -1;
>>  }
>>  
>> +static bool is_exe_text(int flags)
>> +{
>> +	return (flags & (SHF_ALLOC | SHF_EXECINSTR)) == (SHF_ALLOC | SHF_EXECINSTR);
>> +}
>> +
>> +/*
>> + * Some executable module sections like .noinstr.text might be laid out with
>> + * .text so they can use the same mapping (memory address to file offset).
>> + * Check if that is the case. Refer to kernel layout_sections(). Return the
>> + * maximum offset.
>> + */
>> +static u64 max_text_section(Elf *elf, GElf_Ehdr *ehdr)
>> +{
>> +	Elf_Scn *sec = NULL;
>> +	GElf_Shdr shdr;
>> +	u64 offs = 0;
>> +
>> +	/* Doesn't work for some arch */
>> +	if (ehdr->e_machine == EM_PARISC ||
>> +	    ehdr->e_machine == EM_ALPHA)
>> +		return 0;
>> +
>> +	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
>> +	if (!elf_rawdata(elf_getscn(elf, ehdr->e_shstrndx), NULL))
>> +		return 0;
>> +
>> +	while ((sec = elf_nextscn(elf, sec)) != NULL) {
>> +		char *sec_name;
>> +
>> +		if (!gelf_getshdr(sec, &shdr))
>> +			break;
>> +
>> +		if (!is_exe_text(shdr.sh_flags))
>> +			continue;
>> +
>> +		/* .init and .exit sections are not placed with .text */
>> +		sec_name = elf_strptr(elf, ehdr->e_shstrndx, shdr.sh_name);
>> +		if (!sec_name ||
>> +		    strstarts(sec_name, ".init") ||
>> +		    strstarts(sec_name, ".exit"))
>> +			break;
> 
> Do we really need this?  It seems my module has .init.text section
> next to .text.
> 
>   $ readelf -SW /lib/modules/`uname -r`/kernel/fs/ext4/ext4.ko
>   There are 77 section headers, starting at offset 0x252e90:
>   
>   Section Headers:
>     [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>     [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
>     [ 1] .text             PROGBITS        0000000000000000 000040 079fa7 00  AX  0   0 16
>     [ 2] .rela.text        RELA            0000000000000000 13c348 04f0c8 18   I 74   1  8
>     [ 3] .init.text        PROGBITS        0000000000000000 079ff0 00060c 00  AX  0   0 16
>     ...
> 
> 
> ALIGN(0x40 + 0x79fa7, 16) = 0x79ff0, right?

But not in memory e.g.

Section Headers:
  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 3] .text             PROGBITS        0000000000000000 0000a0 071719 00  AX  0   0 16
  [ 5] .text.unlikely    PROGBITS        0000000000000000 0717b9 000a59 00  AX  0   0  1
  [ 7] .init.text        PROGBITS        0000000000000000 072212 0004fe 00  AX  0   0  1
  [ 9] .altinstr_replacement PROGBITS    0000000000000000 072710 000004 00  AX  0   0  1
  [10] .static_call.text PROGBITS        0000000000000000 072714 000388 00  AX  0   0  4
  [12] .exit.text        PROGBITS        0000000000000000 072a9c 000078 00  AX  0   0  1


/sys/module/ext4/sections/.text:                 0xffffffffc0453000
/sys/module/ext4/sections/.text.unlikely:        0xffffffffc04c4719
/sys/module/ext4/sections/.init.text:            0xffffffffc053e000
/sys/module/ext4/sections/.altinstr_replacement: 0xffffffffc04c5172
/sys/module/ext4/sections/.static_call.text:     0xffffffffc04c5178
/sys/module/ext4/sections/.exit.text:            0xffffffffc04c5500

Need to have:

	section address - offset == .text address - .text offset

perf does not record the section address, but the kernel
layout_sections() lays out executable sections in order
starting with .text *until* it gets to .init* or .exit*.


