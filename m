Return-Path: <linux-kernel+bounces-87735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82586D856
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1701C20D79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962522568;
	Fri,  1 Mar 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="VPkA6xFT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040423A7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253057; cv=none; b=ZcyVkTZ6Fy6IQP0/4rDk5kiwho2lbenNnYxWcKj1q8kx12XRvF8aojH/KW+cwkr0LNzaeCi+9uOuQlyKFd5jZgQqS2VTqzvuw09RFIIt6ZCDktJFbdZEK97DL1S9I6DBnm7yF0H6HyvKWia5ILbINcoVqetkh9vhW2xiw7N/08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253057; c=relaxed/simple;
	bh=NXsqQ2Sgdkn+a9Uci3zRdC9SMnBC4lhphpNxOxge9VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahh7vHDV53zd6+BEp0oDDGK0nH0KizhFP5kcdJR121orOctB1f/aIgvkG0/HY6lraoqBprEqBfenJI/Nf4dMlzh2wLckK5YFiWolrsSvCfWDrvSyKq6WemoTTQ11/d4idRFnhtXKA6CaTFBfJyZsrfCXmEIXjIX6m6gCwsYfVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=VPkA6xFT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412c780464dso633135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1709253054; x=1709857854; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6TCxBl7DrW+C2Xnhe2LFnZv9gvBSqtviEifvQbUuYg=;
        b=VPkA6xFTZWj5HUU6zA3oO/dFBMKFPK+yWpT0+5tYNBboneGpeB7G6qDWbLTx2BMTfF
         IPc6XPG4M8HmmmuTlPofAfMVPsf7h4XrJ9kgscz7NLQy4yRy0fcl1afjmY4PsEYJVJfo
         lk897CmhX/8a9icN80pQSchcGa+Sdz1+MZzRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709253054; x=1709857854;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6TCxBl7DrW+C2Xnhe2LFnZv9gvBSqtviEifvQbUuYg=;
        b=XJZ3xmSRWj/DsZGIEc7jua5HcpPDWcYnmyZh/jQUVR2NW5bStPBBdwG2J17EggV7H4
         ICRNhkYYMq6FcGGIrGzYL8g1KF8c8lWt6Ymrk3HxpSAim6L+FnfU36b6lLnpPWHmAqGX
         xmHE1CFru1IHYoVFCtQgqsYpRJFXM3cjuOfjPYrOPMOYAGEXz0I3d1it8U8uKPfOx06n
         2+cAQPWbzfZe8+HO62XgxUPrwOop+umLBWyTywWyaxgTcdMuI/EhKgOyS1wiSE0iNGtf
         UDHiaBQJnrqaFvYonn3jwvyeRn+JrNs37QwaRhoEF1v0B4IDBdLHJSjPvoAuG9OsX787
         jFZw==
X-Forwarded-Encrypted: i=1; AJvYcCWX0icSGGDyHwKiZbUQtCFaw6DSNCVUzlBoFn6IPRleDDwdwLzwiqkWuCj2gSzrRdfYfPaYi3G1LHkeFuGpZ4eRF7cCRlpHnE2ekKww
X-Gm-Message-State: AOJu0YznNLsECgkoXiD+dKAvKfuqrPXhDNy277LElzP45Q6Uf1aTKbO4
	jzE4jz98uBjs0B8x+1jwcp1gnkMh75OpJDlxvOal8Szl9kewRM8FTbS0wAz0UcvuOaSG9NVom/i
	mZIE=
X-Google-Smtp-Source: AGHT+IEv1uPho1CWNYAKQSRLMXcGe87GuCLOXmnROkVz7nCRqDB0yheMv+Ev9X+OmGA3atwHmJZhPA==
X-Received: by 2002:a5d:6a08:0:b0:33e:fd3:8f4c with SMTP id m8-20020a5d6a08000000b0033e0fd38f4cmr101442wru.1.1709253054310;
        Thu, 29 Feb 2024 16:30:54 -0800 (PST)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0033e12a67fb3sm2331728wrq.50.2024.02.29.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:30:53 -0800 (PST)
Date: Fri, 1 Mar 2024 00:30:53 +0000
From: Chris Down <chris@chrisdown.name>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <ZeEhvV15IWllPKvM@chrisdown.name>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240229235134.2447718-1-axelrasmussen@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Axel Rasmussen writes:
>A couple of dumb questions. In your test, do you have any of the following
>configured / enabled?
>
>/proc/sys/vm/laptop_mode
>memory.low
>memory.min

None of these are enabled. The issue is trivially reproducible by writing to 
any slow device with memory.max enabled, but from the code it looks like MGLRU 
is also susceptible to this on global reclaim (although it's less likely due to 
page diversity).

>Besides that, it looks like the place non-MGLRU reclaim wakes up the
>flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
>Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
>looks like it simply will not do this.
>
>Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
>makes sense to me at least that doing writeback every time we age is too
>aggressive, but doing it in evict_folios() makes some sense to me, basically to
>copy the behavior the non-MGLRU path (shrink_inactive_list()) has.

Thanks! We may also need reclaim_throttle(), depending on how you implement it.  
Current non-MGLRU behaviour on slow storage is also highly suspect in terms of 
(lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, but one 
thing at a time :-)

