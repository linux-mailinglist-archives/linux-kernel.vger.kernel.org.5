Return-Path: <linux-kernel+bounces-65688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0C85506D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3811F22185
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC097C0BF;
	Wed, 14 Feb 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpF3+4hV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951205F865
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932131; cv=none; b=XLfW6zu2KOxhvLDbva4CfeChHEQpVgJUMZyIjLoplND51+Z5krcV+J1WnmHFlvBLSisDwuvGbUCly4M7toSaX3/NfmSVCZpGaH/KWixmXknWUJETUJJEttD8mj2z+dWFA1TK46NClct6/Y4b40buQ+JLtjuvcumbWYS8DC5zJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932131; c=relaxed/simple;
	bh=UnEKkjF6H+Xa0wreu/FcqnmqSNSg7820UxEfXya2RYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPkdUy5jk2ItdCs8S1DHGN9eKBYmLPD0zvPcUY70pGmK43DeJZKe2qYTHUetrz/duO8v3WPR/AcaBos274a1AGD19d74GPFmlF09//yDWNEtvUYMEW6kyKAGOF8LSHtvFV0IZMfhoFB8Zw2g1hTPvI7+D+dnBcv9EcqO3mUtkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpF3+4hV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707932128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjcv8N+9j2c+EZOw13h4nVBpRY6k3b6dKwafPGeLn/g=;
	b=LpF3+4hVUnCTYXa8ElxhcVbOOj1+5qAoyDZz+QCE8qgf7c5uyCtKr+2CVa25/TXaGXufUI
	5/QYXRaJTcZxLN4LV6c2PF8vZf/TJrLCk9/XJduZCFv7XQAUWM/qFInPh/n5A3F1CC9iJV
	FA0BXM4f/fnexH+jSgIwtloy40CAu3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-mtcA8VZuPrao3X2-0GRVvA-1; Wed, 14 Feb 2024 12:35:26 -0500
X-MC-Unique: mtcA8VZuPrao3X2-0GRVvA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso34276845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932125; x=1708536925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjcv8N+9j2c+EZOw13h4nVBpRY6k3b6dKwafPGeLn/g=;
        b=rwwADsNda/Dc2IqnZI+mT4VU0xkjTvabIAmZZdP52fyg2Sy4iO2jB2d72HCcuJguMB
         TDXFS2r6lOnapI6A4dWJaU9+XjkgZSbxVVjPubnRC9buY2g8uSitcH6qb3oMa/7thdQx
         2nH95tZYjKK19gY2kHeAhplSU6MP/x5JzZldlRlTjHfLdjL/Kc6/Nfw+QnZ3Jv/EPdQd
         fnnYimqtJNJJ23rMKqDJFoBY2vWVxl3AUbjPlhzVT3X3MzOEEdTdExrsEqF6B608Er9B
         qzccDIeDrRumkLfmKtJg5V28mJandDBDaAFOgokirESO5o3Pi6M05tr8DEWED+mJbATB
         msXA==
X-Forwarded-Encrypted: i=1; AJvYcCUQXjTSLkQ4/WmHLE+N5f3jSW2gGNsG6x2yV3PUb0esBW6qahJg9w1znrMvGwHJ0jxkcFN4cioJVaep5WBbDAwIuAz5YCW6HzWYWHKf
X-Gm-Message-State: AOJu0YznJnlVrRPZ3ikuhcgvd+lvj4LaWr46kjjtIG7ZKgmgat9p40UQ
	2i5OxhkP9pUJobz21ZaSZ72qIwVX/hln0/jSeG4DDIG9Dvh8oXpmSUVgYH6AYiZ1rbf1+DIz3Du
	QlYuSjfHBcxnBFH/f6iB7rFrHHIWAHuHtGbN6Hk1oOQaIu5VFPjPacUCIEgsUxFtnHMtQ5ryZFR
	DhKoTpFwJs+7lZv1rasToIX0SgQDrPXnBiBaZV
X-Received: by 2002:a5d:4c41:0:b0:33c:e327:9f96 with SMTP id n1-20020a5d4c41000000b0033ce3279f96mr2217147wrt.60.1707932125333;
        Wed, 14 Feb 2024 09:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT5FtDGTQYbOYd0BkdVNsDSLM18V6qXnPo6Kdk33MxvhDPJAB0o35DCnQlFDaFL+MTifSp+WH5IFgS5xX4lsU=
X-Received: by 2002:a5d:4c41:0:b0:33c:e327:9f96 with SMTP id
 n1-20020a5d4c41000000b0033ce3279f96mr2217132wrt.60.1707932124993; Wed, 14 Feb
 2024 09:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213005710.672448-1-seanjc@google.com>
In-Reply-To: <20240213005710.672448-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Feb 2024 18:35:12 +0100
Message-ID: <CABgObfbQqVOsH0imHWc938n48TdkD8xFPO4CnwS0EM4oQZAxog@mail.gmail.com>
Subject: Re: [GIT PULL (sort of)] KVM: x86: fixes and selftests fixes/cleanups
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:57=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> I have two pull requests for 6.8, but I goofed (or maybe raced with you
> pushing to kvm/master), and based everything on 6.8-rc2 instead of 6.8-rc=
1 as
> you did.  And so of course the pull requests would bring in waaaaay more =
than
> just the intended KVM changes.
>
> Can I bribe you to do a back merge of 6.8-rc2, so that my pull requests d=
on't
> make me look like a complete idiot?

Ignoring the fact that kvm/master is currently a subset of Linus's
tree (so I can just fast forward to -rc4 before merging your stuff),
that's absolutely not a problem and it happens all the time during the
merge window. The way to handle that is to forge the diffstat in the
pull request, replacing it with the diffstat of the test merge commit
that I do anyway. It's a known issue with git-request-pull and pretty
much all maintainers do it.

But for -rc pull requests what I do is just base the PR on the latest
-rc, and in fact I've started doing something similar recently since I
have very few commits of my own in kvm/next. I always start with a
very late -rc and merge in all the topic branches one by one. Instead
of starting from kvm/next, I checkout -rc6 or so, then merge in the
contents of kvm/next with a "Merge branch 'kvm-6.9-paolo" commit
message (important: git sees this as a fast forward!!), and then apply
submaintainer trees on top. This results in no back merges, and it's
only cheating a little bit.

> It's not the end of the world for me to rebase, but I'd prefer not to thr=
ow
> away the hashes and the time the commits have spent in -next.
>
> FWIW, the two tags are:
>
>  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.8-rcN
>  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.8-rcN

Pulled (but not pushed), thanks.

Paolo


