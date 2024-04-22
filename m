Return-Path: <linux-kernel+bounces-152974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088328AC6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD101C20749
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9AC502A9;
	Mon, 22 Apr 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/pvN3s"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC844E1D2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774469; cv=none; b=Yx84oIVLDJiUznnDO1g616fFBoZddO7BMYXuQ16xjuI4qSPKuNoKprwI2RqtUx0hWq03EPd2GUFDVch44aCkM6EI8g8HQjbHyAPAleSNsuoQsxXUehQMD+eoqlnSX4wbwDu1NONRAh75j/vDYAJHjzVFxXq7DJZ1Als72IxkX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774469; c=relaxed/simple;
	bh=Hr/UOgCeqrf8jczwsKVsQECpXPGmT9JTdxjri7muwxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeAjEf8LIJO3TRCTA2aEgdpguw+I1j/Wg88Zce5ZA8fDeFXhwOjs9OPdVhHtt+gDE1VfGbi2z7SUc84EtgYneKAF0PUydTbgLAwFfQ6PelBFyERBLYntv4AnvnyPor5FadJHr54VtORefrQuvya0a1882n/07QiQMhE/CYgXoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ/pvN3s; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4371330a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713774466; x=1714379266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlPgHf7WOLwsVsrr1Qmr66L30feY5ntlJdRgD5m3Dus=;
        b=dJ/pvN3shEHs7YALvbye9hXVi0VodGrY0pEJdDY8X0eFzBDU10Hr7foYqUMBaGcMo0
         MZnLIlHuiUNqkN+xXE/6aNW7oxOIV8BEvICj80ZqPV8kW9s82YQM3ad5M3Xg7cxYQ5aZ
         lu8ozMbsM2wNvaAEAhcI6KsEAMOeeECZ3dLFaB2+XARmhTCHoCh+7T0IQpSzcRkI2T9x
         dsd+c8OpVGChbKxS3Ep/KJVZ+3KsRl1X06tMMjqBnF0XkEh1oWu/wuHdQBFWl1vygmB1
         YN0tMMqKVIimyIppaflOX9WTiGrk62g8hsaGs7D6Sm+U1dgcc4CjxSnEmOCEyuQ7gtvA
         78cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774466; x=1714379266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlPgHf7WOLwsVsrr1Qmr66L30feY5ntlJdRgD5m3Dus=;
        b=dXmQuBkSsKqbzfOUFdWiWoYDqi3H6jlcGMMUTacvzfkYgsAjHfNiizSPKAZzjnhaKO
         OY71lY7VRZaG7oE0BzR2umbP3qGXUcT1N8uxcw0mdUh/XggzIM2+kuqtMNvs5ckSseJn
         FdZgaciGFr4VtRBtM87hun6FIz+ZQrh1FEt9gX1naeX4QlNOnMb6+1rsd3DlKMbn0Lfh
         Rva09O9jdyR0n9iuTi+tPXKt9jZDFmcXqwfhLdD16XMKlLP0x01nKlSfiRo+7nOiC9xc
         dTROezWt9ySzhlayFlrgObIZQBMvBEndDk6xNl7fh6B55HlwMiUGISuOk5DOxLWXliv9
         dmLA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSGlypQ4P/zDTY6cVYbXCT3thy+rw3xddgl2D338Ld8VltdYsGkMrhEyR7lX2TuN9a8XNMu8m49r3IOEfR6PQaiFLYsXGJBCAMXf9
X-Gm-Message-State: AOJu0YyYRnxuKbuRe0vqwx5bpzYb2WuZgSkycm7MlTgKFePvQ5Ur+mWK
	4VXoXRoBXqsGNn0y/RL6twieA8LlR79AageFdj7772Xz62u4ufzz
X-Google-Smtp-Source: AGHT+IG9E4AKYhCCK6sYyL//PMT4Xf2fELSw2jQbNDSm+B16JRsVysc8j2Jplxh09BEvuKA0ReqFWA==
X-Received: by 2002:a50:9986:0:b0:56c:5a49:736 with SMTP id m6-20020a509986000000b0056c5a490736mr6435877edb.9.1713774465669;
        Mon, 22 Apr 2024 01:27:45 -0700 (PDT)
