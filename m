Return-Path: <linux-kernel+bounces-164671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B698B80E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB16287BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325F1A0AEA;
	Tue, 30 Apr 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lVj8mn6u"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83B19DF76
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506691; cv=none; b=LG0llmkEOjSBW730pLC0FgmcDD1+Pr2ZZsNRzyIPTP14Ug4seUnTquL4K5nel8cuW7vHtOKKY7LezYXq6KNjMIZLAsvdlMSyNkSLRVaKLsKIWDFAv42HLcVZJAkqXn/d4kASuHJWDARfIgGU6mklhMqBeNCVDZNOhGiDpUs8gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506691; c=relaxed/simple;
	bh=UaWvjoeb7IZoqPjtDztFt9cR9SgGUbKqNmmeR3hoe0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sViH1FOesyDBdXfagKZw+kXDCH4Z97/+oPDgHNRhKrg4Ha0ZDje0PhvMxEgEjIpAaQXVXnn43dP0D3+Cho3dPrq+IN/mG8QgCujI9EJlh2bGGfmOj0w7nkuEAwDm18ajwAnHC4BHfJdJC6z23qTa2e7uX1ErFkzoXRVANeXElU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lVj8mn6u; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 03:51:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714506687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ghnc7A+qj4DHw76Zc4PmkMS/7KxAwj/kz5TlaQ90WZI=;
	b=lVj8mn6ue9G0BSVmk14Q+jPSoq2w3ywceBLRrdQrxNI6hh143C5M4hONAgoZ1Tenwfa7jv
	x3OBEdOgt1d0Krs44Hruq1VeMnmIXJRBftrk6lj/9QH7xQmgLHTCmrGV9JgojeaJlhbEbH
	+K0IGz0MeHhX28uYqptwDflPnT+eOys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Improve version detection and error
 reporting
Message-ID: <20240430195124.GD125@debian-dev>
References: <20240430133221.250811-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430133221.250811-1-james.clark@arm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 02:32:21PM +0100, James Clark wrote:
> When the config validation functions are warning about ETMv3, they do it
> based on "not ETMv4". If the drivers aren't all loaded or the hardware
> doesn't support Coresight it will appear as "not ETMv4" and then Perf
> will print the error message "... not supported in ETMv3 ..." which is
> wrong and confusing.
> 
> cs_etm_is_etmv4() is also misnamed because it also returns true for
> ETE because ETE has a superset of the ETMv4 metadata files. Although
> this was always done in the correct order so it wasn't a bug.
> 
> Improve all this by making a single get version function which also
> handles not present as a separate case. Change the ETMv3 error message
> to only print when ETMv3 is detected, and add a new error message for
> the not present case.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linux.dev>

