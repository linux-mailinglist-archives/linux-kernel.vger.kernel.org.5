Return-Path: <linux-kernel+bounces-107453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBF87FCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC221C22504
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250F7F465;
	Tue, 19 Mar 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYX++6X0"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CAB54FAB;
	Tue, 19 Mar 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847479; cv=none; b=UY3CRgGXDgq9Y1xqiFQOshBM1v1pOF7dB5QhAN0gjsXnZ2fh8I68luX3hYBgKDrClKWWEv/qXZa2Xnp1DrGt42eeuD4zF9JXa9kUneCDwdAshYwl3noeFs6DllMOPWDYsZxp7fSYrvkxKMEQZNtVl/neqPWfUOk9yWH+vXq4x60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847479; c=relaxed/simple;
	bh=2wx24UAHiVtV4+ypaJ0gY9Zi1VLzStuGl2jUigSabYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6N747r//6PbSxUvIYhh8HL5nzYc584fDa2CcoiGIHdRBH15BwNhJdaB5cppjlcfiCdp67RWEazzM+nuhZC7R2vzgMoBhH3Gn+rB1GudjWx7zmevHlTtMBXj3evEHeIK38B/tXmXqlDB3UhKEJMoND9xJl2phZa1jDMZDaRV0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYX++6X0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29c5f8bc830so3655606a91.2;
        Tue, 19 Mar 2024 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710847477; x=1711452277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR78YNxmtioAHYTNgvqa14nzPMCB8nOTuQY3ZK9gT7U=;
        b=TYX++6X0ebo3EqeuPDUYCSJHqj9t2zhdTDPTn5hi2eq1lhA7DgJThpaeci1H25YhKf
         cXtJiA3TQxLRID3f3fWbZ9eorGJmfbRBUUvRyB8kiWiCkhDRXBcL2MGtoSGozrukXfKd
         zyI6C0TpfiWn/lpJEBUe6Dg7vBwhhe5br2gcyyq1vr45VT5VZCEkOGKWwfJOdb9c2Epo
         V3/nQWUiP+VApEsB8rk02BTTdR2M+KeYWH06stC5jkL2gQ0ry2S/ldO6D8Kjoi1tfMWp
         8ke0zmS2R6EMjE5ngEvlJbEDCvBwwcI9o2vJN57eA35VY/MRjdF6dfcT9feqp6mYCni1
         zqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710847477; x=1711452277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR78YNxmtioAHYTNgvqa14nzPMCB8nOTuQY3ZK9gT7U=;
        b=jdBympY7b20Y880Gb/BhzQG2KJT9HarFAIgpn/ROIZeVrhirB3OvIQUDK3PT1HBMia
         XqBgQ4Ovq2FIYsPXXrD4Jqk8IjB0eohklBtKNccAJTmwbOTvIGdzddPxQ5inEfipoV9D
         4SqjhXC09lHfFHDKzkfEVng5yjs7/W47K/edefasRm2vvqveJQGdE4ZBrijT/tC7fIqn
         PRRHYA8mi82CbzPVOIt8LG3Y1G0ZUi93ifUE883ntQJy/05cObQ4WgeDJHgX51WpTqBA
         u+FX9gZITKDkCx5ND5jAQE01Ecw/YZDojSvgJU0cLC+u9wAdf5UpaF5zOP/Pur+lLZf7
         5pTA==
X-Forwarded-Encrypted: i=1; AJvYcCUksndAFvk8MQxNv5SGIX4hs9Jm2MEPgBNuJDykSWxSx9h1k9NZGKixfAqTWhRtgYhz06Jp07zfzmF6vgGJn5eYowMnnvvwZiQomaUuQdrkJumfXp1BVhQltuQp0H3VV+5NwfC9s0aLD7WJhvfcPkTGd9Reyqrgv+xGMOdN1kT9BmsYFYI=
X-Gm-Message-State: AOJu0Yz2XrrESgfo/qtqXenkc3PqUdVH9ipjZqpB0ZVExcoMHwaNwVxQ
	JUmrnPa3v+nJiUl4NEZ10RQgiAbKwXrtJaf1t31E6qDsf9y9P9+lv+K4SPQjdt+7NVMt++o5GEO
	4sjfc63xEI7Zw/QTPbb3/5ZwyaNUIWMFXHaM=
X-Google-Smtp-Source: AGHT+IHltyFVuxTP9oHxkHm5cMbzoKM+IH9GPaqGQW9To6riJMOSynrT/GUGulV/RkLMhkCoa3eVryaN8txx2R2x5OY=
X-Received: by 2002:a17:90a:1f4b:b0:29c:74a4:72b3 with SMTP id
 y11-20020a17090a1f4b00b0029c74a472b3mr10354367pjy.8.1710847477474; Tue, 19
 Mar 2024 04:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313230713.987124-1-benno.lossin@proton.me>
 <Zfh5DYkxNAm-mY_9@boqun-archlinux> <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>
 <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home> <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com>
 <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me>
In-Reply-To: <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Mar 2024 12:24:16 +0100
Message-ID: <CANiq72k6Vv2L+q9iV6Djx1=VGYCANegOLb_Kp-yMscMgYzvfRw@mail.gmail.com>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
To: Benno Lossin <benno.lossin@proton.me>
Cc: Laine Taffin Altman <alexanderaltman@me.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:34=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> I can re-send it for you again, or do you want to send it yourself?
> I think it is also a good idea to add a link to [1] in the code, since
> the above explanation is rather long and fits better in the commit
> message.

Agreed, if you want to have a note in the code itself (to avoid
mistakes re-adding them, I imagine), then I would say a short sentence
+ link is best.

Your link is a good one for an explanation, since it mentions
explicitly the UB. The reference's list [1] would be a good fit for
non-explanation purposes -- it mentions explicitly `!` (and
`Infallible` is supposed to eventually be an alias as far as I know).

In addition, while it is not important in this case (i.e. most likely
nobody is affected), it doesn't hurt to include an example that shows
the issue in general for this sort of patches, i.e. what kind of code
will be prevented from compiling, e.g.

    pr_info!("{}",
Box::<core::convert::Infallible>::init(kernel::init::zeroed())?);

In any case, even v1 looks good to me -- thanks!

[1] https://doc.rust-lang.org/reference/behavior-considered-undefined.html

Cheers,
Miguel

