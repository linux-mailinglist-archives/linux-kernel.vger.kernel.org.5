Return-Path: <linux-kernel+bounces-31935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE818336A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D678C1F21C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47714A92;
	Sat, 20 Jan 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UoVe0xuJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5215D0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705789137; cv=none; b=Av3pGrfdPPVT2DjSZQn1kH2L1B8X/IWngLETZWPJm9pkkQIoZtiN+3C+xYFoIK7nRkazeGhxbd6e962NGAM8xxMTMTk1Vls1TH9AgelWJLW4ZJZJ5APXe6/h4WfzCOrB+OqHFcE/KeZAvi4h+xymzMySHCMdhElCdGvEyRaHlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705789137; c=relaxed/simple;
	bh=WUDq2Z8n1nV52ODBFppGnHIdnKgcTnlldqo/+wzLe0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0mGMZxMXwr4WozIZDw9yqsnp2v2tjK0I6iSBe4x5R8OaOOvHgmIi29wg+PzUVX386PCdbOWrmWrIAJiAFtoyOuGjIgbttbLLhsSOUPbzq6FpZiMW2eyuvs4smRwQ0nktJA7CeVIFdWG1BnOOenYrdGYsgkYwp3kqLj80/3DTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UoVe0xuJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2cad931c50so196411966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 14:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705789134; x=1706393934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NHlVF1BGxTeyZfY4BRTZalN1aLn9NZnUwzv1lR3Euas=;
        b=UoVe0xuJjR5UfaJEpMKD816H9SsYUgMMTz/jPPqvmkPSKCNboOeRX8B7B/Yz9KOnhO
         gkn9EBgY+Jf+bR8oBqiM3xMmp4h1wq9hk9EfZS1RJ5ODQlgUZUhD00n7jtnfIX1hfkQ6
         iXVR9gnjM6aWTMbvvFh2EgD2XrYB/DmufZzOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705789134; x=1706393934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHlVF1BGxTeyZfY4BRTZalN1aLn9NZnUwzv1lR3Euas=;
        b=cNp4Y4Sf0o2on3hkR3tKlUTJKA8Vzsju5nl+6a5CZxUyMsyGoLIsjYvuF8+e1gWwy6
         nz4rFTSQv2AXmrJGYN2F+/82nsr2ocYUYBK1sUhM28AyAcMdk6X+Jtp27XdGEBmeDKwz
         v1JMQRW24Gdl+rt7jo185KD4GoNPmoeRytgVJI0MKIk/5Vu6XFalMVsUWgGlUUoGi6pC
         FTt2tECiKP1Q/A88cxKBMb7uc4rpSlFqhsvLnk8saqe4A/XGLxzx6PY8VUuqPL68sW6K
         GNS+6zfN/p0x1rQDbEnDhsEauic5K4tQbjqDTY/HO8NTLtaghg4K66jLuoe1wOv353w7
         YIrw==
X-Gm-Message-State: AOJu0YwZW0B/GkOO+MyslEsl9HYQHF5NAWD1j6h02jJF5I3VE09AnDSC
	9mNz2tLPZMjU9b9XfJwqLlP19dSKBsZJ12cf6AqQuJLTkUnRsuMmy1rsZeUWUSqMLYzfkh1Z8cJ
	2GHY0jQ==
X-Google-Smtp-Source: AGHT+IF/iG52ImIeHZv+wLsfCrQZthWjqI9Abhg/cTkx2qtDQgRwMX2DlYjUNsIAGNTLct19jHnH8A==
X-Received: by 2002:a17:907:a78c:b0:a23:4dc0:97eb with SMTP id vx12-20020a170907a78c00b00a234dc097ebmr1133411ejc.14.1705789133849;
        Sat, 20 Jan 2024 14:18:53 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id q5-20020a170906388500b00a28a297d47esm11776974ejd.73.2024.01.20.14.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 14:18:53 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e779f0273so21845465e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 14:18:53 -0800 (PST)
X-Received: by 2002:a05:600c:2043:b0:40e:4388:9a75 with SMTP id
 p3-20020a05600c204300b0040e43889a75mr968527wmg.70.1705789132818; Sat, 20 Jan
 2024 14:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost> <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
 <20240111094711.GT1674809@ZenIV> <20240111100501.GU1674809@ZenIV> <CAHk-=wi-aMO1GuN1odOz4MZksMNECVdrORuXKfqSS9DoTx0yDg@mail.gmail.com>
In-Reply-To: <CAHk-=wi-aMO1GuN1odOz4MZksMNECVdrORuXKfqSS9DoTx0yDg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 14:18:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com>
Message-ID: <CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Kees Cook <kees@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 09:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's the "don't allocate filp until you actually need it" that looks
> nasty. And yes, atomic_open() is part of the problem, but so is the
> fact that wee end up saving some flags in the filp early.

So just an update on this, since I came back to it.

It turns out that the bulk of the cost of the 'struct file *'
allocation is actually the exact same thing that was discussed the
other day about file locking: it's the fact that the file allocation
is done with SLAB_ACCOUNT. See

    https://lore.kernel.org/all/CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com/

and that thread on the recent file locking accounting discussion.

Now, the allocation itself isn't free either, but the SLAB_ACCOUNT
really does make it noticeable more expensive than it should be.

It's a bit more spread out: the cost of the slab allocation itself is
mainly the (optimized) path that does a cmpxchg and the memset, but
the SLAB_ACCOUNT cost is spread out in mod_objcg_state,
__memcg_slab_post_alloc_hook, obj_cgroup_charge,
__memcg_slab_free_hook).

And that actually opens the door up for a _somewhat_ simple partial
workaround: instead of using SLAB_ACCOUNT, we could just do the memcg
accounting when we set FMODE_OPEN instead, and de-account it when we
free the filp (which checks FMODE_OPEN since other cleanup is
dependent on that anyway).

That would help not just the execve() case, but the whole "open
non-existent file" case too.

And I suspect "open()" with ENOENT is actually way more common than
execve() is. All those open->fstat paths for various perfectly normal
loads.

Anyway, I didn't actually write that patch, but I did want to mention
it as a smaller-scale fix (because getting rid of the 'struct file'
allocation entirely does look somewhat painful).

End result: I committed my "move do_open_execat() to the beginning of
execve()" patch, since it's clearly an improvement on the existing
behavior, and that whole "struct file allocations are unnecessarily
expensive" issue is a separate thing.

              Linus

