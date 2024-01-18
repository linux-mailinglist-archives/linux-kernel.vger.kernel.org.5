Return-Path: <linux-kernel+bounces-30431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06366831E90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B71F22349
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA02D04C;
	Thu, 18 Jan 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olk/jPcO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6D2C68C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599639; cv=none; b=mex/4XtuB6v4C0T6knz20bVs+xoYG59OYlv1Jof5cPauFwhUSKSbQ39GnWfClkIEBffxost4hoACtx/i4MscrlgTjnetbCgc05iqZOoXqCns/f3atrFR0KfwngUefGhQFAag0WYWTyUpYyaBeaHUSrA75WMNp1eygMZVSBAIWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599639; c=relaxed/simple;
	bh=ltTdpIF83mD4FLWoP8ES+hjgX7H5akmsbH+KpszV1Tw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vBQBMpQJlpFP3cnTaAXIbbOls6PW6mMNchuvfoYkwSjTkTGvJqzT7a02YTBsk1lO22x+th7i555K+5mE3OK3zW/W8xAs4ggn4sX1x2XzR9JlPIwFK1UxqqvsvaZTNpvZsUTQAeZYXwhaacz0BiIUV1iWiUM3HvyXgRIucf46kpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olk/jPcO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf8287b3bdso2909707a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705599637; x=1706204437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q3C3WGrieoJdAKFaeIZlXobOygHM9XDpw7BX2KbOhI=;
        b=olk/jPcOL4P18CmMZSUtVuZLS1/hmMykvKVXtE47UIUdOVpEC43luKhwfj9E/nsUGX
         syyfL4xpvdeuuSQTA7VZ6oem8PxUpEMwLzj3+7biCEhfkdZR+XMqFfK6FGoyhhu67y3r
         26q9AfNAgS2BkoqzObqM78oMFvm3n/+OYBcUOXguw5reox20j8ZIM7lgj/82kpoX3raa
         Wm2iIwLJjpNp2XCGM0MpPVO+2v5SeUhohXFKvaHD8noAunKUwzUDKGJBK7u62lwoT6r1
         okP6bJyvaTrIPoJYYoDIwae7f0RatLauOG0sdKEXuIoyguvDMxuEXYeeKIeaTiWNADae
         4YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599637; x=1706204437;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Q3C3WGrieoJdAKFaeIZlXobOygHM9XDpw7BX2KbOhI=;
        b=IVwSEOz02T3x7wkui2sDGs21xIpj6rShw31rKjuPj9zbZG0Hcp7a5kp6Mv5EBkGc/6
         2U9rbmREYv+HVhO25QMFRUdOU0XNDSFBa8Ovv7cFAeL/1r1Z3Xbo1SD2IYfmsQV+bBbP
         HcwTJ0nQ4LMTx77y1K5DOjI1CX8zGt1XQfzw39rt1qdJ/YE6khA5ec1ScXO+rTD+0b4K
         6Vl13/lmnizWfERiscJuONeu2p11jX4vJnyk2bR6dNAZte8kX4Gh58jQAjvw/gNChrB/
         pIUot0BNUdp6t+9axIFrX685Mxv7QhTDHFMJXoGICU6mY0GgsphwDubNqhGPlUIH2sSe
         Sn/Q==
X-Gm-Message-State: AOJu0Yx+ZTIGdzDyNxZwTI3iUb22sSz2rOwKonRKhSJ6q8YmQQtI1AGe
	lvP46ofP3r6BejUgV1TyFvBW6/GZjhlnU0W9fefgiwaBNwMLAkb25KD7GeEqVuDKjBAvQ/aefZD
	20w==
X-Google-Smtp-Source: AGHT+IHQno7PAwboCP87bGIkYG2fH+s8EoDNQ4sFTOlwoU3XmXeAa1RkI+vnnDxRDet8Cr9UHVnWumLJcOM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:63c3:0:b0:5ce:1891:dfac with SMTP id
 n3-20020a6563c3000000b005ce1891dfacmr6154pgv.4.1705599637554; Thu, 18 Jan
 2024 09:40:37 -0800 (PST)
Date: Thu, 18 Jan 2024 09:40:36 -0800
In-Reply-To: <CAAhSdy0SxZWdCHQVW0Bki+bHpg4qrHWV0aFzJq8V2xYtwsMWhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104123727.76987-2-ajones@ventanamicro.com> <CAAhSdy0SxZWdCHQVW0Bki+bHpg4qrHWV0aFzJq8V2xYtwsMWhw@mail.gmail.com>
Message-ID: <ZalilFSHBa_XHolD@google.com>
Subject: Re: [PATCH -fixes v2] RISC-V: KVM: Require HAVE_KVM
From: Sean Christopherson <seanjc@google.com>
To: Anup Patel <anup@brainfault.org>
Cc: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, atishp@atishpatra.org, rdunlap@infradead.org, 
	sfr@canb.auug.org.au, alex@ghiti.fr, mpe@ellerman.id.au, npiggin@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024, Anup Patel wrote:
> On Thu, Jan 4, 2024 at 6:07=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
> >
> > KVM requires EVENTFD, which is selected by HAVE_KVM. Other KVM
> > supporting architectures select HAVE_KVM and then their KVM
> > Kconfigs ensure its there with a depends on HAVE_KVM. Make RISCV
> > consistent with that approach which fixes configs which have KVM
> > but not EVENTFD, as was discovered with a randconfig test.
> >
> > Fixes: 99cdc6c18c2d ("RISC-V: Add initial skeletal KVM support")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Closes: https://lore.kernel.org/all/44907c6b-c5bd-4e4a-a921-e4d3825539d=
8@infradead.org/
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
>=20
> Queued this patch for Linux-6.8

That should be unnecessary.  Commit caadf876bb74 ("KVM: introduce CONFIG_KV=
M_COMMON"),
which is in Paolo's pull request for 6.8, addresses the EVENTFD issue.  And=
 the
rest of Paolo's series[*], which presumably will get queued for 6.9, elimin=
ates
HAVE_KVM entirely.

[*] https://lore.kernel.org/all/20240108124740.114453-6-pbonzini@redhat.com

