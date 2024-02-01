Return-Path: <linux-kernel+bounces-48652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700E845F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77821F24075
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E612FB3A;
	Thu,  1 Feb 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBeRCQHw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5E74281
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810571; cv=none; b=a5KjEH2/snJgy9IdehMN2Z8JnFWtG8VLEhFqFGI2bi5rhuseEYcwvvey9cE+0Fbt19PVm2o08AyRcsqnTGwzzFs+4aNU6YFn7anJC9vKCTdisBJfItKvGjGb4knuVE1uyWsYf5aHoZOL9x+gJw70Ijx4ivqfFAhr5YCT9jt1PL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810571; c=relaxed/simple;
	bh=ColfYwGzOWxKPXerfApdGAeGET6bCQa3gNPmYycvkQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Urt229891h4krMDSNhiH+5THN/NRg/m6B6KHSCbilsZAdv138IfwBbJ+e85k369lkfn1VZDfqObltgekQBTI1d5J6p2JrESICd5MyLgzj6TUM0umMjSu204fdRr8qQ4zgqgUsoZWByNIDWkbN5tz7fp1cGMBOKoNwNdJ7v7Y14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBeRCQHw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so2048114276.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706810569; x=1707415369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vt7MU0bmv3DhhiQJ3wtJw9K+Dqd9x1ouKjCbyi3XDIo=;
        b=iBeRCQHwnhng3F7xF2wvH9rngX7LXNNuPb4fIrcvbWP0PKEchzldpXqbtvENO0q2af
         8ufDzTTB14ip4V47s2EbwMRCybDCocdBE8iYQwwmKv4HwL5EcHUqc89OZCg/CvwfD8eh
         kdV+WzDrl41kQ++QUXTNQoGBaouklYy83LvdvLajTYBun6f5/VUhO0yF8VpX4BfyiZv/
         gQ9Ueb8gYuFztOFz+6nmkX0sZfej2ov2Eb1vnoNKys5esCjsXIhUNR/fQAc8KxPlsnSs
         aAbM2TNGdJ0OC8Oxjit+M7Yk0zABfE0dW5AoFvWQ+NH1td3UVxOA/kmUS7Mw529NX7tN
         B08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810569; x=1707415369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vt7MU0bmv3DhhiQJ3wtJw9K+Dqd9x1ouKjCbyi3XDIo=;
        b=VQlnSYv5YguY33/LyRi6pOcaMh7jAlb+UyoKcr2EsAYF4BupnR0tY6A0XX2oU2ke4N
         dWSUJMwtNSab568Li8FLQ4jRSqP7iNX6TeIsxNBLF2lVD/iQZzp/oh+Fb7Idh3k8ukMj
         Phi0l2xa7yjjF89zB4jPZQlC8ivsteCgjYgFctTdJumKFDmJD5Rz8LA2riQTkD/ms2PJ
         djM9AodsIBGacXseBLcHx2FxCqk0WCexRHvBtW0oL44Mx9At7I9SbyYu6lpcWu/vMiGQ
         rQxQKFT0iIHr+TA+cW9G/KLgVFe5cjcq6q4zvit8DSRrugTMSxlABx07tCj3uQo0o6ak
         jGTA==
X-Gm-Message-State: AOJu0YwdrFUIWpXX3WDMzDoxZiV76mjVIHopxciluIhrG1o91Gsa3cGy
	gBI6ghzc/X21eSSsX4uvLHrpUuA2by0JwBXzbSSr3udULIvqysBLaPtnZ/5FF+OfGG1ErE9hXyR
	zog==
X-Google-Smtp-Source: AGHT+IGoUgKcoa4GAi8Lw+GdpN5bAXMcZfSWEQrKdT61wiJMGMnkzYXnrDgYCKzRULVUjofcJPOdgJcRbDc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:13ce:b0:dc2:1bde:b7ed with SMTP id
 y14-20020a05690213ce00b00dc21bdeb7edmr1349889ybu.8.1706810569436; Thu, 01 Feb
 2024 10:02:49 -0800 (PST)
Date: Thu, 1 Feb 2024 10:02:47 -0800
In-Reply-To: <20240201061505.2027804-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201061505.2027804-1-dapeng1.mi@linux.intel.com>
Message-ID: <Zbvcx0A-Ln2sP6XA@google.com>
Subject: Re: [PATCH] KVM: selftests: Test top-down slots event
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Jinrong Liang <cloudliang@tencent.com>, Aaron Lewis <aaronlewis@google.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024, Dapeng Mi wrote:
> Although the fixed counter 3 and the exclusive pseudo slots events is
> not supported by KVM yet, the architectural slots event is supported by
> KVM and can be programed on any GP counter. Thus add validation for this
> architectural slots event.
> 
> Top-down slots event "counts the total number of available slots for an
> unhalted logical processor, and increments by machine-width of the
> narrowest pipeline as employed by the Top-down Microarchitecture
> Analysis method." So suppose the measured count of slots event would be
> always larger than 0.

Please translate that into something non-perf folks can understand.  I know what
a pipeline slot is, and I know a dictionary's definition of "available" is, but I
still have no idea what this event actually counts.  In other words, I want a
precise definition of exactly what constitutes an "available slot", in verbiage
that anyone with basic understanding of x86 architectures can follow after reading
the whitepaper[*], which is helpful for understanding the concepts, but doesn't
crisply explain what this event counts.

Examples of when a slot is available vs. unavailable would be extremely helpful.

[*] https://www.intel.com/content/www/us/en/docs/vtune-profiler/cookbook/2023-0/top-down-microarchitecture-analysis-method.html

