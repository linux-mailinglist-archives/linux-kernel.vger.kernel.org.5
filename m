Return-Path: <linux-kernel+bounces-9038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC581BF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3CBB24804
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24974E35;
	Thu, 21 Dec 2023 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYGc9GHx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADEE6E2A1;
	Thu, 21 Dec 2023 20:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D559C433C8;
	Thu, 21 Dec 2023 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703189593;
	bh=0WKjtOSrx8bLY+mIWiuI+GOUMzqhkuqPUxDDdGMfxqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYGc9GHxxRhUPNu5ee9erEx1FDTJfNdf5e1e8Qhi4MWkxkit+cdflgtR9n4Cz/r08
	 rA52stsTO9/JxURiuWX1SDFV3kDyIuvec0NL1UyKjkgQqsyGZiDr+Ed3XpTs5rLLgq
	 s/NjmWvXUczeq42T/wjSTXm7OYOg2dCC7ruMUCpQHkcBxUqBeqvoadazdZCzhgEg9s
	 mzu4IeanBBsJcSzXq7FzrB22ROGMaG2ldehWOwUHiMTbQ25hVAHJm0k5CIjIP/KH7+
	 wwvdJr9Efy/z+irg8zUXqp+8ennRmmZ9bVWZx/dF4ffUpFulOldVMQYdJk+wneCcr9
	 ScMOg9HZsiMgw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 3A2B7403EF; Thu, 21 Dec 2023 17:13:11 -0300 (-03)
Date: Thu, 21 Dec 2023 17:13:11 -0300
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
Message-ID: <ZYScVwzbviHyVFHb@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-14-namhyung@kernel.org>
 <ZYSbzZv-Y-j0_feZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYSbzZv-Y-j0_feZ@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 21, 2023 at 05:10:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 09, 2023 at 03:59:32PM -0800, Namhyung Kim escreveu:
> > +++ b/tools/perf/util/dso.h
> > @@ -154,6 +154,8 @@ struct dso {
> >  	size_t		 symbol_names_len;
> >  	struct rb_root_cached inlined_nodes;
> >  	struct rb_root_cached srclines;
> > +	struct rb_root	data_types;
> > +
> >  	struct {
> >  		u64		addr;
> >  		struct symbol	*symbol;
> 
> At some point we need to make these feature specific members to be
> associated on demand, maybe thru some hash table, etc.
> 
> I.e. the most basic workflow, what everybody needs should be in 'struct
> dso', something one _may_ want, like data profiling, should be in
> associated with that DSO thru some other way.
> 
> I'm applying this now as this is a super cool feature, but think about
> it.

I think I have this series applied up to this patch, the next one is not
applying cleanly, so I'll do the usual set of build tests so that I can
push this for linux-next consumption.

This should be on tmp.perf-tools-next in a few jiffies, in
perf-tools-next a bit later.

- Arnaldo

