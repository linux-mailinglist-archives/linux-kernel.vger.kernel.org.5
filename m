Return-Path: <linux-kernel+bounces-137316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6189E052
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111A61C20D03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14E13E3F2;
	Tue,  9 Apr 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfVMmq76"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693213E05D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679969; cv=none; b=SVWz38RukT9N4AcrjNbw5HHD4HhM+su0PjhZYfdDQHDpFJ3Lol1V6bajI0FZ86+Am8T//39/v68/iZnOor2ZcrCayj5sF0tPLmu0BgPUglR4hbbE+YYRc4Ufdg7MWzd968g8nKRvN35mfM7sIFLaFWU8/MECwHwlsnD7FD/GTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679969; c=relaxed/simple;
	bh=N+ANGesTI817FgoUE7MaJdnqIR2bht9uLOcJGxGrIWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hnJyYawjJ3ZdahH0+DmPnYg1teYqsrFNo09I2ikNxzA4UugLEnFov63c/rLaUnjYckB+JffDS2rs47Rf6lL/p4it0OVodAmtlckyT7i5DJBS4VRW++QkVfPEbSRwRX6IMcLIomnjgdMAVouTbFv91s0dEG+NVUTPSxvx1UK2/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfVMmq76; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso8924017276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712679966; x=1713284766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLwBu2UBKVJSMM2lyAnPHiGZDO/8v+PK3h+1CCO1AZg=;
        b=wfVMmq76Tr4gHTGl4TLI/rNhSWR9xTveePofYgmj8ymGgpTSbE0iwrwXNTwctil3q/
         /mKKTemYCH7WaNonOxD32GvJGcU6389Uq2wJPrpnhdBLtQrR4LvCZNjo0ME1Do/RNXC+
         Kj19qZS6Ty2NIyb4ESATJGNem9Qgo1vKRNN64s/BYL0vIiOdZR/F2gvcmdaVL6S2g0Th
         iyzickg++CwETlIuTumRG1pwQsmo+ijzZoydWQ8a29XhxYboNaJ4RaNxET/6VFzn+pnF
         KmnLjojWuL91YQH4qZQJ/QVos8Vf03kIRUQT1miD/2KjEfXaxWXIUIxWhgKr4TZ05RoS
         AuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679966; x=1713284766;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DLwBu2UBKVJSMM2lyAnPHiGZDO/8v+PK3h+1CCO1AZg=;
        b=ugFmVlJFvgnp4v5hFqrCjy54wxFiajAX9F4xGwciUmV3uUz/S+P8BJ7rpAqifn4v2v
         BO0gULqnmSevsnHEVgjfDdrA/fRvDuBzNVY1Ahfocptr7SFTsGVNXeTm2QNcXOAESeWQ
         34a5HilMeZzgvj5ArSE8dqIHXr8ZATBLE+paq1iFzM29kDYBSrPzwEEpcOdzXm5ACWle
         SFI2iXPxFu+HAVsDSXIUbb9rl1AS0AA+zxsG9wqd3p7eDfJI1I9FgAcfG6oWkoxqIs6L
         HgVaXplzHRtQ3qj8S/UynqcJpkENsTO+51w+diXFZqRsO4zEgbhNkg+wPTEEo1W62xbs
         7NUA==
X-Forwarded-Encrypted: i=1; AJvYcCXS1qZ8e2QbCDXxyyQhugBzvBMx3aG8qi93SQg3TXczSkLRAuo4NV9dmaN7YsgXuHmJZSZ6qTyYGXPpCbD4hNoyUdGuTCsgxlu9vlbw
X-Gm-Message-State: AOJu0Yz24LEqOn4WxBRBskmO2ZSiWHcv+SvyCc382WHzw5A4lWPVkvWq
	s8NhEdBT26YneuDZPLjwqpbveYBrBtaucHeTb891O9EZkLAT60fs2WHP7aSaPUw5zdEnfbTTPkq
	48Q==
X-Google-Smtp-Source: AGHT+IF97/uJEtnJ1K5PxcUsCc7VP1sr5xVq2lbeSOKNPCtTaDFq/3fR54LKjXtZIZdm7rXAay6s+SS7FR4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1508:b0:de0:ecc6:4681 with SMTP id
 q8-20020a056902150800b00de0ecc64681mr26885ybu.1.1712679966650; Tue, 09 Apr
 2024 09:26:06 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:26:05 -0700
In-Reply-To: <4ae4769a6f343a2f4d3648e4348810df069f24b7.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZhQZYzkDPMxXe2RN@google.com> <a17c6f2a3b3fc6953eb64a0c181b947e28bb1de9.camel@intel.com>
 <ZhQ8UCf40UeGyfE_@google.com> <5faaeaa7bc66dbc4ea86a64ef8e8f9b22fd22ef4.camel@intel.com>
 <ZhRxWxRLbnrqwQYw@google.com> <957b26d18ba7db611ed6582366066667267d10b8.camel@intel.com>
 <ZhSb28hHoyJ55-ga@google.com> <8b40f8b1d1fa915116ef1c95a13db0e55d3d91f2.camel@intel.com>
 <ZhVdh4afvTPq5ssx@google.com> <4ae4769a6f343a2f4d3648e4348810df069f24b7.camel@intel.com>
Message-ID: <ZhVsHVqaff7AKagu@google.com>
Subject: Re: [ANNOUNCE] PUCK Notes - 2024.04.03 - TDX Upstreaming Strategy
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "davidskidmore@google.com" <davidskidmore@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"srutherford@google.com" <srutherford@google.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Wei W Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-04-09 at 08:23 -0700, Sean Christopherson wrote:
> > > Right, I thought I heard this on the call, and to use the upper bits =
of
> > > that leaf for GPAW. What has changed since then is a little more lear=
ning
> > > on the TDX module behavior around CPUID bits.
> > >=20
> > > The runtime API doesn't provide what the fixed values actually are, b=
ut
> > > per the TDX module folks, which bits are fixed and what the values ar=
e
> > > could change without an opt-in.
> >=20
> > Change when?=C2=A0 While the module is running?=C2=A0 Between modules?
>=20
> Between modules. They are fixed for a specific TDX module version. But th=
e TDX
> module could change.
>=20
> Ah! Maybe there is confusion about where the JSON file is coming from. It=
 is
> *not* coming from the TDX module, it is coming from the Intel site that h=
as the
> documentation to download. It another form of documentation.

I know.

> Haha, if this is the confusion, I see why you reacted that way to "JSON".
> That would be quite the curious choice for a TDX module API.
>=20
> So it is easy to convert it to a C struct and embed it in KVM. It's just =
not
> that useful because it will not necessarily be valid for future TDX modul=
es.

No, I don't want to embed anything in KVM, that's the exact same as hardcod=
ing
crud into KVM, which is what I want to avoid.  I want to be able to roll ou=
t a
new TDX module with any kernel changes, and I want userspace to be able to =
assert
that, for a given TDX module, the effective guest CPUID configuration align=
s with
userspace's desired the vCPU model, i.e. that the value of fixed bits match=
 up
with the guest CPUID that userspace wants to define.

Maybe that just means converting the JSON file into some binary format that=
 the
kernel can already parse.  But I want Intel to commit to providing that met=
adata
along with every TDX module.

