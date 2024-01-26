Return-Path: <linux-kernel+bounces-40382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF083DF49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E3FB24D67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC11DDF5;
	Fri, 26 Jan 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3t8L/i/F"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135341DDFF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288144; cv=none; b=uNtK8YRE55hcKJhVvhrajrOsARDW7HK6pvWtdFG+Wpn1CioWTvq45kVooi9U7RazajhiZnf1jfUzxF8rkTLFwP2znE4rTO8o7XY5175Q6efJc4uUA6IZFVOOWXnpDRUjU0Hc5j5ClrnMpGY2J9/YBPs/xWJfTd+bJOqXOteAZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288144; c=relaxed/simple;
	bh=zxwhVOLE3gzPx1lLnJ7kUSvc4kjwJMjq+fDCZLpDEU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkDRoDh4A4jC5aeNc9XJ+XddtUaDFCsYozPj5YJzXjRHo+oVGSE+AvfKfmAxN8q3rBRUe4bsoSNVFPGfm6BnuEHE1zU0ArYuk9FLQEKhWF3mXeUsFr84XCLDzdWOgf9+J5TYcbMqz8obBYvA/1HG7CTDL0LJnZywx7nJ1NWvLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3t8L/i/F; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55d418c5ca1so5722a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706288141; x=1706892941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxwhVOLE3gzPx1lLnJ7kUSvc4kjwJMjq+fDCZLpDEU8=;
        b=3t8L/i/FClb6wRhwu/aNP7ggDrKYbnMxosDGhZuOO5hT5bLzs2q5jJ1PPq9uuqrkRP
         OCOEU2TQH4jFz7vsVVdkBkNBiOHUfvBhwb15kovW5QVbpN33fsINUPsbHpKy0Vcv8d3t
         fB2XACn9z5X0MV3Jm2En7uAwe4fSuwMtrDn7odBK2g8nAvilsH16VuD/9JacU5CQxwQi
         pwa4G4aYS4ptgk+83zRZRLxBq7lgPoQgSzWgeGv8rmeU/m4kkPMOhxMUrNDx6aR9j9f8
         IRvLxsg0SSi2/9z56J4udjims4IF6DjoXhSWi9aSzGUqJ0obMSA8uBnskOVu961mxd5t
         OnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706288141; x=1706892941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxwhVOLE3gzPx1lLnJ7kUSvc4kjwJMjq+fDCZLpDEU8=;
        b=ZIL3qeqRgPieDe08cQd64HcqHTIoCurDkUpLtqo+vfwedM5SBoqZBwQ4bNebpzW9Xb
         +ttddQQ1YHq/n6Ds8capyUeLR3hzpz7i7gJ9AhWB6EMTy0wRmap+CiZ4lsIkNXT4G7UU
         X5av4Vndmhpim12kyX0Zg5dXjDnZpt7xtzTsWmsUi5xSQpuroINjILytJr0DRC8VlmCG
         XNyTLJRb7BzrCnFjKV9SRfzyKt0Rv95jN2gqcIsFn+KpC4t70EQWccLZl3BxLUZDqfez
         fn5Ubqom6a1yWyaJ6EjNPluEtho2mH7n6BW16iMM+rs4nM5koC6iClcHRopAe66pfiLW
         Yu3w==
X-Gm-Message-State: AOJu0YzqrQV3vB6FWxPdnnl0uzjL/RZJIy/DHAFJYzGvIjQxd/gK63VI
	n011N7pAjSpD1GLzk9/fXYwxn840OLOG5I0adPCRJXJNc1xw22bYWLJlJdN2S5U0hIOBPPqftoP
	wnSv06xH/9a+MRKCDywCLB+xZbDrHAv2Ahn7/
