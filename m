Return-Path: <linux-kernel+bounces-105272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FC387DB40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3191C211C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CF1611E;
	Sat, 16 Mar 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmDWIlef"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D0468E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710614583; cv=none; b=I96sPgSudohphNjWWALGcKhaM45NCohzz+60icITL20cTLejzK+rqtfrw4ktfkuQ5Fs3zAtWjX13Vm+6/nU0JCLzIgjHgGOTOHF5fwKWmxxtLYFZEQnwivkaUDnYoD+mVOuqjFjJAusjN3SnerfA+0Mf3UN97dVJOp1G3FkpLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710614583; c=relaxed/simple;
	bh=VKZjhJVzQP3LfEqci20olDgEm7Ujvftp5WdgHCIuD+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoOty8PHn8LCzuqrHHGM3LpVSHWyFubHswSSGKSXYfizAQaqic7RbmKkk+2h9/Q08pTXK5yb2OO0ooE9wFFOO3Tefcb/ZUnQJ5wkC3NlHl5x313CLw7Tag9ZkrYpGHd5xEkSCrsIa0UFRVaSDzZ40EVTVDuCku8KYRMkxLF9YOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GmDWIlef; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3524700a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710614580; x=1711219380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVAMhQojoyaogORHm9lRJd5kjxn5GQZe8kMwS/E2slE=;
        b=GmDWIlefMTwMPK1/g0Yxa7cWOaj/EM0Ta023WBAwhxNw7EdjCi4NLTWzwXjh/YPGmo
         CxI/emV1fIbQrbjcVMQFJvAclpdJmrViD0jAidXq//HRkxtXnpq8YWmyfZia7nma1bBB
         tUqO3u1fvsP2ZMe7BFY+5ELRzvFTv5qteMZOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710614580; x=1711219380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVAMhQojoyaogORHm9lRJd5kjxn5GQZe8kMwS/E2slE=;
        b=Na8Ynp3AGMtMvUHG7g91qxLYqscjCHCnuFOQV6NWZI9uwQDrF+ZCHMZwKrGukVus3D
         wxD5UqMdD9jNKaP0Q1h+vzdisLJLJgO13J6UdsSku/C/J8N1RWY7zWBBCQlaC1thyGtp
         IBZGN8kAMnAfDCb9ldonbXB+g98fXhV3zUKodyIcYBjVREUe0DPdNIGAhPcAv/PgUUNL
         Do6T8Rh5wst3XFtJVM7Updeh5GFy6SLq04iVKVZ90kkw0QUmpdSbU5VnzBuZ6Pex34Qp
         j9au+pa/11LZiU7BfU6MEU+4YDThiNLvVLxNXh/+G7hPMJsW9SIcm52IUhKuPY4VPMTW
         f26A==
X-Gm-Message-State: AOJu0YwmWTL04S/j7x7o3PMu2R0t/orWC5p8F7LGndDpgwyK/OWEa3WY
	hGGTyzQZHEeNb26YDUoel5BfzLIP4nBTSh5yWBlJf4UlNs9VdN6hsqc/RP1qUhgH5LnQjaOnaj0
	k3e1QzQ==
X-Google-Smtp-Source: AGHT+IHIlCrR3RWD7ij/7a3tXvbY92SA8sP442gXdWDjqMUCpa/PlxusIu2JE7Q4MfwGbQ92fSh4yg==
X-Received: by 2002:a05:6402:4348:b0:567:9fef:f7ee with SMTP id n8-20020a056402434800b005679feff7eemr4833861edc.16.1710614579974;
        Sat, 16 Mar 2024 11:42:59 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id v21-20020aa7d655000000b00568a08a9aacsm2734719edr.22.2024.03.16.11.42.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 11:42:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a467d8efe78so272528766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:42:59 -0700 (PDT)
X-Received: by 2002:a17:907:364:b0:a46:30f4:6321 with SMTP id
 rs4-20020a170907036400b00a4630f46321mr5330377ejb.58.1710614578695; Sat, 16
 Mar 2024 11:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315122934.1d3231ce@gandalf.local.home> <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
 <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com> <20240316142002.7480d74b@rorschach.local.home>
In-Reply-To: <20240316142002.7480d74b@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 11:42:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
Message-ID: <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, 
	John Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>, 
	linke li <lilinke99@qq.com>, Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 11:20, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 1) Rebase without them (I know how much you love rebasing)

This.

Except honestly, the pulls are getting to be so complicated for me
because I have to check them, that I'd really like you to start doing
topic branches for individual things.

That's what we ended up doing with the security layers too, because
there were too many cases of "that is broken, I can't pull it", and
then having one single branch for everything meant that it was always
a "all or nothing" thing.

The security layer issues have largely gone away, but I still pull
things individually, and I think it actually ended up working out
well. Yes, I see more pulls, but not only are they clearer for me, the
code history ends up being much clearer too.

So topic branches tend to make for more actual pull requests, but when
the individual pulls are smaller and have clear "this branch does XYZ
and nothing more", it turns out that the actual effort per pull ends
up being less, and it actually clarifies things a lot too.

In fact, the x86 -tip people ended up doing topic branches just to
make things easier to review, rather than any "I can't pull that"
issues, and I think it actually ended up being something that they
preferred to do anyway.

Now, I'm not suggesting anything like the multiple topic branches from
-tip (from a quick check, there's been a total of 25 tip/tip topic
branches merged just this merge window), but for clear new features
definitely.

And no cross-merges between those topic branches, because that defeats
the whole purpose.

Do you have to do it for the current situation where I just can't take
the mmap stuff? No. But please look at it going forward.

           Linus

