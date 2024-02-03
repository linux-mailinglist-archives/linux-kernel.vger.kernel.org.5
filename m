Return-Path: <linux-kernel+bounces-50767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992C847DB5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB1C1C223D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EEA64B;
	Sat,  3 Feb 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLc4PtDe"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E864D
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919736; cv=none; b=I24zF7Fbwkgnw4IgnY0MrPSChQME65ELy0zLoAJiAYGdSRhbdOATgCd8wS6Zqiw1r20XlqteleRJOk1xkHgEbioD94aRuqDBL5fTpE7m6JyCy8BE0NXtEPHIQJo3vU4n85DWu83AGe5OgYzRqlKpDPAklb9pMGLiCOoipvaYGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919736; c=relaxed/simple;
	bh=C3o1qfywwUvUIabd5hwuMZUV/1xDnvYKJcKZvUvEyP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf/te1Q0QIBamTB+tlAvBzXEa7Bj5VdVGw0prjJUl4H/jaIyyVIDX+ottChEnSFq8VQ57CSCyxi9q4v+gEnHvMqOpeLYS2zDz+BHhFucAaWhW9DzRoyjrfby8AefnX/9/GG1PvBNN9PIIsEMZji3PdcCOoicJfl2BOgpQqiK1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLc4PtDe; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so1361142241.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706919734; x=1707524534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3o1qfywwUvUIabd5hwuMZUV/1xDnvYKJcKZvUvEyP8=;
        b=SLc4PtDeYhPvZQ+9hRVSd1d/F742NIqalcH457QczVaksGyhuCS5am0LEJ/iXUGRQ+
         6wrGw7V7fD+qVOiecC7TXeAR4XPz3jsH8kj7Oj5/ybPR7uaOMjmSF8xNv4Y8jOsVJsEl
         dKPXP3iZMx588LaCokBx+KD7KJeQu48BxPicWOkA6BMBGmNk3yP0aZXMZbWb4M2P1dYM
         qH6DfVbTrCFIHbgk7yPPLdqWKBfBz5XrGRwGoCTMmOHfYWIEWz+6kUY2R8neKv5vOKel
         kiRSYw97OWMsw0TLn866tmfOC+3uIAU52HS24AgQU1vpaJwxjc2yvcHVd3FjWPjD6jE6
         rizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919734; x=1707524534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3o1qfywwUvUIabd5hwuMZUV/1xDnvYKJcKZvUvEyP8=;
        b=LQ1TWHONpzr6p0Htr6sGc7vSTyKuybTGFcUqjI+ME7EOs6meuP/Rs3Bt4cBPtMI2bZ
         nLS0l/TTDeLXUMNlWjZa7RWjgOQSnuRLVh3dy7N10LNH4CRx2f4IkZK2OdOqwRSb3p9Q
         s8QOejP0NZaAl6yLE+K3w0aUoSCZ0LNfWZyT9BMpVezAY4DUaxRap6WG6mR+kk0nP9zq
         mF5xSNgEpoXxN6jCovaL+PNESuCwGjRAH9BMV0WVSo/03+DOlSZMteOKQS7kyL62VQg/
         8KgpXH0sZkoiXxrGQVrKzGx4pd7XpxFB95faaBISt7PgBZF63PzcyN6w58aiGH2Q2GIv
         2PoA==
X-Gm-Message-State: AOJu0Yz8MZ3LVHATQkD3bJ9BRUXUhexBYLRsFk5Q2+y2iZ9wHskBFyeC
	AYLg5YAStEncY7wV5SIvxJa7cyO34I58yLvbxV7cNKhU9zzBBrGZ0oSM2SdnDtDZ8WwAoCMAyQJ
	mxUC9+LYFtf0KQDM5terBzAWqi54/q0+K5IVH
X-Google-Smtp-Source: AGHT+IFSIhEFEg3nGk8Qq4T6ff1tMbZrmfYUk214IAEgqeFc1NH2PoHc6yH0A1svYC8k8WQyWHifnBrhsB2roBVlmO4=
X-Received: by 2002:a05:6102:495:b0:46b:1c45:f269 with SMTP id
 n21-20020a056102049500b0046b1c45f269mr9900834vsa.24.1706919733626; Fri, 02
 Feb 2024 16:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-1-kevinloughlin@google.com> <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
 <CAJ5mJ6j-Vw2P=QLK-J_J79S35UggvZPtm5sia74=enR1qq9X9A@mail.gmail.com> <20240131182944.GJZbqRmBN_KDgK_nmB@fat_crate.local>
In-Reply-To: <20240131182944.GJZbqRmBN_KDgK_nmB@fat_crate.local>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 2 Feb 2024 16:22:02 -0800
Message-ID: <CAGdbjmJgu4euOTEzns4-7pqUWo8n-gNJiAfARoZWxw8T252zJQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
To: Borislav Petkov <bp@alien8.de>
Cc: Jacob Xu <jacobhxu@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:30=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Wed, Jan 31, 2024 at 10:16:55AM -0800, Jacob Xu wrote:
> > We're interested in fixing SEV-SNP guest boots which are currently
> > broken when using a guest kernel compiled with clang. It seems like
> > every other user of SEV/SNP linux kernel code uses GCC to compile the
> > kernel so they've avoided this issue.
>
> Lemme give that a try here.
>
> > E.g. Google COS uses clang to compile the kernel and we've made do
> > with an internal fix for a while.
>
> Which means that, theoretically, you could forward-port this internal
> fix until the issue is fixed for real, I'd say.

True. I just think it would be better to have an upstream fix for
clang builds of SEV-SNP guests; I believe the first such SEV-SNP code
was merged in 5.19 if I'm not mistaken.

