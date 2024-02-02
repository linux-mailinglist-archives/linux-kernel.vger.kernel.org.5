Return-Path: <linux-kernel+bounces-49599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81555846C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63D01C25966
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486E6E2A9;
	Fri,  2 Feb 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DwSRLa8f"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AEB7763B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866736; cv=none; b=f9ZeyvLzWq1/etGqLYHwZABrLzu6ZRPmoimDpQyvex5Zlbk2/02RRpEqg0OBN39BhWAoWevIo/JZhW4nBXgnr/GKwqAlmC1umU3fPXnb+NV57whjwE0HpDaGiPR+22g5YJfa8IhjaJ8gBVQ8xPrRoZEqGAcAnuavlWepm2dFjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866736; c=relaxed/simple;
	bh=3xDROl8J6UtI/TB7+PuBboI2rEm/Unhehxp7GPeMs30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aymh7wExbExLCamamcWOwzW41fpuExP2sMoEdx1mR2t/DVpBwaH1uwJodaschJ8VgaMOI8YbvEXimP/sCukQu0g7WfMP1YfcXviZ4Q+I3M04n2JyqvdU5wkzlyeb++i423dJMWCQEjbn1D56zvfLPaoDl5uJ0KQ/umB0jEw8P9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DwSRLa8f; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so80136a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706866731; x=1707471531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeKdhCjMRsjFWo91Ezk149/GSutxOULRZwKH5QpErwI=;
        b=DwSRLa8f6vVzm2Rzr//00AzpQCN1esfTCO+lF9Pifv6rlmx5F73M0W0u79THUDunAa
         Pqjyj4B8wqp41D8Xd1VVKSZmVLf2hjC9vPJdqqK4YB86uWIXCgyLDo0n/jBtRTL7N45e
         0wADTQIBxj8ECTMflKaTTnM3h2DFO+Vb3aSG5XIeMAjf3Y+f2zY/ymLz1xicLmbHN9nN
         m5uTIXjuw1GIwmhkPTQBGBtmZb9xipxRiLH2H76ErZpnKhS6vgseifzAPr3/uu2MdR+V
         qqiKXeIDQ0HAdPac5FMpVRYwn8tKkWxhqMFBLC+heFBKcg9Fc3CdxvlFHoZ61eUs1RMH
         IiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866731; x=1707471531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeKdhCjMRsjFWo91Ezk149/GSutxOULRZwKH5QpErwI=;
        b=lGADT6oonzkFsqp+3+jgsW7ggPdnYTetNP4pblvd+lC0jQCzuE8TlfFWoitHxOxanb
         lav+6QV6dIdDj0F53zmxNM/oSwywMoKxHQ/CrKqlSMyl64zDp+JnmHNKfJehn257jsXs
         PmC6MTK510IxuKWjLXZYXJoRk/Bm1R7fcYe8SVqMpMvf2aX77ypzPz/gisQYCEr7fp6v
         WoO4KHRdE0ev1eMOWukDnLz3U5tXCZJx0+nqmX+fNoVFcI29Z6G3gwYLSKfYgvGct943
         VLng2iTCRutZm4/37Ps/258UfQPJAaGUlaOVLAtIsIwGxQZED/+14q+90jyA7L7ODVPZ
         Rw1g==
X-Gm-Message-State: AOJu0YxZeJ2YIS59e593fdKEpqVbr4mKQu795ynIz7ZCPfApDDTannni
	zOyoEvL/1ZUDiJxaXNrLuzoEV+aKZ8YzbF586mGQRmTXEJY64cY9t6ITsEN6/HY=
X-Google-Smtp-Source: AGHT+IHXiwyKIRALIJ2SCq1vSMTLrEErtd6l9Z71z0r1zG+PeuTFxWBAltuaEReehtitiCkohmul6Q==
X-Received: by 2002:a17:906:2796:b0:a36:601d:18cb with SMTP id j22-20020a170906279600b00a36601d18cbmr6170826ejc.62.1706866730855;
        Fri, 02 Feb 2024 01:38:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU05zM+SLmpRncuDkB5z531kOG29qxnO0d3IfsxvmWQ5tM9HFuKlDNXfSfVxuuwbh0ZBixzVYdrgwcQULkyaoXO0xJ/p92fCOGxK4ymEJEy0Ut5zCHZ/tvcM8KD3CDECRlTXT2IVJqeOf4XMtfdy0fIT0k0uN/NF1S7SGqTc/Ehb9spi3nHPHkqVIUNsDh8w2aBFDxGRzrg4nJZqPW1U2N8GI3vK90SpAJbDbQfNtdhobZ40VMiA/kLawHCDsC03e6pYAjRBfH+OaZtOc84aXSIVHOtvGj4mJtXhJeN5P97HiGjxaSLxroyx1ZQ9jRi9CdxAawluwJOGCmQuiP3hYx7uUuAI4PNLeMkLSduhLt6AY0Ol4KqoPwehnGdACyKbDo9xvAfGv+8NNZNpLhO3kwkvnCj0ClnygJ4tembCHrSEaIvmFz5YzgY68dxp0f38Q==
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id pw8-20020a17090720a800b00a349d05c837sm686854ejb.154.2024.02.02.01.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:38:50 -0800 (PST)
Date: Fri, 2 Feb 2024 10:38:48 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kees Cook <keescook@chromium.org>, Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v3 00/14] fix console flushing
Message-ID: <Zby4KO9SjbC_pzEQ@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:47, John Ogness wrote:
> Hi,
> 
> While testing various flushing scenarios, I stumbled on a few
> issues that cause console flushing to fail. While at LPC2023 in
> Richmond, I sat down with Petr Mladek and we reviewed the
> v2 [0] series. This v3 series is the result of that offline
> discussion.
> 
> This series addresses the following issues:
> 
> 1. The prb_next_seq() optimization caused inconsistent return
>    values. Fix prb_next_seq() to the originally intended
>    behavior but keep an optimization.
> 
> 2. pr_flush() might not wait until the most recently stored
>    printk() message if non-finalized records precede it. Fix
>    pr_flush() to wait for all records to print that are at
>    least reserved at the time of the call.
> 
> 3. In panic, the panic messages will not print if non-finalized
>    records precede them. Add a special condition so that
>    readers on the panic CPU will drop records that are not in
>    a consistent state.
> 
> 4. It is possible (and easy to reproduce) a scenario where the
>    console on the panic CPU hands over to a waiter of a stopped
>    CPU. Do not use the handover feature in panic.
> 
> 5. If messages are being dropped during panic, non-panic CPUs
>    are silenced. But by then it is already too late and most
>    likely the panic messages have been dropped. Change the
>    non-panic CPU silencing logic to _immediately_ silence
>    non-panic CPUs during panic. This also leads to clean panic
>    output when many CPUs are blasting the kernel log.
> 
> 6. If a panic occurs in a context where printk() calls defer
>    printing (NMI or printk_safe section), the printing of the
>    final panic messages rely on irq_work. If that mechanism is
>    not available, the final panic messages are not seen (even
>    though they are finalized in the ringbuffer). Add one last
>    explicit flush after all printk() calls are finished to
>    ensure all available messages in the kernel log are printed.

I hope that I reviewed all patches. Some already had my tag.
Sigh, it took much longer than I have hoped because I was
overloaded and on a sick-leave.

Anyway, please let me know if I missed some patch or reply.

Best Regards,
Petr

