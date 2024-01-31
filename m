Return-Path: <linux-kernel+bounces-45717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DAE843497
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AA61C2569D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249E712B81;
	Wed, 31 Jan 2024 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gZsoelm+"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009920304
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672417; cv=none; b=I5xTMkpk7v75FmU40F8rpKQ8hs4R60zF0ASJybp/YKTl6TZVBPb01aCtFynjh6F5vjo04D5ARXvbortIVmyPHLEcMdB916YcrgAwUqot4awlIxJXS64DMx5soMaCYsf902vqF8fPOl2FrZ012RS5e5saDN4nh8ITXIpEBM92G70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672417; c=relaxed/simple;
	bh=yw1NOpDHyLzhqgRn7bhY/dhSkPQ2PzYELUWet09fCyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd7wCIvCnzchaGc3rFOCmWsDGg2Bw+CX+hAGQtQ0bMG129fjpi9HyJvwLZPgdbEuwHgLaOPpwz8H9j9Ac0uwe3DSls3qhAb1lGT2Sc4uqsZC8SLXrg7wDxu6xLT15Xz6VU5C1BO3VOGKEX+CuHKQ33AJTW2OZZQamm0ffI7DK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gZsoelm+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso4108072a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706672413; x=1707277213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8RGcPR+EINRerlSJ09DwzUdoWhHkZNQ/15Haltdbaks=;
        b=gZsoelm+umAuDJp3o6Xch5DRDE3T3wh+tTYj1V2Wlt92Bh+lXQMfIpQi/MqjdIDjJx
         OLieoIr0ncAnh5HfxOivwJxgAfy8VkX0U/IVeerD3Qu7OWNkZuZmLHoDJzdK0UH/Iw6L
         t+AuWNE+nBjHewJHJ+kBOtCNiD70IfHn8Ci+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706672413; x=1707277213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RGcPR+EINRerlSJ09DwzUdoWhHkZNQ/15Haltdbaks=;
        b=cJZ9LKw+lgD9pv+U7F0m6bcXHPtYoAKXN9UmIc/PvRC1Es3KOsO0RnbG1nyOuzKBy4
         lddX9UzYDRHKrSdvnDAAq4sjbn9MWKY8C80gVKcSflQNpYICqo/KwRgP6hA3SRePXUtG
         qUsOhxJPJHNNjco6VGg7cEiDi/cyN5t6ZeCFdiw3PjFmraE0QnwPXgS7LQMj4wnP3J38
         l8hfCHqgks6eW6yhe0+l4xaFF4+aTYruAHNja1ZeGVl/T+aD/DL5BUDT5FCHHvflED77
         g5hgZz28mEU4HBGa2Xne3YGBsVaRtKFPuYH5W/5hEoUJQ6wqPwG9SvU1CGXePgCgwRIr
         EdPQ==
X-Gm-Message-State: AOJu0YyLgVl0QakAlAwdZ1hpinPUajCB4HhAQnS8UdYevaFytHYh9W4z
	Ls50eETYWOUGclTfm1KnqZHvXGeoCzCWjYGzWD2gxTTA9CyHWTBxhYXebwFK/fY4gzeC8G9iGWb
	E4XHIWA==
X-Google-Smtp-Source: AGHT+IEFJx5YYgpt81ZuFV8ud8pqArIysER8djfB7CvpgUXPuC1e1FOjdye/ZYDYRyCO9VJ1qJYewA==
X-Received: by 2002:a50:ed91:0:b0:55f:4ce3:5988 with SMTP id h17-20020a50ed91000000b0055f4ce35988mr183544edr.8.1706672412734;
        Tue, 30 Jan 2024 19:40:12 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d6d8000000b0055f8689ec90sm122994edr.18.2024.01.30.19.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 19:40:12 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so2753096a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:40:12 -0800 (PST)
X-Received: by 2002:aa7:d3da:0:b0:55f:4d7e:e4e9 with SMTP id
 o26-20020aa7d3da000000b0055f4d7ee4e9mr171002edr.21.1706672411784; Tue, 30 Jan
 2024 19:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org> <20240131011246.GP2087318@ZenIV>
 <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com> <20240131024626.GQ2087318@ZenIV>
In-Reply-To: <20240131024626.GQ2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 19:39:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyki7XCnUjaBZSobLaNqWSjg39JhaUjrMH67sYxZLmdQ@mail.gmail.com>
Message-ID: <CAHk-=wjyki7XCnUjaBZSobLaNqWSjg39JhaUjrMH67sYxZLmdQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 18:46, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's to stop ->d_revalidate() from being called in parallel with
> __dentry_kill()?

Oh, you're right.

For some reason I thought we did the d_release() _after_ the RCU grace
period, but we don't.

Why don't we, btw? It would be so much better if we did the
d_release() from __d_free(). We have all that smarts in fs/dcache.c to
decide if we need to RCU-delay it or not, and then we don't let
filesystems use it.

I assume the reason is that some 'd_delete' cases might want to sleep
etc. Still, for things like this that just want to release memory, it
would be *much* better to have d_release called when the dentry is
actually released.

Hmm. Not very many d_delete cases, but I did see a couple that
definitely want process context (dma_buf_release goes to things that
do vfree() etc).

So I guess the "make low-level filesystems do their own kfree_rcu() is
what we're doing.

In this case it's as simple as doing that

-       kfree(ei);
+       kfree_rcu(ei, rcu);

and we'd just make the rcu entry a union with something that isn't
that 'is_freed' field so that it doesn't take more space.

             Linus

