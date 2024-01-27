Return-Path: <linux-kernel+bounces-41380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B783EFD3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721DC1F2313F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB582E634;
	Sat, 27 Jan 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGCDGmW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9632A1C9;
	Sat, 27 Jan 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384820; cv=none; b=A/msNkDANBUPEzkSJN75JDrePT18NDHOiFOf3C/eeov+/7qqOdFD3PXFi6X6cstjmMC2TRXPufw0a4S4mJwzIm6AXTc5seCrCqycH19e1pWUdT4o72s3aWtB+fn86t2JXLT4uHUeVH4vH637cwjFTrruJynj3G37HQEIcCsv66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384820; c=relaxed/simple;
	bh=9wu/rXDEi0M+UJTHlnsY5RuZUwgSUdzZITIxuYPhs7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DUsw1wdHpfUnIW6Hp53Nc8F4Acl943Ayg9D+8mXUICr8dbSXZIdZUDSQRSbmH++uOsKSS4j2oSt6poM/VU8T5Y0uhHrvc35nNIbL3V1G1nPcQ7cVxRPXjg9s9gyoRaUqTB335FlGMQAXCxSLndpdWUGmRJm2wqFcKSjehbFuIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGCDGmW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92791C433F1;
	Sat, 27 Jan 2024 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706384819;
	bh=9wu/rXDEi0M+UJTHlnsY5RuZUwgSUdzZITIxuYPhs7A=;
	h=Date:From:To:Cc:Subject:From;
	b=AGCDGmW4dyGZ7bY47P5RPoOutHDW6imACdiY+XOeSzi8lvzVSRZvf3eXSgvxKq3IA
	 KwHp9A2uj2lxxLBBKKjBXNfBwWuQoUJ4TCK8iqDWKVt3uKJErm7FQmdfZ1su3eZqcL
	 p6AAvR40FTcKmiV6fH4BQf0yJe0rQdAT5AkjO5DFS5j7Ve2C/wVaAJAR4GBoWDwUq3
	 /J98xRQMe1zLyncr9fddteTDvNbHW47fnNHJI07Vzb/yR9euH80tAW8w9D1Yp/TsVI
	 KwSAxoWvJ+BMUtYdkSxs/rKMADfjUWP+EV5rtThuyr24KgdNh/JVEK0ambzYG/0wPR
	 BXDZMRyddCyPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5017240441; Sat, 27 Jan 2024 16:46:57 -0300 (-03)
Date: Sat, 27 Jan 2024 16:46:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: perf test bpf-counters failing on some hybrid machines
Message-ID: <ZbVdsbIUQMqHol7V@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

IIRC there is a patch by Thomas Richter for s390 for this? I'll check

Fails:

root@number:~# uname -a
Linux number 6.6.13-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Jan 20 18:03:28 UTC 2024 x86_64 GNU/Linux
root@number:~#
root@number:~# perf test -v 106
106: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 997337
The difference between 292281328 and 383336121 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
root@number:~# grep -m1 "model name" /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-14700K
root@number:~#

Fails sometimes:

root@x1:~# uname -a
Linux x1 6.6.13-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Jan 20 18:03:28 UTC 2024 x86_64 GNU/Linux
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# grep -m1 "model name" /proc/cpuinfo
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test 106
106: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test -v 106
106: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 279934
test child finished with 0
---- end ----
perf stat --bpf-counters test: Ok
root@x1:~# perf test -v 106
106: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 280029
The difference between 261175698 and 219929411 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
root@x1:~# perf test -v 106
106: perf stat --bpf-counters test                                   :
--- start ---
test child forked, pid 280124
The difference between 251455173 and 299125735 are greater than 10%.
test child finished with -1
---- end ----
perf stat --bpf-counters test: FAILED!
root@x1:~#



- Arnaldo

