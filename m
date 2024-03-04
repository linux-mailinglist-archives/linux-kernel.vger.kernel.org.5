Return-Path: <linux-kernel+bounces-90518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DA870084
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3391C2158D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92703A1B5;
	Mon,  4 Mar 2024 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mv2YUw+4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327839FCD;
	Mon,  4 Mar 2024 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552323; cv=none; b=un2pJst/vYi43m6PFPFfgRBJBurqDwoyZPOJufc1FjSQvIS7UMhjIivv+w/y3LHclIigMJI/hbFjfW6QpXH7FO548nSNQ7k+Y6ptA2d5kTHwbohWDXr/MHERynhb5INbTzQcWTgvKRWKMNSI6lsQvU7gDF/Lw6J/pT50CczJkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552323; c=relaxed/simple;
	bh=VTI8cpKT89AjD7F82RNNEo0NCDm0D0CNEsGK6u1avrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OCvLPC9C8fKT3jFpSvpTO9facK6QIM7kEHcmEFbmihzrUfn67mKnuF5XtGYfJ5jvRaHa2bePTbxQ5nvnoeeDO9FwKPk3Kmg1mUZl6p4Onkjfekrm+sD9HBCDPOSqrOJ7+cbhO7JShC55oI/yflOqVRRniMoF3WK0+9tu/LMh0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mv2YUw+4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 424BcXTn071681;
	Mon, 4 Mar 2024 05:38:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709552313;
	bh=76/4WhOAicWnxPVZ9BJChYRJakkI9NozKgJ1A3tDjCQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mv2YUw+4GQRFX+KNg4Ov+jjHUwx5mEEhKjMpJ03buJEQxzKyqfNR1lieGPc9YwFsl
	 N/qlbNopw1RrJSdWPS83V5Ei7ZYPlo7iq8Kd38NTuTSpGGkb7/J/2Xza/mrt9Od2fJ
	 Fuap9AikDQo9kB5PBLk+LQobveVCi6FrtD1cj/vc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 424BcXum047097
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 05:38:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 05:38:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 05:38:33 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 424BcTaT008408;
	Mon, 4 Mar 2024 05:38:30 -0600
Message-ID: <66af18e0-56eb-401f-900d-a83f6e52c603@ti.com>
Date: Mon, 4 Mar 2024 17:08:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] OPP: debugfs: Fix warning with W=1 builds
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>
References: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 04/03/24 16:52, Viresh Kumar wrote:
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
> Fix this and another potential issues it by allocating larger arrays.

Just to keep in mind while applying maybe: s/another/other

> Use the exact string format to allocate the arrays without getting into
> these issues again.
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Use string name while allocating memory for the array to fix potential
> issues later on.
> 
>   drivers/opp/debugfs.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index ec030b19164a..27c3748347af 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -56,11 +56,11 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
>   				struct dentry *pdentry)
>   {
>   	struct dentry *d;
> -	char name[20];
> +	char name[] = "icc-path-XXXXXXXXXX"; /* Integers can take 10 chars max */

LGTM!

>   	int i;
>   
>   	for (i = 0; i < opp_table->path_count; i++) {
> -		snprintf(name, sizeof(name), "icc-path-%.1d", i);
> +		snprintf(name, sizeof(name), "icc-path-%d", i);
>   
>   		/* Create per-path directory */
>   		d = debugfs_create_dir(name, pdentry);
> @@ -78,7 +78,7 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
>   				  struct opp_table *opp_table,
>   				  struct dentry *pdentry)
>   {
> -	char name[12];
> +	char name[] = "rate_hz_XXXXXXXXXX"; /* Integers can take 10 chars max */
>   	int i;
>   
>   	if (opp_table->clk_count == 1) {
> @@ -100,7 +100,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
>   	int i;
>   
>   	for (i = 0; i < opp_table->regulator_count; i++) {
> -		char name[15];
> +		char name[] = "supply-XXXXXXXXXX"; /* Integers can take 10 chars max */

Feels like a better solution to me than the previous revision, thanks!


Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   
>   		snprintf(name, sizeof(name), "supply-%d", i);
>   

-- 
Thanks and Regards,
Dhruva Gole

