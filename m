Return-Path: <linux-kernel+bounces-9034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E481BF75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C28D283D59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCB745CC;
	Thu, 21 Dec 2023 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2h/U0j8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31221651AC;
	Thu, 21 Dec 2023 20:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7857EC433C7;
	Thu, 21 Dec 2023 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703189456;
	bh=019NYr19gFW/EzI4ftLoZI+MnX8nPTJFCQHEjL5OAZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2h/U0j8QN6rgFeiZwqRqGsQmj0v/ymEOEjm6GB7FZ5C9aq4TMSZvg4fUEApBJg0B
	 Ygd85M+Wmy7M8SVCNzAUcr+1IEzFSpAOH/EK3MPaCCbVbCGPEdOhDcfBLjOxg3xcl2
	 smvgIqrhvfagn/HsJbyWolfIrQ11vkYlFY6gRjyUg98LSZiDGg3VGfdPcw4Z692pSn
	 Hfc3n2+QJ8F3Vu6e1T80JaEDlcEwtnNrOsD/92p91SSowpnuuzl5ec4maysdiCBxNS
	 IZTOrfY/fWsIEF1Bxi+jxTE8Wk88m33wPlNDkjfCZVhoV4iKoSciCBqjotmrAVucKy
	 O11WAzIVvs0Fw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A3204403EF; Thu, 21 Dec 2023 17:10:53 -0300 (-03)
Date: Thu, 21 Dec 2023 17:10:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Kleen <ak@linux.intel.com>, linux-trace-devel@vger.kernel.org,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 13/52] perf annotate-data: Add dso->data_types tree
Message-ID: <ZYSbzZv-Y-j0_feZ@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-14-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110000012.3538610-14-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 09, 2023 at 03:59:32PM -0800, Namhyung Kim escreveu:
> +++ b/tools/perf/util/dso.h
> @@ -154,6 +154,8 @@ struct dso {
>  	size_t		 symbol_names_len;
>  	struct rb_root_cached inlined_nodes;
>  	struct rb_root_cached srclines;
> +	struct rb_root	data_types;
> +
>  	struct {
>  		u64		addr;
>  		struct symbol	*symbol;

At some point we need to make these feature specific members to be
associated on demand, maybe thru some hash table, etc.

I.e. the most basic workflow, what everybody needs should be in 'struct
dso', something one _may_ want, like data profiling, should be in
associated with that DSO thru some other way.

I'm applying this now as this is a super cool feature, but think about
it.

- Arnaldo

