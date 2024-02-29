Return-Path: <linux-kernel+bounces-86511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331886C65F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B1EB28747
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9F64CD4;
	Thu, 29 Feb 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUXiIc1z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DA64CF8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201103; cv=none; b=ExHq1Hn1+EYRdyzQn96lvpJdrR6vccDIIiuhqKJ/bEZakbEw7g8Vby5PwdqFI0lbZ074xwtz2Hs8YOVJHdBjcwXIZZqp4QV+F3Wvh4f004bkxO9kH9JF9LD7gq4ivbFZSVUOmWxIYZ3dWTn6A1kSy3HHPvR9CyhSCVY7i9ZUWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201103; c=relaxed/simple;
	bh=mJH7T3GHhmEkUgCax6VHAFCiu4bKdmthZt48XtrJvYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlAhLVGPS2ivRbh+ukkbRfYwtNboNWRA+a0n82Mv9ltKhHmd6L9giHPFccJ00nSXKD8emmnl4wjd/nUrhighe85bOH8pSJrdi2nycepWHJotJDCmjbqG4kTd+fdh1Z8lMfMpobuG3sptoOqb6tamlkqXKmTTDQkuFS0k1flenQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUXiIc1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709201100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFCpQPrTkjVx77y9FbZCVOAeK53WZkOEyY2EC3PXW0Y=;
	b=SUXiIc1zADR+ChQsDVlx54KCu3BKeA3wHRphF9XPcNDyr43A7pboICiHfE7T4iEw74Tko3
	yNwZ7tYfUgchCzH1IHHV1IJBCB2NSYJ9ncTCaTi4MCyRNgMYibLXfNnbJCtzb2HUACvlhT
	tIUddQ/s3cTkQcZtoaB++lN7I1gDliM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Giz8PA8GMqeLT962l-HB-A-1; Thu, 29 Feb 2024 05:04:59 -0500
X-MC-Unique: Giz8PA8GMqeLT962l-HB-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d5e12bbbdso521814f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201098; x=1709805898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFCpQPrTkjVx77y9FbZCVOAeK53WZkOEyY2EC3PXW0Y=;
        b=ilRoa3RRUmC27KBskQfdnHDQKwVW7PbnmBRPxmfBbsoZrkvnuFYuTqEBFbW7bt5EoV
         lqJ+6wo31F7+8/cZTC3ieW+LiX5mF8r8P21a1P9dsadn9D1SFRjPtMzMoCoy2K9Q9f5M
         U1SFaxVAtBWMshS8KdnZlBXqwk0sWOujM9GDXiP3QuSTiuphDF2Y7I5ufiq6R4JyJq+1
         2FIxXIGwIdbHU5CNj9P+Z8nkhgt8Jc7lf9lQe8rTJoMkq5SrZn8PO2mnN7nG68GjTuBj
         GgF2i6cTGI84jBia6h6BlTFxTPYXvpTznJwAclTMAyFrDAEr8dPI/JJf1I0Lp/sybXAX
         wH7w==
X-Forwarded-Encrypted: i=1; AJvYcCVUi1g1zpoPLrWFnUS1DTQr/xl8E/kdzDjdfDLY9xwO3UAPwH0MnIr4QlHWKaJ9w6QR7h21U4q2rRUNGbjFL2hb4GHmylY5fsnQgvqU
X-Gm-Message-State: AOJu0YzwScraytIQO2JYhH7jaHGUTLEWCPDTUgq14pIeEO1PetVdf9B8
	JczoQfwILmWHPYKPgKJvWQZPGsNRZXKi/CNQVwIeiM5YfYnAJhxU/D3GHFkJHsPnBmDadQuMyBj
	uElzmkVV7ocXHmlklEJm0dC9bKZzdRGlY8JOH0jrWTFRR3Gju22DJBrhWLvv8vChYKlugcL1aAS
	RbYu+rl/GbQDtNuiRfEdzZ+sqRtMr6ubaRGmWa
