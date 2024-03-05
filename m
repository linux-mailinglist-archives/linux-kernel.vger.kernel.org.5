Return-Path: <linux-kernel+bounces-91600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57F871421
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195B7B21744
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EA2942A;
	Tue,  5 Mar 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WcBBkjZU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039917C6C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608099; cv=none; b=aHLZkPNV23dpSFeHCW6FnAzY8i0sYAW4ITKKeHEcHPg5MkJP4pV9RyPhUEJxE99CSX9lmXYIIAJr+6+aLDOlXse/I2ez/3CJBqLILqO0GSxeyxV5ALnDQZ60eHHvovc0BGaAE+gMNePgVQwSI2Fdj5tjxYqkZLsqV+yAXpClw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608099; c=relaxed/simple;
	bh=rDXuHhC64rFj17+kkIdTWj5gzWxCIivw1dkwQgCPQyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rrAN5YzrXKtLhuME9mPDOlRBKDBl2Dl0t5hg/8T/5tg7Gtx1CKTv8PpH3swLS7d9A+X+rbOlMTNzpe9Fn7BtmfoapOwkpBB4PM9447RKmCBLSRyBUwbGqkMRHSG44yPjXBm/toEx9w1oUkkeUKANY/X3SCkGSfL1bcoUohYeApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WcBBkjZU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so10116647276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 19:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709608097; x=1710212897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDzznBYOi0dF52rtfqsKSRGkfPC1ojEUUGU2w0MtsAs=;
        b=WcBBkjZUpzcibecwUlZTw+nMvgIzJfEXPdqSCmK4ir/nPhNirF0TkA8SyAPdM6yWpX
         WAilKB4gSc/wcj6LrhtohTHgcIdHp/o0JE39+7tCNbQBvOhuPomp7Nd2O8dqJFAZn1Gv
         pd1C2gDIARX1RIabf5PnbyfjH7Lh69vgmZJz8Fin1SQdspSLkv6/Jxq3hn6OywKfBA4v
         LmeulnLuIV74ggtNGCQKoclZGyzj/eWim0xDXXTwFlR48ebQ0ZnIFdOU08FtrWz79674
         ML/Ote0knrWfIhjTeT/ZSuoBWXbsIQReyLJDo4DDV+QXx+AkZJ5g5EujKCrj0TdzR1rQ
         p5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709608097; x=1710212897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDzznBYOi0dF52rtfqsKSRGkfPC1ojEUUGU2w0MtsAs=;
        b=hhbhSC62CH5Z8aOlH8YK0A+sBeQSqwMzP9/VxqlkN5IgEiBZIHI7TiVzzSlYPmAAoY
         P+1fOS/sDYj/X6lnAtllHI/PfwJwvivs7sXJq/UI0vOLlOX4ZMslPbLwtT74ZwmG713y
         ChjjE48K+CQabYKcEpe1uBKKXpnORAiE62dD2pXY4V1MhQGFEAPim/7bzA2ltgeFZKa9
         kOtZY333LqPDrxVhzkmXrqlkrV3DNI0Nu6pFnUk0BYyWZ8hnafJrL9kmcwncj7iTNPqN
         ypcHUvdnU0RNhYODfYOjnCXDXqJhduKwW8gqYYbWgwp67RoG2yl3AvZnQaH3NZkxYvRk
         qhiw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHRNUgFcqajnokL1G3QIetnRxIgaFvtzvmJQSj7KrVkGZRnLM/d+GMA3Frp9iCj/3AKNctV8Ige6UQaKtBGlICjCgWLBfhzCjbUDt
X-Gm-Message-State: AOJu0Yw/EtqoY3aEcRQv4ZIk+oSbex6aXPfHGcYAsPUuf6itYV7UGjLt
	CnHS+3qwce/ueWvq+4pNSKVUhCWBDocUy0M01/pE+V4iVgRBLObkd02s7vtHxqV52jciykHIlNc
	3QQejWAhQynXZGfAYPw==
X-Google-Smtp-Source: AGHT+IHTEk4Zd44swTyP6CvApoyuoRjmegZa4AO1IVkvbSIipJki8ATrFIgu/J/HXlP8DjKh4LNIawbeTiiM6cqz
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:124a:b0:dc6:e1ed:bd1a with
 SMTP id t10-20020a056902124a00b00dc6e1edbd1amr2743294ybu.2.1709608097459;
 Mon, 04 Mar 2024 19:08:17 -0800 (PST)
Date: Tue, 5 Mar 2024 03:08:15 +0000
In-Reply-To: <26e77602326d4e169a9484314cac2465@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org> <26e77602326d4e169a9484314cac2465@AcuMS.aculab.com>
Message-ID: <ZeaMn488S_xVNtAh@google.com>
Subject: Re: [PATCH v2] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: David Laight <David.Laight@aculab.com>
Cc: "'Chris Li'" <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 01, 2024 at 09:58:43PM +0000, David Laight wrote:
> From: Chris Li
> > Sent: 29 February 2024 08:46
> > 
> > Very deep RB tree requires rebalance at times. That
> > contributes to the zswap fault latencies. Xarray does not
> > need to perform tree rebalance. Replacing RB tree to xarray
> > can have some small performance gain.
> > 
> > One small difference is that xarray insert might fail with
> > ENOMEM, while RB tree insert does not allocate additional
> > memory.
> 
> What is the difference in kernel memory use?
> IIRC someone pointed out (in the rosebush thread) that xarray
> uses a lot of kernel memory if the items are randomly distributed.

I often thought it would be useful if there is an API for the xarray to
report how much memory it's using. For zswap, we could plumb this to a
debugfs interface or so to measure the tree usage and compare to the
rbtree. The cost is fixed with the rbtree IIUC, 3 words per zswap entry.

