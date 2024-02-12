Return-Path: <linux-kernel+bounces-61977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C80851964
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E94B2286E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FCD182C5;
	Mon, 12 Feb 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Zs25J2r0"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDE3D98A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755409; cv=none; b=emP1fLE/SVG6x9G42g4XxxClEBWVqf/6OYQK7uWJ8Q6E9PBKN0O1pS6/87OJfyHjz+KR2XmjdOnDc1oQrqALh715TwC2y57iojaXZEBPs7vYqha6z0p0JAZ1Raejmj3atfA9KaeijPHgBbTGfCPDB08LIb+LN00Lle8ZG4240zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755409; c=relaxed/simple;
	bh=x7Wh7XTCkC+HIYtlIWvgYoPEMwJ1MLo8vCxPc9BeGE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbQlbRnvctEqFyh8slkmfcNZ2TVLF4EfE6ysoUtSO09FTTnV7qB6Ro1xXbS1xCQ/RB0MD1xI92KwhOYEeq0adWlqBy2Be2xV4BgJpg7ch4uDZqaqHSrFbGsVtezeSgpEzV3ZUeAqlZQlDb5nNUUYKEbqGjbDOpC4iZN12LKNSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=Zs25J2r0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5249336a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707755405; x=1708360205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7Wh7XTCkC+HIYtlIWvgYoPEMwJ1MLo8vCxPc9BeGE4=;
        b=Zs25J2r0KSMuW1eAEehlrNBnjlygWgKfWQxBkA6+CdTsj2fPiEFobYHVyKnOTwpUJR
         VFFN+7SQoOkEOfsvZdKarCmerDUMUPTmjlqteyOpQT6a0oxMnMjEasR/lHCT8KmQm64i
         8XozkJvxCQibKKzBQYNDeJo6PSbai4H5IyCoJKY7DuI8ivBvrc1zCMPJDAYlDZmA9dkp
         JwI4DPR3kgGzxpfgNxvZW5DtH0rlA0K/rxSB2cpj9N2D7W0jC1qVSNYXAEQdOLey/jfx
         dONjoi/Z+bQgri0I4AYY067dIcyhCe30/+F2SQdVPA13+DeGFOdh28eF6wlaput3F0Ns
         k6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755405; x=1708360205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7Wh7XTCkC+HIYtlIWvgYoPEMwJ1MLo8vCxPc9BeGE4=;
        b=ZN8so0cOKM8094driEIU1XnMShGzuB4U86fParFyRTi9q8GGnQ9XYpv91V88OqGqDW
         YCchLqMS96oo5nlviYEGXVZLOsZHA6GX1/PI5tYEIwud/9SDyOOrghP6HJRP8YNr+uSf
         3c+LjzjIiBomGCE5B+nzonvlt8+d6GU4zNoiuQ4wy2JY01oMjvCy2WpqPAPExwWeX/pt
         IjvYouHT5sf0CK+NoOldIKgoT06xUfSEin1Sypc1TTmWoczBfqqsQMxEx5rYPO39w7qY
         gI5qBI+65mR5baI8AW3neroPbMyEa7r/HtzfmWRUnlES8Ov7nospEX3rQ4eWEWypRSq+
         Fyig==
X-Forwarded-Encrypted: i=1; AJvYcCVEKi/6w8tvgTLIHMZKN+5CVNSLMGwtQlw1YNbyFUe39dmx3ibqiAuFyb44oKkY+DTw5qO5I1mslorknjIP9c5+3HfQHmif2m+MNlvQ
X-Gm-Message-State: AOJu0YyF5VXUTo/BtmPnyuytovbRXk/z3cEAmd9uqUB/f1RI51Szffay
	/U7oKuKs5Nvrva2AWcIkfnEUJOmTiAXGiYX3gZ/yz2RaCJ/MFm7E/MaANZUkUwfhkbadEuShrgB
	TcOLbfyClKjxsI0r1qHK+7kVoLvu9jKG8pjq0ND0DPi0D4jo=
