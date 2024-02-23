Return-Path: <linux-kernel+bounces-77812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F5860A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78071F22590
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCDE125A7;
	Fri, 23 Feb 2024 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixdwQJAj"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D6B66B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667793; cv=none; b=SOE2k0zzYLpxKxHnmIf//MkDbtigpycvi3k8KJ4BoTVyWrwQivXHMKVRPRWo8OHYMGNhkKXfNvmi/GvOKo/2+D44L4eLnOt8oDem4lP+coQpBLUFT5TlPLiRS5RCiBTUXrGcWFINzuxyOtfgw85g0BvFaVtkX8BiR6R2rBX4Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667793; c=relaxed/simple;
	bh=2eOqefi0VNZTnhkQdFC1j9jqkfL5vkky5ce0kHNNgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jePlP7CQ1oKBTdtqaQKxq4sd6bGbTbVKOFofMrS90m6UkF2ReN6VaL5WENe9vG4UTvT995/Rv78dSZbovy32Yn7v8kVvHnBjvHmLolE8h1Z6yZnfpqVANy+IdyQDJiUbh3tu13Ta/Afio9Eg0uWAodODQbqeVXbiZBnU6FKlqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixdwQJAj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4e2380588so129460b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708667792; x=1709272592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0GRTyFRup/uDSwIpNY903bhAXEkCVn4KPWPZ3fepfE=;
        b=ixdwQJAjGm/iWFc3Odygk94qSEtmvFa2K24GNF89p7dIi1+eC+2IvRb0SGtfbiFPTi
         5toAfl1AW9Y9gBZ6jIvt2wrLnDsBgCdlhgJaScvInxfvBrLXVIkIq4e8XEK4x/SdTBFr
         yBAsEkEtY2+3qKoa6/BFo/5nvZv9XbivX/jM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667792; x=1709272592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0GRTyFRup/uDSwIpNY903bhAXEkCVn4KPWPZ3fepfE=;
        b=qXGD6Ypyj2NdQU/4/q47E9DQ8K9PMl7UjzoaVhrSrjOy7VDyeAQYqMn26iAijbCUTS
         vQ/sjIb5fapaV5MzNIk25twG9AFXiOw1d1gZfMoxiEbLZSbpWAq65WltiaRzAdb3N6LN
         RgmZrQzaDWp1Ycfq78LZ1TaR7Jc0//fGCXSLSPKzlkO6Gdq8B4+8B8sgYn/+UPhI6gjF
         YfudJB+yN8p0a2O4ikuQAZDJ6QsKwsPPjtMkSjpUAe4Cf8IWiAsNrMqEtwT9GAKO6WXm
         hKE9HvGVDQ2ZkS5QWe/IsHhmjoyeIMaeTmh+/kyRrtlLQyzAz643ghuFB2OOtSmGhpIQ
         zcjg==
X-Forwarded-Encrypted: i=1; AJvYcCVGmlvX/5vMyZ+PD0n3nyTanwGrFmELzCA5XlYjogCQqRWqmAgNoVDTLgSPzrSVSkByiw+tjbrZFaM1A1h+ryG7QKJRN2/j1oPIGIip
X-Gm-Message-State: AOJu0YySvXs6nBg1HcRN7m1bCglpUgITY2idKWZbwiLZfNSjTprHfXB4
	5VpWG46MUqjQggb/zzaM0JQBqyp1/cFhury/+DCVX7qEzsKFx3QMfVgRCFtppQ==
X-Google-Smtp-Source: AGHT+IF0gilLsIGarp5ejEN9+WoSUvat7KELBEnCk7j3db1t5zOXCnzQZVr7cdr0DUvKNhCIi6vtmw==
X-Received: by 2002:a05:6a21:278a:b0:1a0:e089:e25e with SMTP id rn10-20020a056a21278a00b001a0e089e25emr715788pzb.46.1708667791830;
        Thu, 22 Feb 2024 21:56:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id x92-20020a17090a6c6500b00298d8804ba8sm557787pjj.46.2024.02.22.21.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:56:31 -0800 (PST)
Date: Fri, 23 Feb 2024 14:56:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com,
	yosryahmed@google.com, linux-mm@kvack.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/3] mm/zsmalloc: remove
 migrate_write_lock_nested()
Message-ID: <20240223055626.GV11472@google.com>
References: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
 <20240219-b4-szmalloc-migrate-v1-2-fc21039bed7b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-2-fc21039bed7b@linux.dev>

On (24/02/20 11:36), Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The migrate write lock is to protect the race between zspage migration
> and zspage objects' map users.
> 
> We only need to lock out the map users of src zspage, not dst zspage,
> which is safe to map by users concurrently, since we only need to do
> obj_malloc() from dst zspage.
> 
> So we can remove the migrate_write_lock_nested() use case.
> 
> As we are here, cleanup the __zs_compact() by moving putback_zspage()
> outside of migrate_write_unlock since we hold pool lock, no malloc or
> free users can come in.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

