Return-Path: <linux-kernel+bounces-48538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED9845D61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52E01F2B4C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69454C67;
	Thu,  1 Feb 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXUxypiu"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DF7E0EA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805324; cv=none; b=jh/FnTfI2FLa0cZu+Gsk3ZDcx/TDDGRG9gJ4waKoXI8kUpdxl+Ydvw07mp4AgxghNGrcsPkBCcjwOmQxslvuquSsIXz/BPFoFRT09KRGIg59GJVuN6CeKXJukUHHBr0Q56CgEObcD4wNwlXN/932uBdqm8t+OWyVxDaS/5rQs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805324; c=relaxed/simple;
	bh=xNU2G1wWCYAXemLHQIapTJ+woUfaGlzNvEQHLSN2LlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG9sJuzDC676CV9WGPt8EgEOTwjt/z4ocedkFYS0CEIz2aJOOMLPej9Xvs8OHArxLr/lUS3EV/kDQbRPWQHJOE1zY9IsoWLek4FQZ88nxcMvXafaIULHo7KGUFb85Li0QlbZ0qBzqoFapk2qYw1JlXdYZXrNI+ajcNEu0jxCJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXUxypiu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29080973530so849128a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706805322; x=1707410122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEnWz5ZST/dH/UlGa6pT/UbRvB/1V8kTgwNMqCtd58o=;
        b=CXUxypiuVGjC9/CYeZ/vWVC3OO8m8ap5epfdMpBtpsQPeBlhaQJJrxahb51dD5ipUI
         49pfIoBhz0cWMkvfmESsD00VHAu7xvi5rFyZlRJ7r8xoIlbbcOnhkfbx9Xbkgsuj/Ai+
         R4NJKIRta6o/7FMZ3zzHDxmoO1i8cJzsJtbq17lo3albDWkfXlqHFia3eexATkuFWxEP
         fOB6EA7ZVOtrFNS66CXmQoNtfSa8oSmZ7kF+jiknvidXktTIK+daUcbfr8fGW2e7Vacd
         MGsf/KRhK+39ZfvtLWj9bkrUjnVm198IRbmQTuZPN4pCHvo1f7EcDkUhVFvTzaTm/ZyB
         siSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706805322; x=1707410122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEnWz5ZST/dH/UlGa6pT/UbRvB/1V8kTgwNMqCtd58o=;
        b=WAM6jKSWoMII1qm/Uwbd5perHH4T9J5gEp77ddzu+7nJnWjvYsfL7ZNbKdUQingkll
         mZfQ7xiuqfBmg64t+wzqJWIfrKCZSLb00LM77eArYm7T0q6XazR364WJ3LRvrjCTSsfW
         SXs3sZvVAqVhgIVu1UHNodfUXIdNuhNRDLA71neoZh9BnY80dln314ipnnx6AQ/Zuv0L
         5QKmEb14A49kkT36fRr01vuqyZHvZUdhM3B2Zfo5i7hKrPoBx2n6qt1zkc+HpFnxv00E
         q2LLu6Fy2MbDhT0D7LAeZUUC9XPC9Hkzhjvstpj4HpEcdQdtRgw0pxv5jajz7PdmaCa1
         5ECw==
X-Gm-Message-State: AOJu0YyXdcE2/Syjd+HJDtKz58U8IzOUe7b5z6QhXd4u7eBQaCkzmVrM
	RxhT/FmhhSYiTZr9CLykFCPLrYLx93tYxEHn/xd62flFDe9bOKdcovrr5vRCjQ==
X-Google-Smtp-Source: AGHT+IFuEuJM0fB+6LKcH/h6Kz9oMWgeazwllVl+2+39fGDBVo4YBYxQBVl080VfgQPHjK/lXRUsGQ==
X-Received: by 2002:a17:90a:d78f:b0:296:1d9f:93d5 with SMTP id z15-20020a17090ad78f00b002961d9f93d5mr1574261pju.18.1706805321860;
        Thu, 01 Feb 2024 08:35:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHs+lSFlCnoIia2qkGpKQwtoJDxQdOarxtWJPx423pvrYhY0lfFSMH2RETUWglEI1BA/xHOwFm1FNehrXvkWVpd4KsDkSmWiKXz+0vDkfFq84MWO8t22pNcbjtg52+eF+ypbh2flU+5RM/Jd9M4PljlhBBK6c3lAY0mp9nsNp2Q0gjBhvNLBxCDf1wArLW8tlAhWy9RyJT2Ye3b6KPgotrtYmswItdZh/oDaQCbc6JSTT34fp5zQRjRY/eHPidhN/YMwZHn8lnBWuCfgyuQj99Z6iefMT1vWwQ+fTpD9XBX8h1F6mk0mwkIkURn0RIOQ==
Received: from google.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id sg15-20020a17090b520f00b00293851b198csm12770pjb.56.2024.02.01.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:35:21 -0800 (PST)
Date: Thu, 1 Feb 2024 16:35:17 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, xuewen.yan@unisoc.com,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <ZbvIRZLyx7C8EzvW@google.com>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>

On Wed, Jan 17, 2024 at 03:48:34PM +0800, Zhiguo Niu wrote:
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:
> 
>      rcuop/x
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> -002|__raw_spin_lock_irqsave(inline)
> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> -003|wake_nocb_gp_defer(inline)
> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> -004|__call_rcu_common(inline)
> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> -005|call_rcu_zapped(inline)
> -005|free_zapped_rcu(ch = ?)// hold graph lock
> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> -007|nocb_cb_wait(inline)
> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> -008|kthread(_create = 0xFFFFFF80803122C0)
> -009|ret_from_fork(asm)
> 
>      rcuop/y
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock() // try to hold graph lock
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)
> 
> rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> This patch release the graph lock before lockdep call_rcu.
> 
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")

This has a "Fixes" tag but I don't see Cc: stable. Does this need to be
picked for stable branches? Or does tip branch does something special?

Also, Cc: Bart Van Assche <bvanassche@acm.org> (blamed_fixes) just FYI.

--
Carlos Llamas

