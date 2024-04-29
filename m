Return-Path: <linux-kernel+bounces-161654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B98B4F05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4E1F21D90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A07F9;
	Mon, 29 Apr 2024 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YZs4FT6z"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46488387
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351852; cv=none; b=RuIrJAw22+Z6KA4xXUA62DosAX4LbdbRgRAXuuWaeAR/1Xtij/0m5zfpS1IQDjd58lYICpgAhDGtJnFzoA5jZbG39Voly0itNTbgJ5s+JDTU6r7TVGZLSBaNqaAJT3PEdX0z/WjMjXS86hfht+pJB2W3yHIUgNzLi/OdhxwQi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351852; c=relaxed/simple;
	bh=8oDxzBVo1kq0eWqfKhLqk7ONSyhHgSnPk/KmVfBq9lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWXFN3deIoKUgBjb/LC5BEdtLTQamlu+nWnotq+sn8wGxIyo9qBlE3lhMHM8qe93uI5+MDbN6/PtphUADplDSkZ5Ag0yDqEdiUYZhgiJgaFkCBXnJ96HCU7lvwvoNN0d4jjIFw9VNGhCMkYthyX0TPRZfpTtKwQd+XY+SemZmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YZs4FT6z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58d0aea14cso298767766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714351848; x=1714956648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov8T+3rEvepBtcwwxhOn/X1LqhIWl/sTR0FMGae+mzs=;
        b=YZs4FT6z9EdEAf4YJnVf4JJUAXkpCAVFf3hlJQXvctmUOEqWdSk4YhC/b5BcDcTU2L
         r+5rjEbQBTv2koVcwe7zWfCRzhDbOMZDHmI5wUhiASgMJWWEcl9qJUDB4H6RqCUr4Iaz
         6jK8HTlqWj7opAM1ovi0fIt7g3I7wTFIxCho4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714351848; x=1714956648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov8T+3rEvepBtcwwxhOn/X1LqhIWl/sTR0FMGae+mzs=;
        b=R6fP613t/eeURJIyRTUziYQfQgxFEwaf7LMMEpjUOxjAaNsn52ZKHUA3iIC+VVLX7B
         7eA6jaoc4D6Kje7rzhdssu+QN5KDNXiNbPLvoWhZoiom+v7L6g1pizcFKYHpD88AmNGA
         0nz69VEKF81qzLAkDdRlmswb2TmoOFhJhQO3j2SRqrlC/wdXkhEL58FjR/9l/cxVrZn8
         EQVNbaLKo+8g8uPGd8KAbxcuImj8UieSjUUcBsycKyZSMdL34X0gjnmW5u5nJMxp/dDm
         X0u4GILLClogSMyM+1Vn59zlFDnkqeoPhqK5oHMVVUuo269M3G3tCWpcmcW9LDPDrQV4
         LYYA==
X-Forwarded-Encrypted: i=1; AJvYcCU4C3E8iowkM0BjvCHdv4Kz2+D2JKL6j4yKDrc6rd6RBIcNCxb+5N9AgF2s1AsqJ3iZYA5bBvm8LtBCb35WaDwAdhtt4JmUc+XcImmE
X-Gm-Message-State: AOJu0Yw+NaZ+IA024SsLhnBFwcMa++oXknjg3DioB96GlA84tNyMdTU0
	oOLDszFG162qKu9SmzBt3ztD3nNBCtSTDcgx96OEeMiS2MI643dsMoFPr0ZIQ9C7q6KIYr4kI0s
	Vxl6ySg==
X-Google-Smtp-Source: AGHT+IEzui7fBtyhZ0si6FqzOgvO2tRLjaR0J7QMroX0kt9a+X+lJ67UsuMcoXk6l1hQUvczpELLQg==
X-Received: by 2002:a17:907:78ca:b0:a58:bda9:cf2c with SMTP id kv10-20020a17090778ca00b00a58bda9cf2cmr5327171ejc.3.1714351848276;
        Sun, 28 Apr 2024 17:50:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170907360500b00a58a67afd2fsm4900073ejc.53.2024.04.28.17.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 17:50:47 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so157872866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:50:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoomWYKkn1fQVnTIECd9U1+Upafk+JZNS9S/Mlu4VvUTt88he2ps4OCbZseS+eSUhlOCtiHrhRnc5IfpTkYCk968xydFbhFjTBC06f
X-Received: by 2002:a17:906:6d3:b0:a51:a288:5af9 with SMTP id
 v19-20020a17090606d300b00a51a2885af9mr5202593ejb.51.1714351846927; Sun, 28
 Apr 2024 17:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com> <20240428232302.4035-1-hdanton@sina.com>
In-Reply-To: <20240428232302.4035-1-hdanton@sina.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 17:50:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Message-ID: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 16:23, Hillf Danton <hdanton@sina.com> wrote:
>
> So is game like copying from/putting to user with runqueue locked
> at the first place.

No, that should be perfectly fine. In fact, it's even normal. It would
happen any time you have any kind of tracing thing, where looking up
the user mode frame involves doing user accesses with page faults
disabled.

The runqueue lock is irrelevant. As mentioned, it's only a symptom of
something else going wrong.

Now, judging by the syz reproducer, the trigger for this all is almost
certainly that

   bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f00000000c0)={&(0x7f0000000080)='sched_switch\x00', r0}, 0x10)

and that probably causes the instability. But the immediate problem is
not the user space access, it's that something goes horribly wrong
*around* it.

> Plus as per another syzbot report [1], bpf could make trouble with
> workqueue pool locked.

That seems to be entirely different. There's no unexplained page fault
in that case, that seems to be purely a "take lock in the wrong order"

                Linus

