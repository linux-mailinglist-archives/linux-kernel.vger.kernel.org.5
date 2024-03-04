Return-Path: <linux-kernel+bounces-90151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B286FB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423F2281AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9E168AF;
	Mon,  4 Mar 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D38jyuab"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613C14ABA;
	Mon,  4 Mar 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538197; cv=none; b=QPSkuMvmiwmPBtvdGCBrGCvzAauXpZpSGRxUSOpITN2zdelBGTGlm0kcZayVzA3O97ibtLNGquUaO9aY4EeUgYcWjA8gz3S1QLmlO84iqoFJppeV8vUKhfqyp1GjlgXkzHYGvBuxaS0RIw3ea7Kd1EWQ2jvj3TAiybpv37dC5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538197; c=relaxed/simple;
	bh=dZAmcUkp17r25WIzQ6yHqKr71ZKrGOypYiLEXAFu3Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f0x0tIhZoYcAYX/KOSljSwJa0XvpITjmkob0r1UZ0gXzTh2jpJ/hW7+AyvuvGXnxbA6Iej+qG0W16YKKNRHfyiG49MuwAQd90kDc1tYiah1j4QlhC6pPeUvITUThsU6jjfNyczJE9iZCXkWZqUsPmBozQXJkFXZb+wsbjW/hlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D38jyuab; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4247gwF3044283;
	Mon, 4 Mar 2024 01:42:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709538178;
	bh=gURS/PLZBo6eK784UbbKH5EpurjEpkBUuvZZBDPKf4o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=D38jyuabDECySA5PmNB4Zx32RNdW1mT6YleOgGE4wpvWTxK0kbr0fir2vxlZ8/MP4
	 Qq9UpzfA8qutihBl31AnInBjepXGkya0ff48gqloS/lT2xWdChwd39dfBDrAyiPBut
	 zJ+tzPv3fSdzr0LbTRBqF0sPnbXSe3t2B+vfCSt0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4247gwjp000580
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 01:42:58 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 01:42:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 01:42:57 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4247gsAb087656;
	Mon, 4 Mar 2024 01:42:55 -0600
Message-ID: <ae566a5d-b31c-4e69-8e79-92322ac7e104@ti.com>
Date: Mon, 4 Mar 2024 13:12:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: debugfs: Fix warning with W=1 builds
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>
References: <50a1a0f23efdc261844a306f5e611051843b4e52.1709536847.git.viresh.kumar@linaro.org>
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <50a1a0f23efdc261844a306f5e611051843b4e52.1709536847.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Viresh,

On 04/03/24 12:50, Viresh Kumar wrote:
> We currently get the following warning:
> 
> debugfs.c:105:54: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>                   snprintf(name, sizeof(name), "supply-%d", i);
>                                                        ^~
> debugfs.c:105:46: note: directive argument in the range [-2147483644, 2147483646]
>                   snprintf(name, sizeof(name), "supply-%d", i);
>                                                ^~~~~~~~~~~
> debugfs.c:105:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
>                   snprintf(name, sizeof(name), "supply-%d", i);
> 
> Fix this and another potential issue it by increasing size of the arrays.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/opp/debugfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index ec030b19164a..96313aa55db6 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -78,7 +78,7 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
>   				  struct opp_table *opp_table,
>   				  struct dentry *pdentry)
>   {
> -	char name[12];
> +	char name[19];


I'd rather we use malloc or else change the limits of the
"rate_hz_%d" to "rate_hz_%4d" or how many ever digits makes sense.

[...]


-- 
Thanks and Regards,
Dhruva Gole

