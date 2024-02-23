Return-Path: <linux-kernel+bounces-78539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360688614B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA59B1F21231
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E20127B48;
	Fri, 23 Feb 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om1OHLt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100101272B5;
	Fri, 23 Feb 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699760; cv=none; b=kUb1SHhXYZQELllEHYgGCW77iALy2PwA7TsUJoXpvoVGu/KqdrfmMCZ0jcx8NrOA6qdW61SGeSt/JUAzN5NC2+BYYpdDJ5ALeIqFxuQftdRN3JDslv/X8ipjjfuatWCfbTubLCKO62iqj8OHogZ0OsZgUev2MStLU8rX5emEhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699760; c=relaxed/simple;
	bh=PEc1cihrzX0ifdXmwzn5PbXGXkCz3NEiplMz3IcV62M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YR6uSxdKLKI/IKbXJe01eqiOmlW8Pgj2Zsbg7v85U1Ee6OlRB56hUPzfrfWcnyxBjVqQosZlRyGdstdTu/o8iqhy0vbqReRPBrBzVXvtSayyt1jXgTIpmiqxvPRN0tZQ0qRBrEdFkwoFAYzxYED+RgwjNzrAabuCLVsTwR0Dn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om1OHLt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A1FC433B2;
	Fri, 23 Feb 2024 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699759;
	bh=PEc1cihrzX0ifdXmwzn5PbXGXkCz3NEiplMz3IcV62M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Om1OHLt0MhTFZLBFunKGxQ4jvDKzGUyDVwjxBB7OSG7AMWKq+AWf06xg45mWcdH+a
	 IriIvRcHPRpMYFP4bGA1yU3oyt8MS1LDnBnC+9Hwbv10mB6BJ3H2CGrbg7rLf8QbOy
	 zaW8JSbPU08sC1UI/8m7qZ2IjyLtYfJZCTWVvodBXlMGMkjEDST3zPDXi8eUeGP8pC
	 fWZMVaRFE3uA3s3z67sG1Mt19dgmYDjFeSlrG0WJtkpiHbKxvTh6hSfwK+HiVNEzDk
	 dyAOvQrmI8sB0Lr0oxt93jYw5mGoK9pNZprS2qkAGmPagrRL1oPMvkA906so1Ggohg
	 mUWCYUv6WnWUw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rdWrV-0067Ic-6S;
	Fri, 23 Feb 2024 14:49:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Feb 2024 14:49:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, irogers@google.com,
 james.clark@arm.com, john.g.garry@oracle.com, leo.yan@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 marcan@marcan.st, mike.leach@linaro.org, namhyung@kernel.org,
 suzuki.poulose@arm.com, tmricht@linux.ibm.com, will@kernel.org
Subject: Re: [PATCH v2] perf print-events: make is_event_supported() more
 robust
In-Reply-To: <20240126145605.1005472-1-mark.rutland@arm.com>
References: <20240126145605.1005472-1-mark.rutland@arm.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <8bc9dcbab11aa25115d0d278d353188e@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-kernel@vger.kernel.org, acme@redhat.com, irogers@google.com, james.clark@arm.com, john.g.garry@oracle.com, leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, marcan@marcan.st, mike.leach@linaro.org, namhyung@kernel.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-01-26 14:56, Mark Rutland wrote:
> Currently the perf tool doesn't detect support for extended event types
> on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> hardware events into per-PMU events. This is due to the detection of
> extended event types not handling mandatory filters required by the
> M1/M2 PMU driver.
> 
> PMU drivers and the core perf_events code can require that
> perf_event_attr::exclude_* filters are configured in a specific way and
> may reject certain configurations of filters, for example:
> 
> (a) Many PMUs lack support for any event filtering, and require all
>     perf_event_attr::exclude_* bits to be clear. This includes Alpha's
>     CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
>     ARMv7,
> 
> (b) When /proc/sys/kernel/perf_event_paranoid >= 2, the perf core
>     requires that perf_event_attr::exclude_kernel is set.
> 
> (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
>     set as the hardware PMU does not count while a guest is running 
> (but
>     might be extended in future to do so).
> 
> In is_event_supported(), we try to account for cases (a) and (b), first
> attempting to open an event without any filters, and if this fails,
> retrying with perf_event_attr::exclude_kernel set. We do not account 
> for
> case (c), or any other filters that drivers could theoretically require
> to be set.
> 
> Thus is_event_supported() will fail to detect support for any events
> targeting an Apple M1/M2 PMU, even where events would be supported with
> perf_event_attr:::exclude_guest set.
> 
> Since commit:
> 
>   82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number
> in perf_event_attr.type")
> 
> ... we use is_event_supported() to detect support for extended types,
> with the PMU ID encoded into the perf_event_attr::type. As above, on an
> Apple M1/M2 system this will always fail to detect that the event is
> supported, and consequently we fail to detect support for extended 
> types
> even when these are supported, as they have been since commit:
> 
>   5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE 
> capability")
> 
> Due to this, the perf tool will not automatically expand plain
> PERF_TYPE_HARDWARE events into per-PMU events, even when all the
> necessary kernel support is present.
> 
> This patch updates is_event_supported() to additionally try opening
> events with perf_event_attr::exclude_guest set, allowing support for
> events to be detected on Apple M1/M2 systems. I believe that this is
> sufficient for all contemporary CPU PMU drivers, though in future it 
> may
> be necessary to check for other combinations of filter bits.
> 
> I've deliberately changed the check to not expect a specific error code
> for missing filters, as today ;the kernel may return a number of
> different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
> -EOPNOTSUPP) depending on why and where the filter configuration is
> rejected, and retrying for any error is more robust.
> 
> Note that this does not remove the need for commit:
> 
>   a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower
> priority than sysfs/JSON")
> 
> ... which is still necessary so that named-pmu/event/ events work on
> kernels without extended type support, even if the event name happens 
> to
> be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case 
> for
> the M1/M2 PMU's 'cycles' and 'instructions' events).
> 
> Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU
> number in perf_event_attr.type")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Ian Rogers <irogers@google.com>
> Tested-by: James Clark <james.clark@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>

Tested-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...

