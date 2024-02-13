Return-Path: <linux-kernel+bounces-63827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38AC853501
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B951C23295
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC85EE81;
	Tue, 13 Feb 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ips1xZJX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241825DF26
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839126; cv=none; b=t0lDs2J921ZSGRvhbjuMfSCU3UNNwHEJEI3Ab3HLgwdy2UI58ute/dgcF8f+KUN2RC+PosAPl2D7SKhmMCchgME7EyvHANLckZmcGUrb/qKc4kVl5d+TuO6f2UPCR99eI9h0RdeyY4huLA6Af4U75O3pEGwA19YTzysEZlm8k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839126; c=relaxed/simple;
	bh=+/Eg3fKlMGekNo4yQ3rdUF3VeqRNJ0tYyXOMZSXk47w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ8jLtKUBEptEiGXc941sauIQdqOgrw/+axjV8EJVfAeqI+o4I/klcJxRuA3hJ/GfvxXIQEk0HwmGMCAD1NZzR2Qbecjsg+TgwKoNOzjLvCDcxEWVSNx293N5PCz7maZtFHDU6OFg8AKMFcyREMjkL15BjrGyjq1yMipSoEfewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ips1xZJX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707839123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mC+O0WAY8x9UWake37mLtLpIEPCaj8+5EiUT3ECyHuY=;
	b=ips1xZJXBsCjitpGA+J8LYashFPU2S/PrE2ZlpdmWLtyLRl0LUKSmIwN00jdBrdMy0xRQz
	uaVbsfgtRjPDhE5SnhHxSNzwyrX5zMalpakz7KNMZ6SLcf64Kq9cDcR2vWW+QQ2A6BZHIA
	0GUE5/6P4Z3lblxfee8UKnQdIb/2qTg=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-fa_VlJTGMUuY_sz0VkgQWw-1; Tue, 13 Feb 2024 10:45:22 -0500
X-MC-Unique: fa_VlJTGMUuY_sz0VkgQWw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7d2de089407so3086974241.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839122; x=1708443922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC+O0WAY8x9UWake37mLtLpIEPCaj8+5EiUT3ECyHuY=;
        b=KXxrCg7Sf+0hoX+GEPQtF+4nuQvV1nkIxbUgNKBjzYzEGRNF4jNCtk4g64rPs8Bj3c
         ClZNIpme+wAknvL3KxCDK4yhhFtVUUkuvq/xS9qUS2E8izI+CdIDrYhicODrCH2/GBcR
         0w8pFR0Hs4wl9HMouiKh2eDo+rIa/ryRqr2Lx4Vl1oKjTQQ1RaRdXYc6UO7b1FZYlUiK
         p7tI4OHcNTv6P8VEpAwmBQ6uHMFJU+R3mB7aMoY44Tzw4BVhYKaiBRc+0Wg4HdVdAR57
         yisrbgMNCaOU2xrnyfoiVeYHAt27Jp+wikWS/gSrMucotkXVr8H7FWKtqfHZoCY/HiuM
         DhwA==
X-Gm-Message-State: AOJu0YwMFyaG4c02qxehwdLqYJXusV/KpZkfllT15419VF8EnTSiE5Rb
	+ZrKaSxV0b50GNMha/5GCU7oJNx7jM2zneMEZSDmKNRglQKMRvKAV0nbYZaap+yxKuMh6PkFwR2
	u1lrTALxPtU/e+cD+rbC4TYLDi5WY4tOMbYS3Ghmu2Lb2gSkvfW/XxO8yP7+GbYoUParslS2JbL
	CGo1UMFixh+UyM2cMUdH7oc435PtrvvbsqE1TP
X-Received: by 2002:a05:6102:2404:b0:46d:5e5a:5e80 with SMTP id j4-20020a056102240400b0046d5e5a5e80mr7770268vsi.31.1707839121828;
        Tue, 13 Feb 2024 07:45:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5uZRjDeJV9I7SDi5aFF14RvjRJfCYm3XpvfMki8n9aEbHyODKiVLPo9TTtcP8SbrbzA5HrAm6y05wjIoyygo=
X-Received: by 2002:a05:6102:2404:b0:46d:5e5a:5e80 with SMTP id
 j4-20020a056102240400b0046d5e5a5e80mr7770086vsi.31.1707839120113; Tue, 13 Feb
 2024 07:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
 <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com> <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
In-Reply-To: <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2024 16:45:06 +0100
Message-ID: <CABgObfbUcG5NyKhLOnihWKNVM0OZ7zb9R=ADzq7mjbyOCg3tUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 6:21=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> On Fri, Feb 2, 2024 at 12:08=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > On Thu, Feb 1, 2024 at 7:29=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> > > I really wanted get_cpu_address_sizes() to be the one and only spot
> > > where c->x86_phys_bits is established.  That way, we don't get a bunc=
h
> > > of code all of the place tweaking it and fighting for who "wins".
> > > We're not there yet, but the approach in this patch moves it back in =
the
> > > wrong direction because it permits the random tweaking of c->x86_phys=
_bits.
> >
> > There is unfortunately an important hurdle [...] in that
> > currently the BSP and AP flows are completely different. For the BSP
> > the flow is ->c_early_init(), then get_cpu_address_sizes(), then again
> > ->c_early_init() called by ->c_init(), then ->c_init(). For APs it is
> > get_cpu_address_sizes(), then ->c_early_init() called by ->c_init(),
> > then the rest of ->c_init(). And let's not even look at
> > ->c_identify(). [...] get_cpu_address_sizes()
> > is called too early to see enc_phys_bits on APs. But it was also
> > something that fbf6449f84bf didn't take into account, because it left
> > behind the tentative initialization of x86_*_bits in identify_cpu(),
> > while removing it from early_identify_cpu().  And

Ping, either for applying the original patches or for guidance on how
to proceed.

Paolo


