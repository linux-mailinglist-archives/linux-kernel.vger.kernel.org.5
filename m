Return-Path: <linux-kernel+bounces-162591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0938B5DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E71F25B13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0767CF1A;
	Mon, 29 Apr 2024 15:30:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2037BAF0;
	Mon, 29 Apr 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404644; cv=none; b=kbyZVXgOqRNLLN1uxqbyXCPB+wiVGGEWWmT7jRi+FE/DnOZX+gPm1aTlpIf6XkJroj7M/IR0xSx2NW1dkQ8/FEFgYL8yn+FmxwJ7ME8/d5SK3rzlcGnTnC/JBfcvkAjxRX4cwqBURz95aQVW03qb67R0N7FWVeROHjI4alMlFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404644; c=relaxed/simple;
	bh=0kYnqk0mVJArcXX3Osqk9XdnGP6ULsQnOom7zi1vRYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZKdSKFq2oE/nmIOXy/gpvRLc+IULIUB+UcB7sEsEQWwhr3QhIcg2Q2b6uJSqYc/Eh8q2YFVSozcc5HTxFp+zSGcIHZ2aphICHlYYx+ZSplK7EI6ZdEUqCTrDW5nR8GQ3qwojRGlcI+45ehaR8216HMsJsNM/Y5CPDDfWgra7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7084B2F4;
	Mon, 29 Apr 2024 08:31:09 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAA953F793;
	Mon, 29 Apr 2024 08:30:39 -0700 (PDT)
Message-ID: <321686b9-271e-4d02-8631-a6782fa805e2@arm.com>
Date: Mon, 29 Apr 2024 16:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] coresight: Expose map arugment in trace ID API
To: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-13-james.clark@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240429152207.479221-13-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/04/2024 16:21, James Clark wrote:
> ...
> 
> System ID functions are unchanged because they will always use the
> default map.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Ignore this patch, the other 11/17 is the correct one.

