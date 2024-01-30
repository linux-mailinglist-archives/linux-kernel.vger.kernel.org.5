Return-Path: <linux-kernel+bounces-44722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A31842684
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9264828E230
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0956D1CB;
	Tue, 30 Jan 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7hZ76Vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFE6D1B1;
	Tue, 30 Jan 2024 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622963; cv=none; b=OqqpW28sy++GOEiS11UaMlyU4pPE2QGFNy8VOf4EBAl/mz5HHZ257gIvEX22hEQlytnLZmbVmaZPb2AqnpS8O8E/o2Zjw850qAm0IBQxxSLdtII/WZE0xlnoeGbJyA9VYNWk42WAPMoKVWs0ylwT23vdtiGRgb2I5xiXGJJBFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622963; c=relaxed/simple;
	bh=6kOSaJfqPSlJRouPhGEV8c/CvXVYQ46pRD4QgFVwYZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQYGExTfZfU+6qYSRZzu21tAbbmWh63iCIpzM33q51QghetSP3jASGSW6dYAunNEeWl9EWOW3LRZPZdL5Dv0ZVBIzXsfLL56gqha/txYpkMsmeaHHzLu2B5LTcG0bgwkfZK3CypfXHycofuxoMKd2JLpTSe0UKHnJrzrpxqANr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7hZ76Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C33BC43394;
	Tue, 30 Jan 2024 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706622963;
	bh=6kOSaJfqPSlJRouPhGEV8c/CvXVYQ46pRD4QgFVwYZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7hZ76Vk1Em6icF9OhasDsoYYK0WkRj27XOXCvffrY+h0S43BNXsnVZHHr8QPcJLe
	 VCpq5YoIKKVUFVOk+H+A6YsGej/kVNfOeuYD733hXkemmB0PwUHGM4bTCCzxfDB/2d
	 5RKfiw0zKLq6/Wd40VX36BOS2U3fQewkQcgFL29/YcSptsW3MGY/ggN4M6YakTgzqD
	 buryrKgyDY40/8Qgd3hnVkNFEk6/BMN7PU71pG24DTEHlf2TptqY21xaLSRf32b9ii
	 aq7VnBh3ehIwHnzigdXKleeopI2C2qdL3IlzQ1OL9KLogpqyO0e5ETVJF1bkG9VbLR
	 qMXEWfPsFtt5g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4E31940441; Tue, 30 Jan 2024 10:56:00 -0300 (-03)
Date: Tue, 30 Jan 2024 10:56:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf test hybrid failing on 14700K
Message-ID: <Zbj_8KkXWnCJB-8M@kernel.org>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jan 19, 2024 at 10:09:10PM -0800, Ian Rogers escreveu:
> On Sat, Dec 23, 2023 at 5:55 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Hi Kan,
> >
> > I noticed the following problem, are you able to reproduce it?
> >
> > Happy solstice!
> >
> > - Arnaldo
> 
> Hi Arnaldo,
> 
> I'm seeing a test failure on Alderlake in perf-tools-next and wondered
> if it was on your radar:
> ```
>  32: Session topology                                                :
> --- start ---
> test child forked, pid 539222
> templ file: /tmp/perf-test-HMet21
> Using CPUID GenuineIntel-6-97-2
> ------------------------------------------------------------
> perf_event_attr:
>  type                             0 (PERF_TYPE_HARDWARE)
>  config                           0x800000000
>  disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 4
> ------------------------------------------------------------
> perf_event_attr:
>  type                             0 (PERF_TYPE_HARDWARE)
>  config                           0x400000000
>  disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
> non matching sample_type
> FAILED tests/topology.c:73 can't get session
> test child finished with -1
> ---- end ----
> Session topology: FAILED!
> ```
> 
> The code is hitting this line in evlist__valid_sample_type as
> core.nr_entries is 2 on hybrid not 1:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n1215
> this causes perf_session__open to fail:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/session.c?h=perf-tools-next#n129

Yes, I see this as well, haven't yet analysed it

root@number:~# perf test -v topology
 38: Session topology                                                :
--- start ---
test child forked, pid 260120
templ file: /tmp/perf-test-WMa4M5
Using CPUID GenuineIntel-6-B7-1
non matching sample_type
FAILED tests/topology.c:73 can't get session
test child finished with -1
---- end ----
Session topology: FAILED!
root@number:~#

