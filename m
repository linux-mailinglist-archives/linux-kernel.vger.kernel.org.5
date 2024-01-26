Return-Path: <linux-kernel+bounces-40473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979583E117
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09BA1F25B02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F73208D7;
	Fri, 26 Jan 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfkL3rMT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127D208B4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292717; cv=none; b=pLuZOWP8bjyzGgpQOwKyXpANQTwMI3pw9Br74MCz5CC6K7u8aMCYRLBdOF2D2QsTOFmTFwomNlr2pSthYBtw6AENSH1kiVpEyzdurB9PvULSw+jFO8VnnkvuprmfMNtnlR7OZ1fY2KAzpkVJhpXiEi1EgcEt/wG/RzBQAx9NpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292717; c=relaxed/simple;
	bh=LAhg6tS6NsgOJEDjzQ1H66nZrrX2VZPrvnT+rMBSFm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDoCbI4zWuzBYy9/AsFh88YE/yEwLzNMboXdCMa/ERysjVy3vDuod6TNrT3CwveIHsR52fYYzlbQyp5EtssKkp+K1zxSEeBknMQIKz302prEz6aYGNAY+W4KgZxyrx5V/iZ3nCTOkUcHDOCg4JzwCYB555VG6tdKVEMgYg9TvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfkL3rMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706292714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG6onSOxW5WTwWOpHXFWverwBGhD/J43wL8mjF4h6m0=;
	b=HfkL3rMTkaJDYQyIO4CRgJeQrNs5spl//8L0pVeJNlx260DOM987OQMQieQ3D8RlY53387
	b1trKEtGz1bOMz/Uq3AK7SgpTXFFUpxsUWqd6J/xEQy5pPjREt3ynf9Or9mVS6RZv4BDhH
	K8/X3JwMe73hKA8qZI2ptTn5kaAfBr0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-fYrvtt-mP0iKQr8FfxZPbg-1; Fri, 26 Jan 2024 13:11:53 -0500
X-MC-Unique: fYrvtt-mP0iKQr8FfxZPbg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bb9f35fbfcso1068409b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292712; x=1706897512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG6onSOxW5WTwWOpHXFWverwBGhD/J43wL8mjF4h6m0=;
        b=Hce1B7bbsmIZJt3QT1eR+hhS1Zu5aa3xMT9/CtBHmjC0LcTdyJesyws0QyLe4myDyD
         LoTanyachBjyDrO1cDgCwI3KxflWv3r7eUFGQXh2ohUfOY2iynOmU1m9HBk19fWbtDW0
         uoRBYTUqnADK700DJnWyfr3x7sxYYGdGNRtcATsE14cEVwbop+AkI5Hm9jiGhRDxqqYG
         4E45vqNsDdlI4g68xakaDqhsokOeHMNHwsZEl2rT2vmXhHvKOX0o2vH1+zOjOkfhGQ/4
         B/Wtp6SEyzo3/j0+NYQAyEcqqv8SRWKrlvIuOPJ6LiYpsXo612htGeDbYYVni6tnjCo1
         3xSA==
X-Gm-Message-State: AOJu0YzuIImEwKcOyA2HAyoN25kgZxNrOwrQBl7na/YoUzBndTyKTzq/
	s0lDzNazX8TjFK78cCzvqe2dLuPCYzFDadWsr6/UIshx15DSHXxKuIqwbYj8nWtqCwsFeN4oWFw
	940vnOa1vgVeZv4IzGtKltqVL+ql6FiflEfFen5TyMEL/Qspe7ee4muXUDI0yWrxSHHceD7CkW3
	EdLm78cFTkK2xVwksHPR60bSDhA0Xo0kKyPGLJ
X-Received: by 2002:a05:6808:19a7:b0:3bd:e0ba:9851 with SMTP id bj39-20020a05680819a700b003bde0ba9851mr156993oib.30.1706292712250;
        Fri, 26 Jan 2024 10:11:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiFLff6j36/Ab1tXXQQCeW0IAo9c/e1vP7Jgv/bnq5PaDz3DPz7Pm9UGCYE8CoFZAlZ/5HDTeo2SYY7usvdCA=
X-Received: by 2002:a05:6808:19a7:b0:3bd:e0ba:9851 with SMTP id
 bj39-20020a05680819a700b003bde0ba9851mr156988oib.30.1706292712070; Fri, 26
 Jan 2024 10:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbFMXtGmtIMavZKW@google.com> <20240124190158.230-1-moehanabichan@outlook.com>
 <ZbGkZlFmi1war6vq@google.com>
In-Reply-To: <ZbGkZlFmi1war6vq@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:11:40 +0100
Message-ID: <CABgObfZe3JWv=zsVoRwgERNzVYLUet8LpRhj_sbh4Mg=zbwsNA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] KVM: x86: Check irqchip mode before create PIT
To: Sean Christopherson <seanjc@google.com>
Cc: Brilliant Hanabi <moehanabichan@gmail.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:59=E2=80=AFAM Sean Christopherson <seanjc@google=
com> wrote:
> On Thu, Jan 25, 2024, Brilliant Hanabi wrote:
> > Thanks for your review. In my opinion, it is better to avoid potential =
bugs
> > which is difficult to detect, as long as you can return errors to let
> > developers know about them in advance, although the kernel is not to bl=
ame
> > for this bug.
>
> Oh, I completely agree that explict errors are far better.  My only conce=
rn is
> that there's a teeny tiny chance that rejecting an ioctl() that used to w=
ork
> could break userspace.
>
> Go ahead and send v2.  I'll get Paolo's thoughts on whether or not this i=
s likely
> to break userspace and we can go from there.

I share the same worry but I agree it's quite unlikely.  Let's just do
it, and if someone complains we'll revert it.

Paolo


