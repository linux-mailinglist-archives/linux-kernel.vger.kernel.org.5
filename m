Return-Path: <linux-kernel+bounces-48868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D522884628B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2C71C226A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEB3D0A3;
	Thu,  1 Feb 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I1l92IRU"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA043C697
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822496; cv=none; b=HUdlQRiZzqLQlPjZk45IcHQFlygK+B5ap+BShHONfYyu6jkj6SGO5jCeavIEg46z+mMde5pbwq0k2pmZOhb+bcUDJrTIZHvwHe7lC5/leZVpXTjXoi5vMCVCzOE4E6r0m9ozUxDe4JwzSor+xQq++mmxQdWLmeNqsa/fuOXjUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822496; c=relaxed/simple;
	bh=jrI8ExyERWG4CLM/V0Lnvn/sGlAkaSXcTtBVtgvdqzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJl/ylwOyzoErbK5Pcejh7VoYcpa8fXu8HZnYUmQENTIFOBfx3F7N/gyd7OEvb1Kcxlmvx8v8LPPEEL3vqRmAtaz7fyiJ5OUbLOV5XgS0LgzVf0Ec3YiuSGfMoSAkBCQjQMMpVFY1R73K1mE0th4n56JD1qWY6tPeoLzaSdrzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I1l92IRU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a30e445602cso547348266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706822493; x=1707427293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WB3kXG8ybGFOWiQ7cR9rzELbZ2l6A+yjZADDKXb+4k0=;
        b=I1l92IRUI/wtVuyP/GaXA249TDMuMvaieSFw7Gfie+2WVPSXDiJzqBO5eXWmZyUEpk
         n0u1Zuqf785SReV3WEnN9Tbx1d5yEM5TsQrGJ/LWvVpeEuhXYQ1m8aoPOCaKbSe1BTSO
         E3HNFJ5CXDHWLXF9VtWOLWOrFYi27sHJdNOYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706822493; x=1707427293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB3kXG8ybGFOWiQ7cR9rzELbZ2l6A+yjZADDKXb+4k0=;
        b=dkA6CoDqA2aRQj95knxWUdDUNQxm5L4yRz+pmSwxOz0eH+NcUE9Tg2OS5vd1mY7hEk
         kF2SapiOoXT5kxeuzwBDWUvsvfmGigjvcJtptnnFC096eVh6MDg6MCuoP0s09lhTK+AS
         RnuaprmFHq5LnZV1bXDIM3CwQaW20412YZSgypMHqCzE/9Riu4HrKIJXDc5g4cOwYuOQ
         EJ1whDHY674algnrOOHOsb90FVK2BzQx/HNcAs24wMAh7ah/QVtgoSsifdCUc8jmge+H
         C0zLg2ehOQM2LHcLOnRI6bID4FxTBPcAVAUeEB8R4TcfrxEoVdTK3rUQcC/G+uowcTiO
         tH5w==
X-Gm-Message-State: AOJu0YwJuH8QxhM/8MIVXLznB3E1iUWXHUL/IOMi31jPBAHNhKvUTsa+
	d4xBV53uln/4j9dnWqfqHpzDzf1sG7CyfPJYzYr7/OKZJvF8/4sHeBHAPGEuXvtUIyeY46yhxhw
	fpLMwIA==
X-Google-Smtp-Source: AGHT+IGpKN/CQXxHMwW3ysT/+eolkbefGvAoC3rWuKjg0F7T/IgxkZTYRLDXE+q76qxJnvbjSZoRCg==
X-Received: by 2002:a17:906:3751:b0:a30:59d9:58e6 with SMTP id e17-20020a170906375100b00a3059d958e6mr161202ejc.38.1706822492730;
        Thu, 01 Feb 2024 13:21:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7xnzPcgLODjWyWeVYOxTYxhgNMq0tfLeOa/ksf4hVxUmgQfd9trD6LNViWZ+qkbONRmyjaMzbAj4lwd/nnj2ed2zFE98mYg+B5lNg
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906378b00b00a36a7f0f087sm167106ejc.222.2024.02.01.13.21.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:21:32 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so249309a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:21:32 -0800 (PST)
X-Received: by 2002:a50:a691:0:b0:55f:e2ee:6bba with SMTP id
 e17-20020a50a691000000b0055fe2ee6bbamr204398edc.5.1706822492138; Thu, 01 Feb
 2024 13:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201202254.15588-1-acme@kernel.org> <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
 <ZbwJrkkQbUxw-hyb@kernel.org>
In-Reply-To: <ZbwJrkkQbUxw-hyb@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 13:21:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
Message-ID: <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 13:14, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> I should've known better and not send the noisy JSON changes at this
> point in time.

Arnaldo, it's not the JSON changes in the history.

It's the absolute garbage in the *tag* itself. It's crazy. Do this"

   git fetch   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
perf-tools-fixes-for-v6.8-1-2024-02-01

   git cat-file tag FETCH_HEAD

and see complete and utter garbage in the tag contents.

Note: that is not a change *made* by the tag. It's literally just
garbage content in the tag *message* itself.

You have something *seriously* wrong with your scripting or tag
creation workflow.

               Linus

