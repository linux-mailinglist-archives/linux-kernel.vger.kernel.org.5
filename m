Return-Path: <linux-kernel+bounces-52342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40A8496EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B479E28BCC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE7C12B9D;
	Mon,  5 Feb 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaMdK9eg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6C12B8A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126517; cv=none; b=euTGoOoV+ROboPWtSfJtHiuAfrKeq94eL10BRYQ5WlTclOP3CkT+7Wtq6esERAz70cRzlvzrXldBLSBp7cMSZeQ2nntTrATm+SBC7zymDIJD8CPPn6tNx8Xg0SgChdpPLgaLHC8qeOnvpSIKp8OlFQrhWta6JoQPuwCxxktqFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126517; c=relaxed/simple;
	bh=vOkWkBauSIjnyICctwQEbt61NLWFP3P5dt+ghsC6ZIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2dJzqp+jT3drO9n2z9MZ0b/HFlz4na96yk59TA/ER3otklV14EP0zSfD9SKrhtirVr1zOZZlVUlYdSjkP5MsjIJM1qRjLgEQjpN2RrmOye06x1w1jkqZLuL3Hn6OwT6eT6Azx82uBQ2psFkT9cIbYzc4HDLZ/tE6albbH72l+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaMdK9eg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707126514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMqEdAAN5pdSVqQGYvLPlIUX3Q/IBdi/Kj47gx/Pps=;
	b=YaMdK9egM4vlcqURY/M6NNJ/0H1oenqnI7lgs6r8KdJBWFhR4Uh36HYm/Kh4TDAzBYoj/Y
	n7FJUrxh6xrwQSvFdd7dQo3Mb+NRYMuVpxUHuT7/dQ2qxuR++sOB1rCpclJ83LruvLMkHQ
	HWgvZthAWbBGKJXq9JtbXaJ7Z8BUdUc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-qfsFe3v9N0q32P649CXqFA-1; Mon, 05 Feb 2024 04:48:33 -0500
X-MC-Unique: qfsFe3v9N0q32P649CXqFA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5114a261573so940015e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126511; x=1707731311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oMqEdAAN5pdSVqQGYvLPlIUX3Q/IBdi/Kj47gx/Pps=;
        b=iYQ6wQRRMtx0aXC4GAb7DLPnAPKi1SbFwpCJRzvVpvWeHB87HGdlj+a7o6GvKAsSQE
         X06dOZhjnhgMWipIpEFcEtJb1OcuEdhfptsReJgNBkxdlp7S7GbHjLt1L4WnvdjJhIDe
         GP2ybm0atGS6eN2JOYKvNPdP0tsGuAJJ84Awa8Ky6oKgaPQpAmRjQxY90smFvxn0/3eB
         DfwshJWFzQ7tyy7zF971ZWkbA+pmjOBG+X7mFIdUti+GGWGgB1mPvdiVImkAQ5fjXipv
         tWgvERr3mz66GtPrMGgbU7yi+ULp1F76TMEm0KA0xO4wXdQjI2GrbptJodu+a94n0HKW
         s9pw==
X-Gm-Message-State: AOJu0YybvM+qOgTPtygCv3ljPQsFpr9JW7k1pLoWR4Uv7jHxWQTxBVTT
	mWhghrSeI+9ZZ3d4PZ8p1kl8aWhFnTBJLK5+RJgr9k5lNFVyNWRxw4f7p7di8wyHu5G171nUQsX
	RlU8c/8qplQiMZ5cAh0UF/4F1zhupZ0MRi/O0X+2/slnolCaPQ3zGTO7idZzdIvPDWvyFkQ==
X-Received: by 2002:a05:6512:693:b0:511:467f:dbc7 with SMTP id t19-20020a056512069300b00511467fdbc7mr4513794lfe.36.1707126511295;
        Mon, 05 Feb 2024 01:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXPxHumKQqO4RAsnr6oHB0T0TKRNp1P3q2+MgoWsacArYoRw0NYX/sr7vujyPeBLB+Q5u+pg==
X-Received: by 2002:a05:6512:693:b0:511:467f:dbc7 with SMTP id t19-20020a056512069300b00511467fdbc7mr4513775lfe.36.1707126510967;
        Mon, 05 Feb 2024 01:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVlEojGt/6iiCeFKWZCcz9YHMrM3URevU2EvWPkLoBQLidEpnxZHKpYwWY8EcGfX6X4xxmo7r8B7B3iplKoZIbydMdgQSTVy/MB20QCunX4Ej28HsjvDzawcBlT8YCqOdTzxYrj6jgZTw6Sfwgl+AfNLjTCwMNGSGWGANQcRcEDmG6Udn895TNA7MQHCwM3VRqCYI9PxBqDrCJYjVilhjDQbqCY3LmY6y/tO5o213myCxQwJmQ=
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b0040fddb65d58sm879282wmo.13.2024.02.05.01.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:48:30 -0800 (PST)
Date: Mon, 5 Feb 2024 10:48:28 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH-wq v2 0/5] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZcCu7GWMPWOFYAFY@localhost.localdomain>
References: <20240203154334.791910-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203154334.791910-1-longman@redhat.com>

Hi,

On 03/02/24 10:43, Waiman Long wrote:
>  v2:
>   - [v1] https://lore.kernel.org/all/20240130183336.511948-1-longman@redhat.com/
>   - Rebased on top of wq's for-v6.9 branch.
>   - Use the new pwq_tryinc_nr_active() mechanism to freeze the new
>     pwq of an ordered workqueue until the old pwq has been properly
>     drained to maintain ordering.
>   - Make rescuer follow changes in workqueue unbound cpumask as well
>     as its sysfs cpumask, if available.
> 
> Ordered workqueues does not currently follow changes made to the
> global unbound cpumask because per-pool workqueue changes may break
> the ordering guarantee. IOW, a work function in an ordered workqueue
> may run on a cpuset isolated CPU.
> 
> This series enables ordered workqueues to follow changes made to
> the global unbound cpumask by temporaily freeze the newly allocated
> pool_workqueue by using the new frozen flag to freeze execution of
> newly queued work items until the old pwq has been properly flushed.
> 
> The cpumask of the rescuer task of each workqueue is also made to follow
> changes in workqueue unbound cpumask as well as its sysfs cpumask,
> if available.

From a testing point of view this now looks good to me.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


