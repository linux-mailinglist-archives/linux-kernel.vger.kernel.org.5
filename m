Return-Path: <linux-kernel+bounces-112384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B2887927
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CEA1F218B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76C3D3B1;
	Sat, 23 Mar 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lOMuTTG6"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F117583
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711205581; cv=none; b=EZWcHdmzj+m0mzmOvDeapUSBcLnGgRuahcqIWQajcP5DXNym+/NTk4Lr96QrensxQNngmGPeG32PvZypruAJLR1tG3Jf63uVGr+vuE+su51/o7LFM48mKO1L4n/w+BxeUGYSR7jtFBocGGrq0LprNw/r0EIaiqZx0kweUwLq9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711205581; c=relaxed/simple;
	bh=lrtfH3zzzgl6lWeZpSHoMuGg8Ea02QXDs7/AlYdtTQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/vgjSmVIpvb//VVUyudovd7QZfA0eUDTsq7QNEbBRcYX3HDsLXQ4ioOD8bpJEoLnJEkWzoXNDxCOaiZek2JcuyB7PkavnOwORDakLK8SwBDVYB4viJtx50SdqnJloZAcSiJ9jGUxcMqYfZRFOZQqFqBwS8XmFZP0qhLb+oEUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lOMuTTG6; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690bd329df2so17011496d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711205577; x=1711810377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQy0LgbNRS2IUlbgbrbirFDizWSucGasGxIZDrnu8QQ=;
        b=lOMuTTG6K7f7ge/8wwyZGpCFSIdzCOivAV/HH/fMFoiXDKA6jAgpaI+qFTTQuuzXzb
         /U37cSD4ok3+GwlCT2gKixqBOgML4AeQUmKz0xpuHJt4buCYB4kwwNw3d5YJEU8RVNrK
         odluiA1ArOBRgV5485e3qjFOPk6NZKEGPYBxuY/k2LPtEQWHZmXC5LLn/ZVutsuNMCu3
         DQu7f2s5RuefWmqy7j3jKwUAQaHrGIIwgLOs/kdMs6Acx7uPVLNcjbHCacxLk1abeuTO
         +UxG6ub+yZ15Xe++FMa7Me2tIwxHCUApPwh626IoysVmqtvqwvWZ2Nuw1DB2pZB05xYZ
         C+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711205577; x=1711810377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQy0LgbNRS2IUlbgbrbirFDizWSucGasGxIZDrnu8QQ=;
        b=dLf9MPXkBVPomgwOKThJSDHg8idlX6gf7fkOEIHudsJRGzCDFMAsHH2HIYxv4vFtSO
         jvPihJWF4OKZy2ldMs4Svuo4sCNUkBr1PCpjm3LtLj4kndR5rzg2EGZ69NSnbbRi+beR
         4aKQCojqLScfEJSUfxALVISliXJpbHmujaEP8EZET8vZl2G6mAiDkmyG20s5k8ify8PV
         lkRF8X+bgts9y6zV/Dbulc1/P73YpHja38CAsYZNx+tdiFvJwQyrMpCSk3jJSEMiXFBH
         Y2Inx9kn0vjyBhOpQfNuIGU9ez+Oh1prUkjyYv5jJla0Gb90xweJwV9IxCyH72g5XkWA
         p/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8n7Zg4UQFM5p3D213WApmaJgq+bYQH2Q4O4wm8F5pe430HRMAUXbnVgHgdTd9T8rZFD3LKnZxs5+i7eWIlVmDpmM1i8iKVjkS1zbk
X-Gm-Message-State: AOJu0YwlWaVpFTHpynR6wAAk6nrCJVfRpE5sWRqnMSVPW7K8m6b8aCP1
	qwWM93AsIuspbAg0MgvbaqRuD4H6c3zT9yalr4brNa8vl0UFT/CqY2LoM8l8+M8=
X-Google-Smtp-Source: AGHT+IFLG11WgqsbhoxFVFpmyCIi7a1JxwIH7NvINLJUVPYcY+qqhDilTzhgQ5CdvjOQ3ISsPU74LQ==
X-Received: by 2002:a05:6214:4017:b0:696:8505:1947 with SMTP id kd23-20020a056214401700b0069685051947mr20765qvb.30.1711205577232;
        Sat, 23 Mar 2024 07:52:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id q1-20020a05621419e100b006968077890csm298604qvc.118.2024.03.23.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:52:56 -0700 (PDT)
Date: Sat, 23 Mar 2024 10:52:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	"Sharma, Shashank" <Shashank.Sharma@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix deadlock while reading mqd from debugfs
Message-ID: <20240323145247.GC448621@cmpxchg.org>
References: <20240307221609.7651-1-hannes@cmpxchg.org>
 <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>
 <20240314170948.GA581298@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314170948.GA581298@cmpxchg.org>

On Thu, Mar 14, 2024 at 01:09:57PM -0400, Johannes Weiner wrote:
> Hello,
> 
> On Fri, Mar 08, 2024 at 12:32:33PM +0100, Christian König wrote:
> > Am 07.03.24 um 23:07 schrieb Johannes Weiner:
> > > Lastly I went with an open loop instead of a memcpy() as I wasn't
> > > sure if that memory is safe to address a byte at at time.
> 
> Shashank pointed out to me in private that byte access would indeed be
> safe. However, after actually trying it it won't work because memcpy()
> doesn't play nice with mqd being volatile:
> 
> /home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c: In function 'amdgpu_debugfs_mqd_read':
> /home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:550:22: warning: passing argument 1 of '__builtin_dynamic_object_size' discards 'volatil' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   550 |         memcpy(kbuf, mqd, ring->mqd_size);
> 
> So I would propose leaving the patch as-is. Shashank, does that sound
> good to you?

Friendly ping :)

Shashank, is your Reviewed-by still good for this patch, given the
above?

Thanks

