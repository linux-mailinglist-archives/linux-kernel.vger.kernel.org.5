Return-Path: <linux-kernel+bounces-123450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4018908D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A51F24106
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62413791E;
	Thu, 28 Mar 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aeBtfOfL"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23961849
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652945; cv=none; b=H008bHKLhelQsHu+WpJvxED3zxhNvUoK9T3o56CMMGMSIVKBODJ8rpNhtyIqGaURcfRKGkCshLnDqDEiKkJQKXeDwQ6ZrKoGfYlSTR5tdYESouCVsIX9aJCwG4fM6B4iNeJJ/O8ZbT/B3XUc7dkWwX2lmcdpszQubLnnNYgRAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652945; c=relaxed/simple;
	bh=LvTVM6ZuC50nKcrlI8MH/IZD5JlHjjHnJ+nBcmHF8jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEAKArQ/tMimtUWeS/vt+DYFN0ea0NfnWw8m3aB4KXOwCvzRPGQcFwG5H9oMi69Y1SpoYo57cUVxZBYUpKH7AEgx98j78hIiIknnGwXlen8zUqz9m6IX965CJ+kg0Lfdje74MbKUAj7TmTuSTeuzoSvAa/FLVnV1LVj8jI3FoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aeBtfOfL; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e675181ceaso777360a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711652941; x=1712257741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwcNMHArrUfgIYzQUz8OeSRd0Gobqr5qC5zdMWE8ArQ=;
        b=aeBtfOfL79iJslGSDuZhn8GTWDtUu+s2xacXxRrQu8C25462ObLKD5HTTHHrRontqs
         aX/mN5FwlBlgBdLgaPiQ4yR8qM91JwZ3XnODf/629q8YpAPL1bKlXLrIFvdKyNb9bWs1
         1wAj7i9YT3KdWO2noj99QbBHsoDByxEVlTvHlePr1djo9NpAAx0ZSpq064OLAJUSInHE
         hCrM+qbb1Z3UB7OZQA0PfHf666LiN71vj5RDKNU4ZPy1yBooVMx9jrtp3s0kZh4PKfmD
         2NIOa986Q1Z+DQ1pBR6U4OCXASCDUZhy+l3vDlnDPLJ/b2H6NCe29i12qyiMfrpybk9i
         EHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711652941; x=1712257741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwcNMHArrUfgIYzQUz8OeSRd0Gobqr5qC5zdMWE8ArQ=;
        b=s0HANSCWbEuPijmCgIHPz73dWB5g3aV3gpJInMFGAB+w0RwF0dHWxlMLhv6qDlpALl
         9E0C/lPtxLNUdAkivt6BMKChYi/KHgNyabZL4X/zaqp070Ye0u1skpcSt5eyyinmXBzz
         yGFmDNruSwVARLC/z3GtETj8BL8/dd+GMjwlHrMPkoUDvsg6VtHL1CwvRhWdwY89rvdw
         jOgwRgBNl9tnf8tZZbJ+XlIYNX+mKnrcvvV98cT6fJqK7X3clhwUJk4nyC+FvN+wrUdA
         4zxpu//B3j4qp3KwbTcKtbECBB7DMVQSfHU46RvFuxl45OfJhGoDv3AMXTIFza7PfHyi
         yoJA==
X-Forwarded-Encrypted: i=1; AJvYcCW3MA5OtYBIqs7a4jVE4RQwSSsROAgGLXy0WFr0uDwgy/qX4cFNSATQ1xkHujRetgLsouEOCy9cohKUxqhHq5mngwKaC1cYHHT6kXbP
X-Gm-Message-State: AOJu0Yzk8d9F8yHqyMmSy9mu3hp693KJLhSWaQoRdqLXPLXX63VrJund
	+xJ5rVO5Sd3wV3ZUmCzXpRzlYJJzzs05DLqIJ3T9Mk7vzAUiNBA+YWaPIY6/IJI=
X-Google-Smtp-Source: AGHT+IFgU+yMj/LuuzfKzd/WLgO0dkeef1X+Ho3zYknpv4WPUKHhZW9HPtoyA7W01Zug2g67NAf25Q==
X-Received: by 2002:a05:6830:19a:b0:6e6:8ef9:f2b9 with SMTP id q26-20020a056830019a00b006e68ef9f2b9mr188129ota.13.1711652941518;
        Thu, 28 Mar 2024 12:09:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a445100b00788357d6759sm755084qkp.11.2024.03.28.12.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:09:00 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:09:00 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] mm: zswap: always shrink in zswap_store() if
 zswap_pool_reached_full
Message-ID: <20240328190900.GD7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325235018.2028408-2-yosryahmed@google.com>

On Mon, Mar 25, 2024 at 11:50:09PM +0000, Yosry Ahmed wrote:
> The cleanup code in zswap_store() is not pretty, particularly the
> 'shrink' label at the bottom that ends up jumping between cleanup
> labels.
> 
> Instead of having a dedicated label to shrink the pool, just use
> zswap_pool_reached_full directly to figure out if the pool needs
> shrinking. zswap_pool_reached_full should be true if and only if the
> pool needs shrinking.
> 
> The only caveat is that the value of zswap_pool_reached_full may be
> changed by concurrent zswap_store() calls between checking the limit and
> testing zswap_pool_reached_full in the cleanup code. This is fine
> because:
> - If zswap_pool_reached_full was true during limit checking then became
>   false during the cleanup code, then someone else already took care of
>   shrinking the pool and there is no need to queue the worker. That
>   would be a good change.
> - If zswap_pool_reached_full was false during limit checking then became
>   true during the cleanup code, then someone else hit the limit
>   meanwhile. In this case, both threads will try to queue the worker,
>   but it never gets queued more than once anyway. Also, calling
>   queue_work() multiple times when the limit is hit could already happen
>   today, so this isn't a significant change in any way.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

