Return-Path: <linux-kernel+bounces-165367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F128B8BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A608B21BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0512F37B;
	Wed,  1 May 2024 14:22:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD112EBEE;
	Wed,  1 May 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573345; cv=none; b=QnJkrnAlXzlO2EcSWAfuYrnrmTsG4wh0ibF+szrTQh5snBMhevclpvW/K6HLpysApH/q4onl/M0VKrqDD9k6wAvNMWqPIww+SxlwdB/f4DLGSJ9oYPiAZuBW2P5/VzNf1gtld/eDB0RiatKNWIIlBClhbd4duoiHtFv+qMwdPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573345; c=relaxed/simple;
	bh=bLjBVR2yDcjyNrB7DXDJfpvDJVP1OshVgAwlgWDOqxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZJlQI704B2nVIY49b1VO6fBdLziQu04vcQtEGXSaAeEEcMTtUSaOE3Km2Rhc4q2Z/n7x0z8f1WO0eFKUzXs2TS8uH4FDnYynmuQsRFgB9R4PwODgbi8dGKeVoo4kN0hYu1fS3iwrzEUzzZiWtKBeZkd5Q1Pm8FaKCQiqEQyf0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE3E42F4;
	Wed,  1 May 2024 07:22:48 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48FCF3F71E;
	Wed,  1 May 2024 07:22:21 -0700 (PDT)
Message-ID: <14e1cf11-ce4c-4d83-97da-1bd4e44ae2b0@arm.com>
Date: Wed, 1 May 2024 15:22:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf lock: More strdup argument freeing
To: Ian Rogers <irogers@google.com>
References: <20240430184156.1824083-1-irogers@google.com>
Content-Language: en-US
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240430184156.1824083-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/04/2024 19:41, Ian Rogers wrote:
> Leak sanitizer complains about the strdup-ed arguments not being
> freed. rec_argv is reordered and duplicates inserted, meaning making
> all its contents strdup-ed and freeing them all leads to double frees
> or leaks. Add an extra array to track strup-ed arguments and free
> them. This makes address sanitier running `perf test` "kernel lock
> contention analysis test" memory leak free.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