X-Received: by 2002:adf:ef03:0:b0:33b:784c:276e with SMTP id e3-20020adfef03000000b0033b784c276emr1025130wro.25.1709201098196;
        Thu, 29 Feb 2024 02:04:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVQghsQXIC4avUjIa45ZpxqXLw07aC63ABv1OLNHKr5AAr7XCmN+5e1UkrNR4sIYwoHhANxACUuLsQnEF9TKc=
X-Received: by 2002:adf:ef03:0:b0:33b:784c:276e with SMTP id
 e3-20020adfef03000000b0033b784c276emr1025118wro.25.1709201097850; Thu, 29 Feb
 2024 02:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022822-CVE-2021-46978-3516@gregkh> <54595439-1dbf-4c3c-b007-428576506928@redhat.com>
 <2024022905-barrette-lividly-c312@gregkh>
In-Reply-To: <2024022905-barrette-lividly-c312@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Feb 2024 11:04:45 +0100
Message-ID: <CABgObfZ+bMOac-yf2v6jD+s0-_RXACY3ApDknC2FnTmmgDXEug@mail.gmail.com>
Subject: Re: CVE-2021-46978: KVM: nVMX: Always make an attempt to map eVMCS
 after migration
To: Greg KH <gregkh@kernel.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, 
	KVM list <kvm@vger.kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:21=E2=80=AFAM Greg KH <gregkh@kernel.org> wrote:
>
> On Wed, Feb 28, 2024 at 11:09:50PM +0100, Paolo Bonzini wrote:
> > On 2/28/24 09:14, Greg Kroah-Hartman wrote:
> > > From: gregkh@kernel.org
> > >
> > > Description
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >
> > > KVM: nVMX: Always make an attempt to map eVMCS after migration
> >
> > How does this break the confidentiality, integrity or availability of t=
he
> > host kernel?  It's a fix for a failure to restart the guest after migra=
tion.
> > Vitaly can confirm.
>
> It's a fix for the availability of the guest kernel, which now can not
> boot properly, right?  That's why this was selected.  If this is not
> correct, I will be glad to revoke this.

To expand on what Vitaly touched, guest availability based on host
action is generally not considered part of the threat model (not even
by the newfangled confidential computing stuff). If you want to stop a
guest, run "virsh pause" or kill -9. Add load to the host until the
guest reports a lockup. dd if=3D/dev/random to their disk. Or if you
need to bypass SELinux, just turn off the host---in CVSS parlance,
that would be a valid attack on an "adjacent" machine, but nobody
treats it as such and the reason should be obvious.

Yes, there can be mitigations but let's say that "orchestrate a fake
migration so that the guest fails to restart on the destination" is
fairly down on the checklsit.

> > Apparently the authority to "dispute or modify an assigned CVE lies sol=
ely
> > with the maintainers", but we don't have the authority to tell you in
> > advance that a CVE is crap, so please consider this vulnerability to be
> > disputed.
>
> Great, but again, not allowing the guest kernel to boot again feels like
> an "availability" issue to me.  If not, we can revoke this.
>
> > Unlike what we discussed last week:
> >
> > - the KVM list is not CC'd so whoever sees this reply will have to find=
 the
> > original message on their own
>
> Adding a cc: to the subsystem mailing list for the CVEs involved can be
> done, but would it really help much?

Yes, it would give a heads up like you do for stable patches roundup.

> > - there is no list gathering all the discussions/complaints about these
> > CVEs, since I cannot reply to linux-cve-announce@vger.kernel.org.
>
> That's what lkml is for, and is why the "Reply-to:" is set on the
> linux-cve-announce emails.  Creating yet-another-list isn't really going
> to help much.

So why do we have subsystem lists at all? It helps people that have
interest in proposing and gathering CVE disputes, providing an easy
way to do so; just like subsystem mailing lists people that are
interested in USB or virtualization patches. It helps searching for
all messages related to a CVE by not splitting them between
linux-cve-announce and lkml, too.

Also, LKML does not get the initial announcement, which makes it a bit
more painful to find the full discussion on lore (you have to go
through a "no message with that id, maybe you mean this one from other
mailing lists" page, instead of having the whole thread in the same
place). A linux-cve mailing list with public posting, used for Cc and
Reply-to of the initial message, would solve this issue as well.

Paolo


