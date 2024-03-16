Return-Path: <linux-kernel+bounces-105288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F160E87DB71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DF91F219AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2681C280;
	Sat, 16 Mar 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F+AkfMcx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23582182B5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710621749; cv=none; b=P8YVKF1NF5BzwwEeuHOshhvaJrrzImw9uE5/YFFQAIE0ox8W9at+w/LVgbL2X8NBaleYnmCrkdGHfjVBhWC7OpukkGvf/TGMPkUN7PM3Xb0mgznscYmf31cft04D4+g5AYjXkYly6beGyeYUnXk3tc8ikQYrMju7dDKk0QTh0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710621749; c=relaxed/simple;
	bh=4DVts3LaFddyaIZPhUKF9mCALyUNNJ1vzsXZqRWfQuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/DTgzBtzw+hZq+VC3b2gHTQUHZ7VYOi63vUaOOKHg/J7Afn9fmXsEl+fvH9onF/Z0XpORw7lJvWkj00X5457X3qAOv4HYOp4wYY6NJ8zq4I1GR7GqgcY+1Za5dcXlCP+h81O8gX0XPvTcXGvZHDrmz9enAMS0rEXavmcnvBsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F+AkfMcx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso4267446a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710621745; x=1711226545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/olCa5XhClUoif8xLGcO50EwYtFIWrYc5w3R35Tn0o=;
        b=F+AkfMcxWqRcBKmqFM/oSeHUQ4GX22MCh4pp+keMdiZKCHAVhHy67nqsonwICxkZjx
         cnxHUciaOhnbfRn5Qz9Qi/CHj5s6b8+l12CHfgQoA8Kw82WBAnTdBHt4d8iEAYuFj8A2
         6Qn0lC3SqBL6yu2m9wDcO40qNEYtFEoAVhldo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710621745; x=1711226545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/olCa5XhClUoif8xLGcO50EwYtFIWrYc5w3R35Tn0o=;
        b=uh4tLZUc60OD1tPPlHH8iqWsgSfiCV7rW5YU1LNCMHeuTdD1xKh4JEO5l+mOtJjLWL
         dvmaTDwD9+qAr0Y4yH/hnz+Q16wkFvcwojDvGorl7VQUEAa/+nY9heEi0+D78QOCcHa9
         nA8fnG/8TL5Ou354X7UsxCF5di27YEBq3cQBVAMCOTfV0JD+VQW7bQgySViJ2p1ethtw
         5oyBApX+1FR+YHaGcRg/RasQOAuyAC1UHHB5EmDbt4/H5x8g2pK6BRVvOYQoaQN6P1h7
         2ThSpdzy44MLuPeoNzi2ZodlAUZDT6Gsi7WBALSJ5E7poZr3Mh3tvPVmmr3g9B2u4z5g
         luWw==
X-Forwarded-Encrypted: i=1; AJvYcCU76kVDRdTCtXJHOpy7pRcvOXZntEl7tnDAxZbmhmRjH+5EmMs6Gjh8EtkcKGx/BKpOThio2ffnlb6uPpVl5KC9eFeMRMhH+g4hxXyI
X-Gm-Message-State: AOJu0YywrOxDv32QTmDE2EIP+UW1t6/b304kJ9toWTRPnodLBkybAACr
	OFoaHhHBdMoQnF1a/cxqjaxT5eMB8Iu92UxcP7CJSQHu1c8I5hrmC8BB8EEy3iH0xq8ytv6a4rL
	yRtcZag==
X-Google-Smtp-Source: AGHT+IFxLDYtCFPenHnHN2FmQ14n8CU9YXcRjte4JEKqOpoJ00nOefhG2GvKKiXRoP1xKlhtMs/eQw==
X-Received: by 2002:a17:906:6d3:b0:a46:b454:47d9 with SMTP id v19-20020a17090606d300b00a46b45447d9mr106734ejb.15.1710621745342;
        Sat, 16 Mar 2024 13:42:25 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id jx11-20020a170906ca4b00b00a46937bc44esm1675871ejb.135.2024.03.16.13.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 13:42:24 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so428949866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 13:42:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8dxQhLWmQtDhWSHCULPntTNN5H8BUHLv5tzSv7JN7xguTl24n03+XbkRJKUp7NvpVMVVyTyNo7hori89XPR03UtdkfXGdDvjtNNb6
