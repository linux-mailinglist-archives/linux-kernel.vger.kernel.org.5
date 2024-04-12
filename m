Return-Path: <linux-kernel+bounces-143203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA608A35BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EB7B23F08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C4014F136;
	Fri, 12 Apr 2024 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+uydLnX"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7EF148FF8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946728; cv=none; b=m7pZ687vSR+6A+lcEbqo5SLE8q/X91FGgEL2DOfIF2Gfw87RZmA0HpT5Xpi4jOpwYXkf1C+lpK5/ugaTfH/UjHSA/UKQ2EDHB8uEqG5+Oh+qiktl6Gn/IggObohtG+sy2QnMJRFCWmAW+rJ+TuDU16jMnblUpxuRGPQug45FqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946728; c=relaxed/simple;
	bh=lmJ/NQbkLOHPPOHUsibhWTeMzkzMSGFbLN5ZZxA4uk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YjoD9e+XBpCCJk1Ee0Z0Xq0QG3D0MNyYC4T268E1tu3seVg4a0QqmKipKtTdD5bxvntIEYB9+J2EzmWIgBVwC1mU8eNQ7cCEnkCeowg3n+bSPzmaNLBTWtFIeQTUvhETZ796342IAKLt4GQpmDDXhEtH/FR7k6zkKc8WMLjH2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+uydLnX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e3c2fbc920so16650365ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712946726; x=1713551526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uzPnCt0//PLoi123hKGABpzFaziAzmX8KGlxO2h3p0=;
        b=C+uydLnX74HK8Hbf274dkmDDhSZwFcL52iIJkg8Iybr61KkOgA7Rv+1PGQvqyjedYp
         RfaoXbtMkWKMzIbwsAp5hzaY6rK2RSUaq5rWprj0og80Mc6myc9uD3xubxeJvC/tV2Xe
         cDQ3FlNnL7aUYJXZEIrJi4NiW4u0K7vudc9Xm2IUw24JocFCVgoPlgiyT3gdi6ocUY3u
         S5wOMRA6R4jIaVRijNphZoMQT9HQv3pTOYYEFz7df8O//Q+YP+91SAPBl0AtvVSxGZqQ
         8wPZ7W9QUSYtjjNbgPmTulgp7oNf7/9NRPlVIafqS562F/xNSMKCKdOyhdgbpOpX8vbt
         TMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946726; x=1713551526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uzPnCt0//PLoi123hKGABpzFaziAzmX8KGlxO2h3p0=;
        b=DZFJhJDoNwdMwg7bJ6ALE/3IMPPb8yHXyzjsfbe/cdow6HXSHxzrUNmZiqH3XeAryN
         19paGEI4w0gG/W5Nw9W6WUpCMr+L7RyDyBO4z+XhgcpyKoj7Dv32jAUqFam2LnJQ/GLb
         9TVSp8zc6nXUpoIDPS94T2YoSxzraOBmeov9rj8hiXnXXQjm8DLZ45R22T1UWYFkT81x
         z91Suic1md8qVjRyOGgJ5HQqFQU2oREzSu8kghYCO8f4YxTFwP0/XyCYXqDU/vSLsUIt
         dzFktL4D2qXMftFerEkU9hS2kfr8UNBqvX8pE1XEyqI9kgMZjdib7oKHR4WESNl7sAy6
         W5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFIDjYvmzz7MEXj8QjidjLQK5Epnpi+ea9Xzvg1YK8Ic5NlHX2eorfb6E1I/HWbUC5oOmLrNAMffjQOPufdGcuLvFRq61dx03HhU7s
X-Gm-Message-State: AOJu0Yzfe0+XF8jCjRjuijC+jchKkBEuS17klDEqy5GX1t9SGt0cHucg
	fm3fZO1yf7cOHH1Z9i3n7kz2K7bWfe/dRd1KeTknxbsD8py715XFLgRbY/MUEkA7X4f5bfzsc0O
	Qqw==
