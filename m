Return-Path: <linux-kernel+bounces-38740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A483C518
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148C2B24EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3496E2CD;
	Thu, 25 Jan 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNLztXyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA86E2C5;
	Thu, 25 Jan 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194011; cv=none; b=Qa5eyMibEhGCloMvTcqE4DQX0uRNreVjojVFzef8rbfU5SMi2tOsNlpL0kOYHD3992OcoMkb8jyZsUZS7+0hlhWM1oblquT8ZUbuJQS24hrDIaPFFIgDUB9xDNR3eJjQ0MfOpJDgHxbDzCI3HNUswkVuxHgN59AnBkdVtDx/yhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194011; c=relaxed/simple;
	bh=cxVwapVppq42oAZrH32flGGzQVK5S4EcrH9NiMkGKv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyKzDG6guXE5FOBp4f1YJCLjvPZSzu5PaK1Ea+WramX7qvuL4IWP7T9vhTBO1dvNZdqf5qeRCKlPlG1K18+9IDe5tGHig7fYEAlIx4PiEppyiGZlhf7TR4ZiGovGuaU6SYVY3MzUVyUipz/iqNDNLxKKc7/AOrg0tpfMrx65x3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNLztXyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA60FC433C7;
	Thu, 25 Jan 2024 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706194011;
	bh=cxVwapVppq42oAZrH32flGGzQVK5S4EcrH9NiMkGKv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNLztXycF0nsyMlSyvF/HgQiVL6IERit4V7eF/i+lrNGgBjQYe3Z3bnlP1D24kFlN
	 hDBFddZhY0VCLKqOT9FGTCsrJxZ20Hn01F2Zo88hVpEgfJ424CQQJQtoYaR974XT5f
	 hpG9b81m9mH690MKNVnl6cfK18YMTnyLxPcYOSsOkMVGmWVay1rKm7GgGUU7o3HgDE
	 36ZCHlvlIbJDSuWIA/e0GMFcqAvAbuJbTG5eI5vSwgoZz8743DypftYI3Xr3gQkEot
	 HNPxRRpLxVRmcfhhwN/3RufPuHh71RdGxY7e0Zyy3a9DsCh9iGNZ1VQlSjj53CQ9Cl
	 2dkZCgGEq6uIg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 730AA405B2; Thu, 25 Jan 2024 11:46:43 -0300 (-03)
Date: Thu, 25 Jan 2024 11:46:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ross Zwisler <zwisler@chromium.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Shirisha G <shirisha@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Fixes for 6.8 PR1
Message-ID: <ZbJ0U8QVZ1LIDuxg@kernel.org>
References: <20240124043015.1388867-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124043015.1388867-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 23, 2024 at 08:30:10PM -0800, Ian Rogers escreveu:
> Discovered some testing issues around perf list, perf script and perf
> daemon based on Linux 6.8-rc1. Some of the issues were discovered in
> the context of an Alderlake system.
> 
> v2 - address Namhyung's review comment and add his Acked-by.

Thanks, applied to perf-tools.

- Arnaldo

 
> Ian Rogers (5):
>   perf list: Switch error message to pr_err
>   perf list: Add output file option
>   perf test: Workaround debug output in list test
>   perf test: Fix script test for python being disabled
>   perf test: Make daemon signal test less racy
> 
>  tools/perf/Documentation/perf-list.txt |   4 +
>  tools/perf/builtin-list.c              | 211 +++++++++++++++----------
>  tools/perf/tests/shell/daemon.sh       |  34 ++--
>  tools/perf/tests/shell/list.sh         |  21 ++-
>  tools/perf/tests/shell/script.sh       |   3 +-
>  tools/perf/util/print-events.c         |   2 +-
>  6 files changed, 177 insertions(+), 98 deletions(-)
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

-- 

- Arnaldo