X-Received: by 2002:a17:907:a4c3:b0:a44:4c7e:fc07 with SMTP id
 vq3-20020a170907a4c300b00a444c7efc07mr5242267ejc.0.1710621743606; Sat, 16 Mar
 2024 13:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315122934.1d3231ce@gandalf.local.home> <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
 <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
 <20240316142002.7480d74b@rorschach.local.home> <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
 <20240316200015.GAZfX6T9ftKSv0-Zs5@fat_crate.local>
In-Reply-To: <20240316200015.GAZfX6T9ftKSv0-Zs5@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 13:42:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGymybvnQu2=+nzc18HkRudoeJODci13RBDr5afyDjfg@mail.gmail.com>
Message-ID: <CAHk-=wiGymybvnQu2=+nzc18HkRudoeJODci13RBDr5afyDjfg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
To: Borislav Petkov <bp@alien8.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Yiwei <quic_hyiwei@quicinc.com>, John Garry <john.g.garry@oracle.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Thorsten Blum <thorsten.blum@toblux.com>, 
	Vincent Donnefort <vdonnefort@google.com>, linke li <lilinke99@qq.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, x86-ml <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 13:00, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 16, 2024 at 11:42:42AM -0700, Linus Torvalds wrote:
> > Now, I'm not suggesting anything like the multiple topic branches from
> > -tip (from a quick check, there's been a total of 25 tip/tip topic
> > branches merged just this merge window), but for clear new features
> > definitely.
>
> So some of those branches are really tiny (1-2 patches) during some
> cycles so I have often wondered whether I should merge those small
> branches into a single pull...
>
> So as not to have too many tiny pull requests.
>
> Any preference?

Not really any strong preferences.

The really tiny ones are so easy to pull that pulling a few random
ones just isn't an issue.

I've been known to occasionally end up doing an octopus merge if I
decide that I might as well just merge multiple small branches in one
go, but honestly, I stopped doing that because it's just simpler to do
two really trivial merges than to even bother thinking about "should I
just merge these all together".

So I don't mind getting three or more random small pulls if they all
still make sense (ie they are clearly separate things).

Now, if you send me three separate pulls for basically the same
conceptual thing, that might annoy me just because it would be so
pointless.

But if it's a "one pull to fix a single-line issue in resource
control, and another pull to fix a single-line issue in objtool", then
those make perfect sense to keep separate, even if they are both
trivial and small.

And on the other hand, if you have a couple of trivial branches with
no real pattern, and decide to just merge them into one that fixes
"misc x86 problems", and the end result is still completely trivial
and there are no surprises or gotchas, that's not wrong either.

And sometimes, merging and sending me just one pull request is
absolutely the right thing.

For example, the ARM SoC trees tend to just merge "umbrella" updates
into one single pull request, and I prefer that - because I see no
point in getting ten different "this is the drivers for SoC xyz"
thing.

So then it's still a clear topic branch ("ARM SoC drivers"), but they
kept multiple branches for different SoC's and sent me just one pull
request.

End result: there's no one right thing.  Make it make sense. Probably
the only real rule is

 - try to keep conceptually different things separate just for cleanliness

 - definitely keep fundamental new features or anything that _might_
be questionable in a branch of its own

but there aren't some kind of black-and-white rules for "this is so
small that it's not worth sending on its own".

This merge window, I think I currently have something like ~15 merges
that ended up being literally just a couple of lines (maybe spread
over two or three files). I don't mind at all. If that's all that
happened, that's fine.

               Linus