X-Google-Smtp-Source: AGHT+IHBcElUyywm0HBVejjIMdijCs8yghvj4BRW5HrKQpxbplEMdBs+GBD1v71ej+e3h3H/Ym/pp0ugjOI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2343:b0:1db:f11d:fef2 with SMTP id
 c3-20020a170903234300b001dbf11dfef2mr218753plh.0.1712946726026; Fri, 12 Apr
 2024 11:32:06 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:32:04 -0700
In-Reply-To: <f6f714ef-eb58-4aa9-9c4d-12bfe29c383b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <ZhgX6BStTh05OfEd@google.com> <f6f714ef-eb58-4aa9-9c4d-12bfe29c383b@linux.intel.com>
Message-ID: <Zhl-JFk5hw-hlyGi@google.com>
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
From: Sean Christopherson <seanjc@google.com>
To: Xiong Y Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Xiong Y Zhang wrote:
> >> 2. NMI watchdog
> >>    the perf event for NMI watchdog is a system wide cpu pinned event, it
> >>    will be stopped also during vm running, but it doesn't have
> >>    attr.exclude_guest=1, we add it in this RFC. But this still means NMI
> >>    watchdog loses function during VM running.
> >>
> >>    Two candidates exist for replacing perf event of NMI watchdog:
> >>    a. Buddy hardlock detector[3] may be not reliable to replace perf event.
> >>    b. HPET-based hardlock detector [4] isn't in the upstream kernel.
> > 
> > I think the simplest solution is to allow mediated PMU usage if and only if
> > the NMI watchdog is disabled.  Then whether or not the host replaces the NMI
> > watchdog with something else becomes an orthogonal discussion, i.e. not KVM's
> > problem to solve.
> Make sense. KVM should not affect host high priority work.
> NMI watchdog is a client of perf and is a system wide perf event, perf can't
> distinguish a system wide perf event is NMI watchdog or others, so how about
> we extend this suggestion to all the system wide perf events ?  mediated PMU
> is only allowed when all system wide perf events are disabled or non-exist at
> vm creation.

What other kernel-driven system wide perf events are there?

> but NMI watchdog is usually enabled, this will limit mediated PMU usage.

I don't think it is at all unreasonable to require users that want optimal PMU
virtualization to adjust their environment.  And we can and should document the
tradeoffs and alternatives, e.g. so that users that want better PMU results don't
need to re-discover all the "gotchas" on their own.

This would even be one of the rare times where I would be ok with a dmesg log.
E.g. if KVM is loaded with enable_mediated_pmu=true, but there are system wide
perf events, pr_warn() to explain the conflict and direct the user at documentation
explaining how to make their system compatible with mediate PMU usage.

> >> 3. Dedicated kvm_pmi_vector
> >>    In emulated vPMU, host PMI handler notify KVM to inject a virtual
> >>    PMI into guest when physical PMI belongs to guest counter. If the
> >>    same mechanism is used in passthrough vPMU and PMI skid exists
> >>    which cause physical PMI belonging to guest happens after VM-exit,
> >>    then the host PMI handler couldn't identify this PMI belongs to
> >>    host or guest.
> >>    So this RFC uses a dedicated kvm_pmi_vector, PMI belonging to guest
> >>    has this vector only. The PMI belonging to host still has an NMI
> >>    vector.
> >>
> >>    Without considering PMI skid especially for AMD, the host NMI vector
> >>    could be used for guest PMI also, this method is simpler and doesn't
> > 
> > I don't see how multiplexing NMIs between guest and host is simpler.  At best,
> > the complexity is a wash, just in different locations, and I highly doubt it's
> > a wash.  AFAIK, there is no way to precisely know that an NMI came in via the
> > LVTPC.
> when kvm_intel.pt_mode=PT_MODE_HOST_GUEST, guest PT's PMI is a multiplexing
> NMI between guest and host, we could extend guest PT's PMI framework to
> mediated PMU. so I think this is simpler.

Heh, what do you mean by "this"?  Using a dedicated IRQ vector, or extending the
PT framework of multiplexing NMI?

