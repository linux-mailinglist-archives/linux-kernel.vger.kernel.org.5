Return-Path: <linux-kernel+bounces-39134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056483CB41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F965B2247D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6B1F60A;
	Thu, 25 Jan 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8fT/wIt"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2B10A12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207909; cv=none; b=fGJ3n3LE0sgR4SQQP04WnHNns24HSl2NVCLEnOiw+DFKImo7eIvyX5IMRSR9CfvoWDXRKFcVFYZGyrm1pERkT29mWZKCyUgWuTbLzG28ph2nWF6m7RyBUPu7c4z+A59TzhUohW0nWTYPYpbdlqhlt+nNeCU0kjQhgecKcUfRrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207909; c=relaxed/simple;
	bh=cZx+YNVP7ZTa30LGqSaWbg8X8fXKuev5Uk2WGNJ5Y4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA1SgrmOr1YLWZ5dY2HfXCxMqmf+YzLYqR0XGZfNRvUWL7Kdut4z639hhdYA1dmKf+GAfVHVcTD1T23tFEbqn3PnlMVLi1rwBoXTCwAE2Ai6lSo4JkN8qT2aF+WpkgB95YGOxqz0IaIB8XbMoqoqkEgfVRCQO6SL6hKQEFYEQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8fT/wIt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d88e775d91so7059215ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207907; x=1706812707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjpbnjVkJNaYuycPPkK9d7AUEFZBY5VnjgqUS9zaxEA=;
        b=M8fT/wIte5Tu4UuwTJdTh4It3NPDMN3BSY31FuLaii5w571zfhCch/TdWqjnWkpmsg
         SwbDvGcht+okrrzBuaqDgE2b0Y1tK69FjjsRhtEQC0JAzqdnWgH3yApNgu3yDneG/HhK
         oz/KSliA0uhEJdvZxO4tYAU8Goqz67aPulO9IUNvMJf5B1Kvtk4fWiFcfwvSSLw4BCDb
         emE2K8anNkjOg7TPfPRI2DQkQQjck0uNDSd2udQ/AxVlDYjlEk55qPXHiF0DjL2ZN8V5
         XzYCDFAy7sD9chrVKTDPKrTHNnk3tqEX65G7S4eD9pGHq0sYJFTNtcw6wt/dJsme//8C
         Csdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207907; x=1706812707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjpbnjVkJNaYuycPPkK9d7AUEFZBY5VnjgqUS9zaxEA=;
        b=aVjhhmGxw3rXpf8+sXBjey7d0KnaqftKVSTuzn9CB1bpw04QwKQc/9RI0FOnUyqgRo
         pzF+s2HAr92pm40ynrdil5dRjqgufb+YTEcJXEfwA0y/UBsqn5RyhZ+LmU2zgnAdyCTf
         y9uggAfsKjTpSoZUxoOmH2dOBHlTskX9cCSHtBIIATcGUMvNw9u1/2BdQALotwQOHhZS
         bwrNGAGo0nrgksUKTFLdXPSrfYHVJUyBF/YEN/HLtbJbyxJF5ErrRtw7XLB0SPjxf8eh
         ZOtFx9I/w9kUqwmn8RQ387MSpTAIsFg+DwuchOLgx2qMbh9iD3QOtnkRD6lwGuYaJuHr
         QFeg==
X-Gm-Message-State: AOJu0YxLgp6DWPwaIVCOtZDtAvP2ZHJTTnZpchrfuOwEdpDsbnuHFRCm
	hQ4z+zGDI2Q8q8qbPyPOBrr45/uE4fc918+A+MHUWt5KrKH6H6SUv8P5yOcS
X-Google-Smtp-Source: AGHT+IHp6qpfTLiA0iJytlA7jNybbdQ1jxKFWt5NMqE3ZB8YeEIMY98zd4QBtVKmr6KS3qkunMUe1w==
X-Received: by 2002:a17:902:fc8d:b0:1d7:1948:6f2e with SMTP id mf13-20020a170902fc8d00b001d719486f2emr132480plb.80.1706207906637;
        Thu, 25 Jan 2024 10:38:26 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001d6ea47ce68sm12386895plb.52.2024.01.25.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:38:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 Jan 2024 08:38:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] wq: Avoid using isolated cpus' timers on
 unbounded queue_delayed_work
Message-ID: <ZbKqoeC7JVcJULdI@slm.duckdns.org>
References: <20240124082938.2527697-2-leobras@redhat.com>
 <ZbGFce8ixJKb6umE@slm.duckdns.org>
 <ZbG9TjHAMJYIvwsg@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbG9TjHAMJYIvwsg@LeoBras>

Hello,

On Wed, Jan 24, 2024 at 10:45:50PM -0300, Leonardo Bras wrote:
> That's a good suggestion, but looking at workqueue_init_early() I see that, 
> in short:
> wq_unbound_cpumask = 	cpu_possible_mask & 
> 			housekeeping_cpumask(HK_TYPE_WQ) & 
> 			housekeeping_cpumask(HK_TYPE_DOMAIN) &
> 			wq_cmdline_cpumask
> 
> So wq_unbound_cpumask relates to domain and workqueue cpu isolation.
> 
> In our case, we are using this to choose in which cpu is the timer we want 
> to use, so it makes sense to use timer-related cpu isolation, instead.

- In the proposed code, when cpu == WORK_CPU_UNBOUND, it's always setting
  cpu to housekeeping_any_cpu(HK_TYPE_TIMER). This may unnecessarily move
  the timer and task away from local CPU. Preferring the local CPU would
  likely make sense.

- If HK_TYPE_TIMER and workqueue masks may not agree, setting dwork->cpu to
  the one returned from HK_TYPE_TIMER is likely problematic. That would
  force __queue_work() to use that CPU instead of picking one from
  wq_unbound_cpumask.

> As of today, your suggestion would work the same, as the only way to enable 
> WQ cpu isolation is to use nohz_full, which also enables TIMER cpu 
> isolation. But since that can change in the future, for any reason, I would 
> suggest that we stick to using the HK_TYPE_TIMER cpumask.
> 
> I can now notice that this can end up introducing an issue: possibly 
> running on a workqueue on a cpu outside of a valid wq_cmdline_cpumask.

Yeap.

> I would suggest fixing this in a couple ways:
> 1 - We introduce a new cpumask which is basically 
>     housekeeping_cpumask(HK_TYPE_DOMAIN) & wq_cmdline_cpumask, allowing us 
>     to keep the timer interrupt in the same cpu as the scheduled function,
> 2- We use the resulting cpu only to pick the right timer.
> 
> What are your thouhts on that?

How about something like the following instead?

- If current CPU is in HK_TYPE_TIMER, pick that CPU.

- If not, pick a CPU from HK_TYPE_TIMER.

- Do add_timer_on() on the selected CPU but leave dwork->cpu as
  WORK_CPU_UNBOUND and leave that part to __queue_work().

Thanks.

-- 
tejun

