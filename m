Return-Path: <linux-kernel+bounces-31496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB41832F04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03FA1C24E41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02C44362;
	Fri, 19 Jan 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxdGrwgq"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5326AF7;
	Fri, 19 Jan 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689532; cv=none; b=bn+khviWy0lnAneOj4kwMk/NvtvM4HR4ZwUsUDp29FD0dza0d4YO3G42nTFZoevjoA5I/HtdkPg2RUpDv9QkBAZ40G2nQtcWO/RWZ9xtDqo1nfc31uERHROkODfURU/R33pzMO3vWMX1iHVxxms/BTLgRrpbCETS/rUIGDQUXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689532; c=relaxed/simple;
	bh=EAecYnq6UDf33R57hZay3IKYojJLPNpFfbigLtJirRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCOLbcCWq08B//ZxNdaMpoaLARl0gBZ+R1xWPKXcIT5BjfqqXxTuzWwrc7HxVoFjUnNwailivgWgaqyURr7QmEu7rWLBw18pbSiWuNzj7BlHAYGZ+Wxo7JF1unfscOpg/VvPbzYQsxWBf8C3eGUwT3CW2dXqSbFHPqMsLIK7gQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxdGrwgq; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705689531; x=1737225531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EAecYnq6UDf33R57hZay3IKYojJLPNpFfbigLtJirRM=;
  b=kxdGrwgq8FGI1ZQ+og1tmmpjVQ1eeBNldyuDEnml8Prhose2531QzV96
   jObOx9MSBSV1FIRpJpwc6rB5wtmvB607RPpJ2CxHQHP8PicuAfbQ3tbAd
   dcflWn19i8Bglo7pZJAox60SU+e+YI0YMXbdb164Q9cOqrSdryotrWyJ9
   4QNrsE13+G+0y0DIAsTrc/0IsJ5ySTXbyXB0AdCp3dZEPF6AB+GQhFZSJ
   UojbqaPn6bo4XXMpuYz2sgCh827KyeZSBvrr6Y9YWIdOZfKn+Q+VbkwIA
   pGx4Xqtnv5nxId98XUYCseHFjNsjlKSVUMU2hRMhnnaEIVBbgpV4ScY5F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="404578652"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="404578652"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="778042392"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778042392"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:38:46 -0800
Message-ID: <029cd7e3-51f5-4d04-8f54-c6e478e052a3@intel.com>
Date: Fri, 19 Jan 2024 20:38:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] perf: build: introduce the libcapstone
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-2-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240119104856.3617986-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/24 12:48, Changbin Du wrote:
> Later we will use libcapstone to disassemble instructions of samples.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/build/Makefile.feature           |  2 ++
>  tools/build/feature/Makefile           |  4 ++++
>  tools/build/feature/test-all.c         |  4 ++++
>  tools/build/feature/test-libcapstone.c | 11 +++++++++++
>  tools/perf/Makefile.config             | 21 +++++++++++++++++++++
>  tools/perf/Makefile.perf               |  3 +++

tools/perf/tests/make needs updating also

>  6 files changed, 45 insertions(+)
>  create mode 100644 tools/build/feature/test-libcapstone.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 934e2777a2db..23bee50aeb0f 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -86,6 +86,7 @@ FEATURE_TESTS_EXTRA :=                  \
>           gtk2-infobar                   \
>           hello                          \
>           libbabeltrace                  \
> +         libcapstone                    \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
>           libopencsd                     \
> @@ -133,6 +134,7 @@ FEATURE_DISPLAY ?=              \
>           libcrypto              \
>           libunwind              \
>           libdw-dwarf-unwind     \
> +         libcapstone            \
>           zlib                   \
>           lzma                   \
>           get_cpuid              \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index dad79ede4e0a..d6eaade09694 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -53,6 +53,7 @@ FILES=                                          \
>           test-timerfd.bin                       \
>           test-libdw-dwarf-unwind.bin            \
>           test-libbabeltrace.bin                 \
> +         test-libcapstone.bin			\
>           test-compile-32.bin                    \
>           test-compile-x32.bin                   \
>           test-zlib.bin                          \
> @@ -282,6 +283,9 @@ $(OUTPUT)test-libdw-dwarf-unwind.bin:
>  $(OUTPUT)test-libbabeltrace.bin:
>  	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
>  
> +$(OUTPUT)test-libcapstone.bin:
> +	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
> +
>  $(OUTPUT)test-compile-32.bin:
>  	$(CC) -m32 -o $@ test-compile.c
>  
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 6f4bf386a3b5..dd0a18c2ef8f 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -134,6 +134,10 @@
>  #undef main
>  #endif
>  
> +#define main main_test_libcapstone
> +# include "test-libcapstone.c"
> +#undef main
> +
>  #define main main_test_lzma
>  # include "test-lzma.c"
>  #undef main
> diff --git a/tools/build/feature/test-libcapstone.c b/tools/build/feature/test-libcapstone.c
> new file mode 100644
> index 000000000000..fbe8dba189e9
> --- /dev/null
> +++ b/tools/build/feature/test-libcapstone.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <capstone/capstone.h>
> +
> +int main(void)
> +{
> +	csh handle;
> +
> +	cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
> +	return 0;
> +}
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b3e6ed10f40c..7589725ad178 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -191,6 +191,15 @@ endif
>  FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
>  
> +# for linking with debug library, run like:
> +# make DEBUG=1 LIBCAPSTONE_DIR=/opt/capstone/
> +ifdef LIBCAPSTONE_DIR
> +  LIBCAPSTONE_CFLAGS  := -I$(LIBCAPSTONE_DIR)/include
> +  LIBCAPSTONE_LDFLAGS := -L$(LIBCAPSTONE_DIR)/
> +endif
> +FEATURE_CHECK_CFLAGS-libcapstone := $(LIBCAPSTONE_CFLAGS)
> +FEATURE_CHECK_LDFLAGS-libcapstone := $(LIBCAPSTONE_LDFLAGS) -lcapstone
> +
>  ifdef LIBZSTD_DIR
>    LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
>    LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
> @@ -1089,6 +1098,18 @@ ifndef NO_LIBBABELTRACE
>    endif
>  endif
>  
> +ifndef NO_CAPSTONE
> +  $(call feature_check,libcapstone)
> +  ifeq ($(feature-libcapstone), 1)
> +    CFLAGS += -DHAVE_LIBCAPSTONE_SUPPORT $(LIBCAPSTONE_CFLAGS)
> +    LDFLAGS += $(LICAPSTONE_LDFLAGS)
> +    EXTLIBS += -lcapstone
> +    $(call detected,CONFIG_LIBCAPSTONE)
> +  else
> +    msg := $(warning No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel);
> +  endif
> +endif
> +
>  ifndef NO_AUXTRACE
>    ifeq ($(SRCARCH),x86)
>      ifeq ($(feature-get_cpuid), 0)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 058c9aecf608..236da4f39a63 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -84,6 +84,9 @@ include ../scripts/utilities.mak
>  # Define NO_LIBBABELTRACE if you do not want libbabeltrace support
>  # for CTF data format.
>  #
> +# Define NO_CAPSTONE if you do not want libcapstone support
> +# for disasm engine.
> +#
>  # Define NO_LZMA if you do not want to support compressed (xz) kernel modules
>  #
>  # Define NO_AUXTRACE if you do not want AUX area tracing support


