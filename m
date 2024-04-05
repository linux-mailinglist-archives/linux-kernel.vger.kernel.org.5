Return-Path: <linux-kernel+bounces-132330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3889932C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0158BB23BD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A314A85;
	Fri,  5 Apr 2024 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="V4vNhYP7"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE512B93
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284475; cv=none; b=mgv1FHBT4PCjk8SDuHdq3j5jqZ9zdYL9jcjcCNUSWWAuBBXNFyyAjjQTrWOMQFBBC0QB5CUBSu5Qc3ftg09zEtdbEolA0jKCjIVe0+e1a1CleRTuDGYTCZi45w5sxVyhbEtct/OEnBJBPawJPX4SyBShpkGLkOF3Dyn8ucZ3Bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284475; c=relaxed/simple;
	bh=Yya1zUFhGL7sBGcq+A3B+9GvjhbcekW+IJTJSqxRJ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI+AMC/Sv7tP+acM0PeYr71d4bunJ0nyZT9J0S8AN1AzV0Q9RFFbf4gasNtLq3DZlmz3rwLvudYlDPv77br5BcQr3FAuaDyeIpgi+jveXju0On6pcdqwM6hsmNc0eBE9iCRAb/VZ9vprupkAkzMcQPwYFWVC6xGbHkMu546e/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=V4vNhYP7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6993bc144a4so3268856d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712284471; x=1712889271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YggOfMTHpxo2322l/tx7/mfZecoLLSLuHm+PlAKVnlY=;
        b=V4vNhYP7XIEgxrMhb31qGCHfxUvX/OgwEiK1LJGn1V9ktRCYXVH3OPsTfcBdGA8FYr
         wD/NXuNTFgB0hy/766uo5rcPp4A8fsFMyiEnT+Mr3+q/D18VqcyVS20Rnh3e93twlGYZ
         SFVEGLAjk15rMU4hIGys/2m+qlSIJQXl5zRuH8lW1bkCebPzHdRyCrRMNlWVg4Y3ZZdP
         G5l3V6Z2quJpHSJW+Hn5bVbySHWDf/ij9W6u80UDENoSs7pvuVN6eOXMjJ4OOg9mFF1v
         hkQlE5OKUcicoswqjJXW/iXoo4gHxJDNC1j5a+o+VdgcgeyAMffd+5zC+MI/m7gM0f6E
         dkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284471; x=1712889271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YggOfMTHpxo2322l/tx7/mfZecoLLSLuHm+PlAKVnlY=;
        b=CUMN7ntMN+Di4qw5WdEJcIndmtbGQSoqWl1QL2ZDQ8ppzE3ffHs5/OEr5bPG0R13Kg
         MTpqVZKk4wbVahuNyMSoZuBIJsT0+ewsDKqs7sEx2/FlV5oU3483H1ZskwGlpOUUws2y
         1QhInWy4d+0uC+8hSxb+qVEFziUF/otSk21uMSiF66X6YQQZnZtkk4fTrOxn5EWvtV5a
         a8xkhOLNH89tNt03iWu7UqsNsSGy5FCoBnyUacCQJaHPsYatsLLYYjpU/h2jp3bApgqa
         6/N5eUbXZTxkBwYBky0/sLO7Bd9bfQMGssSAJ2foKRmnYfHJAohQ1Dj3Fqqq2AzKJL6N
         hVew==
X-Forwarded-Encrypted: i=1; AJvYcCWt7y2Kn3EaBfS/+IoABIWaVnnQEs7K8xrCwBe2+YW3PNOWhSC4rd6HBo87FGJzxMjpcRm2TqIq5HOFg7CYJZttflsLkZCDWW2XGWm5
X-Gm-Message-State: AOJu0Yyzj/0YFTamveMp/71C+8kAXZnFtZxqx6TEDqxdqCkBYHALCVjf
	gCkcPMon9A12rWDdkSHSUHSoc5NUs4rpK4RlAmghh3WBxiElPCsEF2W48i6LHQw=
X-Google-Smtp-Source: AGHT+IFqb0ZQ2yUFnR7Pr1NqJSMzUUBCk16I5RjHOCUoPc+c2t/90Dx09LrRe9sw7VQcaBvY+qvX7w==
X-Received: by 2002:ad4:4ee2:0:b0:699:dcb:a295 with SMTP id dv2-20020ad44ee2000000b006990dcba295mr184742qvb.46.1712284471170;
        Thu, 04 Apr 2024 19:34:31 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id dp19-20020a05621409d300b0069938902539sm267008qvb.47.2024.04.04.19.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:34:30 -0700 (PDT)
Date: Thu, 4 Apr 2024 22:34:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] mm: zswap: move more same-filled pages checks
 outside of zswap_store()
Message-ID: <20240405023429.GC641486@cmpxchg.org>
References: <20240405013547.1859126-1-yosryahmed@google.com>
 <20240405013547.1859126-4-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405013547.1859126-4-yosryahmed@google.com>

On Fri, Apr 05, 2024 at 01:35:45AM +0000, Yosry Ahmed wrote:
> Currently, zswap_store() checks zswap_same_filled_pages_enabled, kmaps
> the folio, then calls zswap_is_page_same_filled() to check the folio
> contents. Move this logic into zswap_is_page_same_filled() as well (and
> rename it to use 'folio' while we are at it).
>
> This makes zswap_store() cleaner, and makes following changes to that
> logic contained within the helper. While we are at it, rename the
> insert_entry label to store_entry to match xa_store().
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Nice one.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

