Return-Path: <linux-kernel+bounces-106398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5E87EDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FEF1F236DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2856743;
	Mon, 18 Mar 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6rUVJkD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1E5644E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780546; cv=none; b=fDTlnWc1AvSvvw0vtNt5fhODTpfNd+99sYoiSo4Rmt+QXVGTRjcT6ORQv8mktL54uUsU5Ki4lZ+bVBcDmeRykPJKUNT6J7TSRCsB+nAmlPNfotVZxvbxzSy1aEluLD+OWi4kjHZQV7n75OTgh0lg0Mu2Qu4r6gjzD15twhS8f0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780546; c=relaxed/simple;
	bh=stnly8HvasFMCvsYR1fbyuJtmkCcBTZ3FsH47hj2E1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2CB9rrXykDHtHL46R6F9WifIi2+jDxJ1BV4bC4YLlqbyQVEjk/kQXzT3n0vLZ5CwkhTDHWyzHIB+Lc/u1+SBL3xqpw1VVBbCZD8mMz9eaBPd/dl7awMYHrgPm4EqO/FAqaFjxPMwBobuhAXskO4t0DO1rXrvVkMiu1/CLsOyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6rUVJkD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710780544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBtKOdFjpK+3+Il0olwQK+Bw8samb3ue692p47qxRLg=;
	b=A6rUVJkDBt+43nNeeksNMXEkWejmtRVd6ji5VJkXFVX1oCDI9v+5YOq+VVlo8wJnoG8j8v
	XdYOTanou/dLKS3cbCVO4HhSfKzekPQHhDjqlrlScs2Mmo+/Mb2X39QiwU6LkPzN0kUkiN
	gaceDE6Pw8FpAJVIjt57mxZHWQXWEu8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178--hyuHS6zNm6x-ggfefkNkA-1; Mon, 18 Mar 2024 12:49:02 -0400
X-MC-Unique: -hyuHS6zNm6x-ggfefkNkA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed71800f2so1498527f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780541; x=1711385341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBtKOdFjpK+3+Il0olwQK+Bw8samb3ue692p47qxRLg=;
        b=t9Jfrsbncqdt7Gv44xNCO92yfdWUODSAYcep8JOTAJYWeK2iSlzYnpdTadrdYlO/SW
         OR/SyPKcn20NZELIlXheVK5NR8lrSPwZeOzwAKfiyPvJBSfz302YxHVFTh6ZMicLXuGS
         P7AwJawYxtm06SEBm6bP+FxMWmFqJDq9sI0BI3hFLg6/GoPR8g6C2bKNBIdSeL2x5rT1
         jECDwk/1BCuDlz9erxzmlQK2c1LEcP1WSVu9pJeiSdlqRdpBT8XalZl67AulKNIvT/5V
         crlYCKQ0C5Jyu1LjgOsYzDRKIpVzeMFIiF1NEl+fYmubhVLyIfpqypKemxIHDL6IstyN
         ZKrg==
X-Forwarded-Encrypted: i=1; AJvYcCW7TuCUHDexS0EAhaCzL1lAGaE3n+ApBFGHRBiDXuD3OUvsaqv7OnhAcxQibygPnFAQlu4hWVswPGQv+ZZx8BUAQ4xswY4fA4kGivg7
X-Gm-Message-State: AOJu0YxEmMRj1kodw0x9z+ZzKNJhLt9zOrGHDeTtJjH7UvYy4TJ0QZOf
	IsfVNyqPby//o4PDbe3aL5K+iZHIulBG3sYYiRen03fS//ol7qr1o/3IwLA93Xntvp9h5mhswlu
	+IeCPum5GdgUa1MUfPtBYPK+lj5oLpxWL3kwZ6xKEnMHkwKJF4Xvsz6Lq3ClICOcgXnWSB+CAtA
	2FmAnRHouFhKFK+VPRmrja/DCIwiens/9yZ7n8
