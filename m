Return-Path: <linux-kernel+bounces-168257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D038BB5CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B503B245D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA958AC3;
	Fri,  3 May 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I041ed7w"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580954BD8
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772038; cv=none; b=CrM5qVFq5be+EeaJhjM548Rz+7wLO03H+MZhuB4t0IRPUQPhT0GBxh9EQsSYj9CdV76thm0QuKrQGphJf/lQCa7MyPf+e2t2VG0MxbMAw2RsgKUg4eFKfpaOO55DDGSfp5nbTPpxDLQyMfq9nWyWhIBtTZyQTEMh+xa66fryB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772038; c=relaxed/simple;
	bh=9Qapmfzm6lSNA1KjLLEHmaWSypEB5MZ/Duccomf7UwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbVzQVh1SznxwWGKLm+C9srm60jsrAY6sEzt/M36TXGVwNej9QkmC2cbqoAP0RMb8b+Wu7jFmccXaaYKWQeg13mlzy5kSH7cW0rc3K1UTeaJsx+KeGTbCcFCsqBPxzha6xd7NiSVvyq3sHZRnoNaA/x+Hp//bhxMgsgJ0gPrzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I041ed7w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599a298990so13922966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714772035; x=1715376835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0cKj1/eeDlsag1nYyx5cuj3RktPC8YvvhuCxa/6SIc=;
        b=I041ed7wq74EqHv+lLpw/4OnY1kI3FzQ0ynGOUp7811sa7ORamvQCjH55bC3YnkSar
         Klx1rhzeK82r5sekSRH+Cic3Wo0satWx94LLNP051CXWwirSPCCliSE8FVQHfxNUSvej
         uk8KtcOJLyEkqe0pyZgWuEHuRw49MMa4Hn1p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772035; x=1715376835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0cKj1/eeDlsag1nYyx5cuj3RktPC8YvvhuCxa/6SIc=;
        b=lXX/SL7nJ1CXyaRv9z7YcqEhevezV13m1PDRl4Ea8W4m3mvkB2cp2ZX2WdvRAz9Pgd
         O/BsXioTV5QupsMQ9v/a73EV11Vt51LD46HByZk9RekjAPJ4kUt2jxtRyFVp9ZmGdHAF
         erba8WUXhMFk4E60jPwJL3IoUH9t/Edk7EGIAMQBatr5cTBBmBmsMOTkyqiGV9jACnVf
         7i3w1+G8zYDuVyHCXwp937KoC1puWXeTq0mCfZjA6svKDeoKPB2rcUHzoHpE3+LnIpkL
         TH9HcQ9w1jRnFUQTVNaxZdvcLKQcZ6e4kJskd3DdnEbVLw6j+D09iPn8AL2XiShPIK2Z
         401Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5rMSUUuqYg0swefKCjDaLb4MyBJTdFxdi8S58H3R6iVWjiiPlOX7zqJS9zIC9cV/q2Vn4aX+/68M6skpzXJ4KtvuVNWJLXY0Vqafn
X-Gm-Message-State: AOJu0YxSNzTgoRPUImWIIJZI6Ist8ZIudSrfCTAbSc5q+Lxo2NSUT4YU
	OdkJqb9vVCM6mNStwhHfKWWiiHVkggy5BMv/sVV0xiu63yXo3NPR08sU/+KEH7DeYXBpI0ULojJ
	fweRToA==
X-Google-Smtp-Source: AGHT+IG8MhpUXmKnXX/11quCokJaAqAwf2Vj5OIgCJccUL6T64QtDABYTBQcAin7T4x/QZrlRzN1Aw==
X-Received: by 2002:a17:906:2492:b0:a59:9f4e:4e3d with SMTP id e18-20020a170906249200b00a599f4e4e3dmr809157ejb.3.1714772034809;
        Fri, 03 May 2024 14:33:54 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a5974a4d662sm1737366ejc.151.2024.05.03.14.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:33:54 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a599a298990so13918466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl+cnbXHSRYiie7KCI+yuTgiWT4lFBoT3lVlxO++wXyqu8eJVhkU1unjlstugFZWwzbGDn5R7utdynpxC5P/zC4T4Bdt9FBmlajPiQ
X-Received: by 2002:a17:906:2c50:b0:a59:761d:8291 with SMTP id
 f16-20020a1709062c5000b00a59761d8291mr2183947ejh.9.1714772033952; Fri, 03 May
 2024 14:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV>
In-Reply-To: <20240503212428.GY2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:33:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
Message-ID: <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: keescook@chromium.org, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:24, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Can we get to ep_item_poll(epi, ...) after eventpoll_release_file()
> got past __ep_remove()?  Because if we can, we have a worse problem -
> epi freed under us.

Look at the hack in __ep_remove(): if it is concurrent with
eventpoll_release_file(), it will hit this code

        spin_lock(&file->f_lock);
        if (epi->dying && !force) {
                spin_unlock(&file->f_lock);
                return false;
        }

and not free the epi.

But as far as I can tell, almost nothing else cares about the f_lock
and dying logic.

And in fact, I don't think doing

        spin_lock(&file->f_lock);

is even valid in the places that look up file through "epi->ffd.file",
because the lock itself is inside the thing that you can't trust until
you've taken the lock...

So I agree with Kees about the use of "atomic_dec_not_zero()" kind of
logic - but it also needs to be in an RCU-readlocked region, I think.

I wish epoll() just took the damn file ref itself. But since it relies
on the file refcount to release the data structure, that obviously
can't work.

                Linus

