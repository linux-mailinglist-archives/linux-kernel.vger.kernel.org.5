Return-Path: <linux-kernel+bounces-7864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF33181AE74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B051F2423A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9FB667;
	Thu, 21 Dec 2023 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O3v00XQr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D05B642
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5532b348d30so412764a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703137150; x=1703741950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I4Z30xKd74ObUozsJeNEksBVIOfy4kYjAEpzTgDQdMk=;
        b=O3v00XQra+41sh3riOTGFFksEKCuvmm8K5B1ZErRubNJOHiEhS3w2da3Zf9vE6Qnv4
         aN34JvUDbCXPpczrlHQcDt8sQH24V8g1eIkj8e2+B1wdpV8HuJJ6VObn/ndpgRq5N2Ir
         92UYncJ+C8dgpIfEUs/lkLbRDXK9AV6Fh6jgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703137150; x=1703741950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4Z30xKd74ObUozsJeNEksBVIOfy4kYjAEpzTgDQdMk=;
        b=gxIeJzMmW1DMRkTss83sa71R+luH5T0UT1a9AGNL90A3U0Mm0Mz8W1KtWRYjskoyaA
         lLbCJCl32+v6LbSFvmlfDoAl/ZI6MxjFbEG4HKcgkoHz8s6zGI9sxRR8Mzrudr9FKVo0
         fv2yeQ+r0IkEAlu1vQ7O2KUc4NXlNZLmv4TO6iBjKn0kWH7D5Bh3sw5BI5rhz4vGf+FH
         RuvWodp2Spz+6W/ASbWS1KUkpBoGM34q0Cnqm9bCy4wslDKx2oEJtQKEyF/gw4i9008o
         B/ssR9RLoL/PnxMQ4vWZFVBWwi6O5rBaUDFkT0F+1A824Le6qYCTAqzv1S7eoV7rgKyY
         Dc4A==
X-Gm-Message-State: AOJu0YwIZDCDLEynpP5iOZPBEWXHVM1792DkCfxPdZg+ZtLAvm9dQuNs
	RhKPz1xcIOTzdN855vnRxOs2mwzdkz+XIWicxTHzaCDx
X-Google-Smtp-Source: AGHT+IELTbMREYbBFUWvwt9z7CIf+SvDvobeEpl2eaTpn0L/9Fhkx/qeuNpskMSEmOMhRAj9tQR/kA==
X-Received: by 2002:a17:906:2d6:b0:a26:9a3d:20f2 with SMTP id 22-20020a17090602d600b00a269a3d20f2mr963502ejk.2.1703137150511;
        Wed, 20 Dec 2023 21:39:10 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id q20-20020a17090622d400b00a2375780143sm552464eja.159.2023.12.20.21.39.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 21:39:09 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a234938c7f3so37671266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:39:09 -0800 (PST)
X-Received: by 2002:a17:906:27d4:b0:a23:6493:7211 with SMTP id
 k20-20020a17090627d400b00a2364937211mr2723108ejc.114.1703137148904; Wed, 20
 Dec 2023 21:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312191507.348721d2-oliver.sang@intel.com> <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
 <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
 <87013f74-5828-4bef-848b-ffedde8e86f5@citrix.com> <CAHk-=wh=z-aXw6o8Hi9SiC5-vwP403-ZpDHUOXdXmLbaG93dvQ@mail.gmail.com>
 <CAHk-=whfpRxuucUL1oguRivq0e7JSxNWC2p_6gvKriNTHmr0UQ@mail.gmail.com> <CABCJKud8PG_ho79it34JxHG07n_Kbe9SLeBkEJwMYP_kS80D_g@mail.gmail.com>
In-Reply-To: <CABCJKud8PG_ho79it34JxHG07n_Kbe9SLeBkEJwMYP_kS80D_g@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 20 Dec 2023 21:38:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQvNhB+7nwUkWs8jkh8qbd0nipotYhhghFSVBNNoagcQ@mail.gmail.com>
Message-ID: <CAHk-=wgQvNhB+7nwUkWs8jkh8qbd0nipotYhhghFSVBNNoagcQ@mail.gmail.com>
Subject: Re: [linus:master] [x86/entry] be5341eb0d: WARNING:CPU:#PID:#at_int80_emulation
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Borislav Petkov <bp@alien8.de>, 
	kernel test robot <oliver.sang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 15:40, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> I tested the patch with the 0-day bot reproducer and it does fix the
> warning. My usual arm64 and riscv configs also seem to build and boot
> just fine.

Thanks. I've been running it on my machine too, and still don't see
anything wrong with it..

I suspect all sane people are already on xmas break, which explains
why people are being quiet. They _should_ be.

But since I'm not in that sane group, I decided to just bypass the
normal channels and apply it directly.

It really isn't all that critical, since I don't expect anybody to
actually disable the posix timer subsystem: I think the config
variable came out of the kernel minimization project, and it's
probably much more likely that people turn off CFI (particularly since
you afaik still need to build with clang to get it) than that they'd
turn off the posix timer support.

But I think it's a worthy cleanup of some messy system call macros, so
I wanted to put this behind us whether it truly matters or not.

            Linus

