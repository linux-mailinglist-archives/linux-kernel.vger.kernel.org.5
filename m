Return-Path: <linux-kernel+bounces-69456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992A858981
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E76D287393
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690A1487C4;
	Fri, 16 Feb 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WxQ9ewr/"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E062138489
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124433; cv=none; b=eCzD8ZTg396BDQ9ltCm5tt+BE7ix8Bdzn4QOYH7E5bWItrpiDFda7TNmPpW7bdJcqWUndd62dcdH7gyNFg5CtEx6zmyBg8jYIMTC0tWSN8KJDFiGL6amj24lxs+Jp0vOqkqSSrWNgCcZ1B99Ugl00+lcu3QIS17M78Yh4mSZ59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124433; c=relaxed/simple;
	bh=L/6pue76t+6bV8etRbJ/+JrByK34gEKlyYW7HOqcgIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etWhkS8R05bA4imU+N7vstSVP49U+z1hNzFFvMgnGBfnhewJMiAW7TR4iYDrFahYN7O+iapOWi0FyBATSFxK4ri1g9NAHivizSGXzNF1/tgy8zbWPATcNVH3KMNK9C3aoX0V92kXGzIua0tv8FhkTz+8a+t4iIZoaCTuIXw27pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WxQ9ewr/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d1094b5568so34165881fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708124428; x=1708729228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/6pue76t+6bV8etRbJ/+JrByK34gEKlyYW7HOqcgIQ=;
        b=WxQ9ewr/KAU7FJ3rjnLbX6gK4Axam3W7lNGF5R8u3M0HnoMlapmeyTXBKUoPakuGzk
         Nwfms+Yj7H/09cz+pUaA8u9ADZ+ZgyhmUHwGSZg8eiJWrHIeZ7qojALYz5b9bGqfpyNQ
         TEdIKJ/m1eP5UUcjPH/IcpQsm5AC6For6YFucYQkuaFY0XZpFRJp5NftCaWogy/qg9Ks
         MI/dGOm+fMvK5Im3vzcKPprq66c7Hq5udwHB0LyuRuVKjJHiDOB8UA1r0WBp7VVMVIqB
         nbxZhgvOQ9kMgm9Cs9WUFYur1FAExp+ctpMl8sMT4mSqeH8MOGFgodO16k4KQltfw+Nl
         DJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124428; x=1708729228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/6pue76t+6bV8etRbJ/+JrByK34gEKlyYW7HOqcgIQ=;
        b=WmR+AFPPXXjf+yOtn44ZMkLro8k8slMNiHEv2BdWXoh4UFRm4oCp7d2/BKOfG4RMtT
         2CXsetOfgeA38MP3ZSL50nc8mT1CTqOiR/J1dqOVF1mslzkSVAcbu1e3BGNWNzQ5gw7g
         em8wEbOceecYkYmLBVSLH0b9ld6RkCQ0+ej3aynyS67f+Zytt0UvG76B8aSXosaibco0
         HCRRT9goWBUNfKvAnFHRHZ3c+IuPKtbnZLibXVhC8s/OYNaAOzLp13TN3giTpZUxk8W7
         HlICOL4zgyQMLzvUt0J+OU9RhvF8IG9ImFjkNisQU/u0c6jWXpYhNjFdkNdwCTo1STVY
         vZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYQStfLP97F9Y4+709tfkMJgPAuuigfmDbCn0QFQi+wRcKrYtsjoyxRvMpHGs8FO+BIwTSsiDubNH39mH7BjbXAhOlRqOMAuX2N7k8
X-Gm-Message-State: AOJu0YzlttbG7bOBnfVy9eS/lGohEB6nF7KorbdNdL+ESMshhqOYwTSE
	jnQZZ+FiB374V32VIMCY1lOe4m187jx/UTinUppVappmPC6+itfP2j3GA0stYxqCD1YbDEOfK9U
	js0Sn09/s0+937cC/cRQsuz2TM9g9OivVUaeDv1BVHEcwV1X/
X-Google-Smtp-Source: AGHT+IEOZcOwZIFZjSELq39TRPKSsU03mDvfP+/A3CI44D/4utD/scQXzIoLEolaupxeC0YOENEhksY63FGtN0BdNKw=
X-Received: by 2002:a05:651c:807:b0:2d2:933:4165 with SMTP id
 r7-20020a05651c080700b002d209334165mr3997245ljb.11.1708124428664; Fri, 16 Feb
 2024 15:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215133631.136538-1-max.kellermann@ionos.com>
 <Zc5sMmT20kQmjYiq@google.com> <a61b113c-613c-41df-80a5-b061889edfdf@zytor.com>
 <5a332064-0a26-4bb9-8a3e-c99604d2d919@redhat.com> <87ttm8axrq.ffs@tglx>
In-Reply-To: <87ttm8axrq.ffs@tglx>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 17 Feb 2024 00:00:17 +0100
Message-ID: <CAKPOu+9sbWwZhbexQHwqZ6nMfg6dau7oYEzzgQ5qx+JiEcdmXQ@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/entry_fred: don't set up KVM IRQs if KVM is disabled
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xin Li <xin@zytor.com>, 
	Sean Christopherson <seanjc@google.com>, hpa@zytor.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:45=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> #ifdeffing out the vector numbers is silly to begin with because these
> vector numbers stay assigned to KVM whether KVM is enabled or not.

There could be one non-silly use of this: if the macros are not
defined in absence of the feature, any use of it will lead to a
compiler error, which is good, because it may reveal certain kinds of
bugs.
(Though I agree that this isn't worth the code ugliness. I prefer to
avoid the preprocessor whenever possible. I hate how much the kernel
uses macros instead of inline functions.)

