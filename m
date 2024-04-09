Return-Path: <linux-kernel+bounces-137092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0689DC47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D094D285466
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AC132803;
	Tue,  9 Apr 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2wSbiTb"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A57131BC8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672903; cv=none; b=cc2PeiOjarCZI3jqDJvkDdi5cNrEU1HpBs1dfKdMvaKnLfPtMyrypfg3UJaxSXk790/wLUU5gtJ5TLBqK+kniGkB4rUV11pYKBPubw7nYytikE1UQZNH7u86bcUtWrHC4nmUTO/OimUVQfdOnebZLjMp2waRgltF41FZcCryl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672903; c=relaxed/simple;
	bh=ecBCK7Lu8Ggx22af5hT7SSOBxD7jfhbMXuI5duWZMj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oK2wRCosO2Ru4CjQpE0gGQ1nUgTfLobrhKgB6EwQeziar8SyultQSb1yNB65Y7jSRMxcrRL/v65j7TL4MwSIsVRZNKWL5RLOq4FS2hIr8vBPdb3XqxsG6zPN7bO3TDFhWJiUAFEahHWI75WHaO5rDB7d9APn4+1EBsH0Y/kZcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2wSbiTb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso3548345a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712672901; x=1713277701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OFqgZamFtP31b7OyDpspDBZgnDXmW9Vk3TX0d8nfJ8=;
        b=c2wSbiTbkVfr6C/UDIdUAoVCrVKIT5i5H3BLhhUkNR7fp/MGnAbKe3JHBXL+acdlKD
         7k902W0fXqg/8bpOrUSy6HZytouhfj6u0wdY+brM65UtaOY90Nndn5nDroXdJrAFVMTD
         SomSZIFf5r4KyOdSarvgGwat3bG4zLqsUBstDD1NTDfALSa+asvRjkI4PJ8pOgh+K17n
         NkEwBnYadtB8gWUQFRXEUL8vhAqywX72ge9JAiykPn6zBY97zcKYZnmz1LjJIqFvbLy5
         CPyhMPN3EuqgnbuZr6Wjno5MXLIFv6jqUndowLbpWIagU2yJcqiHyTqWLizspG8oPtvo
         piRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672901; x=1713277701;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OFqgZamFtP31b7OyDpspDBZgnDXmW9Vk3TX0d8nfJ8=;
        b=WWqCCHFcXsmP7R268PP5bnIE9z3nmKoyh3BUA4rQ0DeAOWv8J602HyMZo3BGUe/gVz
         nkC+sfrpprd7bp283QYPqvL4ljrR2UguNFnxGFwwt4qKi6KVWXPcmqaMYkeQJaQoWyt0
         pQ/UG9Dx88kVvC8nO10FT9JuT8LXBv0Sl+0L+zQQ7z36N89FpkKcwJOKJ5QT7ZTeFBFv
         I13cdxPZLJ/E6bzKB+CsapAsERPv1Gxso82OMPM32E8u0djs8dcanoJAkaoTCecml8LP
         JRsSSFip4Easo2wYNPShFC0Ip4jV27Tdfml4DFeKZCUNFpH54DQSVEePhY9cw2r8mtiT
         j7HA==
X-Forwarded-Encrypted: i=1; AJvYcCW/81JDazTBMYubsAR5bddA8Mu7VQmeK7sFqjSJ3AT+5MO4vPV1Zu8Ik70BTNXlSgnmxU9dFepv+EcGEcz7BSxMXcDrcNbq0YxAOei3
X-Gm-Message-State: AOJu0YxCc5VQA0KqkSxDK8Xk1dkV2PiWBff7YzZfiMmXRNdxzCjqZtOY
	XxAOd9Slg+um1EKfafXWEC013EjS4EzWi3/mcz+79mcth/RsLqnbQ56UhZptSoaXRJP1KYkOrHt
	rCA==
X-Google-Smtp-Source: AGHT+IEj2tDswqkoTxI0ITyJen86BjJMQ6z5RDGHO6n0k7oyToaidiE0MSXY8NfDznJNMlCpVlKjPHFccGs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:581e:0:b0:5dc:1099:957f with SMTP id
 m30-20020a63581e000000b005dc1099957fmr36132pgb.4.1712672901358; Tue, 09 Apr
 2024 07:28:21 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:28:19 +0000
In-Reply-To: <19db06082aff01540819d86d4ca839446c967db7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320001542.3203871-1-seanjc@google.com> <ecaf87b40d6da2ca39a5eaf94d2efded2ae3368c.camel@infradead.org>
 <ZhR74WgWxO4MQcbl@google.com> <19db06082aff01540819d86d4ca839446c967db7.camel@infradead.org>
Message-ID: <ZhVQg8mKr2VIQptT@google.com>
Subject: Re: [PATCH 0/3] KVM: Fix for a mostly benign gpc WARN
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com, 
	Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024, David Woodhouse wrote:
> On Mon, 2024-04-08 at 16:21 -0700, Sean Christopherson wrote:
> > On Fri, Mar 22, 2024, David Woodhouse wrote:
> > > On Tue, 2024-03-19 at 17:15 -0700, Sean Christopherson wrote:
> > > > Fix a bug found by syzkaller, thanks to a new WARN sanity check, wh=
ere KVM
> > > > marks a gfn_to_pfn_cache as active without actually setting gpc->gp=
a or any
> > > > other metadata.=C2=A0 On top, harden against _directly_ setting gpc=
->gpa to KVM's
> > > > magic INVALID_GPA, which would also fail the sanity check.
> > > >=20
> > > > Sean Christopherson (3):
> > > > =C2=A0 KVM: Add helpers to consolidate gfn_to_pfn_cache's page spli=
t check
> > > > =C2=A0 KVM: Check validity of offset+length of gfn_to_pfn_cache pri=
or to
> > > > =C2=A0=C2=A0=C2=A0 activation
> > > > =C2=A0 KVM: Explicitly disallow activatating a gfn_to_pfn_cache wit=
h
> > > > =C2=A0=C2=A0=C2=A0 INVALID_GPA
> > >=20
> > > It looks like these conflict with
> > > https://lore.kernel.org/kvm/20240227115648.3104-9-dwmw2@infradead.org=
/
> > >=20
> > > Want to arrange them to come after it?
> >=20
> > Very belated, yes.=C2=A0 Though by the time you read this, they should =
be in
> > kvm-x86/next.
>=20
> Did that 'yes' mean 'no'? Because your three patches are in, but you
> didn't arrange them to come after my 'clean up rwlock abuse' patch, as
> you seemed to be saying 'yes' to...

Doh, I misread your question, multiple times.  I thought you were asking if=
 I
wanted you to arrange your patches after this series.

Your series goes on top because I want to land this series in 6.9 to fix th=
e
syzkaller splat (which was effectively introduced in 6.9), whereas your pat=
ch is
6.10 material.

