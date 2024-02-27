Return-Path: <linux-kernel+bounces-84058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DD86A1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCEC28C977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3D14F993;
	Tue, 27 Feb 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhKNTrEY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3F14F967
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069757; cv=none; b=rN/JLaAAH806c8otnvn9Mvct/yldx1Q551YGR5eQyluHPUV5JZwgcThJvy4r+VJAwbvDN4hNudnqZvyp6hTcTKmcUZlCTV0qRfRcvMBbr39YiVXL4EXd9AjsBsjI1cAuF+yqz6VjdclAOsRH2Ga7WzyeHojKSBTFXcfTUY7o6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069757; c=relaxed/simple;
	bh=2REuIryrvhb8IY5ewJb7IEUgAePxkytfDpGv804DBtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpLPi+x9M02P/LyfUT7l488kqP0YHxY6eMyRRUWJOUveAs24/2AOg/8wsNsTS2Saa1FSPydoVD1HavQNA76jwojn80+v2LU5/sIact5ZBJN1fOO0Qe6+pQNbcYylclqVgougY56gjpxTsqjW0KD2ZUy3+RbHA0YhiwgmX3HaSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhKNTrEY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709069754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys4/mtb/zCFeZVJK605fpgT3Q8mDJMYzpv+wFzJ5MM0=;
	b=HhKNTrEYfjmmQdwTiHPQwlz613uPC9LqmI2e/knDrPa7aXAD4rfySU37hYgmqBicJpg9hT
	mdtCyOZHgqYs7jofcAGoR1mBQz7tBqsOy+Vls4GQ/7XZXgB2GqgKHtcXsVw9Vi0EqlJSkQ
	Bz2ikiaDLIb6R+3PI4F4jCW0B6gOKJc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-eNQz6lqFM0SI73watrX8VQ-1; Tue, 27 Feb 2024 16:35:52 -0500
X-MC-Unique: eNQz6lqFM0SI73watrX8VQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d36736772so2317146f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069752; x=1709674552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys4/mtb/zCFeZVJK605fpgT3Q8mDJMYzpv+wFzJ5MM0=;
        b=wCbr09QD179Mhzv5k3JgFZ2AKAYmFIxLE+1wU+5pOgg5VjrACDwNGO3tLcyvkEHwKu
         P3qv1BrxGZaI+uX0iet9n2QlHgoo5ScE8l4Wq9cT2V8QCV9hWumW0A5FreaXm6ChkA58
         FEm5o1cOWGR/FavMXuiKXKmwwnkepXSmlwb4ZKAMvUlpWSUez5KSnkeUoaElVwc/q46C
         JkzDYSPXvU7daYOy/PBys/jacEP3B7CrhJMcv/k0zGbCetTWtoxGVCjcKbc1dmEd05rq
         3Yv6eE9CL6+qe6vidE/u/fhSi5r6BXcvaE+WEMLRCnnsCoVdBbiov9Cks+pDmuKhDQYC
         S+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+/gPFlsTGxcu5NXhosCYtVuyY3dyk0ARzkmGdELxaor6OXqtIi6zB2mwNjVgZKA1ResMkiyZ0AXIc7ALOV3j2sn4JNt5znF+G1iXV
X-Gm-Message-State: AOJu0YyxcEn/KW6RygHVAjt3a80Lq8Qslg70bFV/fNA3K5FjOFJXjPCR
	874k2w9N2XUJnKLjP7vTY5LXjbn03PfIiW5nLSJ2YZ5dxa7gIfVhcoBvarfl+9DjosbVROZHhJs
	MoaNxfr19A7pwvypHB3HA9dGmPF6d8u97evuDqF7OKNfS6KpFGFVPWtoIYfOgGj9fmq3aE72bq+
	iZMyDUcFjoTl961kVAEKQYLvyZ0cE6PhkMpI7h
X-Received: by 2002:adf:f883:0:b0:33d:86a5:a052 with SMTP id u3-20020adff883000000b0033d86a5a052mr7729537wrp.54.1709069751774;
        Tue, 27 Feb 2024 13:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFudc2J2mLvfXTssXGAJUKIVisLTyQ+4K0Yjs9+2zCjktF1ZOaKlOpwmj6zM/fsmBz+xvc9FNXOFe6nCQ/tUEg=
X-Received: by 2002:adf:f883:0:b0:33d:86a5:a052 with SMTP id
 u3-20020adff883000000b0033d86a5a052mr7729530wrp.54.1709069751470; Tue, 27 Feb
 2024 13:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227192451.3792233-1-seanjc@google.com>
In-Reply-To: <20240227192451.3792233-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Feb 2024 22:35:39 +0100
Message-ID: <CABgObfakhde_Xwhj1Q5LLkD-TxMCWoAMfz40HC_Nr6y5hDLBYA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SVM changes for 6.9
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:24=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> Please pull a single series that allows KVM to play nice with systems tha=
t have
> all ASIDs binned to SEV-ES+ guests, which makes SEV unusuable despite bei=
ng
> enabled.

Ok, will do so tomorrow.

> This is the main source of conflicts between kvm/next and your "allow
> customizing VMSA features".  guest_memfd_fixes also has a minor conflict =
in
> kvm_is_vm_type_supported(), but you should already have that pull request=
 for
> 6.8[1].
>
> There is one more trivial conflict in my "misc" branch, in
> kvm_vcpu_ioctl_x86_set_debugregs(), but I am going to hold off one sendin=
g a
> pull request for that branch until next week.  The main reason is because=
 I
> screwed up and forgot to push a pile of commits from my local tree to kvm=
-x86,
> and sending a pull request for ~3 commits, and then another for the remai=
ning
> 16 or so commits seemed rather silly.  The other reason is that I am hopi=
ng we
> can avoid that conflict entirely, by adding a common choke point in
> kvm_arch_vcpu_ioctl()[2].

Yes, I'll do that. I have to respin anyway to get the SEV test
infrastructure. I'll keep posting against kvm-x86/next, though.

Paolo


