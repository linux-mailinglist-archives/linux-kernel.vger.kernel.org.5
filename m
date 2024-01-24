Return-Path: <linux-kernel+bounces-37271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27C83AD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D203B282B72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6F7C0A8;
	Wed, 24 Jan 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1wYFMkBw"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D97C0A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110832; cv=none; b=FxmziOrXBRZ8wqHNaW3eGegNamhGBMCtLsWra+mccMHWtoScq7TgfoAySUAfpm3+MHhXnAqjr2kGUMzw7wobq6SM55hcFu6MKjyYz4Mb1yA4jOpZdQcZNOMpI36uehzCXI/MBa0D7X19AGaDG28ZEwcC6KDeD1DttGarzXoRiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110832; c=relaxed/simple;
	bh=HmA5/Of8RA57iGWfYNJOIJnsqWGKdGPvKLPPKII9WVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpwl03xYi+wjmrX7arVrQSwHZrR3JswSlzBsU5xJ5HoWlkAm8iuGZAxcw+k1lrtePyNksvifbkrYuZkhoOoUZjpQVyzx9McJihkpG63M3y+o3jGVUFkcMsVeKwhDAMk7SvYFEE5UeCFMpTSZ3ibp46L/gaNJZzoufyL5aJQEfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1wYFMkBw; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso70554739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706110830; x=1706715630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sp30z39qJ5sIlGwmXa8064qBxWqWmADfo1Qv+7GX/z4=;
        b=1wYFMkBwxT9H6Ek12BTig87oWFLw5/ow3hgEQK3TicbDHwYuhI3xGPeLASGx5lXFaf
         8j+xlnIEzZ1PRqazoDaanmfAfYomKkWKXyzJ7ZhMjWIXeBLYO/eVXsOW9N2syPb5pzR6
         5rQRoWB8VJsym7y9Ms/mRzisvhSr4te4F8qqpXfk/DH04Nv2GAeNQKunTmqUd8m9dnIp
         p1JEN2opiTTdarIEiTey9BR9jghRvCUmtohVyy5a7a4qd/r9HhlbcaDVKyxNlxjOCwVb
         hN8XPIL/tgU4YnHTp/RVxogQW2xCQXf2zzEBHFRJBOrumEO29lu++rsqJMxBgVDIVVmR
         Ttzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110830; x=1706715630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp30z39qJ5sIlGwmXa8064qBxWqWmADfo1Qv+7GX/z4=;
        b=aSEG7sZzoTJBUm1z6YH9mTduD3/9npZML3Se2BjxRH5ggeTqP9UQeLbENmjTStdIiv
         EtS02Bq9KsGaGxInZVEKOHIJKhndj6cs+NlvnzLB4Vz8WaggR7MLhOcvsenSgicyXOB2
         GZdXuM+4RuXMB5+ohr1QrOLHEbmYP3ESSEUVBsmE8wsKyrj/KkEggvtN130oZqYtVpZe
         bXT7kK9+pxz6JCLeT7tzpkTh7H3P1C6ueyrQU83wIdmt2rzMWGPD9TXyNdzebk2ZLzhM
         4QLx8GjDSVtkJxtWmx8BynTkWVkj0PoH3yX0D99bi8BfDU6r5Vd+sDzFcaCwx062yETY
         q6OA==
X-Gm-Message-State: AOJu0Yzhp6tDXSRiXdfpVaE6yBnWdIXPFVDxvyn6Y8oHMqm9cX/Mst4f
	1e6O7rFQnvRdNwSxurfAZb98S1S1tAsYZ/GYsHzsauF4DxK9H5yppBnm2TbN+nw=
X-Google-Smtp-Source: AGHT+IFPlmLegu6UaxmmOMcq0IbOOnny9YxFFPLKn1lRDPjZsbjV+UoKWJadiitSxpImMLFrcagtjg==
X-Received: by 2002:a05:6e02:219a:b0:360:7937:6f7 with SMTP id j26-20020a056e02219a00b00360793706f7mr3125990ila.3.1706110829953;
        Wed, 24 Jan 2024 07:40:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j26-20020a056e02221a00b00361a166564csm4476442ilf.4.2024.01.24.07.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:40:29 -0800 (PST)
Message-ID: <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
Date: Wed, 24 Jan 2024 08:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240124093941.2259199-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240124093941.2259199-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:39 AM, Christoph Hellwig wrote:
> Make sure all in-line block layer submission runs in noio reclaim
> context.  This is a big step towards allowing GFP_NOIO, the other
> one would be to have noio (and nofs for that matter) workqueues for
> kblockd and driver internal workqueues.

I really don't like adding this for no good reason. Who's doing non NOIO
allocations down from this path?

-- 
Jens Axboe


