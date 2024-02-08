Return-Path: <linux-kernel+bounces-58364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E04A84E54A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60121F2821E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C441C74;
	Thu,  8 Feb 2024 16:43:03 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3D82D74
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410583; cv=none; b=OwfRtgkgOjaquaLagUJkRUr/OxgSVCyWg3hONglxlk+hoCKTdIzXhReEL3vLF0cqLfKcqNyuap1aqDWD+HzTmWFejfd+DGD5h6N0bvUcjX/d2mi0hZ+yIaEscYyUL+piCKfg7vWVDfOUL+u74FJETEtytJqT4v7SjPQcTwjuUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410583; c=relaxed/simple;
	bh=e9gx7ysf5nDVQcKyRIhMrUuZqIvSokXKGgA3mBX6IGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/PT+K2MMUiJcri2/a14pW556Iyoa+OLjMxqyBNhFc47U6K6Tpsh1OIQlSGhzWHb9VUZkb/g8wF5d46dyVW1aPcOQPlcWh6efyy++QqCmCMw6+ouVTm6DMPYt2mL3U+1nA/egm/qBtru5BSKxJHgVNU+xZWjdbqnJv1YuggKuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from [192.168.2.131]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Thu, 08 Feb 2024 17:42:59 +0100
Message-ID: <ff6cef18-c1fb-4a1e-91a5-fb713086474e@davidv.dev>
Date: Thu, 8 Feb 2024 17:42:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: make driver settling time configurable
Content-Language: en-US
To: Denis Kirjanov <dkirjanov@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Xiongwei Song <xiongwei.song@windriver.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>
References: <20240208093722.246930-1-david@davidv.dev>
 <20240208095358.251381-1-david@davidv.dev>
 <0e129417-53c8-4931-af76-a37762472fb0@suse.de>
From: David <david@davidv.dev>
In-Reply-To: <0e129417-53c8-4931-af76-a37762472fb0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 11:26, Denis Kirjanov wrote:
>
> On 2/8/24 12:52, David Ventura wrote:
>> During IP auto configuration, some drivers apparently need to wait a
>> certain length of time to settle; as this is not true for all drivers,
>> make this length of time configurable.
>>
>> Signed-off-by: David Ventura <david@davidv.dev>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  4 ++++
>>   Documentation/admin-guide/nfs/nfsroot.rst     |  3 +++
>>   net/ipv4/ipconfig.c                           | 23 ++++++++++++++++---
>>   3 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b47940577c10..b07a035642fa 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2291,6 +2291,10 @@
>>   
>>   	ip=		[IP_PNP]
>>   			See Documentation/admin-guide/nfs/nfsroot.rst.
>> +	ip.dev_wait_ms=
>> +			[IP_PNP]
>> +			See Documentation/admin-guide/nfs/nfsroot.rst.
>> +
>>   
>>   	ipcmni_extend	[KNL,EARLY] Extend the maximum number of unique System V
>>   			IPC identifiers from 32,768 to 16,777,216.
>> diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
>> index 135218f33394..f26f7a342af6 100644
>> --- a/Documentation/admin-guide/nfs/nfsroot.rst
>> +++ b/Documentation/admin-guide/nfs/nfsroot.rst
>> @@ -223,6 +223,9 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:<dns
>>     /proc/net/ipconfig/ntp_servers to an NTP client before mounting the real
>>     root filesystem if it is on NFS).
>>   
>> +ip.dev_wait_ms=<value>
>> +  Set the number of milliseconds to delay after opening the network device
>> +  which will be autoconfigured. Defaults to 10 milliseconds.
>>   
>>   nfsrootdebug
>>     This parameter enables debugging messages to appear in the kernel
>> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
>> index c56b6fe6f0d7..cbf35163b973 100644
>> --- a/net/ipv4/ipconfig.c
>> +++ b/net/ipv4/ipconfig.c
>> @@ -82,8 +82,6 @@
>>   #define IPCONFIG_DYNAMIC
>>   #endif
>>   
>> -/* Define the friendly delay before and after opening net devices */
>> -#define CONF_POST_OPEN		10	/* After opening: 10 msecs */
>>   
>>   /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
>>   #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
>> @@ -101,6 +99,7 @@
>>   
>>   /* Wait for carrier timeout default in seconds */
>>   static unsigned int carrier_timeout = 120;
>> +static unsigned int dev_wait_ms = 10;
>>   
>>   /*
>>    * Public IP configuration
>> @@ -1516,7 +1515,8 @@ static int __init ip_auto_config(void)
>>   		return err;
>>   
>>   	/* Give drivers a chance to settle */
>> -	msleep(CONF_POST_OPEN);
>> +	if(dev_wait_ms > 0)
>> +		msleep(dev_wait_ms);
> What's the point to wait more than CONF_POST_OPEN with the change?

I didn't have anything specificin mind - shall I change this

to only enable/disable the 10ms wait instead of allowing a configurable 
value?

>>   
>>   	/*
>>   	 * If the config information is insufficient (e.g., our IP address or
>> @@ -1849,3 +1849,20 @@ static int __init set_carrier_timeout(char *str)
>>   	return 1;
>>   }
>>   __setup("carrier_timeout=", set_carrier_timeout);
>> +
>> +
>> +static int __init set_dev_wait_ms(char *str)
>> +{
>> +	ssize_t ret;
>> +
>> +	if (!str)
>> +		return 0;
>> +
>> +	ret = kstrtouint(str, 0, &dev_wait_ms);
>> +	if (ret)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +__setup("ip.dev_wait_ms=", set_dev_wait_ms);

