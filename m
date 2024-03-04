Return-Path: <linux-kernel+bounces-90536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39C8700D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23181282C18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE23C480;
	Mon,  4 Mar 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vn9lOqZY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5A3BB5E;
	Mon,  4 Mar 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553186; cv=none; b=SKZ0gh3gVNyp+C1SJjtFJuPTIOyFQGXJyQbs9GqgbrM46YRCdqIBFB3HVAqp4igrajSXgvncC7+YpwnkpLGcaD/7RMerW0Yu8kRFAr4cjHYnZktsCYj3F/CC4rAPYKVLvu2Tb0YhruTDwT76j1Fl3KDzr+CGGi9/IEbPFqCGdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553186; c=relaxed/simple;
	bh=8Q0hpRNs1YcIFywA2qZbL+uykvSJlC+R25zWdO3lxgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=epyJMs7u91etIaYzGcbg9yAYZTMCNInmICNMrtDKxKOtJo/IT0hd90W9UjAdeRHE7561/Gp3xFDTwhIQRHfa9xZOqJbTOhp0cXXE5tORcO/VpGF4M43irnu1jBj7k2NJFdhTNgPnWrI8wynY8dQ4Tuoi78CWWZERCKj0yXtOv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vn9lOqZY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 424BqrOD100923;
	Mon, 4 Mar 2024 05:52:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709553173;
	bh=gBe33nm2iOAnPbCyUfzD2Hk51P4hdFpUREFEEjcPNzk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Vn9lOqZYtSBGFSxODoIrKX8g/KWj9EKUrnd6uGI0kcDhj5yYNbFhJlUQB0WrEuRN9
	 S5hSrh6g14JhCpL1N7H34EHesCX5/Che8RFoMy+FCGARjC1u5sggeOx6RxKjo0Je1w
	 w/X7otyWs4A+Jbb7kYIacuce1v+pqKZ7f7uCjldM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 424BqrhG068851
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 05:52:53 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 05:52:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 05:52:53 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 424Bqnu3025627;
	Mon, 4 Mar 2024 05:52:50 -0600
Message-ID: <f2dbd3ea-233a-4ce9-a483-92397462f87f@ti.com>
Date: Mon, 4 Mar 2024 17:22:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] OPP: debugfs: Fix warning around icc_get_name()
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>
References: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
 <0275dc46489419f34765c6ed389c0e9d6245fd31.1709551295.git.viresh.kumar@linaro.org>
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <0275dc46489419f34765c6ed389c0e9d6245fd31.1709551295.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 04/03/24 16:52, Viresh Kumar wrote:
> If the kernel isn't built with interconnect support, icc_get_name()
> returns NULL and we get following warning:
> 
> drivers/opp/debugfs.c: In function 'bw_name_read':
> drivers/opp/debugfs.c:43:42: error: '%.62s' directive argument is null [-Werror=format-overflow=]
>           i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
> 
> Fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Do we not need this:

Fixes: 0430b1d5704b0 ("opp: Expose bandwidth information via debugfs")

?

>   drivers/opp/debugfs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 27c3748347af..a9ebfdf0b6a1 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -37,10 +37,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
>   			    size_t count, loff_t *ppos)
>   {
>   	struct icc_path *path = fp->private_data;
> +	const char *name = icc_get_name(path);
>   	char buf[64];
> -	int i;
> +	int i = 0;
>   
> -	i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
> +	if (name)
> +		i = scnprintf(buf, sizeof(buf), "%.62s\n", name);

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   
>   	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
>   }

-- 
Thanks and Regards,
Dhruva Gole