X-Received: by 2002:adf:fd0b:0:b0:33e:6760:6def with SMTP id e11-20020adffd0b000000b0033e67606defmr10341237wrr.56.1710780541332;
        Mon, 18 Mar 2024 09:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFepTlAmHpk5XYr52CmG+vr1oXsaNyDVNLRINU5cOCbpoo7rMo/2qyJQ4eDkMw6LiUrwInEBeyds8RYpJNHITE=
X-Received: by 2002:adf:fd0b:0:b0:33e:6760:6def with SMTP id
 e11-20020adffd0b000000b0033e67606defmr10341226wrr.56.1710780540978; Mon, 18
 Mar 2024 09:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226190344.787149-1-pbonzini@redhat.com> <20240226190344.787149-11-pbonzini@redhat.com>
 <20240314024952.w6n6ol5hjzqayn2g@amd.com> <20240314220923.htmb4qix4ct5m5om@amd.com>
 <ZfOAm8HtAaazpc5O@google.com> <20240314234850.js4gvwv7wh43v3y5@amd.com> <ZfRhu0GVjWeAAJMB@google.com>
In-Reply-To: <ZfRhu0GVjWeAAJMB@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Mar 2024 17:48:48 +0100
Message-ID: <CABgObfYNnDXvPU7OMDHzq-yjRYGHaS-M0E_tE2UB4ucv6E1x2Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] KVM: x86: add fields to struct kvm_arch for CoCo features
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	aik@amd.com, pankaj.gupta@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 3:57=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Mar 14, 2024, Michael Roth wrote:
> > On Thu, Mar 14, 2024 at 03:56:27PM -0700, Sean Christopherson wrote:
> > > On Thu, Mar 14, 2024, Michael Roth wrote:
> > > > On Wed, Mar 13, 2024 at 09:49:52PM -0500, Michael Roth wrote:
> > > > > I've been trying to get SNP running on top of these patches and h=
it and
> > > > > issue with these due to fpstate_set_confidential() being done dur=
ing
> > > > > svm_vcpu_create(), so when QEMU tries to sync FPU state prior to =
calling
> > > > > SNP_LAUNCH_FINISH it errors out. I think the same would happen wi=
th
> > > > > SEV-ES as well.
> > > > > Maybe fpstate_set_confidential() should be relocated to SEV_LAUNC=
H_FINISH
> > > > > site as part of these patches?
> > > >
> > > > Talked to Tom a bit about this and that might not make much sense u=
nless
> > > > we actually want to add some code to sync that FPU state into the V=
MSA
>
> Is manually copying required for register state?  If so, manually copying=
 everything
> seems like the way to go, otherwise we'll end up with a confusing ABI whe=
re a
> rather arbitrary set of bits are (not) configurable by userspace.

Yes, see sev_es_sync_vmsa. I'll add FPU as well.

> > SET_REGS/SREGS and the others only throw an error when
> > vcpu->arch.guest_state_protected gets set, which doesn't happen until
>
> Ah, I misread the diff and didn't see the existing check on fpstate_is_co=
nfidential().
>
> Side topic, I could have sworn KVM didn't allocate the guest fpstate for =
SEV-ES,
> but git blame says otherwise.  Avoiding that allocation would have been a=
n argument
> for immediately marking the fpstate confidential.
>
> That said, any reason not to free the state when the fpstate is marked co=
nfidential?

No reason not to do it, except not wanting to add more cases to code
that's already pretty hairy.

> > sev_launch_update_vmsa(). So in those cases userspace is still able to =
sync
> > additional/non-reset state prior initial launch. It's just XSAVE/XSAVE2=
 that
> > are a bit more restrictive because they check fpstate_is_confidential()
> > instead, which gets set during vCPU creation.
> >
> > Somewhat related, but just noticed that KVM_SET_FPU also relies on
> > fpstate_is_confidential() but still silently returns 0 with this series=
.
> > Seems like it should be handled the same way as XSAVE/XSAVE2, whatever =
we
> > end up doing.
>
> +1
>
> Also, I think a less confusing and more robust way to deal with the new V=
M types
> would be to condition only the return code on whether or not the VM has p=
rotected
> state

Makes sense (I found KVM_GET/SET_FPU independently and will fix that
as well in the next submission).

Paolo


