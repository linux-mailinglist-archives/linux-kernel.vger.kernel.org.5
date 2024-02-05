Return-Path: <linux-kernel+bounces-52287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D429849655
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB6FB258EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1DA125D1;
	Mon,  5 Feb 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsHC+mTS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470912B7A;
	Mon,  5 Feb 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124894; cv=none; b=b92uljuV2Q+RFVMKA8ZPey89pSQywOcYm5YHF7is6EVeYgrjMAzAZzkvmQMCMD9ChFR/oUX44kboLFIVxrihOfAlKSocJ//BbQKMbcP01B6N6LzvhpgCLxeqx0CSIeBF87F8q9dHeewG9QKSZw3t8+CBsBE6MxxbP1HtPA9OS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124894; c=relaxed/simple;
	bh=paGI1RDfUiXo+kSzw9iNTY7r4/um3ISRwxQ+S61xmr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odWV1QO5dfxdIMwH6QWVy5sBwKbJo430w0Bei1zvUODSp+LVgAz4Br/NHdOTaLBhRDulTGMuPoAaeVt7rRgI07gkn4hwghQIYB/1h9WZs9nFYV3ptPq/9WpnPLTngqkVtrJxQcbjgEPNLpS3uVk52cynWa8ICtHrQrOtcCyKr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsHC+mTS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707124891; x=1738660891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=paGI1RDfUiXo+kSzw9iNTY7r4/um3ISRwxQ+S61xmr0=;
  b=EsHC+mTSlYcTFy63d3GAZE/2wYx/vZFoDa4gxhFbncnyQv18aOiTmwUB
   +lSf3L/jZUOwuZT/H7XQGzXxshAePgoE8cRtp5/3X7kjxc6Lv+GDHI0vy
   5aUFEwDxAmYUGKAXQn0erv2PLGtUKxM8iUNvoujCRY0Uby8GzptkzCTQX
   wqUWX8tGuowRA4333QiqyiluWvh3j2KQ2J9C6zYoLG+f9NTfQ/p1T1Zwb
   EVBr5zVmdiFWWBNbIimqw/7yKMrH1o3zn8CpVl6OiJ86sqfW1iiPBPg5P
   IdLYUwJh5TZDH8rI0FVqJFpZcZQRcfkL3lcVZEUf/Kygct0ekfR+XdRTB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="18010128"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="18010128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31764973"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:21:26 -0800
Message-ID: <fbd131d2-a4c2-4b7a-95ae-6593b7a3a997@intel.com>
Date: Mon, 5 Feb 2024 11:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] perf: build: introduce the libcapstone
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240122112054.1576835-1-changbin.du@huawei.com>
 <20240122112054.1576835-2-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240122112054.1576835-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/24 13:20, Changbin Du wrote:
> Later we will use libcapstone to disassemble instructions of samples.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> ---
> v2:
>   - change tools/perf/tests/make also.
> ---
>  tools/build/Makefile.feature           |  2 ++
>  tools/build/feature/Makefile           |  4 ++++
>  tools/build/feature/test-all.c         |  4 ++++
>  tools/build/feature/test-libcapstone.c | 11 +++++++++++
>  tools/perf/Makefile.config             | 21 +++++++++++++++++++++
>  tools/perf/Makefile.perf               |  3 +++
>  tools/perf/tests/make                  |  2 ++
>  7 files changed, 47 insertions(+)
>  create mode 100644 tools/build/feature/test-libcapstone.c

Perhaps add it also to display with perf version --build-options

> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 64df118376df..1e2ab148d5db 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -87,6 +87,7 @@ FEATURE_TESTS_EXTRA :=                  \
>           gtk2-infobar                   \
>           hello                          \
>           libbabeltrace                  \
> +         libcapstone                    \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
>           libopencsd                     \
> @@ -134,6 +135,7 @@ FEATURE_DISPLAY ?=              \
>           libcrypto              \
>           libunwind              \
>           libdw-dwarf-unwind     \
> +         libcapstone            \
>           zlib                   \
>           lzma                   \
>           get_cpuid              \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 37722e509eb9..ed54cef450f5 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -54,6 +54,7 @@ FILES=                                          \
>           test-timerfd.bin                       \
>           test-libdw-dwarf-unwind.bin            \
>           test-libbabeltrace.bin                 \
> +         test-libcapstone.bin			\
>           test-compile-32.bin                    \
>           test-compile-x32.bin                   \
>           test-zlib.bin                          \
> @@ -286,6 +287,9 @@ $(OUTPUT)test-libdw-dwarf-unwind.bin:
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
> index aa55850fbc21..3e1072c59757 100644
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
> @@ -1094,6 +1103,18 @@ ifndef NO_LIBBABELTRACE
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
> index 27e7c478880f..56c2720c1d0f 100644
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
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 8a4da7eb637a..b08026f5d4e7 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -83,6 +83,7 @@ make_no_libelf      := NO_LIBELF=1
>  make_no_libunwind   := NO_LIBUNWIND=1
>  make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
>  make_no_backtrace   := NO_BACKTRACE=1
> +make_no_libcapstone := NO_CAPSTONE=1
>  make_no_libnuma     := NO_LIBNUMA=1
>  make_no_libaudit    := NO_LIBAUDIT=1
>  make_no_libbionic   := NO_LIBBIONIC=1

Also needs to be added to make_minimal

> @@ -152,6 +153,7 @@ run += make_no_libelf
>  run += make_no_libunwind
>  run += make_no_libdw_dwarf_unwind
>  run += make_no_backtrace
> +run += make_no_libcapstone
>  run += make_no_libnuma
>  run += make_no_libaudit
>  run += make_no_libbionic


