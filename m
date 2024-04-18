Return-Path: <linux-kernel+bounces-150318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD48A9D34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7668F2824F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816015F409;
	Thu, 18 Apr 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLFS+Kvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC486FB0;
	Thu, 18 Apr 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450909; cv=none; b=UncDFQnzT9OYz3iVNQ+CSp0tz3+xqrSEmgIKpvBRa5gg4HGmBChp7xu2G5JZ8wApVy5phqa/13RsDV7ALyrpFm2m95WxJhg2xFc1LPx6YD3ILiaqLJM6Wlf1SCU6ExjDtWpZwZc/czBoZaOnV2l2gwqOtMZLlhp6sdkyq4QhmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450909; c=relaxed/simple;
	bh=OEXF5v2Z/Fz6GXadkZnudB6JdYfvV5Jh7Dv77dnNqH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxhEyfhD5jq93iSLZDGNGW/rnAjTe3e4YafN0gt4PuJCtN+yA8Wf3E6qrl5Cn/bOfZkwpo8AOogHfwJacqs/F9IPj9U4yk3HGAdVGjBfQl76kHCjFWqldsdASxojiHT/a5QwdnnZgI4HZ2opxnNdI9Bz8tkGn1zUWTr+5S+tRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLFS+Kvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628DEC113CC;
	Thu, 18 Apr 2024 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713450908;
	bh=OEXF5v2Z/Fz6GXadkZnudB6JdYfvV5Jh7Dv77dnNqH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLFS+KvfC4yz42/ZvPtVa1JR+3VpF1SnyRmcsg79sL9c9Mh1+7odVb3yanDzLBIaZ
	 lG/qW1+t8HN49kq0flP7g/KJw5jsU16ZYt5m+j2jKYdYcbi+99J8xzq1/9YEGwW1cb
	 o6pYCHkpsFH9DPn6J3ZrELrEfCn5566dKM1dEPct22EkP1RoVe2t1LUDJ7sAlMU1rp
	 +huprQEG8wwFf7hKW0z0zQbnmomN9MFf0rsHUem0Q+c8Ouaiti+I3edb0IRHWaD59Y
	 QkfmXS+E9P2PrfhtZ2G5nTMVBz5Z67458aT5o7kItN1sAgZqvPh/PiW/BrgyIaUyjk
	 3UEI5NvykCdHw==
Date: Thu, 18 Apr 2024 11:35:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] perf trace beauty: Fix statx flags printing
Message-ID: <ZiEvmabmIxTjDLeb@x1>
References: <20240418131304.3188385-1-changbin.du@huawei.com>
 <20240418131304.3188385-2-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418131304.3188385-2-changbin.du@huawei.com>

On Thu, Apr 18, 2024 at 09:13:01PM +0800, Changbin Du wrote:
> Missed a string specifier '%s' in format string.

Humm, what branch should this be applied to? I ask because:

⬢[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/trace/beauty/statx.c
f122b3d6d179455e perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument
3d6cfbaf279ddec9 perf beauty: Introduce scrape script for various fs syscalls 'flags' arguments
a672af9139a843eb tools headers: Remove almost unused copy of uapi/stat.h, add few conditional defines
6652830c87be8446 perf beauty: Use the system linux/fcntl.h instead of a copy from the kernel
690811f0128eb603 tools headers uapi: Sync linux/stat.h with the kernel sources to pick STATX_MNT_ID_UNIQUE
49c75d30b0078d30 tools headers uapi: Sync linux/stat.h with the kernel sources
5d33cbfedb51f732 perf beauty: Add support to STATX_MNT_ID in the 'statx' syscall 'mask' argument
c65c83ffe9045901 perf trace: Allow asking for not suppressing common string prefixes
794f594e0c3be619 perf beauty: Switch from GPL v2.0 to LGPL v2.1
fd5cead23f546973 (tag: perf-core-for-mingo-4.12-20170331) perf trace: Beautify statx syscall 'flag' and 'mask' arguments
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ tools/perf/trace/beauty/statx_mask.sh 
static const char *statx_mask[] = {
	[ilog2(0x00000001) + 1] = "TYPE",
	[ilog2(0x00000002) + 1] = "MODE",
	[ilog2(0x00000004) + 1] = "NLINK",
	[ilog2(0x00000008) + 1] = "UID",
	[ilog2(0x00000010) + 1] = "GID",
	[ilog2(0x00000020) + 1] = "ATIME",
	[ilog2(0x00000040) + 1] = "MTIME",
	[ilog2(0x00000080) + 1] = "CTIME",
	[ilog2(0x00000100) + 1] = "INO",
	[ilog2(0x00000200) + 1] = "SIZE",
	[ilog2(0x00000400) + 1] = "BLOCKS",
	[ilog2(0x00000800) + 1] = "BTIME",
	[ilog2(0x00001000) + 1] = "MNT_ID",
	[ilog2(0x00002000) + 1] = "DIOALIGN",
	[ilog2(0x00004000) + 1] = "MNT_ID_UNIQUE",
};
⬢[acme@toolbox perf-tools-next]$

Can you please try with what is in
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git,
branch perf-tools-next?

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/trace/beauty/statx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
> index dc5943a6352d..c61f2be53bda 100644
> --- a/tools/perf/trace/beauty/statx.c
> +++ b/tools/perf/trace/beauty/statx.c
> @@ -21,7 +21,7 @@ size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_
>  		return scnprintf(bf, size, "%s%s", show_prefix ? "AT_STATX_" : "", "SYNC_AS_STAT");
>  #define	P_FLAG(n) \
>  	if (flags & AT_##n) { \
> -		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
> +		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
>  		flags &= ~AT_##n; \
>  	}
>  
> -- 
> 2.34.1