X-Google-Smtp-Source: AGHT+IHPhjGekzFaAxOSY3AMoXRTFxX3dpE7iDUR78El8uM/U7K4LFQWafnE7Y9AmTxxssX1hIBGdqnq/CfbOXChbDk=
X-Received: by 2002:aa7:db54:0:b0:561:e8c:793a with SMTP id
 n20-20020aa7db54000000b005610e8c793amr5269696edt.33.1707755405177; Mon, 12
 Feb 2024 08:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122062535.8265-1-khuey@kylehuey.com>
In-Reply-To: <20240122062535.8265-1-khuey@kylehuey.com>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 12 Feb 2024 08:29:53 -0800
Message-ID: <CAP045Apecy=G_Wmcw6TMjSDfa3TbkMfFVkzGDJ9xTVksCLkZ0w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
To: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: "Robert O'Callahan" <robert@ocallahan.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 10:25=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> rr, a userspace record and replay debugger[0], replays asynchronous event=
s
> such as signals and context switches by essentially[1] setting a breakpoi=
nt
> at the address where the asynchronous event was delivered during recordin=
g
> with a condition that the program state matches the state when the event
> was delivered.
>
> Currently, rr uses software breakpoints that trap (via ptrace) to the
> supervisor, and evaluates the condition from the supervisor. If the
> asynchronous event is delivered in a tight loop (thus requiring the
> breakpoint condition to be repeatedly evaluated) the overhead can be
> immense. A patch to rr that uses hardware breakpoints via perf events wit=
h
> an attached BPF program to reject breakpoint hits where the condition is
> not satisfied reduces rr's replay overhead by 94% on a pathological (but =
a
> real customer-provided, not contrived) rr trace.
>
> The only obstacle to this approach is that while the kernel allows a BPF
> program to suppress sample output when a perf event overflows it does not
> suppress signalling the perf event fd or sending the perf event's SIGTRAP=
.
> This patch set redesigns __perf_overflow_handler() and
> bpf_overflow_handler() so that the former invokes the latter directly whe=
n
> appropriate rather than through the generic overflow handler machinery,
> passes the return code of the BPF program back to __perf_overflow_handler=
()
> to allow it to decide whether to execute the regular overflow handler,
> reorders bpf_overflow_handler() and the side effects of perf event
> overflow, changes __perf_overflow_handler() to suppress those side effect=
s
> if the BPF program returns zero, and adds a selftest.
>
> The previous version of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@kylehuey=
com/
>
> Changes since v4:
>
> Patches 1, 2, 3, 4 added various Acked-by.
>
> Patch 4 addresses additional nits from Song.
>
> v3 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kylehue=
y.com/
>
> Changes since v3:
>
> Patches 1, 2, 3 added various Acked-by.
>
> Patch 4 addresses Song's review comments by dropping signals_expected and=
 the
> corresponding ASSERT_OKs, handling errors from signal(), and fixing multi=
line
> comment formatting.
>
> v2 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehuey=
com/
>
> Changes since v2:
>
> Patches 1 and 2 were added from a suggestion by Namhyung Kim to refactor
> this code to implement this feature in a cleaner way. Patch 2 is separate=
d
> for the benefit of the ARM arch maintainers.
>
> Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleaner
> implementation thanks to the earlier refactoring.
>
> Patch 4 is v2's patch 3, and addresses review comments about C++ style
> comments, getting a TRAP_PERF definition into the test, and unnecessary
> NULL checks.
>
> [0] https://rr-project.org/
> [1] Various optimizations exist to skip as much as execution as possible
> before setting a breakpoint, and to determine a set of program state that
> is practical to check and verify.

Since everyone seems to be satisfied with this now, can we get it into
bpf-next (or wherever) for 6.9?

- Kyle

