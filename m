Return-Path: <linux-kernel+bounces-129703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46896896EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015B62883C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892D146A87;
	Wed,  3 Apr 2024 12:07:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4BB143869;
	Wed,  3 Apr 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146079; cv=none; b=F2mhf0apcBGieFFgAm2mZmm4aMnkrWLUwiwbqUC5oeRrW/pom5R6qOdOdHSje5Q3F3ejUg7j9ZiaI4QaBrK89jDXrohcWbjK6GgUldW9pN9Rk/LH8SY3S8I9eBQc5KTdKRmw+tEaNHh1ZEAFftMPvwNAHn+k+6dhDUWSiRcwi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146079; c=relaxed/simple;
	bh=EwpnPCGxmMvv8rA/eff2h/LdO5QZDZn+k3W+wcBdnEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBnSfWQqsKv5+QTGXXURQ6F7EGLy54va0VDNZhakMp84MgDYPuXOe5CmOIANXqzXIqcPji6Bmzzsd1R3iWD15NmXT6bc9DKfzPqS1Vr9cVlK0gENjOSkP3iyTzQMdw2LABC06uFsTnrLyJ1UEKPnk7vDk1d7zoCWo3YzJpA3oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659001007;
	Wed,  3 Apr 2024 05:08:28 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503973F64C;
	Wed,  3 Apr 2024 05:07:55 -0700 (PDT)
Message-ID: <6445e850-fe24-4eb2-86f0-217b62b9001d@arm.com>
Date: Wed, 3 Apr 2024 14:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] soc: samsung: exynos-asv: Update Energy Model
 after adjusting voltage
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240402155822.505491-1-lukasz.luba@arm.com>
 <20240402155822.505491-5-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240402155822.505491-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 17:58, Lukasz Luba wrote:

[...]

> @@ -97,9 +98,17 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
>  			last_opp_table = opp_table;
>  
>  			ret = exynos_asv_update_cpu_opps(asv, cpu);
> -			if (ret < 0)
> +			if (!ret) {
> +				/*
> +				 * When the voltage for OPPs could be changed,
> +				 * make sure to update the EM power values, to
> +				 * reflect the reality and not use stale data.
> +				 */

Maybe shorter?

                                /*
                                 * Update EM power values since OPP
                                 * voltage values may have changed.
                                 */

[...]

