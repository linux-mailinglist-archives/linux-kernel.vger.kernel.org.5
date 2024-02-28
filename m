Return-Path: <linux-kernel+bounces-84490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971386A75F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42602287E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7820328;
	Wed, 28 Feb 2024 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQE9xELG"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6E1F94D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092450; cv=none; b=s6noFDQkf8v9+WlRsZiFWoKNdcgBIiY6gRfwin9rGaXuR2Trn7mENoJyvmG+OeG1tBAvppUOmfkCveUc3esNdXDGKwQ03uo9jWRdQtjYSTXw30z61LLIui//MUtlE2blRBubI8jkul7vs5Tg4LM6UhoWifqyZ+uoxckPYjVRXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092450; c=relaxed/simple;
	bh=Gys5rIVEqU+8ZAfbcIk9B2jQAfl//a/eRahES1W3iQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La2nbKjl1smpeLUwWxMQx9UuTUmwzkyADwuMRYx1d0FkIC3ZYlHeTYdFMOFlZb9cS9XYjTJ/q8pzlkP4MW3pZuywNBPi+UPPT1bfcV/OKTjUlX9SWMjQpMjB5QYmGYWDX7CCEifaMDCqMWKCQnHVzOmzYa8S47RfUKb02DNwoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OQE9xELG; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a05923b689so1582709eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709092448; x=1709697248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KY8CoTVB6M487loVkFhchrHttyfk+9wVAAJEvNgRsw=;
        b=OQE9xELGZTcPwKRTOW+BqT9zLlCuGvfmzvrpmaG5JTECx2m6mWLqbXIp4tAi+C/Fr5
         EiF1d9zqb6oYzWWjjUaIpnmrbshueizq1foSNaAz+S7fPaO21u3guxBHrmGvpszJ90Jg
         Z2TFQvnoHbbMuWPNz3pVpQUWQuIW/nC9iIPhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709092448; x=1709697248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KY8CoTVB6M487loVkFhchrHttyfk+9wVAAJEvNgRsw=;
        b=xNyH2zgu1+95bMRPnVMB6ufN6b5y5WQao3OQst/5hqxo91bVaaz7AbtmWwwj9HHDQK
         uOgljYkzqqhl/U3g/Mgur9IUR8oGf57qUVioobthWqy0dnuFhYc8GXG1WoSdEBvsoleh
         CXDkEhZACIEG+6F5oH2jNet4zL9jIiQqS87anjnY1tEPQ/PWJwQF+Oe2vz6e+Kkk6STX
         npMclN1CYjqJPSmj0Vf7c1WKDhU4935IBnpBouVETH6EOhIyxAdhh+9DNIai1E5vtumg
         pE2+xOxeAFhRf4bVqVFtGi+Kd6TjN2tQljGxWRxuzZ4x5D/S8eBVK5VSKaEsORG3Zgva
         Qkcw==
X-Forwarded-Encrypted: i=1; AJvYcCX7wvBOk7S2E9MUgvDMzKaiX94N1SvhTQg3dhEdx/+y7xw83XhxlzI+HGTEXEPslNjD+2sk6dreQL0hOP7LReJU+lPCh+Yfs/cn/u9R
X-Gm-Message-State: AOJu0YzzHuLY3gBSGgYySRsQC3//gu88Rhni3A5HZVX4mvrdhHTAaP1U
	dkbLlxkcXT7V5aXp3LTfoPAdGRnM6J2yG7t/WkYTYzHzS7XLRHymT6gvGGvCeQ==
X-Google-Smtp-Source: AGHT+IGJY8hhhtb7cW2zfwnaoGLplFysBjz2rL6AUTpyPAHUKj4C+RVZd7BcUYvG6epTqHiCyB82BA==
X-Received: by 2002:a05:6871:520c:b0:21f:cc34:ad6b with SMTP id ht12-20020a056871520c00b0021fcc34ad6bmr13281418oac.50.1709092447868;
        Tue, 27 Feb 2024 19:54:07 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f4f0:fb4d:aa01:9068])
        by smtp.gmail.com with ESMTPSA id du15-20020a056a002b4f00b006e3a69eb6c4sm6683755pfb.219.2024.02.27.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 19:54:07 -0800 (PST)
Date: Wed, 28 Feb 2024 12:54:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] mm/zsmalloc: simplify synchronization between
 zs_page_migrate() and free_zspage()
Message-ID: <20240228035403.GE11972@google.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>

On (24/02/27 03:02), Chengming Zhou wrote:
> free_zspage() has to hold locks of all pages, since zs_page_migrate()
> path rely on this page lock to protect the race between zs_free() and
> it, so it can safely get zspage from page->private.
> 
> But this way is not good and simple enough:
> 
> 1. Since zs_free() couldn't be sleepable, it can only trylock pages,
>    or has to kick_deferred_free() to defer that to a work.
> 
> 2. Even in the worker context, async_free_zspage() can't simply
>    lock all pages in lock_zspage(), it's still trylock because of
>    the race between zs_free() and zs_page_migrate(). Please see
>    the commit 2505a981114d ("zsmalloc: fix races between asynchronous
>    zspage free and page migration") for details.
> 
> Actually, all free_zspage() needs is to get zspage from page safely,
> we can use RCU to achieve it easily. Then free_zspage() don't need to
> hold locks of all pages, so don't need the deferred free mechanism
> at all. This patchset implements it and remove all of deferred free
> related code.
> 
> Thanks for review and comments!
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> Chengming Zhou (2):
>       mm/zsmalloc: don't hold locks of all pages when free_zspage()

That seems to be crashing on me:

[   28.123867] ==================================================================
[   28.125303] BUG: KASAN: null-ptr-deref in obj_malloc+0xa9/0x1f0
[   28.126289] Read of size 8 at addr 0000000000000028 by task mkfs.ext2/432
[   28.127414] 
[   28.127684] CPU: 8 PID: 432 Comm: mkfs.ext2 Tainted: G                 N 6.8.0-rc5+ #309
[   28.129015] Call Trace:
[   28.129442]  <TASK>
[   28.129805]  dump_stack_lvl+0x6f/0xab
[   28.130437]  print_report+0xe0/0x5e0
[   28.131050]  ? _printk+0x59/0x7b
[   28.131602]  ? kasan_report+0x96/0x120
[   28.132233]  ? obj_malloc+0xa9/0x1f0
[   28.132837]  kasan_report+0xe7/0x120
[   28.133441]  ? obj_malloc+0xa9/0x1f0
[   28.134046]  obj_malloc+0xa9/0x1f0
[   28.134633]  zs_malloc+0x22c/0x3e0
[   28.135211]  zram_submit_bio+0x44e/0xee0
[   28.135871]  ? lock_release+0x50c/0x700
[   28.136520]  submit_bio_noacct_nocheck+0x22a/0x650
[   28.137327]  __block_write_full_folio+0x48b/0x710
[   28.138119]  ? __cfi_blkdev_get_block+0x10/0x10
[   28.138885]  ? __cfi_block_write_full_folio+0x10/0x10
[   28.139737]  write_cache_pages+0x83/0xf0
[   28.140397]  ? __cfi_blkdev_get_block+0x10/0x10
[   28.141152]  blkdev_writepages+0x46/0x80
[   28.141810]  do_writepages+0x1be/0x400
[   28.142443]  file_write_and_wait_range+0x104/0x170
[   28.143254]  blkdev_fsync+0x4a/0x70
[   28.143846]  __x64_sys_fsync+0xe9/0x120
[   28.144491]  do_syscall_64+0x8d/0x130
[   28.145106]  entry_SYSCALL_64_after_hwframe+0x46/0x4e

