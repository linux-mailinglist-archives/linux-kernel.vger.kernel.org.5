Return-Path: <linux-kernel+bounces-167703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC478BADAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A801B20EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C715380B;
	Fri,  3 May 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kW3w76/r"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76114A0AB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742690; cv=none; b=bSGEONmJRKamJHor2CH0xOjMIbd6mFUcp+5wQIkLkGegaYYeB4/cLeRTU01TD87fhRrqkka/bEXuI08GSrdYkGONUeGS/nKjoYWaUUhCBMfLCpnXal9kPRPX6dcZa2bqoHxm82fx2HbhMkzgpyb9V46Xgt0v0sXg1TbX//to7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742690; c=relaxed/simple;
	bh=LnQBqRowOn/mmqH744BQ56CUkrHMmmG7pILmr2k3FwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lz/CaU2t46haTT7ywsrw8cRNkxNUslpTiDst3QYptIYa47cJN87yiYVHY7nrbZToa3JBRO6HBzrzEQcMkrLp7zCP7rNzdnqr8OGT7x1eQXvyZCvgnQK+FG3RCbhjIpXJcKqiWnZl0oL5fgU42K2tagcvClJ71QqcFKTh2amdP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kW3w76/r; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f041e39bc7so8425144b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714742688; x=1715347488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ccOeukr23e3h6a0N8DffRaB2MUtEUXB1eb2oExcKkQ=;
        b=kW3w76/rsYjB2Aw2hH5w+q98JKgzG+DyYm6qhv9gF2jS+2J8EE6ZiUxcYdjIDfKZV9
         hVeJCOICkGQGIa1vyzFmb8v3+7sNDVjcl6XPCcxof2AC2y5hWgIHADeaEuSnM5Ehbzd+
         r2X75cvehYAW/hljvHI4wCTg2bAvHOZ+Fg5eJuEIM0MdAQFtfyKnmohkcgQN8Q3wwUr3
         5ErAGQX+Eqjc++Vv4kwhqRcMIELSk4MSqQiYZxFYEx+YWR+s0gAD2xzhN0FaiQExpZUI
         arorupLC/GMjgPEjZaiOc9BQYj8vS2VWw9ZFWUMO1mAD8LHstE1ut1SO2cZxLbIORbXL
         F6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742688; x=1715347488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ccOeukr23e3h6a0N8DffRaB2MUtEUXB1eb2oExcKkQ=;
        b=E/RTym4geGe7kPiv8EyrYlpGnt4fmgZ9pv3Vn5MATV8b1Tn5nh71yPSakWOWHuKEPt
         fZW2j9S7QOp1xEHaNmv9zg4BPhjUwuCOkJvtAlg4DyMX9nSd4Pgfoyy5/NTgDrgUlr9m
         2GmJQ14yDq+lz8140zskQmQVIdYzP/V2yS9w4PuoCxTGmJhA8tlyLRJVh7TxPAnfd/A1
         0y8it/Y7qY6bYpLYHeskkDFm0x103wBj6rrIMBg3PdmkrFMWMhI5iS7z6YDpC9liwZ8P
         4K8+tihLIHE47i5P7sb4K3NcNkEd9u09vP4Eh9LD9FGvC2vPIoS3S425FdqSYn4uEVFr
         rwuA==
X-Forwarded-Encrypted: i=1; AJvYcCWTtFFMURHXD5hsYh/ZvoJd3xhO004PzV4t3XDO+zsmBBtGOxqdebtCglf2MbIvvhhE9BwBFFOI94TfNl1FHvEd6dEXyNypJzRHIrB7
X-Gm-Message-State: AOJu0YwzNgVkCz0vNIoaPhZR6iTBcZig0PB88G5pE4RE3qes3lunWPve
	T8JE33u9CLu0be6hzKyaGjsbGV54JCVC+j0IU69IwkmIKp7sbYLsG+EfZenRbJvoIDiNI427Dc1
	ztQ==
X-Google-Smtp-Source: AGHT+IFqaqDYUgUT1sFW3BILdnSLhDiEXyo5YaoA9nj8RUO7yNSem5r8cA469uOkvhX2zmIw7iPay/E5mxs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:181a:b0:6f4:42d7:fe02 with SMTP id
 y26-20020a056a00181a00b006f442d7fe02mr106073pfa.3.1714742688288; Fri, 03 May
 2024 06:24:48 -0700 (PDT)
Date: Fri, 3 May 2024 06:24:47 -0700
In-Reply-To: <DS0PR11MB6373EA67C70B8579A194089EDC1F2@DS0PR11MB6373.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425125252.48963-1-wei.w.wang@intel.com> <20240425125252.48963-4-wei.w.wang@intel.com>
 <ZjQjYiwBg1jGmdUq@google.com> <DS0PR11MB6373EA67C70B8579A194089EDC1F2@DS0PR11MB6373.namprd11.prod.outlook.com>
Message-ID: <ZjTlkSi9jYn2e9oc@google.com>
Subject: Re: [PATCH v3 3/3] KVM: x86/pmu: Add KVM_PMU_CALL() to simplify
 static calls of kvm_pmu_ops
From: Sean Christopherson <seanjc@google.com>
To: Wei W Wang <wei.w.wang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 03, 2024, Wei W Wang wrote:
> On Friday, May 3, 2024 7:36 AM, Sean Christopherson wrote:
> > On Thu, Apr 25, 2024, Wei Wang wrote:
> > >  #define KVM_X86_CALL(func) static_call(kvm_x86_##func)
> > > +#define KVM_PMU_CALL(func) static_call(kvm_x86_pmu_##func)
> > 
> > ...
> > 
> > > @@ -796,7 +796,7 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
> > >  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > >
> > >  	memset(pmu, 0, sizeof(*pmu));
> > > -	static_call(kvm_x86_pmu_init)(vcpu);
> > > +	KVM_PMU_CALL(init)(vcpu);
> > >  	kvm_pmu_refresh(vcpu);
> > 
> > I usually like macros to use CAPS so that they're clearly macros, but in this case
> > I find the code a bit jarring.  Essentially, I *want* my to be fooled into thinking
> > it's a function call, because that's really what it is.
> > 
> > So rather than all caps, what if we follow function naming style?  E.g.
> 
> Yep, it looks good to me, and the coding-style doc mentions that "CAPITALIZED
> macro names are appreciated but macros resembling functions may be named in
> lower case".
> 
> To maintain consistency, maybe apply the same lower-case style for KVM_X86_CALL()?

Yeah, for sure, I should have explicitly called that out.

