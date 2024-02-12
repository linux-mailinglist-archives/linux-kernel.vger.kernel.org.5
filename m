Return-Path: <linux-kernel+bounces-61670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376E85152D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38711F2166C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6223A8DD;
	Mon, 12 Feb 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AI58PqFl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B93A8EC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743875; cv=none; b=uBbpi69hl8Df8QqcvWaSbddn+/Eh4oqrKSE/e9O0Y9YN+lLmYwjlciyrEKc13r+UOiOaUWvF4hHWrGfbKmWZQshWzogrv6P00QRGh4xJ6/h/Kecgv3IePtxnNRjQZANTV7T8V3h59slt4zlcP8jlLlYNak3lHekRVcYKP0MTo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743875; c=relaxed/simple;
	bh=q4qP82FOXPBJyfTKqkI7kEs7ZoU8FcrMrDnPTekYs18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFtdJ/S9Npj63TMZ5vW0wLNbVaf8Klpo74ew/Qjk/871Cu66Pj8YfW0YODG3VeEVscDAerrFgHiTOY+Qk0d2pcUxkXtCledq6Yf2soTqjMIYN5Jt5UthE5mDslyORPm6v3nGX8hx7BOIng9uPCNnXNHIOiPEIpWddwk2D4GGIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AI58PqFl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93ddd76adso22080445ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707743872; x=1708348672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qm/YqX9uEOdb2kQB3M409FAVZ5tf5xIwSXUTJ0MefI4=;
        b=AI58PqFlXdaTUiYY0MBu8L0vxOlF1wx5K3YJH3m2xtxIZK7k9jdTHCMP80UKODjZZI
         AGtcn4H6WhbMr6H5DDQ23Byj7HQNbRTSCkJ2xTW2p5ttvHlBftyctrLmEivNQBZ6Rm5n
         USHMAOMpikqIe2PfYAmNECGjvnaoUoYtdcpGT9Md2IH9Prx7XeHpT4NuhfUR9n2oUz+o
         hpkBlPQ43NkswpLl2NmH0kzEuVJscZb146CezURTivK08I4d1/sR1aYUkjilOGPG56Pp
         HOpgQ/ryipWUxi9vcF/y2hfet1WPXPvHZ9KnSuCFLKYWu63f2qTwnZJSM1U9C5rUjpgP
         1xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743872; x=1708348672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm/YqX9uEOdb2kQB3M409FAVZ5tf5xIwSXUTJ0MefI4=;
        b=Y6l6quAWF5o5oREW+s62Z/fFXhYa36jnPnyt95v5apDx+lzcc++R0nibOVTXUhSHwk
         dyJC9c+2okcT+A6r5JAGmAC1lNjglBKT8dzEkxu1lel23je/Xj1L/nwv8aoQVdtHs0UC
         2Seov7deFNEK+wL2VUemOWEjajOicB6/ESz4iXpYUQIgtJD5PW+WXEA+odwC/svxakiv
         W4MnhmW278yzrTR9syfDS51MeDNsEdMq/M87+pI94k7ue7i8xTYUO6BV2Zy3c76aA/Jl
         tS2iVHhiJ/gQjwm4uui1ArrHfXnmM9E3vBFkWKw328pZl3OclL/WLP/GZv7j3Qew0HHe
         xLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSswrNNUKdND/LKUlP/gYn0a5eW+m9oFcfbyjRUaQKBIOJonJ0bO7TSKOuJzJLQwIhSxEA2FU1I1Ud0Aah1nlY5bCjPnSw+VWsYd+K
X-Gm-Message-State: AOJu0Yy/Bx1RN3xTLGvUdRdJEmr5zPlHOQfRHifqGZZkBj/IIsl7wivY
	I/nmEvJfe1gnsgj3FcBXUyBp8b4PXcSqLIziWuQh5KBGEeanU3iEFv5Yg209g/Q=
X-Google-Smtp-Source: AGHT+IG4i2F8jes8SWyhPU9KzSPg92BHLobuOB60eNJ5XoqdtqSJy2pk8QJ2bS+RXJDsRCu4HUKbeg==
X-Received: by 2002:a17:902:d2d2:b0:1d8:f071:5067 with SMTP id n18-20020a170902d2d200b001d8f0715067mr7055492plc.35.1707743872372;
        Mon, 12 Feb 2024 05:17:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx1ihhn9KToX8YItEUX78cWAXU6fzVhUpXmF9/mp/4ogkpwNeWJ0edTGMaQ49NRdbv/u7fJmam54FIUEF9MaKPo0HZj174f2iFwvoAHTiUKQmu28RQEVHt06PGaAFhYYss1cA9fhM7z/VCyOEn38AZyQwQaChYyr2ECUm0zjU5c6c2fwdKlI6kWMH0OEfCqszPbQA/1tLAqJ7YWhiuLLWM7HKOJT6GlS5dmU5qxU84KLM7w0ZzMfwChA==
Received: from [10.255.183.165] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902c74d00b001d963d963aasm323858plq.308.2024.02.12.05.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:17:51 -0800 (PST)
Message-ID: <f4143532-ece4-413a-ab59-45f91cfe66d9@bytedance.com>
Date: Mon, 12 Feb 2024 21:17:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all
 zswap_pools
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
 <202402120226.TK7G37U9-lkp@intel.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <202402120226.TK7G37U9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/12 03:01, kernel test robot wrote:
> Hi Chengming,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 191d97734e41a5c9f90a2f6636fdd335ae1d435d]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/mm-zswap-global-lru-and-shrinker-shared-by-all-zswap_pools/20240211-220028
> base:   191d97734e41a5c9f90a2f6636fdd335ae1d435d
> patch link:    https://lore.kernel.org/r/20240210-zswap-global-lru-v1-1-853473d7b0da%40bytedance.com
> patch subject: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
> config: x86_64-randconfig-013-20240211 (https://download.01.org/0day-ci/archive/20240212/202402120226.TK7G37U9-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120226.TK7G37U9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402120226.TK7G37U9-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/zswap.c: In function 'zswap_shrinker_count':
>>> mm/zswap.c:1300:42: error: 'pool' undeclared (first use in this function); did you mean 'zpool'?
>     1300 |         nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;

Forgot to test with !CONFIG_MEMCG_KMEM, need to change to zswap_pool_total_size here.

Thanks.

