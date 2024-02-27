Return-Path: <linux-kernel+bounces-82830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F77868A37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3DFB22F84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D756444;
	Tue, 27 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEnNtpe2"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA555E5A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020336; cv=none; b=gyGgDliQSkTbq3sHYwS5Jb53cc/YKyPEKwE79z9RdGF3rJfaMvJCiH+F+TILH/Rm/txXaPKNKuxMkr0M5p0mrV/hv1DNlZcLTNFm6A+QCONorNq5B16SqZDAlWzceLPRRprgwrkS+ZK7A0dJ96QUynONsnm3BSWUiAomx4HKAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020336; c=relaxed/simple;
	bh=9i5bdvauffTPJLJAtxK7D8dzjqmk1o8q6vh9OmqQgHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd9GVaGh7TLj6rwYK1uQnNlTstCWkfC7pKjc3Q+iyY2+RZkolaIPU0rjmNMqurlQSToJxaj69srzw96VEzMaOEO6EunZ/wy/Kl77yeDxpzDGY0wW+nBZP0t8z/fJVecdNdRJHmL9diIcdlODaTSvXj/cvg26zhYXFnLapCPV9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AEnNtpe2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e54ffdd0b5so25800b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709020334; x=1709625134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENJj/6O9DH4cxRE/TQEbtaKBpIfwOdtzioRhc7Nl6I8=;
        b=AEnNtpe2p9wUfimLtrhNE0O5NILodGNRrUixx63KP9vqnPgmGOjZQ+GXBqpk9W9Y+X
         BB9K83vxGgmnh3tQACS4Z6PR98BFUYGe4XpG/xp1UG3RV8ULxl0eFdMq24Cr2uNw+O+n
         b8KGPO7R2a/XPS7zVfmjn3peJ/CdePSpVcIp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020334; x=1709625134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENJj/6O9DH4cxRE/TQEbtaKBpIfwOdtzioRhc7Nl6I8=;
        b=L1My/Q6oeRh+VPctjM2MEZxhZjA/GxMHY9Cm8t1gOmbL+VIIpxNaITui9U9x5VxHiD
         w9xGtwF80bHsE2XOXLClz/7MzRt/0CcBB1iSlxP/XL3BcxbHvFsaWvGccmwx6EHKDpsD
         Ho5r59RD8YLN9Ey5nz2WusZnURAvdlNrrgd6YTLzuJpkVL4lrbjJWtK0Awg46/jtzG2L
         nz8ljGTUqnz5nwUb6MJ9Xu5ZB24eBVDRfvIhxb29T6YaE7xIllLk1NrexiPMZHbAWd3S
         dAhKIjq393S1HnqQo40WmBGQn45cqgYktiLJjbB4SI65kf6Rkx4PaDuknzEfg8hpLomE
         HUdA==
X-Forwarded-Encrypted: i=1; AJvYcCXmRsRgtIXdw7113PVeyQ84KKwUt0VZTs7YrHafr5LNqARQDXCqVW2VwF3JrWXV0zf9yql4ENei1Zd23bNVS9vdJA7COqUsayDYuOGy
X-Gm-Message-State: AOJu0YzUv1TsNDTeiIgxUArYc7ahmPvbj6D1PMuJsu5azl4EKyeZgmHv
	eiDar1vnjKIryQ+EmyJIwMm13x7EDDog8VKxGmjDK1YFly47TKgDbRPaPZwfyg==
X-Google-Smtp-Source: AGHT+IHoSiz3A+hlmxfNO+hdIrVvlJj1VC+1EonpCetHm1MwdjZTWc/oUEw7NbQj6yQqC4qDRXxp0A==
X-Received: by 2002:a17:902:d4c3:b0:1dc:b6ef:e233 with SMTP id o3-20020a170902d4c300b001dcb6efe233mr1675638plg.50.1709020334115;
        Mon, 26 Feb 2024 23:52:14 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f4f0:fb4d:aa01:9068])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090332c800b001da2f9d04b0sm901544plr.15.2024.02.26.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:13 -0800 (PST)
Date: Tue, 27 Feb 2024 16:52:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: chengming.zhou@linux.dev
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	hannes@cmpxchg.org, nphamcs@gmail.com, yosryahmed@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] mm/zsmalloc: don't need to save tag bit in handle
Message-ID: <20240227075209.GA11972@google.com>
References: <20240227030045.3443702-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227030045.3443702-1-chengming.zhou@linux.dev>

On (24/02/27 03:00), chengming.zhou@linux.dev wrote:
> 
> We only need to save the position (pfn + obj_idx) in the handle, don't
> need to save tag bit in handle. So one more bit can be used as obj_idx.

[..]

> mm/zsmalloc: don't need to save tag bit in handle

Does this mean "don't need to reserve LSB for tag"?
We still save allocated tag in the handle, that's what

	handle |= OBJ_ALLOCATED_TAG;

does.

> Actually, the tag bit is only useful in zspage's memory space, to tell
> if an object is allocated or not.

I'm not completely sure if I follow this sentence.

