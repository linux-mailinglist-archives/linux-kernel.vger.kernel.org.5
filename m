Return-Path: <linux-kernel+bounces-37220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01F83ACC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071281C23A97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5237144;
	Wed, 24 Jan 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmhCmpyA"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2615BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108863; cv=none; b=i7AhsQ7I6VsjmVVyAUhuRPIbRHzWpgoCt7ZUuDVB6vpsPd50jXQjDXQKc7y6AwqvJJ7ik3aSW9B2QWMTxoPp+sJJpY03ufURN864XgVJsh7tMymz/UBcQPZyjXQxMCWvxvnpM/yUN3feDphHIrTskRW/KCRtA91bClqct4d6rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108863; c=relaxed/simple;
	bh=9IkzyGEiEKGVlY7GJByNMGnOjq/P6kexG1EtvIuQJEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcQg/gdXtmnpvc+yrEnM5A3U21UPKmKoBpoxQAAWIfim1kxvfB12YNqdmPecho9KMV/QjAChFFZ/uYu0FvqwEoAujoHCleUGcGHM2NACTog4FrdmOHB50mmFLzSWwjxzRKsURQfpp1f6KxHgdyUSfKVD7nyHCSIrABfu4JtenXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmhCmpyA; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2c21d77afso3713197241.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706108860; x=1706713660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQUhXDctFpKrx2fN5W2QrrWVrRbLkQpDhsup1S4036w=;
        b=qmhCmpyARXLoJ6MdMPHEVtCYATWCv7XwXXKY6aF4BbnQdNdqOZG69NvkTqPH9mGtJ7
         xa2sS7sCNbJotAI50oi6IyqOJyeVyf4MqpFkITKycB+oOEsRP8uTGB/DlXpzVZuHj5Qs
         UDGHcgd8gr1S7XZcvmjd8ui5NlVPk/KT31WDudQfZUC/3SELMDA0MEkv9s37Fr4nrYEW
         tsM421VNdTbzvHs/5+ljRrPS+Q9p3ZZsy92Ao8FoEMoFZEtUttLcWXCFWmIS4o5Zrb6o
         lKBU/paVSaVCODJ7hJGk++YkO2R1Q80psAdaQOJXubUz/6Hohk0+iHRZv/O0A79yLFiy
         oTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108860; x=1706713660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQUhXDctFpKrx2fN5W2QrrWVrRbLkQpDhsup1S4036w=;
        b=E3j90zt/rho4TDIVkW2KBTVMBIzLWXRdMZeDdFuZKj4bASosenPGu47cC/ykSI0Pnf
         ckuziedSGql3AF93NprLdDZdWrpODv4besa/QagwD+36UDoDKn+1aCreHsSQzk+L2UJw
         V1V4PG11kbFQ5kDReQR0Ots1m6rZqUNidD/c5Xqx9vFE4DizNK+Cwz2MkteEyqOzf6Sp
         AOTeO+gVPvxiKZdfLccPtumEdbNw9dgPkB1KJDvr+G4W4J9lHX4j0x35oKShcg4a9A0Z
         Ag3tK7dp3nOOcvIvBDX0rKVhDuhfn890/aCIfCIj71cZ/f14ANmAfMSiRTPVuvvsYJSV
         Ic1A==
X-Gm-Message-State: AOJu0YzQ3YW2TeBMY5QJ9YoewMN6sY0d0qYBQIlEh3WjjS6QhTvARSXJ
	o2mTeLHOT1PhpezWLWUQ362q/GxXJwrGP0lB/0fys7FQwISj9GC5v+n3NadSZ7TQnmpmJH5AxSQ
	ITZQXjzuv+pKp4sBB7foRYnCAdBTvGHtTFRWn
X-Google-Smtp-Source: AGHT+IFb6yjLuBKZVuY2x8Cw5WSdGsFrEo/4i5lg0hKx+ZpQud0Y0yr6LHmrGsVoHS54595KDEkmaWJgFQ0HvO4qfoY=
X-Received: by 2002:a05:6122:45aa:b0:4b9:e8bd:3b2 with SMTP id
 de42-20020a05612245aa00b004b9e8bd03b2mr812775vkb.2.1706108860461; Wed, 24 Jan
 2024 07:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com> <20240108-rb-new-condvar-methods-v4-3-88e0c871cc05@google.com>
In-Reply-To: <20240108-rb-new-condvar-methods-v4-3-88e0c871cc05@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 24 Jan 2024 16:07:29 +0100
Message-ID: <CAH5fLgjQTkipTEWv=ogiaa7Y6xcrQR4EVkzhSz4oW8J2Bvq84Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] rust: sync: add `CondVar::wait_timeout`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 3:50=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> +/// The return type of `wait_timeout`.
> +pub enum CondVarTimeoutResult {
> +    /// The timeout was reached.
> +    Timeout,
> +    /// Somebody woke us up.
> +    Woken {
> +        /// Remaining sleep duration.
> +        jiffies: Jiffies,
> +    },
> +    /// A signal occurred.
> +    Signal {
> +        /// Remaining sleep duration.
> +        jiffies: Jiffies,
> +    },
> +}

I just realized that this needs to be re-exported from kernel::sync.
Otherwise this struct is unreachable, since the kernel::sync::condvar
module is private.

Maybe Miguel can just add that when he picks this?

Alice

