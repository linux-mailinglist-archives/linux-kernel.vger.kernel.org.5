Return-Path: <linux-kernel+bounces-51022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF1848526
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DD41C23011
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0516415;
	Sat,  3 Feb 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifKg6t7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4B5D72E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706955371; cv=none; b=J41ME8f9GTMpV56D5TGBhCBJxwxtwMobMYRJAbqfKcNGckGkH5YlHc7Gk4ctNBOffxiXzimleu8LLJ8tGOWwLlCNo0rAOC+xYBtBqhFVByllOE5iAPf8F2CQCr04+WjhRRn60qiX29DEjwlR0gEE+wxOQ3uVhrZcp9O1mJUDGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706955371; c=relaxed/simple;
	bh=qxxuz2J2p7Chf6uH2yTVM5xEF3vgNMCUL6jdWNWRg38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia7b88GkS/VgN2NOXyrfPtaQU5NI1G2xwcAbG9Zo9p/lARuzl4e0ypKnM5gAdH9tlYsdquVIlA8hSqQUB0Km0IL083l8SsTWKlbvxMwCq+bw164nH2CR8iZbFMnUYFEWaycilxizmj7/6Z2cVKHuZLnxjj2a991NVQs4vdRwIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifKg6t7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB9BC43390
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706955371;
	bh=qxxuz2J2p7Chf6uH2yTVM5xEF3vgNMCUL6jdWNWRg38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ifKg6t7h7ZaFdzlONK894NjGz0J83Cpt8IaNzcSrZ9Orl3sBfLnF22QfrcDln8r+y
	 CGN++nrT1sca5Ea9KQR6uZBk3LmFXy/ADIJ4TG4xSR9yW3wxnQJbiLbBqiWYaIn0ca
	 br5GVGPJlPqPbg2xVPhSujifEiMoaVZBmQoxa+5S2Smeti0JHoUrSqKXKdU8kOIEfB
	 g1YdcryTowvT0DZ2oOss+1Lx9oAqOCg3ZJ0TgmvcomX8uNZE47wDAtKYPXURg00GX8
	 yxI8+O3MzCghJGpoXj1HbSEWlfdhXGrmeeMcka2gA2yXtLZnyTbLkT1KczTtLm0XIb
	 x7a0coKN/enOw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf591d22dfso32117351fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 02:16:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yzpg1eVwGfOWaqwqUwlVImnSXCNvdWfS8akp6njKontdACujcjP
	BQMaeXsj8qfIhl2W4QHV+hCSBtRnyL7Aj8EJ9kd/MpF4pOWuHQubUQsQ/fLFjEYbcbxq2oVfzxk
	jJjzVLW1B7kbR+mxGwzcGmuDsYog=
X-Google-Smtp-Source: AGHT+IHuUKWtfsDtEMgekEGLIHPc/Xgf925IRUkC6ZpzqkRtHjBk4GdC8Hwp3t5TwzrGsY9B9RFMX/IwuiU8Nx4evWg=
X-Received: by 2002:ac2:410c:0:b0:511:44c9:511d with SMTP id
 b12-20020ac2410c000000b0051144c9511dmr848164lfi.21.1706955369587; Sat, 03 Feb
 2024 02:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-1-kevinloughlin@google.com> <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
 <CAJ5mJ6j-Vw2P=QLK-J_J79S35UggvZPtm5sia74=enR1qq9X9A@mail.gmail.com>
 <20240131182944.GJZbqRmBN_KDgK_nmB@fat_crate.local> <CAGdbjmJgu4euOTEzns4-7pqUWo8n-gNJiAfARoZWxw8T252zJQ@mail.gmail.com>
In-Reply-To: <CAGdbjmJgu4euOTEzns4-7pqUWo8n-gNJiAfARoZWxw8T252zJQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 3 Feb 2024 11:15:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHc8C+JnUDv5JDEeyFR-uZdmDN7ZF+QQZkGpw9ps8nJEg@mail.gmail.com>
Message-ID: <CAMj1kXHc8C+JnUDv5JDEeyFR-uZdmDN7ZF+QQZkGpw9ps8nJEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Jacob Xu <jacobhxu@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Feb 2024 at 01:22, Kevin Loughlin <kevinloughlin@google.com> wrot=
e:
>
> On Wed, Jan 31, 2024 at 10:30=E2=80=AFAM Borislav Petkov <bp@alien8.de> w=
rote:
> >
> > On Wed, Jan 31, 2024 at 10:16:55AM -0800, Jacob Xu wrote:
> > > We're interested in fixing SEV-SNP guest boots which are currently
> > > broken when using a guest kernel compiled with clang. It seems like
> > > every other user of SEV/SNP linux kernel code uses GCC to compile the
> > > kernel so they've avoided this issue.
> >
> > Lemme give that a try here.
> >
> > > E.g. Google COS uses clang to compile the kernel and we've made do
> > > with an internal fix for a while.
> >
> > Which means that, theoretically, you could forward-port this internal
> > fix until the issue is fixed for real, I'd say.
>
> True. I just think it would be better to have an upstream fix for
> clang builds of SEV-SNP guests; I believe the first such SEV-SNP code
> was merged in 5.19 if I'm not mistaken.

The problem is not only Clang. The problem is that we try to keep the
stable trees working with newer compilers in general, and we are
relying heavily on behavior on the part of the compiler that could
change in the future. Those references that GCC happens to emit as
RIP-relative today even without the workarounds could easily turn into
absolute references on tomorrow's version, given that both are
permitted by the code model under -fno-pic.

I've compared notes with Kevin internally, and we'll get a minimal,
simplified version of these changes into my v4 SEV PIC series so that
we can easily cherry-pick the fixes, either into linux-stable or into
our downstream fork.

