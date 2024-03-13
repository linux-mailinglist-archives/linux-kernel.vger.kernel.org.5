Return-Path: <linux-kernel+bounces-101622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9187A992
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAB31F22DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010433F9;
	Wed, 13 Mar 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB9hh7OY"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794294A04
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340569; cv=none; b=LfQhJgG0npRSGEDKQddWBNi+TCrteqdjipfM1OGAlO2ImiXZEtWM8L6Bnh4p9ZM4s25ggWm6+ZphNsAOIkgmqKZGeZ4mG8DMG3kIjv00uMNtC0iX0ehvaqv05/3AdeFY0LBd6dzsM8npgOFSVmt59AmcXSFJ0U/xrY5dsyaqhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340569; c=relaxed/simple;
	bh=4Jx1cNbMOR6HZAyGd5CeOFh2DVlmrzbJXauFBEFoIMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lN3+Yu+nBFLUmkA7tfFrAqTG6n7+J7MF0ksG66LagV1GhfFO9VHr7HH0fMDJ11yh++ejVB4JuSK4YvmrJMWHNcXuYV2TKgoHPFXbYiJeejLnqvDSqsTU8XCwZ0XH+nN5xN+/bYKpgtLtcp7YM+73QMH6ws0FfM1/blmrGyvUElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CB9hh7OY; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7dc1d027ca8so545825241.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710340566; x=1710945366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io/s7dHkAHb6RnVIc6UpS8ZjyV6CjdJnMEpaFNKkOk0=;
        b=CB9hh7OY7Yfs8eYc26IMPLpA/br1aHTeIblqsbOScREiENxYFOnfvS0MU73it9X43L
         PSsUls3a5OGaMKDIzZ0NuJ/sVlcNsVvpKHvEa7zexatqQI57QROVccSpinwVprvBElan
         99U+hq1TemdLEUhArr4G7XipYGy2xvfkBdzF7E1BML+zHh1bQM9GJSUJ6InYPwVBT6CJ
         geUL21Wd3HlTaJNlDm70vuONHbplsXwYLqzBT+hQvYEuWDwoq8IohD2lIyER3ExWvu3J
         V6OUObmB6c6RpeplhySAzqoBo4j1EaRQ6DiUGkbpzR+w+K8Gqj5haZVJ+voLbVkDczpz
         j0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340566; x=1710945366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io/s7dHkAHb6RnVIc6UpS8ZjyV6CjdJnMEpaFNKkOk0=;
        b=eNkXQ2g/5bxUdZqIHFpDdFUcDr8Ux0RtG/CCbfqkuskMNoyzdH0YALO7KIIb307ivZ
         ODX5kF7TJsZhyUpnt/o7LyoxHsojaLKI0/FrODJcuKdW9GvPz/8qkX/lf/OR3Q8XhkmI
         VcSC89zFjliHF/gnOxLcs91NPLKSu62Ky92iRMlwdBsKKEMZ5bDQ0S9LZ1S0kcPc9uEY
         reUiMgP8WuKXen7zCOXFiDgSj0J1GPTlNMwH+LHCIItCV37usckhVEbYS8mcZureMHTI
         H6lxfSi9X3sYHoWsyqvHx7PisD39EwerRtiqMVSny1cml3Bmz5cvrRQdVhOeL6A/Po24
         XfSg==
X-Forwarded-Encrypted: i=1; AJvYcCVlJux9hm7B1buRKkeELTytpYhuc76XBWYgtW3ISex0IgubEiHLHAaMckXj/h3FFW9G63uc7MeW2BfUCApe7geAbVQl01otH6punyqz
X-Gm-Message-State: AOJu0YzS8xVrJsWd7ri6Qg4kSfwIbx13PzE/31DTW4ApUg3DPLOVO9Oz
	IAo8v6palWq7ItFTi4Ln6QfaiALtXxwltY+9cxz8rKkvyLAB2yOCIjvR5RGmHF6cImgIPE0BDuq
	k4inQi2kfKdiQouPM9uhBBIucBoliuCgzMQaf
X-Google-Smtp-Source: AGHT+IHX75N/xEME3Jbch1ablQ6YKeO5GzIiVXWx6yrQ/uhbTXuIPc/BaiDtToAke2hvqcVRaoRDftJpHvYD5DPZ/mc=
X-Received: by 2002:a05:6122:4d18:b0:4d4:be1:8196 with SMTP id
 fi24-20020a0561224d1800b004d40be18196mr181745vkb.11.1710340566173; Wed, 13
 Mar 2024 07:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
In-Reply-To: <20240312180814.3373778-1-bigeasy@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Wed, 13 Mar 2024 15:35:27 +0100
Message-ID: <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Mar 2024 at 19:08, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi,
>
> Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> the signal gets delayed until event_sched_out() which then uses
> task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> signal is delivered with disabled preemption.
>
> While looking at this, I also stumbled upon __perf_pending_irq() which
> requires disabled interrupts but this is not the case on PREEMPT_RT.
>
> This series aim to address both issues while not introducing a new issue
> at the same time ;)
> Any testing is appreciated.
>
> v1=E2=80=A6v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigea=
sy@linutronix.de/
>     - Marco pointed me to the testsuite that showed two problems:
>       - Delayed task_work from NMI / missing events.
>         Fixed by triggering dummy irq_work to enforce an interrupt for
>         the exit-to-userland path which checks task_work
>       - Increased ref-count on clean up/ during exec.
>         Mostly addressed by the former change. There is still a window
>         if the NMI occurs during execve(). This is addressed by removing
>         the task_work before free_event().
>       The testsuite (remove_on_exec) fails sometimes if the event/
>       SIGTRAP is sent before the sighandler is installed.

Tested-by: Marco Elver <elver@google.com>

It does pass the tests in tools/testing/selftests/perf_events (non-RT
kernel, lockdep enabled). But I do recall this being a particularly
sharp corner of perf, so any additional testing and review here is
useful.

Thanks,
-- Marco

