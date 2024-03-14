Return-Path: <linux-kernel+bounces-103730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49CE87C3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1412821F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E59757F8;
	Thu, 14 Mar 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KrQUwth4"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43076038
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444556; cv=none; b=TdY92ckQvtD0y8A4aMsz76t8VS6Sibvzw8aPHOg81EMEv3+y0Dl02hb6ttu0SmKqvOP69bclbEVH1t5/INPiHovlSujl4cHkg/ow51vnX0chMNlwCUE+ZDRHcpIxjhPUchqmako0IUuXomi4gVan7UH9GpSQPjJ3NLMh1BWoxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444556; c=relaxed/simple;
	bh=j370lb0qDBwQ17RgRxbnS+RhhoggV3WG+mP+d9ZizRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vE+/KW+OVH5CWcZvo21i6UnG6ma8fvybPy/gm+7uGWUaXX7jQUFQzUoA/ewcODU1AyOsHC2T/XZEFcp15U9y2wOe1nVcuNcUVTgQhSWIcXcaHlIW3slb3NTCWn6VOJtKSOYR6OqBtskx7Zj+DWrIx0chV+BQT1wiES5+CAf2wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KrQUwth4; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3663903844bso2145545ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710444552; x=1711049352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQVXW4pqUc+5MvS+fpWDH4aAzF9Z4lrhR/aL1NZ4TIQ=;
        b=KrQUwth42/xei+2h9bSdkVReYS9vydXkZIjEhBA1+9LrhhOrmhhG2OX3cHpOb/o/5k
         KNlciErfzLuQuek7CoV6VwW7EhvPh83d8l/q8apH3aInncSjnvnZ803wvar8LAI2Ukrj
         x2dasU5e9dVGE+RKgEb6VpttCwFwLTu/Y2SRpZ048z6oS0ZUP8NRxP38MSQJnOshzAvj
         nV0uJ5+tDNI3ZzASHB/qdr8h5yAwxUeX1tau8afX+SnYodPGjYgN0FnHkbEB1+ye/RXc
         V5SPhJ9p/r8uYwy2BueyYJGMJWHbuCPInD93xZCmNfrgwu02wEkdv24N7d8R70hnnLoI
         HAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444552; x=1711049352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVXW4pqUc+5MvS+fpWDH4aAzF9Z4lrhR/aL1NZ4TIQ=;
        b=abISbV6lX7zOozxshDgeNt7pI07uZjY5BhUwezRp6jEyToqvqkNOSA0EMmb9Xd93pe
         F8MZAPcfBnsoqbS83HAeysod2Iuv7s39qeVLIJrtpkAwzaJfeOUcppyV+0cSZ7/vgciV
         u86DUXmbEkXRNJtBL89iDx56Yioz6/ArLhSSwtGI7Y7g8SkvjisQBlXLbYfhh/I0rI63
         d4zXQfJ58fEoSY5oiPe/pXU80s+J012ibOooMkq3nkrblHuVXoLgDw5f/uflUA16/Cqb
         9ObGUVaRMS6CDaeeZikGLVXVc0BPNyM7gzyTMqDMcQxTJmeyGVHxClKnibwzHWhXUwTH
         91Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWXh0zn7WxHXFJeAPkxknVLpqT56KmuVxdzoC7cCtolT73Mq6mtWKHuFBSbrO9ezduIHvtYwKBu6R69NqcDToblBCqpT88VMvn5p2py
X-Gm-Message-State: AOJu0YyXwgEzQv9/IdENj7Z3aoZt4zkwSCc26qNxJkfnVi+YqoZgjbib
	PbJTyxSCciPe+75aQMRxTlJDxfQQ36olUGZHFDO4U9RdxJwvHilk7ZhhLcnHmKA=
X-Google-Smtp-Source: AGHT+IFnRFRmvFHBWikJqk1InfxIyI1mPjv9exDYI7mEo9NnA42myZHRsEIgotQ8Y7Ss4bvUI6aiZg==
X-Received: by 2002:a6b:5c0f:0:b0:7c8:d3ac:2d31 with SMTP id z15-20020a6b5c0f000000b007c8d3ac2d31mr3088651ioh.2.1710444551935;
        Thu, 14 Mar 2024 12:29:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fz9-20020a0566381ec900b00476e8efd3f2sm322036jab.155.2024.03.14.12.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 12:29:11 -0700 (PDT)
Message-ID: <16df2125-fdf3-49e9-9924-425a8d7e1377@kernel.dk>
Date: Thu, 14 Mar 2024 13:29:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: extract the function that checks the legitimacy
 of sq/cq entries
Content-Language: en-US
To: Xin Wang <yw987194828@gmail.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xin Wang <yw987194828@163.com>
References: <20240312194446.114312-1-yw987194828@163.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240312194446.114312-1-yw987194828@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 1:44 PM, Xin Wang wrote:
> In the io_uring_create function, the sq_entries and cq_entries passed
> in by the user are examined. The checking logic is the same for both, so
> the common code can be extracted for reuse.

Looks fine to me, though not sure how helpful it really is, it's not
like it's a lot of code and it's easy enough to read as it is. However,
a few minor comments:

>  					 O_RDWR | O_CLOEXEC, NULL);
>  }
>  
> +static bool io_validate_entries(unsigned int *entries, unsigned int max_entries, __u32 flags)

Line too long, please break list other functions. Also needs a better
name, probably io_validate_ring_entries() would be better.

> +{
> +	if (!(*entries))
> +		return false;
> +	if (*entries > max_entries) {
> +		if (!(flags & IORING_SETUP_CLAMP))
> +			return false;
> +		*entries = max_entries;
> +	}
> +	return true;
> +}

And I don't know why you use parens for the first *entries check, but
then not for the next? Should be consistent, at least.

> @@ -3854,13 +3861,8 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
>  		 * to a power-of-two, if it isn't already. We do NOT impose
>  		 * any cq vs sq ring sizing.
>  		 */
> -		if (!p->cq_entries)
> +		if (!io_validate_entries(&(p->cq_entries), IORING_MAX_CQ_ENTRIES, p->flags))

Again not sure what these parens are doing here?

-- 
Jens Axboe


