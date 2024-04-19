Return-Path: <linux-kernel+bounces-151718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A58AB2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12F4285E32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5FC130E34;
	Fri, 19 Apr 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X57mlf5j"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B4130AF9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542292; cv=none; b=DN26qk6zum6iZVn6HsEkxN1WJuUNmws6zjfCciA03aT8yIBG9Ye0Bqibxe8TjL4VNwkVef8Woyu76ilKXTe4h6qpq6OoPr51ISI4sE0fByLk3a2t92C3bUzDMVVl4DSSS8GZksfNmv546G/O8H17vf7sCrWYVD0CJ17Z/Y4xzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542292; c=relaxed/simple;
	bh=j6b6QG8HnX4Cn+WfIW+BG9Bp2mDbxqytU6EcMIEFrDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lp+b6PtCn+AHrQnq5eEyaEKHb96b7M8bYUiAMM8IQYcYkLf+ejOfAWG6+739JDx14NnzLLcJZi7PSfLhxJz46Pp+uS+HSPRpXQF+cx4uwTmh44asHd22nKqcx38XX2oaX7o9hkG0685aqgE2xEenvBp8Haej/zqXXronEOksF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X57mlf5j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso4196156276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713542289; x=1714147089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWiZrGAjVFQzRmGgPcSYpuKvkOXtBojlJhZpooqeoIg=;
        b=X57mlf5jKbfO4rwkL53FNtp242QGlLPcEc01TNqZRPM9NDlOdg0HozW/K2SZpWmMoV
         rzNE838LhZ16515r89SGRHHY4wF7jaUINpRIFg+BifN82GvDidcNu3+QvF3UoxeE6aAK
         ku8eMJqqkQ5AbZE8dYEtH26/HPB8Qs1++DfpOjs6OjJZIKyT5vMgZYR7wNvq3CM6/sZP
         7iBYX4Rbz+YriS1+7MN9Or6nuAK1H9Y0C1WrdOg6+yK8npH6I8TYCPPdH7LfpoZKS4MU
         IXMxE7Er5LWvhksWji70z6Nafnvcs+Di5UvJtDUqOIY2L/6PjQ86JiSRmjk6Ogc3g04L
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542289; x=1714147089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWiZrGAjVFQzRmGgPcSYpuKvkOXtBojlJhZpooqeoIg=;
        b=Gauqta5Ql5U7qnubzQquJS/wvQFyMxnMkvlNH6onavynnEGNJlEeorIQ2EUbqWsW6d
         18T+Eq9p+yXBJU6FUNENaw3c0iD/+DPPb9fXbHo0q8wrzMI4ZJp+E4B96Dzrm6YszQ5E
         T8XFHQcyeIxq/wgQRcgw0UwoIUxxDIXIdfC8V4S1R/P0jSunIbalYUG7jgAQtas4TRwj
         czDFfGvgCHt+7Uw0MH/XQrsind9MEkil6eOC6shH5zUbF/Fywc38GZxpUdtW65/fVsSk
         uH0RqJVdznHRhOcfuR7wG9rPGKwp3EkZnztmfNfXt9Qf9GGdtF+XrO0t3Ik2jmZdhc7v
         7mzA==
X-Forwarded-Encrypted: i=1; AJvYcCWYs5aOGwVGsuun4qMpTYQIXJ9mp6t0O1NJ3ioGpJ3IsA8fwVLkwct3MK+JPz7+pOubZ5W2UhPoqh2DgkmYchCJysjNUnaOz/xjHoaW
X-Gm-Message-State: AOJu0YzAC/wmQGhh13rulYqkdF6/esoTMNVLllltpnEsu5HOie7N6edq
	5gUgqdtWJ26LcjMFNNxPS9zm4Pj3KymfoGLYHLlv685/7f2sEsCzP/3zDh4v9U4NM1zFVEJJBYz
	5nA==
