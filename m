Return-Path: <linux-kernel+bounces-58274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39ED84E3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D9C1F24E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4E7B3E8;
	Thu,  8 Feb 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwk5Azy5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7F7AE69
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405498; cv=none; b=NcU3LD+2iFUDjtQ5kq9vTvL1FVToDyKt8J6lqGGL1p3zk0g2Iw9lsy056JSNAkN7YdWErDuDKQMqUtM6I2RmR1byaofPKXWPGrU59uMzEwsd7letBvx7QtdepGtJ9ddTVaJqJLScQO30EpW0HLzxg3+KRghvI4zBcbRtHp8Ep9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405498; c=relaxed/simple;
	bh=dFYvkaZge0c0+El6Pw1KblQbr2FK+v6Osc9jzuaaAtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FlKw2u1bfuslJUoEao9lP/q+dTFEJm6q8qvhrnhj08o7ipUNRizswpq6MYfq0cYMhuE8nn6sHK2qIbR+kTe3GRXAqqsdeGRIEXuHDO0lFC0ufCqiqxjUfXl6h0KuSFwGXfsQMsTpdrzBZoaHFMQl+F14mhuzsabC4VVvMFTHTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwk5Azy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707405496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFYvkaZge0c0+El6Pw1KblQbr2FK+v6Osc9jzuaaAtE=;
	b=fwk5Azy5+EMZ13EfxZvviuOlyUIWhRyHLC/KtPqQ57nJf33zkxz1wgz0UlSM3rrs9uxwWm
	JRwcZosU2U22TuGXYxelYMGkgoWWiGoNchVuzD8b8X8Au5KvKbSHybmXeug/kNWiMcN+8B
	ISV+p7oAHzZgJTd3qEu55qM5WxJcuWk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-t_3j19XbNYuL5lCjZ8uGSg-1; Thu, 08 Feb 2024 10:18:14 -0500
X-MC-Unique: t_3j19XbNYuL5lCjZ8uGSg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68c88fe9dadso16070606d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707405494; x=1708010294;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFYvkaZge0c0+El6Pw1KblQbr2FK+v6Osc9jzuaaAtE=;
        b=YniwXtBiLTFv7P1/9qq2KpR/fC9qOUv/7G/vvWrCJtOhzWhcL6TUHjnxDzTxDPi5vV
         vDq7q49gu6ED8Rhr6qsxion9PzyhtsBKDIFupiGYpzYF3z9FJaCU4mhaE7sCxGAF/MTL
         Nydf6cWtdLIN3X7f5W6hMkMOWa0z7YV4X9PCCNb/x6J8FcWwR5BRIng09hk3YB5wKqHZ
         Z1+5qPOL6/d1E4XOQdh77hNm6dn2hk+3BtFPqPrSIqgFiQjGOyMvTnQLrNTKnGsLjsSp
         niJDhm8NzxKNixGGNZVSYLkY7TkG65KVrZsou6HwD2gJzOnIu9Ul1RR5iB0N7O2jhAIO
         tpjg==
X-Forwarded-Encrypted: i=1; AJvYcCXdBkFdLDilKZdPlrcWQpAEgwxx0Kv9JqBDeSNJzQubh5d5bUE0hDdS4eTnmSAjesKGNJRdABBb595x5iudHGeLlnWNBcUQspQNxLeF
X-Gm-Message-State: AOJu0Yy56vTW/m9/v4kk6B6l1J0rjUZfeE7t6yeNIo48w3Ll2pu9QgiD
	L5kFKYF8PE9eivv1jdws2SFlMyfxjLguQxrLBjMaiH51BgUAIjSJPbX63DYY6w8TjB9IWrGg3ez
	JGFVY4NqoRTI/nEr/yyi7UsSEGnjZPVNmAEfhxis2LD7oBSgMkyOvvHy7kaLE+Q==
X-Received: by 2002:a05:6214:319d:b0:68c:a8df:37e1 with SMTP id lb29-20020a056214319d00b0068ca8df37e1mr4937917qvb.4.1707405494238;
        Thu, 08 Feb 2024 07:18:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIZEnArvLct7ssCt89ZvDuE8i0tTcR/bSsNs6qUP3wxpuKX66caiGzMswh/QHg0PCTSCA3Zw==
X-Received: by 2002:a05:6214:319d:b0:68c:a8df:37e1 with SMTP id lb29-20020a056214319d00b0068ca8df37e1mr4937883qvb.4.1707405493982;
        Thu, 08 Feb 2024 07:18:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHsDvETefvIWR8z0Hf7oDqKrlMQDg5hWUrGHgJF6kaFz7+Rx3vAMrU1RrdsQ1cCIjms+8YF9d5VnEK0qrGQWuaPzWWP9Md9GvM6uOrgcdMUwjraBOU1dujw3PG7ZvLfpDMo9UylKB8YF8sTZLfPYCJgxZ/GqI9z78J9ono5eZBtokNojKEYK9OUL+Ithf+QpDM9esWqMwpi5ZGDCazbt4n3ySzeWyw6c1cAmNbwMUYLndqutHzfSuYRvjx5idwihtRo861XVGk+Tg3BFuL+ceLb2uMCJkU9ierJSEsdDbh09rY82Hci6Si8aiXEnyrB0ghLm//seG/cGfMYNVYq3ITe9H4ZzD0XfgLDKQt6CmdG92W+Dnh0MfHtqOkjawoiD1jgIGqVrUCUc8eMUEBxZ9xTcm0i8gsrRoyOR0m9DuG
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id qj14-20020a056214320e00b0068cd0424f3fsm5168qvb.66.2024.02.08.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:18:13 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, linux-kernel@vger.kernel.org,
 ricardo.neri-calderon@linux.intel.com, yangyicong@hisilicon.com
Cc: Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v4 2/4] sched/fair: remove unused parameters
In-Reply-To: <20240207034704.935774-2-alexs@kernel.org>
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-2-alexs@kernel.org>
Date: Thu, 08 Feb 2024 16:18:10 +0100
Message-ID: <xhsmhwmrff0i5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/02/24 11:47, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> sds isn't used in function sched_asym(), so remove it to cleanup code.
>
> Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


