Return-Path: <linux-kernel+bounces-149117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86C8A8C08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C80287ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE024B33;
	Wed, 17 Apr 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryaf6MX2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542571CD38;
	Wed, 17 Apr 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381704; cv=none; b=dRssHpZmIeoPiC4BHh7Ny+3StZHXeQsXTq2C6l3U6KK8H6MHv0YVZ50Cucui9YAdGWVOKk/sSJpZznd4vel55MH1a7HXDdqJB+Nx3YMhyvTbVj+kBmr9GhOalpE4WrPBoN/X9GhoJIJlXbxNaMwCi+PviSOkO8bp1EOiXnpLztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381704; c=relaxed/simple;
	bh=wVjPG3014MVAYdrd+COut7DaylrR6d606rWJWXDaurs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsMKYP2dKV7FMlWP4dM5lBiXreO5OnZEtcFgoNndlRBwEKRxgMRioGncWeOySZT0S0YHMRVewl4wCI8QsxBqZDOZcn3+Ihns6gzdKADTndLIZCVff8be7TBuDGzb/lQ7khpAnw5H1TtC8N6sFGhC/ESl1BlZI91yWUQ96jjPyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryaf6MX2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db101c11feso1016291fa.0;
        Wed, 17 Apr 2024 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713381701; x=1713986501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL+IxItw+NlxsTFv09kI71KrI9rXuCjstbHDz2H2mLI=;
        b=Ryaf6MX2mtjx30OCVVkH2gfynErdhD95uR4i0JP0HwD2LvxcBnMIhzKtDzlZdg0/HB
         RkXI4hdxosA+0iR0IYmwi9OP5iFXYifn0dODhmWln/ZFnhWNiT0hv7NanpHQe7TURvm4
         jwG0zZAX79KikogoEjU4E2kyn58ZjVvb7Gc3atndlMNJt46+tFpxOnc8lRiZvGhGofww
         mjMQAn0jyS9Bhb2T+r2VXeCsXiPgvA8ks19XAn0njZnUeSB/oxVMOKp9UNs9bmRDIlE6
         iiGvf20GaRRyO9Ijd/AJz/2C+jHzi2zK72jMP1fxgqQMdrdRXbtSxcGjnKCyMeQXR++X
         TTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381701; x=1713986501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL+IxItw+NlxsTFv09kI71KrI9rXuCjstbHDz2H2mLI=;
        b=Eiv6aJ8gg9KvsTlchLthNLhYUe4HNK25ny+/KfPCme0z7Dfxjg5VcTSQhoSF/I/SmG
         WBVG1WUugKP0IGoqIPy2NxPV6wjHnmiam+mEqchsBceeGPiKTVxweX+V0UHFrj+/lkKW
         giRvf8f9aZiNuiXdqz4KFDHZ7o5+UhRxUlFj+5WbV2edOnihV1DCyP4wRG7VMqfRHknT
         BmyJaR9pAVWWVRjrajWfFbNsm3zOZzWa4h1pKOv0zChrh1yxNiXB9qgluhOIa3TumF46
         DQWS6YaJe8pQiCYztpM8dfB/8lSU++8eMKKuMkBKWKTo5fZaG8KqqY0f9MNz9YF6g3YN
         9PEg==
X-Forwarded-Encrypted: i=1; AJvYcCUxAYZ/BqguVNal9fFCc0zRS/iDvuDQSof+78n5J6TZf9Q3O/565NmEbZxrXox1CWhcBDL2Ek646pwBxiHaNrXg45k9RaAJIgmSTBhVPbThQaI=
X-Gm-Message-State: AOJu0Yw/UcFBw0wYbOkyXg+uUTuCeqR8TP/2Xp6XNelBvuRBgeQLp+D7
	I2mwwS3FJqs2/OC23T9Nv3isXm76P+5hzNNpnbMd+PwIyHG5JFlGxaN6t61yRrAJD9UAGkBuZZs
	IKbm7mrrnE99omWbYal+78Q3TNTg=
X-Google-Smtp-Source: AGHT+IE+dn1+BiC5HRFISePkl+JlKbtUp8WFd3e+zMtV4AQ006m3tGlALuUK/FOuVkyav3qxNtEic0kVPRyneibZka0=
X-Received: by 2002:a2e:a28c:0:b0:2da:7944:9521 with SMTP id
 k12-20020a2ea28c000000b002da79449521mr10390lja.25.1713381701276; Wed, 17 Apr
 2024 12:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414161257.49145-1-ubizjak@gmail.com> <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2>
 <20240415201119.GBZh2J57f3aouPE_JR@fat_crate.local> <CAFULd4aFSBHNxyVyVt9soPnJXDgiOu6qCCNMLoenFNXtk0W4wA@mail.gmail.com>
 <20240417184040.GEZiAXqKvw3uRcmTJL@fat_crate.local>
In-Reply-To: <20240417184040.GEZiAXqKvw3uRcmTJL@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 17 Apr 2024 21:21:29 +0200
Message-ID: <CAFULd4b8kRgy0p3pKwheLRHx7rX+4RuY-45_Zt-CCj5sCpGjCw@mail.gmail.com>
Subject: Re: [tip: locking/core] locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Waiman Long <longman@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:41=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:

> > If the line count is the problem, I can easily parametrize new and
> > existing big macro descriptions in a follow-up patch. However, I was
> > advised to not mix everything together in one patch, but rest assured,
> > the creation and testing of the follow-up patch would take me less
> > time than writing the message you are reading.
>
> I'm simply making sure we're not going off the rails with
> micro-optimizing for no apparent reason.
>
> Saving a
>
>         test   %rax,%rax
>
> doesn't need fixing in my book. Because I don't think you'll be able to
> even measure it.

The above is perhaps a little unfortunate example taken from

if (cmpxchg64(...))

where the check is against zero. The compiler can optimize the check
to a TEST insn in this particular case, but otherwise CMP will be
emitted for different usages. Not a big difference, but a register has
to be kept live across cmpxchg8b.

> > It brings no future maintenance burden, but it perhaps improves
> > someone's life a tiny bit.
>
> This is where you and I disagree: touching that alternative in
> __arch_try_cmpxchg64_emu_local() does as we tend to change them from
> time to time, especially in recent times.
>
> And I wouldn't mind touching it but if it is there to save 10 insns on
> 32-bit - which doesn't matter - then why bother?
>
> Or do you have a relevant 32-bit workload which brings any improvement
> by this change?

There is one important issue. When a register (or two for double-word
values) has to be kept live for a compare, the register pressure on
32bit targets around cmpxchg8b goes through the roof, and when using
the frame pointer (and maybe some fixed register, e.g. PIC), the
register allocator runs out of available registers. The number of
spills around cmpxchg8b signals the troubles register allocator goes
through to "fix" everything, so from the compiler PoV any relief is
more than welcome here. Even in GCC internal libraries, we have had to
take a special approach with this insn to avoid internal compiler
errors. The kernel was quite lucky here ;)

Thanks and best regards,
Uros.

