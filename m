Return-Path: <linux-kernel+bounces-88866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5D86E7BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60301C22254
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02141CA98;
	Fri,  1 Mar 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z8ftq+2h"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F632107A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315520; cv=none; b=A1SS/3sK0YcjIKS/o4JI2xeNdgfUUN7BDZmGNNVpIG9pn6uwVDNCj8T1ldnfLHrgMCYhSXO6G6pOZ5qp+IRBOZ+6AdUP/9dHUp9fqe5omNVxIaoNVIkQonH1RK4jC0+k5yQcbl3ShaYUSQ9P4+WJrG1ov+0VHi3RwZyo3pikolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315520; c=relaxed/simple;
	bh=49XDVc09oo1D7rxA4pKGXs7kZYjPBKw7n1z6bPxN2O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVBQFXp1R+Bz4nylp65KZyjgVv7hM1RL6Ign1TMus6DvCV4Ih0cAHgSGoIlkuX0sNgWYSll6EbdIuMdP4oW5rcNMCaDgebK/Jf3SsTHSeBUcLDBIbNG6QcGPOo/tV5g9HZwubUjRVWLIVfPj6RRlqzMRK536iGCWUkGbnv2HreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z8ftq+2h; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d094bc2244so32281761fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709315516; x=1709920316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMbDkgTXsN2/951Q9RWiF9r9QR8HrSOWMnrlfRXcYc=;
        b=Z8ftq+2hBrKePv8z3w/kbq3cLXIWnZi3Y0ul0WgUBnyz856THfNs0tiFI+UfmRGozl
         01KV6ZC6jI51czHKXE2Iyj7PmhoMVla37Xmhd8o/0xATarFq6I3NACAmsQUmvAGip4in
         OBZRFracH8+AVZ+fq9HAGtVJ4rGdS9Bh+Lo78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315516; x=1709920316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzMbDkgTXsN2/951Q9RWiF9r9QR8HrSOWMnrlfRXcYc=;
        b=s+lolhKKg8dN1sI7F7Gq50aK0s/YFkkanh6cZcGQ9hK791Ji0d3nsp/h9zfuuaFbn+
         K1enMyQ7nawq7XmqgHa3KBmHWk2PhiAghij44fw9BA/2J5S4Dj73RH0hwJtRkS76zt8o
         LOsGvzq7dFMjrWSUOLS0IzVQfzd0xLYWxbWy0KE0K7PW+FZ3VGHDHnHBN5LPCJGvNJhc
         pHOz6viQQiyUoTt4er795Iyc7htU0zbgy927FXIui8ZIZbrIH8ljmo6s7JRGx7doq09o
         N+fn4XzybTe5T8n8JkR5qtEa3IBbfwtacB+8cmH1o+6pvz2eBWyTzhUteNckM/8kaZhL
         3XaA==
X-Forwarded-Encrypted: i=1; AJvYcCUEYfT9gS2hMhXeKHv3x6QVB75Tqz7Lhr/RwWbDLYxy059vK4miMkEc68tMX8G8FuHWzxx5gtfTUMOk5xvTKJ0+wWFYVuXfvrUqYryx
X-Gm-Message-State: AOJu0Yw/MPPm4coCOEkKp0PykEbkwd4cLyXOrGDblleLvf0s2osAZdtC
	4LLkwV7NLU3W8Tmmwp1++3Yj11w57yIQVam1Y56of6M2Gncr51UQreXEv26UGGlkhOjom20gUph
	QiUyY1w==
X-Google-Smtp-Source: AGHT+IF/631R2BVTX7YRW5ZiNdKuQ2qEAsoLAU4kVwBPnEZp7mqFu35CZycw4VE57WX0piv9/0r3AA==
X-Received: by 2002:a05:6512:488e:b0:513:506:219d with SMTP id eq14-20020a056512488e00b005130506219dmr1877442lfb.49.1709315516362;
        Fri, 01 Mar 2024 09:51:56 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25a47000000b005131441e4d8sm685795lfn.74.2024.03.01.09.51.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 09:51:56 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so26084871fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:51:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGO2rJZa2fXS/IR2B9I1F7WXEweY0ixYmwjmO1wUHbb16nsyXFn4Xp2VMir4FzKo8mJ+0KNj9r6BszVaOnYjsZTUhgPuQ1WjMGaUQj
X-Received: by 2002:a17:906:5a9a:b0:a44:48db:9060 with SMTP id
 l26-20020a1709065a9a00b00a4448db9060mr1596114ejq.19.1709315494643; Fri, 01
 Mar 2024 09:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz> <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
In-Reply-To: <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2024 09:51:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Message-ID: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 09:07, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> This is just an example of using the kmem_cache_charge() API.  I think
> it's placed in a place that's applicable for Linus's example [1]
> although he mentions do_dentry_open() - I have followed from strace()
> showing openat(2) to path_openat() doing the alloc_empty_file().

Thanks. This is not the right patch,  but yes, patches 1-3 look very nice to me.

> The idea is that filp_cachep stops being SLAB_ACCOUNT. Allocations that
> want to be accounted immediately can use GFP_KERNEL_ACCOUNT. I did that
> in alloc_empty_file_noaccount() (despite the contradictory name but the
> noaccount refers to something else, right?) as IIUC it's about
> kernel-internal opens.

Yeah, the "noaccount" function is about not accounting it towards nr_files.

That said, I don't think it necessarily needs to do the memory
accounting either - it's literally for cases where we're never going
to install the file descriptor in any user space.

Your change to use GFP_KERNEL_ACCOUNT isn't exactly wrong, but I don't
think it's really the right thing either, because

> Why is this unfinished:
>
> - there are other callers of alloc_empty_file() which I didn't adjust so
>   they simply became memcg-unaccounted. I haven't investigated for which
>   ones it would make also sense to separate the allocation and accounting.
>   Maybe alloc_empty_file() would need to get a parameter to control
>   this.

Right. I think the natural and logical way to deal with this is to
just say "we account when we add the file to the fdtable".

IOW, just have fd_install() do it. That's the really natural point,
and also makes it very logical why alloc_empty_file_noaccount()
wouldn't need to do the GFP_KERNEL_ACCOUNT.

> - I don't know how to properly unwind the accounting failure case. It
>   seems like a new case because when we succeed the open, there's no
>   further error path at least in path_openat().

Yeah, let me think about this part. Becasue fd_install() is the right
point, but that too does not really allow for error handling.

Yes, we could close things and fail it, but it really is much too late
at this point.

What I *think* I'd want for this case is

 (a) allow the accounting to go over by a bit

 (b) make sure there's a cheap way to ask (before) about "did we go
over the limit"

IOW, the accounting never needed to be byte-accurate to begin with,
and making it fail (cheaply and early) on the next file allocation is
fine.

Just make it really cheap. Can we do that?

For example, maybe don't bother with the whole "bytes and pages"
stuff. Just a simple "are we more than one page over?" kind of
question. Without the 'stock_lock' mess for sub-page bytes etc

How would that look? Would it result in something that can be done
cheaply without locking and atomics and without excessive pointer
indirection through many levels of memcg data structures?

             Linus

