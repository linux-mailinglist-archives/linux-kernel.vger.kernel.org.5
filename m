Return-Path: <linux-kernel+bounces-138374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652C289F045
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969501C22225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02871598F0;
	Wed, 10 Apr 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C15iyB2/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F446159574;
	Wed, 10 Apr 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746613; cv=none; b=APilqCzc5c5LR3FTfrwaWhrFeBZ/oaw1FM8IO7KQf//5xpf90GYoPMJqOquLYc6WsZzhXI5fTpTSZYu9MFAK8IHGt0JeHTP3A5wI4CZGPlUlvQMfjbRiobQri+Cls+PRc64JYXw4irqyQIFPV6dSqViyk1tfz1e6pveCXw2qhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746613; c=relaxed/simple;
	bh=u9T0l9eXbL58OZvI94dgqt5v5baEh/sBXiJTBgbWk8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw1oboJ2Y1OYK4BGu0FkuErDMyF/+YVRQ7ncTLcrO3KuR0e5PhJju/Tjb4Yq6lFwY8HSVmwwGG8fNBmbVGe61tmFVJJB16aY7ceM2A7Mbxwj6KOV/UCEijN90a8nHFmsg9WMWg+RHVRmzPeZm3fo44pb1msx7y+QaF3WUPopJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C15iyB2/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343e096965bso3566792f8f.3;
        Wed, 10 Apr 2024 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712746610; x=1713351410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqQXPbClifmzWM97HnNjHu4AEdkJ9y2YNxCTb798lyU=;
        b=C15iyB2/ehgAk9S9N7YxLs54wdmOcrlTRMui9oWAapScwC1zEzW/NnSqGzAquFkQec
         NmnmERXBCM8dXczw8EF5A22g3ymeCSfcC8rtwNzGE1a/CoMlkx1JYlMBrFnX4VZHYHTb
         WELyzVARKC/E9L4AZ6k/Y8E9TZwYNG5W7+FB2RdIv/WatWwFYh5oYwLiR+ykIX8HGamN
         ADAh439IXBE56R/n+vvpSzpaqtLj+DtCxgM+t3CatHaCCe75/6qat/kTJTDZgqlR29DF
         okneE0+AL5Ui2bV31IEnZd10fCO015vv9eJzfgzdLyhtv5kav0QioYFQ+zfh36NlSqCa
         Qv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746610; x=1713351410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqQXPbClifmzWM97HnNjHu4AEdkJ9y2YNxCTb798lyU=;
        b=fRRKL7Y/lDzjm5qmWbhgwyFdWDEFKfMiKp+vvwrWj+jvYXNjO0UiZccLZaTc46SE/L
         nPkSGjap5JmLJ+585AKa2FgZCr4XpeRF80LjMFP+Ik2nEyt4cECC8aiYW5Wh3UTZ9szp
         PHZDCsrIzOx7S/PyCyVlT8aSQrNrHl7JWS1W95ircb2WvuFzpXS9qhfL927d81bwECc+
         SU8NQmokSmgMOM61K+eH3LtLP0vm099nPPR8Q7Klc3Tgej8es8kTZHrytvHa8MIyFYCG
         a0dkxq9MHZRjJJlSXQNTqAV4Yetg8/35E0yO5l6wGHzWXeIc2UVZtIXKNlcnt6E5iJIv
         T9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ypd2Qq/7obFR+VdjMSO93IWu447AJfk7qfte+PPl6LQaaqGGKygw6J8Q8T6rwRMTXM1OSxfYeeertyPaQmB7OSGYgTW0ZSkNrHQ5hlVxN/qZEE7hkkWd6ztVu74x5U115x3VFJGLcoVTWZ2hE3OttA838nfraZbdh0S526DiOsXcDis=
X-Gm-Message-State: AOJu0YyrD9Iqc4dfGLhv2vCBf9gWDExh5X4Jeje5Wi+rxgEBH+uzNzSR
	FojNxg8r0OF/JvSEV2xxgdJRg71Z5o3ya7+nZJltfaGpzbVLZTSKHb7ziHkAB/IT89h5S9cNueG
	G/r8OGLBbR6e1W4ItVxM/aVuAYNA=
X-Google-Smtp-Source: AGHT+IFDwOXTXWXGzI7c9IMvMyoqPFnwnsmcmxDtJZBM4XZOGejYBdwRQPhabKya/JxeTUaAKehXTN9ASk6qZZo+pyM=
X-Received: by 2002:a5d:644b:0:b0:341:66c2:3dbb with SMTP id
 d11-20020a5d644b000000b0034166c23dbbmr1636721wrw.30.1712746610430; Wed, 10
 Apr 2024 03:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007b02500614b66e31@google.com> <550cc81a3dffd07ec1235dc32fd7bbde22d9bf57.camel@sipsolutions.net>
In-Reply-To: <550cc81a3dffd07ec1235dc32fd7bbde22d9bf57.camel@sipsolutions.net>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 10 Apr 2024 12:56:39 +0200
Message-ID: <CA+fCnZe_fuT2y4ryFeb8A49k19MY3Nct79JCoGwQh0hjcq6bqA@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING in kcov_remote_start (3)
To: Johannes Berg <johannes@sipsolutions.net>, Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:45=E2=80=AFPM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2024-03-28 at 04:00 -0700, syzbot wrote:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 2400 at kernel/kcov.c:860 kcov_remote_start+0x549/=
0x7e0 kernel/kcov.c:860
>
> This is
>
>         /*
>          * Check that kcov_remote_start() is not called twice in backgrou=
nd
>          * threads nor called by user tasks (with enabled kcov).
>          */
>         mode =3D READ_ONCE(t->kcov_mode);
>         if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
>                 local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>
> but I have no idea what that even means?
>
> > Workqueue: events_unbound cfg80211_wiphy_work
> > RIP: 0010:kcov_remote_start+0x549/0x7e0 kernel/kcov.c:860
> ...
> > Call Trace:
> >  <TASK>
> >  kcov_remote_start_common include/linux/kcov.h:48 [inline]
> >  ieee80211_iface_work+0x21f/0xf10 net/mac80211/iface.c:1654
> >  cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
> >  process_one_work kernel/workqueue.c:3218 [inline]
> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>
> It's a worker thread. Was this not intended to be called in threads?

I think the problem is that the KCOV annotations in the NFC code are
buggy: kcov_remote_stop() is never called if the loop in nci_rx_work()
exits on one of the breaks. With the recent addition of the nci_plen()
check, this started happening often. But breaks existed in the loop
before that too.

We need to move kcov_remote_stop() into the loop and call it every
time the loop exits.

Dmitry, could you PTAL and confirm this? You added the annotation for
NFC, AFAICS.

Thanks!

