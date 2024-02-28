Return-Path: <linux-kernel+bounces-84788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C886AB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A5D1C27D06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9736123;
	Wed, 28 Feb 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fQMEz4/y"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB82219FD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113510; cv=none; b=aRp6/K0X7mh0t9Ezaat4CzVVnG2dNgwOttCQQfa5ISw3l0TWtTLHP3J08Tdy7FZSSJM7mGLoZhnSzrFDGzxKDrOAWEUq8Yu7rBCCn/9Na4lHe9Xno4R1bngGRGPpbfoU1ajZM6vtfGo0xcv03I1OgVhRoscv1dqUKdXc841VzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113510; c=relaxed/simple;
	bh=6GGeF04HQWYOOVgF8emoialS5Ml60103rSnFJpOnveo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoyUw8BcWdGXDh6pXiMEMbMX66Y/SyOU7a5kyItGSKByB4+fJwBdgqGc/NdxH6S9/Gg6cN5v9HlHjsuZ/u2fJTjvQRfH10YIatyxgVNJSzBVJ182Q2OB71YnQ4kOkrJF/rwu7c5zJRufMgQ+fE1gzhfElIo+jR+TqWLdHf/cSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fQMEz4/y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dba177c596so4662665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709113507; x=1709718307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdtDjYqbHw4N9R6tFKPHGKX5xI8wlaodQ+T0JbRKQBg=;
        b=fQMEz4/yBonSCOyIyoRpwbYWK9akUTshzY9c0DElnYxMNyp0xZAxoGJJEhMZ1CjrMR
         oeKH0yel2sPRxOu3g8ISMOhN4Q3KTtmr0v7XzaEPl3lgqtc1zgkz5AgbpVh1HDnhS9Bl
         bd2st93YyLodbngupiJqGhyyNgDluV697zQNAm8ADcwBqFP6bcGksjfMztOk5INHkl+A
         ko59tycwnSJr1gdvrv5v+UVMh0DO9qT4BePm/xzVarsd1jlfReRNp5avDIFrKkKDKiEF
         B7Sd1mdVYW9S561A28IWUXrpWTm0LhiFZXrFE2NoB12mWRhhWv0VizvqUXWsG/1+s7z3
         1wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113507; x=1709718307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdtDjYqbHw4N9R6tFKPHGKX5xI8wlaodQ+T0JbRKQBg=;
        b=uAQRTr+lI7p0kwcbnardGsLJglOAVaMYXq7y2+oGwCPQwimMoaYKSe60MBFYe0vCo4
         9gWd9qg6L8Q34T8arlvSEkTqv6MPkrGEhRLuj8BZ9mM7s6rk+bwBm6GCEd3tn3vrDC4y
         6OYbKV2S+bpAAVmXzR/fFBVmJAUJ3j6/fDDUatHzUqS4PaFtK91yUKnS1nmZShHN4/FS
         yeTUwLNqEJgRGDkfautVHyQeIEln+JQQ7zpqRdwKSqOo8VAFvJagMye22R+LlmyKfMFz
         IaOtL7gI/ZsU2+p1/K9HiGEsgdYZsPG990homlN1a8adyM9oPe0P3lML4SwbyIihrfen
         qViA==
X-Forwarded-Encrypted: i=1; AJvYcCXL2P+nBL7z1ea0F1FzTjOdbKUHvBuTKwM0lDkfqhcwyThfcwjr/r+4hxOYiVkjRrJyR65TfPnLWQF4BjFtFgYONQcdZQMI6a2zSIm7
X-Gm-Message-State: AOJu0YyyXsfxSFJ6AlzKz/TCh9NqCJ0uLR10+/eoFUsICs+VHZDaQUUp
	yQFEi7EPsTeLg7cRm/ZufqXl0NRUzJiC6tAqlvm0QXS5aKA38AzAA2vOpLip+KU=
X-Google-Smtp-Source: AGHT+IHfOpB9FG4OVBJ1p/m39z+7wpIGQENZumzD77mzjtCwGXkGUX3WR5Pro7qqZmQtj5dSXQqwUQ==
X-Received: by 2002:a17:902:f544:b0:1dc:b6ef:e237 with SMTP id h4-20020a170902f54400b001dcb6efe237mr2203762plf.31.1709113507533;
        Wed, 28 Feb 2024 01:45:07 -0800 (PST)
Received: from [10.254.95.105] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id bb8-20020a170902bc8800b001dca3a65200sm2882479plb.228.2024.02.28.01.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:45:07 -0800 (PST)
Message-ID: <d2a988e3-892d-4dd8-b75f-96d76c89ee6b@bytedance.com>
Date: Wed, 28 Feb 2024 17:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/zsmalloc: move get_zspage_lockless into #ifdef
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nhat Pham <nphamcs@gmail.com>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240228094036.2267912-1-arnd@kernel.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240228094036.2267912-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/28 17:40, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It's only used from inside of an #ifdef section, causing a warning otherwise:
> 
> mm/zsmalloc.c:735:23: error: unused function 'get_zspage_lockless' [-Werror,-Wunused-function]
>   735 | static struct zspage *get_zspage_lockless(struct page *page)
>       |                       ^~~~~~~~~~~~~~~~~~~
> 
> Move it down into that block to avoid adding another #ifdef.
> 
> Fixes: 2258bdebb55e ("mm/zsmalloc: don't hold locks of all pages when free_zspage()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hello Arnd,

Thanks for your fix! But this series has problem and should be removed by Andrew later[1][2].

[1] https://lore.kernel.org/all/20240228043534.GG11972@google.com/
[2] https://lore.kernel.org/all/20240228035403.GE11972@google.com/

Thanks!


