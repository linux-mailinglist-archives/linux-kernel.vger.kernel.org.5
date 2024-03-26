Return-Path: <linux-kernel+bounces-118871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40A88C07E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02E21C37C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961456B6D;
	Tue, 26 Mar 2024 11:20:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274D38FB9;
	Tue, 26 Mar 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452007; cv=none; b=fouAGk7xbuhskxsBJm+4lVgcBOIBQ2RwR1LkSHyu1vokj86U5O51MVMceeF9/Mrnj8BbkLKmC0UoJPNBEe/AvqbaiXdPl3+WpvH7O5rZ+KfIDkZtOH3FRae+xEJ9oCuuxnKwGPhH84IJDKnvp7ft3YpYvYCzBxybc7tjXZJgNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452007; c=relaxed/simple;
	bh=6brBgBW6YoCYIcFpfRnD9GmEyXoViwHWmMX0BAYP6h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZGkvLlHSrT6yN2q+8qTIJ13VHqeaKQ6YhJKrca557KXGGBx432GGANDpo0PmES81z87GUEN0TkdvWOO78VxaAMTSG0jnWVKtwapGvOmD5DIMeHSSd3tthTWvrQAumVbolo6z+0XjKRFMlT6lPxQrlc/7wXv9GrOKnb7AjwMVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16CB92F4;
	Tue, 26 Mar 2024 04:20:38 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 784523F64C;
	Tue, 26 Mar 2024 04:20:02 -0700 (PDT)
Message-ID: <59d37960-cf19-4b10-802f-59d42496c133@arm.com>
Date: Tue, 26 Mar 2024 12:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 4/4] soc: samsung: exynos-asv: Update Energy
 Model after adjusting voltage
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-5-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240322110850.77086-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 12:08, Lukasz Luba wrote:

[...]

> @@ -97,9 +98,17 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
>  			last_opp_table = opp_table;
>  
>  			ret = exynos_asv_update_cpu_opps(asv, cpu);
> -			if (ret < 0)
> +			if (!ret) {
> +				/*
> +				 * When the voltage for OPPs successfully
> +				 * changed, update the EM power values to
> +				 * reflect the reality and not use stale data

At this point, can we really say that the voltage has changed?

  exynos_asv_update_cpu_opps()

    ...
    ret = dev_pm_opp_adjust_voltage()
    if (!ret)
      em_dev_update_chip_binning()
    ...

dev_pm_opp_adjust_voltage() also returns 0 when the voltage value stays
the same?

[...]

