Return-Path: <linux-kernel+bounces-60062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AAC84FF63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EAB1C21161
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA448210EE;
	Fri,  9 Feb 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4k9Lf6q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02653A7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516252; cv=none; b=e3SO1RTqCHD92TvvaogEYWEhJedZ4PHlyOhKMNrSK6bVPfwUv0y74qn3ONDZ6iLSySS3X19IloD2DNHcE+hbC9jvG1z2Nn1DwMLsoP0ucn/bQ6UIZpl6kjK6aD2dgs4DVJvxwfDbNaBXFYmR8Tz8UkvE9mFP+Zas6E2Vn8R6REY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516252; c=relaxed/simple;
	bh=/eKGCuNJ3FHEbyu+DPRPVualyEamXtqY05+7kv0j6v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGn0rAEdqWHrK+vRoMEVtG0lg9PTNygWpI3HzHUjc4sO6NiCMEvI4gUF6bswlouYdSqA/PUpUQ9UYdgCZ/xP3bMv+4g4OZEXu9KUj5XxoV+nHMdJ5hWNqn/qKzRwtKoSmJmGJDlyPnZ0fyqfp5ktRIR63o/CSPgyKzyuamHUP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4k9Lf6q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707516248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PsQcBsRk1vKYhCjqjhZmQmcpr29M732Tn4RN7l3cCk=;
	b=N4k9Lf6qvzr2x5qqvdf8EZBey+X7g0o4/ky6BynvetJZH5yA6PyJwi3lFRSNJKI4MMdayf
	D9jWAJtX5xzXoI/cLQNUIJpXYDndNfIMV/QPpPyIxOpp5aYth77JlU7voSTh0ogVk16oAC
	GddRQTsGlqooI3RUHnyaypoOwjHoLL8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ROo1kxR2Po2c_3Vw1Kx0Tg-1; Fri, 09 Feb 2024 17:04:07 -0500
X-MC-Unique: ROo1kxR2Po2c_3Vw1Kx0Tg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5953e534a96so1901735eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707516246; x=1708121046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PsQcBsRk1vKYhCjqjhZmQmcpr29M732Tn4RN7l3cCk=;
        b=mTNlxtslCk8Sgu8+ZfTSSJ+iSamCtiq/TpyREEVJq3TQPjNp2IOMBH/DPe1MJ8u0C1
         p/YygmJbBHtED6rCXN6QfjevQd7ob/OcUgaP60oTcJhBl8wYksFwhgnPHa+td0ENKwRJ
         9961KabT5SuGP6EIRZzlyshXtWizIFWqebrb7Whuvb1AVZBM3p6SC4SecsiVOGO9unx+
         syGlEvQOkMIfEqi/zJP+uPdwqyacLlbhRHFvrZOb6JElA3xklFfYrfaunthiFMvuyo02
         SR9GHAkmBPYFKeM8bq5cZGQJfDK8+4zmFM0UZTdp2f+q1eE0LYMRMgi27qOBgbGCW9Se
         LnsA==
X-Gm-Message-State: AOJu0YxulzqrA19epAcGp7ub8l5f9l2I4CVU8/Xw3wW2v7E64+sNNM8Z
	sl7gmUL1UqeNKi2gQ3TdgVzYZUtaxyLv57LIA2NDHEEPwDJMGsE0SbdLFUmnhw9bIgLISIV0bAu
	0bttY9FlJs9Ze8PR4DTq1Vopb87dY1f5sAzJtTKyWdFTMLg7Of5uEjcFrgNz0qDrAOi/RGQfEQS
	obZJk3u0PRLERRVozxHg6fDPBAeGFcjhz6pgaF
X-Received: by 2002:a05:6808:120b:b0:3bf:dc8c:7a10 with SMTP id a11-20020a056808120b00b003bfdc8c7a10mr380353oil.45.1707516246419;
        Fri, 09 Feb 2024 14:04:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESd3wyQYbLXEJgWAjhRINhimI++QSrzJ/Q1rWiu7+oeZZ7mrDpl2fSjeBnrRsri1YJlp6CLkBROWJZ9MNGWd0=
X-Received: by 2002:a05:6808:120b:b0:3bf:dc8c:7a10 with SMTP id
 a11-20020a056808120b00b003bfdc8c7a10mr380339oil.45.1707516246138; Fri, 09 Feb
 2024 14:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123001555.4168188-1-michal.wilczynski@intel.com>
 <20240125005710.GA8443@yjiang5-mobl.amr.corp.intel.com> <CABgObfYaUHXyRmsmg8UjRomnpQ0Jnaog9-L2gMjsjkqChjDYUQ@mail.gmail.com>
 <42d31df4-2dbf-44db-a511-a2d65324fded@intel.com> <CABgObfYa5eKj_8qyRfimqG7DXpbxe-eSM6pCwR6Hq97eZEtX6A@mail.gmail.com>
 <ZcY_GbqcFXH2pR5E@google.com>
In-Reply-To: <ZcY_GbqcFXH2pR5E@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Feb 2024 23:03:53 +0100
Message-ID: <CABgObfYQQZooYrsUnc8SSUbpiYQyZKGzDN2JutB-a5mJWWcr7w@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: nSVM/nVMX: Fix handling triple fault on RSM instruction
To: Sean Christopherson <seanjc@google.com>
Cc: Michal Wilczynski <michal.wilczynski@intel.com>, 
	Yunhong Jiang <yunhong.jiang@linux.intel.com>, mlevitsk@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dedekind1@gmail.com, yuan.yao@intel.com, Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 4:05=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> > If they are needed, it's fine. In my opinion a new callback is easier
> > to handle and understand than new state.
>
> Yeah, we ripped out post_leave_smm() because its sole usage at the time w=
as buggy,
> and having a callback without a purpose would just be dead code.

[...]

>  : But due to nested_run_pending being (unnecessarily) buried in vendor s=
tructs, it
>  : might actually be easier to do a cleaner fix.  E.g. add yet another fl=
ag to track
>  : that a hardware VM-Enter needs to be completed in order to complete in=
struction
>  : emulation.
>
> I didn't mean add a flag to the emulator to muck with nested_run_pending,=
 I meant
> add a flag to kvm_vcpu_arch to be a superset of nested_run_pending.  E.g.=
 as a
> first step, something like the below.  And then as follow up, see if it's=
 doable
> to propagate nested_run_pending =3D> insn_emulation_needs_vmenter so that=
 the
> nested_run_pending checks in {svm,vmx}_{interrupt,nmi,smi}_allowed() can =
be
> dropped.

That seems a lot more complicated... What do you think of the patches
I posted (the one that works and the wish-it-could-be-like-that one
that folds triple faults into check_nested_events).

Paolo


