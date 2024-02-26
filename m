Return-Path: <linux-kernel+bounces-81910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E90867BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064CA1C2AAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3712F59D;
	Mon, 26 Feb 2024 16:29:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8012F39B;
	Mon, 26 Feb 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964964; cv=none; b=spCevTfV3iw0pqYcUYlzkkC02G9tcL1D66u6gxhIMpzFkw91aluQXIQduHPo0bgEAtouPFUePHu3dsHhej4wHNysIDb/FyAEJBuHTbViai0mbwv3AsEuevnxjedCE9MzY3BVfe10pY0+N4vfgq6MfE/gvZnVC151qUNwQq2nbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964964; c=relaxed/simple;
	bh=RqI1ZOwpCqfHOLSUWAUd97Slp9znorLCgecOqeZopt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsiOx7i+OpFiWWjsxPw8CrmBmI7bPhzC5OB/mLuiczkPuNOMuGOZe6MSCIZoDrqDXa+LinKeCDhfe0vUS8bQomTe8DmUuSZfSJOca2ap1g9tIXohHDtjQ3WErj+D37dVnTbtJlpPWsV+76IVVpOsL6M+0zgZclRbFEDvvirMQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230FBDA7;
	Mon, 26 Feb 2024 08:30:01 -0800 (PST)
Received: from [10.57.12.43] (unknown [10.57.12.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C9B3F73F;
	Mon, 26 Feb 2024 08:29:19 -0800 (PST)
Message-ID: <b86a2c0c-72a6-4b14-92f6-523da8291631@arm.com>
Date: Mon, 26 Feb 2024 16:29:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] OPP: Extend dev_pm_opp_data with turbo support
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
 morten.rasmussen@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
 cristian.marussi@arm.com, sudeep.holla@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
 linux-arm-msm@vger.kernel.org, nm@ti.com, dietmar.eggemann@arm.com
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240117110443.2060704-2-quic_sibis@quicinc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240117110443.2060704-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/24 11:04, Sibi Sankar wrote:
> Let's extend the dev_pm_opp_data with a turbo variable, to allow users to
> specify if it's a boost frequency for a dynamically added OPP.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/opp/core.c     | 1 +
>   include/linux/pm_opp.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c4e0432ae42a..e233734b7220 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2065,6 +2065,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
>   	/* populate the opp table */
>   	new_opp->rates[0] = data->freq;
>   	new_opp->level = data->level;
> +	new_opp->turbo = data->turbo;
>   	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
>   	new_opp->supplies[0].u_volt = u_volt;
>   	new_opp->supplies[0].u_volt_min = u_volt - tol;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 76dcb7f37bcd..a08a1fb1ca2a 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -93,6 +93,7 @@ struct dev_pm_opp_config {
>    * @u_volt: The voltage in uV for the OPP.
>    */
>   struct dev_pm_opp_data {
> +	bool turbo;

Please add description of that new field, like other
fields in the comment above.

>   	unsigned int level;
>   	unsigned long freq;
>   	unsigned long u_volt;

