Return-Path: <linux-kernel+bounces-43428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982688413BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306821F23B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336C6F090;
	Mon, 29 Jan 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e+F+XGcc"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3386A008
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557934; cv=none; b=NAPszr2yRZHnGkkTYq/weYEVqPXAKSqbAPO7w7qfUppFWkggQD+HY9y50xa+dtgFZPOM2lP4yjbig3ItISLmzVFvaTkhOtkYvQhVX8o3nRCUueX+92CqQZNbQXCMk2PbXgEPBPDRhtHpkmGWqNDR0keRevfw43W42HBuAD2kdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557934; c=relaxed/simple;
	bh=+U42MXYQmyPm0YLTZYN6+NqwTBjYG5RX5rdbE3Yhuts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIxxgwU4R1epDTwmTJ94nmLmj5iIFJ67MlUsuROHX/Y3go4YLYI77VsemPQpiyowS9n7bDDpbvTBS9N5rdSCPx1xuU2obWMKJxvK+kgMxmRNBT+29re1krCkj4HChpbt9If/Ifb0fb+YKAXLcVcpmdYgJkFk1ET3q4wwegt/eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e+F+XGcc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3122b70439so426057166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706557930; x=1707162730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=POvQx/OtzDWk0KpZLv1n2MuJ9LedkHIMhddtK9sWv5M=;
        b=e+F+XGcc/Xysiz2RY2vioan6Fq+ZZyXzafhL04gc0yqdKBiWsZJUgzpRmc/NB+j5vQ
         AmZMfM4dGL0OXsaCkqsA12Ihcvm8JfEDaub+jQyUKzWZwj82HSQpa5UknJmU0V4t/QUp
         gppgh7VO8u9Y1JXAJlaPK8MB5GF8WN96C5O+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706557930; x=1707162730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POvQx/OtzDWk0KpZLv1n2MuJ9LedkHIMhddtK9sWv5M=;
        b=PaHIfndQxoWgKp9rvl1WJDivZg0XxI1nUbjosYQF7BGf7nKdB4asg4/hMNZjGm4eli
         XuZS4t255vD6QBy8ByD3it5CJ9RKFH2HAbFn0ttLc9XeJrd/vzINBcRgKbd7MCPF0iT4
         7sUY0iXJwaVloyfgEwK64Vnx9eI9K8Z5eMVnCQbJjWFxUq+UStsioJLBWfGDRJxHpgJE
         TF4GeoYiU/gkq/pRXh3/9POIs8blueMeyVKFfVAB9t5+MI4ehWTkQcNJlPYW790puorc
         huvdqCNdqla/bo+sYyCq6LfiHZVS3Fe+9gbTRD3h+smUtqUEYD4rcP00NerB4z8Tc6eL
         sgIg==
X-Gm-Message-State: AOJu0YxA9//osY6QN8PH3cREQQ4uIRWia1EMKcM84zA6j/f1eBTQsZ/5
	qdYDzdzxtVQ6576ktsW7528EcbNVckI0DOHHaL1h9RiyqC2lu605F+yNPvuJvIbxHbVyrJ4A8pa
	fH4A=
X-Google-Smtp-Source: AGHT+IGyyNEmAmZSKhq2hE1Coy+jswThmilVQg6d2mukM4r5AggSUxD5mNbecEmt/zEXikY8PjYPTg==
X-Received: by 2002:a17:906:848:b0:a2c:b5a1:f8 with SMTP id f8-20020a170906084800b00a2cb5a100f8mr5631512ejd.37.1706557930209;
        Mon, 29 Jan 2024 11:52:10 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id pw18-20020a17090720b200b00a35c1d11621sm1237876ejb.131.2024.01.29.11.52.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 11:52:09 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1060825a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:52:09 -0800 (PST)
X-Received: by 2002:a05:6402:51ca:b0:55e:e838:a20e with SMTP id
 r10-20020a05640251ca00b0055ee838a20emr3923739edd.25.1706557929185; Mon, 29
 Jan 2024 11:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
In-Reply-To: <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 11:51:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
Message-ID: <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 11:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the patch was completely broken. Here's the one that should
> actually compile (although still not actually *tested*).

Note that this fixes the d_instantiate() ordering wrt initializing the inode.

But as I look up the call chain, I see many more fundamental mistakes.

Steven - the reason you think that the VFS doesn't have documentation
is that we *do* have tons of documentation, but it's of the kind "Here
is what you should do".

It is *not* of the kind that says "You messed up and did something
else, and how do you recover from it?".

So the fundamental bug I now find is that eventfs_root_lookup() gets a
target dentry, and for some unfathomable reason it then does

        ret = simple_lookup(dir, dentry, flags);

on it. Which is *completely* broken, because what "simple_lookup()"
does is just say "oh, you didn't have a dentry of this kind before, so
clearly a lookup must be a non-existent file". Remember: this is for
'tmpfs' kinds of filesystems where the dentry cache cotnains *ALL*
files.

For the tracefs kind of filesystem, it's TOTALLY BOGUS. What the
"simple_lookup()" will do is just a plain

        d_add(dentry, NULL);

and nothing else. And guess what *that* does? It basically
instantiates a negative dentry, telling all other lookups that the
path does not exist.

So if you have two concurrent lookups, one will do that
simple_lookup(), and the other will then - depending on timing -
either see the negative dentry and return -ENOENT, or - if it comes in
a bit later - see the new inode that then later gets added by the
first lookup with d_instantiate().

See? That simple_lookup() is not just unnecessary, but it's also
actively completely WRONG. Because it instantiates a NULL pointer,
other processes that race with the lookup may now end up saying "that
file doesn't exist", even though it should.

Basically, you can't use *any* of the "simple" filesystem helpers.
Because they are all designed for that "the dentry tree is all there
is" case.

                Linus

