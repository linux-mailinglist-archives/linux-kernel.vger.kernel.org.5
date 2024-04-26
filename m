Return-Path: <linux-kernel+bounces-160329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71928B3C09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21CAB2512A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB31514C0;
	Fri, 26 Apr 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p50eQb72"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681A149C7B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146452; cv=none; b=iB9KBrHGIdEtcC8SFkeb7eoIeIRhu4heuYgyHbZV++vU88ZSKLr4S3zom7wF/uJ7V5SP/vkMlzliDi/hFtOfOPc5FW4l2iddSAzRsQTxyZM0GLSYqf43vKJ6gyGNSRBp+yF5g85uuQzbLYe7dqifmgn4bHwB/Ck+3i2uJADB5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146452; c=relaxed/simple;
	bh=3kv3W8HCdfkaWDUxqPPBqvTTgtgtiGVVw92b0grhvFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ep2ZR1DaqaDXNYaKm1tffaazOO6l/PtlvkQezIh5gFxOLqr1VpzgdqB13EDFYHH1g02/JqZ0LQQ20V428+MHdmWj9U9CrKSuz81SmqjZReaxYSbqp9iGb+rcBLkv31bPZKmQzDgmoiDmdY8EQPGbqXMFhslqQ/iWy7/acn/ZTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p50eQb72; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b028ae5easo41020527b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714146450; x=1714751250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2E9JoSWwd8nVZWjHSk8NyMAJBnorcWNH5AMDyGnL6Dw=;
        b=p50eQb72zDQe3QRayW0+C1Ticmi/NdxCzcJCY5/hrodEeFBl+nZhLXVr8EfXMxEcMv
         EY+AlQiLXXmKysYjTli68C8Nwhbi3prP4ROIL494mOWr3xBCAnr+oT12gvy1JJUipSjH
         3Z+9aBX7LlUKhk0+29mcJPhjbZEOXAjOGHkaRi4TfmOtRU7GH+1XTG6AnQx48Na0QkDk
         FEt1LhyRyCQkuNIEbE3Ql49UpO0bCSVYrA0UW/JOjtoTdx2exTmcVA7CGoD6Ok/QSDtH
         GHg84hbm+Pjv+fmWtiBXAVokL+tPNCXPIMZ+Sjnfqv/y6muuJlTxVOfuE9iMnazqmrR5
         a9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146450; x=1714751250;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2E9JoSWwd8nVZWjHSk8NyMAJBnorcWNH5AMDyGnL6Dw=;
        b=AHNEut1IjA7xzQ3K8Jv+it+SWd4amrvx3aW0meg2UbpFpYECg1d1Vw9wggydchQYDM
         DSJtz5N6I+ndFbFG1QEV5hbytSLidpBtfh6Fs90KHjlsQxMoZpzc9to/u5Ow2IWxFi2H
         pkvdY+3Hk3AMNyO4hKbq0K0IvqH0mm9ZiOc70HhIXsLIrQ0LST2jUJeu1+b2Odc0+ELa
         ayjMXmT+VipGOAY7hzs2halKbYeKMZPHBGUQ2T0iQMqBNhcwY3EDclnwCZEb+U1lbMh3
         cf9SBMCAX9GVM+45aHfN937bGUA5bXfzvZLLtFFcZShV0DTzaR3TyQQdzJMcunSNwZXp
         +VIA==
X-Forwarded-Encrypted: i=1; AJvYcCUGsXP5EhVwJFG9XNL4UwVJDJc6VnrCmsQO2aIGSVpl/lAFqkw8oR7ynPMAOukDv6L9MFdymZz2eq79af0+D5K0+lyVP3YGZuXuLguM
X-Gm-Message-State: AOJu0Yw9O0sRXTG2dbMjJtmeCDoPXgGpuUzwAABBeDfNNc82TcPl8dzg
	OkanMS3KrGKmcWaWtaxhf2/4TmAMHZDPiJv7F2nddZEp162/3X5XMx8NGuAx+3ubaPPT2wSj446
	uMA==
X-Google-Smtp-Source: AGHT+IF3FSBZIrw+Ee5KLhA7Zd1dn/48qyZF8Ne2lnAcIov1+3/MDN/HY98TTWsNvj3V2JUe1s1WrbhQb1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:df44:0:b0:615:e53:1c1 with SMTP id
 i65-20020a0ddf44000000b006150e5301c1mr675860ywe.7.1714146450107; Fri, 26 Apr
 2024 08:47:30 -0700 (PDT)
Date: Fri, 26 Apr 2024 08:47:28 -0700
In-Reply-To: <7f3001de041334b5c196b5436680473786a21816.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423165328.2853870-1-seanjc@google.com> <4a66f882-12bf-4a07-a80a-a1600e89a103@intel.com>
 <ZippEkpjrEsGh5mj@google.com> <7f3001de041334b5c196b5436680473786a21816.camel@intel.com>
Message-ID: <ZivMkK5PJbCQXnw2@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fix supported VM_TYPES caps
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024, Kai Huang wrote:
> On Thu, 2024-04-25 at 07:30 -0700, Sean Christopherson wrote:
> > On Thu, Apr 25, 2024, Xiaoyao Li wrote:
> > > On 4/24/2024 12:53 AM, Sean Christopherson wrote:
> > > > Fix a goof where KVM fails to re-initialize the set of supported VM=
 types,
> > > > resulting in KVM overreporting the set of supported types when a ve=
ndor
> > > > module is reloaded with incompatible settings.  E.g. unload kvm-int=
el.ko,
> > > > reload with ept=3D0, and KVM will incorrectly treat SW_PROTECTED_VM=
 as
> > > > supported.
> > >=20
> > > Hah, this reminds me of the bug of msrs_to_save[] and etc.
> > >=20
> > >    7a5ee6edb42e ("KVM: X86: Fix initialization of MSR lists")
> >=20
> > Yeah, and we had the same bug with allow_smaller_maxphyaddr
> >=20
> >   88213da23514 ("kvm: x86: disable the narrow guest module parameter on=
 unload")
> >=20
> > If the side effects of linking kvm.ko into kvm-{amd,intel}.ko weren't s=
o painful
> > for userspace,=C2=A0
> >=20
>=20
> Do we have any real side effects for _userspace_ here?

kvm.ko ceasing to exist, and "everything" being tied to the vendor module i=
s the
big problem.  E.g. params from the kernel command line for kvm.??? will bec=
ome
ineffective, etc.  Some of that can be handled in the kernel, e.g. KVM can =
create
a sysfs symlink so that the accesses through sysfs continue to work, but AF=
AIK
params don't supporting such aliasing/links.

I don't think there are any deal breakers, but I don't expect it to Just Wo=
rk either.

