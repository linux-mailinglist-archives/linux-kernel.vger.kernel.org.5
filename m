Return-Path: <linux-kernel+bounces-43250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563FF84116B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098BA1F27CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8DF3F9F6;
	Mon, 29 Jan 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="heAvSSTb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA7157E64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550973; cv=none; b=HsIuzmrBbm0ZESsbF+/TG1tvIvu4+bc6HTEZfU24Rwv8+SVrYf4H02AlpmpjTnodoqv1rcl6xd2qE/rl4P++BklKxKF/wv6EiBIpP4U2f0yCOdD+7M60mWVl7D0KrrV0OqD/V9eWbasUZES2W9W2UJwlBLZN0ZrvUaat/ubXfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550973; c=relaxed/simple;
	bh=eJ4tB/dpOgHGrxgqDYW104LSCUa8aT6Nh1QEcB2/LFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEnEjrCJkCFDI9UchLuhycGOge4YQw5KTT97B7CSH9ZiVO0QwfWN4rKl40bqhAyCQdKkg6qiiHL5Es/orTGA5Mf/TPiCuObcEUpwB93/htKXiQj0jKi59qOnMFoRP1ZkNu3dNPA0ODEjbzjrBHiLdd7XUmOi9NnxTsJCtsNX/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=heAvSSTb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf42ca9bb2so36705511fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706550970; x=1707155770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkYokCIwpJBz8xiFXNezYEF1FGA6YIGCtwREDWysAIE=;
        b=heAvSSTb75W6Y3CJNKb21/ZtCHt/Bm7spFnt9UT+MeoMP0WaU8+xVdeLjW1Gsip9o/
         j08cG/kTqWr1Mm/650KDN/juOcNmXP5Sv3YuoMvLhEeqMdv2NQAGtIAou7xuFv1bbZKZ
         uGxL75ttWmr7nvcAAtLH5Rm1dJy4yF3dVYBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550970; x=1707155770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkYokCIwpJBz8xiFXNezYEF1FGA6YIGCtwREDWysAIE=;
        b=V7t/vNAuoK3t1MmdQbLsSb43ICY0MBOfek6TtDSNBpPbL4lB2j9nQHdCbLVAHPAcQf
         WTVIuw9gyUvf6rpg1WlK7+pdthiSgQJXD7W7QsQsYU3XUyAP9xrAZvmZDpoCuXNdqPah
         OolHaWAmyZYsZ2QNTPje1N13S9GtcVfaEQYtqhFlnSE4LRouuUcmT11TdpNHIjJnwpId
         itVHIvE0R2nTsedwHpi9XeGnN5XI2See3Tl2FUmB5YJeIKR1O3RRbB0TbuWR3deqV1wE
         pwDEwYE33Jlj0judSEumR58GN4me3huytRPcC/t3/fNU07fx8dKv3gv1mYUKgH/nS7W9
         vc4A==
X-Gm-Message-State: AOJu0Ywxcjz0AI08bSsKkWGxJvC0Lw/LA4NqEX+fwrsecGjKnzhFVEtK
	wM0InRONV5ptfekJy73Z+2TOB5AOMlBsetKyHCuHpzUZzMYCA80fQYggeUwAEyvsBUHJ3qcqu+V
	ydHc=
X-Google-Smtp-Source: AGHT+IGrHBkdHUaTDb2SxKunx0JZoiTau6GOv9cC7LP5t/sf+igFVfIaE26PgpKuV+tF4jpLEYJo+Q==
X-Received: by 2002:a2e:9c4e:0:b0:2cf:33a3:42fd with SMTP id t14-20020a2e9c4e000000b002cf33a342fdmr4145474ljj.2.1706550969999;
        Mon, 29 Jan 2024 09:56:09 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402149900b0055efbf3b5basm1371776edv.56.2024.01.29.09.56.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:56:09 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so3799950a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:09 -0800 (PST)
X-Received: by 2002:a05:6402:2709:b0:55a:392:143e with SMTP id
 y9-20020a056402270900b0055a0392143emr4968057edd.27.1706550969019; Mon, 29 Jan
 2024 09:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
In-Reply-To: <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 09:55:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrTm3_Ro7_0WAsk0CW41g4pg1z7reZh4A0xCeMBUJtpQ@mail.gmail.com>
Message-ID: <CAHk-=wgrTm3_Ro7_0WAsk0CW41g4pg1z7reZh4A0xCeMBUJtpQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 09:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> eventfs_create_events_dir() seems to have the same bug with ti->flags,
> btw, but got the ti->private initialization right.
>
> Funnily enough, create_file() got this right. I don't even understand
> why create_dir() did what it did.
>
> IOW, I think the right fix is really just this:

Actually, I think you have another uninitialized field here too:
'dentry->d_fsdata'.

And it looks like both create_file and create_dir got that wrong, but
eventfs_create_events_dir() got it right.

So you *also* need to do that

        dentry->d_fsdata = ei;

before you do the d_instantiate().

Now, from a quick look, all the d_fsdata accesses *do* seem to be
protected by the eventfs_mutex, except

 (a) eventfs_create_events_dir() doesn't seem to take the mutex, but
gets the ordering right, so is ok

 (b) create_dir_dentry() drops the mutex in the middle, so the mutex
doesn't actually serialize anything

Not dropping the mutex in create_dir_dentry() *will* fix this bug, but
honestly, I'd suggest that in addition to not dropping the mutex, you
just fix the ordering too.

IOW, just do that

        dentry->d_fsdata = ei;

before you do d_instantiate(), and now accessing d_fsdata is just
always safe and doesn't even need the mutex.

The whole "initialize everything before exposing it to others" is
simply just a good idea.

                Linus

