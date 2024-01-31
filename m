Return-Path: <linux-kernel+bounces-46962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15FB8446F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911301F21EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4012CDB8;
	Wed, 31 Jan 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6blsveO"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C212FF78
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725030; cv=none; b=iprmBPOAAgl0ePZtsA9AGCCyTtl2iZXrj6B10idsNtsdO5D2VxFY1YRKQ+faugwP/9ojLNrksy24B6DAf+hxNNGYrOKABF5P0yaYf38lohERnOM0Zb+rVRP9zYB4Ncp+Q2/sH09lMir9Ng15pKnri14zHeq9ImiTq+WHCOB6bsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725030; c=relaxed/simple;
	bh=lSL7ZiS6AF8e2f46sDRNj1OPxHM2bdMKamA8rT7qT4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhEd3lrBAZx7ofyqh/kjLWm3E08JaqewoOhF+T8/zfmn+y0pPtp0KXOxlJPkRGcIhswfFdzt4j67+g2OY3UVtonh0q00XD8QSIZPQOcDGaaWZScmnC3jdr5/Zi9tEErWW/W+yUOxyuEDbd3YGt1KC83RioHj3domTkKbZBTTORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6blsveO; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3638bd37107so5325ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706725028; x=1707329828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGoGC6xB6KW9odfFn1t46MQGiYGwOCppmvmcxLORiTA=;
        b=C6blsveO2WU3EpVhI+nfyqpFQvAsUxqYeqyLTZcF6hZYN38oLVTxc922seTevu/+qs
         2AEX4ZtyyV4Uatc/PFHzuGBDfAENogo+lheKcQVFCNg2veGhq02LjzG+mWAGKbcYtOF7
         W4msDMo3d8qWimVXTZkuD+0VUjMNZ/1svRiz/ITJdh1jZ7le4GK5NgeWR9qVgqX7tFzt
         A1FhD3duX5G/Ji0vFg9QyFvRYlBwpZbXySPVKZaIwAkRQYY4ZLUDW7a+CR0iZChWhgWx
         8NPuPtTN3KRhNgHsRP2pkQcAvGjMeIutlxRhm/DR+8LCJXEegw67rB3zTjhWTVW6vxy2
         iSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725028; x=1707329828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGoGC6xB6KW9odfFn1t46MQGiYGwOCppmvmcxLORiTA=;
        b=hKCSLui7WVE7V6ZOqIy31bNtuXVuIOyURpELiGvyo+ytLGoMchB7GenpbOP/YPgKU7
         JDoRL8gotfpEF8ogVPy7Yv9sou4G+6xcu2Zp+ZDajXcJ6vFO/n7uyYcQ08LnQe+oN8o+
         oJPFJewYXrsNKyTVT6GBOYiexC/tbh5VB5wAzVXkw6IPULMXQTVLBtFssiEbeDWm3uTn
         kcLNyq8n4Pgg4eZI9+nSQXR6DrkGnm6I1QDv3saPmerOupq6YEN0M9CSOzq0lPp8pbeP
         W3EIhgsf2E/NTy25HQ0aUjUZRQ7HPiyi5JLLxyfByPnwbOBTYgWmuLzqvKLTrjXp5Pjc
         IRrA==
X-Gm-Message-State: AOJu0YzhNeNVj+Yzik3Qzgd0rUw42mqCrNwemybQxZ4wS3fK+bXpBo1Y
	MhOfCi2h5S8nkiDY8jEZPeML62Ij+9c7HZpNyNolOYhCkfNkskzu6SdgawOqV0fzupr6VZIb7lq
	ZENsPH1xo8BQw3R9VmBrL9hH4JkSSZs7YwcNE
X-Google-Smtp-Source: AGHT+IHycvDls/YT+3j8QE0ZFLpsakcLLNDEcd+SkH5MogAi7j4e2wPM1sO7EFqC9NaJxi/HxumIw1JCoMp8P/VnjQo=
X-Received: by 2002:a92:c9cd:0:b0:363:8388:dbd1 with SMTP id
 k13-20020a92c9cd000000b003638388dbd1mr15806ilq.16.1706725027987; Wed, 31 Jan
 2024 10:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-1-kevinloughlin@google.com> <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
In-Reply-To: <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
From: Jacob Xu <jacobhxu@google.com>
Date: Wed, 31 Jan 2024 10:16:55 -0800
Message-ID: <CAJ5mJ6j-Vw2P=QLK-J_J79S35UggvZPtm5sia74=enR1qq9X9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
To: Borislav Petkov <bp@alien8.de>
Cc: Kevin Loughlin <kevinloughlin@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
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

On Wed, Jan 31, 2024 at 6:01=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Jan 30, 2024 at 10:08:43PM +0000, Kevin Loughlin wrote:
> > Instead, this patchset continues the approach of fixing the immediate
> > problem of SEV-SNP boots crashing when built by clang, providing a
> > backport-friendly set of changes needed to successfully boot SEV-SNP
> > hosts and guests.
>
> What use cases are those exactly? How do I reproduce them here?
>

We're interested in fixing SEV-SNP guest boots which are currently
broken when using a guest kernel compiled with clang. It seems like
every other user of SEV/SNP linux kernel code uses GCC to compile the
kernel so they've avoided this issue.

> SNP is not upstream yet and the SEV* code has been out there for a while
> now without a single such report so this must be something new happening
> due to <raisins>...?

E.g. Google COS uses clang to compile the kernel and we've made do
with an internal fix for a while. We've unfortunately just been rather
slow to report upstream.


>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

