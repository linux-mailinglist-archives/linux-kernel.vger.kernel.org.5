Return-Path: <linux-kernel+bounces-25038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163A82C67F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A891C21F76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281E168D7;
	Fri, 12 Jan 2024 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dUNfJu8+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3A168C6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2bdc3a3c84so360468566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705093472; x=1705698272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=379NH/DRc7y5/q+wxZXouxXkcoZV1s6DfMkXYqpqv6U=;
        b=dUNfJu8+IwJI6uVWkHBf835b29azG43IM4mgl1S8bvb/IwOqwV4Oce0TZhzaoRlvzs
         TPcTgd36pSvBfSQVONk5/ACGPDC3KOBAwALpziZZcyOIuJ4waYiQzOWikANnQTKCto+B
         PuFw1/itzqZQQAMkxbqh3rmvos8Rox8k5AOYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705093472; x=1705698272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=379NH/DRc7y5/q+wxZXouxXkcoZV1s6DfMkXYqpqv6U=;
        b=AKhEuyD4N/ojzkFjzxa8oBO3SNnzD1q5/zC0c88YfIwGETEO3cJtVWxJy4VVKDZgvV
         msNA/cyd8JTL6sy3WOiTVHJVCW39BmVoZw7ciArh6wRwFHyu5MdNQ8/uDQWHuqONQoCo
         18NvbT6dB0adhUti00zmY5teyDBDvoTt1SCGPaJSSW6df5iEb8ev5aO+ugWNZDjPo6OU
         NorvgCaeAtF71a5Jz/LvwQ0yFvCSz/KP4KJg/idc3EMaGqJGked/G9EuzroMnM7klpJP
         cL/zUnmYxZ/aW4KgjuAhSXtbDxBjpyYHPx7lW3II9ng5FiJRV5Pxj/8kAmOTCzKbWfc8
         4PSQ==
X-Gm-Message-State: AOJu0YyPhCeqF3C+oe50f3lxWfNInvid58RvBG2fRnQR7fX8nQaXEI1j
	iuFeFZfwsBTPoZ/E6llqukqNEexv8gCehXF5ej4LbucXiaWw/jtD
X-Google-Smtp-Source: AGHT+IHpfKwGE0RuBm8gwYeBN1h68b57WCP8g18TVBhZjQ5X3jwuzmbnNmiV5RJgloyaxWg0VzAfhQ==
X-Received: by 2002:a17:906:1e89:b0:a2c:2094:5d46 with SMTP id e9-20020a1709061e8900b00a2c20945d46mr924231ejj.81.1705093471909;
        Fri, 12 Jan 2024 13:04:31 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id ga25-20020a170906b85900b00a272de16f52sm2130663ejb.112.2024.01.12.13.04.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 13:04:30 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-558b5f4cf2dso1787107a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:04:30 -0800 (PST)
X-Received: by 2002:a17:907:960c:b0:a28:f5bf:ea68 with SMTP id
 gb12-20020a170907960c00b00a28f5bfea68mr1160474ejc.58.1705093470093; Fri, 12
 Jan 2024 13:04:30 -0800 (PST)
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
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com> <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 13:04:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
Message-ID: <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 12:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> All cores stay at 2.2GHz (ok, so there's noise, but we're
> talking "within a couple of MHz of 2.2GHz").

Note: that is true also when every CPU is fully loaded and I do a real
full build.

So the "empty make" is just my quick test that happens to be
single-threaded and should take just 20s. All my real builds slow down
too, because all CPUs stay at the minimum frequency.

And I just verified that Ingo's revert that only reverts two commits
(commit 60ee1706bd11 in the tip tree), makes things work correctly for
me.

Not surprising, since the bisection clearly pointed at just commit
9c0b4bb7f6303c being the one that caused the issue, but I decided to
just double-check anyway.

So with that revert, for the single-threaded case I see 4GHz+ numbers
(they spread from a single CPU to multiple CPUs once you run the
benchmark a few times).

And then when I run a full parallel build (rather than the
single-threaded empty one), the frequencies drop to ~3.85GHz for the
all-cpu case.

                Linus

