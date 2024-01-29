Return-Path: <linux-kernel+bounces-43306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E9A8411F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE49B2519B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9466F080;
	Mon, 29 Jan 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWX9wu8z"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2166F08F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552299; cv=none; b=YDLsI4xzdNvT8LPN/gl2+z/DP9vKgB5MhjYpHbi6GewTHr+2ZH3+l2PwPCLgODUq0MFMQwewOY7PYPkQz8BCRZJc8mcd5dBsXhVpt9434sbqa3NcHyYVCJm4q/0eomjzYFtyv6wQq0gU8So0k7+Vk0OdspfupL56THDcGimZIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552299; c=relaxed/simple;
	bh=RlpRow3CqzT0lKovy1uJ/GWXsTUCY3Hx4347GCJxhzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI6vh7P/oON1ML3LkKxsxC73wVpIOMv2N7PC+EmIgy1dAZzR+DRXPl2IhxY4mt5g+MrnHzJ7RPtixwleH5MshtoQ2JYxIZEQqCCHGVvOmGRgYzA/sqC72Jbz8Fjx74NYDAmqRQwE/4VH1rD3qpQdMbbQGfQMAwXkKlBt39+w0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWX9wu8z; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1541738a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706552297; x=1707157097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JsXah7Pkji3SDbAVdxC7AsWo6lMd1Lw+YEA9IO4bmc=;
        b=dWX9wu8zHRkubfZkZN8k3PUEaQinkAUc7cYkWFa3fuDaJSbEODmyHYkBzd3JYk2/K7
         F4cS5zQVJpMtsCPUGlFPBf+oIz+YHxXiAV43IOsNhWl1pv9U72nYPJDCxMnx0ngbvsHa
         udMC4zRCDuXDym/x0ocJu2acoeEzIpxcgrL8Y6AMaJLzL8g1QMBBne7qdOMu05H9xjZi
         pAX/l8i/JfZeh33ptseINodQyeXX8HIzkW4zNI5CbLVKFa3ef3k1LVTdi3IkHjNuByba
         pGy1osJD7gPMuHIoSwz2PjP9Qn6fEYJo5S93V+uqGfqQq3lAxzTkwtjGPEwQXCFhzhUv
         kcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552297; x=1707157097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JsXah7Pkji3SDbAVdxC7AsWo6lMd1Lw+YEA9IO4bmc=;
        b=I/mT+gxhlcd2H+SY7DeB7pd5NYWDbCK7a6XbPSJpv4yhf1TA4m4qgiwZZcMFM+YOAo
         2TAz0CJFvR/Kk71tmE4Y/TPPHixiHsxq3U3+0ewtE3S2SxicwJiAauGtefDm9V3sk4o8
         apd8I7xGH46vY2VpBVb6tNRfh9WmHJAHc3Ugr6sogOKD/CPnXnzU9dv7f5XivZZs1oND
         zEyEV8vK8y7U0HOrX2zXDZ6+YBJjb/JmJKQyALK5q/8udCC4yCG8qMqQGxAowT2s1Q7K
         7NLEVP5Cnk5dMMXG/yAm2k5+QIysIBmMPnYE3Dq9XPIYOBcQy3hdDJBQi4vD78RqRCkC
         uaGw==
X-Gm-Message-State: AOJu0YyXWjhTyLugbwKAoA/38qNT/MZTSPn8Ug/IuSqQYh0akwErPpdN
	GMCt65uM3d1/+5ABOX8ZdXV2VomCjam/ISYe3oONgC5pxG5wf9ZjS3smCfXl
X-Google-Smtp-Source: AGHT+IEIOZayRPvf1kqV9yx7ThkEdpUC11jiSqv23FB+RZT5JugHY/xnPae1bVW67tkdi0+omeF2LA==
X-Received: by 2002:a17:90b:60c:b0:290:6b66:620b with SMTP id gb12-20020a17090b060c00b002906b66620bmr2591878pjb.12.1706552297106;
        Mon, 29 Jan 2024 10:18:17 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ns1-20020a17090b250100b0028e821155efsm8804988pjb.46.2024.01.29.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:18:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 08:18:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on
 unbounded queue_delayed_work
Message-ID: <Zbfr52x97-tLP66t@slm.duckdns.org>
References: <20240126010321.2550286-1-leobras@redhat.com>
 <ZbQozqY9qOa4Q8KR@slm.duckdns.org>
 <ZbQsr1pNSoiMbDrO@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQsr1pNSoiMbDrO@LeoBras>

Hello,

On Fri, Jan 26, 2024 at 07:05:35PM -0300, Leonardo Bras wrote:
> > 	if (housekeeping_enabled(HK_TYPE_TIMER)) {
> > 		cpu = smp_processor_id();
> > 		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> > 			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> > 		add_timer_on(timer, cpu);
> > 	} else {
> > 		if (likely(cpu == WORK_CPU_UNBOUND))
> > 			add_timer(timer, cpu);
> > 		else
> > 			add_timer_on(timer, cpu);
> > 	}
> > 
> > Thanks.
> 
> I am not really against it, but for me it's kind of weird to have that many 
> calls to add_timer_on() if we can avoid it. 
> 
> I would rather go with:
> 
> ###
> if (unlikely(cpu != WORK_CPU_UNBOUND)) {
> 	add_timer_on(timer, cpu);
> 	return;
> }
> 
> if (!housekeeping_enabled(HK_TYPE_TIMER)) {
> 	add_timer(timer);
> 	return;
> }
> 
> cpu = smp_processor_id();
> if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> 	cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> 
> add_timer_on(timer, cpu);
> ###
> 
> What do you think?

Isn't that still the same number of add_timer[_on]() calls?

Thanks.

-- 
tejun

