Return-Path: <linux-kernel+bounces-154386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44908ADB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CC01C211A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530FB12B93;
	Tue, 23 Apr 2024 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Bo7a/SmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FCFC18;
	Tue, 23 Apr 2024 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835331; cv=none; b=b9yVoy68noG6nXxiGnV3+9dW5UiyVh1QuCzpsKOY6ThcoO+acfs80iDfh0WBM5RZgP1cskK2TJcGcGKIiHdRq7iXwci+lmxIIWque1+60/p3xzW7a3gVgmFDJxVqTLdk7yngG+7mqnI4OJXvblWZTo6jtzm3C9Q7D5SC7oKqvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835331; c=relaxed/simple;
	bh=Ih5x3U7p/xtVraTTykRD3OsOwljk9aCuZMTsbHhk8XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxHbNtd3xOPe/tZrkAQP1hzQ2ynbmbtk4jw/d2fViXUd+kcWxHhf1UPjL/WLzUfHtOmZU1OYIQjvjkBssOBRmg6kAGCtccecMvpspZrHQewt0itr9tdCr4eCsIu62hI5fTd0nyp61iVcNeHy123lODtEMmj6UpHQkI1nzX1Be2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Bo7a/SmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A225CC113CC;
	Tue, 23 Apr 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Bo7a/SmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713835327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABtPQ8N241McwH5nBg097+oC8v9+e969bZpbfxdAxJg=;
	b=Bo7a/SmOoG+JYtN0U12s/KdN/K9YPwQO2U7Df3gj0Zy0tHf6yaZ6wf0tUpHaTLTCcWR56o
	2OzydvBrH6TDAOiEJWmz5+SMktEDm21j0O4sXlWNKK9nOENQPpkg7FhCGaulIQ4kTQz6RX
	ckK8y7h3bZBaw+sVwH8zHvzLGsbsTKg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 885dffb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 01:22:06 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3836954276.1;
        Mon, 22 Apr 2024 18:22:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFE59M95gwpK0xW41tk1fcGijHiuASSGjXm664l5iDFOedUgrdC6OWHIiiAI4NBVThC+Fm0KqwPEe8WQ9SU5su/LlZC92c
X-Gm-Message-State: AOJu0YxJlmU18DtPon06cPDT5NwpNd7Rtw0qsr5Sn1R/MR+hh0pzboG1
	Uz2iJDsNkI/dwOQBZNHgh50GfKoaQz5vSWaFdO1T1ZmBRd8T9MgDSrS8+Z7rwBz6Cug90/O03gt
	jmZeO0RudJo/FYtEzowonIkZgf4k=
X-Google-Smtp-Source: AGHT+IHOl/OU0gcvKAzZv+BDUZWeDYaENpYzgHuuBDp9zvpkL5AsnDGHxy57Vi8y+7xvNvjifG8fxHcls0zCXYzjLQs=
X-Received: by 2002:a25:ac90:0:b0:dc6:d258:c694 with SMTP id
 x16-20020a25ac90000000b00dc6d258c694mr1437897ybi.19.1713835324219; Mon, 22
 Apr 2024 18:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114814.24601-1-Jason@zx2c4.com> <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
In-Reply-To: <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 23 Apr 2024 03:21:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
Message-ID: <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Babis Chalios <bchalios@amazon.es>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, Christian Brauner <brauner@kernel.org>, linux@leemhuis.info, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Alexander,

The process here seems weirdly aggressive and sneaky.

On 2023-06-19, I wrote that I didn't want to take this route for
userspace notifications.

Then on 2023-06-28, you wrote to Greg asking him to take it instead of
me. Nine minutes later, Greg said "yea sure." Then he caught up on the
thread and some hours later wrote:

> Wait, no, I'm not the maintainer of this, Jason is.  And he already
> rejected it (and based on the changelog text, I would too), so why are
> you asking me a month later to take this?
>
> Work with the maintainer please, don't try to route around them, you
> both know better than this.

Then on 2023-11-14 you wrote to me again asking me to take it, despite
my earlier reservations not changing in the interim. I didn't have a
chance to reply.

Then on 2023-11-30, Greg weirdly took it anyway, with zero discussion
or evidence on the mailing list as to what had happened.

When I noticed what had happened (while working on his driver in the
process of cleaning up/reworking patches that your Amazon employees
sent me that needed work), suspicious that you tried to "route around"
the proper way of getting this done and trick Greg again into taking a
patch that's not his purview, I asked him wtf happened on IRC:

<gregkh> ugh, sorry, I don't remember that.  I think Alexander talked
to me at plumbers and said, "hey, please take this virt patch"
<gregkh> but you are right, you NAKed it in that thread, I forgot
that, sorry.  Yes, revert it if that's needed.

Greg then ACK'd the revert commit which came with a stable@ marking
and a Fixes: tag (for 6.8, which isn't very old).

So it looks to me like you twice tried to trick Greg into taking this,
succeeded the second time, got caught, and now are trying to make a
regression argument as a means of keeping your sneaky commit in there.
All of this really _really_ rubs me the wrong way, I have to say.

I don't know what holds more weight here -- the predictable regression
argument, or the fact that you snuck nack'd changes into a very very
recent kernel that can still be removed while probably only affecting
you. But I'm obviously not happy about this.

Jason

