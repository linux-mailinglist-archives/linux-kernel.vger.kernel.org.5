Return-Path: <linux-kernel+bounces-131288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C39B8985B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2901F236AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987D811E2;
	Thu,  4 Apr 2024 11:05:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86A959157;
	Thu,  4 Apr 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228744; cv=none; b=h2r5jUNfZ75Q+QfS10JacV0LGJ0QAgF82BriDqIRrl7d+ErLKCo2PQhO5UsK8OLLRX9PpbELRXSXiwXOBMVq6k+hZBfL5H5uQvTO9VEWBeQ6tgeMWp8+dviB8tIx39M55lkXmNNPDyN+4zg3xDwR9276lNL1gf6kZGRKWYmtVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228744; c=relaxed/simple;
	bh=wdbjKuAXBag0wP4Mj8I0Q4F5Fo+sCqKR7kQJZok6xR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj8Sc0idq+PjoMY180ZSjdlrM1dI2GX++clcoxqYzxaW3dBjcGvRZuOWMtigGpn4PSBP1bcyk+xEfQp8mxfDFcsBdfN3zBKKF8AQjYYoVRh7EI6MG+ynoz8FxTrfJ2qr+06RJYk9w01B3jMgJhQSnTuNJOU9speuNO+WsAWY9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C809BFEC;
	Thu,  4 Apr 2024 04:06:12 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2E13F7B4;
	Thu,  4 Apr 2024 04:05:39 -0700 (PDT)
Message-ID: <7ecd3ec9-6990-4d3e-84ae-d0d3a1cccb78@arm.com>
Date: Thu, 4 Apr 2024 12:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM:EM: fix wrong utilization estimation in
 em_cpu_energy()
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com, rafael@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
References: <20240404104200.1672208-1-vincent.guittot@linaro.org>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240404104200.1672208-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 4/4/24 11:42, Vincent Guittot wrote:
> Commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
> has added back map_util_perf() in em_cpu_energy() computation which has
> been removed with the rework of scheduler/cpufreq interface.
> This is wrong because sugov_effective_cpu_perf() already takes care of
> mapping the utilization to a performance level.
> 
> Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   include/linux/energy_model.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 770755df852f..70cd7258cd29 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -245,7 +245,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	 * max utilization to the allowed CPU capacity before calculating
>   	 * effective performance.
>   	 */
> -	max_util = map_util_perf(max_util);
>   	max_util = min(max_util, allowed_cpu_cap);
>   
>   	/*

LGTM. It was developed in parallel IIRC and that change which removes
the extra margin to the util was lost from my radar. I can see it
landed first.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

