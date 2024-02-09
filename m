Return-Path: <linux-kernel+bounces-59851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DD84FC91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F86B29B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9471882888;
	Fri,  9 Feb 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yy+M4ke0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A1763E3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505305; cv=none; b=FNJ+TRChPDnR10tfh7W8efsMo4ka72ugLRX2tS+c82e0STf6CEA8MUc9wxjPamTsYXgQ/uuyZNdxue9+f8uEGlRlUaa417ILzk0vtaeid7S55sanMgSFYvapzqnqCrg7EmSRgPjL4mukHBfeAHLXAbsJwV0KswAtQ0mASJUcmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505305; c=relaxed/simple;
	bh=/Fi6BzVbQmG5nVQ63UG70WqUaLeYJODCbbDv9TLG8F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBainflHrvicPDcgICLs+TAl00WXQ6PjGgWCKkQmwXUdHlPbsPl8TFzmuXSGnWgVIfFLSV9BMA5RMQg/RA1ipWyoAJN7Uj5ueA/eCtz1Ac1DHYqiCqmhEKdum3hsCQcwG6Up+2avpl5wSj4xDw3vVnyt7QgkNHPOBjErKZFLSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yy+M4ke0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso1770814a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707505301; x=1708110101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IdZXKSMkBRnCj9HwTG4zGu6FPnSLltcxrc9e3CQDYLI=;
        b=Yy+M4ke09v4bYYxDozFtQ9Xc/S5X6WWPsevYlfwSVOoOoC/90t58yS9D/9RZQ7iPdW
         fTpJ2LkjqxqP5QgCWJL94x1/QKBtMg0M+RsdyS6/nkjCfU0pWU98vbQdxL5pd6LdvsbN
         MhxO7RzrNsvaVaQzhetO/fbk2AgUP0HwCPKeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505301; x=1708110101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdZXKSMkBRnCj9HwTG4zGu6FPnSLltcxrc9e3CQDYLI=;
        b=wHFFw0EIN1zl4THjRooYrADeznPSC2uI8CxHLXWT2OHYxeboVykNASvsnu097zs+/H
         PbX7jI+Srk/eLGrv+wSFfgHfV4rDwbqHfbi0vWqUUED52DqNiivr3QPNt/G4hzrHtTgm
         Kem/1zp6X0AXrA1sYpgM6URfltTrRNIT+Y4w19y439ivap8s7Ic3GtpYav+5npXuzd07
         nLEH/42MclzBKePr8bGry3tQyUwqwWpF/N1nVgPkFTpsizh+Qxyg3iOiolVzHHFq9u0P
         N78fq4pVP5WB5WetZuVF6iXPXznnaOheI7iGGjcbyFQjqb7OwrQoOMyt3BnOICwtE0Ml
         MeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDGcLQwSq/fjgwMWwjLr48/Hmx0jNBA6jmNHJJktyUUGHj4xTE/XCjObbGVvKzFPKoDVybvULyofBSINlYZIkdODTfzKzHqiEieBmE
X-Gm-Message-State: AOJu0YyIdEJqg2UoukF5r537CxUCZSdETLizImE+QpsEBu4Au5LIIrSe
	4YxWkxm4cPPjeCiS4/4vj3VvWcIaU7N/VQdmAKu7S+AZYN+fNd94KgBzkNnFYr84FNlyz2iF9JF
	Xk5c=
X-Google-Smtp-Source: AGHT+IGYY+lKj9yL/KDT7HLy6dFIID4pAuTBGd7vV306osTY+DA1MNxVlcv5LnIHErdDXrImZVIPrw==
X-Received: by 2002:aa7:df82:0:b0:560:658:a263 with SMTP id b2-20020aa7df82000000b005600658a263mr2038379edy.19.1707505301584;
        Fri, 09 Feb 2024 11:01:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9CvvPhL5OmCibGLimKWLNTdaZtblGda7/Ki+dH3EGWV2xadMZ+HuqQErFNPUpwpNMISzccfyGGd/6UmjO9KamVEyiAMVNSnfeFZYc
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id m17-20020a056402051100b0056038077ffasm15160edv.38.2024.02.09.11.01.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:01:41 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso1770790a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXt1j14UciQII/nmljC3htV7jJe/Aa/iSjYr5tjJZAtv/4jD+OKn2HH1ON93q/idEG24EteseOIDnwQnOS3QX2t19VAdmR+8faycExu
X-Received: by 2002:a05:6402:5d82:b0:561:3d83:96a4 with SMTP id
 if2-20020a0564025d8200b005613d8396a4mr1642420edb.42.1707505300634; Fri, 09
 Feb 2024 11:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
In-Reply-To: <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2024 11:01:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
Message-ID: <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sean Christopherson <seanjc@google.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 10:55, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> And also pessimizes all asm gotos (for gcc) including ones that don't
> contain output as described in 43c249ea0b1e.  The version checks would
> at least not pessimize those.

Yeah, no, we should limit that workaround only to the asm goto with
outputs case.

We should also probably get rid of the existing "asm_volatile_goto()"
macro name entirely. That name was always pretty horrific, in that it
didn't even mark the asm as volatile even in the case where it did
anything.

So the name of that macro made little sense, and the new workaround
should be only for asm goto with outputs. So I'd suggest jmaking a new
macro with that name:

   #define asm_goto_output(x...)

and on gcc use that old workaround, and on clang just make it be a
plain "asm goto".

Hmm?

            Linus

