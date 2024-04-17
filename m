Return-Path: <linux-kernel+bounces-149235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3868A8D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9531C209EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE3C4AEDB;
	Wed, 17 Apr 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aaft/Gcf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFC481B5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388066; cv=none; b=ZzMFSAvmz4ahknjhtaCkD8A/6d/PI6lScTLFbj0UhmQcvv60bqjF/QquTc9sWi68IDrd122QFZWA0YLc8kjIUL7dtv7IQKqo8oD3M47gjLvrHGNoaWH0mO+3jh/CCrUYMvVSU6ANhHi7oLb8P1p6Dy4uyMawGWtAyXmXxWIi/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388066; c=relaxed/simple;
	bh=SuSpqJqbxnlzpseOBKBTPAEDlzg9TcHCJWvNZcoGvhw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/0yKIU1gDTusnhzP/B3mmJAMqJIGQBZNAYeACmOTAOnr3YkZP4qfEQ8yopGF/N1BqJDEImJpHuFuF0+eWh7K6Q+AT4kN8Ww7rrchygGpgBzy4ih78zjS3nsyrCxHhvIVUn/+eVsYp83k3bo6eDS3zq7BlcRquYgDEfypGOOcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aaft/Gcf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a2c4a28e43so218901a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713388065; x=1713992865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfyLy/OiYOcy41ACUnbr3O3h5WQTS1oGPltebZjz3tM=;
        b=Aaft/GcfQ2KyWkW/JR2p90Q0kZwa0wUGV2tY1DcYG0oqey0dyOpcKZvNaFy0e/pRgn
         3qcusEKYM2xM2x4+NvouMFioCxTEXpfVeN4KG7cS+MafAkysBH6x95qnGz4Q3WuoS7Ju
         HFRWX/EvGhjPAavzOdczOfQh5+stoGsUn4/A1tVX50Tw0Rlt/REgYvcXJPmTnR5TNo8J
         ghbmwjhCk2ehIXKhJcKa6VdvEJrDPlcocz+f63m4XpBqFWxUdexnW3Htym3cNYXYbbYz
         lg/sJC6B6MEaXu0eRFFyDifpcPBVwPnrPhoJtW+txdCqCQ42q5U4Qo08fRyrwRC2iq64
         k0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388065; x=1713992865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfyLy/OiYOcy41ACUnbr3O3h5WQTS1oGPltebZjz3tM=;
        b=wgJ+ALVgLKXOhgBP/pi+pB/7ENasavDQFqWV/5Ii2xWRKQ6giKqT3T6ngbUbNHqNML
         1Z4CrQ+xrITf8Cpb7L3uZo2zuvmmbW0eDzuNaJ5SHmRu7xOdGWyphjYumlpXz6YTSLdE
         AolFgeLIAjoMxzQiNuzSxTL86hkiDw8qojLDtkPh5xP2KtQ2lVhX+tTjO158ICn8vynn
         S7OONex/8Dz/T3wNIj9y/Y2kqK0XzHi85u8a8Vm2xSw1i8m7rRvDF5B+Ze/NsYBznh9S
         26BmFOS/oyX4jFkk/c0+/hggBzMuWEj9QbTjjV41Tn+/vFil/jl5XS1c8+5cDG4HepRg
         G5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmq1HO4HEuXq3YYvTHGiVeCEVmEkdVNcgK8iaSYh6gmMhlStINxx24EmIERsoKhBjwrFtUPmdRw/gEpxr+aXHFx88ZlDfR0kvAijM+
X-Gm-Message-State: AOJu0YwRr8lto9UQaRfNNdyOaI5U/J2u8Pv2PWbsGX8nxSv76mozeMEr
	eGFNBsXyddpJkKp5DPtRloF0lJmFYBjIh06ZKtIHpuCd+bDvt7JOhIoOuZqGFpB3fgk9kZ2P/3+
	n4g==
X-Google-Smtp-Source: AGHT+IH2gdLSxVam6aZplit7Lxn7mctOY7g4Ov3RDJUiqulzPGarONgO9/yviAsymTcZNJNLwyynbE844kc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4497:b0:2a5:366a:30fa with SMTP id
 t23-20020a17090a449700b002a5366a30famr1998pjg.3.1713388064735; Wed, 17 Apr
 2024 14:07:44 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:07:43 -0700
In-Reply-To: <20240417193625.GJ3039520@ls.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-3-pbonzini@redhat.com>
 <20240417193625.GJ3039520@ls.amr.corp.intel.com>
Message-ID: <ZiA6H9-0fknDPdFp@google.com>
Subject: Re: [PATCH 2/7] KVM: Add KVM_MAP_MEMORY vcpu ioctl to pre-populate
 guest memory
From: Sean Christopherson <seanjc@google.com>
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, rick.p.edgecombe@intel.com, 
	isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Isaku Yamahata wrote:
> > +	vcpu_load(vcpu);
> > +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> > +
> > +	r = 0;
> > +	full_size = mapping->size;
> > +	while (mapping->size) {

Maybe pre-check !mapping->size?  E.g. there's no reason to load the vCPU and
acquire SRCU just to do nothing.  Then this can be a do-while loop and doesn't
need to explicitly initialize 'r'.

> > +		if (signal_pending(current)) {
> > +			r = -EINTR;
> > +			break;
> > +		}
> > +
> > +		r = kvm_arch_vcpu_map_memory(vcpu, mapping);

Requiring arch code to address @mapping is cumbersone.  If the arch call returns
a long, then can't we do?

		if (r < 0)
			break;

		mapping->size -= r;
		mapping->gpa += r;

> > +		if (r)
> > +			break;
> > +
> > +		cond_resched();
> > +	}
> > +
> > +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> > +	vcpu_put(vcpu);
> > +
> > +	/* Return success if at least one page was mapped successfully.  */
> > +	return full_size == mapping->size ? r : 0;

I just saw Paolo's update that this is intentional, but this strikes me as odd,
as it requires userspace to redo the ioctl() to figure out why the last one failed.

Not a sticking point, just odd to my eyes.

