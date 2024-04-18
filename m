Return-Path: <linux-kernel+bounces-150634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EC8AA21C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578E91F215AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116717335B;
	Thu, 18 Apr 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rS82ilXo"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD916D30B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465421; cv=none; b=ilq0uYXoKLlawoVufHEUNpNx/honOKHNtTvQQ+YdmIw7Y4PYEs1NrOW9k8ncnJ9LH+fquryZ+jr0dmlTgxq2fCJKTkPjA6yZJDNustHd0GXBby+pQTJlQ6U7NI2ENgch4EbHHbhWZRQCkz1KAInsVH6HGSp1Hnhwn6ydC1S5Z+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465421; c=relaxed/simple;
	bh=5M7sY2eNkmePxZYEhbphJRX7F7XSNeGGbs2z+TtGQ10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=llXnI/x21oYV5JassrT5aGjrHLFSVziDmLI3ZBVNAnKLWOediWDTWTJ1zTZDtsDjtU7b+k0PPQwsHOFQiQ61fI82VWr+3Ma0fRJO3LytM5Xd5TVRPRtiqF1hIse7Eo85SAH4etaW4A9vdIyoYm3hBE7RGjoFwFiEXKl7r/dSIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rS82ilXo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5f7c0bb1b95so207202a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713465419; x=1714070219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wlN/ce91bTf9rbFasUDQdfgpzsyETmNKvn6NbsAl7o=;
        b=rS82ilXoy6GZhfwknA0JqCrTPIg4eHWWzsNFXY1+6YnMxmOVOpz2aPS6qs/yvXNBC/
         IY3p6GFKqzBramDmAMK2oJckpsfw/Yn598Tt+qBYIbQXbpPg6r7dHXVYtSC9+j8yen4A
         dy9TKe3tzEbKadQoCnB6lloa+66xFKtdSB3yzhbns4IPAoFx9sWYXfxqEmbOvbrr7ZK3
         Hx97/T559MRJtWsHSU0EpXXuuGNu70C0n9jExU8vFZuGpJy9SBuFgezejK6ccnSJSS0g
         rX93TTJp4H1GGbpedbgpkbLoU1sFTgy2HMnDjqDK7y1T3VFujup1bgFNb4wy/Fp7G4nu
         6ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465419; x=1714070219;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wlN/ce91bTf9rbFasUDQdfgpzsyETmNKvn6NbsAl7o=;
        b=lHF9cPk22rRighONkxABWVhZ7krmubNTC9c8qNo2DxqlsA76iXH6Y6ia/wPcFxdifG
         bkgm7SCzVKw3Wk+ybNHxiAe3XiWqKzY1V7caYAhGoNsX5hiZDIyfGvyDd0p0c385yfKa
         LRdZ/aiGmg+TSBEi0RPPNcXL+LiPalRnyc8ffYUP0GxIyPnvyvtgte4w/Sxbho1R7LU+
         esUTJrNJEI49qt44owbO2NG9g2ktHB/0NDC5uiI320ddUYolJXqb2hvMmihIUUsAyvvO
         B3gcUGy/9CbX6Y/+cvf57tD/AjFAwYYwu5hjiOmfVKKc99h4OvwR8653TiItFPsT4kWj
         E55w==
X-Forwarded-Encrypted: i=1; AJvYcCWvlHaQrLvcjGgqNXVlxPDyG2cZDrNfrfT2tQPzhX8h8IgeDbwFeHM+yQVfRKHSV/qjd3rqHhzLhyUklGAwwhuSw7llwQDtVz8tZCXA
X-Gm-Message-State: AOJu0YyAk9NG0stFOktQrPy09uwA0tC3flU05B8LpyPuEcCfCtMOUM2a
	7xtR57jhU74UgfDyUzdpITzo6K1b1Ca/FVZ59mlKt5I7MbVtbAflu3npCKY3WceJNVW7AFl2/ON
	E5w==
X-Google-Smtp-Source: AGHT+IEEQdqUCVbpG8urZmuw0tUnHYvNqYQTHwsqXS5Je37zGkNyPzcVm0cNUkYflnrODXJVMl1KaQDGJeY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:3d4f:b0:2a2:bcae:83c1 with SMTP id
 o15-20020a17090a3d4f00b002a2bcae83c1mr15360pjf.3.1713465419139; Thu, 18 Apr
 2024 11:36:59 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:36:57 -0700
In-Reply-To: <70f9f3f847e614cbb95be4c011ecb0a5cbd2ef34.camel@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416123558.212040-1-julian.stecklina@cyberus-technology.de>
 <Zh6MmgOqvFPuWzD9@google.com> <ecb314c53c76bc6d2233a8b4d783a15297198ef8.camel@cyberus-technology.de>
 <Zh6WlOB8CS-By3DQ@google.com> <c2ca06e2d8d7ef66800f012953b8ea4be0147c92.camel@cyberus-technology.de>
 <Zh6-e9hy7U6DD2QM@google.com> <adb07a02b3923eeb49f425d38509b340f4837e17.camel@cyberus-technology.de>
 <Zh_0sJPPoHKce5Ky@google.com> <70f9f3f847e614cbb95be4c011ecb0a5cbd2ef34.camel@cyberus-technology.de>
Message-ID: <ZiFoSdKY7nrh7cfL@google.com>
Subject: Re: [PATCH 1/2] KVM: nVMX: fix CR4_READ_SHADOW when L0 updates CR4
 during a signal
From: Sean Christopherson <seanjc@google.com>
To: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024, Thomas Prescher wrote:
> You are right. After your pointers and looking at the nesting code
> again, I think I know what to do. Just to make sure I understand this
> correctly:=C2=A0
>=20
> If L0 exits with L2 state, KVM_GET_NESTED_STATE will have
> KVM_STATE_NESTED_RUN_PENDING set in the flags field.

Not necessarily.  KVM_STATE_NESTED_GUEST_MODE is the flag that says "L2 sta=
te is
loaded", the NESTED_RUN_PENDING flag is effectively a modifier on top of th=
at.

KVM_STATE_NESTED_RUN_PENDING is set when userspace interrupts KVM in the mi=
ddle
of nested VM-Enter emulation.  In that case, KVM needs to complete emulatio=
n of
the VM-Enter instruction (VMLAUNCH, VMRESUME, or VMRUN) before doing anythi=
ng.
I.e. KVM has loaded L2 state and is committed to completing VM-Enter, but h=
asn't
actually done so yet.

In retrospect, KVM probably should have forced userspace to call back into =
KVM to
complete emulation before allowing KVM_GET_NESTED_STATE to succeed, but it'=
s a
minor blip.

> So when we restore the vCPU state after a vmsave/vmload cycle, we don't n=
eed
> to update anything in kvm_run.s.regs because KVM will enter the L2
> immediately.  Is that correct?

No?  Presumably your touching vCPU state, otherwise you wouldn't be doing
vmsave/vmload.  And if you touch vCPU state, then you need to restore the o=
ld
state for things to work.

Again, what are you trying to do, at a higher level?  I.e. _why_ are you do=
ing
a save/restore cycle?  If it's for something akin to live migration, where =
you
need to save and restore *everything*, then stating the obvious, you need t=
o
save and restore everything in KVM too, which includes nested state.

