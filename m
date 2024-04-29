Return-Path: <linux-kernel+bounces-162885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0428B61AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342ED2854AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68213D25F;
	Mon, 29 Apr 2024 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FhZFxRnt"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418F13AA52
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417649; cv=none; b=GBfT7jO5iT2iZSryhZ7eOmeJ8g4QQczWfXiYzk7m8U4R5dge/QntkvXBhs2Vmmk1QB8ZqAgXseBnPJrSv1z3m4D51Ra57FBkiftk0LBT5s7Cf6TZLFmg7SRAtrMgNUtYK380Hkq0CtrGovgLMWIzti2JdzAW8jL+mcQ4COH6ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417649; c=relaxed/simple;
	bh=xZ+i34Cf2kb3FAwoHPMUHPU8QtuIKuYH2rbGEJRg9XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTpFnNSEc0LFXduC1YFRmvldoIXXOmaaU/DO9xWulrQ3J+TxVTV89KVumcIJkDzdN7G8/c4cIo7UA/eSkhv6VLzMPdVfXwFsoxjFobHp0ah4mJXom1hPz/+sqRU4lshl4TDU1lsZokQNG//p+6P8zLcrFAtc41v4VhUJ845Z/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FhZFxRnt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5724e69780bso5153739a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714417646; x=1715022446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=va/hNt/iM3MNb7CVvLz718YlZI1otzVGYYp14TWrAyQ=;
        b=FhZFxRnteElRfasvTmJH55CpjLYSKDdv0RmOvGLj5WW9auy4njJh4diQ8nwhW9dJww
         fpfmYv4eeeBBWgtVbrEDs7BoHjC4A+XgQGVIUPUEjhmoJsoFvUFB5m2Rhn50t+1c+e8x
         Go61x1fqExHK8To3htJo64GB7AByQq81I8H2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417646; x=1715022446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=va/hNt/iM3MNb7CVvLz718YlZI1otzVGYYp14TWrAyQ=;
        b=p4UdhNAF5F2u9hAwrj288E1KVG2cJ2m4BR/Hjs0tJ94X1FfHWM0znP0ra0QiuhAfkm
         z6SfWbXRDH5Ke2ZwuNKnCLVFyC9xgPq67XnTRPij7SnH73V0izBwSxkOPsvVV//+qDQh
         zA0yNlHwe2R9DcqG1w+xwz2si/zsYyk/uLHUgoJl5z7llHy5je1eVyVKtVLD0LhiJoca
         hvR77VvK2CAK10me+a6rO7SAAovOscMgCJaLRtYbPsnucH1Yt3gcG2FdYBdovOVduc5E
         Egvy7CWgzavsws3uajjqE2mf4d5EwG/6ha2qmbPgHxFGdtP8qJemhjNFb7f4sUlvRRcf
         xWvA==
X-Forwarded-Encrypted: i=1; AJvYcCW127CK88GQBhnYAdpK5GA6l2R0LCF+8qfLaSowTGCzBI7xodqqqZf7STsdufdHX8VIbTnQ0XaMkUN8173bs3F2Ubvv7N/4cJXfSXe5
X-Gm-Message-State: AOJu0YxgXJtk6qRZ7JOBiDqgdCNHf1IbahYEC6tQKWnL8UEZWENAOdiC
	YzQZNy0omNtyqODjW6f0VrLErnSHXYd7feoDUMkbMUsUDBTMv+wiOT5xC8EYMJqTN5aqhVorIsm
	FCAkaPw==
X-Google-Smtp-Source: AGHT+IHW54oNRxW1QetVvwNKvJi8/comRl26hZNjPxIpWr3VOn5SoJvSvxpIh3gtDxpQ69vGVo7dyw==
X-Received: by 2002:a50:d651:0:b0:572:47be:be36 with SMTP id c17-20020a50d651000000b0057247bebe36mr6712528edj.0.1714417646121;
        Mon, 29 Apr 2024 12:07:26 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id k25-20020a056402049900b005700ef75274sm13369688edv.33.2024.04.29.12.07.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 12:07:25 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55b3d57277so586126466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:07:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFQAdMlE3uzNpDkrSWsGapXGgWFX8cUGLuHMzg5qSg44CyilOxYdES8XeF6blO70cUocu4XNCAzUBsH6EVp6lZfYefTXfxeUX2VKIS
X-Received: by 2002:a17:906:12c1:b0:a55:3707:781d with SMTP id
 l1-20020a17090612c100b00a553707781dmr6853559ejb.73.1714417645239; Mon, 29 Apr
 2024 12:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com> <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
In-Reply-To: <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 12:07:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
Message-ID: <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Ingo Molnar <mingo@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 11:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In particular, I think the page fault emulation code should be moved
> from do_user_addr_fault() to do_kern_addr_fault(), and the horrible
> hack that is fault_in_kernel_space() should be removed (it is what now
> makes a vsyscall page fault be treated as a user address, and the only
> _reason_ for that is that we do the vsyscall handling in the wrong
> place).

Final note: we should also remove the XONLY option entirely, and
remove all the strange page table handling we currently do for it.

It won't work anyway on future CPUs with LASS, and we *have* to
emulate things (and not in the page fault path, I think LASS will
cause a GP fault).

I think the LASS patches ended up just disabling LASS if people wanted
vsyscall, which is probably the worst case.

Again, this is more of a "I think we have more work to do", and should
all happen after that sig_on_uaccess_err stuff is gone.

I guess that patch to rip out sig_on_uaccess_err needs to go into 6.9
and even be marked for stable, since it most definitely breaks some
stuff currently. Even if that "some stuff" is pretty esoteric (ie
"vsyscall=emulate" together with tracing).

                  Linus

