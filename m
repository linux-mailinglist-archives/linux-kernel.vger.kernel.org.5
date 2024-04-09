Return-Path: <linux-kernel+bounces-136096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C842D89CFF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D341F23B07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295824E1A8;
	Tue,  9 Apr 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h60fPXzW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0A64B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627023; cv=none; b=XhQ7490fUzzJ7AwRp9u+uC4SpDClbv8UjfiNpZ2tRUPKUzDPq+wiG0K9QnbTiDHyr6dpMjtNyYcTkSKiKiKebcPmcRQ6fvYSyRP32McbjQr2XAHFJLcDbjAL/5vls/0uy2UTnLXYtC7359eUN3clSAQ5FQBr/8yWZTUGImByq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627023; c=relaxed/simple;
	bh=BD1zkFEQaCmId3mcDbRC3TYOSHb6Co89bm3mk+igess=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wqse9ffQDbT+abhZiDCn1C8E+Ny0TMbGQRcIqjSX0/+vRXyw0E9dWad7p3o5M3TCqYhnFe97IwBT6+H3ypRXJtS9OqyOh3aA0lOSyI+iTT0b7gcns+Zj6Zjm9h5d+Ha0bMxeWxFe/AGKZVJph+8bD5a0oH3oOJvFKRrzxx9cbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h60fPXzW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6144244c60cso74634817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 18:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712627021; x=1713231821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjRIPz/M2VcYUECjNKWWApA6QeGNd1itI8GrWzco+o0=;
        b=h60fPXzW2phobwCv85xH/q4ID8VtFL+oYbaAf4d25kwQA0EJHLlffKbezFka/GySYJ
         RJwfDn2OWYkXAfhhqbCyK2o5EbAMvzGn2M83Z+ww8O5T+IjmFBT7M4WAhzcE7eBC+HJA
         JViPODu3XP4Y3xucKlL0mVxuHQF+HfnASxJvMMMzUEC5a08/Ak+H0TmmqTF7sAlJmdrA
         HsXp5//RhwQhn0PDubwLGZQVwOb/lt11ohDVpdCNaztQ+mAfRYQz4BiFG3XvG3wepjQ4
         dbPklnDc8zPHSnz8KZG9VC4R3tMVPiM9ibzT5fusUZKJJIOMj8vqpkLvDy5vpwaCMICf
         vIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712627021; x=1713231821;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjRIPz/M2VcYUECjNKWWApA6QeGNd1itI8GrWzco+o0=;
        b=P3fQl9d2hzLGP0u0YDOnqZmCuFRrhp91+9i2aOAS0I8AUnuQhzq9kV6mtCO+zIesuY
         8t8Nb6QRwxvLLMM8qwhUxxkCRTWFsJdbTMFtb+YLIGHpJEI2vbUId2PEi1ZAB/WqmOjh
         /sWACPIEO7qyYoN6my2AgGZaEsdyqu1zZW7V0re/UlF0NjD2uxcNqFRq2NKD0SV3Iule
         cD1PdvYgWCek3ymNxTphYoQLgOAwNU/wCCxTzhTSl2In9zOM6GQEL1t+Ad2XP86XIe2v
         GDhiOARzGQZqlM4Fb14LYOQ+cv0nXZi0a50pj7tyWPy+SRXcZ7zf1C/+X4bRtN4QZ/v5
         pKZA==
X-Forwarded-Encrypted: i=1; AJvYcCUhMZNPa579Ke+VKL/OYhw3XFPlduh0eTzETJQ4QiYlDgcMu9x0mt3Tnx15dAFGAbz3EiNBvOf6BbR6m9yekh/MMsAcSh+4TWSd2vur
X-Gm-Message-State: AOJu0Yzcf2HSJfQm3aw5U3qwyi7/uSeJ0dZqEvpyu6hCwWsBrzI1WWF3
	2AFhWoCpyxVntOfahxG0t90PrY/6s8hRaKeHXAlUT6VWc1nPnh2OAjCuXHenLy+LroTRcrHrBI3
	b0A==
X-Google-Smtp-Source: AGHT+IE9KQsNOA93ROMsXKq+pKiB16ajbUxXH8rL5WHrQbZF5FFxqIToaI2n/+CF6oPsbOBr7AgNq0Zr+iY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:680b:b0:614:881:f59e with SMTP id
 id11-20020a05690c680b00b006140881f59emr2787183ywb.2.1712627021028; Mon, 08
 Apr 2024 18:43:41 -0700 (PDT)
Date: Tue, 9 Apr 2024 01:43:39 +0000
In-Reply-To: <SN6PR02MB4157FDA1C431A92873AA1AAED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240324190503.116160-1-xry111@xry111.site> <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com> <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
 <Zg7jLn-lV55Yh6mH@google.com> <SN6PR02MB415717D76F71C023A574841ED43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <f8df14f3-ae6a-4e08-927a-7a7c2ebe8352@intel.com> <SN6PR02MB4157FDA1C431A92873AA1AAED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <ZhSdSwqUprIgLVtr@google.com>
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024, Michael Kelley wrote:
> From: Dave Hansen <dave.hansen@intel.com> Sent: Thursday, April 4, 2024 1=
1:09 AM
> >=20
> > On 4/4/24 10:48, Michael Kelley wrote:
> > > I agree one could argue that it is a hypervisor bug to present PCID t=
o the guest
> > > in this situation. It's a lot cleaner to not have a guest be checking=
 FMS and
> > > microcode versions. But whether that's practical in the real world, a=
t least
> > > for Hyper-V, I don't know. What's the real impact of running with PCI=
D while
> > > the flaw is still present? I don=E2=80=99t know the history here ...
> >=20
> > There's a chance that INVLPG will appear ineffective.
> >=20
> > The bad sequence would go something like this: The kernel does the
> > INVLPG on a global mapping.  Later, when switching PCIDs, the TLB entry
> > mysteriously reappears.  No PCIDs switching means no mysterious
> > reappearance.
>=20
> Xi Ruoyao's patch identifies these errata:  RPL042 and ADL063.  In the li=
nks
> to the documents Xi provided, both of these errata have the following
> statement in the Errata Details section:
>=20
>     This erratum does not apply in VMX non-root operation.  It applies on=
ly
>     when PCIDs are enabled and either in VMX root operation or outside
>     VMX operation.
>=20
> I don't have deep expertise on the terminology here, but this sounds
> like it is saying the erratum doesn=E2=80=99t apply in a guest VM.  Or am=
 I
> misunderstanding?

Huh.  My read of that is the same as yours.  If that's the case, then it pr=
obably
makes sense to have KVM advertise support if PCID is available in hardware,=
 even
if PCID is disabled by the host kernel.

