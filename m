Return-Path: <linux-kernel+bounces-15901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51582354E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A74728611E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA91CA93;
	Wed,  3 Jan 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ao4m+7og"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01CA1D526
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so729660966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704308703; x=1704913503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKmjMzWb7Jj/X9j8Rv82hF1TJV7D5FriH7ZLTHY6fDQ=;
        b=ao4m+7ogigntnvTeyIC59CGV9tn7ofZAVy1dd/7fCULOJRl5vI0JEC6tQLnl7e9eJg
         N/gz/zOXgU6Ib+H+s8fTUWfY96ECOWOOKO0No+y2hzF3VRBk+KqaSl4C9CMnXtYJSAf3
         0r4fvMOXzciyDZdGx/86ehjkSunwpu5xHL/mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308703; x=1704913503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKmjMzWb7Jj/X9j8Rv82hF1TJV7D5FriH7ZLTHY6fDQ=;
        b=gHagB4Oa+8xl0es4Kqd3VnSuoCBImpZ+NYs6ospG3EcjcAqpaO6APnU0ym3si6lUsA
         PWZpcra7dBIdNVDGe6FBHiM5I3MCQ3BDvNRR9RikpOT7TIs2B493Zp5Uy+gfsMTsVpCe
         ld3kgy3TNwaeS0TixJzgxQI8AphKgQyXIFdS2OJdeNgOHwygYQ/gYLyMJjs5PbhVpFca
         iHmpSw17rKH7OcDg5ETZ/gAOq24BmX2tC6YnxCsmYgWeDgXgn4JGtRq7CyeTK13HGrdj
         hGXUn6jtcObSfKI0iI5pKvRgSdd9ZI5cDRot3C/Vgm2yjtJjZuJozsld/j4cckO2NzXb
         cu1g==
X-Gm-Message-State: AOJu0YwL9CjqpRW4gWMDzjyMb5Sy/AGSPgVt0FHyAQ6844DFVWfnsw0T
	ZeDehPtCIgfJxM8GLgc95n7XozuNu1hCBa2enmEu73mmZHzfwEHj
X-Google-Smtp-Source: AGHT+IGaKXsd+6CRIABSyTIRzaCuraYjUsxcOWTr15HpccjQhT5zXvwwa+prXUZaogrblqD3bfLISg==
X-Received: by 2002:a17:906:ca1:b0:a23:5411:1c59 with SMTP id k1-20020a1709060ca100b00a2354111c59mr7955801ejh.35.1704308702817;
        Wed, 03 Jan 2024 11:05:02 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id ge24-20020a170907909800b00a1c7b20e9e6sm13020469ejb.32.2024.01.03.11.05.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:05:02 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a27e323fdd3so294206666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:05:02 -0800 (PST)
X-Received: by 2002:a17:906:b114:b0:a27:59a2:93fc with SMTP id
 u20-20020a170906b11400b00a2759a293fcmr5684885ejy.107.1704308701823; Wed, 03
 Jan 2024 11:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com> <20240103135102.38352956@gandalf.local.home>
In-Reply-To: <20240103135102.38352956@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:04:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcVh71g2G-cQQBV_65jM2WJ916oW6Bv0+=xppNtE6Fzw@mail.gmail.com>
Message-ID: <CAHk-=wgcVh71g2G-cQQBV_65jM2WJ916oW6Bv0+=xppNtE6Fzw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 10:50, Steven Rostedt <rostedt@goodmis.org> wrote:
> I think these changes are a bit much for -rc8, don't you?

Oh, absolutely.

None of this is rc8 material apart from the oops fix in your pull
request (which my patch that then removes the whole function did *not*
have - so that patch won't apply as-is to your tree).

But let's aim for a tracefs that doesn't play games with the dcache.

Basically, the dcache is *much* too subtle for a filesystem to mess
with. You should either:

 - be a fully virtual filesystem where the dcache just maintains
everything, and you don't mess with it because you don't need to (eg
tmpfs etc). Everything is in the dcache, and you don't need to touch
it, because you don't even care - the dcache is doing everything for
you.

 - be a "normal" filesystem where the dcache is just a cache, and you
maintain your *own* file data structures, and just get normal lookup
etc ops, and you don't mess with the dcache because it is just doing
its caching thing that you as a filesystem don't care about.

and in both of those cases the filesystem just never has to really
delve into it. But tracefs had this abomination where it maintained
its own data structures, _and_ it tried to make them coherent with the
dcache that maintained part of it. That's the part I hated.

               Linus

