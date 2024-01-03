Return-Path: <linux-kernel+bounces-16059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5B823793
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AAE1F25B54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA71DA45;
	Wed,  3 Jan 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aSp1CCxH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F71EB22
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3374c693f92so912634f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704320066; x=1704924866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9MZB2GKQQoVizz0Mae9gZ/uAOfWAVjDPrCIYZs+35rM=;
        b=aSp1CCxH+rQnW9MDXY+6XsfO399ujdTJOF6McZfSZe6t6YPUkAoShgzPMHfO9Z8Gg1
         3Yi3ia0snMiCfvFguzmWMBBlg8vJE4962ohGzlOHOk2txIODJceljR6fD+UXO4F/C8vd
         iJAROsmGdWk9lPi6mkJrwt5cYiNs4EIxrSxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320066; x=1704924866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MZB2GKQQoVizz0Mae9gZ/uAOfWAVjDPrCIYZs+35rM=;
        b=kdPJif8cda/OPUH0o5RVLvkMOJ03fuWGyE07o2R+iXDVNKweOytxjHg7QbnafJNejA
         RC26W0xXZYzJlcMz8TkR2l8EXWa0rKuwVcPpMYflwFJ2b4eGsKgnprNAOmsng0bqnWqF
         jMQu0Gkwoz+7HyEg+E7b2jRhz/WpdYWWvOyB3Nddii7OzigF7SJs4TUJETtDNLP0NfN/
         cWb5kySdv18PzMbw2pqE8hrDQgIzetIHqKhIkpeoS5URuZ5v1SWe0QOCgRELwXpV2Z4k
         kov5ix/g1td3wcKu+PurWltvPwzApZ7X06Vk5oBRE4Ozl48eK46XpFBdVDpbtyjxTulO
         qMjg==
X-Gm-Message-State: AOJu0YxkIvNtuwJEOAYSif6gkCqn1vSpdxbR1AerNU6ijxNd935R2b+6
	tOwCltNQLJ3Pnv7j72MxvdSmCW0E+AAUY2BYfjgodZpBZH37FGP6
X-Google-Smtp-Source: AGHT+IGaBhWcvRo3zC1rTAeoG2zUiz+EJHVKZLw65x4X9oHk3Zpf79Lu2uNY+WC3QJJheO443BqO9w==
X-Received: by 2002:adf:d1e4:0:b0:337:509c:f1c0 with SMTP id g4-20020adfd1e4000000b00337509cf1c0mr316750wrd.46.1704320066541;
        Wed, 03 Jan 2024 14:14:26 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b00555f49e7080sm6543135edb.56.2024.01.03.14.14.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:14:26 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28ac851523so93613666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:14:26 -0800 (PST)
X-Received: by 2002:a17:906:6854:b0:a27:9029:4657 with SMTP id
 a20-20020a170906685400b00a2790294657mr3946525ejs.125.1704320065698; Wed, 03
 Jan 2024 14:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com> <20240103170556.28df7163@gandalf.local.home>
In-Reply-To: <20240103170556.28df7163@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:14:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWbqy-hd-Xo6dwx=6dH+gMyvf_wFtih7eEpBkHyigzJA@mail.gmail.com>
Message-ID: <CAHk-=wiWbqy-hd-Xo6dwx=6dH+gMyvf_wFtih7eEpBkHyigzJA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I actually have something almost working too. Here's the WIP. It only works
> for tracefs, and now eventfs needs to be updated as the "events" directory
> no longer has the right ownership. So I need a way to link the eventfs
> entries to use the tracefs default conditionally.

Ack. So the ->getattr() and ->permission() thing is a bit more
targeted to "look at modes", and is probably better just for that
reason.

Doing it in d_revalidate() is a bit hacky, and impacts path lookup a
bit even when not necessary. But it's still a lot less evil than
walking the dentry tree manually.

So that d_revalidate() patch was more of a "I think you can make it
smaller by just hooking in at this layer"). So d_revalidate ends up
with a smaller patch, I think, but it has the problem that now you
*have* to be able to deal with things in RCU context.

In contrast, doing it in ->getattr() and ->permission() ends up
meaning you can use sleeping locks etc if you need to serialize, for
example. So it's a bit more specific to the whole issue of "deal with
modes and owndership", but it is *also* a bit more flexible in how you
can then do it.

Anyway, your patch looks fine from a quick scan.

                  Linus

