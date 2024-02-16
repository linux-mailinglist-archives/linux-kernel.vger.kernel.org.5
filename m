Return-Path: <linux-kernel+bounces-69055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8B8583E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BC21C23C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF04513340A;
	Fri, 16 Feb 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hUmf4TAW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88C43687
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103710; cv=none; b=JgRuuGXwNS53DEZZxslUNQGU/NQBnWj1gYCj8ZkwTcYIwcG0Eh4GvdZWB1XdocckNpPFLP14M/zAMp+4M+uyaih+qcDmeOCNVdz7xvIOAPf+R4eGUmPidAAmCFmOCrN4LMaxYjn9qJRPKjLOsT0xb6ABomaPu0XGTqPdd+lhB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103710; c=relaxed/simple;
	bh=0F5qTSlPkN7zpwybiJ29zbr41MUG6fVejMzapwrkqpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB/JbedsQODA5ePbuni3Xup9XSm25KrfEAtf5wWW92vlp3U8F5FfCaklcl0KKj01UrXvhNBg1Cf9nvT1Uf1YsboXfWih3VXcxkmRq4MKYL3KonibXB/WJK7hSdq+H+FgUitkNFmnvPKKUhzENYwXNWW+vdxcGuBXbNm9r6sr1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUmf4TAW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso3102477e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708103706; x=1708708506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjqnFLCl0w+QOjidjrUgBm/5JGoP8ymIUB3cNBX26RM=;
        b=hUmf4TAWgJTmCBGlpy+CzmKgCBqV88xFswQpPwaB43m8xOM1OmbGgFgg1UdRNX77rJ
         XAkH75ZEPRNuLgFoBwPp6Sad0SD6HPGujR2LZ9oZ2F0mnjPlrWFu9reC0+aba7KgQQzR
         drBihIicw5I8iUEALA9djnfZwHJGVPqHPHYuqCb6a31kCSoXia07rg+TfqQvaBrXSmgb
         HsNcPy3bKBy6TuTvkWJsueeMTqynEmVm4+o7CyOkRuTGYim33hSpW4j1eRFLuOFDO9Ax
         nIAeUeybtfu4POy9Fl9wFQIoP/ov2kgCrSM6VDUfuXBHkFVuQHxbMUzMLYGi5BaFO/mw
         Fv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103706; x=1708708506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqnFLCl0w+QOjidjrUgBm/5JGoP8ymIUB3cNBX26RM=;
        b=Do2ONjxRyMVe/eoDWGh/pYT8aUan16pwDf1PdlF7BRvTxff2PXNMg1DoWjr8AEIYan
         B6/AYLqcnwJUhmvwR+BGhAPuOx8MT7GWcgiVrhNVXw4HynqV9Kudf4JaECTescV6m6bF
         OB0AXciJXRTkFTr4yHMx8nU1DrtHXWNGdxX/ZF3mbQyo0vBaThuTQ+fitdL/Ot/likbG
         GgE68SoY3pGj2H6JJyrLMB2k8nHAsz5S2Rpif1ghirZkhDPLP9V5sHgFxuyOMo2kd1Ue
         a9qtqAO8GXZTSGLsELpqYbrWr2e97cL9qQXwyHm4cMzWnXYajlzFJPOnzjecwCkxvn23
         Dd8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhzZ45V1mU33/bjgn2seiUGThWMD+HuKFdt9F9l09snYWpznvojNTKDsD+ZyV01yH0Eux+2B8t7N8cYT+vyQ7ogyR35CCk3v2rixzP
X-Gm-Message-State: AOJu0YwL2DLFxt6R1xDz+ht9+qLw1WO2XPMkGCwb4eaY73jdipNVxSLa
	gje8mBqhmj3G86SPQQnYxrRb2brJ6OEaARxoCWX7MGLgOM2Ido9S+59SGn4O596efdNB7BU4aOl
	MdEpMUEyfa+233/s1CDkApKk4Xus9Nw9Q4n+q
X-Google-Smtp-Source: AGHT+IGWo3M5xdMyPXKWXIW5ULQNkr2RgZyQgSgnB7DImaPcMJq9MUmuYo3ikJDlMmug99VbQUIKBzitV5wxc8l+7zk=
X-Received: by 2002:a19:e041:0:b0:511:7c27:9655 with SMTP id
 g1-20020a19e041000000b005117c279655mr3726644lfj.23.1708103706175; Fri, 16 Feb
 2024 09:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215010004.1456078-1-seanjc@google.com> <20240215010004.1456078-2-seanjc@google.com>
 <CALzav=c0MFB7UG7yaXB3bAFampYO_xN=5Pjao6La55wy4cwjSw@mail.gmail.com>
 <Zc5bx4p6z8e3CmKK@google.com> <Zc-XF0yQp_dDUa6f@google.com>
In-Reply-To: <Zc-XF0yQp_dDUa6f@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 16 Feb 2024 09:14:39 -0800
Message-ID: <CALzav=eNEzFFmkhcE9K-nr5rvZ1nzXxCaukw7hjXzWcEieX34w@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Mark target gfn of emulated atomic
 instruction as dirty
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Michael Krebs <mkrebs@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 9:10=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Feb 15, 2024, Sean Christopherson wrote:
> > On Thu, Feb 15, 2024, David Matlack wrote:
> > > On Wed, Feb 14, 2024 at 5:00=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > When emulating an atomic access on behalf of the guest, mark the ta=
rget
> > > > gfn dirty if the CMPXCHG by KVM is attempted and doesn't fault.  Th=
is
> > > > fixes a bug where KVM effectively corrupts guest memory during live
> > > > migration by writing to guest memory without informing userspace th=
at the
> > > > page is dirty.
> > > >
> > > > Marking the page dirty got unintentionally dropped when KVM's emula=
ted
> > > > CMPXCHG was converted to do a user access.  Before that, KVM explic=
itly
> > > > mapped the guest page into kernel memory, and marked the page dirty=
 during
> > > > the unmap phase.
> > > >
> > > > Mark the page dirty even if the CMPXCHG fails, as the old data is w=
ritten
> > > > back on failure, i.e. the page is still written.  The value written=
 is
> > > > guaranteed to be the same because the operation is atomic, but KVM'=
s ABI
> > > > is that all writes are dirty logged regardless of the value written=
  And
> > > > more importantly, that's what KVM did before the buggy commit.
> > > >
> > > > Huge kudos to the folks on the Cc list (and many others), who did a=
ll the
> > > > actual work of triaging and debugging.
> > > >
> > > > Fixes: 1c2361f667f3 ("KVM: x86: Use __try_cmpxchg_user() to emulate=
 atomic accesses")
> > >
> > > I'm only half serious but... Should we just revert this commit?
> >
> > No.
>
> David, any objection to this patch?  I'd like to get this on its way to P=
aolo
> asap, but also want to make sure we all agree this is the right solution =
before
> doing so.

Sorry for the late response. No objection to this patch. I'd like a
better story for KVM code that interacts directly with user pointers,
but I have no objection to fixing forward for this case.

