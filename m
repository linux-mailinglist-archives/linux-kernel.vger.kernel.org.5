Return-Path: <linux-kernel+bounces-137238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCC89DF54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D371C21579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2CB13B59F;
	Tue,  9 Apr 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aByLc8KO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B813B293;
	Tue,  9 Apr 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676858; cv=none; b=ocoovgjLxqXAAYfwwCpEaOvkbIHertcZchi5xRHJNkiqJPMzl/k/f4mGbPgmQ51BfqT9qmaQCuon6K1oLSqOnNKFf4O+1vIV5e4rncxLy+Q4jKKrYoNrT4f5MDLKkXZ9+Hp6XtuTXhZFXnS7UCOHGjdGeIY9YECSjTGgWLwiP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676858; c=relaxed/simple;
	bh=UOhKabfItxET3ULoSOS1JWZmwpxrExFjqIzeLK3XjNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM9H8MunoHuh4O3r20466XdI5uGqdZTnPZR02EwiIUcaE4XcKSTHRD7oMsQSZ7M0JAqoEepvWxVhndZqtr8KVIZKmT7VvoHFQGxRX58oj2ZTFe2OFmZptewboNDF2+nbkojHr9WGAUZHzoS/IB8rMJDpEr4T+YWahL9T1sXOSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aByLc8KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BB1C433C7;
	Tue,  9 Apr 2024 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676857;
	bh=UOhKabfItxET3ULoSOS1JWZmwpxrExFjqIzeLK3XjNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aByLc8KOhk3SjmIeX3HiEE54zuWlvsuFrdFIVwpvFVM3e5WYptiYH59wRakil01eq
	 hswuvwpJv1LauKgQ1+/YCoeKmfgysYzXcoVpe/2NJQXqPaN8oOb1qUeCI/QjBAnRm4
	 jHQQOif0SSSG+nBuEcipU21PnnZahUSKPnYf8a+skI3Jjk+4fVBUEOj1kycQ5+Klr0
	 iEkfXktH0de/l2SIBAisWcd13Y/SoIeSErPPlXDO5FcZqeuFbtVVU3vQTutC8RBLGV
	 lnMiD00+1P4Q2ECpfe9h9tkOHJSIjFIviTYdJdYXl19MR07OPc4cPGTntozGYsx87L
	 Qphf/ugxeEHvQ==
Date: Tue, 9 Apr 2024 12:34:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BISECTED: perf test 'Miscellaneous Intel PT' failing on Intel
 hybrid machines
Message-ID: <ZhVf9rO-b3xTqZEK@x1>
References: <ZhVfc5jYLarnGzKa@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhVfc5jYLarnGzKa@x1>

On Tue, Apr 09, 2024 at 12:32:06PM -0300, Arnaldo Carvalho de Melo wrote:
> root@x1:~# perf test "Miscellaneous Intel PT testing"
> 112: Miscellaneous Intel PT testing                                  : FAILED!
> root@x1:~#
> 
> then I revert:
> 
> commit 642e1ac96aaa12aeb41402e68eac7faf5917a67a (HEAD -> perf-tools-next)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Apr 9 12:28:49 2024 -0300
> 
>     Revert "perf pmus: Check if we can encode the PMU number in perf_event_attr.type"
>     
>     This reverts commit 82fe2e45cdb00de4fa648050ae33bdadf9b3294a.
> ⬢[acme@toolbox perf-tools-next]$
> 
> It works now:
> 
> root@x1:~# perf -v
> perf version 6.8.g642e1ac96aaa
> root@x1:~# perf test "Miscellaneous Intel PT testing"
> 117: Miscellaneous Intel PT testing                                  : Ok
> root@x1:~#
> 
> Investigating, if you come up with ideas, lemme know.

Some more context:

When this patch was implemented/tested I had access only to an ARM64
hybrid machine, now my notebook is a Rocket Lake lenovo (13th gen), that
is hybrid and the test is failing with:

root@x1:~# perf test -v "Miscellaneous Intel PT testing"
112: Miscellaneous Intel PT testing                                  :
--- start ---
test child forked, pid 304355
--- Test system-wide sideband ---
Checking for CPU-wide recording on CPU 0
OK
Checking for CPU-wide recording on CPU 1
OK
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.934 MB /tmp/perf-test-intel-pt-sh.xACV6V7Hn4/test-perf.data ]
OK
--- Test per-thread recording ---
Workload PIDs are 304377 and 304378
perf PID is 304389
Waiting for "perf record has started" message
OK
pid 0 cpu -1 fd 5 : sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
pid 0 cpu -1 fd 6 : sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 6
pid 304377 cpu -1 fd 7 : sys_perf_event_open: pid 304377  cpu -1  group_fd -1  flags 0x8 = 7
pid 304380 cpu -1 fd 8 : sys_perf_event_open: pid 304380  cpu -1  group_fd -1  flags 0x8 = 8
pid 304378 cpu -1 fd 9 : sys_perf_event_open: pid 304378  cpu -1  group_fd -1  flags 0x8 = 9
pid 304381 cpu -1 fd 10 : sys_perf_event_open: pid 304381  cpu -1  group_fd -1  flags 0x8 = 10
pid 304377 cpu -1 fd 11 : sys_perf_event_open: pid 304377  cpu -1  group_fd -1  flags 0x8 = 11
pid 304380 cpu -1 fd 12 : sys_perf_event_open: pid 304380  cpu -1  group_fd -1  flags 0x8 = 12
pid 304378 cpu -1 fd 13 : sys_perf_event_open: pid 304378  cpu -1  group_fd -1  flags 0x8 = 13
pid 304381 cpu -1 fd 14 : sys_perf_event_open: pid 304381  cpu -1  group_fd -1  flags 0x8 = 14
fd 7 : idx 0: mmapping fd 7
fd 11 fd_to 7 : idx 0: set output fd 11 -> 7
fd 8 : idx 1: mmapping fd 8
fd 12 fd_to 8 : idx 1: set output fd 12 -> 8
fd 9 : idx 2: mmapping fd 9
fd 13 fd_to 9 : idx 2: set output fd 13 -> 9
fd 10 : idx 3: mmapping fd 10
fd 14 fd_to 10 : idx 3: set output fd 14 -> 10
Checking 10 fds
No mmap for fd 5

