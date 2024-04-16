Return-Path: <linux-kernel+bounces-147676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8B8A7793
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A968B1C21CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48982481;
	Tue, 16 Apr 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFKUXqyp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332378C86
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305697; cv=none; b=KEolhAG8l3myMKYNMu9Z8SK1TiWdx4hf99auAfUZBhQgNkdKPDSa5SogQW7pIP0PxwMvWWY61SD7E38K5109CJZF0HqvwuCL2ngzxr9/CfqpWVG01ZTOlN5QuD9HjVtjuS0zyrzGnIJWZNwn/aXY2H02+norx+UpEIJks0XF6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305697; c=relaxed/simple;
	bh=7y3M+0fa7LjUGCW8zz0dPkhDbnFqBsAs1zY2vanoPcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ryGAvZbeaOLBlZmY4q1fabnFPx6dt2Y8SR58mYgLj4D6m/H+cCFp0skQmn1WkGwBZVVlpNoISLztjcYry9sSPbOASV3EfN9aPsCmNEUNA96/K7zp52Pm9ceUKmFG2ELYPWi+X2VKPTO+6NJjatgtSf7FD08ndyr6flXWDL75t4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFKUXqyp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6156b93c768so85724907b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713305695; x=1713910495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojAEudSaSnS6y1Hv+EyDUIwvL32E3n7xtXtPYkUfBj0=;
        b=zFKUXqypvTvGF555bgjBt0erX55aDgTTyZK71AWJQw+5G/tYwc3GnK7nbUnYvk25lX
         QYooX3CiiN0l5ott4sBi9bqQhCoXTjT5l9he33Q023Ifb9KSkx0i3oHYqtk0fhL9ub1b
         DSVCt8LYv9MZr/CF4QkL7j+fRN9L/GxBIjqRhDvpjtG8hFEE9wYFFvR1t8X3EpMjGhuv
         KnKJGPzXURs/LssuZFAG0XcLddvEa4X/tPREccHd2ch0VuQy5HaVkK450kC9HMiRgUQ4
         cSb35f6ZAmI9i5CCQtnAstADEhBFAWw4fBMIgGRxPoujleH2UcVO3k7k8dTueHYd0l0Y
         T91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305695; x=1713910495;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ojAEudSaSnS6y1Hv+EyDUIwvL32E3n7xtXtPYkUfBj0=;
        b=BfVDFzWeEdtcHSpd4+SUVbOKYeIXe6P0yew2CirV1g36Iqj1iSCcTYpyfJYVD8k0WR
         BIE+S/r5hFaa8sot8Yo//PTBsYlCQcfPL0ns1H+mM77Fsfs2xRlz8UDIaa8Gxx6+I/Tp
         eP3HKQFodVsZf5ZrVoAeJdUjHl2vyeMdbnxIep2KSed6rNh429xZCFC1Q8F6it2m9ZQp
         Y9aBVD1owguAsMJtba0m7DeBMQCVk0dZ6HQo+qKnhVP67CynLeyvPiFdat8QUh0FhpC0
         pnC2O67gVEEdnQZiUX8avxrnc1Cqvx95YGCa02UlOUjD/4TZcxavUQk16kUnr3Z9TfBU
         RPnw==
X-Forwarded-Encrypted: i=1; AJvYcCVnviDF+S8QV5i7HZnRumyp9veLCnfRxd6N4jRJZH/t/Qc43qN+yUHXq3p3/Fg+zOww3Jqky6L8ne5JjKaI2VyUurnnkGON50pV3FBA
X-Gm-Message-State: AOJu0YztbYoZUWCKou2kAmxPUESaAqUL4REMlxsNgCHgZz/zkq+1VN1s
	+aWikpUZMmtiFMNDfKGm69S/BtVMRxrgSqD/gX5Yp0kC4qmJVtfN+ifj2hzhjiRcI9GM1msX27A
	/rQ==
X-Google-Smtp-Source: AGHT+IEGWsaw9u26zK3PN5zbRSPRYyfDKGBaFt2K6uHPnxrP/X83MK3MKEIo+XYbUZDKfg8SYvyQ6tKroEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4e94:0:b0:61b:46e:62da with SMTP id
 c142-20020a814e94000000b0061b046e62damr161189ywb.4.1713305695455; Tue, 16 Apr
 2024 15:14:55 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:14:53 -0700
In-Reply-To: <CABgObfZ-dFnWK46pyvuaO8TKEKC5pntqa1nXm-7Cwr0rpg5a3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416204729.2541743-1-boris.ostrovsky@oracle.com>
 <c7091688-8af5-4e70-b2d7-6d0a7134dbbe@redhat.com> <66cc2113-3417-42d0-bf47-d707816cbb53@oracle.com>
 <CABgObfZ-dFnWK46pyvuaO8TKEKC5pntqa1nXm-7Cwr0rpg5a3w@mail.gmail.com>
Message-ID: <Zh74XcF2xWSq7_ZA@google.com>
Subject: Re: [PATCH] KVM/x86: Do not clear SIPI while in SMM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: boris.ostrovsky@oracle.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, Paolo Bonzini wrote:
> On Tue, Apr 16, 2024 at 10:57=E2=80=AFPM <boris.ostrovsky@oracle.com> wro=
te:
> > On 4/16/24 4:53 PM, Paolo Bonzini wrote:
> > > On 4/16/24 22:47, Boris Ostrovsky wrote:
> > >> Keeping the SIPI pending avoids this scenario.
> > >
> > > This is incorrect - it's yet another ugly legacy facet of x86, but we
> > > have to live with it.  SIPI is discarded because the code is supposed
> > > to retry it if needed ("INIT-SIPI-SIPI").
> >
> > I couldn't find in the SDM/APM a definitive statement about whether SIP=
I
> > is supposed to be dropped.
>=20
> I think the manual is pretty consistent that SIPIs are never latched,
> they're only ever used in wait-for-SIPI state.

Ya, the "Interrupt Command Register (ICR)" section for "110 (Start-Up)" exp=
licitly
says it's software's responsibility to detect whether or not the SIPI was d=
elivered,
and to resend SIPI(s) if needed.

  IPIs sent with this delivery mode are not automatically retried if the so=
urce
  APIC is unable to deliver it. It is up to the software to determine if th=
e
  SIPI was not successfully delivered and to reissue the SIPI if necessary.

