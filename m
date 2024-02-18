Return-Path: <linux-kernel+bounces-70569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B023D85993D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A44B2113C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F9173164;
	Sun, 18 Feb 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1VJ3AeS"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADC71B52;
	Sun, 18 Feb 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708287862; cv=none; b=DTdLbPiefmujp3zEqtbXZBbBpg8C5NPR/HzAe2qo6vFqDDAi2AN+3SGv1rib2NCcY4viFjoE3Lnb4FYUm3EOyHcEUlXV0ZR4whL9N1WvD1OYnAVRq72eWkAV6MUYcQ0cruDT3Psg9/H/DCsGmUFZuBB0V29TmEvDAKdiiJr4CeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708287862; c=relaxed/simple;
	bh=h/S33fLRUwPtE0sfKI/JBPwaDTTSKAGSV0evo6a1CVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc0X3MEVA6Z+IHobYahTAeklttkUcrcXXwT8gB1tvCjeiREBlr9XYASGiVu9Y1zzgVx+4c1UOLSum7s0fEAcSGjHp4POEX3R5mTGPXc6Q5kxt7It9OBOtty3n2/FaFi8k5qFBOVRit5icJZ8XVwhG+nAQvc8zaQHTyGFd6f7Aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1VJ3AeS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so3764167276.2;
        Sun, 18 Feb 2024 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708287860; x=1708892660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/S33fLRUwPtE0sfKI/JBPwaDTTSKAGSV0evo6a1CVY=;
        b=k1VJ3AeS8MWEvN37bI2Hw/JRRqzPy3QCJXtTVpCmj8lIoge2yZ0dVjf9JITnoaI69u
         LFHgssaCPv2E9+F7JaJpjzrLGXytJip3HfU2jxoQq80sI7SKnKCsB7olzqp9MclhnorJ
         4jw0mGe+g658+OwHynjKc/tWxFzCM97pZjxnk1hjhLtmeEwH+IBDR+oTV6LPQitKUn4k
         I11oouGLVI+h17hMaY33BFqwUNC0RkF1p1jtJ2rGGIdQWedc4gbFgsAclWrCkfnUEGp2
         PpEEN1oCex8/+IhNv8Y6f26TXeUs57KQ1/SCP+wxnGIYdkN+x17KsxyhzjuDa7+8//wO
         IbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708287860; x=1708892660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/S33fLRUwPtE0sfKI/JBPwaDTTSKAGSV0evo6a1CVY=;
        b=KcCa1ukS/DtK+i7fsrCpvlGZuhGF6SWSM9U5Fsl304mEYR0qtO9v7IhHepEBKXDBut
         LDLMPE6YBnJKh/vVkRhCTEMK3K3pWZJvNJH9ev/ow6R2xTYnxp7y5fTotXs0ZrtYU+00
         q7J6Dum17j7TSBtaDwdrK3yn/v1i5UZ9Erpd8LVqiQVL8tIyCwWb+3jk/SrCofmx6eGn
         91oEK8UjyHXpx3Zm2xPCm0+E5vKgxKChIyEdUZTv/Vu+7GNsyqGRhuB7Zq14eVc5Ts/F
         KY5uGHBMkjXkCGPcHK47EpwYEpWQK4UlldMHJ2XQ7RoyvJX/v16CrPEtkGNDov/ICtrn
         2zVw==
X-Forwarded-Encrypted: i=1; AJvYcCU1rozDbWpZpjwqHjM1gsnASomvCEMSxnF5phYFjJp/iStqXrnTYzt8yPXcEfVmPEtpJOqekoO6x65guHIuFbavRWCgTKXGxwEDOq+ShaHyUdnlaINdbctjYeQCgNHTA7/5oCYPYJgREkjy0tA=
X-Gm-Message-State: AOJu0YybxYJ8WLJoKmBy13L7USdalWSXTbo/63xN8pny2hi9IkNvvgMw
	/nLrt51oOdSC4DMWGXCpJcaVq/EKUWtzyA8qF3VMvnR9k80HRxRozvLvUzGStevDqbBhV6tn8Sy
	u6CRNRv4r8NnodsWfPjbkhJhjDxeBLwvv
X-Google-Smtp-Source: AGHT+IF6DFUVVTPf3FDA/xyWPhTM6CpGUYanWgyLe0DtCWUPU62PhhpNqEnF0iJfuM4XbS8beC8F09j6kocy0+illUg=
X-Received: by 2002:a05:6902:240d:b0:dcb:deba:5ef9 with SMTP id
 dr13-20020a056902240d00b00dcbdeba5ef9mr11235376ybb.21.1708287860130; Sun, 18
 Feb 2024 12:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215104601.1267763-1-aliceryhl@google.com>
In-Reply-To: <20240215104601.1267763-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Feb 2024 21:24:09 +0100
Message-ID: <CANiq72=Wvj4r1Fa=HdsbFu=VXuzWtug8GSnzWwhF1ZCXNQ5dsg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: stop using ptr_metadata feature
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:46=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The `byte_sub` method was stabilized in Rust 1.75.0. By using that
> method, we no longer need the unstable `ptr_metadata` feature for
> implementing `Arc::from_raw`.
>
> This brings us one step closer towards not using unstable compiler
> features.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` with slightly reworded title -- thanks everyone!

Cheers,
Miguel

