Return-Path: <linux-kernel+bounces-166775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4EC8B9F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A231C21785
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342316FF4B;
	Thu,  2 May 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FevljIVB"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B815E5A9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670470; cv=none; b=ix7qXKaYqsKIpDETqASb9j+W3ZGNCtDJBSdLYWg05IHlGCscTkmJabIWUGysliQgv/YfWc5CPlN2xua4pzYhA2vS2QXGrryJJZZ5aaaGez+oc9cYbiRupUsOaw6C/DTG7mIm4KJCc3VQHNogkAgkno64bGZUVzXam1OGOExPSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670470; c=relaxed/simple;
	bh=oxNcBWQxmMinnuPRCnHgfU+zEqGKyyng8T4qsAL+ufM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbbgQr8olaxNtxKIrDdW8XZZ66yZKTp//P4oovlAicLXr546U27F0V0UHR1Ik1t13GRZ3r/LhCjC5M7KI2vMqGzQmUfYjOq5m2K8xrDih3rfCgxCIbXrkW710iu0riVD5XZJMCZUnBW/946fVcXmIEBS+rCge4Xnl+OOKyiL/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FevljIVB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so9965325e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714670466; x=1715275266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IAFt7eBKKgungDlgXUVM9S/K1MsryQKKIBA2KVjr1YE=;
        b=FevljIVBtNzae+cu+q/wb+BEoyzpC2aKX1GW1S4aE+9l8bQPMb7oE2HB96HHze05bX
         4PHq1SDn0EMgpqsDhMvWYyTQ3fqBuGxwns+9pIThO8JI9rm1UKcxYs9ralH6N3E8DYgr
         Ve75NXkwUzbFQTRi6KXqq3g75/1lOsWfISCU3gnU8UPCrdnTmknXS226jnKnLW+MNwYR
         9rfY2an8JUXXiSd/Zk9S8ec9zTLwrdgaT9jD8KZ3C4O/pmJWnxTJVoEhN9gHMG+zrKJ8
         EUjlXZy9mGCfsJSTSX3oxHKl1EUgBZt1cw9vfeProEu0YMM+MQhgMBHEUyq/Cyr12mDp
         I3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670466; x=1715275266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAFt7eBKKgungDlgXUVM9S/K1MsryQKKIBA2KVjr1YE=;
        b=HXp+5+l3svEGq26rbRsHaWysU/50XQuyLFdG2Kgh/O/rueZHdJtA9tFbAcUGaBL1gJ
         lVCJmGj1sTJ5QNJUZUXtFSO5ClLpltbxyx9As2b2lWMooyJcMVKbktQxQq5TcV9cSeHh
         bkV/m+KLo38bqTABtZ/DmCdlhwzLL/85Qr/Sb7QV+a8zvtBENJkiPn0Q2357tZno/ynp
         SRLc1yiGeq+as9m3y9sSvvbXZxV8qaydgndalfuOZX73ke6lvNvszqtQtVye/xvkuqFS
         eCRohM+jaYsjw+i14nFIkj+h9Z4Hl4Ts+cGD9ZgXY14Fts0LZpMErvjbJ8vCUNmSK6g2
         HaMw==
X-Forwarded-Encrypted: i=1; AJvYcCUMONDlqpD1uNvt3gHHj/XAeezTQrzfjCGVBjOy6U26yDEWz/RPjFJVp+9uVEn5HzLiBp2kjPvMENTM11z+JxiVb3p3x0cS3YJMp2oA
X-Gm-Message-State: AOJu0YwppwJ/Vo17tz5UtwLcIJVxATNpHkUd+Py0cdXL5lNrkTNcPvQg
	+6rrWyfbhQeFZi5KE5Z67ZQLobkta0que+eFB+3w9g4JZrU3D7EOqKfkUgmVtCqVxBFhbc1EdfN
	lNAQ4dBFhAVXj3JSGkjOJVfjeh7Qe7cKrRX9a
X-Google-Smtp-Source: AGHT+IFpNRlTHWJL6HXai3hmJK+GuIw3YYYOL/DrnOSaXBdoOfBi4Z5FJUy9J23o3mfrfAr4AkX4h3xDsLMrq2uwIYs=
X-Received: by 2002:a05:6512:3f1a:b0:51d:4473:48eb with SMTP id
 y26-20020a0565123f1a00b0051d447348ebmr423118lfa.38.1714670466174; Thu, 02 May
 2024 10:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com> <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
In-Reply-To: <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
From: Marco Elver <elver@google.com>
Date: Thu, 2 May 2024 19:20:25 +0200
Message-ID: <CANpmjNPtoKf1ysbKd=E8o753JT0DzBanzFBP234VBsazfufVAQ@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 18:42, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/05/02 23:14, Marco Elver wrote:
> > I sent a patch to add the type qualifier - in a simple test I added it
> > does what we want:
> > https://lore.kernel.org/all/20240502141242.2765090-1-elver@google.com/T/#u
>
> Want some updates to Documentation/process/volatile-considered-harmful.rst
> because __data_racy is for patches to add volatile variables ?

This has nothing to do with volatile. It's merely an implementation
artifact that in CONFIG_KCSAN builds __data_racy translates to
"volatile": the compiler will emit special instrumentation for
volatile accesses so that KCSAN thinks they are "marked". However,
volatile is and has been an implementation detail of certain
primitives like READ_ONCE()/WRITE_ONCE(), although as a developer
using this interface we should not be concerned with the fact that
there's volatile underneath. In a perfect world the compiler would
give us a better "tool" than volatile, but we have to make do with the
tools we have at our disposal today.

>   Patches to remove volatile variables are generally welcome - as long as
>   they come with a justification which shows that the concurrency issues have
>   been properly thought through.

My suggestion is to forget about "volatile" and simply pretend it's
data_race() but as a type qualifier, like the bit of documentation I
added to Documentation/dev-tools/kcsan.rst in the patch.

> >
> > I'll leave it to Tetsuo to amend the original patch if __data_racy makes sense.
>
> OK if below change is acceptable.
>
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1012,7 +1012,7 @@ struct file {
>         struct file_ra_state    f_ra;
>         struct path             f_path;
>         struct inode            *f_inode;       /* cached value */
> -       const struct file_operations    *f_op;
> +       const __data_racy struct file_operations   *f_op;
>
>         u64                     f_version;
>  #ifdef CONFIG_SECURITY
>
> Hmm, debugfs assumes that f_op does not change?
>
> fs/debugfs/file.c: In function 'full_proxy_release':
> fs/debugfs/file.c:357:45: warning: initialization discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   const struct file_operations *proxy_fops = filp->f_op;
>                                              ^~~~

Exactly as I pointed out elsewhere: pointers to __data_racy fields now
have to become __data_racy as well:

  const struct file_operations __data_racy *proxy_fops = filp->f_op;

should be what you want there. The type system is in fact helping us
here as intended. :-)

