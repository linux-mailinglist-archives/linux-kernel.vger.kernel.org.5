Return-Path: <linux-kernel+bounces-130430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E28977F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619D71F21721
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3015356D;
	Wed,  3 Apr 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGrjwiBa"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD41534F2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168188; cv=none; b=iDHVHWEbupJOsWewbjqR6HmA4PiEa6BHU0/by5nCinu2cpQgVhA6ekPqzJnMFU66/m2s4/L8SRndkLhMFuNgMS2iDzOl8WwIepXZT9DWWoea/TH1bvyBSpJcKblpNp+iF20o/l9Yltm1fnRaz8TqkOV98wREl7w0t9fjC9N4Fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168188; c=relaxed/simple;
	bh=VFiK45j2Q+k25OG6ST/L3ExJ/1D7WWKaEd9JXrngPjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSKV4Q8UNVlRf6Eqt4Hjv5i2kEmkRZcTsptnbhazjCK2sXbdIuE8QAnnltOMEYokLKLLzhB3ZP0QUj2fJBLi11JLNA16mVIys+Jlkf7fBf1GxwaPcwgRn31XtKhVcKLx4uaAjFRwzUgqfJxVdLqaXy+xLURe5zMQXOL3aL6invY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGrjwiBa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so2914a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712168185; x=1712772985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNELuWdWa80XXRXdRCDWUU8putHnEOf7PvgbPFwUh3I=;
        b=rGrjwiBamwokjHSr0LoUryiPjR1nKxLARzz67P808l9jQ0HOgpcvi+wqRkEFN80JU4
         ne6A6MOVWyFM2YNKc7Jqm9COE5RJ4oFlWmxc97Vpe9H9tNJaz5JFZi0Ab3ciswUvuzAF
         jJsNkx1QIiuRCFzJ0Kl7bU3rh1txCUtoxIK+Y0vatw6B4UFn0UjC+eJlBnp9nIDK1EGy
         3dVyy+k9XTg7PMT/RABZeOBWYDNbn9+S+1CV2BVEyQNg55GKXup1urMZxdS7/3XF7OYp
         qEOAaBeL/7aO4xAq4Nh1Jp76tSIxyt70HoiiAQXUz+6e1+6HvXZyyISPRDtF20+HuEri
         aF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168185; x=1712772985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNELuWdWa80XXRXdRCDWUU8putHnEOf7PvgbPFwUh3I=;
        b=D7Cw9jT+yZjP1eUFcqnzF3uyv5OrN1l1mW9jhx975MUO0FOr0M7q3st4BAKyRoPh+M
         6xOMyYXVymzhY3Nl/wucKipbtpzbXrHWqHFZHcvsB+toZCZEF6Tp+V44rmxZJl3NCAdy
         mxI5QRihQI+iFHTaqivsblZXprORHQFwj3bUx6tkZJ+aaYGULW9lixoJDsuPuUm5AtY/
         X2kZzJd3opt6WyBVwxPpNQc82Yp3yM8rmD0FGjHO1TRB7Ief/qia3UHg0fF7/z++6+uc
         LMeLmRVD4SvTAi0N4WEatlJ0KQmNP779281qk0SpbebqFSWm3wKnB+rJNcxZD66+AOqv
         rNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4bQZ/62CDdv+kBVGhPkz9wwtkhhtMDP3KMXNXQ7STR+OOZne0jCnwEqQcXfu6aVRLElDuMIVz2P1FBvuy9UC2rHU0sfjxBZk+2sa
X-Gm-Message-State: AOJu0YxKLTAwuVdf2vfiPgiM5faJjxmVeLF/ZDbxxwwF68SfVqHNDTm2
	5C4jqO0/sP8flSwfDbgOYaLJmeOckVpuirODPl7OY88dxUhOCEA99n3DXDBHYwbzL5KoyTnoWth
	QPVH5aSygc4+S4fkvqSUItGEd9iQkPREpN98=
X-Google-Smtp-Source: AGHT+IGfHejWu5qYzjBmQ79n3dfe2V1iyaclIyCvbL1++S3ixo7/rHPVQXjlJIE+9sKOojX5U+IOl4Fuki4ckmOFfxc=
X-Received: by 2002:aa7:d645:0:b0:56c:5a43:5a66 with SMTP id
 v5-20020aa7d645000000b0056c5a435a66mr236161edr.7.1712168184752; Wed, 03 Apr
 2024 11:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
In-Reply-To: <87r0fmbe65.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Apr 2024 11:16:12 -0700
Message-ID: <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
> Subject: selftests/timers/posix_timers: Make signal distribution test les=
s fragile
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The signal distribution test has a tendency to hang for a long time as th=
e
> signal delivery is not really evenly distributed. In fact it might never =
be
> distributed across all threads ever in the way it is written.
>
> Address this by:
>
>    1) Adding a timeout which aborts the test
>
>    2) Letting the test threads exit once they got a signal instead of
>       running continuously. That ensures that the other threads will
>       have a chance to expire the timer and get the signal.
>
>    3) Adding a detection whether all signals arrvied at the main thread,
>       which allows to run the test on older kernels and emit 'SKIP'.
>
> While at it get rid of the pointless atomic operation on a the thread loc=
al
> variable in the signal handler.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for this, Thomas!

Just FYI: testing with 6.1, the test no longer hangs, but I don't see
the SKIP behavior. It just fails:
not ok 6 check signal distribution
# Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0

I've not had time yet to dig into what's going on, but let me know if
you need any further details.

thanks
-john

