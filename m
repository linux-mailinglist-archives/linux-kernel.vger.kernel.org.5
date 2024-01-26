Return-Path: <linux-kernel+bounces-39479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F26083D1D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612471C2451C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E0522E;
	Fri, 26 Jan 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uXtUAFSa"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C651838C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230840; cv=none; b=X6Ei2sVK7PnPmBkya8Mo+g3IXsKFNVIGAAyMr8CGabrQtXRfkGPml0xWXWeCGbcs5mOgunI1lbxJRicmcpJNnTLlikXaDPFh0kigHkTXzt7vsnRmA6QDv4Bwta5g+WRIYHv55xJq61uZJ5Mya6WY4lQ7H0jzvLkH8uv4Dh1gbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230840; c=relaxed/simple;
	bh=b1EysaVqnVOuKJxM2IaK/TxCQ3p1ykl4Repgjoi2kfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqoiJZuRGIU7ZM9hFk+uvliJ3N0q35iDMcAQoIJ9ezEnNZDIvvyl/5HRXMb1DS0hc4IOz06xSuGndPPeVDqGxmXOMV3WiNtqBgjOk+WxsVo6R6uw/UZncEJ8lBBX2heKnBmtmuWm5MdJJaeftR48R0tdSD+46GWgdqQSa/2m2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uXtUAFSa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so3667a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706230836; x=1706835636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoRz9Pe9GXZ+r6gty+528GFeZ2jb+Iln87IYuPoUJm4=;
        b=uXtUAFSavHIAlokoD9ChlZDw7bcCC+GKxtYPDXbA1y5/qumtsgjcvjZSKg+CiZuLlN
         /+JmWcwoKoUeB9+XaTjDqH/bIFe1jF1RM899+YUvG7Kb/l6RmyLSuzfmGBMvc3tQiDnh
         DC1CV3IAsMYbUI+jiS5K8LHygztIGmUxR2E6UwphAc0/8siFIROE099EhkgYtv47fQfg
         uT1ESirUBpk1zo4Qv4eASm1FzeCPYu6TRi12+dtMZCWwFHxhVwbR2JClK4/4vgbnrgir
         rYGpQ9pUAaAkfOHx3+r0CKS7Izh4bULrfIw27XQQDIH1BmJGJIF8D5SOCPf7tG5lU4DH
         5sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230836; x=1706835636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoRz9Pe9GXZ+r6gty+528GFeZ2jb+Iln87IYuPoUJm4=;
        b=ZmRLRz5/8a5ouJRn3w5DkYI5jW8vx7nUSNi4uP7gHneTxLzdFe76Azt44qCOdqStd9
         f3GU6pkpgWE8nVEWpS1LGBFJQXIcHqjQJmfFboZoNp3wRsARoihliq44iZA0+MQAbqil
         /XxC7Z8q//PuDBFsX9tbEZqE1l04MR+66sk54nvOXCDvdGkx1/8qFeTDLiDbrys5qPds
         XptrKD+TAgxaiOpEUT1b68IhB/+Tm1L+rI40O8ScBGZGeuyOBjBhPvvhoHyxvBQd41aq
         vhji7VhiDUKMcdP2zmkwVJH3ZbxmWcJgDOSt8Pm/96nfomCRypXgZTiND08VhoU6Krcw
         woNQ==
X-Gm-Message-State: AOJu0YzUK2Nrx/nxdqXd8xY6Uq0rXHqSuo2/AxUXbAQUUsyrmak6BDty
	AzWQsBCb+Cjy/5VEDyRnerU80J0ssXCfsSUlfMnP+BYGuXlNC/SZvZEVtLqp1YEXPbFzGnksNaw
	Fc00LEbYHP9Pol0GcELx7Fo9wslID9vN3wr5i
