Return-Path: <linux-kernel+bounces-108442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20655880A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5641C21701
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09D14A96;
	Wed, 20 Mar 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hKGkHQKQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F031134AB;
	Wed, 20 Mar 2024 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912249; cv=none; b=ej7GUGkmDdCmHUMha7k5UM3mP3NrdWOiLSHbGjgab5C6KbQYv8J2w2I/mJMlskQasXu/y9QcN2u9N9Uex4gjX02MiblhGYtoo4Ats12lwtT/BbWJtAEt2KmWX/J6GlRcbdPZ5uR078hC+WWg9NTU6qw7AVKECuonxMv1ihKGc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912249; c=relaxed/simple;
	bh=HJrpAB3s870TF7XDdJL3Y/viUMsCZ5xu7IbozphFcg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI7auOrYA+PAD+3b1UPVk4hqoNie4AZEqwLoOFZ8IDWfXxXjKEX0e/X4Sw/ennTm+FywRYIxMgua4N570IKdT7nMWM/0ehkkmI1dwWu9xHw8J9qr9LP/JP90F9Y+fxfCLc6hxzdTSaLer6omnn1n9KpyNgedgVhwnkPO7rS2ebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hKGkHQKQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42K5Nwt1063360;
	Wed, 20 Mar 2024 00:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710912238;
	bh=hclMrfbJMmUXigAObWf3+YqP1MxsUJQZjymXgjSMcuw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hKGkHQKQ+Nov4FIkZwuAlfOLx24b+8miR1OL0uFzwgDZ8/ubErzP5GQRGybA/qmAj
	 J47yy7qUW6UzRA/v1/MYiI2mZexZ9z9/9YlkipG1PGZWul9NgxUJ/x8J43qNAUKvOh
	 r4m0CymaC6T8BruALMZ9+WskQte41eGz2m2TkPVs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42K5NwYJ130209
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 00:23:58 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 00:23:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 00:23:58 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42K5Nvpv008108;
	Wed, 20 Mar 2024 00:23:57 -0500
Date: Wed, 20 Mar 2024 10:53:56 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ke.wang@unisoc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan94@gmail.com>, <di.shen@unisoc.com>
Subject: Re: [PATCH] cpufreq: Use a smaller freq for the policy->max when
 verify
Message-ID: <20240320052356.6ogxfa6teocp7br6@dhruva>
References: <20240319080153.3263-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319080153.3263-1-xuewen.yan@unisoc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 19, 2024 at 16:01:53 +0800, Xuewen Yan wrote:
> When driver use the cpufreq_frequency_table_verify() as the
> cpufreq_driver->verify's callback. It may cause the policy->max
> bigger than the freq_qos's max freq.
> 
> Just as follow:
> 
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_available_frequencies
> 614400 768000 988000 1228800 1469000 1586000 1690000 1833000 2002000 2093000
> 
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling_max_freq
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling_min_freq
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_max_freq
> 2002000
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_min_freq
> 2002000
> 
> When user set the qos_min and qos_max as the same value, and the value
> is not in the freq-table, the above scenario will occur.
> 
> This is because in cpufreq_frequency_table_verify() func, when it can not
> find the freq in table, it will change the policy->max to be a bigger freq,
> as above, because there is no 1.9G in the freq-table, the policy->max would
> be set to 2.002G. As a result, the cpufreq_policy->max is bigger than the
> user's qos_max. This is unreasonable.

That's a good catch! Never thought of this.

> 
> So use a smaller freq when can not find the freq in fre-table, to prevent
> the policy->max exceed the qos's max freq.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/cpufreq/freq_table.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index c4d4643b6ca6..1d98b8cf1688 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -70,7 +70,7 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
>  				   struct cpufreq_frequency_table *table)
>  {
>  	struct cpufreq_frequency_table *pos;
> -	unsigned int freq, next_larger = ~0;
> +	unsigned int freq, prev_smaller = 0;
>  	bool found = false;
>  
>  	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
> @@ -86,12 +86,12 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
>  			break;
>  		}
>  
> -		if ((next_larger > freq) && (freq > policy->max))
> -			next_larger = freq;
> +		if ((prev_smaller < freq) && (freq <= policy->max))
> +			prev_smaller = freq;
>  	}
>  
>  	if (!found) {
> -		policy->max = next_larger;
> +		policy->max = prev_smaller;
>  		cpufreq_verify_within_cpu_limits(policy);

LGTM!
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

