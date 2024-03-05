Return-Path: <linux-kernel+bounces-92579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934687226E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B52E1C21002
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756AF126F3F;
	Tue,  5 Mar 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3gTKCYw5"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0A4683
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651369; cv=none; b=O1PCGY9Xqrp5A6lqStwNr18P4ELWhS9/pmyplAyrtykucR26KfEkAmasWYaXpi09KBPXyeuqmNkTnFwTIIZs5MUlB/1ganuVYkzfZTv22t3xZFr6mXehODbfPLLaBkCrBBvVYiAW7d1T7VcbvndmEd30lDRsAFhoOZaPe67XsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651369; c=relaxed/simple;
	bh=hdCuVGSBUPeP62wVW13hZzP4jReqsbbFglcuHtVJNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFFZokeYJ/7sK9nLRCj8qNpp0+VrYagwpA8+2czzhWNcnjQPYKmmJrVg4IKVF0rwNcQgJ1hOsDdYug7ZzBd7/CDvMdLR6E64/akQHGBxwrt0h/vLAMGAdQ+XDkv5nFaXfBYikycVzOa+phRRw1HodTn9Rx/JqsJIn3RKsBrNN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3gTKCYw5; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7883810ff3fso23259385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709651365; x=1710256165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMJUcs7j0iO8KThfdIZ+8SZ0/aXDPhgmGxD0Vm/szV8=;
        b=3gTKCYw5btQGUCqqENFghLxvffYiJjL2Gy/H+Y77SOS0xE2rpYL3J3VXUDqp20BeUO
         meolbe0sHmHMA9JsI+YahO3rYX512ytM9z8839BvhmstCX1nzwDM1R6gGD6NB5j6wnMz
         1u216vzd97xehCBVUXtTNj5E/BxBU6B/xAHgdo+3dk5Q/YMTVlkRiRp+SHEcbYMKmAvv
         Ps2Y7wT+67WOsIjkaDuuV8kgm17Cc2G4LQKKPWgq45xPbeR37OR8FO0AuCOKUq+nSAGq
         Zj8F31+oDVe8CwABCCnwJWJS/38DUz2FY4Hwg5sQJ6vryOCGp34YLeKvEbhF4WIkFE2K
         1NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709651365; x=1710256165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMJUcs7j0iO8KThfdIZ+8SZ0/aXDPhgmGxD0Vm/szV8=;
        b=dKQEcLLIzKhB75jVhREbh89SLLZ/b9a/ozPvbgyT/Dd8Q/Ur3WPxpxiZpebbnTZ9Vg
         JIUH1quUOSMjOXvRxjBUQ3H8tmBeKpLxtvc0Vgm6kV86p/2GJXFD432Sk0+FfCzyHxMg
         diZyGqeTz1UMAsR6w+8kIjzLZGK+/EeoNyU1avNtfHLL/bTWqfMLe8d7yCFPWC/WvlP5
         qVp+69UId6COTws4G1rZsLLUHKKQqTu8m4v50NPbBHwVKzeL+pycZDcEWiwWn1ZYQ0lg
         YPx0d0Bewe2iXNqIEPMWEDtL1XHLy9H2fdBQi9VZX9LKgO5cDlyjvR3j88Pc0TwWreT4
         Hc+A==
X-Forwarded-Encrypted: i=1; AJvYcCXnQ4aAqr+aik+oslqeUcGhAoxDexYK/nSr8YiI41tk6Tp4CENybCmscPPSzlVOWOOic15qu4A5mRSh1ACuXcG4VsFdxtzMzhlW6CWs
X-Gm-Message-State: AOJu0Yxu9ehKD/i+3PmtA4O/eqWX6v8A/ejXzgN3WQXthCq74i/iuFzS
	zpnvAkspGdsxUIXqazuD1yi4Rkw4ugMKXo0HrSo+7v1m2UGso/xb9mMd6sMPx8Q=
X-Google-Smtp-Source: AGHT+IE2IpfsU80i1T3mMZ3R93xTJ1vHYotlevR91JRgi3ykt8c2lEcD3RWlivEX3IlhMEUM9eO+5A==
X-Received: by 2002:a05:6214:70b:b0:690:6e84:3e11 with SMTP id c11-20020a056214070b00b006906e843e11mr2241127qvz.63.1709651365113;
        Tue, 05 Mar 2024 07:09:25 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id qq3-20020a0562142c0300b0068f11430971sm6328206qvb.35.2024.03.05.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:09:24 -0800 (PST)
Date: Tue, 5 Mar 2024 10:09:23 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: akpm@linux-foundation.org, yosryahmed@google.com, nphamcs@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH mm-unstable] mm/zswap: global lru and shrinker shared by
 all zswap_pools fix
Message-ID: <20240305150923.GB1491027@cmpxchg.org>
References: <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
 <20240305075345.1493214-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305075345.1493214-1-chengming.zhou@linux.dev>

On Tue, Mar 05, 2024 at 07:53:45AM +0000, Chengming Zhou wrote:
> The commit bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared by
> all zswap_pools") introduced a new lock to protect zswap_next_shrink,
> instead of reusing zswap_pools_lock.
> 
> But the problem is that it's initialized only when zswap enabled,
> which causes bug if zswap_memcg_offline_cleanup() called without
> zswap enabled.
> 
> Fix it by using DEFINE_SPINLOCK() to statically initialize them
> and define them as multiple static variables to keep in consistent
> with the existing global variables in zswap.
> 
> Fixes: bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared by all zswap_pools")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403051008.a8cf8a94-lkp@intel.com
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

