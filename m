Return-Path: <linux-kernel+bounces-108716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD7880F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28F4283CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED43C467;
	Wed, 20 Mar 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="af8FPEnj"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66B3C08F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928265; cv=none; b=EewCwJ+0Yrbqpv96NB1NkrqLH91LsTplAz4Q6ZkfLhLj1QvcjbJLa1FvHWU3VDrnqAWnOzHzC73FBSO35PPp39656MpeUZkzyiI4kE39HY2zzi60i8zHEjZyiUeCkjaHCeREzjUAfuBHOHM/OXz1rPKHEnu6yalndRJbbF+zhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928265; c=relaxed/simple;
	bh=aYvUqauW3XAIBf8VauVB+YWLGD5kYr5o2CXhUs1LuqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGQImUtPC2kSGpq6pzIq8YnayPzBLozILCmMisaDcYLpZe7K32jZ0dIgTkbLIW9HT9SUuSBL9zgLtWZm9Qxk6/zUD5AjEfDf1C78AzXIO9dEIQTx6LH+DSgFJ7vc8WzcjzYTQP5AlEyQ5+lWKqSAR+ztboaAZV18fvt09eJbzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=af8FPEnj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78850ab4075so262993285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710928260; x=1711533060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjhq1PEVAhGZ2kdB4HfNLj6p/IGSV1YaiQEcKC9VuRs=;
        b=af8FPEnjpJHDPR//+n5dPfAQ4owOylqJsR4qmlIO6ztQE4UmL1VvnIlPYiFaAk/TEH
         bS+FtONd1jOZ5XmOOE+EZnbpZ+ut+ZruOp+O9kKN/DhctmYMQoOEdZhXdZ6lWLNhdIiI
         kok+k8YvuhXzVWdxRfEiRErNeS3g0cjEiifWeO0+qPYu0NxSmxUPh81E9N1ccpR+tino
         711IqB12kYzH5dYYmmTgSxuStEkdoISTPBFQx0chqyM3eDG0dGy/EPTQMY7veeU9xRpB
         R815831rpV+E2c6IuKNs+nK5dteRmoi6Ksyid2dW7AoL55mWh89kiT4h9Qrgxt4jQRjM
         /CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710928260; x=1711533060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjhq1PEVAhGZ2kdB4HfNLj6p/IGSV1YaiQEcKC9VuRs=;
        b=wQzWdJaLDyt91e7AG8oUTrLsCSyzUfrwCLHlfPKtXCmC9DgrhkVGu0/+dxGXFhwIkr
         8yn1AuYhaqAYB9UyYB4V9yCSOi1aFdzL4dxATUu66PbAkjDo5hRKBbthY1E3NzQ/pQEu
         JRL1HYvl6Yj8A1chmjm3B3cq36NnNYdYBgTSDzNICvt8JRj67zkrPVWBWa5kfSURwQLq
         67+9OixJI0Rm9LCF6yo5lCHvar99Z5nM6KBGOUqOA/8ub95m4z4fuhfphguhpSsQo/27
         l1254DwnbO7FvY2k45UW6KuKfJnkmgWqBypdwAEAXYgQbhyvpP7oma9vEGLk2CE6om7m
         q29A==
X-Forwarded-Encrypted: i=1; AJvYcCULIgg96ftIXe2Duce3EvZSWfDahEgXhGsOzKoTshQ7xnsSTdnCzcawGtIIyCr1eOMprpzH5N/SobvotuXLV6MnmJhodKb+Kk8XoAxo
X-Gm-Message-State: AOJu0YyL46SLSv22uSGlvQyQ0kkiQBLH4F1at7EgZMeoXuKNbazQiZH9
	+HPgfZ1WZqmaiga1ragWfTqMTxjatYjX9KX+wYuN2gYhFrYk0YPqjRNVtT/w01I=
X-Google-Smtp-Source: AGHT+IGej3yUPKo0x6NaIzUJ6vdFXjvt7+s9BDm07QL7zkuqPVDB+G2T+cMn8qgZ1RdyhjYEJasuxA==
X-Received: by 2002:a0c:ef86:0:b0:696:48a2:9cd9 with SMTP id w6-20020a0cef86000000b0069648a29cd9mr453563qvr.33.1710928260485;
        Wed, 20 Mar 2024 02:51:00 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id q13-20020ad4574d000000b00692bd4905c9sm4943884qvx.15.2024.03.20.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 02:51:00 -0700 (PDT)
Date: Wed, 20 Mar 2024 05:50:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: zswap: increase shrinking protection for zswap
 swapins only
Message-ID: <20240320095053.GA294822@cmpxchg.org>
References: <20240320020823.337644-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320020823.337644-1-yosryahmed@google.com>

On Wed, Mar 20, 2024 at 02:08:22AM +0000, Yosry Ahmed wrote:
> Currently, the number of protected zswap entries corresponding to an
> lruvec are incremented every time we swapin a page.

Correct. This is the primary signal that the shrinker is being too
aggressive in moving entries to disk and should slow down...?

> This happens regardless of whether or not the page originated in
> zswap. Hence, swapins from disk will lead to increasing protection
> on potentially stale zswap entries. Furthermore, the increased
> shrinking protection can lead to more pages skipping zswap and going
> to disk, eventually leading to even more swapins from disk and
> starting a vicious circle.

How does shrinker protection affect zswap stores?

On the contrary, I would expect this patch to create a runaway
shrinker. The more aggressively it moves entries out to disk, the
lower the rate of zswap loads, the more aggressively it moves more
entries out to disk.

> Instead, only increase the protection when pages are loaded from zswap.
> This also has a nice side effect of removing zswap_folio_swapin() and
> replacing it with a static helper that is only called from zswap_load().
> 
> No problems were observed in practice, this was found through code
> inspection.

This is missing test results :)

