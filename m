Return-Path: <linux-kernel+bounces-25160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E782C8C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DE61C21C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD5179BA;
	Sat, 13 Jan 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bpe27UIX"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF12B79
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso8464250a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705109495; x=1705714295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoGLThHnSaP4bd2eglM/Nyo0MIFkY4uCtWC0UmUimCI=;
        b=bpe27UIXzUUxSgXItzs8+TSwTOnGUCEYkKvYrwIELbF5wUdGEIbN0Rt1fPP8jg8L+j
         Mo15E9kYvYp56sRlGeJRoNOmnxXpMDzyMjXrRnmbWSNF1A258eEKY3FnuUJ5Iup+ivT+
         v5BxtSH1A+4Xk676WgcNyxS7g9aZY5bskbcuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705109495; x=1705714295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoGLThHnSaP4bd2eglM/Nyo0MIFkY4uCtWC0UmUimCI=;
        b=hMIqYj6zCwAPnEDy2lkKgKAZcj9x5NuIgn0vY83uhxv2mMaPOCKajTcsjnCMUjujce
         IoFbP030eFvXYx7H22nteYsBxUeBMq82X1nVsXKnyxEsAOAQzpwTD86f5DuoJQZ/AdDu
         9cSMPgc3GeHK9jPbHoNdL4+lp/u30DT2Co5z94u3jMxeJhzUx5OpvAiU283g8AY5RvL+
         fyr7xvn/FJQJdIlkbYmwmSdyQvWpJAO5tuBB7FjNhTO+gnh3Zd9lo/NjHDK8qzqyhFI3
         QPVYpPBcr1ERW1tebo58eSTuAXOCWZVsJ7jxBOdAWXVInlY1K/GYijmr6PTEjEV8g1KV
         Jucg==
X-Gm-Message-State: AOJu0YxeP86K4ESPDCwOaZYzhalWt3kcrTc84Qs5pJROCGLcbbLQupsv
	aNuLrGVAHTwaNSvAk3lgnK27M7AdAd31XeZsmtPfTA1tcQe0JWPi
X-Google-Smtp-Source: AGHT+IEUuuVewKSA0OgLikHrabSLsOPvAHKPXyvOnQaGorSB0vTdUyjAqQs04DT+xxolPlD7tJFVGg==
X-Received: by 2002:aa7:d78e:0:b0:554:10f0:7177 with SMTP id s14-20020aa7d78e000000b0055410f07177mr763445edq.80.1705109495608;
        Fri, 12 Jan 2024 17:31:35 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 7-20020a0564021f4700b00557de30e1f1sm2332220edz.74.2024.01.12.17.31.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 17:31:32 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a29058bb2ceso769574566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:31:31 -0800 (PST)
X-Received: by 2002:a17:907:c287:b0:a2c:b094:f2e9 with SMTP id
 tk7-20020a170907c28700b00a2cb094f2e9mr823454ejc.186.1705109490957; Fri, 12
 Jan 2024 17:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ+ixagkxRPYyTCE@vingu-book> <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com> <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
 <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
 <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
 <20240113010432.xe25lxqogxuvl72t@airbuntu> <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
In-Reply-To: <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 17:31:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMGP2STWAqEO=T3TQUu44ygz2_JpOh65RahEO5Cjc+Yw@mail.gmail.com>
Message-ID: <CAHk-=wjMGP2STWAqEO=T3TQUu44ygz2_JpOh65RahEO5Cjc+Yw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 17:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> With a *working* kernel, I get events, setting the frequency to either
> 2.2GHz (idle) or 3.8GHz (work).

Just to fix that - not 3.8Ghz, but in addition to 2.2 I see 2.8 or 3.7:

  ...
  <idle>-0       [034] d.s..   208.340412: cpu_frequency:
state=2200000 cpu_id=34
     cc1-101686  [034] d.h..   208.342402: cpu_frequency:
state=2800000 cpu_id=34
     cc1-101686  [034] d.h..   208.343401: cpu_frequency:
state=3700000 cpu_id=34
      sh-108794  [029] d.h..   216.401014: cpu_frequency:
state=2200000 cpu_id=29
      sh-108794  [029] d....   216.402670: cpu_frequency:
state=2800000 cpu_id=29
genksyms-108565  [029] d.h..   216.404005: cpu_frequency:
state=3700000 cpu_id=29
  ...

etc.

              Linus

