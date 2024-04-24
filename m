Return-Path: <linux-kernel+bounces-157292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D458B0F64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A21F22294
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99A16133F;
	Wed, 24 Apr 2024 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSQNh+xZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6F15FCED
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974902; cv=none; b=Zh7bWEt14YByf57ZztYSmCmeoqEsJCyx9+UMEQfDdBfaN5mxWBfqP1t1jZuEmoutGzwATTxH+9nrM5eQnQHKfSZJwX/+w3zZ4M63gTze9CLjTeCjwEYA9gBSi1AUJAGH3LxeMwZWAU+Zzl1mxiNYhiS3RxZuF/Kk2Thp3lmfz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974902; c=relaxed/simple;
	bh=UX+RSQsTZIoCgA4sTAjvIrhaan3lVSfzg+9u2yHW7fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c16wcqDkohpG4oQE37VgQ3o0SD/X8z2LZSMuQ0DF+kRy9Snzu4kVgV3HyF+fk49CyZuLkT06MmGsrXdoyYiOR/RI+J6d8eXGBlDOz6GW/PmjhNBwApiOECJHF+QlAuBgB06czDsg/HBXaNshUqZRjgAQzVWca1a+FgfVBDUXzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSQNh+xZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so74558276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974899; x=1714579699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk3EKgsQGWnjS0MB5E+L5+lH/YRrJ8wTPFpK6fCHC/0=;
        b=fSQNh+xZyICEaLyAYJ9j8B5Dpz9iGvXe9AekGvZfUPSkhGUTKrJ2lWayZW7QAOpQOf
         Q8M9BTKg6GMvNXkaD9RUJ1roLQLTBheXYP90tNemuaJnFJSGeXEHf5U6w/G8ikG57+hX
         W/ZzL5/4l3gLhcXPfwq+bEcEFadq6++lmanCmdo/KIZDV3aU2zV7kIT6eEz9zfIpPkXU
         LjwDPyGXrm6hdmyc3QkSm+PodXwkdjiQ8stX3PaKWkIe2b584IuIkiqHXxhX4rcfzUJe
         HfikG0tr0eilK8dW+/r2DUtDQCvS/X8YSGThyZQo/jrugYDs0TXEhbrObWtF24v19B28
         yj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974899; x=1714579699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk3EKgsQGWnjS0MB5E+L5+lH/YRrJ8wTPFpK6fCHC/0=;
        b=hV9kfpz33Z7FoTcRCRkuHu7hUOd4tqU04huPHJgfN4WoKW6sKrUnabunrt1tRha2Qc
         65lzvCfAOW1R5WbJf8dshQcoNPooYTI7AA5iY6LTY73U9vvRiSriS3R0QZqOeJNK3B5p
         QGUBj4YIiwhNpdm2FftaXsQpg+cvJUzdGKM5h/lxKMW3eMkY7pO8w3LSrxxWp4iFmppo
         JbDBjYBTJCzFs6JMFUdXEm+8vEJdPd0xIhLdho24cbKoaN95r9c8Cw9riX1gvTGlgTLZ
         IiXZhxldzTaS2UK3mBuvTkUHv61I+ZiNcDq3QT2GwTiqTS2xWcyhCtL5n4LIWLwB9tqw
         52ow==
X-Forwarded-Encrypted: i=1; AJvYcCX86d3/6Rf6biu19kCjJE9DA5Wstak+1rSxGF0sQqhxN1ObRSgJpIc3hwvgdMLsnrntlC75HCnrkIJGGvGUqfN7haB+bliqf+LtZ9mz
X-Gm-Message-State: AOJu0YzwSZtmXkUDBPKKa5vqq70eb0zUBrpwceSbaLec4zE1VYEHoEbe
	7T3XDO88maJ4Fmgh2guKp2W5J8cITYgWt32qgHvP/j71PaBajqr47Imoe3zW60XrGM9YtsxVGNy
	6PQ==
X-Google-Smtp-Source: AGHT+IHUEHWaTgZwPWeVlQZLsmhgBLdJhdqkgpe+SOVJ7NnX/mE1lLDAZaofyhrlTH6Xy2nYNweVj/XvttU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:b0:dcd:3172:7265 with SMTP id
 k6-20020a056902070600b00dcd31727265mr1002573ybt.8.1713974899485; Wed, 24 Apr
 2024 09:08:19 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:08:18 -0700
In-Reply-To: <20240329201854.f24ZDY24JtVE3gfa0i3m1MOFYfXVhCKdkXd0j5c-B6I@z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-26-xin3.li@intel.com>
 <20240329201854.f24ZDY24JtVE3gfa0i3m1MOFYfXVhCKdkXd0j5c-B6I@z>
Message-ID: <Zikucr6zpwBxOUiy@google.com>
Subject: Re: [PATCH v2 25/25] KVM: selftests: Add fred exception tests
From: Sean Christopherson <seanjc@google.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Mar 30, 2024, Muhammad Usama Anjum wrote:
> On 2/7/24 10:26 PM, Xin Li wrote:
> > Add tests for FRED event data and VMX nested-exception.
> > 
> > FRED is designed to save a complete event context in its stack frame,
> > e.g., FRED saves the faulting linear address of a #PF into a 64-bit
> > event data field defined in FRED stack frame.  As such, FRED VMX adds
> > event data handling during VMX transitions.
> > 
> > Besides, FRED introduces event stack levels to dispatch an event handler
> > onto a stack baesd on current stack level and stack levels defined in
> > IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
> > support ensures a correct event stack level is chosen when a VM entry
> > injects a nested exception, which is regarded as occurred in ring 0.
> > 
> > To fully test the underlying FRED VMX code, this test should be run one
> > more round with EPT disabled to inject page faults as nested exceptions.
> > 
> > Originally-by: Shan Kang <shan.kang@intel.com>
> > Signed-off-by: Xin Li <xin3.li@intel.com>
> Thank you for the new test patch. We have been trying to ensure TAP
> conformance for tests which cannot be achieved if new tests aren't using
> TAP already.

Who is "we"?

> Please make your test TAP compliant.

This isn't entirely reasonable feedback.  I'm all for getting KVM selftests
TAP-friendly, but the current reality is that the KVM selftests infrastructure
doesn't make it easy to be TAP compliant.  We're working on improving things,
i.e. I do hope/want to get to a state where it's a hard requirement for KVM
selftests to be TAP compliant, but we aren't there yet.

If you have specific feedback on _how_ to make a test TAP compliant, then by all
means provide that feedback.  But a drive-by "make your test TAP compliant" isn't
super helpful.

> > ---
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  .../selftests/kvm/include/x86_64/processor.h  |  32 ++
> >  .../testing/selftests/kvm/x86_64/fred_test.c  | 297 ++++++++++++++++++
> Add generated binary object to .gitignore.

This should be unnecessary (though I haven't actually verified by building), as
KVM selftests ignore most everything by default since commit 43e96957e8b8
("KVM: selftests: Use pattern matching in .gitignore").