X-Google-Smtp-Source: AGHT+IGL6rWZU5v103N0xcbcUzq2l0nfavM24hYp0Ft0qdPxvPUH9Pfo6QzVp+PC4QsbaCA/ecx9XWSzUb/uCr9Bg04=
X-Received: by 2002:a05:6402:b6f:b0:55c:e4da:760d with SMTP id
 cb15-20020a0564020b6f00b0055ce4da760dmr48283edb.1.1706230835791; Thu, 25 Jan
 2024 17:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151358.2147066-1-nikunj@amd.com> <8cd3e742-2103-44b4-8ccf-92acda960245@amd.com>
In-Reply-To: <8cd3e742-2103-44b4-8ccf-92acda960245@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Thu, 25 Jan 2024 17:00:22 -0800
Message-ID: <CAAH4kHZ8TWbWtf2_2DjEQosO8M08wD-EvaEsBKrXmPUaiFg+ug@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Add Secure TSC support for SNP guests
To: nikunj@amd.com
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, x86@kernel.org, 
	kvm@vger.kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, seanjc@google.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:08=E2=80=AFPM Nikunj A. Dadhania <nikunj@amd.com=
> wrote:
>
> On 12/20/2023 8:43 PM, Nikunj A Dadhania wrote:
> > Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as t=
he
> > parameters being used cannot be changed by hypervisor once the guest is
> > launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".
> >
> > During the boot-up of the secondary cpus, SecureTSC enabled guests need=
 to
> > query TSC info from AMD Security Processor. This communication channel =
is
> > encrypted between the AMD Security Processor and the guest, the hypervi=
sor
> > is just the conduit to deliver the guest messages to the AMD Security
> > Processor. Each message is protected with an AEAD (AES-256 GCM). See "S=
EV
> > Secure Nested Paging Firmware ABI Specification" document (currently at
> > https://www.amd.com/system/files/TechDocs/56860.pdf) section "TSC Info"
> >
> > Use a minimal GCM library to encrypt/decrypt SNP Guest messages to
> > communicate with the AMD Security Processor which is available at early
> > boot.
> >
> > SEV-guest driver has the implementation for guest and AMD Security
> > Processor communication. As the TSC_INFO needs to be initialized during
> > early boot before smp cpus are started, move most of the sev-guest driv=
er
> > code to kernel/sev.c and provide well defined APIs to the sev-guest dri=
ver
> > to use the interface to avoid code-duplication.
> >
> > Patches:
> > 01-08: Preparation and movement of sev-guest driver code
> > 09-16: SecureTSC enablement patches.
> >
> > Testing SecureTSC
> > -----------------
> >
> > SecureTSC hypervisor patches based on top of SEV-SNP Guest MEMFD series=
:
> > https://github.com/nikunjad/linux/tree/snp-host-latest-securetsc_v5
> >
> > QEMU changes:
> > https://github.com/nikunjad/qemu/tree/snp_securetsc_v5
> >
> > QEMU commandline SEV-SNP-UPM with SecureTSC:
> >
> >   qemu-system-x86_64 -cpu EPYC-Milan-v2,+secure-tsc,+invtsc -smp 4 \
> >     -object memory-backend-memfd-private,id=3Dram1,size=3D1G,share=3Dtr=
ue \
> >     -object sev-snp-guest,id=3Dsev0,cbitpos=3D51,reduced-phys-bits=3D1,=
secure-tsc=3Don \
> >     -machine q35,confidential-guest-support=3Dsev0,memory-backend=3Dram=
1,kvm-type=3Dsnp \
> >     ...
> >
> > Changelog:
> > ----------
> > v7:
> > * Drop mutex from the snp_dev and add snp_guest_cmd_{lock,unlock} API
> > * Added comments for secrets page failure
> > * Added define for maximum supported VMPCK
> > * Updated comments why sev_status is used directly instead of
> >   cpu_feature_enabled()
>
> A gentle reminder.
>

From the Google testing side of things, we may not get to this for
another while.

> Regards
> Nikunj
>


--=20
-Dionna Glaze, PhD (she/her)

