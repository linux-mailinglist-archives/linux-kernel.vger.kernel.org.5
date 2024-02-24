Return-Path: <linux-kernel+bounces-79544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481A8623EB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C1F2841A1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D21AADF;
	Sat, 24 Feb 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/e4ofWD"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2B199C2
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767077; cv=none; b=FDII3vObp8mg2Cju3e32XOg+I/axdowdxnCYhikGZVUlgyMbR3i4lmoucUNB6fa/7qLWWJSxuEicjtxbvHgq4G9HMlsB/J4ja8JEm6O02SrhMSEal4NCoFbxiMV4dSzpRijbTWeGLtZiXnu1pwaXynGfYIvwLpadx/z2NGFezRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767077; c=relaxed/simple;
	bh=y2+xsbNA7nJA5AJAIiiYtBIFp5DHt0sr/WcAwRB23LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGTuyUboF26OXZgvmf/9REO5VOv5qKIFH4hlJDZ6G5GC06E2coA3q59ZHTQW8AFuTUCnY/03CaF8m7PKdZsK0m4jH5shvnp1fyD6UgyLin0OXjGGknbwGD0avywZoGJnJz/vv7qhzM9KhLkt04jTE6FzFh4J7zFHwT7GDiQ5KSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/e4ofWD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so6312a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708767073; x=1709371873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=y/e4ofWD20vd3a1URnY4gVNi+xSV3qazdgGof9LdTOzGjqTop0P6aPamki0ZqSqYfB
         8jzkcCaMNaIpmJ0G14woHpNmbJvu/21hSAOyxvWzlfcTyg1WSUuQxHDXvDvmN3lpxB02
         ej0DLMEvAf8S1YVFIb61w0mDWMR793YdZ3YIHn9a7t7ZxU/4A0DVieYSU4KYgccZtO8C
         W0d5MnLT7+WrmnZ9cJ135R76IUHgL2rqZSQ/h4LASdB8h2e0+uax9yjGIw31p4tuTRf1
         OxfMDNLFpY3POZ0yl9X2ouDzGJLcC0KIZ1CnYoVGT2/hTwVoeF9ZgNt8JRMldLkqinZc
         LK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767073; x=1709371873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=lrmBvkzzJxqXKgMA0hud8nEjPUQuUM4NroxRwhwC8G8pNGNiB2lyRcScZkPmFzTF+d
         y3kTPBqkTZiaJoikUrkvL1eUoVkh6GZdvrtAv3Mjt90fjZFS02ZcmD/Nkc3+/Vij02L9
         1b07JZuarKv58e3e04evlQ6MctV752H6ZYJPXcy+zTiXag/lzpEHIMUOS7fpWEt9ltyK
         R+mPzKQK8lATkTyxcGxi9/j80Z7nx4clAO3era0FipYZptLtti8UtCjSufHPtu8EsIhs
         Gv6EB5jdR1VlEjTcw2iD/Wyfu1hNnBLu7E+Kk/q/cMsodsJceCZ7081EzV+stcSJTuvt
         T+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUAHMyfsVtot4lIaF3t0qn300kssdNsQic+/ttWw58DGPoaFrelv2frUlPhivIu1wlemwv1q/D2NXEOXZGCQITVTCmv45FPhIKDiAEa
X-Gm-Message-State: AOJu0YwyAYYeNwk+NiJcL8ebz8PN5A1h88eKCcqeiBklJEt9ebhdRi4G
	Y7rZJM8nK89mftpFO2tyWWQofcq0IUTYGhwS3PWjXNXLaCHfy54iwRcSDyR8GN/pyoGn/VRHN77
	oxWYw9+CfWtYg/nfexwqSlhn6l8wtSkFreAqS
X-Google-Smtp-Source: AGHT+IGOZl/nBisuhQ6zD6jxD83U4XFWrPSRI4XTF0ONfj1DyW3nznVrpeMbXo6M+AY0O65iMMFktnvrm6rpep/W1WI=
X-Received: by 2002:a50:a6d7:0:b0:565:733d:2b30 with SMTP id
 f23-20020a50a6d7000000b00565733d2b30mr114515edc.4.1708767073364; Sat, 24 Feb
 2024 01:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com> <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 10:30:59 +0100
Message-ID: <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:04=E2=80=AFAM Dmitry Safonov <dima@arista.com> w=
rote:
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Okay, but what about CONFIG_IPV6=3Dm ?

I do not see any EXPORT_SYMBOL() in this patch.

