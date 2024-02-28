Return-Path: <linux-kernel+bounces-85667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4986B8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC397287425
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45374433;
	Wed, 28 Feb 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbjIdgmK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131C74412
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151458; cv=none; b=U0y83HCnBlUJ7vKqSKxmgL2TxHaGQpzwRUZxiRuliUh9Y3rCUkLA5SF4bvfHnGJt5FhFkjo7XOmHzcvdRgMOlFsP5JWOSyRHu6Wk7aFfwmCEozyVep+nWTBoyBLeLjZ78i8FgdHlFOfv28QufbO46RUB5EinhyHyguEnrwRabdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151458; c=relaxed/simple;
	bh=zCE3KeML9YfIVCAxmwUQkF435x0sQK0jWupf7a2rdBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxXiztmn1TOK+vroUwpBpuMlIYC6jPVYXtfIOEbV3Qr/qYKMBjXxt/Y6FTBC6LMmECFyFXaFljoYObFrOcI7RXRtDU4y0bOpB5jaSIX/DdxqlUvxWwLASCabXrYkBBNXxW092DcTr8dWu1eynIlNx9pD7dZty57UHmCS0Ltv81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbjIdgmK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709151455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTw4ZSIJXGsiLChjCX2qkr5AsU1DzHE1V0dnP5D7DIs=;
	b=RbjIdgmKGQhvEPEWaKdN/EiyzbbP/fhxBy1XcnCnEK7OlkZLx7tyBY3q2x/FJLoUX5S5i6
	nKR1UlpW7nxT6q8XVIxrTdUhhf69H6O2xFYfxFHibkO4WC46W0ov+NINhbwUE/45U5gOX5
	MwxzCooZf9Yqys+grKlluZNmAcDDGB0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-H1T2Qhr3OnmTdHa-0gkGzg-1; Wed, 28 Feb 2024 15:17:33 -0500
X-MC-Unique: H1T2Qhr3OnmTdHa-0gkGzg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d07c0825aso65991f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151452; x=1709756252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTw4ZSIJXGsiLChjCX2qkr5AsU1DzHE1V0dnP5D7DIs=;
        b=FO7EyezZ4GCfKUAv+Gz+aT0NxzXMFs3ixcCHuDr1+zX+VJCTXd2NNliIzB2q+WV8Ci
         x6nesLGhDGW8ta51WZ1yD2pYpbmE1MqH7xvm3gavMvCFNQUt5fPfY37RB61rKWtwfWjB
         D6LMik62UxMfXOTVAZ8/HuoZe5XBSNlVOXnEkcVgjofIFEfbaR0mm+ydXm5nM8q0m7NK
         npaQgg1a7Q6KKkHiZvg0fBp3hc3aZwlX35GgPCQjGnK5Z7DRKzOCog1d9lZKxK85WNZT
         WaIBp2JBMbqk5+yLQX0vb1Hl/x1ZbczLpFI7uuFlXqqFD/5Z8cciz9ETzhKmmAd0GPbw
         ITNw==
X-Forwarded-Encrypted: i=1; AJvYcCUY8Ecrar6n1OIIPe53bsggjWw+rKqmE4o5+ckOFe9WqrrdLwmqH627YPiLPh81GZsgrgMFQl6+Fl2EA/VG6nOV163xaMVZMYICGOJT
X-Gm-Message-State: AOJu0Yyue7+HyynD+m0CoL0F3lUioQC0NN+NvC/fu7eUivbCv/c7PMWe
	ak17Ub4Km4mzroTEW8iQEKvL4SAxSLyxVRnwRTw4oGn/Qzvr5Akri8/CZMqEUCEMZdi/UJBZja5
	NcMRbQxk60zaFazUAYVRx9hmUS4vDlAeKsRmrKai6+gl4wnJrofN8twE9n8HnheoOQxhuIZOFy6
	q+swlYGTYfbzMTr7ubHTG92PN/1+wrnhrJtFGn
X-Received: by 2002:a5d:4b0a:0:b0:33d:afbc:6c85 with SMTP id v10-20020a5d4b0a000000b0033dafbc6c85mr461057wrq.8.1709151452252;
        Wed, 28 Feb 2024 12:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgHPzGN/DHFe4puI/8ysLIKlvcEuBiVtnUT6JuEjxUXY4Ozjp/ZzTMdzcpsSTIbMTP4PxKulnZgiPsoMvTHxg=
X-Received: by 2002:a5d:4b0a:0:b0:33d:afbc:6c85 with SMTP id
 v10-20020a5d4b0a000000b0033dafbc6c85mr461045wrq.8.1709151451975; Wed, 28 Feb
 2024 12:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-18-pbonzini@redhat.com>
 <Zd6W-aLnovAI1FL3@google.com> <CAJD7tkapC6es9qjaOf=SmE9XYUdbh_fAperjSe9hy=_iqdB0wQ@mail.gmail.com>
 <Zd8x3w2mwyAufKvm@casper.infradead.org> <CABgObfZ9LFDrtLkMaT5LVwy0Z2QMk6SqJ104+D=w7o9i0gEu+g@mail.gmail.com>
 <Zd-Icopo09aUmOvT@casper.infradead.org>
In-Reply-To: <Zd-Icopo09aUmOvT@casper.infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 21:17:19 +0100
Message-ID: <CABgObfZApRALa0AEWRDTY_Qc3bFVe25mVph2R1JaUBhqJ8eabg@mail.gmail.com>
Subject: Re: [PATCH 17/21] filemap: add FGP_CREAT_ONLY
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 28, 2024 at 02:28:45PM +0100, Paolo Bonzini wrote:
> > Since you're here: KVM would like to add a ioctl to encrypt and
> > install a page into guest_memfd, in preparation for launching an
> > encrypted guest. For this API we want to rule out the possibility of
> > overwriting a page that is already in the guest_memfd's filemap,
> > therefore this API would pass FGP_CREAT_ONLY|FGP_CREAT
> > into__filemap_get_folio. Do you think this is bogus...
>
> Would it work to start out by either asserting the memfd is empty of
> pages, or by evicting any existing pages?  Both those seem nicer than
> starting, realising you've got some unencrypted memory and aborting.

Unfortunately it would be quite ugly to force userspace to do all the
initialization in one go. For example, there are different kinds of
pages that probably would be initialized at different points (e.g.
before vs. after vCPUs are created, because the initial vCPU state is
also encrypted).

The thing that I want to protect against is userspace trying to
initialize the same encrypted page twice.

> > > This looks bogus to me, and if it's not bogus, it's incomplete.
> >
> > ... or if not, what incompleteness can you spot?
>
> The part where we race another caller passing FGP_CREAT_ONLY and one gets
> an EEXIST back from filemap_add_folio().  Maybe that's not something
> that can happen in your use case, but it's at least semantics that
> need documenting.

From the point of view of filemap_add_folio(), one of the racers wins
and one fails. It doesn't matter to filemap.c if the missing
synchronization is in the kernel or in userspace. In the case of KVM,
the ioctl will return the number of pages before it found an existing
page, or -EEXIST if that number is zero (similar to what nonblocking
read does with EAGAIN).

I'll improve the documentation and changelog and make sure to Cc you
on the next version.

Thanks again!

Paolo


