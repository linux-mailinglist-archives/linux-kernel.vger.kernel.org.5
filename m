Return-Path: <linux-kernel+bounces-89534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E97B86F1AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7DB1F21F4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA32BAFF;
	Sat,  2 Mar 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bFn6PqM8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938622F14
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709400299; cv=none; b=Fc/67/BhJt2vuXQ7h+bYp8iwmdOAOVM6v0txczM/U78QT9m7Km3CptHK87lUDoYp9FiIJk/hYP1y9DOHCpTnqwqLU8Cj9gB6gni55V9V0NnNY658H+3eUItJ6buzhSFgWB7z/QUbQfTeZ/mmp47qnon/Kk1sX5ZH6N8RqNFK5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709400299; c=relaxed/simple;
	bh=vl266v+DWxspHYSP5ObZ8S+P5zUYhXz+/kT1sIGtMm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kT9bKxLcBvcm/6uEAfcwICvfIFrl82vhxiiHqv5lL9xCIuG6/ZFWL/G2HgH9c2Ve40U4wA8MK8hCiHOGOOH5Ga/oU5Xc09bWBvahSJcaWzMnwnmVVQblyyInlNBPLivGqiiUPJW8XTKx35GkKyuNVTCy2hZpQE+BqUYZXY0klac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bFn6PqM8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so4052834a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709400296; x=1710005096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjK6wKdnzd4oQb5xoo5+khVVVZu7kTYhRXWNaWHDaW4=;
        b=bFn6PqM8NKwr/2dbFE6Y2yb4J8zvPJbSUY/UBA8rb4h47xM/u84F/e/MtXcNO0Vdtu
         7khuwt4TMIBSIGnJLvlETvDLA/gPMLVD5GRdWKyHZKgaWQ/N7c2iF0TpOjZ104nGaQ+j
         KXuzI4E4Be2ZTgNdErxOHk7ae+THnzaGuHWjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709400296; x=1710005096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjK6wKdnzd4oQb5xoo5+khVVVZu7kTYhRXWNaWHDaW4=;
        b=Eqwi2+gibgL5FEDNZZMjV+bZpewU9GFpRhAQeXImhWGCM3DH37csg/2F6qw0lXg0vf
         Cz4JYvEQMbcN/41qSn+hke/0t/s6Lo2gXX7Bw9Zi8Wx8gEwMUvLsHMiMVJMkb4A2dyx8
         1wI7MQTD8QaWaXpwNSq7PWK0BKMEkcIrUWBZjdFyMN978x1vuqWJ4xERMOUxYqAhcNx0
         Ex4FkrIXMP10P7+h2zaL/dIeWnCCbBjRUGtnG3lACpHPJJKiBcF4uJZrVpvKJIrWVtKX
         RlEVhacMEF78Y9yE1CXUaFvQHirJaaW5FnF6avMcZuToF9AyLispUYGPaaKD1ZMx8n9L
         M/AQ==
X-Gm-Message-State: AOJu0YzY/WBi8XyOZwg0SCJ6vb1IUG4o2+M327TRACjDQBK2qdNXPFHe
	qrGsc0IdT31MH4miPFqSJLHpqFmGeSDrprpR5NKkNTtMbaa10XCBUdUz/bm2ml0EMN65mu23gQT
	//XbYRA==
X-Google-Smtp-Source: AGHT+IG01ceSOIl08D70sRTbnuPcAwPbBMo5S19TGVGAETS49TgI2uq/kCnqI5Dn6I6ClyXwj8MTKQ==
X-Received: by 2002:a17:906:c44c:b0:a3f:804f:c1a4 with SMTP id ck12-20020a170906c44c00b00a3f804fc1a4mr3574404ejb.74.1709400295683;
        Sat, 02 Mar 2024 09:24:55 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id pv25-20020a170907209900b00a3ee9305b02sm2883821ejb.20.2024.03.02.09.24.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 09:24:54 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so4881685a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 09:24:54 -0800 (PST)
X-Received: by 2002:a17:906:a3d8:b0:a44:c2e5:8055 with SMTP id
 ca24-20020a170906a3d800b00a44c2e58055mr2003778ejb.1.1709400294161; Sat, 02
 Mar 2024 09:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home>
In-Reply-To: <20240302111244.3a1674be@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 09:24:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
Message-ID: <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 08:10, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - The change to allow trace_marker writes to be as big as the trace_seq can
>   hold, and also the change that increases the size of the trace_seq to two
>   pages, caused PowerPC kselftest trace_marker test to fail. The trace_marker
>   kselftest writes up to subbuffer size which is determined by PAGE_SIZE.
>   On PowerPC, the PAGE_SIZE can be 64K, which means the selftest will write
>   a string that is around 64K in size. The output of the trace_marker is
>   performed with a vsnprintf("%.*s", size, string), but this write would make
>   the size greater than 32K, which is the max precision of "%.*s", and that
>   causes a kernel warning. The fix is simply to keep the write of trace_marker
>   less than or equal to max signed short.

Please don't just add random limits that are based on other random limits.

That printk warning is for "you did something obviously crazy".

That does NOT MEAN that you now should limit your strings to something
JUST BORDERLINE CRAZY.

See?

There is not a way in hell that printing a 32kB string in tracing is
valid. EVER.

So stop it. Stop making limits be some random implementation detail.
Make limits *sane*.

Make a *sane* limit for tracing. Not a "avoid being called crazy" limit.

Honestly, I suspect that a sane limit for tracing strings is likely on
the order of tens or maybe hundreds of bytes. Not some kind of "fits
in a short" that is just printk saying "I refuse to waste memory on
the stack".

Side note: for similar reasons the field-width is a 24-bit integer.
And no, if you think that passing a 16MB field width is sane, you need
to rethink your life. Again, that's a small implementation detail, not
a "let's explore how stupid we can be".

          Linus

