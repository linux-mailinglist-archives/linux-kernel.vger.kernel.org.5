Return-Path: <linux-kernel+bounces-168163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC08BB482
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B6285B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C87158D78;
	Fri,  3 May 2024 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob9kBIFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB912EBFB;
	Fri,  3 May 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766974; cv=none; b=Fj4cS1gGGmxM2Ho9PoFw+bOItiJKU+5GRD21HFvv0k9p0/bsk4aykvKlP91rBOKxZMdxJRAnnWJ+GNOU1Q418vExdFA3vpaAnZ9mtj5yDPGoWwiF/WXN46wgUHN1RMHkNTcsau7UBIDL6zS4BpQ8fNVHnN2CNtIqdzg6sb8fjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766974; c=relaxed/simple;
	bh=4oGY0Pg1PsM+ff50czZR/Fug2cqi9hrlFUkpP2wDbUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqcDmnqq2BN3z1/72E8BXeSH6BaHLf3VgSt15ZqsjTggqXkcLoWeLA3ZgLJxwcb/4de43sGpeLxPbuxVFhpsmn7mcRddWsI4TQRHc4iYahPBEJcFjNVbcHyhLgfLY9XhPNDqMQ7qY7JhZghFMDQulLdABD5QGi0VxD5TkOvX2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob9kBIFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB4FC116B1;
	Fri,  3 May 2024 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714766973;
	bh=4oGY0Pg1PsM+ff50czZR/Fug2cqi9hrlFUkpP2wDbUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ob9kBIFCI8VxMmGvTiKxqSdBhFOXY6940QkqfEjyLzi4ikHx//6iATKTnO1cXuGu1
	 7B23DF2catUkHTsfIitXeR1xYtUX5RrB6Pfl7MX/na5bLU/9cD/SHbcZDePxxWsUL3
	 Sq6ahpP1N2w3Vv3WwGSqGJpeqbs6uRz6EL2KoSpr9p2JZtEpDLwRZTx4+jSPqhxO/x
	 esumHZVp1a8hgL5aiYL7A/k4WJ9mqMf/Hrs7qq06T9z/MG8s+qnnLdmnTpw+2lxJBR
	 mZXEGTnSoQb3NtvA0maZHDMGmEVEzrs8BaujS7TyP95KZe0CBfDbOeOHCGHpyTzZBi
	 wxQsprPrtAxBw==
Date: Fri, 3 May 2024 17:09:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Assume sysfs event names are always the same case
Message-ID: <ZjVEeuFPMknYI7_H@x1>
References: <20240502213507.2339733-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>

On Thu, May 02, 2024 at 02:35:01PM -0700, Ian Rogers wrote:
> By assuming sysfs events are either upper or lower case, the case
> insensitive event parsing can probe for the existence of files rather
> then loading all events in a directory. When the event is a json event
> like inst_retired.any on Intel, this reduces the number of openat
> calls on a Tigerlake laptop from 325 down to 255.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> v1 sent as an RFC:
>     https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/
> 
> v2: addresses review feedback from Kan Liang, by updating
>     documentation and adding tests.
> 
> v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
>     that s390 event names are all upper case. Do a lower case probe
>     then an upper case probe, make documentation and tests also agree.
> 
> v4: add checks to write (kernel test robot) and fix a typo.
> 
> v5: Add reviewed-by: Kan Liang and fix potential uninitialized use.
> 
> Ian Rogers (6):
>   perf test pmu-events: Make it clearer that pmu-events tests json
>     events
>   perf Document: Sysfs event names must be lower or upper case
>   perf test pmu: Refactor format test and exposed test APIs
>   perf test pmu: Add an eagerly loaded event test
>   perf test pmu: Test all sysfs PMU event names are the same case
>   perf pmu: Assume sysfs events are always the same case
> 
>  .../sysfs-bus-event_source-devices-events     |   6 +
>  tools/perf/tests/pmu-events.c                 |   2 +-
>  tools/perf/tests/pmu.c                        | 467 ++++++++++++------
>  tools/perf/util/parse-events.c                |   2 +-
>  tools/perf/util/parse-events.h                |   2 +-
>  tools/perf/util/pmu.c                         | 111 +++--
>  tools/perf/util/pmu.h                         |   4 +-
>  tools/perf/util/pmus.c                        |  16 +-
>  tools/perf/util/pmus.h                        |   2 +
>  9 files changed, 415 insertions(+), 197 deletions(-)
> 
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

