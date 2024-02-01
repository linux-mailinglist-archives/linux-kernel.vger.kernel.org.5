Return-Path: <linux-kernel+bounces-48597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47957845E99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC039B328AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D084022;
	Thu,  1 Feb 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmpgKxQV"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320EE84026
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808766; cv=none; b=H9h2wx5c2zeiLzYRCWRXrxpLEKpm29eElslOo8llqIbBIb0Zaww9p3qu/rNlmb4QHtMy0Ru7HRYGfguDWSaJ95jk4XMytFZoEgWu8ds/uCLFJrdRfP2Ck1S0wcmnsgRMBYqiTEHj1WDL2jcpMHzy68Kzb++E8Ty/6Byq5rrDJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808766; c=relaxed/simple;
	bh=MYQeElrn6RP0xY9MrtM5r3jpd3C3Jxbd1CwNKrqS/qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTR3fmUYH7ZJgc8oP0eO7JTX2FHxMZZKfWF25EO9skmHEBfVO353DvDDsnSGpXcid+x6kLeilnK/Wgkat+V8wNuHWuzgM1CPPvOamJpldhw/LCYdybh1W9kPfWoaakIXXdiSND4VrSg3XsEc/Ndq+5BxwiyqArhpyE7tkOIGnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmpgKxQV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf962e1fcbso1204205a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706808763; x=1707413563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UD3/+3gzKT8fI1Ep9NTewT3g/cKMHmpNqtb0XSkLImQ=;
        b=nmpgKxQVvdoUqnFo/LTKfILhjMKZXfkEYE2niej15duz6hlc9dksQ6dU/l78O7MWNj
         63KFlkvuf/QY1BNozo/Q6bLZm7rSBekZA4cQ/dTc5Uii51G5A6P00Gg4EGGg4iCPlL1l
         2Wd1VnUqojZG+2nOF139BEge3bxBFX+hwCDmN/SIdAfKrT3wwcGj3MLznzex4lEmnHcX
         CNechPbqLcMNO2TNRzILih5BpjrPYSYRcToGMTu5U8TAow1PhAFqOz2uQLzhwIY1G5Wa
         pHqedtBYyOx22mFc5KOmfvN+inAaUtCfeh02f8n81r+wzif4OfUjcOks2PDtfb7t/MKr
         NMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808763; x=1707413563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD3/+3gzKT8fI1Ep9NTewT3g/cKMHmpNqtb0XSkLImQ=;
        b=IVxTrvyTPxMTZ+RYPEemm0PwPbLRXcx9XeiEM06rT5/z/JAhc5PK+SddLxpEsV/cZW
         Y6B3YLv92YGFa3MVwlSCpE5+gHRUEy9jSJzxV9zujC4xMIzNuDQeoYyUxhJt5fdmG8Dp
         k+7pNxK/b2Wv+WEXvfn47ghK3IxwuhyqGB9W4xUVROtqp1JFvfD+l/1VVWR3jo/W0uxV
         S/Cfi2MvmVSO3MzzfQ4wq8gU0giI8NK/nWVlXZLF3MlKQLjNfD1OfDl3KpiBq7mzZivV
         SfDU2w+nXhA5pW4RFyvLQry/EdwiTSSvMpsGzD7KgfRRG+xkBl1pwAVqdHGS+tfjUSpt
         Xlhw==
X-Gm-Message-State: AOJu0YxfK2k1MJKaXuvJtnlcQkH0Hfh5GzFwWdK6Yzi3pVCZZQsfr0wB
	BQJs4fnS97URTnOxARtdf5rIn8kG4oZjDekFuxPIC60ajz+UMT044B5k+f804UBUFmLrpfbluVS
	8LQ==
X-Google-Smtp-Source: AGHT+IEafkVK8au1j33821EYsvbAmBAx9/jzn80P/T05OUbLplyNFemMOeZYcdkVNujKPjTr+JBvyfZFE5k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6641:0:b0:5ce:474:352b with SMTP id
 z1-20020a656641000000b005ce0474352bmr12944pgv.5.1706808763674; Thu, 01 Feb
 2024 09:32:43 -0800 (PST)
Date: Thu, 1 Feb 2024 09:32:41 -0800
In-Reply-To: <510f3534-b076-4d23-b4b8-361c1f872d57@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117052210.26396-1-shahuang@redhat.com> <ZbQVRX3V1P-ZE2Wf@google.com>
 <510f3534-b076-4d23-b4b8-361c1f872d57@redhat.com>
Message-ID: <ZbvVuciX3HENjxQi@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix the dirty_log_test semaphore imbalance
From: Sean Christopherson <seanjc@google.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024, Shaoqin Huang wrote:
> > >   	/*
> > >   	 * We reserve page table for 2 times of extra dirty mem which
> > >   	 * will definitely cover the original (1G+) test range.  Here
> > > @@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> > >   		sync_global_to_guest(vm, iteration);
> > >   	}
> > > +	/*
> > > +	 *
> > > +	 * Before we set the host_quit, let the vcpu has time to run, to make
> > > +	 * sure we consume the sem_vcpu_stop and the vcpu consume the
> > > +	 * sem_vcpu_cont, to keep the semaphore balance.
> > > +	 */
> > > +	usleep(p->interval * 1000);
> > 
> > Please no.  "Wait for a while" is never a complete solution for fixing races.
> > In rare cases, adding a delay might be the only sane workaround, but I doubt that's
> > the case here.
> 
> If that's the case. I guess I should keep the current solution. Except you
> have any better solution, please let me know.

Unfortunately I don't have a better solution, and I don't have cycles to stare
at this deeply to figure out what how to make the synchronization rock solid.
Sorry :-/

