Return-Path: <linux-kernel+bounces-51617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D84848D45
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B6D1C20DBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14322319;
	Sun,  4 Feb 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2y3m2fs"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE622309
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047846; cv=none; b=t+MzDAJN9DwjsGJlLCusv8hHamfzdij0594J+RDCUWkwYtE+vjqJWfL2JkHgDSdh9hXFVF0u9Erl71jhVbDTrW7bTEYapzwR27OOZPTW6OyFId8Sm8SsWhbjFAKgciOO0AdLuRX+qwXonvZLeAGCeLuRfwQ+vLTyeET+aJ+uVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047846; c=relaxed/simple;
	bh=zfHxKnze1zst7lS0M6qYgHzsqoY0Z67CTQM5r25muvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DXKN2OURfC5LWwVFj7UXaqn6/5VCDVrKfn3APONlcEW6uFfchCOlXs76vvUETZdaxP2Jyb7vAIP4be+Mswb3n3Pn9jxwOPjkVn3hh2x0xsLh6aWhfNOpoOE/zhGHqtFM6q6SEnKrZuufLg/4MeRruIBVus1BkriR9+AE+ahXDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2y3m2fs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e1270e8cd3so1678092a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707047844; x=1707652644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdnC+0PjgyOKa+pKvPd4AQCjcLpAyk4MtGcD9BnAIFI=;
        b=T2y3m2fs59WuQRyiCYNUiYGF/CS7tRI48/VKAxxjAK5fobOubYUfYObIE3gkdRwx3V
         jiFr0Ey0DfxwF5fFUArG2iB+3CS2ite4kv4/L3zOUS9jdCZKr5L0kSdivKsTTiJClksW
         Bxm/ZEz/Se4VOF2wd8+uovZvUDH3ZonXXd185YqhhecKQHcn3kYOQ5uIvq7urEwVN1/T
         /gJn9tKSF3GFOOY8Fy3KWVzNShNvfkQC1gkOM2eg2cTi5qL9abz5M3qMiyPZ8PCRIeFi
         DM4v5/QnGFdukzYf8ux4sCCevujGCvBDU36MCZdlrSNkT8LFLNNQ99H2XeVODxMtXhe+
         BoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047844; x=1707652644;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdnC+0PjgyOKa+pKvPd4AQCjcLpAyk4MtGcD9BnAIFI=;
        b=Bwai6d8REhMZ/oza6W5hS+AlPNE0WszSnMOqA31UZVBUDijwYmXC+dcIbzjuQ4IgCZ
         lv7x5mk80rJVJWUC6wvqwxzuYwcjMrleyB6ZYKBtXJNtvnjEKS9eItqI/N4SFy/oJ26F
         cig+4pxeUgng9hWJlceiFJ6ABARbA9qJ/I8spriylfVKtKolufN4lL6bsnNAqa+i2KRc
         WS+8AwbdIUMilNN2FW09717H8Bgpuy2b4TShETpkRMM3IcE8WxbZLJinM2Ff9lvaCB81
         iTVnLNabM+s7IW79DG0FpqSTm4Zk8HWTlXWt5+sNgK668ji+mtmGW9KKcnK+NUNjfn62
         TN7A==
X-Gm-Message-State: AOJu0YzulswtOmubNcCesQB7hGkACsE83r7vXqhbggEKSV+0PhYjM/z+
	hg/0biirCYaiLmCiJLRKo8yPcAOMJqMCM4Pf4iNT7vsWbO/oUJ6K
X-Google-Smtp-Source: AGHT+IEXi/xHFeohYu4bF9t/k2Y/CK3N2OEnkEjg17oJ8Jjl08ngGrx2syyQMsQJv4YAX6oO1qu/FA==
X-Received: by 2002:a05:6830:1448:b0:6db:ee16:6254 with SMTP id w8-20020a056830144800b006dbee166254mr7487028otp.33.1707047843974;
        Sun, 04 Feb 2024 03:57:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCZhuThsYJVmF8a4H0UyW5qrOgJb2pOCCqoOk2xjmcurbiAHzsYVAgLnv4i1MeQnjTKnXQMIULe/asyOvB1Vejeso0KZ/ZCZ2Oa0z8YyU1bwYBOIUCKXmSrsvfUVc3C53/yYpXfrP6zl175481AhoKJQud+OgTo69ChQDY+BTdWouuD3uhtAzLOu6yH37nTyh28XjLRPXVHqeeMKQLb3fWpDDvo0wsLW32B4+0Rt/zfA9xpbO1qzstbQo+2ma06Sb8Sa1aaYW8dBYnWM0jh1uaKlxA0LBh6+7f9QSjalpsUrEhytbeDQXCkLeQQGxXnglFS152rmDeawdI+wQq1pKbrnRTTAsbrJvYW1DqArXSb6Opou7sUpmD7cnjMONgOqRmwvc3lBBFVE+RjItd2tv0d1NBf2gOcuBSVOLGlDlSZ9ZOcFKxsx65bxEshCdO
Received: from [192.168.255.10] ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00170100b006e0414d7cf8sm385450pfc.95.2024.02.04.03.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:57:23 -0800 (PST)
Message-ID: <0b1f1de7-9394-40df-9b5c-c8c1cb1239d4@gmail.com>
Date: Sun, 4 Feb 2024 19:57:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
Content-Language: en-US
To: Valentin Schneider <vschneid@redhat.com>, alexs@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 linux-kernel@vger.kernel.org, ricardo.neri-calderon@linux.intel.com,
 sshegde@linux.ibm.com
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/2/24 10:27 PM, Valentin Schneider wrote:
> 
> Subject nit: the prefix should be sched/topology
> 
> On 01/02/24 19:54, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> The description of SD_CLUSTER is missing. Add it.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Juri Lelli <juri.lelli@redhat.com>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/topology.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 10d1391e7416..8b45f16a1890 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>>   * function:
>>   *
>>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>> + *   SD_CLUSTER             - describes CPU Cluster topologies
> 
> So I know this is the naming we've gone for the "Cluster" naming, but this
> comment isn't really explaining anything.
> 
> include/linux/sched/sd_flags.h has a bit more info already:
>  * Domain members share CPU cluster (LLC tags or L2 cache)
> 
> I had to go through a bit of git history to remember what the CLUSTER thing
> was about, how about this:
> 
> * SD_CLUSTER             - describes shared shared caches, cache tags or busses

Double "shared", so could we use:
* SD_CLUSTER             - describes shared caches, cache tags or busses?


> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
> 
> And looking at this it would make sense to:
>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
>   rename SD_SHARE_PKG_RESOURCES into SD_SHARE_LLC
> but that's another topic...

Uh, naming is a hard things. :)

Thanks
Alex
> 
>>   *   SD_SHARE_PKG_RESOURCES - describes shared caches
>>   *   SD_NUMA                - describes NUMA topologies
>>   *
>> --
>> 2.43.0
> 

