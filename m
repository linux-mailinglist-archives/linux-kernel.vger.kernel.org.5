Return-Path: <linux-kernel+bounces-135470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442E89C55E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C5C1F2391F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3943B7C089;
	Mon,  8 Apr 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6A9ytY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53D79955;
	Mon,  8 Apr 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584583; cv=none; b=fGXAPDkehakMsnRdB5mpf+H9FFzRiuLlQZihGF/3yw4n/AosHluodIBt1QWBCSAo39NY6I9mitn69Tfu6NILrGNNOBRIe1jp8CvNCnyfbDGWKk3u2FzPnBqkbIMuRuI9BJGo+ifC7YJkbtqQXShPdTv8X64NLZlb5h7u9eUSOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584583; c=relaxed/simple;
	bh=aLYcoDPwUFsUit2u1j/5yFGuRmxNoZ15e8nXxxHoW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCHKCCpvsTQ7e1RRkGW0nS//tcHOJ/cSvsDugVvS0ZUI8gDctvXUXj9EEYezunKXqlYk+uJIw4Jh3JP/xSPkBDZKM3Nq2ksM1zbzhJlHBMYObFMgqjyVim5Yf2dExnQilsN/17D2iEm99I7zI7ypHDMBojzu4L6eu7saeowtJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6A9ytY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFDAC43390;
	Mon,  8 Apr 2024 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712584583;
	bh=aLYcoDPwUFsUit2u1j/5yFGuRmxNoZ15e8nXxxHoW/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6A9ytY1NmhMim7uIJdEIzkWs7DHtbd13oUu3zs5nbmfyBov9+e02zrZOrTgDrukp
	 vXsttbjZUYCSXBxeqBNzEsA4GQW8gMUlOIaVO2FFopg1qVGAyFGHaOH6+77wKc1HDT
	 223KMONzV+w95f6nZbwmQm9TzpXO153FK5zBap3xbedphtY0H1NNEepROtSAS8QqfJ
	 YRxN1fPzgoRh7FWdC02y966CaTv0OHP8w9eQplZEUd7iOXOdsrhuWYh3kib5QVhqnJ
	 oL/a4vGIAkzUmCi1HOH7jnsNGlaqm8VjOk/KFe2Uycr+tR0QXSelf1qjWnLEoWiQ0d
	 ykr9Qe0m9L83g==
Date: Mon, 8 Apr 2024 10:56:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/9] perf annotate: More memory footprint reduction
Message-ID: <ZhP3N-oBezFN1ISW@x1>
References: <20240404175716.1225482-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404175716.1225482-1-namhyung@kernel.org>

On Thu, Apr 04, 2024 at 10:57:07AM -0700, Namhyung Kim wrote:
> Hello,
> 
> This work is continuation of the previous work to reduce the memory
> usage in symbol and annotation structures.  Basically I moved some
> fields in the annotation which consume spaces in the struct symbol
> which is allocated regardless if the symbol has a sample or not when
> annotation is enabled.
> 
> With this change applied, the struct annotation only has two members -
> annotated_source and annotated_branch.  The next step would be to
> remove the struct annotation and to have a hash table from symbol to
> each annotated struct directly.
> 
> No function changes intended.
> 
> The code is available at perf/annotate-diet-v3 branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks, applied to perf-tools-next,

- Arnaldo

