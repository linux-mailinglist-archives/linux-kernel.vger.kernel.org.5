Return-Path: <linux-kernel+bounces-97573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7F876C07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B4D1C2127F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9C5E08E;
	Fri,  8 Mar 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9zkNYND"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308A1EF1E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931148; cv=none; b=JG6zkXcC/fjk8jBp1oRBy5wRJuORnAmbXP3DCk0hac839vUT/pJStAccM+SaCa8LyygNvyDczdfVHcoOjK/DplPq+5C8r6O6ksc3Wkpa20yaeeAmqs5RsoTnKf8eBI0YdD2qSrQbC8ugJdKoYWCQv6X6jtaAQxeGkbjenp2gg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931148; c=relaxed/simple;
	bh=j2rwAOJRo4LYcXeDY/WUYHfb4+0+9qA2Hm/60uUoEdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lmob9FBwwQWdEVbPeuNO62a61YSTvtJ/XWGvztTXduYVb2m4rTmMQi2GSvAiiNNGy9fsrhqXaivCcD6j3XUArdjLcgdLlUSI6Xxip7maRTh/Jp5kOvBjUeRsllLqxmrXjNlsjK69g9MxeDkYKvAKH89GoE7gMKWx7xyQL6a4RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9zkNYND; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7db1a21e83fso714295241.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709931146; x=1710535946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIbSa45F0sbbEQNxZfvGwr7gnFgJqOFTDI+EfPdvz1M=;
        b=z9zkNYND9UIpwbtaasfHE+K+7uEVHpNP2bEtbgLp0XgH0zlCLAukbH9tMVxwChpMsv
         8CcI/mSGOQVxijIxE+b2+b010oXE244oO248T7KgIv3A8yCCAt8EVgV15QGN6EQ9V6S7
         WwKbApT+FhGmYjbZIj7DdJV1vjOchZYZOxhgbSxOGPlPq8Vi4zgH/w86VnXP24QQNmxm
         GhhZc+fr5Gf/dBJH2b3yRUv+NoMnoZd20X7NVuf/1ltnzh5Ebdctjk4Ggigd7wXwgFGm
         VXyo2hbK7iYebb8U2XrsuOQr5k942LRWmr6X0/XCazRRwWbKfivFyV8VMln+COxhwEib
         IUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709931146; x=1710535946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIbSa45F0sbbEQNxZfvGwr7gnFgJqOFTDI+EfPdvz1M=;
        b=ViP6QpKrbl9hoeccQ9QjO43UzAbPrh5quzf5IFKj9DLKHvx1xwcplGcX01bKQnaxEZ
         aPIyWHYFmk5mDa5msBrSaAzHocX0JyxuD8zOfBN+jdz8I0nz41kAvbicVElNl3vlNFqD
         e3feZynow7tz73fytjJtyivIRZu+L8BY8qgGApgOQP97Ou+hqbgXEr9VUx0LerCe8j7D
         4HaacjFU4QJzXlGeaLf/5GgXqA8QB2AG+1pQ7RKiJOc+3ZiqrBVQ6JzvWDuWmbqvf1r7
         hFoT2snj4AIszc6OuoKwQb0Q6qLCLteNaly1Fr2wNWY/7Wgbx+q17drMx9oRp+KdVOqv
         6pgg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRmGPeCOVUcrJMCy/0N5aWCCxU5FUPlinGwWDj81U67GFp88sI3CXqgQ4ySGfJufv1ecYHFQP/jPPm9/Hw1rroPYosAKt96adOe+b
X-Gm-Message-State: AOJu0YwJjQF0mJrDey1mUWJMt+aA1TnQ48FitYxT3H6vZkDz2FHia1J8
	NP2riyY7IxB0m++2uAAJQvuursd66AFPlI1uTEcot+PIkUBhhAacSPxS0NUnrNZk9gN40KsY8L0
	mXmf+G8hJvol9tfh+0SghDlHx799mZ1AKf9WN
X-Google-Smtp-Source: AGHT+IHi7Oud5ysHq9CgQrZBqlgkk+ZUvKe1KS7qoSHtq5TTT8mP5c7o9KkShcg8eu23GC0V/keL51QjkCc9dUbzAC0=
X-Received: by 2002:a05:6102:1886:b0:472:eb81:ef29 with SMTP id
 ji6-20020a056102188600b00472eb81ef29mr138917vsb.23.1709931145717; Fri, 08 Mar
 2024 12:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
 <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local>
In-Reply-To: <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 8 Mar 2024 15:52:14 -0500
Message-ID: <CAGdbjm+RMy6M=_PRg_L70g+EZ1FXi0BVub60KT4-GHuv6wLa2Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, acdunlap@google.com, 
	alexander.shishkin@linux.intel.com, andrisaar@google.com, bhe@redhat.com, 
	brijesh.singh@amd.com, dave.hansen@linux.intel.com, dionnaglaze@google.com, 
	grobler@google.com, hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, 
	kai.huang@intel.com, linux-kernel@vger.kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, peterz@infradead.org, pgonda@google.com, 
	ross.lagerwall@citrix.com, sidtelang@google.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 6:01=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Fri, Mar 08, 2024 at 11:30:50AM +0100, Ard Biesheuvel wrote:
> > Agree with the analysis and the conclusion. However, this will need to
> > be split into generic and x86 specific changes, given that the DMI
> > code is shared between all architectures, and explicitly checking for
> > SEV-SNP support in generic code is not appropriate.
> >
> > So what we will need is:
>
> I was actually thinking of:
>
>         x86_init.resources.probe_roms =3D snp_probe_roms;
>
> and snp_probe_roms() is an empty stub.
>
> Problem solved without ugly sprinkling of checks everywhere.

Agreed, this is nicer; we can just add dmi_setup to x86_init as well
to implement the same concept for all checks we need.

