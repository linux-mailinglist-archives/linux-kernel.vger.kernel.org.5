Return-Path: <linux-kernel+bounces-111078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC168867A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C78DB22DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4713AD9;
	Fri, 22 Mar 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZURDfk1w"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05216428
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093831; cv=none; b=TwZVdrvojtS0UmgX232HVnQFUxx/Rmg1nS7tWRjaGsYSj0ieDCXiil/sICE9Z6NBubfVZYWVwRZWmPQdL6yOKJheB+2Yoqs01IAa0eTXkv65gB4deVd4jw0kmMBtsHTsmjfRSgYzbqyfQDL/nw7ViaUF2keTNUJCbbaA/cZqX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093831; c=relaxed/simple;
	bh=fhANto9ziKDqCV1d131XA6WLw6k2l/+/gNXzyf7gZhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFfz7pMkHV8mV52riN2UU4pSiE+lhCgfSfOTKJBZ7aHKbmeDgJ5YkJf6ffbwEnLK5gTE8AZymRa054+PL7QI4XrfgTAGB+lPER7MyKzQLCSujql61wbb1h6GeAD9fzdYeBcM+rPO2gFYjajojp7DKf9a1QAqk5MhLxHKDNysxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZURDfk1w; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d436ab8a36so750736e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711093829; x=1711698629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnAe25wJMJ3hThrbeQJ8J1z3keZcPEDX52hAsKrK748=;
        b=ZURDfk1wYqYogkF+3Q2iYedPkvGQ+kNNxzFzEkMX4jOFRWE2Xy6islJrTyOsoXaGXj
         PUe5QCW0YiU131aaFqx7SBvJ4iGygUStqFW2Jzu67VGICAwbwRP4eHod20t066Zaqinc
         EgSwfmK8O+incoIJqzRU1y8q+04/gkn66EXOUmX265woCTD/q8hrWg3xw7YW8Jm0/C0j
         uUph+hzBvxty33kn7s9RbNCoSDiSUp5GMhpNFO9PQ9mSrCPfIqWg32oHcq94urTI2B0G
         9djY0OcWX4HbLaPGOaknrcNUwTTwmJjTvQ1YOZBqp6lQkfI1iMBZpByFbLO936EJInp1
         cTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711093829; x=1711698629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnAe25wJMJ3hThrbeQJ8J1z3keZcPEDX52hAsKrK748=;
        b=EtmpU4Pt592JgrS9LEh27syHTadhX4LQOqWrSiaZ1lsz2Of4jOlwW+oHuiFJvaXhOg
         5dRzDEhu2lQ482LFsDPTgnCvI2E68CLFkyT+jRE2ihrj8qAZu1Hl35BcjvZuVz9wnzr1
         72EmRSWOHrmw0VubbLPc0nObwyCYG6JmgiS2mVIb8o0vYD4+yH0Yq+Aj7Nq3aKjq1N1W
         L4PVQJGVpN64YfSqTwnRRZgCeen0mnDxiQAwpOgfP0dARY41k3oeRy+HhYkeUeAuRdm6
         Vjvaz3j9nNv+0oodk/A9myfVYpwcyFLQFjBaR3Oym9BooU+W1Ebm0PAqOulf7vdvAotz
         GRCw==
X-Forwarded-Encrypted: i=1; AJvYcCXoiK4ZOBRlL9k06uLwzax79l2VDztmaXl5jduvCtL7XxsumBjeT7D03BqhQQGaOrxFTE+TNGaw1t6NAVeD9GtRr4SJqaTfDxBRWQCf
X-Gm-Message-State: AOJu0YwSgpgwlbDL+BLw9aHaQaWJZyhpoUJW9iXwcZW4gzqqImh6vgGn
	GXurA6nDXJUIDsaOZS2oezUvmKrn77OHkvB2MUVGwpjjzZaPKFeyw1jmC4LgH8lguQ3ECor6uMP
	VXvpvv1Wyrf/Cm01Kq4xAer00upyKGvBCYeeF
X-Google-Smtp-Source: AGHT+IEdHDofjFjwDR/cIVjAYo6hIbKCd/YvnqQY/HaWYXK9gwQ7LydUhVgY49326mzzl62aJcHnOQXe0Qarrj2Yq28=
X-Received: by 2002:a1f:fe86:0:b0:4d4:15d2:8b3b with SMTP id
 l128-20020a1ffe86000000b004d415d28b3bmr1599387vki.9.1711093829049; Fri, 22
 Mar 2024 00:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com> <ZfsBADaYHz1FG8ie@Boquns-Mac-mini.home>
In-Reply-To: <ZfsBADaYHz1FG8ie@Boquns-Mac-mini.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Mar 2024 08:50:18 +0100
Message-ID: <CAH5fLgjd0hJzHbwM3bMZ9DUvDZ0OSf-btnebN0UG9GE9gKFfGA@mail.gmail.com>
Subject: Re: [PATCH] rust: time: add Ktime
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 4:30=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi,
>
> On Wed, Mar 20, 2024 at 10:08:45AM +0000, Alice Ryhl wrote:
> > Introduce a wrapper around `ktime_t` with a few different useful
> > methods.
> >
> > Rust Binder will use these bindings to compute how many milliseconds a
> > transaction has been active for when dumping the current state of the
> > Binder driver. This replicates the logic in C Binder [1].
> >
>
> I wonder whether Lina's previous patch also works for your case?
>
>         https://lore.kernel.org/rust-for-linux/20230714-rust-time-v2-1-f5=
aed84218c4@asahilina.net/
>
> You don't need to implement all the `Clock`s since you only need
> MONOTONIC time. But maybe `Duration::as_nanos` and `Duration::as_millis`
> return `u128` is problematic?

It would work for me too, but adds more than what I need. As for
`u128`, I don't really know what the status on that is. I need to be
able to print it as a base-10 integer.

Adding an API with separate types that distinguish between Instant and
Duration and different clock sources so that you don't mix them up is
reasonable, but a bit overkill for my needs. I am spending enough API
design cycles on my uaccess, file, and linked list patchsets. Someone
else can submit patches to add a more well-typed time API in the
future.

Alice

