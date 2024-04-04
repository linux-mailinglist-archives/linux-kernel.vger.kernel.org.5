Return-Path: <linux-kernel+bounces-131844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77887898C74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B1A2873B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D71F945;
	Thu,  4 Apr 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSjTgkQI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21B1C6A4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249131; cv=none; b=EPOLjYywQPxbNWZvy49j8jX1Qo9jmhk6uILq4llrxHQpjJX8BbOi45vGs45/QWSCqS7r51QIDxC+tB29kbsMAg956ZdG3A0aeDimbb8eW7ZzZABtmuFK4ts1vcjH25gEWDO4KC4flPEkaj3QprfOD/pJKg4MNz7kaOzvi+eK/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249131; c=relaxed/simple;
	bh=R2Q0YhYDoAdmS1G1vial4m1sbS4rAYQTKRYgPCb4YzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aOpjQ/X0BYHy4VB+lmGjKzbjZlEwIchkJsbyDYOcyh4gvyPNqRVXp9GFW7t6NXd6qMtGQjS6WRGRqYdqDP81m8LNTwk1AJrjG1ygxtJcFOvJBRDBigH/bGl6MgeuTFkfmBtFw/dBF4d30RH7Zq5UTlAbQWWEV0M1R6gasBoVJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSjTgkQI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a25c69cdb1so908105a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712249129; x=1712853929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVoi6NefjZ/c/oxqYd/vI1BhozsfpX8kO//U2Kh2pO0=;
        b=TSjTgkQI51TkaI/SeGvoWSBGvafrylrOaJY8zS6sHaF53ZtPaTQmD51uOac+G32whU
         1lDLz/AJBk2ybIB4Yn5nFLeMrmyVjLKuYuZLBHm+ws0790L16UVmduZ/ZQAiK60zNJDA
         sPlNmuSK+LAVkYz84IUwhbVCc4EKWkvTYTf1H5tSzDS3VHXtelFB0JGSNOMUGfCIhPza
         qwvVoFsso3EuqIBzXQmb1QQ97G5e+1zbqhNmw5PTMNTAQ0whOYqvs5O4bHv8VXhE6mbU
         v250K/jbovQobadfq28oFQPCP7kNfgZFWD3L6pf8JvSVcBv/ehZsOcPBQIPcr+4d5nEh
         XevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249129; x=1712853929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVoi6NefjZ/c/oxqYd/vI1BhozsfpX8kO//U2Kh2pO0=;
        b=G4PzR2KphJl7Ots+52hFBc0TPDtwdg5ZWWjtSqLSFBGirwkh8H/L9pa8sDydZdGETJ
         ImFhTVvv+nh3B/Qhz46Hq4Cnz/viZFDtvMyVk32Qm7YNQEEGGU0azQ0EcHsEEiUL4dDt
         FxG4MkdBXmc+EOXfklJwQ+NmniNvJxXNL2OlW1HqT4TmX+/s2kk8piV/o3VAG22pzoDH
         sINpMWBRFBYf/ZIQVYFUQlHbDHUsb+9cHfxxbJ8fr6gb2iyu0Kh0keBhkZGQrSBUrbLX
         V1We250XxgaNQxDvL7OeCLMG+A1I4weAVPQXU2vI0GzoK9O9EZ4930klj7rOEAFcXgXb
         QmWA==
X-Forwarded-Encrypted: i=1; AJvYcCWrLoSasWjikk/+ZiRnvD95/wR3+lR2+TLZNkaJYZ0SxDlmMuq6HwoC2xuDb/uqS91foBudfQIerhTjzRGQR2JI7PO5WmmkhCec8n9r
X-Gm-Message-State: AOJu0YzExN6XrWo5ZzjnsGkxLiDaSU/Mbncv5Owlm+g2eSpKpziZ0sXp
	l53V7oyfchSzSBSwagRqZJ0gcaIYUMdAYw1w8BdCkbMgOMrCrdI9AIV/QmYjhwFIWkzpddpB3e8
	Egw==
X-Google-Smtp-Source: AGHT+IHzgawHVh4ywKIvALLI1VYQ7Le+Uz6/53yKKCXMjdCI0rpXbu/V2XBId+DkTFab0AyEbOGamH6MDhQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e60e:b0:2a2:8b25:745e with SMTP id
 j14-20020a17090ae60e00b002a28b25745emr3364pjy.0.1712249129364; Thu, 04 Apr
 2024 09:45:29 -0700 (PDT)
Date: Thu, 4 Apr 2024 09:45:27 -0700
In-Reply-To: <ZeqSncClqOQqCO41@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-2-seanjc@google.com>
 <ZeqSncClqOQqCO41@yzhao56-desk.sh.intel.com>
Message-ID: <Zg7ZJwQ0nOqwwmQI@google.com>
Subject: Re: [PATCH 01/16] KVM: x86/mmu: Exit to userspace with -EFAULT if
 private fault hits emulation
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 08, 2024, Yan Zhao wrote:
> On Tue, Feb 27, 2024 at 06:41:32PM -0800, Sean Christopherson wrote:
> > @@ -320,6 +328,11 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  	else
> >  		r = vcpu->arch.mmu->page_fault(vcpu, &fault);
> >  
> > +	if (r == RET_PF_EMULATE && fault.is_private) {
> Should we just check VM type + RET_PF_EMULATE, and abort?

No, the goal here is purely to ensure that emulation is never triggered for
private memory.  Guarding against attempting emulation for a VM type that doesn't
support emulation at all is something different.

And more concretely, as of this commit, all VM types that support private memory
(i.e. SW_PROTECTED_VM) support emulation, just not for private memory.

> If r is RET_PF_EMULATE, and fault is caused by accesing a shared address,
> the emulation code could still meet error if guest page table pages are in
> private memory, right?

Yes, which is why I squeezed in a documentation update for v6.8 to make it super
clear that SW_PROTECTED_VM is a development vehicle, i.e. that trying to use it
to run a real VM is all but guaranteed to cause explosions.

