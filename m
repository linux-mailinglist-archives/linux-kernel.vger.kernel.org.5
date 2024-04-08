Return-Path: <linux-kernel+bounces-135841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F189CBFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CD9B25FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148B1448FA;
	Mon,  8 Apr 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkgfv8f1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA7433BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602304; cv=none; b=gX0s/DygNCTqZb+haGJV3oHQdb9YTStI/XSqF84/3M1pd2QfG/6r/tuGWRXFvOPndDfjQBAihlH1UbtRu/A4KAweWMnaCymwp2fDN4e5P7BOjKrcF7TYzs3qm/GIaGXsq5e24m7BrWrhPCYxYN7LFdj0C2dyHmravUFM95p1BUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602304; c=relaxed/simple;
	bh=1avNKwwiDh2vBNJhsj9DLMz82UH9nkJvd8D2qwe1iNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mNAsO5uIRug3E2faONYAQNIRgMN0yRGIohWjPSq4v0ZQ6pkPDm3fj5QG2xvzc/tmCyQC0r9QxDwaant4rzvjSPDCz5tlwNnom8kqdvIiOCfPx2gt9j/Zez1ilmeOb7vhve8tO57Pto+Tx0ANk894ykD5U5dtDUkJJVlzFhj8QkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkgfv8f1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ea80a33cf6so4517780b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712602302; x=1713207102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/yxqBlI0VvymlOKCCFzRFh5RuQygtpsmmsY/Zf5/fk=;
        b=mkgfv8f1ZcVD+rulw1XTRN+v6MRGD+CSUANg1HuiMZJdNAG/2KOBJTQI/H+hsCVxbJ
         d5n1iw1LVe9AMotlz9xq8ilYNmj/RKjF85zKgT8XAvKPxsB9YV7C9Y1mYHr/2kd4DAhL
         FtZ5KsAz3eRacd3vyvpi4ZdNa4quxRJARUul0587QsikT25qxMn7wvDbBB15lUKIEE6U
         2DCCJap6C43LeREEEnCMxT4XHKpPrgyycGeOP/7EcWUJvRayRHHMjIBabyPx8+4J+8my
         esC7SYdssZ8a0eEG7JVX2klK8LWh26fRqWbLoa0Mu/x2SvXAnR3OrIoe71TUzVOi2duH
         //Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602302; x=1713207102;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K/yxqBlI0VvymlOKCCFzRFh5RuQygtpsmmsY/Zf5/fk=;
        b=KJz9wTVa92ftdsCfkIad8WM7kg00Lv1i7Y+3wNMJpbE7SSstHZ4thtpmWIRP7ztiSJ
         O3OBqhifRnDMPac4Kz2xlzELbSmVjQ4RC6t+fbc0tu/HmN4V/kAn43gqQ3JYm0GOUOKU
         VJ8Eyuymu5Ndr0lQlVzAwAs40pmnfyEF13GlHj5jAMi4P9rch0AdQlglCLuYMuu9dQoV
         KkI47jhsDSTQL9tWVom3YaJyn4TwfGZu61ynr1H0rbCRQfOLTj1LcCODbKxC2SQgkry9
         t6fpCn9xUzBjwnRX0EbWq3RvJT46nCYcC/OrJ2gi7s0CXDxOpEXT1AvTU7VlwKsij7aw
         8QZg==
X-Forwarded-Encrypted: i=1; AJvYcCXuWHe5YtOdU582vRaaCiUUbd2qJUtUmin1hGk6ShstpuLsgjCcuhwk1snnDh82kHa2ODC+7dBeoIAE0YizDMEHU+KynwQoCFT7Iiz8
X-Gm-Message-State: AOJu0YzKXU+e3pIQtKuKiQnqzS+1Bio3fH+3PNXxmumUMqG8RO0WE3wD
	YxVgBN51olEfmv2O/qvZgqGQ601sL69O2QmTj73BaDHLFlLu3Xip+t8V6c2d4scfXgWrEeybEKu
	Z9A==
X-Google-Smtp-Source: AGHT+IFIZ89r2xcZjl3lX5o7HwjptwKZXoT6ylwgH1ZLbk5qUwIUkSMLXCRpN/p40yyWtCdfKVhhiE6ZYuM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9288:b0:6ea:b999:4de1 with SMTP id
 jw8-20020a056a00928800b006eab9994de1mr1150525pfb.5.1712602302196; Mon, 08 Apr
 2024 11:51:42 -0700 (PDT)
Date: Mon, 8 Apr 2024 18:51:40 +0000
In-Reply-To: <a17c6f2a3b3fc6953eb64a0c181b947e28bb1de9.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405165844.1018872-1-seanjc@google.com> <73b40363-1063-4cb3-b744-9c90bae900b5@intel.com>
 <ZhQZYzkDPMxXe2RN@google.com> <a17c6f2a3b3fc6953eb64a0c181b947e28bb1de9.camel@intel.com>
Message-ID: <ZhQ8UCf40UeGyfE_@google.com>
Subject: Re: [ANNOUNCE] PUCK Notes - 2024.04.03 - TDX Upstreaming Strategy
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, 
	"davidskidmore@google.com" <davidskidmore@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "srutherford@google.com" <srutherford@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei Wang <wei.w.wang@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024, Edgecombe, Rick P wrote:
> On Mon, 2024-04-08 at 09:20 -0700, Sean Christopherson wrote:
> > > Another option is that, KVM doesn't allow userspace to configure
> > > CPUID(0x8000_0008).EAX[7:0]. Instead, it provides a gpaw field in str=
uct
> > > kvm_tdx_init_vm for userspace to configure directly.
> > >=20
> > > What do you prefer?
> >=20
> > Hmm, neither.=C2=A0 I think the best approach is to build on Gerd's ser=
ies to have KVM
> > select 4-level vs. 5-level based on the enumerated guest.MAXPHYADDR, no=
t on
> > host.MAXPHYADDR.
>=20
> So then GPAW would be coded to basically best fit the supported guest.MAX=
PHYADDR within KVM. QEMU
> could look at the supported guest.MAXPHYADDR and use matching logic to de=
termine GPAW.

Off topic, any chance I can bribe/convince you to wrap your email replies c=
loser
to 80 chars, not 100?  Yeah, checkpath no longer complains when code exceed=
s 80
chars, but my brain is so well trained for 80 that it actually slows me dow=
n a
bit when reading mails that are wrapped at 100 chars.

> Or are you suggesting that KVM should look at the value of CPUID(0X8000_0=
008).eax[23:16] passed from
> userspace?

This.  Note, my pseudo-patch incorrectly looked at bits 15:8, that was just=
 me
trying to go off memory.

> I'm not following the code examples involving struct kvm_vcpu. Since TDX
> configures these at a VM level, there isn't a vcpu.

Ah, I take it GPAW is a VM-scope knob?  I forget where we ended up with the=
 ordering
of TDX commands vs. creating vCPUs.  Does KVM allow creating vCPU structure=
s in
advance of the TDX INIT call?  If so, the least awful solution might be to =
use
vCPU0's CPUID.

