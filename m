Return-Path: <linux-kernel+bounces-101337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC387A5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069F01C216AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124263B798;
	Wed, 13 Mar 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLxNW9Gx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B983A8FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325361; cv=none; b=L+2kSi23OZxlSSBi6m4SkY23OhCT5V+OllZ6u6jUT7f36zxaAExJwJ7CcTh7OC/tSnW1DGCKdv/sNql1MQUVW0Vr7z0RgOYfbW1fNSR0ZbFruzYCCsLH5vd3Q2b1cP5B/jb5E7q+Fy1rYvYArWtcyn6yhL5YC0ILG4l0vfJDJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325361; c=relaxed/simple;
	bh=CJRhvp+EStKHG6szGmLbrxToFf2hj8HXvfvOe6R31Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4L9s2Oa5wSvN8CaRiIKmSmfQAKfJx7i590v9ne72lNKiTY71KLqEU0+bh31fLoEmk+1rRBN7HekzK/PowI1J31IK0N5wK4Y9hw1AjoLQ7g8oiaxvGhs1t1fzdfd+FiryOabCMCauH/vvMRpV7lKbosbUc6c2PVdOMYXKCxSw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLxNW9Gx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso7617384a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325358; x=1710930158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plF2ZZ+jQHBrhP5TbjHA7b+fame9PVkXcotzcGjV4mg=;
        b=SLxNW9GxGpRLWiD3AYJHEtk8+2KoxbtaWgMBoizbtKZsOALr18ceDkIvwUqEwtcGNm
         WC71OO+yG856lKfPPPyrIlxJ0WS/7ub42n3p12lEvKijqWCFqVLdcuxpXUPCk8Vxmwpk
         Pz4s4laEWiqpJFsur7d2qcLrmTHO7mmKHgmW6IzKB5YLCC1RD4MZ2N3BRQOYoKy9xoeQ
         H2UaFfkmgmw2NomAmxY3/1i237Dzx2Kv7lPtLx0XllyvQjAmC0+bkdt0/Sf/vk7Q5Fil
         rlfSPTfqgGYnaJ8zK5i6mvk1K0j8Y0ZNE3cLCUzj49dP0EU4Y9ckjpgu4ypLBaDsJnf4
         nRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325358; x=1710930158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plF2ZZ+jQHBrhP5TbjHA7b+fame9PVkXcotzcGjV4mg=;
        b=Y7BQ6etBxBw6TW8g2t8j1HEO35IOMjL8489IKG7S4PCkAOuSZfTVhxREpyvVd4uJER
         ba9hNPSni7rPnaDlDMxIAODA03/r1Y8lvnBEU1HEw5HIyY9c1SjxP4u+x5iRFM65gLcW
         tJ+25mRjaGWszcqRhAUD9tBXqrAviHFiXmklER9N1mpiZCMPpWrnl1F5ves2w9BzRhOe
         rwcCd4IgKl4Otb2A0OQPu3nFu35bH7vw0BtNyaArFop9v65Q19liyukI05GpNrnChv7e
         vj/Ln2uNooVZXMpfY8olwN5g53n531Md3pUNaoyxIkWx5XOXnFsl5C05r7jMSQ2LzKRu
         RUYA==
X-Forwarded-Encrypted: i=1; AJvYcCUK0y4pWttiiKVWnflqmXcws+ZSMCespZWZPci0VlxvVliHEQYSAFRxj/Ur4Xk/PBodLZIvPBXSh8s6nOjA1yrtfB/Lel8FzS13qBTM
X-Gm-Message-State: AOJu0YwsZR++bQJR3LQcWn64duCO8+Qygl1A/N/BM4MnLZPNDamAnKKK
	6Hy5g36l+/YIEcaTDUGb5i2Tr5LLmm2+1fmq0QcQccz3zZHsGgkP
X-Google-Smtp-Source: AGHT+IFNQHi0j9U+y72oxKS4J90HI96Qs3JcTHfzP0uY17/dhMvtq5M+jznLeEhiwQL0kh+zGGv+Bw==
X-Received: by 2002:a17:906:a241:b0:a43:fd9e:2d44 with SMTP id bi1-20020a170906a24100b00a43fd9e2d44mr7156003ejb.42.1710325357568;
        Wed, 13 Mar 2024 03:22:37 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm4723379ejj.53.2024.03.13.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:22:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 13 Mar 2024 11:22:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yuu Lee <379943137@qq.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] locking/mutex: fix documentation spelling mistakes
Message-ID: <ZfF+a4ZpEBjxmXtt@gmail.com>
References: <tencent_8E6B496F6B4EC012379A594046F8880B3D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8E6B496F6B4EC012379A594046F8880B3D08@qq.com>


* Yuu Lee <379943137@qq.com> wrote:

> fix 'task_strcut' to 'task_struct'
> 
> Signed-off-by: Yuu Lee <379943137@qq.com>
> ---
>  kernel/locking/mutex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index cbae8c0b8..82d19846e 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -362,7 +362,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
>  		 * checking lock->owner still matches owner. And we already
>  		 * disabled preemption which is equal to the RCU read-side
>  		 * crital section in optimistic spinning code. Thus the
> -		 * task_strcut structure won't go away during the spinning
> +		 * task_struct structure won't go away during the spinning
>  		 * period
>  		 */
>  		barrier();
> @@ -401,7 +401,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
>  
>  	/*
>  	 * We already disabled preemption which is equal to the RCU read-side
> -	 * crital section in optimistic spinning code. Thus the task_strcut
> +	 * crital section in optimistic spinning code. Thus the task_struct
>  	 * structure won't go away during the spinning period.

There's another typo here, which you might as well fix?

Thanks,

	Ingo

