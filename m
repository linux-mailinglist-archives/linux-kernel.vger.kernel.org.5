Return-Path: <linux-kernel+bounces-129867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68B89716D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE9B2AF5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE451487DF;
	Wed,  3 Apr 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tb+ReZxg"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BB1DFCE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151896; cv=none; b=sPJCMK7FT/RUgsrZZs+HjaljgoLdim5BP3o402JhEi+SEO0H5j0ieYFtlxW+3F3VveB8PSTt1s7JdAfAJgG56Gj/2HmduU/JTSZUJaOrlZ7OWpP4dzdKfturbgmNeJMN+uCdnqNlgfEFMbXPutpCbNAirZ5n/LoZ6mupRhk/gWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151896; c=relaxed/simple;
	bh=F75LonjtDwlNXFBva+zn4kv8XePXXdYv9gTZZ/GIFdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7EVWzs6hdQjy1mprC7ERPQZgI9NwIbYzzMZFZt8WCx+POao+cvnJVWfS8INR0AfAPbdDi4/jL1iV5e5omZx/zilTvdVaY7WL018VwOszaC1luahmapen158+/nnGT+kzRjJ0QqnvAigsdEiMpe9qt43X+o01W60+jzVGHtF4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tb+ReZxg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso60478539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712151893; x=1712756693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYUiEK8E1sx7xpi6BOcpI2EaSW3yUWioYsWwaMCl5Gg=;
        b=tb+ReZxgCubJoYxQEetWeeqtoX/BqGePEtWW7IWcckCBgrFdXemkjy+dPV++j2ajSe
         D9zzhXLURPlYUmtxpHxkUVFUdXdh0efJU3Awxurd/N1ohuskh8jxlVTue28owSPsIVnb
         OTNygT0K8JexcFBYR16HHfoVnBG1o3cTVlqfEc/GYEbiugGjs1E0a6ulxcrSvWNQqQ7h
         J2y/rSRgdtoTsHKydNQemVh2bbdl/OFJizOBQSjbTrJYent19jE2n54To06LOdrwjorv
         noNFQhVRr3zbmbIAEbuByDpIRaq2RTVQdHvt8vxccUydK/NQUC7WNJ0Aqylg5mHj9XLv
         iQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151893; x=1712756693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYUiEK8E1sx7xpi6BOcpI2EaSW3yUWioYsWwaMCl5Gg=;
        b=EyOzRvY3kCVCN0chAvBovVY2cqpXJwgX2UXs1b/cfwtiVKZ2qcLzpleJJnDx4tbKGf
         40VvH/sw3yRU21Ge6XrslZsQbAgR6GNV9k6tx+Ifygkr4rJZfcCCamHPW+0iimOUuioN
         YfNgfPYLq2DW7xnG0VW8hG/AOgj7sm26bgw7/z9FP38tgeYU1jOaKuLjyn/Q90DkA+b+
         SV199+9OJI0jibCdS4b8VlcdjH+ysav3Oxnt1ENonM7OJ2nKc/k4ERr0e4fwjpxBvtAg
         05Nrj4ozMlb/Zwh6ApeUl8aAbpLmreeRSgjIpmGAO/xdPrZiWMGU40tzfJFwgFyhzZVl
         yVeA==
X-Forwarded-Encrypted: i=1; AJvYcCWfnouPqC0g4TErgSgwo+a3hzffVyThjnoJxOEb+vGJYQmMPfB7jn54nPnMMxLlilzGRQTC2xYwVqS/XlDcL/zsz5g4/Jbu84MmIkEl
X-Gm-Message-State: AOJu0YxLkQJ85Nnl8XMJg8XmC4XwE2LuEY4CiAYZ0wDPsuCtzXTyi4Wm
	3zYj+p7CuiTspcVlH3ZY2pJvcfbEecKi1Tc+GJo2/Fx/k9MWXzKfEwO/7WtytVE=
X-Google-Smtp-Source: AGHT+IFiVj2+RbRrFiPSwAJLbcVhGhHRt/GlPoPiS3ctCNlSrvDN2vDkatZJo4osH6z/B6RQkar2kA==
X-Received: by 2002:a05:6602:3422:b0:7d0:5b47:8f57 with SMTP id n34-20020a056602342200b007d05b478f57mr18956163ioz.1.1712151893563;
        Wed, 03 Apr 2024 06:44:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w9-20020a056638138900b0047f14f6a3f8sm477987jad.107.2024.04.03.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:44:52 -0700 (PDT)
Message-ID: <8fc38d0e-4138-4624-800e-b503bbd744e1@kernel.dk>
Date: Wed, 3 Apr 2024 07:44:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] userfaultfd: convert to ->read_iter()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402202524.1514963-1-axboe@kernel.dk>
 <20240402202524.1514963-3-axboe@kernel.dk>
 <20240403-plant-narren-2bbfb61f19f0@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240403-plant-narren-2bbfb61f19f0@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 4:09 AM, Christian Brauner wrote:
>> @@ -2215,16 +2216,25 @@ static int new_userfaultfd(int flags)
>>  	init_rwsem(&ctx->map_changing_lock);
>>  	atomic_set(&ctx->mmap_changing, 0);
>>  	ctx->mm = current->mm;
>> -	/* prevent the mm struct to be freed */
>> -	mmgrab(ctx->mm);
>> +
>> +	fd = get_unused_fd_flags(O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS));
>> +	if (fd < 0)
>> +		goto err_out;
>>  
>>  	/* Create a new inode so that the LSM can block the creation.  */
>> -	fd = anon_inode_create_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
>> +	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
>>  			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>> -	if (fd < 0) {
>> -		mmdrop(ctx->mm);
>> -		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
>> +	if (IS_ERR(file)) {
>> +		fd = PTR_ERR(file);
>> +		goto err_out;
> 
> You're leaking the fd you allocated above.

Oops yes - thanks, fixed.

-- 
Jens Axboe


