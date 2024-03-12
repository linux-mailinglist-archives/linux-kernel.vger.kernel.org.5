Return-Path: <linux-kernel+bounces-100858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D170B879E47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BECB230C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B882143C77;
	Tue, 12 Mar 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVwgfL0m"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482714375A;
	Tue, 12 Mar 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281674; cv=none; b=YdeuuB9bLAKRkt+Y7JuZi8/uH+9BBx1jqGJIh3stPln5m2Pgw6bu834v3MDtE039+85/2D2vn9Ys8pNj6GGuM0qUfP1iHbV17lFYLQ1H16+J7XuPYfSACMok4piiwpAxXyRdvtQFAe8hoJ75VouUVNr0FwV6g12EqKRRPm+X274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281674; c=relaxed/simple;
	bh=qYIO1lEZjXWQG6vPC0J4Y9X67kpBQycga3CudFSq98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW40w1X87IW6/tXlIz43eReITs7PtQoMMIVOTBA3jrT8nCo/NJV6UnOIYUbZVlRzQbXSFqzAECeZu0uGNJCwLnW3MlydrjKEPQQMCf4X/qGF1IYQ0JAYPpmDnWAqF4rY1PswUGxM6RtazLdb+6IR3b8edlFbg84jUKqqecdhas4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVwgfL0m; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a1aa46c975so176325eaf.3;
        Tue, 12 Mar 2024 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710281672; x=1710886472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c6wUX3sbOlM55YAg2meo6Cj+EsM3Jg6xyNcl4PPWJQ=;
        b=PVwgfL0mpS0R4WcmSzEqhMquSHwtoCbcMMfoispivLkvHWrypwXultdzmlq4sjCMjb
         SI91OfNXJIC4/Mm+xGvg5ShyhW7UkbxRPiP+zYMl3N816ViIs3GBWYfKbeSS6oMue7CX
         2qZf8E4ONcb3H26lCtCB4ztIpRoMYJcBcZgFj9DKoAMqLfPnaMraQ5YUtp44A4hIpJQa
         ap9WaPlikOl3ybIurQ5nMBl2RoN4XfOoVc/R0aa1Uxj3gZduWTFqkXA7wzR02heV8JEa
         rAL0L+exDEXTKay3m/Vxt+0VNludHkFUwXhks8dOtNIIltqv2M5sMhrsMYumFakJXbX4
         HBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281672; x=1710886472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c6wUX3sbOlM55YAg2meo6Cj+EsM3Jg6xyNcl4PPWJQ=;
        b=RCXyAzRmec0sK4reBevF9fLjUepjubHC0HxjvIxdJ1k9PZekUHMMipdMnRjIdMpfNJ
         ipWYvwekPWNf/GoWNvH1BPfnPTAZEofq3xt/Udo80j+M18K4KDYE+ZsfL2D+C9+YfUFc
         02cyOtRUj+VK6JiwLBf3X9GFQTUsHs0qDHv7GK2F6fkeaoUXKi66gbDehPRQD7sUpwHc
         rcKh1FbINuHocB9KznpzMq94ip1n0kzbQ1IYgpILfhPm2T5371Vus0GZLMQDHKubmGMr
         hQgfD8mi1cXQ7CABqSlktAwhya6gxSMCxfyHxxXtpMSLuVeVRDZVQIMcKfT62AEsG4fR
         QH6w==
X-Forwarded-Encrypted: i=1; AJvYcCVjdzmvN4BwlHycWyzmPqFydSKysnuvhoXPTc1sCETpz/BxFxNiKSiWnbLgLyPuouGtTdDU8H88x1AnlxcK8qcxSxP0G2OoLsmWMGLvCm9mQbKNrQx2ZX+lTzKFFeVlrAuoozm+IbE7UaT+qdOFdcI1OJhNs9n6Hxz+
X-Gm-Message-State: AOJu0Yws8KhEZ9IBCGvc8uvAlHTegNz4DjcdIlksv0YBX8YPIxJ9cZ7w
	On/x0FccHu5/7uMDpJtAkC9M6yk++6BfukOXHbqYjMNzS5aq3dB2
X-Google-Smtp-Source: AGHT+IGLAfJoyoRCDZdiRbLiJmk0PBjAy3mgWufwB3FmwP88QIS0T79LTKLeJhKU6OA5D+gTzxYdbw==
X-Received: by 2002:a05:6358:7525:b0:178:e2b3:98da with SMTP id k37-20020a056358752500b00178e2b398damr1978712rwg.28.1710281672119;
        Tue, 12 Mar 2024 15:14:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2875])
        by smtp.gmail.com with ESMTPSA id 16-20020a631350000000b005dcc8a3b26esm6499419pgt.16.2024.03.12.15.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:14:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 12 Mar 2024 12:14:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <ZfDTxhn34fihYQ_o@slm.duckdns.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
 <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org>
 <20240312134739.248e6bd3@kernel.org>
 <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
 <39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
 <20240312144806.5f9c5d8e@kernel.org>
 <20240312145455.403b713f@kicinski-fedora-PC1C0HJN>
 <fee2fccf-ef4d-4595-8f20-07ba4dc67d42@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee2fccf-ef4d-4595-8f20-07ba4dc67d42@kernel.dk>

Hello,

On Tue, Mar 12, 2024 at 04:02:08PM -0600, Jens Axboe wrote:
> diff --git a/block/blk.h b/block/blk.h
> index a19b7b42e650..5cac4e29ae17 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -534,7 +534,7 @@ static inline u64 blk_time_get_ns(void)
>  {
>  	struct blk_plug *plug = current->plug;
>  
> -	if (!plug)
> +	if (!plug || !in_task())
>  		return ktime_get_ns();

Late to the party but I think the following is what iocost is doing:

1. A cgroup overspends and needs to wait before issuing further IOs. It
   takes the current time, add the duratoin that it'd need to wait to issue
   further IOs and then schedules the hrtimer.

2. The timer triggers and runs iocg_waitq_timer_fn() which takes the current
   time and calculates its current budget (which gets replenished as time
   passes). If the pending IOs fit in the current budget, it issues them. If
   there are still pending IOs, it calculates the next timer wakeup point as
   the read current time + the time needed to resume IO processing.

3. If the read current time is sufficiently in the past, the hrtimer
   scheduled in #2 would expire immediately and if it still reads the same
   cached current time, the calculated budget would be zero. It won't be
   able to issue any more IOs and will schedule the hrtimer on the same
   exact expire time as before, falling into an infinite loop.

So, whatever that can feed actual time to iocg_wait_timer_fn() should fix
the issue.

Thanks.

-- 
tejun