X-Google-Smtp-Source: AGHT+IFW2ky1SPK7f/pxpi+Hn0rcIyvwlKlbPLBHypeEskqOEkZ75tvGKrkE6cXBAEQEzkvOsqK8ieIXVU0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c1:b0:dd9:20fb:20a1 with SMTP id
 w1-20020a05690210c100b00dd920fb20a1mr251076ybu.10.1713542289670; Fri, 19 Apr
 2024 08:58:09 -0700 (PDT)
Date: Fri, 19 Apr 2024 08:58:08 -0700
In-Reply-To: <DS0PR11MB6373D059F2BB9F196AA9D503DC0D2@DS0PR11MB6373.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419112952.15598-1-wei.w.wang@intel.com> <20240419112952.15598-5-wei.w.wang@intel.com>
 <ZiJ0mjZxlRsLwl3E@google.com> <DS0PR11MB6373D059F2BB9F196AA9D503DC0D2@DS0PR11MB6373.namprd11.prod.outlook.com>
Message-ID: <ZiKNWM0XyMqbKrD2@google.com>
Subject: Re: [RFC PATCH v2 4/5] KVM: x86: Remove KVM_X86_OP_OPTIONAL
From: Sean Christopherson <seanjc@google.com>
To: Wei W Wang <wei.w.wang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Wei W Wang wrote:
> On Friday, April 19, 2024 9:42 PM, Sean Christopherson wrote:
> > On Fri, Apr 19, 2024, Wei Wang wrote:
> > > KVM_X86_OP and KVM_X86_OP_OPTIONAL were utilized to define and
> > execute
> > > static_call_update() calls on mandatory and optional hooks, respectively.
> > > Mandatory hooks were invoked via static_call() and necessitated
> > > definition due to the presumption that an undefined hook (i.e., NULL)
> > > would cause
> > > static_call() to fail. This assumption no longer holds true as
> > > static_call() has been updated to treat a "NULL" hook as a NOP on x86.
> > > Consequently, the so-called mandatory hooks are no longer required to
> > > be defined, rendering them non-mandatory.
> > 
> > This is wrong.  They absolutely are mandatory.  The fact that static_call()
> > doesn't blow up doesn't make them optional.  If a vendor neglects to
> > implement a mandatory hook, KVM *will* break, just not immediately on the
> > static_call().
> > 
> > The static_call() behavior is actually unfortunate, as KVM at least would prefer
> > that it does explode on a NULL point.  I.e. better to crash the kernel (hopefully
> > before getting to production) then to have a lurking bug just waiting to cause
> > problems.
> > 
> > > This eliminates the need to differentiate between mandatory and
> > > optional hooks, allowing a single KVM_X86_OP to suffice.
> > >
> > > So KVM_X86_OP_OPTIONAL and the WARN_ON() associated with
> > KVM_X86_OP
> > > are removed to simplify usage,
> > 
> > Just in case it isn't clear, I am very strongly opposed to removing
> > KVM_X86_OP_OPTIONAL() and the WARN_ON() protection to ensure
> > mandatory ops are implemented.
> 
> OK, we can drop patch 4 and 5.
> 
> Btw, may I know what is the boundary between mandatory and optional hooks?
> For example, when adding a new hook, what criteria should we use to determine
> whether it's mandatory, thereby requiring both SVM and VMX to implement it (and
> seems need to be merged them together?)
> (I searched a bit, but didn't find it)

It's a fairly simple rule: is the hook required for functional correctness, at
all times?

E.g. post_set_cr3() is unique to SEV-ES+ guests, and so it's optional for both
VMX and SVM (because SEV-ES might not be enabled).

All of the APICv related hooks are optional, because APICv support isn't guaranteed.

set_tss_addr() and set_identity_map_addr() are unique to old Intel hardware.

The mem_enc ops are unique to SEV+ (and at some point TDX), which again isn't
guaranteed to be supported and enabled.

For something like vcpu_precreate(), it's an arbitrary judgment call: is it
cleaner to make the hook optional, or to have SVM implement a nop?  Thankfully,
there are very few of these.

Heh, vm_destroy() should be non-optional, we should clean that up.

