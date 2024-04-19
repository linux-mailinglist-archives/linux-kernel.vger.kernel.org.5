Return-Path: <linux-kernel+bounces-151551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633758AB066
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AF31F24BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C912EBD9;
	Fri, 19 Apr 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qwXxU69"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347FF8562A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535736; cv=none; b=VEnBP/cFbi62VriOsV+FSf21XZPXm7M1dTlwufPKTeznHE5V03el6bXHAMXXyElaSGIwIvNmJMf12jvYkObTZZ2qBoeif+uKvuzDLIQZhynMhvKM6AK/BaYvlEmfIpxOzL7rrTIu2tNJWiEY4HtVe8bBwGH50MIlwrjn1oAx2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535736; c=relaxed/simple;
	bh=AfSvAfZ+PLfkq85Cm4kW2djWmgUs/Kj0iJYGdgszdE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLoUsy3vhgylQri4PIoRxF9rme0hK4uL99atG7Slm/j2hXgKRayCyqCCp09SGW4PwJ8vC/F+bAJ7xXTWSM8NDvsxMIAQg7F3LqhuENWiZTNcdd4HgldMTCykdRgdD52ORUNXGa1Sqb7XMUrFqS3k6imgvUrtoe6wLHDnBhs9urQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qwXxU69; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2abd30f9so28392077b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713535734; x=1714140534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33sdiDZDWg4/FZTAXVC794hL3/UVeYFyR3Xkr0YWvZ0=;
        b=2qwXxU69LJ2MMB4MZ/FDduh1HeesVYk5kwOP+71/R3KCITSog5zlUoYUZEi4Cl0JUn
         BHTXi8vtGEFhYXjKyk4ZdWqP8Zz7gCTf7XEm8ldqtzXt/AxKBwJgN4eztzyiKaEtGpwN
         Qg9hK+x43Wh5PLoklfMKqu+t1JajkYOwTzR940y27zEeckICZ5uLiR9MU2VLyne4Yicw
         SOkhFp/xYNZA/2e+hSatotfByCS4Hmk5SxMnxuGnKbXwTHsD42JZ67+rydNosqyEhJ5G
         GMQYmsyLyJDYZgD+fM0QRlg/7RBBnZRUkz1WJ9KwRMYwxJVqcvxcufjaROYD3UfaTC3v
         zJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535734; x=1714140534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33sdiDZDWg4/FZTAXVC794hL3/UVeYFyR3Xkr0YWvZ0=;
        b=lFL9TlH0q+yRRukOWZBN0nS7W7UobazMCvlRMYJNUozWvwea94kSjFMjknjrcpzIBP
         mvxJYUcPCgi9SOt6XsHxhzFQz6xynlRH3uPFWufFDxj4ThNbIQLlRExwIPytgb+BVagi
         pw86/NboyfOyDJz4DtCMJV8g2D3x6tRE72g3LO2HSsfYL98ex6AjOjzP6Y/Hztm8JXs9
         TFrhU72t2FoWKBS73ioZBuLp3rVymjoFgapa72OGAAp4goVbCP4ypyJejz6eLgN01mHW
         pwH2enRITprnGqDB7nDNMYPKGmoadXXtzUq/CuLe5TOFHjomjAQHuzmEF/w9+82bjXHA
         73cw==
X-Forwarded-Encrypted: i=1; AJvYcCVKmTSEMThEqu/F5svkatDPrbGQAzQFswQBIilUoGCEoIqys+Rq8QhVfR56D+XOuNbzSNOn4TAhpeq7YRcwuZ5y66BHbFjO3NZiISBD
X-Gm-Message-State: AOJu0Yzd07D3cTq0f67V0c8NDvlSuX3lGFvsEVIOz5dpjmvH83vPNVhI
	DrsnwKALIvhAsq9ZRdBnKBr5AWgVIAtTP+kfmRdL6BIIPqBqrkR329SAubfimcNiS0ZjnUY46vj
	n8w==
X-Google-Smtp-Source: AGHT+IFGxzB5q+UmtaeYs4fr1YvtZlgI+JgTd7YHhZpapr5Z1gcjIWkYcZeYP2XQFLsBW8qY+ksucflV/rA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6b01:0:b0:ddd:7581:1234 with SMTP id
 g1-20020a256b01000000b00ddd75811234mr148387ybc.11.1713535734251; Fri, 19 Apr
 2024 07:08:54 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:08:52 -0700
In-Reply-To: <ZiJ4r70tsphVk45Q@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-3-pbonzini@redhat.com>
 <20240417193625.GJ3039520@ls.amr.corp.intel.com> <ZiJ4r70tsphVk45Q@yilunxu-OptiPlex-7050>
Message-ID: <ZiJ69KnDcYabiUwi@google.com>
Subject: Re: [PATCH 2/7] KVM: Add KVM_MAP_MEMORY vcpu ioctl to pre-populate
 guest memory
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, xiaoyao.li@intel.com, 
	binbin.wu@linux.intel.com, rick.p.edgecombe@intel.com, 
	isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Xu Yilun wrote:
> > > +#ifdef CONFIG_KVM_GENERIC_MAP_MEMORY
> > > +	case KVM_CAP_MAP_MEMORY:
> > > +		if (!kvm)
> > > +			return 1;
> > > +		/* Leave per-VM implementation to kvm_vm_ioctl_check_extension().  */
> > 
> > nitpick:
> >                 fallthough;
> 
> A little tricky. 'break;' should be more straightforward.  

+1, though it's a moot point as Paolo dropped this code in v4.

