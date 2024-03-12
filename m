Return-Path: <linux-kernel+bounces-100908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF127879F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC401C21BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F44645B;
	Tue, 12 Mar 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB4H4wSX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1045C16
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284454; cv=none; b=YtqJ1cYqZo+CdrKsiLrvlRsWFWa7a21h6mVaJ481a5aNxohclO0ihtfyL9KRH+6TSaZglXaRxrRwCHOMkKsDgiZNS8A/tvNhMq2oGibyNE31MCwfu8Pbrz5WECw8L1O1ey1KZ7aNmKtSm3hA+/GOGTyeXTzK51qTeUPXayZ1UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284454; c=relaxed/simple;
	bh=qO2dOJwYXiHGsrBD/FdzA/KF9c8kSd9g7Y7J4bPgbmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9j7DQ5kV4oGFF4FMEIsuIIE9KwWIuEfL7K1DVNm/o9RzEa5XuNAzhmcbPSh4K45YBYUD4lk3+shAzEfCjmu2LByDp5pCDYMlig+k1uRIl8Fa5Jat9VhvqpvGuAX23RkctHzDpJynbcfvBrtwfiiyxPmWT1CTh/qDz4NGS7zfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kB4H4wSX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso7737912276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710284452; x=1710889252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoycAKQrzvuQYrnmzWabhjdIoZbB1BxJilyBQoB+qZI=;
        b=kB4H4wSXEAsUKfpRUpMmqoduBOGFESBiovb9E+zQVgmZOSHBPocWEfFYXZltkIyMHV
         ZMMCynAoVx6kEulz23OTsqydHOfA0xNduwBD2XET+qRLbVbuTdhgTAIBQVjR2lWynJwi
         6EiB3tqEBVyFQ5Ghgf3jN66Qevjyo+6ZuTubVIA3j4Q69dZo4qiRz5bXhnLGt2a9dWa/
         bbAIcI9h19Lgsg6h3mexwDlV09OIEf/G5QWsqEcuUZqI137UhfqNt6DGjdTUQavHdJlD
         wkSi61U/kBTHis0WhR9VwKrdQ2D7oghRxJhTVDHIZbuXZV61ijCY6eDTjmRO/YJzYndU
         4miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284452; x=1710889252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoycAKQrzvuQYrnmzWabhjdIoZbB1BxJilyBQoB+qZI=;
        b=ks39g/c9DaqGT4siXqs/mSqdYHdm4Ycac6PhfiWGH/1OmjnLyzfjrdGYQf76C3GQ2H
         7FUxTl++zqPOGsTP96c+9ZVpyGWnes87IkP5PK4qlYbUvR6ht5qLoZXuH3/0q/v8VamL
         8vySK5KZN85+4CML36dPg6xvOGCnfkHRrB+ctzB6Lct8x+ZTuRp4HIhmU4Xrt4tVLUl2
         icw3B+pPnc8XIkDClMIZXPlNuZ2KcdoSilqlot3ymiZGgRHBx2UaLnKRGcMNLD8PvsHU
         lC5hRoHRUIhxzOuvPaJduFm9e8J1nGjRPbTHa3hjHlX0X5KioFh++Tlr3ck8WkXR/R7x
         uGaw==
X-Forwarded-Encrypted: i=1; AJvYcCWFRl9tLOFMG8KcaDbM3q+1frsnNCIAyRWIttffI/jo1uP3IKVq0s1NZyWiwvJt8O70+CgyNlaDcj9WUwES67C1l17IXJHooYoMtzp5
X-Gm-Message-State: AOJu0Yz7mR41FhreuMyPq5bEVRHsFCUm+01ldPq1+r2A2U3SJYEADDN+
	5Zgou9vuNdk4NoDVeAVEY/OSOVNRH9UPDobPIS9SPjaf+4YZ1poYpkCHaoeXlIe32kZ8AlhjBkH
	nSg==
X-Google-Smtp-Source: AGHT+IFGUdhgsgVJ8mgWrHNthZAEjKQcuSF0mvEDkwwjRyC0VHPHtI8nOYpsZHnTIn7Wy+TGMLNJXNZF3Bk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100d:b0:dcc:8be2:7cb0 with SMTP id
 w13-20020a056902100d00b00dcc8be27cb0mr87342ybt.0.1710284451989; Tue, 12 Mar
 2024 16:00:51 -0700 (PDT)
Date: Tue, 12 Mar 2024 16:00:50 -0700
In-Reply-To: <5e302bfa-19a8-4849-82d0-0adada3e8041@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com> <20240308223702.1350851-7-seanjc@google.com>
 <5e302bfa-19a8-4849-82d0-0adada3e8041@redhat.com>
Message-ID: <ZfDeohmtLXERhyzC@google.com>
Subject: Re: [GIT PULL] KVM: x86: Selftests changes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, Paolo Bonzini wrote:
> On 3/8/24 23:36, Sean Christopherson wrote:
> > Add SEV(-ES) smoke tests, and start building out infrastructure to utilize the
> > "core" selftests harness and TAP.  In addition to provide TAP output, using the
> > infrastructure reduces boilerplate code and allows running all testscases in a
> > test, even if a previous testcase fails (compared with today, where a testcase
> > failure is terminal for the entire test).
> 
> Hmm, now I remember why I would have liked to include the AMD SEV changes in
> 6.9 --- because they get rid of the "subtype" case in selftests.
> 
> It's not a huge deal, it's just a nicer API, and anyway I'm not going to ask
> you to rebase on top of my changes; and you couldn't have known that when we
> talked about it last Wednesday, since the patches are for the moment closely
> guarded on my hard drive.

Heh, though it is obvious in hindsight.
 
> But it may still be a good reason to sneak those as well in the second week
> of the 6.9 merge window, though I'm not going to make a fuss if you disagree.

My preference is still to wait.  I would be very surprised if the subtype code
gains any users in the next few weeks, i.e. I doubt it'll be any harder to rip
out the subtype code in 6.9 versus 6.10.

On the other hand, waiting until 6.10 for the SEV changes will give us a bit more
time to see how they interact with the SNP and TDX series, e.g. in the off chance
there's something in the uAPI that could be done better for SNP and/or TDX.

