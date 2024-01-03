Return-Path: <linux-kernel+bounces-15942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A178235FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CD31F259D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612621CFB5;
	Wed,  3 Jan 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Haitd8b8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679E1CF94
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a27e323fdd3so298243666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704311853; x=1704916653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHOZq6HPvj4dG+d7G6FK1Ss+OGlgrauAKkpyntxQ1Jk=;
        b=Haitd8b831Jfe2uySpovfluMz4EAlG4YY0ENDnWQ7zMBRnMcKwlyls4SlJxLpIOeWk
         fbuoJPanij6bhpksOSzlWLA8WATelOhq4LFxcmVbelsTqlIqQfDtjCbkgNoGCseMoP6i
         DBJul1V3U2i9bkzm2zYFDgM7xNhWsmn83LVo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311853; x=1704916653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHOZq6HPvj4dG+d7G6FK1Ss+OGlgrauAKkpyntxQ1Jk=;
        b=uTy+1KZ9Cyg07uTGdtkxezdThAEFg4c2Z5v77XtvGbpXYCiHPNG3iNkvC4Vn7pHHY2
         u0tPaemFS+5+l/k8TL+4LqP/JYVQIg59LRdUsnmz6dJYNYokODqMz/wXW0LNU4TQ0KIm
         ECI7GxCwSRDmj1ODynRvNyGI+BjNOHgwb9qZQRz9MhYDv5/ldfb/68/U/bW0GuT2YS3Y
         jAn68hu23CxhjFdlkKPTyqR9+M48El7mQ/5Cag0S9pFJIVdUzBN/fB/lsUQZGfSIWbdy
         MjRec59uEP5q9hf3iXXC1Kyf6vd0PWG6r/flKbXKHgwcfyNDjeRSaD0Xr9qX3BCGSLQY
         pMig==
X-Gm-Message-State: AOJu0Yy4TGEq7IYl9OtkiSRIa3W0Wj442BSNT/6UkwQYx/AJUFiJRXmb
	kEkmRNgSuw/YPlaCjBnI/npisYQREI9hT9HuPwyakedQ93/6vXRG
X-Google-Smtp-Source: AGHT+IFDfsTZPZRl+cyONcbEKOg1kNhp8NtHVUVS58vNqbB8bS8Odv0DGSZrmfg8wcBhotmDoaMBFw==
X-Received: by 2002:a17:907:3688:b0:a27:efde:b354 with SMTP id bi8-20020a170907368800b00a27efdeb354mr2852956ejc.64.1704311853134;
        Wed, 03 Jan 2024 11:57:33 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709062daa00b00a2808ee8ab1sm3004971eji.150.2024.01.03.11.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:57:31 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a27e323fdd3so298241366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:57:31 -0800 (PST)
X-Received: by 2002:a17:906:df13:b0:a28:34e5:b60a with SMTP id
 ie19-20020a170906df1300b00a2834e5b60amr1188633ejc.14.1704311851332; Wed, 03
 Jan 2024 11:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com> <20240103145306.51f8a4cd@gandalf.local.home>
In-Reply-To: <20240103145306.51f8a4cd@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:57:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
Message-ID: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 11:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This doesn't work because for tracefs (not eventfs) the dentries are
> created at boot up and before the file system is mounted. This means you
> can't even set a gid in /etc/fstab. This will cause a regression.

Which is why I suggested

   "I think the whole thing was triggered by commit 49d67e445742, and
    maybe the fix is to just revert that commit"

there was never any coherent reason for that commit, since the
permissions are dealt with at the mount point.

So this all was triggered by that original change that makes little
sense. The fact that you then apparently changed other things
afterwards too might need fixing.

Or, you know, you could do what I've told you to do at least TEN TIMES
already, which is to not mess with any of this, and just implement the
'->permission()' callback (and getattr() to just make 'ls' look sane
too, rather than silently saying "we'll act as if gid is set right,
but not show it").

Why do you keep bringing up things that I've told you solutions for many times?

                 Linus

