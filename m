Return-Path: <linux-kernel+bounces-100535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2263879946
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3728373B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D77E58C;
	Tue, 12 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kd2Sq6wG"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78967E567
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262009; cv=none; b=YDLsW9AwuZA5V+8hDV+UvZ5WN+7Zcd9n5G8j3dQdRKHtpx2QVojgy0111sYv3JZYp51Cm8McP4crwq/3ZZumpIqyGNyyHJuEGwr9loUZR3X5TgCTWHihtfc2MFT5/0ExauBWmzxYomBe65UV/9eFcSv0OxBcs3F+s3fVjPOu9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262009; c=relaxed/simple;
	bh=umBBBlqiVX5oZZtiGOfeEiJeUV8Q19s5Pbg6aHawHxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaxNR66zIb/wbNsMapbstOnjcKaFtXuO42rqLN0QCA0Tu5rWiots6Lwu90gb7RpPqjEYZ9+k+tYD3A5tq6kujtRAHwKj6+o2BFgfxVgAIIxXkWccPnFwzrkE4H1qYJBCLO0Gy3i2UaDlg58KXxHGFlkGLysipHQktAfnbGmUzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kd2Sq6wG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a450bedffdfso22368866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710262006; x=1710866806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umBBBlqiVX5oZZtiGOfeEiJeUV8Q19s5Pbg6aHawHxo=;
        b=kd2Sq6wGqbalAbOexqxfKhZqCfGponrDDy6LVPFyKP2xY3toq6p6aL8MsenG4A74+C
         OjsHLvYqVYvd35aIvFutIXkeKuYQYy2Xm50WWsKLBBWuxI6I7qLZfK6YKCOQSEoIO2q5
         3jLiJurpC46z0ad4RijkHRC3ah2x2uHAzbdIu4SvHl2OspGtyRg8bzos38h+V+5sA1+z
         wJjpzkSUtysiIrbuNRZJiczoRuCBPQniUUhQM+Gh08Z7v7JVSA7LszcbrOZ66WHO4YLC
         mlN5PHgmQf4Bb2RQgvvAGwth0h+9QG3MTEwMWtY+HwfJzDjWb2514mKm9tiOTjAelNlg
         6Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262006; x=1710866806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umBBBlqiVX5oZZtiGOfeEiJeUV8Q19s5Pbg6aHawHxo=;
        b=ONQm28SPo9FYAN4iXfIF1IITsGGzbaaJiJe5g5+TDV4WqcNbJFouvnBp/5RKWfWDKz
         hODWG62tTj717fq4nkC10aHQ28U8BLUZS2B8PbDOqMeTHh+DTmYb5lc65jbGsUIc1pYp
         CAA0BZiUSJF+iY4s5KyI3tqI/lDgitQEhrNWHHFB8pvlvrNaFX5ygrTOb/9FGDJdS9+Q
         0dS0loeldi0VTgGb7L0RgGwWH/DF/K0zzqsEAscBAO2hxyAPMJOtSr8k2+68LI/WcRRx
         iMq4ehjTySHdH0BQPnAMnsz10B3AiF22ahsbQmfzwQd0YjvTNEfnHnxoUw5jRo96xC7U
         avSg==
X-Forwarded-Encrypted: i=1; AJvYcCWYy1jNP3H2848I8YVHlWuDXsuxKe8do9AFwanqmtubdiARfWq7Zwdt0Lan+piSVCGX1S5mUztnfXGgFPcgGt0VUtCRTmMDH502W12Z
X-Gm-Message-State: AOJu0YyUkd2CB1ZRlkuXWSoMQVm5bSvhM1XKS0zQdeQqMi202z3KD2Cm
	JnSfEE+HuoMeCk5o5IgKMtKwKWI9hcqZW44/S3c2pRmhH8V+iPRZXTYHLmiNc2K8AotalE8nils
	U4EcvS2PpIY/JT7nLJzz1VK81nfVWTj3Ms3AV
X-Google-Smtp-Source: AGHT+IGVlC5uTtOU6FyuKLGUS7/Ahwf88Sy4hHfGWJOJKNSYBfewGYffw+CkAy+momTU8t+Kg9yxuqKDgfeDMU9LuYs=
X-Received: by 2002:a17:906:6d55:b0:a45:25d:a291 with SMTP id
 a21-20020a1709066d5500b00a45025da291mr664266ejt.25.1710262005967; Tue, 12 Mar
 2024 09:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com> <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
 <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local> <CAJD7tkYa_NuX2_PD1sEn6kE6Q0Z0VCyq2T2HK_Qdj-_94+OG_w@mail.gmail.com>
 <20240312163502.GGZfCENkvNb41IJWPy@fat_crate.local>
In-Reply-To: <20240312163502.GGZfCENkvNb41IJWPy@fat_crate.local>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Mar 2024 09:46:07 -0700
Message-ID: <CAJD7tkZjHaLpWhn6bKRMwZrgiaK6V3gASB9d--e16xiV8P_7cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:35=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Mar 12, 2024 at 09:23:48AM -0700, Yosry Ahmed wrote:
> > Sure, although I am kinda familiar with that. It would be useful to
> > point out what part(s) I may be violating :)
>
> Are you kidding?
>
> Dave just told you.
>
> Lemme paste the whole text for you:
>
> "Don't get discouraged - or impatient
>
> After you have submitted your change, be patient and wait. Reviewers are
> busy people and may not get to your patch right away.
>
> Once upon a time, patches used to disappear into the void without
> comment, but the development process works more smoothly than that now.
> You should receive comments within a few weeks (typically 2-3); if that
> does not happen, make sure that you have sent your patches to the right
> place. Wait for a minimum of one week before resubmitting or pinging
> reviewers - possibly longer during busy times like merge windows."
>
> https://kernel.org/doc/html/latest/process/submitting-patches.html

Thanks for sharing that. I have always assumed this was about pinging
or resending patches when reviews are taking too long. In this case, I
was responding to review comments. Maybe I misinterpreted that.

Anyway, sending a new version in the same day is too fast regardless.
I did admit that already. My bad again :)

