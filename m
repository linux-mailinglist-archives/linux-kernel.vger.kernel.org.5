Return-Path: <linux-kernel+bounces-105758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88A487E3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1732281149
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C19225DD;
	Mon, 18 Mar 2024 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YSB4ad8t"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33661CA89;
	Mon, 18 Mar 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710745771; cv=none; b=DNBbtI3J41DcqyrsNLUFNQ/4wK5GEBDw6parujusd4sPKv71xDJAEJ3u+59PG2Pkejoj6l0XXxrouyWecjS7ChV052JV5Icx0YSBImf50LyJMC8rE5W7yEBxXsXj64gO1SyTL73HVI8WvPFuUs2CEu/meRhV847LrM7XubgKRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710745771; c=relaxed/simple;
	bh=uuwFTLvyMNqlpKTyNz8SdpNe0H6SFIIuVGNRpJwqqGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcR1UTTBG77dSKEY9RwEyxbdza8G8TaWfkFQKETB8I541JIVsVK6sQg+GRNOcYH7mUTbbkOgJPeWbK5IIZg8zygD1iVJEZf9K7ENjmgDSCePzCuI9qxu8Xd1xcBGzcnZubrgRjD5xEeBelK/MVEXCt1/sM/EUYsMfUkWPyAgyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YSB4ad8t; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I63EYF085045;
	Mon, 18 Mar 2024 01:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710741794;
	bh=eb0Ccz7HpZ5APiazpAPXMBC/gybVlUfHgyxFsx8OJ5c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YSB4ad8t69Xt6z8Q9rUY7EPVPxlrBq3REXebtcGlwp2Xm9RDgJhWweHPSkviZerXB
	 sECEHphpbqVd6gYcEzGnykTJsRuqoFIEyjiUgvEoZmz51wvOS+gqLTJH9eanEIJrXb
	 51pd1marzgijpu8vVM65WjCMxGNME2Yx2hb6+A9o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I63EkG002963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 01:03:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 01:03:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 01:03:14 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I63DLB033059;
	Mon, 18 Mar 2024 01:03:14 -0500
Date: Mon, 18 Mar 2024 11:33:12 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash
 Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue"
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>, Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit
 Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH V5 1/5] PM: domains: Allow devices attached to genpd to
 be managed by HW
Message-ID: <20240318060312.z5pk4roz6uqhwosc@dhruva>
References: <20240315111046.22136-1-quic_jkona@quicinc.com>
 <20240315111046.22136-2-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315111046.22136-2-quic_jkona@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 15, 2024 at 16:40:42 +0530, Jagadeesh Kona wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Some power-domains may be capable of relying on the HW to control the power
> for a device that's hooked up to it. Typically, for these kinds of
> configurations the consumer driver should be able to change the behavior of
> power domain at runtime, control the power domain in SW mode for certain
> configurations and handover the control to HW mode for other usecases.
> 
> To allow a consumer driver to change the behaviour of the PM domain for its
> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> which the genpd provider should implement if it can support switching
> between HW controlled mode and SW controlled mode. Similarly, add the
> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> genpd provider can also implement to synchronize the initial HW mode
> state in genpd_add_device() by reading back the mode from the hardware.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pmdomain/core.c   | 64 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h | 17 +++++++++++
>  2 files changed, 81 insertions(+)
> 

LGTM!

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

