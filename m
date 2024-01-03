Return-Path: <linux-kernel+bounces-15762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEE823168
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195BE285BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646631BDE1;
	Wed,  3 Jan 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+cJ4oK0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DB1BDCE;
	Wed,  3 Jan 2024 16:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC1C433CA;
	Wed,  3 Jan 2024 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704300151;
	bh=W3VpZjffXk3hT12TW9hTJXygFOk8lCYLKgul5isBSrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+cJ4oK0Su0pORAHADbdE/gHNovOTnqzThinrLsqwYxS8umjkY0cUxB0hSQJ8C7ho
	 pd7dh9zSyajdeBEFYlmtV+7sQbQrhHRikvZiXB2U7aS//l9jdL6+1GxoAu7/a/ivj5
	 kYWXINkfs6heAqltnYmJyMS+7G7c4Ca1ngjVxvyq57lXVN2VC4bOHPxWkq+84mzlIV
	 +9xDNjUWL3Ys0aN/gclesKI0hgTe3NxofpYk4aYfktj9V7O90UPIvitRjRv35CNBhN
	 5ssWerzeJiH7ZbhAJQuWJFiLsRDo0JO9zcLlcU2a2RbFmimDucd7K/V5Advr9O7NeX
	 w3+xLwmf8VhHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 90C0A403EF; Wed,  3 Jan 2024 13:42:28 -0300 (-03)
Date: Wed, 3 Jan 2024 13:42:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf x86 test: Update hybrid expectations
Message-ID: <ZZWOdHXJJ_oecWwm@kernel.org>
References: <20240102215732.1125997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102215732.1125997-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 02, 2024 at 01:57:32PM -0800, Ian Rogers escreveu:
> The legacy events cpu-cycles and instructions have sysfs event
> equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
> events are now higher in priority than legacy events this causes the
> hybrid test expectations not to be met. To fix this switch to legacy
> events that don't have sysfs versions, namely cpu-cycles becomes
> cycles and instructions becomes branches.
> 
> Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
> Signed-off-by: Ian Rogers <irogers@google.com>

With it:

root@number:/home/acme# perf test hybrid
 71: Intel PT                                                        :
 71.2: Intel PT hybrid CPU compatibility                             : Ok
 75: x86 hybrid                                                      : Ok
root@number:/home/acme#

Applied.

Now to look at this on this hybrid system (14700K):

101: perf all metricgroups test                                      : FAILED!

Testing Mem
event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=1,metric-id=cpu_core!3UNC_ARB_DAT_OCCUPANCY.RD!0cmask!21!3/,UNC_ARB_DAT_OCCUPANCY.RD/metric-id=UNC_ARB_DAT_OCCUPANCY.RD/}:W,du..'
                               \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu_core'

Initial error:
event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=1,metric-id=cpu_core!3UNC_ARB_DAT_OCCUPANCY.RD!0cmask!21!3/,UNC_ARB_DAT_OCCUPANCY.RD/metric-id=UNC_ARB_DAT_OCCUPANCY.RD/}:W,du..'
                               \___ unknown term 'UNC_ARB_DAT_OCCUPANCY.RD' for pmu 'cpu_core'

valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,percore,metric-id
test child finished with -1
---- end ----
perf all metricgroups test: FAILED!
root@number:/home/acme# grep -m1 "model name" /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-14700K
root@number:/home/acme# 


root@number:/home/acme# ls -la /sys/devices/uncore_
uncore_arb_0/              uncore_cbox_1/             uncore_cbox_2/             uncore_cbox_5/             uncore_cbox_8/             uncore_imc_0/              uncore_imc_free_running_1/
uncore_arb_1/              uncore_cbox_10/            uncore_cbox_3/             uncore_cbox_6/             uncore_cbox_9/             uncore_imc_1/              
uncore_cbox_0/             uncore_cbox_11/            uncore_cbox_4/             uncore_cbox_7/             uncore_clock/              uncore_imc_free_running_0/ 
root@number:/home/acme# ls -la /sys/devices/uncore_


102: perf all metrics test                                           : FAILED!

event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=1,metric-id=cpu..'
                               \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu_core'

Initial error:
event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=1,metric-id=cpu..'
                               \___ unknown term 'UNC_ARB_DAT_OCCUPANCY.RD' for pmu 'cpu_core'

valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,percore,metric-id


Testing UNCORE_FREQ
Metric 'UNCORE_FREQ' not printed in:
event syntax error: '{tma_info_system_socket_clks/metric-id=tma_info_system_s..'
                      \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'tma_info_system_socket_clks'

Initial error:
event syntax error: '{tma_info_system_socket_clks/metric-id=tma_info_system_s..'
                      \___ Cannot find PMU `tma_info_system_socket_clks'. Missing kernel support?
Testing tma_info_system_socket_clks

- Arnaldo

