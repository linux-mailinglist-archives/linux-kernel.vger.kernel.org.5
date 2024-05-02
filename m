Return-Path: <linux-kernel+bounces-166560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104CB8B9C69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C550E2839E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBEE15358E;
	Thu,  2 May 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAIBRS9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C9153587;
	Thu,  2 May 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660538; cv=none; b=Sg4H8t/iR3q/3eqiygcd3O3zIRuG+i3ogVGu8AJ1eKH3eTsjPssASoW5fhLEJ3/2bNHHUiEdlOT9QgBT0thGkXcTVaY7qCOpvk8BnVdJKAngDTqhxKlSyfSOW5FQFHHJgCUx907e9jK6BmsVlJwTtgaSXdQLGoHoh9Ql8xA87Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660538; c=relaxed/simple;
	bh=sMBrADE2JhJ9VMLmjn6LuipV096YR1K8BaZa4eR/Ixo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM0/ere2IA/iMr40b/u7oi0GX3iDlRsBifFhkcBejiV6XNpv7m7ViKezIHBSQzvSE5r3wpAEik/dqYp8VLsR7I35ln2P86bl8NomVccE4Vtlc+rn9O8xMKsi0kqxpcp53jkwOyZx3KfCyeW4NmCBdwVf6QCl8vgXDbeuPmhWgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAIBRS9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A6BC32789;
	Thu,  2 May 2024 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660538;
	bh=sMBrADE2JhJ9VMLmjn6LuipV096YR1K8BaZa4eR/Ixo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAIBRS9gHglqAT+OihBqCDSlaDcFZnWoDSUUvAORPeblpWZHx1MEETR5IoOxSMFnf
	 tqUNQvFkO2GXRPoMQHNN9vVJhFE0pr7sccx8R6LH0JtJ95+Qp5ECtZzStnnHxSrMt9
	 xs5WyftoiwJkAZOGs4rrAPj+ib8z20/KMLWBBnlxN5t4BT8vkDgeLoVb9SGraSCyvh
	 xkOw0/Ed51wD5F9SXQcncJrLzqcuf3PecnfsUf4TRFRFO/DtG0JNAsHyVSLTcwhtpg
	 MkHLa/FvY8OLgJJR5S3lakkAaxiJ5otVrG1vWJTk0ues5kKEF/GCac8Orj5Km78JIU
	 WjWqwRncBYJig==
Date: Thu, 2 May 2024 11:35:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
	leo.yan@linux.dev, irogers@google.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf cs-etm: Improve version detection and error
 reporting
Message-ID: <ZjOktWrI2-Db1sNH@x1>
References: <20240501135753.508022-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501135753.508022-1-james.clark@arm.com>

On Wed, May 01, 2024 at 02:57:50PM +0100, James Clark wrote:
> Changes since v1:
>   * Add a commit to use struct perf_cpu in place of some of the ints
>   * Add a commit to remove repeated fetches of the ETM PMU

Thanks, applied to perf-tools-next locally, going thru tests.

- Arnaldo
 
> James Clark (3):
>   perf cs-etm: Use struct perf_cpu as much as possible
>   perf cs-etm: Remove repeated fetches of the ETM PMU
>   perf cs-etm: Improve version detection and error reporting
> 
>  tools/perf/arch/arm/util/cs-etm.c | 287 +++++++++++++++---------------
>  1 file changed, 139 insertions(+), 148 deletions(-)
> 
> -- 
> 2.34.1

