Return-Path: <linux-kernel+bounces-162895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D298B61D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E081C211E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE913AD30;
	Mon, 29 Apr 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNHmifh3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42212B73;
	Mon, 29 Apr 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418223; cv=none; b=gTgd3U9PL9EYQ60kBHbEdV5L2o15XdVSuQChguWoEs+/kWZBpZ1q5EiAmL3dcDUN35K2CREuGZaHE/7qvYyA1PQ1Q0GhIgdF9983M9Ok8J4A6uuFmCaLCi9Gedc0UcEafjyvB1nEYqqArd/f1scSyfHizON+1R0524Cns+SRNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418223; c=relaxed/simple;
	bh=fCaAngOuXgNFJdHQQ0Scvj6xvPVUn9bKXe5Ku+a2DgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8KtGzlr2/kzUFTV5RnPX3jipRhRSx9prqh6rSJki37726SxYt0kX+gWr4z98uWO+wzdCcSnXKlv2/b7aR+A9fpnW5ZGmGn7+L1M2RUbzgvCHIxY0Do4uV35h9q95vTWekSUzXC1BmyPz0jgC2RBUmlZgDo2HhFWGA7keAYcW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNHmifh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429FAC113CD;
	Mon, 29 Apr 2024 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714418222;
	bh=fCaAngOuXgNFJdHQQ0Scvj6xvPVUn9bKXe5Ku+a2DgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNHmifh3gp2/W1XTWAdnv1C1TNWCtJWYUTBB1oUkcZVUOkVVqox4TFMT38U6d6dPe
	 CG9zwvPw15AlOyqrjFtEuWODF5mmkVq9/uZfG4764HLBSJFUnSoNsGSa2/xmEPt5kF
	 m7Ncz0eQvjL8AczE0CzEntXOnZcSfXpt+Cu31adH1DOpk/DUViu3Yoyghj1wlnxvsL
	 Z7pQrxj9ufqweP+i+ijqxIBGq3vJRkYcx9REZrxm81z5AHhhHCUlzML43bwRSW0J1X
	 bSCMxoHICGDA6XIMwnml8kP+HFSFYi7yDhNbLGXLhnDgd7/OqfBTEVlNJ5Nt3MoJCp
	 c0i0eAEjkaGcg==
Date: Mon, 29 Apr 2024 16:16:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] dso/dsos memory savings and clean up
Message-ID: <Zi_yKzGMoDU0-L3K@x1>
References: <20240429184614.1224041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429184614.1224041-1-irogers@google.com>

On Mon, Apr 29, 2024 at 11:46:07AM -0700, Ian Rogers wrote:
> 7 more patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> a near half year old adventure in trying to lower perf's dynamic
> memory use. Bits like the memory overhead of opendir are on the
> sidelines for now, too much fighting over how
> distributions/C-libraries present getdents. These changes are more
> good old fashioned replace an rb-tree with a sorted array and add
> reference count tracking.
> 
> The changes migrate dsos code, the collection of dso structs, more
> into the dsos.c/dsos.h files. As with maps and threads, this is done
> so the internals can be changed - replacing a linked list (for fast
> iteration) and an rb-tree (for fast finds) with a lazily sorted
> array. The complexity of operations remain roughly the same, although
> iterating an array is likely faster than iterating a linked list, the
Th> memory usage is at least reduced by half.
> 
> As fixing the memory usage necessitates changing operations like find,
> modify these operations so that they increment the reference count to
> avoid races like a find in dsos and a remove. Similarly tighten up
> lock usage so that operations working on dsos state hold the
> appropriate lock. Note, since this series is partially applied in the
> perf-tools-next tree currently some memory leaks have been introduced.
> 
> v5. Rebase, adding use of accessors to dso as necessary. Previous
>     versions were all rebases or dropping merged patches.

So, on an Intel machine:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -8
fb401385575211e6 (HEAD -> perf-tools-next) perf dso: Use container_of to avoid a pointer in 'struct dso_data'
0fe118d129ab1c77 perf dso: Reference counting related fixes
35e44adf6103a407 perf dso: Add reference count checking and accessor functions
35673675ebbbac5d perf dsos: Switch hand code to bsearch()
654d60f2f5c737cd perf dsos: Remove __dsos__findnew_link_by_longname_id()
94b0ba802e090b66 perf dsos: Remove __dsos__addnew()
47692286dd856469 perf dsos: Switch backing storage to array from rbtree/list
8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-tools-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the default
⬢[acme@toolbox perf-tools-next]$

When I'm at:

8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-tools-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the default

root@x1:~# perf -v
perf version 6.9.rc5.g8c618b58c89c
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : Ok
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : Ok
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : Ok
root@x1:~# time perf test "lock contention"
 87: kernel lock contention analysis test                            : Ok

real	0m9.143s
user	0m5.201s
sys	0m4.812s
root@x1:~#

Moving to the first patch in this series:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -2
47692286dd856469 (HEAD) perf dsos: Switch backing storage to array from rbtree/list
8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-tools-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the default
⬢[acme@toolbox perf-tools-next]$ alias m
alias m='rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test pythond'
⬢[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/ ; m
<SNIP>

root@x1:~# perf -v
perf version 6.9.rc5.g47692286dd85
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test -vvv "lock contention"
 87: kernel lock contention analysis test:
--- start ---
test child forked, pid 2279518
Testing perf lock record and perf lock contention
[Fail] Recorded result count is not 1: 2
---- end(-1) ----
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~#

This breaks bisectability, but then lets see if at the end of the series
it works:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -8
fb401385575211e6 (HEAD -> perf-tools-next) perf dso: Use container_of to avoid a pointer in 'struct dso_data'
0fe118d129ab1c77 perf dso: Reference counting related fixes
35e44adf6103a407 perf dso: Add reference count checking and accessor functions
35673675ebbbac5d perf dsos: Switch hand code to bsearch()
654d60f2f5c737cd perf dsos: Remove __dsos__findnew_link_by_longname_id()
94b0ba802e090b66 perf dsos: Remove __dsos__addnew()
47692286dd856469 perf dsos: Switch backing storage to array from rbtree/list
8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-tools-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the default
⬢[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/ ; m

root@x1:~# perf -v
perf version 6.9.rc5.gfb4013855752
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test "lock contention"
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~# perf test -vvv "lock contention"
 87: kernel lock contention analysis test:
--- start ---
test child forked, pid 2289060
Testing perf lock record and perf lock contention
Testing perf lock contention --use-bpf
Testing perf lock record and perf lock contention at the same time
[Fail] Recorded result count is not 1: 2
---- end(-1) ----
 87: kernel lock contention analysis test                            : FAILED!
root@x1:~#

⬢[acme@toolbox perf-tools-next]$ gcc --version | head -1
gcc (GCC) 13.2.1 20240316 (Red Hat 13.2.1-7)
⬢[acme@toolbox perf-tools-next]$ rpm -q gcc
gcc-13.2.1-7.fc39.x86_64
⬢[acme@toolbox perf-tools-next]$

root@x1:~# grep -m1 'model name' /proc/cpuinfo 
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~# free
               total        used        free      shared  buff/cache   available
Mem:        32507912     9081644     3531432     1987616    22554868    23426268
Swap:        8388604      314112     8074492
root@x1:~#

- Arnaldo

