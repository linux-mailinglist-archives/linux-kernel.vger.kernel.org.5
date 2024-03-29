Return-Path: <linux-kernel+bounces-125222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C889226B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5951F25F18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E04130AC8;
	Fri, 29 Mar 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK6hGq/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5128DC0;
	Fri, 29 Mar 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732200; cv=none; b=iJo/adnj5GmolOGQazkI02Dg3TSTKB1hhoo0d4XbQAISEK/B1T48u/w8uTd+dbkH2Qx/XC5X1JN5k0+WirPJlcDXWbKL4ktUzn2CALsPVe1hNqfqfyGweh/Nx9X9gG6gnunrQiI3IgQLN5fVNLjPPdsph5aCPVzFmOOKbI9D4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732200; c=relaxed/simple;
	bh=BuGWdecQ/Njyxbft7vhGROS6EDgjjEQxrXuJekhPQqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOu8BD5Q/WeFuGMGc3CIIZly3wGtDWIpsOdeU0ruzNnko1I/dVFVI5kLsfPAZ80lHdSex968nLqmcINz8wvKhY4DZ2JBHQYo6GdTycy008SBqrIz7FCCu79NC3ArDgd0HgO6ZiPP3fWbng4RqzTqqqAPT2RFoY0h5R4wo+uzOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK6hGq/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87676C433C7;
	Fri, 29 Mar 2024 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711732199;
	bh=BuGWdecQ/Njyxbft7vhGROS6EDgjjEQxrXuJekhPQqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WK6hGq/sZacTM+03ujyZrburl+1ffpCWgurNYh75zLx9uMxC/Cvn2lc8GbCMx+xP3
	 93tNlP5PD9R3QyqFXL6XL0OROgWca3kMM/oU1Qpr6Bcn5W6Iq9rxrGS+vFj9tYNGP7
	 RqFQxz8OcbTMsHOi6nXr6DWT6qv6w3l9J+qemBjIZ6N6lIEV+zNklZroCi0mgJzBYa
	 TIrUNS8bXRRCmpFyUm5PsZU60t0pDGC+fHOBIfiQV8V/oqGPNBgwUVj9dCFRTLLQeM
	 otHQhsn5WRzZVY/CER04RpIdTptM+rTC/qUe/Omw3YSrvDMMhKEGXb9hMoK68XOkDr
	 bC+qZUtHQznFA==
Date: Fri, 29 Mar 2024 14:09:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH 0/4] perf annotate: Use libcapstone as a disasssembler
Message-ID: <Zgb1uj_VQ1pjFdKE@x1>
References: <20240328232009.466018-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328232009.466018-1-namhyung@kernel.org>

On Thu, Mar 28, 2024 at 04:20:05PM -0700, Namhyung Kim wrote:
> Hello,
> 
> As we've added libcapstone support, it's natural to use it for perf annotate
> as well.  This change added the capstone support on x86 first.  Other archs
> can be added later (by someone who can verify it doesn't break things).
> 
> For now it tries to use capstone (if available) before objdump.  But it
> doesn't support source file and line number info.  So users should use the
> objdump (by passing --objdump=PATH option) if they need them.  For example,
> this command line will keep the existing behavior (i.e. using objdump).
> 
>   # not to use capstone for disassembly
>   $ perf annotate --objdump=objdump
> 
> The capstone uses LLVM objdump style output which is slightly different than
> the GNU objdump.  But it should not have differences besides that.  I've
> verified the result of data type profiling and it produced the same output
> but gave me ~3x speedups.

Excellent news, I'll try and test all this soon!

- Arnaldo