X-Google-Smtp-Source: AGHT+IEBXRn/yWC2G3iLvBVpTnf7frUux03kuFyEOJZMUmvVIkI7QkDfzNcoibbTn583SotrwZpKTXcErZZGb809pYo=
X-Received: by 2002:a05:6402:22cb:b0:55d:20f2:6d64 with SMTP id
 dm11-20020a05640222cb00b0055d20f26d64mr192253edb.6.1706288141014; Fri, 26 Jan
 2024 08:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114223532.290550-1-sameo@rivosinc.com> <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com> <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com> <Za1G9I+tYuIL9ser@vermeer>
 <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com> <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com> <65aeecea827f0_37ad2948@dwillia2-xfh.jf.intel.com.notmuch>
 <14dffda2-f413-4304-9932-3ac8ddfb30e4@intel.com> <85109de4-5832-4e14-8416-6443ac417c9d@linux.intel.com>
In-Reply-To: <85109de4-5832-4e14-8416-6443ac417c9d@linux.intel.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 26 Jan 2024 08:55:26 -0800
Message-ID: <CAAH4kHbhiyruEHiVx6cj_CangiD5L40+aRJBjgFJ65r9VHxpbA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	"Yao, Jiewen" <jiewen.yao@intel.com>, Qinkun Bao <qinkun@google.com>, 
	Samuel Ortiz <sameo@rivosinc.com>, "Lu, Ken" <ken.lu@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:59=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 1/23/24 10:48 AM, Xing, Cedric wrote:
> > On 1/22/2024 2:32 PM, Dan Williams wrote:
> >> Xing, Cedric wrote:
> >> [..]
> >>>> So, yes, the mapping should be allowed to specified by the low-level
> >>>> driver, but at the same time every vendor should not reinvent their =
own
> >>>> enumeration method when we have EFI for that.
> >>>
> >>> Given PCR->RTMR mapping is static, I just wonder why it needs to be k=
ept
> >>> in kernel. Given that PCRs can never be 1:1 mapped to RTMRs, and that
> >>> TDX quotes are never TPM quotes, applications used to extend PCRs wou=
ld
> >>> have to be changed/recompiled. Then wouldn't it suffice to define the
> >>> mappings as macros in an architecture specific header file?
> >>
> >> I think something is wrong if applications are exposed to the PCR->RTM=
R
> >> mapping thrash. I would hope / expect that detail is hidden behind a T=
PM
> >> proxy layer sitting in front of this mapping on behalf of TPM-client
> >> applications.
> >
> > Hi Dan,
> >
> > My apology for the confusion! I think we are talking about 2 different =
scenarios - (1) this patch alone; and (2) this patch + vTPM.
> >
> > Scenario 1: This patch provides RTMR access only. My assumption is, the=
re are existing application (and/or kernel modules) that extend to PCRs tod=
ay and would like to work in TDs where only RTMRs are available. Changes ar=
e of course necessary in those applications as TPMs/PCRs are no longer avai=
lable, but from security perspective they would like to keep the same activ=
ity log and just change to use RTMRs (in lieu of PCRs) as the secure storag=
e. Hence a PCR->RTMR mapping is necessary and must be agreed upon by all th=
ose applications and relying parties. IIUC, this is the intention of having=
 PCR->RTMR mapping config maintained by the kernel, as proposed by Sam O. o=
riginally.
> >
> > Scenario 2: A vTPM is implemented on top of this patch, in which case t=
he existing applications don't have to change as they can continue extendin=
g to the same PCRs, which will then be emulated by the underlying vTPM impl=
ementation. PCR->RTMR mapping in this scenario is obviously internal to the=
 vTPM and I agree with you completely that it should be hidden inside the v=
TPM.
> >
> > My comment in my previous email was regarding Scenario 1. I hope the cl=
arification above helps.
>
>
> IMO, we should adapt an approach with as minimal user changes as possible=
 So I think we should try to avoid scenario 1 if possible.
>

I would note that the MapPcrToMrIndex mapping is an entrypoint of the
EFI_CC_MEASUREMENT_PROTOCOL boot service of UEFI v2.10. Similarly, the
event log should be collected before called ExitBootServices and made
available at /sys/kernel/security/coco/binary_bios_measurements.

>
> >
> > -Cedric
> >
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>
>


--=20
-Dionna Glaze, PhD (she/her)

