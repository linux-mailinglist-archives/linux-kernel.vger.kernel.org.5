Return-Path: <linux-kernel+bounces-23951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030182B45A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7731C23CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6752F82;
	Thu, 11 Jan 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZGnBV05n"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6D52F60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so7064440a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704995628; x=1705600428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilDm8raeE9xT20TWRdxA4s6W/mK6GtdZjsELca1tIi0=;
        b=ZGnBV05nSmJViUY4XoHCqkkXUekcecRS76mY2VA2KeAyQYbRLaNhiA28Wv6fwHjI4x
         Bh8Ddh6dxyfDFmNzCvPhdxVi1h6uwEd2VDv9uznc1Go/OzvEE4sd6MdMQRQk9PwWKaUO
         9Qeno74SDuP8H/5He0Kkslrzn8fp4WKEOLqJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995628; x=1705600428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilDm8raeE9xT20TWRdxA4s6W/mK6GtdZjsELca1tIi0=;
        b=bjWg3jk6aYhn01Fz1sPWPCr7+zkztu5UChqkaOyJ3aUSDeLB6C6XjnQbK110AA6iej
         d5V9FeWrwqt5Lm/NoAHohvwqS9TqCEoxMoaTYp13TqszRl59SOxN6IiVQqw/lfZuCkyg
         MG8PbPp1yFdTomqViEkVYzjBNeyrv3tTNlPXpdc2o5j1r6GNXi9awEbbCNXbLZ2tN4Pi
         gtxWuBEcnTVKh8jUCrXxwJWPKlBeTbdSskDohWcHHsGzhGGDnYxLYnTU56sWtp0EY0Ic
         1zLyvjRgjjFOXgqptjGulmErxmlNShDtUaFPHaTMX/u9r0gwrH1MVzkYwdT4gMTMhwLs
         yiBA==
X-Gm-Message-State: AOJu0YxRlY4WkIDDDNyHXptl9DrqSt/oacyl72a4oUSDomu102tlnpgE
	2kX61C5Es4fovo27hY5mz+YDi2cpGfmltouSLNAmW/8M7dBT1X3Q
X-Google-Smtp-Source: AGHT+IEQFX1+JiFqPxpKsPF2adqTHrYJjUqEMa9Hvyhobj1mh/t4jkLp6zbN+5C4tSLFerOAPTmlDw==
X-Received: by 2002:a17:906:f895:b0:a2b:f9f7:2b6e with SMTP id lg21-20020a170906f89500b00a2bf9f72b6emr20982ejb.100.1704995628254;
        Thu, 11 Jan 2024 09:53:48 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id bv9-20020a170906b1c900b00a2bfd60c6a8sm835847ejb.80.2024.01.11.09.53.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:53:46 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2a17f3217aso635872766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:53:46 -0800 (PST)
X-Received: by 2002:a17:907:1a55:b0:a2b:1ba9:873b with SMTP id
 mf21-20020a1709071a5500b00a2b1ba9873bmr16085ejc.125.1704995625956; Thu, 11
 Jan 2024 09:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <ZZ+ixagkxRPYyTCE@vingu-book> <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
In-Reply-To: <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 09:53:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
Message-ID: <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 09:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 11 Jan 2024 at 00:11, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Could you confirm that cpufreq governor is schedutil and the driver is
> > amd-pstate on your system ?
>
> schedutil yes, amd-pstate no. I actually just use acpi_cpufreq

Bah. Hit 'send' mistakenly too soon, thus the abrupt end and
unfinished quoting removal.

And don't ask me why it's acpi_pstate-driven. I have X86_AMD_PSTATE=y, but

    /sys/devices/system/cpu/cpufreq/policy0/scaling_driver

clearly says 'acpi-cpufreq'. Maybe I'm looking in the wrong place. My dmesg says

    amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

which is presumably the reason my machine uses acpi-pstate.

I will also test out your other questions, but I need to go back and
do more pull requests first.

              Linus

