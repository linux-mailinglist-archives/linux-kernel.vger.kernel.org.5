Return-Path: <linux-kernel+bounces-129923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3C897213
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796841F2A31B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4011494CD;
	Wed,  3 Apr 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVKZxVmm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BB148305;
	Wed,  3 Apr 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153613; cv=none; b=ayjtEXRBup5ByHw/WWV9qIDzENIkHZJB0nf+eKbAtK+b2Ce5ou/Cb/5sZw4GYEMpeb0/gScgChnVCOygkJghvos/M9FyosrVADcvQtVUyYtvbGeIj/8K/xOv5Ad54PjZ2oViCAdGMrtG7xmjbMnjVI1YQoFv2Ektpsixk9b2Ejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153613; c=relaxed/simple;
	bh=oQYdkSycvPqbfcL8zV1mGBUEeLAVUzVXPrPdPWpM2sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObWPUX17mEvCapnQrbcyGkMRBDInydK0RvqOlBDxMbh2RZUysizV7FfMg7esrCHKTbkjruIEU3vI9nZRc4aMWe6wu35z79sQ4oXS/a5HJ+uvomNFab7hlsY1ZvT58JAYmtOcBDfGRHByJy3XHozA7XXepd1mkX6GfhZeApdxVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVKZxVmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1174EC43390;
	Wed,  3 Apr 2024 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153612;
	bh=oQYdkSycvPqbfcL8zV1mGBUEeLAVUzVXPrPdPWpM2sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVKZxVmmRpT2UuBVrMkJN4j6QAsZvTJG5XS+d8+f8CCEIatF/O80939pAd6Rkg3Mh
	 8zBLMasfk18iLwbj04SdoWyUevPKUYipyh0lZgXuFLvi5IaUwbT0+66K816uSZAOYY
	 PYvclJ1Cs9dyFePT1a46c9mPQgZKNTdKiOcSTiVZAjEUZkP4+jNQFIo56yIjGOPjij
	 Fs6q9LDC7kMwZD5gnhJIVAuqTnwOZJqP6BHLjAkZrJg62gqFBMxUGDH1UB+mjawsxH
	 AePpsbvsAjEXmQl4cGRf+18pn7FRHBo0s+cJ4LrIv7niK3AhQgm7Fd9/uT2go0zMgO
	 0wSKS9cNEkLgg==
Date: Wed, 3 Apr 2024 11:13:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/5] perf annotate: Split out util/disasm.c
Message-ID: <Zg1kCT3V3n9l0fJc@x1>
References: <20240329215812.537846-1-namhyung@kernel.org>
 <20240329215812.537846-4-namhyung@kernel.org>
 <ZgyBwTWv8OZlbl9m@x1>
 <ZgyCkETBtsTX3tA8@x1>
 <CAM9d7cgyeaeTPyw5fZjX2OsVrGqv-VrqpU_RPgUu8yWN+qTDsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgyeaeTPyw5fZjX2OsVrGqv-VrqpU_RPgUu8yWN+qTDsg@mail.gmail.com>

On Tue, Apr 02, 2024 at 04:03:33PM -0700, Namhyung Kim wrote:
> On Tue, Apr 2, 2024 at 3:11 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Tue, Apr 02, 2024 at 07:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Mar 29, 2024 at 02:58:10PM -0700, Namhyung Kim wrote:
> > > > The util/annotate.c code has both disassembly and sample annotation
> > > > related codes.  Factor out the disasm part so that it can be handled
> > > > more easily.
> > > >
> > > > No functional changes intended.
> > > >
> > >
> > > Unsure if here, will check and fix later, detected with:
> > >
> > >   make -C tools/perf build-test'
> >
> > did it, added the missing env.h header to disasm.c

> Thanks a lot!

Three more, also fixed:

util/disasm.c: In function ‘symbol__disassemble_bpf’:
util/disasm.c:1203:9: error: implicit declaration of function ‘perf_exe’ [-Werror=implicit-function-declaration]
 1203 |         perf_exe(tpath, sizeof(tpath));
      |         ^~~~~~~~



diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 3438c31437f46e71..c2664215554d0bb3 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -21,6 +21,7 @@
 #include "maps.h"
 #include "srcline.h"
 #include "symbol.h"
+#include "util.h"
 
 static regex_t	 file_lineno;
 
util/disasm.c:1229:32: error: invalid use of undefined type ‘struct bpf_prog_info_node’
 1229 |         info_linear = info_node->info_linear;
      |                                ^~
util/disasm.c: In function ‘symbol__disassemble_bpf’:
util/disasm.c:1230:32: error: invalid use of undefined type ‘struct bpf_prog_info_node’
 1230 |         info_linear = info_node->info_linear;
      |                                ^~


diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index c2664215554d0bb3..5b5407525b31f47f 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1170,6 +1170,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 #include <linux/btf.h>
 #include <tools/dis-asm-compat.h>
 
+#include "bpf-event.h"
+
 static int symbol__disassemble_bpf(struct symbol *sym,
 				   struct annotate_args *args)
 {

util/disasm.c: In function ‘symbol__disassemble_bpf’:
util/disasm.c:1235:54: error: invalid use of undefined type ‘struct perf_bpil’
 1235 |         info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
      | 

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a88d33fd38a58e4a..a1219eb930aaeb5a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1173,6 +1173,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 #include <tools/dis-asm-compat.h>
 
 #include "bpf-event.h"
+#include "bpf-utils.h"
 
 static int symbol__disassemble_bpf(struct symbol *sym,
 				   struct annotate_args *args)

