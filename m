Return-Path: <linux-kernel+bounces-168174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55E8BB4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7271C2303C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D0158D99;
	Fri,  3 May 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrUd5XS8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04C157E62;
	Fri,  3 May 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767672; cv=none; b=t6xDIwKc/SkavF2x1K81DtpE7bktwgtBIbh9kdpxcSTpkPm0lBanYwz8HlTChZVagQTJBM1iUnNrhUVq5b31gUBRuHehE+7OP5cNbK2OAwz0eyPVgVxMjw/unZUAHchIJmOh/tzHz/w6m1CzfXIk4/Frdls6NfR4OmhFbJzNqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767672; c=relaxed/simple;
	bh=ybKkS+1yGYkf7MFehjLArh675WknPQu5/9lQl5Hso90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfjhAeUcS0Mk2xSS5m1QvI7GtLm1Rplu21ElFT3kSMP4ntO+m8FU65Zn5Q2SLzwDfg7Ty0f1IFBkewdLNzXXFQvvHfCjL+fNPIEZ+2OJWHj1OvdwDwJ0kKkCKVj60gJkyMf4TnjIpB6UW/l15yc8nabwBhs9BBBm8JqdIlCXBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrUd5XS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058C7C116B1;
	Fri,  3 May 2024 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714767671;
	bh=ybKkS+1yGYkf7MFehjLArh675WknPQu5/9lQl5Hso90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrUd5XS8OGzs8O+Z0BXHye0IFQANFQqvVkAGISHp6VQsdCuX146vOsckPdr8KJ/IT
	 Ji9z3Jruw8RbHT8f4SjhonjFJxAoTlFtooUI9Q//8ZmSLdUUE7OJqTMzCMwNTmaIem
	 i1srsf1JCnS6lOcamUIu1StficWnJLokgQtU9Cwp4GJorqji69fYmk/KN1PNXURw52
	 jaExLfk0ol8Qk2YSUQwLMG/Z6WHRzNBAfKk57p/iZRyTa3cSsEM6/h9wZSCScqpBA/
	 6wx1StqU+TvpRJ6gvHUDaGwXnnWCeb42nA4NYPlNHK9kmKn9gLjqCt2784H+fNLwn7
	 x3u9pjrQvVdbQ==
Date: Fri, 3 May 2024 17:21:08 -0300
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
Subject: Re: [PATCH v5 1/7] perf dsos: Switch backing storage to array from
 rbtree/list
Message-ID: <ZjVHNB7pTKKWERFn@x1>
References: <20240429184614.1224041-1-irogers@google.com>
 <20240429184614.1224041-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429184614.1224041-2-irogers@google.com>

On Mon, Apr 29, 2024 at 11:46:08AM -0700, Ian Rogers wrote:
> DSOs were held on a list for fast iteration and in an rbtree for fast
> finds. Switch to using a lazily sorted array where iteration is just
> iterating through the array and binary searches are the same
> complexity as searching the rbtree. The find may need to sort the
> array first which does increase the complexity, but add operations
> have lower complexity and overall the complexity should remain about
> the same.

With just this first one applied:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
325557715f1d8593 (HEAD) perf dsos: Switch backing storage to array from rbtree/list
7b6dd7a923281a7c perf pmu: Assume sysfs events are always the same case
6debc5aa326fa2ee perf test pmu: Test all sysfs PMU event names are the same case
18eb2ca8c18f0612 perf test pmu: Add an eagerly loaded event test
aa1551f299ba414c perf test pmu: Refactor format test and exposed test APIs
785623ee855e893d perf Document: Sysfs event names must be lower or upper case
97c48ea8ff1cd70f perf test pmu-events: Make it clearer that pmu-events tests JSON events
3cdd98b42d212160 (x1/perf-tools-next) perf maps: Remove check_invariants() from maps__lock()
e3123079b906dc2e perf cs-etm: Improve version detection and error reporting
bc5e0e1b93565e37 perf cs-etm: Remove repeated fetches of the ETM PMU
⬢[acme@toolbox perf-tools-next]$

root@number:~# perf -v
perf version 6.9.rc5.g325557715f1d
root@number:~# perf probe -l
DSO [kernel.kallsyms] is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/hid/hid-sensor-hub.ko.xz is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/hid/uhid.ko.xz is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/net/tun.ko.xz is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/fs/overlayfs/overlay.ko.xz is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/net/bluetooth/rfcomm/rfcomm.ko.xz is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/input/misc/uinput.ko.xz is still in rbtree when being deleted!
DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/sound/core/seq/snd-seq-dummy.ko.xz is still in rbtree when being deleted!
<SNIP a lot of other modules, probably all of them>

Then with:

65e1e704f37916a0 (HEAD -> perf-tools-next) perf dsos: Switch hand code to bsearch
64377d6b7d5f9a71 perf dsos: Remove __dsos__findnew_link_by_longname_id
8e773b8be95aff66 perf dsos: Remove __dsos__addnew
b1d064fc9b912ece perf dsos: Switch backing storage to array from rbtree/list

applied it continues like that, the next patch in line isn't applying.

I'll push what I have to tmp.perf-tools-next.

- Arnaldo

