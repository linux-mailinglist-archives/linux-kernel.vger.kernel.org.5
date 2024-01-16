Return-Path: <linux-kernel+bounces-27436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D767D82F008
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AC61C232B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C201BDDC;
	Tue, 16 Jan 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgimQmPF"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C351BDC8;
	Tue, 16 Jan 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705413222; x=1736949222;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jO9folGESd0ZEFAll3N4Qxi0Oa88Gb131sxpT3mbQns=;
  b=AgimQmPFIUZM8Ha6l5ixe5H+aCvwnQ8Ol2JTXBK0EXq9J+EQLaBqWxnC
   XtKALXPTxR/fBFzJV8Kg4IjR/0xL4Jn/WSJVaVxpVTVl/YhAtpMb9sIdL
   RZBYxHOG7cUf0WT+lg8oLlcnOrDk46m++qqfurK9PCrYmH9JZvrlfGCGN
   y5IXnY4dNeyq/1BRMyOx2AmDwG8egdoOkow+nCmog65eovXg/u/ICfdLE
   kv0MB2UhN+PPmPLEX4XMbv1iAwvN/iujP0KkW0DgrjW6KsX8FxWyzk2xv
   iFKRosD3sX5P+J1jsWDo+CRDxqK7iGQB4t7J8Dn0+kaQMAntKVzNoHx7g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464154184"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="464154184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 05:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733616603"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="733616603"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2024 05:53:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id EE6AC301BD1; Tue, 16 Jan 2024 05:53:40 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,
  Namhyung Kim <namhyung@kernel.org>,  Ian Rogers <irogers@google.com>,
  Adrian Hunter <adrian.hunter@intel.com>,  <linux-kernel@vger.kernel.org>,
  <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 0/3] perf: script: Intro capstone disasm engine to show
 instruction trace
In-Reply-To: <20240116113437.1507537-1-changbin.du@huawei.com> (Changbin Du's
	message of "Tue, 16 Jan 2024 19:34:34 +0800")
References: <20240116113437.1507537-1-changbin.du@huawei.com>
Date: Tue, 16 Jan 2024 05:53:40 -0800
Message-ID: <87il3tl6zf.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changbin Du <changbin.du@huawei.com> writes:

> This series introduces capstone disassembler engine to print instructions of
> Intel PT trace, which was printed via the XED tool.

FWIW at least on x86 in my experience capstone isn't that great an
disassembler. I used it in another project and ran into many decoding bugs.
They're mostly in obscure corners, but can be fairly annoying.

My other concern with your patchkit is that you change the default
output formats. Since perf script is often used with scripts
(as the name implies) there is a certain expectation that the output
remains stable and parse-able. There are actually use cases where
the raw bytes "insn" output is needed.

I would rather define new perf script output types for the new decoded output,
but keep the old alone.

-Andi

