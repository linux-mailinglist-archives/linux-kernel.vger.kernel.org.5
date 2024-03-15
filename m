Return-Path: <linux-kernel+bounces-104962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6AE87D69E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461251F2389C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22956B6E;
	Fri, 15 Mar 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJoRpAcH"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E175823D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541731; cv=none; b=sNQySFIINtUHqpWLW2/hUw9aBFCUZROKIo/oPJvBy5tcqFeOqVqoPhJCpkYk8fd88OCyRc0PTXhyMTq/4Cit8XHEdjdKrYwUN49HgP+DZFag4Bk2HkBI/FtCtSD4y9Mc1+phdYnGwgubInK+f2f6xiPSn1cHG2eAlwDrcFJIHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541731; c=relaxed/simple;
	bh=p6YA2ZEKShNxBk5y1IkrSjEYXZxVmLi9Hpcct3E+Pps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPrv36P49XY6XDt/soTjaVXKBX4OZaGpSuLv3SZZAggCTkncW5KGLv8iiLP8NRVRkncfYpSDFvPpKJaaGEnT5vpvNt85adt8BwSJjDDw2MYHC0QjBM/pGyokdvsYmhDGZLrwjCoT6w7ktcaTEpw74O4B/88Dws46Slwg/ExIFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJoRpAcH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so18503541fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710541727; x=1711146527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YUeFqqtIuPT4RgHb/ci6iuEBarWfDLjpf3yXBTu85U=;
        b=cJoRpAcHudTQm7fiGXz2ccygWmzRWr/86/OcNeS766aLwlDLWBtu0JWikgqeOPCAta
         Q5Szlwiu5ms8SbcBde0nsq3FPEZsbOzxKmd4+AEZudOLGBMtqDT4TuPmitkvkaIXxx26
         mY9vz1GeoboyZYLfY2fvwU+HEVXCn5GWoQl+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541727; x=1711146527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YUeFqqtIuPT4RgHb/ci6iuEBarWfDLjpf3yXBTu85U=;
        b=lR/OGYfA09jxK7+hNkHxJjsfOu7fTLu0OYxDim67SerD/bOkLUX0YddIh0iVYXCf2A
         p0KHPkfKR4hrozzICJe65VHvxfUWOJzp7cTROV0h1pShPmvQ1vY9PZym98XFOGpJuZhZ
         KT60TihSvRTbN16d9FDzOyPkJN36aCjhMCbg/TlISWiJD++BOHVvcZvFRN3f0BrPrEhn
         ZQPQG7nS8KOHoeEuxuVa7+el9MW0qOwjJ1gOP+uFak/1dxLA5GyTTloKpfNI2CDLA2/S
         Rd8wFjWgDTBv5VQNS/K74jjqq9QWHOM1E8lEmndU2v1J8E6sqAVdQ0PgFsoTOtyRfee+
         bIwQ==
X-Gm-Message-State: AOJu0YwtBCGQYcruoW0PoEYhcccZOeUkVWZsqa6fLHN61imAyOq7FeUX
	WBsWosNqvsG/Uh2bbRjJZWVIktlh4RQYEpwlM8XmZQ5rBmN1GZvyYWtA64oTVZ2BDDir/fFUTRx
	6hFCwOg==
X-Google-Smtp-Source: AGHT+IFwMyQ+qtgAsVNiDiFkhVVH9bcfkFP9QYglTFmlfsRwOAJSHdRyXHt/iHX0cIlH7CnsVEaeQA==
X-Received: by 2002:a05:651c:486:b0:2d4:764f:87d9 with SMTP id s6-20020a05651c048600b002d4764f87d9mr3647698ljc.32.1710541727193;
        Fri, 15 Mar 2024 15:28:47 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x2-20020a05651c104200b002d33e712493sm633156ljm.51.2024.03.15.15.28.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 15:28:45 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d23be0b6so2524626e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:28:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3293:b0:513:ba0c:cb6 with SMTP id
 p19-20020a056512329300b00513ba0c0cb6mr3803414lfe.2.1710541725253; Fri, 15 Mar
 2024 15:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315174939.2530483-1-pbonzini@redhat.com>
In-Reply-To: <20240315174939.2530483-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 15:28:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
Message-ID: <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 6.9 merge window
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 10:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

Argh.

This causes my arm64 build to fail, but since I don't do that between
every pull, I didn't notice until after I had already pushed things
out.

I get a failure on arch/arm64/kvm/check-res-bits.h (line 60):

        BUILD_BUG_ON(ID_AA64DFR1_EL1_RES0       != (GENMASK_ULL(63, 0)));

and at least in my build, the generated sysreg-defs.h file has

 #define ID_AA64DFR1_EL1_RES0 (UL(0))

so yeah, it most definitely doesn't match that GENMASK_ULL(63, 0).

I did *not* go delve into how arch/arm64/tools/gen-sysreg.awk works. I
don't really do awk any more.

The immediate cause of the failure is commit b80b701d5a67 ("KVM:
arm64: Snapshot all non-zero RES0/RES1 sysreg fields for later
checking") but I hope it worked at *some* point. I can't see how.

I would guess / assume that commit cfc680bb04c5 ("arm64: sysreg: Add
layout for ID_AA64MMFR4_EL1") is also involved, but having recoiled in
horror from the awk script, I really can't even begin to guess at what
is going on.

Bringing in other people who hopefully can sort this out.

                   Linus

