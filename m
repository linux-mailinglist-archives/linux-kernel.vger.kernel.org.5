Return-Path: <linux-kernel+bounces-104634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F587D152
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF26D282595
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDF45970;
	Fri, 15 Mar 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mjcTznr0"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1863EA97
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520997; cv=none; b=Jn9oBVgwd8xGu8OotUCGwmKqsHCDU/EKJEKaSFPq7kxc9ch+rZ2QDbxiy8eEVWVwHHAxUhN8mDE21qv1AKivpO5u6G6GBm05xvw4fl2Lt+DyiH6kUnYq4Cm6Z7CjKWGoZ7QArj1eWVeJTl4M1Pglyk9dqRij5koAW8pbl/E0LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520997; c=relaxed/simple;
	bh=KL2SdFZI6xj14E9gdnKkJmRkYlKkUmM4EoGRsI93QtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkxshdrYDIrbR356tHnQWLGpVlmCqWbdq+yH2PRgmM20C4e4Q1whZ/2/v4Vp0rMUYJFyBgRuqb1q9GPgaq8bzlLVjhXg/gY/69mL6heFz8WgY46j8jmMwvx2byOrcetJ8TDBQqX4Wk8C1mIb0FTENRTd+ixTPY0NTc/3FeAjHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mjcTznr0; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3667b0bb83eso3086685ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710520994; x=1711125794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NnYrkeEuyooTzIwqpfS+gG0pSUcxJ+MtV42LbV77NO8=;
        b=mjcTznr0AnttCmWs8R630cdqUoVvTyRfA2XvIzaCYQalCB+oC+Dn4yVxntdM+c7K4o
         ISpJMxFnoyZCUP3zbAPIeRcopPEjjbuBW3UDAZYZBMCZ8chnvewDkygBrQqMNmwhrtBf
         voqsNaeq7k6ua5gktQiGIwWGBb1mjSj5T+Dw8+YifwOeTjJBlKczopztKOzh90LsLE+B
         uzPDaBw1VXpUvU/QKmBhFj2T3IhdqczIL4IAFS+xsNjkP+BW2KfgdxgCCDX2CqErBIIt
         xdfz66AcD2KrOH4JhCoLQTylykypZYxKLyuzRXpvlDql22u2LOknTwcwwGRYAPAH6Pt2
         2seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520994; x=1711125794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnYrkeEuyooTzIwqpfS+gG0pSUcxJ+MtV42LbV77NO8=;
        b=RFUMneVkDeddpWtFJ4uqvaDmXRcLWHqru78qVGG2sQEQbwqvkjjK1UZskH1eMnhbEn
         xVnsyP9zjvEkORbP+haywjaF5v/IzgzBqxw09eJAeXn81at6xvwYQCiDE6f64Hq84/TM
         WlQa78pFjCualQRGQ5kwa63C3k+UA5HxvJtRCRX439o4I0h/4k7n7ur8lIBonExLouKv
         PPCeU3gSE7Ymx/GcYqk/H/4vKGVVN2FbGMlC7xQdaHRylN0GBOrTGqcib3+iSbCm9Z1k
         tObkgWA1JeKYqJqjC6+z0/uqFa6CPkGQYHq3XClQBYLAw7Xl5gheEFa63TnDX1UKlFy5
         4U+w==
X-Forwarded-Encrypted: i=1; AJvYcCXPpFeDn1WGs0vCBSauE87pzS4n1kGLm/NICqlbAu+tEPxfJFETYTWz9FI5nlTYRhSx6xMcxTchhLNzMtqIuPjvHTau8e4ccQ8/F24e
X-Gm-Message-State: AOJu0Yyo9LykXqjkyW4jptcEq/qybQ5UTTjAp97+LoHtANx0Z3X2CNxP
	9aD9zA+yUXXuT+ib2lsM4BPBjwUFlk66Vod1Ps7fhNUflHVD3fAHcR1E7dhRs10Z1R+KUvCsfRf
	0
X-Google-Smtp-Source: AGHT+IHw1pzzO7Lbgj3rvUe5D+ef6Gi98W/ojPiEC7bSUDtyXI2fQLppD6zQr3heqjbpOrSMGqElPA==
X-Received: by 2002:a05:6e02:1745:b0:366:7443:c9f7 with SMTP id y5-20020a056e02174500b003667443c9f7mr6765962ill.3.1710520993934;
        Fri, 15 Mar 2024 09:43:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a11-20020a92d34b000000b00366958eb5e8sm505837ilh.74.2024.03.15.09.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:43:13 -0700 (PDT)
Message-ID: <ed44cb26-7d23-4391-89c5-0e7b59d019f6@kernel.dk>
Date: Fri, 15 Mar 2024 10:43:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Content-Language: en-US
To: Sascha Hauer <s.hauer@pengutronix.de>, netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, io-uring@vger.kernel.org
References: <20240315100159.3898944-1-s.hauer@pengutronix.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240315100159.3898944-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 4:01 AM, Sascha Hauer wrote:
> It can happen that a socket sends the remaining data at close() time.
> With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
> out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> current task. This flag has been set in io_req_normal_work_add() by
> calling task_work_add().
> 
> This patch replaces signal_pending() with task_sigpending(), thus ignoring
> the TIF_NOTIFY_SIGNAL flag.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Should probably also flag this for stable, 5.10+ I think as the task
sigpending got backported that far.

-- 
Jens Axboe


