Return-Path: <linux-kernel+bounces-78938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B174861B05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C781C25874
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C2B142649;
	Fri, 23 Feb 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbBu/fE9"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7013EFF3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711205; cv=none; b=d0LE3+XBXC2WndPPG6d2d8E4aFBCmjiA58mhwH4Bw3eGGBT4DA12Gzm9l1XM1zE5IAesBhzcQD5RZsP+Cd9dtu44tD+XEUevrfuEKru6KCbUBA3sBJ/g6eOBYXXI1BTNpcTXgjKDaUkanKDPcfoilfdvua0ArixEJPr3HPa5h5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711205; c=relaxed/simple;
	bh=JTIBShtgIr5g6rY0xtefZuQDFwfDgZS/8epM2acW8kM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9vu6UipD9sasHWzd34yoERsy+NFk3drA0Rz4Pala34wbY9gRbJjaTr/jn9CCtOQqsTVLNqj1iJ0tYp92ibjrq+BzztIyAUjcFKmhP2yUlLq1mZZiOD6V61KnBJpt3ZpX75LSldUzyIEDqU89njBh7Rb+96TyXc+ehtnMcmj/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbBu/fE9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608a8fd6800so20739517b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708711203; x=1709316003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZlW1EJxs94ddQvEpIRIB6nMElLk51bT9baoyhTLzcw=;
        b=NbBu/fE93yYh+mw+PMuD6GgYGcQwX7O2eUKwIZk/z1BLcmq0Ugaf/Nx0Aubhw6YDex
         Us/lKerEpmIiFERqAqJ6tSlwuSD8Ct+Ohanp8mUvwPQnW25qR5pkC9heOnnvozhz4T1d
         KMQmKDQeWG+Sd+c+KPI0Mal8IHOuO29dPOdW+3jUXRLAr3vfn0s3FpJAAXy0qSGkFCC6
         1yu7s9oNWGA3YVPKOnAepQQtkmmd/CijtSZ3MZfsGw5kiSMrqB55Y3v07Tgr/QlYXgKn
         bDl4Ng7IihZQWVdJbCzw9T5x1Ir5vcnCXhAnsJIWgi/nyVYG6kX4OXz7nbRoUb4Zu7np
         Zfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711203; x=1709316003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZlW1EJxs94ddQvEpIRIB6nMElLk51bT9baoyhTLzcw=;
        b=PjH8Kc1F+BeopOfeuhn11tTQN4k2+AUURtxGtJVv8TJRNsMiXqPHWmlOQXWEjTcnkD
         21wcpq63nct7mD4L7E2PlC2pgB4H4k0B4wm+73yjLF3jHcn+3vo7N+Yu9pYqI7zYQqHK
         cBkWWsA89BvvfQMpgyWlQft/6Wjh3h4tWnV/tAvrsTuDpL0CiZR+s1pcQQcclRwFoLH8
         0G8npBkmNzp7Aas759JuGd5BIqSXawNTNgmjgmfOrZEw1ajOzC6MDj6CjTG0/xVxRDy6
         bJ+GnOx7Sda9Pgh8XXA3nqZb/U8qDld6jF9aQ2EjKNdEsTzrAYCyurgE81s6ZB84BW+v
         ysQA==
X-Forwarded-Encrypted: i=1; AJvYcCWEaX5oA4o2XQGnJBrbdKyzzO6vsKOJSohkDCOhYLA2dwrjKvKA1dqsbVihDxdxdvcuH6TMw5ic/OajRxMeHktUis3/9mfLrE2dFHsI
X-Gm-Message-State: AOJu0YxhYn9tOeyblOyfzdki/CQr9LKniZ+GYf/XzTwuo4PBgpC+FJOg
	VTqucDt+OIB9G+xcQQvcqTxTw/24Dqiwq1pFqx8x1srri3knXOFLfXtw2kzn9NygANMreEi4lvo
	VNg==
X-Google-Smtp-Source: AGHT+IFddBZPJ0oMQJFmcgncflFQLIynO52TmQ0RXS5kF1rPgpXbVxpnqSicc8D4/kWxpa1H1Uj3I4Yk7aw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c2:b0:dcc:9f24:692b with SMTP id
 w2-20020a05690210c200b00dcc9f24692bmr24709ybu.13.1708711203125; Fri, 23 Feb
 2024 10:00:03 -0800 (PST)
Date: Fri, 23 Feb 2024 10:00:01 -0800
In-Reply-To: <5580a562-b6ac-448d-a8fe-cedc32d33bab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221072528.2702048-1-stevensd@google.com> <20240221072528.2702048-5-stevensd@google.com>
 <5580a562-b6ac-448d-a8fe-cedc32d33bab@redhat.com>
Message-ID: <ZdjdIYNEA7k2Fmnu@google.com>
Subject: Re: [PATCH v10 4/8] KVM: mmu: Improve handling of non-refcounted pfns
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> On 2/21/24 08:25, David Stevens wrote:
> > +	} else if (!kfp->refcounted_page &&
> > +		   !kfp->guarded_by_mmu_notifier &&
> > +		   !allow_unsafe_mappings) {
> > +		r = -EFAULT;
> 
> Why is allow_unsafe_mappings desirable at all?

It's for use cases where memory is hidden from the kernel and managed by userspace,
e.g. where AWS uses /dev/mem (I think) to map guest memory.  From a kernel
perspective, that is unsafe because KVM won't do the right thing if userspace
unmaps memory while it is exposed to L2 via a pfn in vmcs02.

I suggested allow_unsafe_mappings as a way to make upstream KVM safe by default,
without completely breaking support for AWS and friends.

