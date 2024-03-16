Return-Path: <linux-kernel+bounces-105184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CF87DA3F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33566281EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22518AF8;
	Sat, 16 Mar 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EmZk4OPf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074E11CAB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710594687; cv=none; b=FiWQzSNyMn51WOePJLrqk4Pe5FBA5nShfTOxKWKemMDmugo1LhE3yV5xxpnpltp/Bkct3b8upG4EjMdYQjfDvXO6pUvDQrWe06iz9XgVoX9/FCsknaLvAZ0B1V0esgti8fq9uP0SAHnUufy/pM8+Edo3eywa+cA6M6CwmAT5xq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710594687; c=relaxed/simple;
	bh=rO4KCncAVBzKyo8HaWQ66ZO3eypp+s7wobGFla9sU40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFlhWiNBri1fApW8f1skLzuinnU6LYLIaUMeTVSXIaS3dBIaOvVS+V7t9tv2kJFqdTEVKgXO1XprNpXL0EKDId34xtJBv+2U9ay5eUTfNklrKMYVUD7la7aimX7Ae8QFhZeDmvg4VMOomRtaG09Vub2+9B33ws6BQ70iisCOJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EmZk4OPf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e694337fffso686374b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710594682; x=1711199482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FEqnSfMhQIp3TkrzYqaBX3W8VokWEZx/voZejNaF3s=;
        b=EmZk4OPfJtPtR45OueMNNGVLxG1dGDzfM9X19jY+nW6/ZOtCBc8jwYUAHyAeXZcO2o
         POwgdEaxZg2b+Jre06+mHk1/pMOxdTGpQqXuwGeWLYcY8fCwXThiKYqm3cBpzwDdHIRE
         YwzwsNGGekbJmjSBoVkVwwW3H1+JJUbGWlvz7R8wmS9AVmwaBwggWGVF2bV6vCGrb7Ia
         4TZ3A4rvkZNhGx+y/22mNot7C5DG3wn6sO7tcXqybKUgRfVtSLK9WDLeryM8QFakflJU
         8FmcIoveXMlDUMN7DMvm+WV8wddvwQEDC9dlAU0TElE0OafeMA7g25EL3UdPx6FIzJmi
         Jzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710594682; x=1711199482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FEqnSfMhQIp3TkrzYqaBX3W8VokWEZx/voZejNaF3s=;
        b=MfU1Kv5h0sUztoKam8BCCEX4g5GjCX3fJrHV1JCxCfDMmJCdzpLmZLdN2smAIWZXZV
         dhf4rSn3i/fmWUTS93f+2+Wc8vbwnlaXjVPVVjBH75pjkNgxH+rlGcjFumWk25yTLbGv
         M02c7F8WLZhalKElRNFms8C2CxFM8ZqKPzS6jo6YzaNUkPBMKLyhN41b+TqKB9eBpGsK
         2ChgD2IDQ7JnIwAA4vvyVmA5XpM3B31ZWvRJO1gRt8m/h/q1FXLNs4U9cG4PiCK59AQm
         JGAFC98pUyk0lq4XS7WUB+wJRXjsxWeK7xMuv+uKQKE90+fdJK16qCk+7aYxCPGOo1wm
         aGxg==
X-Forwarded-Encrypted: i=1; AJvYcCVAN6zc/9rQ8VDRea3q4Y//yi4mY27liTTPYMlpK7KYlXlb43Q/yCbvdE2zJmuzUYaP1jJj4Ss3mVkswPj0+CLHCuepysZss2u8tyhe
X-Gm-Message-State: AOJu0Yz2oBU0JmqThUA2j1hKCkdJJsoKRHGIMntTPxnCtVMXWDYNkAuR
	MQczXxwCpGojo53Irqoq+26wzrVL45o9CdiPgZ0iW2oSlXO4gGDF8/EqLewEHTI=
X-Google-Smtp-Source: AGHT+IEdCJENxq/g91WELKycDun7kutIeW6QGFOKcDfHgVF8lnebLkU27Q8nvUgcywXY1R1ai9z0bw==
X-Received: by 2002:a05:6a20:3c9f:b0:1a3:4721:df94 with SMTP id b31-20020a056a203c9f00b001a34721df94mr5692508pzj.0.1710594682405;
        Sat, 16 Mar 2024 06:11:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id i36-20020a635864000000b005dc507e8d13sm3998412pgm.91.2024.03.16.06.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 06:11:21 -0700 (PDT)
Message-ID: <6eb8bb77-7440-427b-bbc5-d1ac5d6533d8@kernel.dk>
Date: Sat, 16 Mar 2024 07:11:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix uninit-value in io_sendrecv_fail
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000024b0820613ba8647@google.com>
 <tencent_6C22CC2079326CC82FB96CD89458E9F6EF0A@qq.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_6C22CC2079326CC82FB96CD89458E9F6EF0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/24 6:42 AM, Edward Adam Davis wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index cd9a137ad6ce..3db59fd6f676 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -1066,6 +1066,7 @@ static void io_preinit_req(struct io_kiocb *req, struct io_ring_ctx *ctx)
>  	/* not necessary, but safer to zero */
>  	memset(&req->cqe, 0, sizeof(req->cqe));
>  	memset(&req->big_cqe, 0, sizeof(req->big_cqe));
> +	memset(&req->cmd, 0, sizeof(req->cmd));
>  }
>  
>  static void io_flush_cached_locked_reqs(struct io_ring_ctx *ctx,

This will just silence the syzbot report, as the memory is initialized
upfront. But it's not the real fix, as ->done_io could still be recycled
from a previous issue.

-- 
Jens Axboe


