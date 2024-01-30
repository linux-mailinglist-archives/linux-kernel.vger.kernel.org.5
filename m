Return-Path: <linux-kernel+bounces-44606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570F8424F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A132821FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B652C67E9F;
	Tue, 30 Jan 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JzMfKxUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009F67E7A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617766; cv=none; b=d9k8y86e4g+gw6nnmix5iicmpxba+nhndOxpRjRYQqy+3C0p0aJrhLt7jz/nmkimxMvyct3zhsFxqLG/MmlLNlzshl+Ak6yuZ7oirgck4hIZHmKVH1u7MOQjFanXQGWksxeD40Nf/wuCd+AWmh+ElQPv2QzEUBBSQeS5vT1UrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617766; c=relaxed/simple;
	bh=qsIiCLqaLUknvCs6gj9gNldzzaHio3dXD0f4X/3u4Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/oK/VUR9EQQGhY0GRO2EsmN28f0BwHT5fNsMDwc+Ouq7IT9QR/LCebenxrzTz3DhPUZDG7YAqNWbA9GywHZ1r4wBqYqqD9V7vKIGZsuDaUX4J2noXGqLt6J4ke0nFJWLL/ce0wHeSMd5n6esj31BS7XggOZYXXt+ZGlxVzr+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JzMfKxUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177BFC433F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JzMfKxUk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706617763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mwVKBiEiIEYjQjxu2rl+y+jfQVIMNK8et3Pu7l5bfk=;
	b=JzMfKxUkQK/g4RWE6IHVltGlcUOp8G23T5+z9yTrD2ydRVcbbgpkQYajXhs04VzIdlVp5p
	/tCdNqgdRXQTlVwGJLaA4DyrOrpD9POxARDWEMyqbtRw7tYWgBTxhJm0tvLu2k/MGDKzuX
	+ul8JldwwqMwRvywUZgSy+52sayfWIg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 95299615 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 12:29:23 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc256e97e0aso2673854276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:29:22 -0800 (PST)
X-Gm-Message-State: AOJu0Yy0vFY/2ExRfuwSuBV2V0AmF4yYsVv9jHePRbSJKMXy/oawTQ3O
	95mjQORZKoBPBlKvn5tJ8IvwJZFSttVM5lmoxEOmGuf1DJ4ZZXRAUFTbp8M4BxJ2khM4PaLVknn
	64x2EqTyfwJIj5w7ANjM8IzAUgEc=
X-Google-Smtp-Source: AGHT+IGzrUAZ8eeCxiURky9BbLZcKZRYDdZjm2ie1uZ/chlKKKDiusDHkduPVUrbda3ObuhZHE1pCVRlt8IC4qGfUUM=
X-Received: by 2002:a25:8e84:0:b0:dc6:4d0c:e9de with SMTP id
 q4-20020a258e84000000b00dc64d0ce9demr4850031ybl.0.1706617761118; Tue, 30 Jan
 2024 04:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 13:29:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
Message-ID: <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

I've been following the other discussion closely thinking about the
matter, but I suppose I'll jump in here directly on this patch, if
this is the approach the discussion is congealing around.

A comment below:

On Tue, Jan 30, 2024 at 9:30=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>  static inline bool __must_check rdseed_long(unsigned long *v)
>  {
> +       unsigned int retry =3D RDRAND_RETRY_LOOPS;
>         bool ok;
> -       asm volatile("rdseed %[out]"
> -                    CC_SET(c)
> -                    : CC_OUT(c) (ok), [out] "=3Dr" (*v));
> -       return ok;
> +
> +       do {
> +               asm volatile("rdseed %[out]"
> +                            CC_SET(c)
> +                            : CC_OUT(c) (ok), [out] "=3Dr" (*v));
> +
> +               if (ok)
> +                       return true;
> +       } while (--retry);
> +
> +       return false;
>  }

So, my understanding of RDRAND vs RDSEED -- deliberately leaving out
any cryptographic discussion here -- is roughly that RDRAND will
expand the seed material for longer, while RDSEED will mostly always
try to sample more bits from the environment. AES is fast, while
sampling is slow, so RDRAND gives better performance and is less
likely to fail, whereas RDSEED always has to wait on the hardware to
collect some bits, so is more likely to fail.

For that reason, most of the usage of RDRAND and RDSEED inside of
random.c is something to the tune of `if (!rdseed(out)) rdrand(out);`,
first trying RDSEED but falling back to RDRAND if it's busy. That
still seems to me like a reasonable approach, which this patch would
partly undermine (in concert with the next patch, which I'll comment
on in a follow up email there).

So maybe this patch #1 (of 2) can be dropped?

Jason