Received: from [192.168.1.20] (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7d38f000000b0057033a63559sm5365017edq.21.2024.04.22.01.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:27:45 -0700 (PDT)
Message-ID: <589b0185-c620-4797-82da-5443ab707a68@gmail.com>
Date: Mon, 22 Apr 2024 10:27:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: use __free attribute instead of of_node_put()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
 javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org
References: <20240419131956.665769-1-vincenzo.mezzela@gmail.com>
 <20240419140106.3mkayxriqjt2cz5i@bogus>
Content-Language: en-US
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <20240419140106.3mkayxriqjt2cz5i@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/04/24 16:01, Sudeep Holla wrote:
> On Fri, Apr 19, 2024 at 03:19:56PM +0200, Vincenzo Mezzela wrote:
>> Introduce the __free attribute for scope-based resource management.
>> Resources allocated with __free are automatically released at the end of
>> the scope. This enhancement aims to mitigate memory management issues
>> associated with forgetting to release resources by utilizing __free
>> instead of of_node_put().
>>
>> The declaration of the device_node used within the do-while loops is
>> moved directly within the loop so that the resource is automatically
>> freed at the end of each iteration.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>> ---
>>   drivers/base/arch_topology.c | 41 ++++++++++++++----------------------
>>   1 file changed, 16 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 024b78a0cfc1..58eeb8183747 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -513,10 +513,10 @@ core_initcall(free_raw_capacity);
>>    */
>>   static int __init get_cpu_for_node(struct device_node *node)
>>   {
>> -	struct device_node *cpu_node;
>>   	int cpu;
>>
>> -	cpu_node = of_parse_phandle(node, "cpu", 0);
>> +	struct device_node *cpu_node __free(device_node) =
> Missing include <linux/cleanup.h> for this ?
>
>> +		of_parse_phandle(node, "cpu", 0);
>>   	if (!cpu_node)
>>   		return -1;
>>
>> @@ -527,7 +527,6 @@ static int __init get_cpu_for_node(struct device_node *node)
>>   		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>>   			cpu_node, cpumask_pr_args(cpu_possible_mask));
>>
>> -	of_node_put(cpu_node);
>>   	return cpu;
>>   }
>>
>> @@ -538,11 +537,11 @@ static int __init parse_core(struct device_node *core, int package_id,
>>   	bool leaf = true;
>>   	int i = 0;
>>   	int cpu;
>> -	struct device_node *t;
>>
>>   	do {
>>   		snprintf(name, sizeof(name), "thread%d", i);
>> -		t = of_get_child_by_name(core, name);
>> +		struct device_node *t __free(device_node) =
>> +			of_get_child_by_name(core, name);
>>   		if (t) {
>>   			leaf = false;
>>   			cpu = get_cpu_for_node(t);
>> @@ -553,10 +552,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>>   				cpu_topology[cpu].thread_id = i;
>>   			} else if (cpu != -ENODEV) {
>>   				pr_err("%pOF: Can't get CPU for thread\n", t);
>> -				of_node_put(t);
>>   				return -EINVAL;
>>   			}
>> -			of_node_put(t);
> OK you moved 't' inside the loop and this must be taken care, but...
>
>>   		}
>>   		i++;
>>   	} while (t);
> ....now, will it even compile if 't' is not in scope ? I think you might get
> compilation here. If not, I still don't understand what is the value of
> 't' being checked there.
>
>> @@ -586,7 +583,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>>   	char name[20];
>>   	bool leaf = true;
>>   	bool has_cores = false;
>> -	struct device_node *c;
>>   	int core_id = 0;
>>   	int i, ret;
>>
>> @@ -598,13 +594,13 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>>   	i = 0;
>>   	do {
>>   		snprintf(name, sizeof(name), "cluster%d", i);
>> -		c = of_get_child_by_name(cluster, name);
>> +		struct device_node *c __free(device_node) =
>> +			of_get_child_by_name(cluster, name);
>>   		if (c) {
>>   			leaf = false;
>>   			ret = parse_cluster(c, package_id, i, depth + 1);
>>   			if (depth > 0)
>>   				pr_warn("Topology for clusters of clusters not yet supported\n");
>> -			of_node_put(c);
>>   			if (ret != 0)
>>   				return ret;
>>   		}
>> @@ -615,14 +611,14 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>>   	i = 0;
>>   	do {
>>   		snprintf(name, sizeof(name), "core%d", i);
>> -		c = of_get_child_by_name(cluster, name);
>> +		struct device_node *c __free(device_node) =
>> +			of_get_child_by_name(cluster, name);
>>   		if (c) {
>>   			has_cores = true;
>>
>>   			if (depth == 0) {
>>   				pr_err("%pOF: cpu-map children should be clusters\n",
>>   				       c);
>> -				of_node_put(c);
>>   				return -EINVAL;
>>   			}
>>
>> @@ -635,7 +631,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>>   				ret = -EINVAL;
>>   			}
>>
>> -			of_node_put(c);
>>   			if (ret != 0)
>>   				return ret;
>>   		}
>> @@ -651,17 +646,16 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>>   static int __init parse_socket(struct device_node *socket)
>>   {
>>   	char name[20];
>> -	struct device_node *c;
>>   	bool has_socket = false;
>>   	int package_id = 0, ret;
>>
>>   	do {
>>   		snprintf(name, sizeof(name), "socket%d", package_id);
>> -		c = of_get_child_by_name(socket, name);
>> +		struct device_node *c __free(device_node) =
>> +			of_get_child_by_name(socket, name);
>>   		if (c) {
>>   			has_socket = true;
>>   			ret = parse_cluster(c, package_id, -1, 0);
>> -			of_node_put(c);
>>   			if (ret != 0)
>>   				return ret;
>>   		}
> Same thing applies to these while(c) loop. I don't understand how this
> could work even if it is compiling fine which I doubt.
>
>> @@ -676,11 +670,11 @@ static int __init parse_socket(struct device_node *socket)
>>
>>   static int __init parse_dt_topology(void)
>>   {
>> -	struct device_node *cn, *map;
>>   	int ret = 0;
>>   	int cpu;
>>
>> -	cn = of_find_node_by_path("/cpus");
>> +	struct device_node *cn __free(device_node) =
>> +		of_find_node_by_path("/cpus");
>>   	if (!cn) {
>>   		pr_err("No CPU information found in DT\n");
>>   		return 0;
>> @@ -690,13 +684,14 @@ static int __init parse_dt_topology(void)
>>   	 * When topology is provided cpu-map is essentially a root
>>   	 * cluster with restricted subnodes.
>>   	 */
>> -	map = of_get_child_by_name(cn, "cpu-map");
>> +	struct device_node *map __free(devide_node) =
> If not above ones, this must fail to compile. Perhaps s/devide_node/device_node/ ?
> I now doubt if this patch is compile tested ?
>
> --
> Regards,
> Sudeep

Hi,

As you rightly pointed out, I inadvertently omitted to compile this file 
during the kernel build process. Consequently, certain errors remained 
undetected. I apologize for the oversight.

I'll send an updated version of this patch soon.

Regards,

Vincenzo


