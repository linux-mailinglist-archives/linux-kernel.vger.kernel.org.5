Return-Path: <linux-kernel+bounces-110667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A7388620E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44651C21F09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EE8135A73;
	Thu, 21 Mar 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgbYbhTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBA5660;
	Thu, 21 Mar 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054123; cv=none; b=bD2+neLWOWaLimU5ljz8Y3Dh4EHwtyhcdx6uNnvITSy0dgIx3CQTQziKTxYMHajGuuvLNwMoSegchXSDG7TMZ9k7+Pdn3AYLY6ci4WQZhwEACrsn54N3jRO+wRUuSd/OD8Z2LnxCdr97LzglrZbhjXewktJZnnAXKFDTvRT8Jfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054123; c=relaxed/simple;
	bh=Zfum68HEytLWKgrAIfscXuFBNg4ll/RiXypMBqUsJUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH7AUog0kYYiw0yf6UQzMC9BI3wBJuVMHRcg/BkCCYRuaMWwLxOwYe73bmyfY3/9BlhXah1cJDP/9xQYjctHggK7e8r9o+7OIoFlrjlKvvn230c5vojHJMB899KNUjR/jrJULEEfobcI+IWy7zAs/7R9KWciQKD5W8OmWDjQC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgbYbhTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73594C433C7;
	Thu, 21 Mar 2024 20:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711054122;
	bh=Zfum68HEytLWKgrAIfscXuFBNg4ll/RiXypMBqUsJUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgbYbhTaDPrg1MzZEM7wc09W+s1ifR1arErWffJrNG5SHnyDDJYsLeVtXNRvvJdiZ
	 rFaMq0nSJEpJDZUxN6MynuUljvrYsvcJD/kqFZW39uhZlLJCRynxFNyYefn+1CtrkT
	 PKFcW4y1kEKxoIbYUMz2bAOw+lO55U5oK8XecYIAN8r77jywzOjfjad+ubS1H0O4uL
	 W5VhKvKxIjhw8cIaiUK9WiSkr0OHTB+QsP8GG1Uw1DSYdidmBF63ZtQFMOECjgyVpw
	 Hw26S4mdsU9QKtjx5Go/7ZAvG3FhBOJebVW+ht11RcxfmUesYIWRutPxN47m/O/+S0
	 tuXrM0865Z8kQ==
Date: Thu, 21 Mar 2024 17:48:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anne Macedo <retpolanne@posteo.net>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf lock contention: skip traceiter functions
Message-ID: <ZfydJzGgz4qy7Inh@x1>
References: <20240319143629.3422590-1-retpolanne@posteo.net>
 <ZfyRWZqxypTzdvQF@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfyRWZqxypTzdvQF@x1>

On Thu, Mar 21, 2024 at 04:58:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Thanks, testing it now on x86_64 and aarch64, will apply it then.

Done, applied, on aarch64:

root@roc-rk3399-pc:~# perf lock contention --use-bpf -a find / > /dev/null
 contended   total wait     max wait     avg wait         type   caller

         6      6.03 s       6.03 s       1.00 s      spinlock   __tick_broadcast_oneshot_control+0xc0
        19    811.74 ms    621.76 ms     42.72 ms     spinlock   rcu_core+0xec
         2    201.76 ms    201.75 ms    100.88 ms     spinlock   sugov_update_shared+0x44
         6      7.80 ms      2.35 ms      1.30 ms        mutex   regulator_lock_recursive+0x144
         1    702.63 us    702.63 us    702.63 us      rwsem:W   __btrfs_tree_lock+0x2c
         4     62.42 us     18.96 us     15.60 us     spinlock   tick_do_update_jiffies64+0x44
         2     39.96 us     22.17 us     19.98 us     spinlock   __tick_broadcast_oneshot_control+0xc0
         2     33.83 us     18.08 us     16.92 us        mutex   mmc_blk_rw_wait+0x138
         1     21.58 us     21.58 us     21.58 us     spinlock   sugov_update_shared+0x44
         1     16.92 us     16.92 us     16.92 us     spinlock   cpu_pm_enter+0x34
         1     16.04 us     16.04 us     16.04 us        mutex   clk_prepare_lock+0x4c
root@roc-rk3399-pc:~# uname -a
Linux roc-rk3399-pc 6.1.68-12200-g1c40dda3081e #1 SMP PREEMPT_DYNAMIC Thu Dec 14 04:02:49 EST 2023 aarch64 aarch64 aarch64 GNU/Linux
root@roc-rk3399-pc:~#

its in tmp.perf-tools-next, will move to perf-tools-next in the next batch, after build
tests together with other patches.

Thanks!

- Arnaldo

