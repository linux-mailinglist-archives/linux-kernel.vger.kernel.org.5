Return-Path: <linux-kernel+bounces-141343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497A8A1E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26ABB36D03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32E1534EF;
	Thu, 11 Apr 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fm6vMQyb"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A947A64
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853883; cv=none; b=g7xxp3VilVmGDtnR0i75WzSDOCXA6nkcQLnEUwdrppacGBduHLOz82s2sMHkWG3wgwOFz5a1wOxaKG1deNR0uFQcvs/DpcVx8zKBrs0vBiSAyJbc3DXkES/8BA8Znva0J6Hk/pzBXCtyzpes6/JT/mxXgP4OMW6pEi+pqA9dJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853883; c=relaxed/simple;
	bh=UnBJFcPPvwWzi0FfiqnRkFfUQdXHP/a35MX/pq5LyAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyQUV3BuazYBRDaLA4OtS40+8HlwsrRbr35+NWxy9ZbGPh5U/8ciHT5S0jdH0iFrc5d9aaNyZcw2JNIsTAFS40N3TETgyAj0aWfqzs2pnwnFzNDOMutQ5u7RhYcHM8TvTWKRGeE6qkXvrOfa/QVJnivVs6QdAZ5KGnadHJe7u20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fm6vMQyb; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so65639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712853881; x=1713458681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbctDn2ebNI1qx8fESTV2MUnI/LKkzIT0RDCKmLmiV4=;
        b=Fm6vMQybnvgWX4Zj1birgEwefGXabexCFNFeu3nDiW+dKJaQ6x1adpEq/l8hsFAY4X
         SdCLS4nYpxVIrk7CeO7ZxsigL3KvAYhEPuskgc/XTwCvP+kCLnG4VMvvxnzjA3vICJrR
         T1ikmXVTfcmTdhUX/q85ZjE/gE8uEWv7DJOtjGKmYRtkvUZoKkqoLhC2i9TOkA+q+6ty
         ksm497BdKaNudTDbp0VEzSGCz33S1a/XNSmL3+YB7RNLJfO7vepp7KrdolnJGvgaiFXI
         J3pegBmm+LTN21Tu0KKtTgmQj+9sAyRTzx17eo+0w/NL8VrMtiYKDsF3TLXLyXSk/UT8
         2FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853881; x=1713458681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbctDn2ebNI1qx8fESTV2MUnI/LKkzIT0RDCKmLmiV4=;
        b=AmZUtAgsKbfLWT4UycupOQhrCGt7umzr3uOvuOkhKYkf8V/n4AqYyxlKk5U6ny3Zt0
         KI+g2U9DSyfGWSQgZZalZuv6KV+as5WYFfegJZ505MqaFfOQTkZojF5khtLuXUQdIHU/
         6JBVfg/uf6ZAFIwv6fdUi7O6eOMHgemhNdWileDejZLlIgQSn6YsJ6ihFNt7yDQr4DnD
         3peOwwPKUNDTPEPtXAJrBOrS4zeMZ79Pt5mVWgKnaLBvrblVJFRCb+f/1m7+6UITA4h9
         LpVoqjMIpOBv0Dq/XXhd1mNsaXiqEp11UgC7OS4l12mRxrIvCKbnoQKYTGsGRuO4j9jx
         MfOw==
X-Forwarded-Encrypted: i=1; AJvYcCVLr0s0RWrwDcPdrwFT7qOPmeOpVPGcG5GLMicuptYyXWqC34DYzowl3+dZVu/8cibjcziJGoqGNYiGDv0q1LcXG4NMPrgSZ4Rlx7t8
X-Gm-Message-State: AOJu0Yz7tEekx07G7nfBdM/sxw6maHKQiOkeHIuQw9g3dsvDwfhuSWMS
	YAmjycKNBxkHZ5xUtaeXzYg3UKQoD2q8ouZ2mByY4oiUXhMHB9grHxeItCP/PcleB8D6N0Uhl3N
	g
X-Google-Smtp-Source: AGHT+IEUTrM6OumzLR/N7eIq3bgozrwf1Oz1pYJe82O+IuxY0yootlN+7gFIk0CkUsJh86R4wYtIKA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr395259ioj.2.1712853880943;
        Thu, 11 Apr 2024 09:44:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ii8-20020a0566026b8800b007cc7612f093sm492800iob.43.2024.04.11.09.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:44:40 -0700 (PDT)
Message-ID: <9a4f8738-6ad5-407e-a938-83395aa1df4f@kernel.dk>
Date: Thu, 11 Apr 2024 10:44:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] block: fix that blk_time_get_ns() doesn't
 update time after schedule
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, johannes.thumshirn@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
 <20240411032349.3051233-2-yukuai1@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240411032349.3051233-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 9:23 PM, Yu Kuai wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a16b5abdbbf5..e317d7bc0696 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1195,6 +1195,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>  	if (unlikely(!rq_list_empty(plug->cached_rq)))
>  		blk_mq_free_plug_rqs(plug);
>  
> +	plug->cur_ktime = 0;
>  	current->flags &= ~PF_BLOCK_TS;
>  }

We can just use blk_plug_invalidate_ts() here, but not really important.
I think this one should go into 6.9, and patch 2 should go into 6.10,
however.

-- 
Jens Axboe


