Return-Path: <linux-kernel+bounces-162626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7F8B5E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5241F21E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB4E83A0E;
	Mon, 29 Apr 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIDKepGJ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DDE82D7C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406203; cv=none; b=tg6Ofunps4uJBNKTaNUzRF+8EiyDouOcuK/GrIY5WdEUBAcAH4uoJaNQzZmo2l4me3wIl5hmNpm+mgl5ga/6imMxAjkhhWvDmvevTHYcULwfy156+HUDKMYzdUrVqXebG1EBRZqrDMQPi9ZY+hEH0xhvWKQZGrIEpGXMVY3X8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406203; c=relaxed/simple;
	bh=A07QcFP/MMmIg3bG1V9Wl7fpGXwWKW9aaf37uhkjfiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/f5vQqK4x76rgdPUSygAqwCm3bjSAqD/ZgNAZFMX4DwM6gU00tQealSDTGbMWSI2q+Waai4xNM7+/Hi5tS/oaWLNEZDDIKDYCd37m3Aev4HBc0g9peblCWxdyb//s3nrWxuqFbrh21YvoMiI8ybeV8us7lK5VRzyDdvUo8LJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIDKepGJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b265d41949so20268a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714406201; x=1715011001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEQuwU3fVtab/n23+uZu3RYhTzAI76tzPa5Uy0uousA=;
        b=HIDKepGJdWRmrET6mj1o5iCF/5Um2lprTLstyuik1GBZynCwfWE/f6hjd5915JTTTL
         xw/h/QfRA1lfvrCUC8/gpyy1Aai5J2jYKhgy/ov4PqtRPrnyIzfCSZsiJAsBJI+iMULb
         ZY3IjAxUWoDF6OY63J3fQLf953fH91C7ffaSW8qIkbZRCCjCQ7FV00zHCyokKaS+qd6E
         hYpVJoK9RwOqy/imjpOQjVLVBl1giaRKe0CYp3oi5NfLogH1V+PQ2L+3Uwahw0iQmOnJ
         DdAtL2YRM5oFiEinuFnvgQaMlD1Y+68EBq2hp/x2BXtlTiu91RCrJfCH+Gjy5zYCisU6
         lNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406201; x=1715011001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEQuwU3fVtab/n23+uZu3RYhTzAI76tzPa5Uy0uousA=;
        b=wTZZrX+xXeVuXIiaJlsHL1dySJihMTI3FocMNMRa5btTnOXeTuOI6icb5/s0A1DM0T
         rNE+eVMtlKOUkDA6oFsNH4Y/gu4jGyc3rKHY9Qa5BDCFwifKwufGh7jlVt2w26zz7c0+
         xpiM6ks+vCTN9iek5YE7eke2YKVsa+aGOYZTGPrQlxxsYI3wYhCmszi92j/We8mTxm98
         ajjhqArGWoekOXNvPxj/z/Y0PPcAiE4+Ipe0H62nyrBWjbLaZd2nMJ5IVUHZ034oCNZt
         k52lMiruhprTVlA6TkW8QVZiLSRbQQZNNScDG1DRLjN9XAiVP8iXiTXf9aMr3kSJgusp
         dPBA==
X-Forwarded-Encrypted: i=1; AJvYcCUvnN7TR1/WyZfT6nAid2W+nAy4Eh5LnDlo4Q94/OkpsgtwFd+ISj4dy3H8HlmRB/Gyr3vK/R6q8kbOhuFb1514HbO+ybFZYpTuWd4o
X-Gm-Message-State: AOJu0YyOH84NzGf4lG7Two2QvMJ8c/vDMCcC2kK+sGi6UVP5YWtiJ6l7
	BYUxZmwowoO7NKPnOhugf5G+exK90QpT7JHuSbg1b6eUSqQg9t9RMSbYMTSny/ag6hLJBQR8Obs
	Wpg==
X-Google-Smtp-Source: AGHT+IHBVUsW/5Qt9t3LLdGhu7oHg9VBlpWPRRiyLHb8hlj9J2tk0cnqrDVW3ZR4vZtNZUWF1/ZBf9pUcqI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e384:b0:2ad:7736:1a05 with SMTP id
 b4-20020a17090ae38400b002ad77361a05mr31292pjz.3.1714406199473; Mon, 29 Apr
 2024 08:56:39 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:56:37 -0700
In-Reply-To: <514f75b3-a2c5-4e8f-a98a-1ec54acb10bc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423165328.2853870-1-seanjc@google.com> <4a66f882-12bf-4a07-a80a-a1600e89a103@intel.com>
 <ZippEkpjrEsGh5mj@google.com> <7f3001de041334b5c196b5436680473786a21816.camel@intel.com>
 <ZivMkK5PJbCQXnw2@google.com> <514f75b3-a2c5-4e8f-a98a-1ec54acb10bc@intel.com>
Message-ID: <Zi_DNaC4FIIr7bRP@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fix supported VM_TYPES caps
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 29, 2024, Kai Huang wrote:
> On 27/04/2024 3:47 am, Sean Christopherson wrote:
> > On Fri, Apr 26, 2024, Kai Huang wrote:
> > > On Thu, 2024-04-25 at 07:30 -0700, Sean Christopherson wrote:
> > > > On Thu, Apr 25, 2024, Xiaoyao Li wrote:
> > > > > On 4/24/2024 12:53 AM, Sean Christopherson wrote:
> > > > > > Fix a goof where KVM fails to re-initialize the set of supported VM types,
> > > > > > resulting in KVM overreporting the set of supported types when a vendor
> > > > > > module is reloaded with incompatible settings.  E.g. unload kvm-intel.ko,
> > > > > > reload with ept=0, and KVM will incorrectly treat SW_PROTECTED_VM as
> > > > > > supported.
> > > > > 
> > > > > Hah, this reminds me of the bug of msrs_to_save[] and etc.
> > > > > 
> > > > >     7a5ee6edb42e ("KVM: X86: Fix initialization of MSR lists")
> > > > 
> > > > Yeah, and we had the same bug with allow_smaller_maxphyaddr
> > > > 
> > > >    88213da23514 ("kvm: x86: disable the narrow guest module parameter on unload")
> > > > 
> > > > If the side effects of linking kvm.ko into kvm-{amd,intel}.ko weren't so painful
> > > > for userspace,
> > > > 
> > > 
> > > Do we have any real side effects for _userspace_ here?
> > 
> > kvm.ko ceasing to exist, and "everything" being tied to the vendor module is the
> > big problem.  E.g. params from the kernel command line for kvm.??? will become
> > ineffective, etc.  Some of that can be handled in the kernel, e.g. KVM can create
> > a sysfs symlink so that the accesses through sysfs continue to work, but AFAIK
> > params don't supporting such aliasing/links.
> > 
> > I don't think there are any deal breakers, but I don't expect it to Just Work either.
> 
> Perhaps we can make the kvm.ko as a dummy module which only keeps the module
> parameters for backward compatibility?

Keeping parameters in a dummy kvm.ko would largely defeat the purpose of linking
everything into vendor modules, i.e. would make it possible for the parameters to
hold a stale value.

