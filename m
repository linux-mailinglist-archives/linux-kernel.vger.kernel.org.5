Return-Path: <linux-kernel+bounces-105238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D787DAEF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138D21C20C10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D61BC58;
	Sat, 16 Mar 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QVLwXgRh"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D78C07
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608420; cv=none; b=Lw56Cg3L1c/ldR9QRsWI4CdRn9eeQPO1QxRVg7cJoiVEco+pkC1OsXOXnJZsALQKLqgu1re1ODg9062vN1hfVTJEqPqDRIziOiPvXyOQxourbkxjfM+EOkqZrKfIpuHt1sF1dNLedSgGEfQdNsu8WbiXqlO6k4piI7tWciJlKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608420; c=relaxed/simple;
	bh=u/bZv6E05f3mRkmnhykOIIMJBPFXkOhL/ZZY0KaSOUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OelOcHN42lMosHgOfwlHJJ+C+2WtItwfEdvhRMjbOiJpbI4nJXQMKkXp2RsQ/KHRxX8VHplT7bI49+BFCYacgOaf9R53apQM3PF9JyzyZhPxARLnDyDH7FaSYdX6PFd6VGW/bbJ/i7wW0jtNPb4RBZbOjRDMxTUvc1eiXLcnt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QVLwXgRh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513cfd48224so4591521e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710608416; x=1711213216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PWbA0wHuinXi0fph4mmC8TipcDP0qDAWprG2vdMlvMk=;
        b=QVLwXgRhzK7diMNnfzwijtunQFTo0uXFx3fH5SjMFShZ4RC/X8v6gtSRbc9cpPsmyb
         QezrLDIGAHevRuJYpeMY3OMf8A+b4U52YEBUtXg/2pU7QQ0AFQtBoZF8lcDtOs53yEDP
         GkKicRIUU4x935xUqOM9Q8zVMpovKU7PrJJFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710608416; x=1711213216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWbA0wHuinXi0fph4mmC8TipcDP0qDAWprG2vdMlvMk=;
        b=jAqZktrFolfpsiKACQY2gw4Y3Kkp2yaiDTx+4sDf51LkMepLG1nCFsWi41wn3YB3tS
         rBq+1IW4/uolKreGLAGtknpG6y5TCPVzNNww+lAlPW5NwMBA6NuMO7k8J+37aEWJqM0f
         A+bCLOlg92WrB53K6Vnhb+tJbxHjErQ4QhLeIfXfx5K6qSzdsopaTcqrMOjCyr3MppFA
         mhkYbsZnuvHVykLaAKQIUeW24+ZBCMOrWmrp9ndcjov9qdrNTAE5Un0dDSg0iUnCRnGi
         WjS0YaI2ZpAz+riCP2vPZsk8yab+aR9ZKbj0qaif7Q2VYOJzBFlSLJ3MifygEFo4hSIb
         yYUg==
X-Gm-Message-State: AOJu0YyB5Ny9ZffhoS6MWB2qE1YQuLpsmg06fgQFo76mExjGMWWre380
	RzbwP4XQyKv76paDpE7vEooOCb9/oIdNzMVxreu8/MjD6Na9XcLNPhVDAbtYxBCIOFHWCGWxsXA
	C4HKzKQ==
X-Google-Smtp-Source: AGHT+IFYA8UmErZ0zfb0qqsHZLchV8WE9yGRwrxj5LKHX6qLUzZ6O7dby5wVTr+mWCwSoEDmX6FV6g==
X-Received: by 2002:a19:644d:0:b0:513:d5ec:afb with SMTP id b13-20020a19644d000000b00513d5ec0afbmr1531874lfj.40.1710608415705;
        Sat, 16 Mar 2024 10:00:15 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i21-20020a198c55000000b00513137b0178sm1034243lfj.91.2024.03.16.10.00.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 10:00:14 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28051376eso46588981fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:00:14 -0700 (PDT)
X-Received: by 2002:a2e:a164:0:b0:2d4:3e96:47ee with SMTP id
 u4-20020a2ea164000000b002d43e9647eemr1832357ljl.26.1710608414220; Sat, 16 Mar
 2024 10:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315122934.1d3231ce@gandalf.local.home> <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 09:59:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
Message-ID: <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, 
	John Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>, 
	linke li <lilinke99@qq.com>, Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 09:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So instead of merging a new feature that was mis-designed and is
> already having code working around its mis-design, I'm not merging it
> at all.

Here's a clue: when hacking up VFS code, ask for ACK's from the VFS people.

And when hacking up MM code, make damn sure that you have VM people involved.

No more of this "random code that happens to work in my tests"
garbage. Yes, I'm sure that others have done this same disgusting page
counting hack and this was copied-and-pasted from some other
disgusting source, but because of all the history, I'm now looking at
tracing pulls arefully, and I'm simply not allowing any broken hacks.

So in addition to getting actual VM people to help you with mapping
stuff (hard requirement), I would also suggest:

 - your allocation has to be live over the whole mmap (and that's due
to other fundamental issues - you're not even trying to deal with
actual dynamic allocations and thank Cthulhu for that), and the code
is literally designed that way, so then faulting pages in one at a
time and refcounting them one at a time is just pointless and wrong.
Just do it all at mmap time.

 - I'd suggest marking it all VM_DONTCOPY | VM_IO | VM_DONTEXPAND to
not let people play games with the mapping.

 - avoid all the sub-page ref-counts entirely by using VM_PFNMAP, and
use vm_insert_pages()

and a random note:

 - from a TLB pressure standpoint, it might be a good idea to try to
keep the page table entries naturally aligned, so putting that one
status page at the beginning is likely a bad idea. It will typically
mean that hardware that can silently use larger TLB entries for
aligned pages won't be able to do so.

but the effect of that is likely fairly small.

                Linus

