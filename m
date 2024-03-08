Return-Path: <linux-kernel+bounces-97562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82BD876BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24290B21D87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF85E071;
	Fri,  8 Mar 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bfbySoMt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B11D52D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930373; cv=none; b=PqytOwOCJw1QHMeh3qR1GwDyrdv6Il14Z6oUoxfn6dg4ljobclgBFXwazf2sb8mkCNiEhHT4KNQlcqeF5hPoi+Ve5n/JD5YNZofwdq7NAf2eqTWsLRdkCITyKTDdwl4rdU5D6CiJO2kZYM8ReJqp6Qfemt6xmOneY8aGjVYNmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930373; c=relaxed/simple;
	bh=UogInE1oek8uNz978Fr2Y00YKfvATmfN6x91AoetXLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXleQRpcfpJVK47WdMqyvaVIwdz72rcJXckuU8TKofs71KCRf84KNNGyVIAdFXQB54+F5j2LGfQJtnNOJiOq3QYlO/mHwjXNVivZB9x537F/xK9G4zSBMg/2iLgwIggkrgTFdcvIbdJwY4THvSUBCxv2lie/ektZVSXDMTa9XY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bfbySoMt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51380c106d9so1502925e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709930369; x=1710535169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwaztDR+5Lsp5aM9L+iH7awTig0xm/0SM0pTAJYMRCo=;
        b=bfbySoMthMQ4qHeppHq9Sn7ImelW/diIyajn3wJ39BsRUNU/edzx2ff9YbNntSX5XD
         pvE0s2SjG0XZlgV29qv+MZIdr4RYa1J/SeeMTcSLp+5u2EhPyXkxMlO1XGPK5fC7WYyx
         QJJep9jWGMG/JhbjPg2qUQRaZlIVOSi4Lbhis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930369; x=1710535169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwaztDR+5Lsp5aM9L+iH7awTig0xm/0SM0pTAJYMRCo=;
        b=AisxtKCJyhQ/1kG9Y++IhRVpz1jJ8AaDGhJkj+a4T3kH4yctiZ6DTRu3DX8Tspqtz/
         4OzNA84II9DUgV352nKNhnjpaHzsrsRcsfdR3xYwnLJAT8wBkbLyd2McmxjUrAXyLsiA
         QzlQmxVfsUrM6Tdk5WANTXlas0SOIyjOMqe+vkfATNVA3SIogNkulcOeL8mj4Jw6iC5R
         uBzmbZ1nj2TOTxDUXV+ilLxkUYR/O1iSxPCOppUpkxdPRWipvqO5zbZG1xwOaG250vvy
         hyD5bU5TlUrivEYGLLY23v9QmVVYyP0TC0gnIoP/szwl3WuvNcvPFWt/s7LP2G0hMNJu
         vPIg==
X-Gm-Message-State: AOJu0Yx3hIY4gPjQsryyrDbTSpKl+fEowE23+nQBkbsLkvTg6QKCe+KE
	dd//1yApUFG1P6t27Sr1x1xpIXDe282/WVFzUwoxtCMSjwLQMf4pwUUPkD/QQ4okzoTgo7A6e2J
	ZDtpr3A==
X-Google-Smtp-Source: AGHT+IFgCMskNPMlpzXg66VtlY9pNAkouMNliqdDgyti0vkgTw72LQ6rMrUD5pqU6sYLNrWtYa7JKA==
X-Received: by 2002:ac2:41ce:0:b0:513:1aa4:a374 with SMTP id d14-20020ac241ce000000b005131aa4a374mr87639lfi.2.1709930368982;
        Fri, 08 Mar 2024 12:39:28 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id o3-20020a1709061b0300b00a45646a9e18sm150303ejg.76.2024.03.08.12.39.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 12:39:27 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4467d570cdso152970866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:39:27 -0800 (PST)
X-Received: by 2002:a17:906:4f82:b0:a45:5be1:6e20 with SMTP id
 o2-20020a1709064f8200b00a455be16e20mr91471eju.23.1709930367225; Fri, 08 Mar
 2024 12:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308183816.676883229@goodmis.org>
In-Reply-To: <20240308183816.676883229@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Mar 2024 12:39:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
Message-ID: <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joel@joelfernandes.org, linke li <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> A patch was sent to "fix" the wait_index variable that is used to help with
> waking of waiters on the ring buffer. The patch was rejected, but I started
> looking at associated code. Discussing it on IRC with Mathieu Desnoyers
> we discovered a design flaw.

Honestly, all of this seems excessively complicated.

And your new locking shouldn't be necessary if you just do things much
more simply.

Here's what I *think* you should do:

  struct xyz {
        ...
        atomic_t seq;
        struct wait_queue_head seq_wait;
        ...
  };

with the consumer doing something very simple like this:

        int seq = atomic_read_acquire(&my->seq);
        for (;;) {
                .. consume outstanding events ..
                seq = wait_for_seq_change(seq, my);
        }

and the producer being similarly trivial, just having a
"add_seq_event()" at the end:

        ... add whatever event ..
        add_seq_event(my);

And the helper functions for this are really darn simple:

  static inline int wait_for_seq_change(int old, struct xyz *my)
  {
        int new;
        wait_event(my->seq_wait,
                (new = atomic_read_acquire(&my->seq)) != old);
        return new;
  }

  static inline void add_seq_event(struct xyz *my)
  {
        atomic_fetch_inc_release(&my->seq);
        wake_up(&my->seq_wait);
  }

Note how you don't need any new locks, and note how "wait_event()"
will do all the required optimistic stuff for you (ie it will check
that "has seq changed" before even bothering to add itself to the wait
queue etc).

So the above is not only short and sweet, it generates fairly good
code too, and doesn't it look really simple and fairly understandable?

And - AS ALWAYS - the above isn't actually tested in any way, shape or form.

                 Linus

