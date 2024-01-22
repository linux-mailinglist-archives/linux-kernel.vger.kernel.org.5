Return-Path: <linux-kernel+bounces-32326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BD835A35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A89C1C21AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E14C8E;
	Mon, 22 Jan 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UJwTldj3"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4F4C65
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705900233; cv=none; b=iZrFJQjD1zA+B4GQLQ/rw78IA5YQFjhBVI+IFGR2GUCbcMZDXGFd/xG90moYomwKrOTvKwFdwu/COvA5PM64t5IRq326d5ikXJBT0n5FnqkY5XGlbP1uuecAlEeXFD6ZU7ESwNSrsGauHkjA1AKMdd57TM1C3cwU2vG0sQmcmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705900233; c=relaxed/simple;
	bh=IVCfn+pI29tjNzjS3wp0wFp5/+Z2nUKsVuz8Y3dLxVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e05OQaVqSbuf2WQd2YbVbuzFvde57U91zokpKw8nX5As4fxgdVNrqsD3vRsZULMPrrhLbtRk9OiDefVKcmQKB8v1SOPIhwOThlo+kWskq6kIwKj0GEgLFhtshWL1gzzL22SjG5r3MqknElT/vnMXvUiMx8Z2HFJBkxa2QYZd1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UJwTldj3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e835800adso2828016e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705900228; x=1706505028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bX4dObL3c95165XLM7yzt7rEIgdTlOtpBnPF9EhNwGQ=;
        b=UJwTldj3GGaIHFXa3t4g6hdXwYrLY4N6p7CPUdfNV7bP36LRbM/1cy+YBAilhuKSI8
         f2WFDL9qJTuy8Cd7bTtjVi0l373Y/ZiUBgF+5Qd4Rw3OKSuCv0gO+Jzinr1j8KkV9/jR
         UOATkhdTu21BjVClkPrhAJ7dVgJUeq3pCyHjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705900228; x=1706505028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX4dObL3c95165XLM7yzt7rEIgdTlOtpBnPF9EhNwGQ=;
        b=rhmGxUs19bT3v07knpZSyv0NQRGCj1LQHdUoPLTOzf58/TISCuU2rZhKjPYDx8Z9O+
         vhQCTBr9CuTCX7fRPdBqpr474zwzLvScPL0+SkSUVw1aruCcuAi52HPKjmXNGOx5ZBri
         DH2Rc2yEkq6yBnX66s6UYwjnJakB+CYRBLjLlwyy1DCyM44KOvy/V7KcPPQyXZQrT6YY
         lfqMaJmZuNZSNVuVqV0dHdrhGZv/0zXZKD74X94S0H7dxAsFlo8ihFnEUT+QpVAhDIPd
         sEG0kABWgKgbGHAlVf8+Neb7dAHTJ4e0NFHUJEgKzhp4eK48DGLUdJGJZH8eVPFUHh+G
         wFJw==
X-Gm-Message-State: AOJu0Yx4QJNWYjKWqIYjlG2imnZKf35SuP2UO1MY0tcIKp32HshE6yua
	Rw7k6thVo5fG7rPNQd1DQL8nRdQeJ6YJpKkRI9AmCOPdAxEAOEGbBaecLbrNywLokHzkM1DLt4r
	CEQT2nw==
X-Google-Smtp-Source: AGHT+IFSprsOZOnIXsajITcVNVsO14jnZgJQ0dHjTRAwbKCZ8KzT1yiPHqJVb0pgnWW3GzyC+DccjQ==
X-Received: by 2002:a19:e008:0:b0:50e:8efd:e0c1 with SMTP id x8-20020a19e008000000b0050e8efde0c1mr741141lfg.175.1705900228406;
        Sun, 21 Jan 2024 21:10:28 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id k16-20020a056402049000b0055c2404fbe4sm1247379edv.69.2024.01.21.21.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 21:10:26 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3392ba29845so1284888f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:10:26 -0800 (PST)
X-Received: by 2002:a7b:ce95:0:b0:40e:49ac:e4a6 with SMTP id
 q21-20020a7bce95000000b0040e49ace4a6mr1440118wmj.171.1705900225838; Sun, 21
 Jan 2024 21:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble> <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
 <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car> <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
In-Reply-To: <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 21:10:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
Message-ID: <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 14:56, Shakeel Butt <shakeelb@google.com> wrote:
> >
> > So I don't see how we can make it really cheap (say, less than 5% overhead)
> > without caching pre-accounted objects.
>
> Maybe this is what we want. Now we are down to just SLUB, maybe such
> caching of pre-accounted objects can be in SLUB layer and we can
> decide to keep this caching per-kmem-cache opt-in or always on.

So it turns out that we have another case of SLAB_ACCOUNT being quite
a big expense, and it's actually the normal - but failed - open() or
execve() case.

See the thread at

    https://lore.kernel.org/all/CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com/

and to see the effect in profiles, you can use this EXTREMELY stupid
test program:

    #include <fcntl.h>

    int main(int argc, char **argv)
    {
        for (int i = 0; i < 10000000; i++)
                open("nonexistent", O_RDONLY);
    }

where the point of course is that the "nonexistent" pathname doesn't
actually exist (so don't create a file called that for the test).

What happens is that open() allocates a 'struct file *' early from the
filp kmem_cache, which has SLAB_ACCOUNT set. So we'll do accounting
for it, failt the pathname open, and free it again, which uncharges
the accounting.

Now, in this case, I actually have a suggestion: could we please just
make SLAB_ACCOUNT be something that we do *after* the allocation, kind
of the same way the zeroing works?

IOW, I'd love to get rid of slab_pre_alloc_hook() entirely, and make
slab_post_alloc_hook() do all the "charge the memcg if required".

Obviously that means that now a failure to charge the memcg would have
to then de-allocate things, but that's an uncommon path and would be
marked unlikely and not be in the hot path at all.

Now, the reason I would prefer that is that the *second* step would be to

 (a) expose a "kmem_cache_charge()" function that takes a
*non*-accounted slab allocation, and turns it into an accounted one
(and obviously this is why you want to do everything in the post-alloc
hook: just try to share this code)

 (b) remote the SLAB_ACCOUNT from the filp_cachep, making all file
allocations start out unaccounted.

 (c) when we have *actually* looked up the pathname and open the file
successfully, at *that* point we'd do a

        error = kmem_cache_charge(filp_cachep, file);

    in do_dentry_open() to turn the unaccounted file pointer into an
accounted one (and if that fails, we do the cleanup and free it, of
course, exactly like we do when file_get_write_access() fails)

which means that now the failure case doesn't unnecessarily charge the
allocation that never ends up being finalized.

NOTE! I think this would clean up mm/slub.c too, simply because it
would get rid of that memcg_slab_pre_alloc_hook() entirely, and get
rid of the need to carry the "struct obj_cgroup **objcgp" pointer
along until the post-alloc hook: everything would be done post-alloc.

The actual kmem_cache_free() code already deals with "this slab hasn't
been accounted" because it obviously has to deal with allocations that
were done without __GFP_ACCOUNT anyway. So there's no change needed on
the freeing path, it already has to handle this all gracefully.

I may be missing something, but it would seem to have very little
downside, and fix a case that actually is visible right now.

              Linus

