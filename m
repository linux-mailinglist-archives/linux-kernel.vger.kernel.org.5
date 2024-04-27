Return-Path: <linux-kernel+bounces-161132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF57F8B4779
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5976D281F84
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F03BB20;
	Sat, 27 Apr 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cQeQtxqW"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF33A29A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714244573; cv=none; b=J963p5WR1KVrC85m+PY/GwtmiZTA7w00yqVjV2Ez6CWuB/myGvABeT+rO17r7lWKxE6d4zzWwCuAWF4xtacytog2vHUNUYGNUTcvDfWtYISK4qxIW+NFoKYZqYx+01aqlRZ4VsII00n5TmBe3IK9hdwjlJQU49w0Jm13vR6USJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714244573; c=relaxed/simple;
	bh=zfMWvuo8KGM0LEUnxsmTmqDiqq2kR44rM6AqbMFn7zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtVBIUhi6Q61P1yKdl3LMLvKKa4+7nkBruKex4voXiGwerbpxOXdgXnZ8ay/V1mkhi2118fM2yxhs8hx8KbJ3adsbteMqg3N51pnL0CUE5/adUxY67bNoQs2qOK8ckQUe9l2c4ii6RVtglzPjH4A1E015O9By/KvgTVRtLMphOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cQeQtxqW; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso14774181fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714244570; x=1714849370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w1GCIdsjWlrVsQk7NNBBmnRhr1gy36n2rmXWCKoP5NE=;
        b=cQeQtxqWDMYXq7abrC2YMbGj6JElvxPNxQCdTVIWxraETJFaIHxXZ6obDpf/mbAVI1
         iA+0qVQR1WLXEcLm2JGmtW1ciuwDny5wbWCuAVR6g17YYe0DSfdnYIURXUTZoRLLOg6J
         rSVofajPO8Zi3g3mu39BBSoXyYZP71IoV39a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714244570; x=1714849370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1GCIdsjWlrVsQk7NNBBmnRhr1gy36n2rmXWCKoP5NE=;
        b=HfJHY3I76hN9hE79P5zNJfbaS/w0nB6uS0XBbGAspmyCs44hkSDxR2TaICJbDu87Gn
         4f+zCo3k9KTx0nPTHYxevvdsWtmFF4tLZdfZ7ZMRla11YDb4VCCVOJ5YW2SFS3stU2ZW
         GRB6p4x/Y+sgIRX4rbMUyOJjNp2O8cGDThOZxKQw8ZecCoSvQ8o7B3I8aGB8/RK8IrH1
         tyNVOk1tQAS0kXENUHq2fkRsl3szWeJ3I9nTNVVB4WjMg0ckDh1F+NDcb061vacR/mtU
         OHXak1WoagfElv13XcJFd9LREngvKGYP1hfbDVo9h4OCszW2zyg7E4zMbVMzQHkUME7t
         KXDA==
X-Forwarded-Encrypted: i=1; AJvYcCUqMftqDUp3i0KhD2jRW1b3Hoh3eiv7I64ZVaEywdaJSnLeA3IyQhzmCbgN9+wCBa4z3dWVnxRJkfAQNR4k+rpsjayeUIRRw1TOPZkl
X-Gm-Message-State: AOJu0YxxlnBlEZv/35K8OGJsSG9ofGDNKgchf1h/D9CDb5d6aERqm6/1
	QfOO799hxV7JDNCn7BbUjtfZp+h8q0qL9tng+lOY4skYy/xY4lEOcipyZuuVqm2nnuwAstXVukU
	8
X-Google-Smtp-Source: AGHT+IGyclkti3PvL62BAegyi/GhJ3aI6sRjPXPYl21xYoU8isgELlcvmDZ3Osvovg4VsyPrdoEirw==
X-Received: by 2002:a05:651c:a0d:b0:2dd:d3a0:e096 with SMTP id k13-20020a05651c0a0d00b002ddd3a0e096mr6006569ljq.31.1714244569890;
        Sat, 27 Apr 2024 12:02:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r8-20020a2eb608000000b002d6b801a863sm3072719ljn.34.2024.04.27.12.02.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 12:02:49 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51acb95b892so4015331e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:02:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk0dqCB8XAaF+EYDnWL9od+splepmeOcdhUmmHvnQjOqpAcoG3sqvrbW3xrzjLiQjXX4PtSPBC0Myz0/3La1FJaZyV2YT+SgzFo1PO
X-Received: by 2002:a19:750c:0:b0:519:611f:df49 with SMTP id
 y12-20020a19750c000000b00519611fdf49mr4859014lfe.69.1714244568762; Sat, 27
 Apr 2024 12:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV> <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV> <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh> <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
In-Reply-To: <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Apr 2024 12:02:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
Message-ID: <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 23:21, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting data race between __tty_hangup() and __fput(), for
> filp->f_op readers are not holding tty->files_lock.

Hmm. I looked round, and we actually have another case of this:
snd_card_disconnect() also does

                        mfile->file->f_op = &snd_shutdown_f_ops;

and I don't think tty->files_lock (or, in the sound case,
&card->files_lock) is at all relevant, since the users of f_ops don't
use it or care.

That said, I really think we'd be better off just keeping the current
model, and have the "you get one or the other". For the two cases that
do this, do that f_op replacement with a WRITE_ONCE(), and just make
the rule be that you have to have all the same ops in both the
original and the shutdown version.

I do *not* think it's at all better to replace (in two different
places) the racy f_op thing with another racy 'hungup' flag.

The sound case is actually a bit more involved, since it tries to deal
with module counts. That looks potentially bogus. It does

                        fops_get(mfile->file->f_op);

after it has installed the snd_shutdown_f_ops, but in snd_open() it
has done the proper

        replace_fops(file, new_fops);

which actually drops the module count for the old one. So the sound
case seems to possibly leak a module ref on disconnect. That's a
separate issue, though.

                      Linus

                    Linus

