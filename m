Return-Path: <linux-kernel+bounces-55885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6D84C2FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F411C21870
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C410940;
	Wed,  7 Feb 2024 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/+k48pg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C9FC05
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275879; cv=none; b=LGXqDOM2in3VOL653b7WuP4AulnyKb+5Bn/ah8SAVGANr8d5HUCvZ8o4glzQMKV57/D4txi64hkWI6KhvAHxOMOPgM5T4OFIH3H0yDfkUy3B0FvYYbrwMbPzdVZyvhf5Cd016JVqRijwYxJRLUrU3IR7GqU/iJa4/gBWlFkx1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275879; c=relaxed/simple;
	bh=xv4B1LEIU4KOtG2Ub7BjbYH4Tj88+0kJFfUuhhkXn10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZVPKb5m4ubYZv4yghUxV3D/m3xiXp8yuuvKOZltD79HPCT++/Sz4bYTbgOt2Lr780XeNuKM3bmAUKfha94AB02KPxnw7k0fkoTqoSf8rPlAht7gAe7X3egBG+lGuWUNa7DuedBjYGdJ5JbXXbvDH3B6cGdzgbu62vT3OGLgqVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/+k48pg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6e6bc4aa3so213722276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707275876; x=1707880676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4CjCucqTLIudtP5PVERixa/oHt8DzPccdaWLPRE6E0=;
        b=D/+k48pg4+cPb4R97X9AG8UgLKAiJ34XAIe4MLydGty8u8Y8skBBgydIYZ+3EpySDH
         uVJcq703Ljn5fui46gS6pzdOwwhhFsd4XQl0t2bYvK65VlOaAItTIMH7M5oVsu3iv7Tc
         0cN+/fmbt74DmVaG57gGZ28NNqhKdaHEoiv0lny2QBO9BWg8FhDaHTQp/TISI0pDJpP/
         S0BrPTA1cKugS4Z/j/0TQyFW2ayEE4JNZXGSps0yotn8Sn7xSJ2eS4pT5V4Z9ydPSne1
         hKcX+XQz/zYfLwJuOINqz8PvAm9LJILYPReuXxNFO3LQ4NCBeQnMnCwwxTaUU4VCNkaK
         XXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275876; x=1707880676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4CjCucqTLIudtP5PVERixa/oHt8DzPccdaWLPRE6E0=;
        b=CTHSyLvot0wskUfp2SqN2L0bqRiBvFxq8L+0n40jHdzrIh79J2xyEorVg0SzUxM3HO
         wywlRGDWPV1672RJOSExm6OAlcqdoGFaSttXZZSUKDYiyOB/WdMnhblnknsXr93vt5Wr
         Cry1KkxtUcxHjzG0Ey6qkyRVxKHoWK6oV2//DMuzcX4TNR4791GbaNrOYy2mz/aHxJ1z
         HnEQScAtOoqAwZSOM6eGHUDdbQT/oc7vQobP5gjnjIsljX+V95juGIO8ip10Dumtjr6z
         YOC1bwA9Aqmvzm7zdZZkt0POLMtrhvjspj49Gu0kMbg9abN6m0o4a9uI4CH0piTS49Dh
         9cRA==
X-Forwarded-Encrypted: i=1; AJvYcCVLkkS9ReKdwxXPabMTBH8BcASkaC4oOGqqc2Et5fqMZhBWHAGNWpj2xl8m2ecLJcn4pW9MB++pr3MYKZAvqwgh9JZUADZ5P64LSo0P
X-Gm-Message-State: AOJu0YzQZzkenlS6q+lQ7Pv2wfQyWdEVToD98edjzirp7fomHE9c+chf
	jBbIqX8/2sA8oB3ZqAFRIY1JZl10k0/JWSuHmG+AvZIgkmhFXTB2eY/TxO9+4m4429sjnkfozDm
	KxA==
X-Google-Smtp-Source: AGHT+IEDt9S4Bp3akJ9/asxSh8xQpB7ev1QayNj+tDmZqMrZWt3F4FRrmzgPTDDZ2QioeOUf8ryjx+YClGg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:e01:b0:dc6:b768:2994 with SMTP id
 df1-20020a0569020e0100b00dc6b7682994mr152301ybb.0.1707275876698; Tue, 06 Feb
 2024 19:17:56 -0800 (PST)
Date: Tue, 6 Feb 2024 19:17:55 -0800
In-Reply-To: <20240115125707.1183-4-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-4-paul@xen.org>
Message-ID: <ZcL2Y1gpRG8C1_8f@google.com>
Subject: Re: [PATCH v12 03/20] KVM: xen: mark guest pages dirty with the
 pfncache lock held
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM: x86/xen: for the scope please.  A few commits have "KVM: xen:", but "x86/xen"
is the overwhelming favorite.

