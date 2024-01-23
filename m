Return-Path: <linux-kernel+bounces-34626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AD83850B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BBE29158A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DC7CF0C;
	Tue, 23 Jan 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jlxuETIp"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFA7A735
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975728; cv=none; b=FQrHu3NkOwWEKdKhIUN2kZf9w8AhBQQhn7Yo5qrCroNugGjXmF3RBMQDTvPGr2WEqQKDlm6oaif5gQAClDqxd5hCQ1AKLxynIDEEnOxbWAgyHVHkygWI1Uk8WM4whz6p4hfXW+3v/5oBVh0h8mmv/IAzi5F5ir+8RxOaK1+pPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975728; c=relaxed/simple;
	bh=R+kv9l/ZUzM8R/FElAZPCWzzxzFAddYDRk9QLtHUjGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcCPfnZFjym9hpy8O4YwGdfkpYw6v1HuBKFKhMNPW4DeDj01BDwp6Zdjav6DkWgwaE1/DmWHDWlR415tK/1Uhgy+N+IWB4RsK8cZ6P0x+VmoTTZpI+0VMR2063yPVHxBTJ4qLI09ZnAaPPJK97QocLLm+SLq8kL2UHuksJChEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jlxuETIp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3046221b0eso144474966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705975724; x=1706580524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o6pnpX/gRRzVtSBelmPlR+54VBb1uBa/4Pwf2be9x4=;
        b=jlxuETIpd6q3tab8WM4HKNWnsRGEui4Z+zs2siiFXbFnb+46nFf5LplBA0j/nETlrO
         5QC3f+C5KDbfeO/xbV0HQYdQsx5xGrEZFhcwn1iI/EmFLrYCdxzG87BOTgIqOeJGnPqU
         otJsOU+Ox+j8VyftjD2aIqkLaFWw3HvbubehE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705975724; x=1706580524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o6pnpX/gRRzVtSBelmPlR+54VBb1uBa/4Pwf2be9x4=;
        b=teE7wAYoy0leCdysvJnAlTiII8PvPmkq6EA25fn9cwpxg5vAE+mCCsNUcQ2lE/8oFD
         clNKwj84KVryI4U5+S6SQv2JKXQYiDnhtUEpmjERw9CubaYhaZcDKm9xyj2BiToMo2Yp
         9d55svYy7NEztlq+tH1DcqWiXvASkyvU4Hdiz37X1xveK15Cc/awBMv52d2IBhvdCWGv
         j2ua8WM2NrzOPL9hAh6rV8QgoneIjhMkMr8JJfGkAdQcWXUV0R/606bSJ25I/6J805CT
         E0cOkt9qH0c25vR4dqjrGj9zCCZYvM1zU5E+u6qhDhKk4TCoAXhfSaPaoi7nTpmPSXni
         F6kg==
X-Gm-Message-State: AOJu0YyP4CqmI3xU07mJJju8v/1Bo4a9I7z9LmEqQiXjhiZylT+RAkTt
	/Usm1hqoQHBXGfOgm8S9k4CP7j3N9KfmjYuIYVjSnAhJlIisr2acdXAAlZB780uvE9SCy+rMdrc
	=
X-Google-Smtp-Source: AGHT+IGdsWZUJnlMiUSi8sddeYOrGaLVAkJ20bBS3sCJYMqdlauRbUtXEvSbdKZNhrQ4b73Ef6WbzQ==
X-Received: by 2002:a17:906:b2c6:b0:a30:9e78:662f with SMTP id cf6-20020a170906b2c600b00a309e78662fmr417117ejb.70.1705975724110;
        Mon, 22 Jan 2024 18:08:44 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id i2-20020a170906090200b00a2a04c9226asm13868416ejd.194.2024.01.22.18.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 18:08:43 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337cf4ac600so3551216f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:43 -0800 (PST)
X-Received: by 2002:a5d:4683:0:b0:337:c6b6:fe5d with SMTP id
 u3-20020a5d4683000000b00337c6b6fe5dmr2533245wrq.102.1705975723146; Mon, 22
 Jan 2024 18:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
 <170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
 <20240117090706.3522d23763fab9dcea21aee1@kernel.org> <CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 22 Jan 2024 18:08:22 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
Message-ID: <CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com>
Subject: Re: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:08=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Wed, Jan 17, 2024 at 1:07=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel=
org> wrote:
> >
> > Gently ping,
> >
> > I would like to know this is enough or I should add more info/update.
>
> I still am not sure what this is going to be useful for.
>
> Do you have a specific example?

Since there seems to be some communication gap here, I'll give it a try.

First, I'll paste the key phrase of its use case from the cover letter:

  "we would like to know how long the resume processes are taken in kernel
  and in user-space"

This is a "system measurement" question, for use in tests (e.g., in a
test lab for CI or for pre-release testing, where we suspend
Chromebooks, wake them back up, and measure how long the wakeup took)
or for user-reported metrics (e.g., similar statistics from real
users' systems, if they've agreed to automatically report usage
statistics, back to Google). We'd like to know how long it takes for a
system to wake up, so we can detect when there are problems that lead
to a slow system-resume experience. The user experience includes both
time spent in the kernel and time spent after user space has thawed
(and is spending time in potentially complex power and display manager
stacks) before a Chromebook's display lights back up.

If I understand the whole of Masami's work correctly, I believe we're
taking "timestamps parsed out of dmesg" (or potentially out of ftrace,
trace events, etc.) to measure the kernel side, plus "timestamp
provided here in CLOCK_MONOTONIC" and "timestamp determined in our
power/display managers" to measure user space.

Does that make sense? Or are we still missing something "specific" for
you? I could give code pointers [1], as it's all open source. But I'm
not sure browsing our metric-collection code would help understanding
any more than these explanations.

(TBH, this all still seems kinda odd to me, since parsing dmesg isn't
a great way to get machine-readable information. But this at least
serves to close some gaps in measurement.)

Brian

[1] e.g., https://source.chromium.org/chromiumos/chromiumos/codesearch/+/ma=
in:src/platform2/power_manager/powerd/metrics_collector.cc;l=3D294;drc=3Dce=
8075df179c4f8b2f4e4c4df6978d3df665c4d1

