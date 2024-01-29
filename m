Return-Path: <linux-kernel+bounces-43302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D658411E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81A01C2042D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD226F08D;
	Mon, 29 Jan 2024 18:16:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADE6F067;
	Mon, 29 Jan 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552204; cv=none; b=IdmazRUEavphNtMMplqAlicMPiS37hcaKOCSXYe8GO+pLlRZ9KXtmhnKgVk91DQlAQanHC24dv4AHipbYgAog/bN4VmsbnKZ1NAlmFXl3idcArbMFx0MBFwAS1/xj3nPsUdxX7Bd5jMpvSZc7Rvmmm3w7SSDdRpLq7+G3cpRJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552204; c=relaxed/simple;
	bh=3K9E1eBaQHZke+ZOLH8M64F3SEbU0rMNrNadqCjf4v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWqcnrRARFddwEDHaWS+Oz7RDpRo/BgfGCVAhhofUiXnydimRN0bG3c1AlgjiTKRffMaxcDewVimM0FDQ+s54A1+LioUYCe5kqgz5c6d2P50CvWEL+vKtDSlTrgQz7oz5QxCq+6z3P+n0hm9IOjo+Zz5Afwz6tCmGnZfLNnJm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FA6DA7;
	Mon, 29 Jan 2024 10:17:26 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA8CC3F738;
	Mon, 29 Jan 2024 10:16:39 -0800 (PST)
Message-ID: <c6aa3166-ad82-4576-8d77-19232d477c73@arm.com>
Date: Mon, 29 Jan 2024 19:16:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 10:56, Lukasz Luba wrote:

[...]

> Changelog:
> v7:
> - dropped em_table_get/put() (Rafael)
> - renamed memory function to em_table_alloc/free() (Rafael)
> - use explicit rcu_read_lock/unlock() instead of wrappers and aligned
>   frameworks & drivers using EM (Rafael)
> - adjusted documentation to the new functions
> - fixed doxygen comments (Rafael)
> - renamed 'refcount' to 'kref' (Rafael)
> - changed patch headers according to comments (Rafael)
> - rebased on 'next-20240112' to get Ingo's revert affecting energy_model.h
> v6 [6]:
> - renamed 'runtime_table' to 'em_table' (Dietmar, Rafael)
> - dropped kref increment during allocation (Qais)
> - renamed em_inc/dec_usage() to em_table_inc/dec() (Qais)
> - fixed comment description and left old comment block with small
>   adjustment in em_cpu_energy() patch 15/23 (Dietmar)
> - added platform name which was used for speed-up testing (Dietmar)
> - changed patch header description keep it small not repeating the in-code
>   comment describing 'cost' in em_cpu_energy() patch 15/23 (Dietmar)
> - added check and warning in em_cpu_energy() about RCU lock held (Qais, Xuewen)
> - changed nr_perf_states usage in the patch 7/23 (Dietmar)
> - changed documentation according to comments (Dietmar)
> - changed in-code comment in patch 11/23 according to comments (Dietmar)
> - changed example driver function 'ctx' argument in the documentation (Xuewen)
> - changed the example driver in documentation, dropped module_exit and
>   added em_free_table() explicit in the update function
> - fixed comments in various patch headers (Dietmar)
> - fixed Doxygen comment s/@state/@table patch 4/23 (Dietmar)
> - added information in the cover letter about:
> -- optimization in EAS hot code path
> -- follow-up patch set which adds OPP support and modifies EM for Exynos5
> - rebased on 'next-20240104' to avoid collision with other code touching
>   em_cpu_energy()

LGTM now. I see that my comments from v5 have been addressed. Minor
points which still exists for me I commented on in the individual patches.

For the whole series:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

(with a simple test driver updating the EM for CPU0 on Arm64 Juno-r0)

