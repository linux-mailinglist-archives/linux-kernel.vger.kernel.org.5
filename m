Return-Path: <linux-kernel+bounces-84417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A773886A67C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06489B25B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA992E545;
	Wed, 28 Feb 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AWEi53Fe"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BF63B3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086942; cv=none; b=JJZRn21B8lSvHD+1xrYFr4nsY7txta8kxBbMdM+PBA9Mho+PIePYOjsLyjM96SeSLL1hGCXUqHvy8hKEsNfe7jjdHjkp7TC7rreWdFEYXcf3nCbwzN2gWT6ivMTEZEjYDaxK3jFQY4t5q+2bx9CdIvyBGwh+UTdW/iQceUHWmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086942; c=relaxed/simple;
	bh=n7sKrucxmqM3nY48zUskic1CHAohwEXx76qMsz3jL3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1ulein90SSnWfd+Q70y58sZXD2/DDW9IGXB5rVNjYvQhptwQ8kvsQAE8g7waLG+WDz65dzkbvBcwMnHgJ2Um7+YeSFYkwlnY/lkUkjaTTIFFauZGe32XJxnndulQ6huxtR1+zUrVTswr/DRBvbl2h9aafHXiS6cwttiI3tK3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AWEi53Fe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6da202aa138so3405139b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709086940; x=1709691740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2thBrEP5hWhv5EqfsKxztEs5LEONNt9sxWnYlMBaPDs=;
        b=AWEi53Feu29eYnKsgTotJACkoBppbvNCuA2hI51axcu20K2MS5nFBRXuI9xuyAM92q
         p4enCYTrzJqiQWxHw9d5W9fQ3c7NpfWDgj7e42xsfc7mnF546lO+2yymeRInnC9DjWY7
         qUvVrPGAnKTAgw+V6j5OKvrNcaNW66xujMDhVNFVchjGE0S8qBs6XDZuufl9+D08Kpko
         8Bc147NZZaxcYfG6GsN8MU89mF26k+IKE1lu4KGYollKTuv7B4VeNsMdTvC8v8aY/EDm
         X1BuSfdT8yFYNTVHrA5bdrSJYUZDuAe26LTUc390X7NVMCrdV/zHnpEFvzfSJMU0HbXr
         oFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709086940; x=1709691740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2thBrEP5hWhv5EqfsKxztEs5LEONNt9sxWnYlMBaPDs=;
        b=KeK5PFK/AA+sHiQNJ5zHmlpQvnh1YgiK8E/uRsWCnq6t955FnnDHOyCtK2TVMDfwks
         y8qBZ12TWI0fpRA9E3PbjztKLtrNpfyimauBYAH89iLoSzW8eV1VlNNFooUo/T14Mlj9
         NWXLRfB9dJFz4YuBl+dnCUhuISmWgK8a7HdxMtsftbZfvlhpdJyK0mSnJoGqnnQZFsaM
         GxUaJRxcqEfFBvVzksUGpSurmCbYtLxgQ0PYr1bBEmHHXXUWQxDLS9oPhXlB0poyQE/q
         +8v3jjM+h9msxcIDroAp1mude1MOTyXapOqeAevdKwk0n5w5KYKL5cUrudDOmCjVB+YS
         uDlA==
X-Forwarded-Encrypted: i=1; AJvYcCUU8F9JJJFsAquRn/PKNw7c6ebF2de4h42bcHq9zcKAnyE+3s+U3xgy+z4AVYzCFQYhNJeONnXJM+83prbSjugZfEGHJBeoOxg5s46v
X-Gm-Message-State: AOJu0Yw99BGoN2ljXyWHxUXgO31RTlZ1ob4pFR1l7n3gdddDYBaAxDt1
	eUV3f4uEAVuyTNhwDAE4VKEc1LkHmFYH0QZ5qDSihjN6ohB+8UTxQZJuq5Z/qDQ=
X-Google-Smtp-Source: AGHT+IHRTctjx7WaD57ISb1SWcAjZ54ihHK6EK9EDmq6nLQt3jdyfnlHI/Q6KoySpg7kTSjaszF0ZQ==
X-Received: by 2002:a05:6a00:1810:b0:6e5:50f3:61a6 with SMTP id y16-20020a056a00181000b006e550f361a6mr3451574pfa.13.1709086940299;
        Tue, 27 Feb 2024 18:22:20 -0800 (PST)
Received: from [10.254.95.105] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id m3-20020a62f203000000b006dde0724247sm6768131pfh.149.2024.02.27.18.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 18:22:19 -0800 (PST)
Message-ID: <55359a0d-fced-431c-a8fe-734c739b0158@bytedance.com>
Date: Wed, 28 Feb 2024 10:22:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 0/2] mm/zsmalloc: simplify synchronization
 between zs_page_migrate() and free_zspage()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: yosryahmed@google.com, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240228015720.GC11972@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240228015720.GC11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/28 09:57, Sergey Senozhatsky wrote:
> On (24/02/27 03:02), Chengming Zhou wrote:
>> Hello,
>>
>> free_zspage() has to hold locks of all pages, since zs_page_migrate()
>> path rely on this page lock to protect the race between zs_free() and
>> it, so it can safely get zspage from page->private.
>>
>> But this way is not good and simple enough:
>>
>> 1. Since zs_free() couldn't be sleepable, it can only trylock pages,
>>    or has to kick_deferred_free() to defer that to a work.
>>
>> 2. Even in the worker context, async_free_zspage() can't simply
>>    lock all pages in lock_zspage(), it's still trylock because of
>>    the race between zs_free() and zs_page_migrate(). Please see
>>    the commit 2505a981114d ("zsmalloc: fix races between asynchronous
>>    zspage free and page migration") for details.
>>
>> Actually, all free_zspage() needs is to get zspage from page safely,
>> we can use RCU to achieve it easily. Then free_zspage() don't need to
>> hold locks of all pages, so don't need the deferred free mechanism
>> at all. This patchset implements it and remove all of deferred free
>> related code.
>>
>> Thanks for review and comments!
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> JFI, recovered from the SPAM folder
> "The sender hasn't authenticated this message"

Sorry for this, I thought the problem was fixed after testing with my own
Gmail last time. But it turns out my corporation email still sometimes has
this problem.

I will always use linux.dev email in the future to avoid these problems.

Thanks for your time!

