Return-Path: <linux-kernel+bounces-29698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CD8311FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993841F21721
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292C6FBC;
	Thu, 18 Jan 2024 04:01:00 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0BB641;
	Thu, 18 Jan 2024 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550460; cv=none; b=jUsx+sbablLns6wjO4IZa5TDJ/+xiCtdrW8P9Rb+/ANPvNLa9QOXHZA0GEbO5/e0ExchF6LPIjxuFRZW20Yj+k7UJu7nKRzTAG/QnWHk4QoKk11oPVMKvSbqPDLukYboQU/B3faSKUYImjYtX1ZwR+mlhBpEsz/0XskkPRQoYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550460; c=relaxed/simple;
	bh=KJCxYFTEjhZdm9oclmLeYnAWVvPrKYCHqefqfvdCqss=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy; b=mq43rJpGeWaWJwF0jY/w1KU9Uatro0le3/DrKRGLj+cYShllVJArjI4CUmA7F1wpDlyoTCK6a0x82kARKrqIHzh57/XRDoEblBgQnHIpJfeOAnJoK75t0hcVRBuh/aMb5qDNdXs/XPiu2kvJUiLFg9GdDVnLskb0n9/nhcRhp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TFpt72xqXzsVy9;
	Thu, 18 Jan 2024 11:59:59 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C7781402CA;
	Thu, 18 Jan 2024 12:00:54 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 18 Jan
 2024 12:00:52 +0800
Date: Thu, 18 Jan 2024 12:00:42 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Thomas Richter <tmricht@linux.ibm.com>
CC: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>,
	<changbin.du@gmail.com>
Subject: Re: [PATCH v2 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
Message-ID: <20240118040042.cxtbysotgjabwvo6@M910t>
References: <20240117051104.2147643-1-changbin.du@huawei.com>
 <20240117051104.2147643-3-changbin.du@huawei.com>
 <240dd956-5f72-4330-b7d8-5c3f8711cb37@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <240dd956-5f72-4330-b7d8-5c3f8711cb37@linux.ibm.com>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Wed, Jan 17, 2024 at 09:54:59AM +0100, Thomas Richter wrote:
> On 1/17/24 06:11, Changbin Du wrote:
> > Currently, the instructions of samples are shown as raw hex strings
> > which are hard to read. x86 has a special option '--xed' to disassemble
> > the hex string via intel XED tool.
> > 
> > Here we use capstone as our disassembler engine to give more friendly
> > instructions. We select libcapstone because capstone can provide more
> > insn details. Perf will fallback to raw instructions if libcapstone is
> > not available.
> > 
> > The advantages compared to XED tool:
> >  * Support arm, arm64, x86-32, x86_64 (more could be supported),
> >    xed only for x86_64.
> >  * Immediate address operands are shown as symbol+offs.
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/builtin-script.c  |   8 +--
> >  tools/perf/util/Build        |   1 +
> >  tools/perf/util/print_insn.c | 123 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/print_insn.h |  14 ++++
> >  4 files changed, 141 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/perf/util/print_insn.c
> >  create mode 100644 tools/perf/util/print_insn.h> 
> ...
> 
> > diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> > new file mode 100644
> > index 000000000000..fe035efe8cf6
> > --- /dev/null
> > +++ b/tools/perf/util/print_insn.c
> > @@ -0,0 +1,123 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Instruction binary disassembler based on capstone.
> > + *
> > + * Author(s): Changbin Du <changbin.du@huawei.com>
> > + */
> > +#include "print_insn.h"
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <stdbool.h>
> > +#include "util/debug.h"
> > +#include "util/symbol.h"
> > +#include "machine.h"
> > +
> > +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> > +{
> > +	int printed = 0;
> > +
> > +	for (int i = 0; i < sample->insn_len; i++)
> > +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
> > +	return printed;
> > +}
> > +
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +#include <capstone/capstone.h>
> > +
> > +static int capstone_init(struct machine *machine, csh *cs_handle)
> > +{
> > +	cs_arch arch;
> > +	cs_mode mode;
> > +
> > +	if (machine__is(machine, "x86_64")) {
> > +		arch = CS_ARCH_X86;
> > +		mode = CS_MODE_64;
> > +	} else if (machine__normalized_is(machine, "x86")) {
> > +		arch = CS_ARCH_X86;
> > +		mode = CS_MODE_32;
> > +	} else if (machine__normalized_is(machine, "arm64")) {
> > +		arch = CS_ARCH_ARM64;
> > +		mode = CS_MODE_ARM;
> > +	} else if (machine__normalized_is(machine, "arm")) {
> > +		arch = CS_ARCH_ARM;
> > +		mode = CS_MODE_ARM + CS_MODE_V8;
> > +	} else if (machine__normalized_is(machine, "s390x")) {
> 
>         } else if (machine__normalized_is(machine, "s390")) {                 
> 
> > +		arch = CS_ARCH_SYSZ;
> > +		mode = CS_MODE_BIG_ENDIAN;
> > +	} else {
> > +		return -1;
> > +	}
> 
> I have debugged your reworked patch this morning and discovered that
> it was not working. The issue turned out to be function machine__normalized_is().
> The first parameter is passed to several functions before the comparison.
> The calls executed are
> 
>    machine__normhalized_is()
>    +--> perf_env__arch() --> called for first parameter.
>         +--> normalize_arch() --> always returns "s390"
> 
> We need to change the second parameter to "s390" without the trailing x
> as indicated above. Sorry for the confusion.
>
ok, will fix it later. Thanks.

> Thanks a lot.
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 

-- 
Cheers,
Changbin Du

