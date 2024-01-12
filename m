Return-Path: <linux-kernel+bounces-25035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F682C66F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED590B2397C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB439168CD;
	Fri, 12 Jan 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CVU+lC2B"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A315AE3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd33336b32so91056161fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705092592; x=1705697392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AcgekRMTZOGarr1AiT3SZQ4oxXi6ap/AyePT9GwV/oM=;
        b=CVU+lC2BDMBrF5SEU317dpOtxNISZgKFdryEQAxscCxnuXPRyfcI5aKmgPPPrLrXwm
         45pZ5uLS7PDc6e6MYWE5tGabTfmVf5qYyEk8yddwa4uHHnT7gyot53ZBSyR2vVK9knVO
         UD+wjpasVHuUHK7WwImtsrSr4MaflSDSoQh3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705092592; x=1705697392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcgekRMTZOGarr1AiT3SZQ4oxXi6ap/AyePT9GwV/oM=;
        b=ofLLGzQJAw/vn9OQwHH6kS8wFPVOThprvgZUvw2eyo/npMtk9CW26N44pySy7GOqYB
         b/WBSspvnGDNghLd7b0rTK1qysv2CfCpNhEN4/i0fCYdjMbkmlrPhWXj3HODG767iT3R
         OGt2A9r8m1hJRrPcu/OwecjbHUewWk2n7vWVY61oZ+aECdKGKEnSefPRISjQ8sjOvhLK
         XBZD3IBynjfnpXb9cVbJuqoiC7mN0QIx/pkWAF2fRrXzVZ8DUnVd2DWEYblplR93HQv2
         pcgTIvZCIoMwq6mSUj+z+DNMPhGy+TE/7SPmxedfO7hBFwBKZpTLvCfFqLnqURLgNxyd
         /h+A==
X-Gm-Message-State: AOJu0YxmKCKuZVgsuUQKOA9Z+hD/6uTw0nD9THAbaqmdpBGfet9gr17h
	HYNVLauuniKEtFLEfH/O7iHW8ZJM40PqCGwtfUdteMhWpsJr1ceS
X-Google-Smtp-Source: AGHT+IENJ/EkyR/PfWj9EBYT77tP2UCOWPuVH75ue4z1h+rSj/KADhd6hsQwBQiQz+9RotqJg6TlnQ==
X-Received: by 2002:a2e:828a:0:b0:2cc:81d8:5ee8 with SMTP id y10-20020a2e828a000000b002cc81d85ee8mr1110849ljg.56.1705092592060;
        Fri, 12 Jan 2024 12:49:52 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7ccca000000b005572a1159b9sm2162532edt.22.2024.01.12.12.49.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 12:49:50 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e5f746ac4so26441745e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:49:50 -0800 (PST)
X-Received: by 2002:a05:600c:4b0f:b0:40e:585a:c12f with SMTP id
 i15-20020a05600c4b0f00b0040e585ac12fmr1266804wmp.43.1705092590274; Fri, 12
 Jan 2024 12:49:50 -0800 (PST)
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
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com> <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com> <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
In-Reply-To: <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 12:49:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
Message-ID: <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I will test Vincent's test-patch next.

The patch at

    https://lore.kernel.org/all/ZZ+ixagkxRPYyTCE@vingu-book/

makes absolutely no difference. All cores stay at 2.2GHz (ok, so
there's noise, but we're talking "within a couple of MHz of 2.2GHz").

             Linus

