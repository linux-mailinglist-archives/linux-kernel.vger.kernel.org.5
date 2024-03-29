Return-Path: <linux-kernel+bounces-124068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB28911C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C281F22979
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936737153;
	Fri, 29 Mar 2024 02:53:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD8629;
	Fri, 29 Mar 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680821; cv=none; b=ix89yKOaSGhPEBppx73VW7rABjCWKdgaZZrX/PssqGKfD89PmlepDWcwcKluKUS3JZ0AzRVlKYVcIm605JkgdmrMnsfDZgmT84D4w2OdNUFY8xG+U+6FPdZuOPa9XmOSjAml8tz7nbQJVptRaCmMn4EsdmqgqseStTnaHi0sNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680821; c=relaxed/simple;
	bh=cLVUA/Dq+r+L9fmpbcFS4ppyU7J6eSvTew0CqZL202k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h+FDxC4rkBQtEAJ8Hr8UxeNQfKHYdl/rQPrSrUPH9rKbcRQ2L0YziZyI6wGoahntR0ulQ9/d54FrTmDPyeP/K6h7wi5ZlKKYreCGhv2jXbGbmrApyDua9BdtahycQk9cQsvnjaLXEYcZQrBkzbUk90M+5nTkpsgyhW8vXmYxlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V5Q0P05PQz1xtM9;
	Fri, 29 Mar 2024 10:51:33 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 45B1F18001A;
	Fri, 29 Mar 2024 10:53:35 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 29 Mar 2024 10:53:34 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.028;
 Fri, 29 Mar 2024 10:53:34 +0800
From: duchangbin <changbin.du@huawei.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
	<kan.liang@linux.intel.com>
CC: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 4/4] perf annotate: Use libcapstone to disassemble
Thread-Topic: [PATCH 4/4] perf annotate: Use libcapstone to disassemble
Thread-Index: AdqBhEXN5g0vMGErl0mxS52m6D0zyA==
Date: Fri, 29 Mar 2024 02:53:34 +0000
Message-ID: <9492dc44260c40598d1b282975eb9a4a@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Namhyung,
On Thu, Mar 28, 2024 at 04:20:09PM -0700, Namhyung Kim wrote:
> Now it can use the capstone library to disassemble the instructions.
> Let's use that (if available) for perf annotate to speed up.  Currently
> it only supports x86 architecture.  With this change I can see ~3x speed
> up in data type profiling.
>
> But note that capstone cannot give the source file and line number info.
> For now, users should use the external objdump for that by specifying
> the --objdump option explicitly.
>
> Cc: Changbin Du <changbin.du@huawei.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/disasm.c | 153 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 59ac37723990..c58ea6d822ed 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <ctype.h>
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <inttypes.h>
>  #include <libgen.h>
>  #include <regex.h>
> @@ -18,6 +19,7 @@
>  #include "evsel.h"
>  #include "map.h"
>  #include "maps.h"
> +#include "namespaces.h"
>  #include "srcline.h"
>  #include "symbol.h"
>
> @@ -1341,6 +1343,151 @@ symbol__disassemble_bpf_image(struct symbol *sym,
>       return 0;
>  }
>
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +#include <capstone/capstone.h>
> +
> +static int open_capstone_handle(struct annotate_args *args, bool is_64bi=
t,
> +                             csh *handle)
> +{
> +     struct annotation_options *opt =3D args->options;
> +     cs_mode mode =3D is_64bit ? CS_MODE_64 : CS_MODE_32;
> +
> +     /* TODO: support more architectures */
> +     if (!arch__is(args->arch, "x86"))
> +             return -1;
> +
> +     if (cs_open(CS_ARCH_X86, mode, handle) !=3D CS_ERR_OK)
> +             return -1;
> +
> +     if (!opt->disassembler_style ||
> +         !strcmp(opt->disassembler_style, "att"))
> +             cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> +
> +     /*
> +      * Resolving address operands to symbols is implemented
> +      * on x86 by investigating instruction details.
> +      */
> +     cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
Enabling CS_OPT_DETAIL is to symbolize branch target address. You can refer=
 to
print_insn_x86() in print_insn.c.

> +
> +     return 0;
> +}
> +

--
Cheers,
Changbin Du

