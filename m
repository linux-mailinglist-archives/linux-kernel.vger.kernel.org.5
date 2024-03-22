Return-Path: <linux-kernel+bounces-111090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F28867C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078A41C23C46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3DE14ABA;
	Fri, 22 Mar 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YoD5veMT"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2D14A93;
	Fri, 22 Mar 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094491; cv=none; b=tURZPSKg7l3wxJY+LqfL0baiCBVC8sly4jM2SErDKTT1k5v7DyuDoPtpdhcI6RkXKNZqKG8mm+jWm3duEb6LV9k9mrggB43JHZtQPmg1RIPhgidhL2NETYuCKYnTe/FcrmsTPLOHzoPKmOaCNxu6P7h/0eFFG/m23rWkGl88O7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094491; c=relaxed/simple;
	bh=vEgSCRk9M8yaBIAvf6yfuXyNYcAHetrVsnO27cdC9TY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoY60i485Ve1vzy1LuHFmwAOO7pix4P5XayV6c/AM3Y4zYpoehJ60o2NX0PMziKAUQvXpCNQl+Qkfn3eV1lMTkhyXxHSpQeqcI/MquyKgOfCmEoHeCk9mY9R7H6W2FJmbhIrs66oFYX0AouQOgxtdwn/xkNH4OyJR5mF1EU1Gsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YoD5veMT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42M811wl115639;
	Fri, 22 Mar 2024 03:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711094461;
	bh=aonmxCcT8p6x3oL13Kq+gj+L0Jfrg/DuVw41r9ecWIM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YoD5veMTKY7G6a3rf/H2MQGgD8D3cugDZ6ScvIPSAFEDvTrDy8ljtbcUms1dLvORg
	 Yy8O74xrSihtKkhd9Yxc7l8VyITrV+mYldQmyDZ9X87t7YgptoB3vMVxqNXIMw8XE4
	 N2eOkbmxTeHUn/+hY1C34wKVu+U6KzrH1rxMrKPg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42M811Xu013055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Mar 2024 03:01:01 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 03:01:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 03:01:00 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42M80xA8070119;
	Fri, 22 Mar 2024 03:01:00 -0500
Date: Fri, 22 Mar 2024 13:30:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ye Zhang <ye.zhang@rock-chips.com>
CC: <finley.xiao@rock-chips.com>, <heiko@sntech.de>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <rafael@kernel.org>, <tao.huang@rock-chips.com>,
        <linux-rockchip@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Fix perf state when
 calculate dfc res_util
Message-ID: <20240322080059.xopjb2yr766sk5ob@dhruva>
References: <20240321102100.2401340-1-ye.zhang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321102100.2401340-1-ye.zhang@rock-chips.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 21, 2024 at 18:21:00 +0800, Ye Zhang wrote:
> The issue occurs when the devfreq cooling device uses the EM power model
> and the get_real_power() callback is provided by the driver.
> 
> The EM power table is sorted ascending，can't index the table by cooling
> device state，so convert cooling state to performance state by
> dfc->max_state - dfc->capped_state.

Thanks for the updated explanation!

> 
> Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
> Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> ---
> v1 -> v2:
>   - Update the commit message.
> 
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 50dec24e967a..8fd7cf1932cd 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>  
>  		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
>  		if (!res) {
> -			state = dfc->capped_state;
> +			state = dfc->max_state - dfc->capped_state;

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

