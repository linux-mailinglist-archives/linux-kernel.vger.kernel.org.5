Return-Path: <linux-kernel+bounces-36952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C883A96D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00A42829F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712AD62A1E;
	Wed, 24 Jan 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eY2C3aO6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A762A19
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098633; cv=none; b=j6cAVxzyZY8xNSUyqI8d+eAKhybXaVl6+OcOn1yXZUWtdw5PCbbAV6EMaH1cT4TdN28lDlUDWQ/1sE1kBk4pvCLkdz4Hlecu7JiOfUONP6JwouOZyyDTE7WO4u7tqn9ZHzOWOic30bx9GXJ3bK7VhgxiQzEGfro9H//+7nuEyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098633; c=relaxed/simple;
	bh=9rIW4BZC82xuUDbZFWKobPmRbLgwvfViOByLftgM8f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLL3B4kbreH+ea84J6hfG9ifna+5G3LK+YibjIqe7KQUEZ2WH8KmrCgRZcTty9OFXQ6HHu24m9Hdw4rQ2mKC3Z6namBJA/aJkhpeC5769tFigQ7Q9jgC6PPV83dnzfrQLT0V13/ah0PQRShabP3aGuyYFRQmwb0C4P02WWrj8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eY2C3aO6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a310409589aso103002666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706098628; x=1706703428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R534gPYSNr7qXXwj05XS3LR+Dft8ZupD8G2mc4eLBbQ=;
        b=eY2C3aO6WLIbI3GT251VVVbSFjASKKxtAzhUmudwDd6PxAXES28URJT61sXMPCvdN+
         qBKu5kDHelOLa/vJEcyuWN3SMyhXFyxWO3qBQ/RzOQfcwJywNdgZ03mfXbNfU8Mkjb5i
         I9Xjdyvb3AMBZo1DFN1+ycalxUOPQVcELysNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098628; x=1706703428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R534gPYSNr7qXXwj05XS3LR+Dft8ZupD8G2mc4eLBbQ=;
        b=rAfJ4JP70LVZHu+b59wmCDiq/WOrL0a4748sDLlqIXuV8vxkPu9j1GDFN+Cps9YFtG
         q8Lg1tIWDka7d1U/YI99Sf6gNDhNzJSdI7fAnF/5I50uBEpQtBeAmUvE2LxldTxaXr+i
         4qByXcEN3pwJCt3H0j62DABWaMDlE8Fo1RrQwymN42SMqQSNyqX553ha4bwSCuRTWKaT
         unnn8Eb7ARqHv3yboI85QodNX6l4AtLjVaDozNs9mimYuwDfrdVQiyvcRinG8qIw3EzJ
         JdyVWsa40GaRxPh1OxcEJ2z1J17GP88zKagFmlpLqEP0j8ZOcx07Zk7h3knzooFlZaeO
         6oNw==
X-Gm-Message-State: AOJu0YyvQ9iS/5VxmXRpQNruI1B1rIjk7jJ+uP8VE4iPTPvqfMHsyr9k
	9vtntnHn7jCxd59p5W5ZnslGEuc63d1aUVot1ddfyzI7OWCRaMz/O6j3aDwH86AmMYcMIH2oa0s
	v68WPG5lggzfkD+9ADQCV8o4QnKwwdCLRFI0r7Q==
X-Google-Smtp-Source: AGHT+IHRFw0weEHminhg3Rf758vsNvpsMk749Qr5zmuq35Cat1GtfJfvnBtbd7XR7W+WKZpKiC/GEmFSgxd7bOxchBw=
X-Received: by 2002:a17:907:a805:b0:a31:4083:4d06 with SMTP id
 vo5-20020a170907a80500b00a3140834d06mr121802ejc.85.1706098628041; Wed, 24 Jan
 2024 04:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124113042.44300-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240124113042.44300-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Jan 2024 13:16:56 +0100
Message-ID: <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add support for explicit export disabling
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 12:30, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> open_by_handle_at(2) can fail with -ESTALE with a valid handle returned
> by a previous name_to_handle_at(2) for evicted fuse inodes, which is
> especially common when entry_valid_timeout is 0, e.g. when the fuse
> daemon is in "cache=none" mode.
>
> The time sequence is like:
>
>         name_to_handle_at(2)    # succeed
>         evict fuse inode
>         open_by_handle_at(2)    # fail
>
> The root cause is that, with 0 entry_valid_timeout, the dput() called in
> name_to_handle_at(2) will trigger iput -> evict(), which will send
> FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will send
> a new FUSE_LOOKUP request upon inode cache miss since the previous inode
> eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
> -ENOENT as the cached metadata of the requested inode has already been
> cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
> treated as -ESTALE when open_by_handle_at(2) returns.
>
> This confuses the application somehow, as open_by_handle_at(2) fails
> when the previous name_to_handle_at(2) succeeds.  The returned errno is
> also confusing as the requested file is not deleted and already there.
> It is reasonable to fail name_to_handle_at(2) early in this case, after
> which the application can fallback to open(2) to access files.
>
> Since this issue typically appears when entry_valid_timeout is 0 which
> is configured by the fuse daemon, the fuse daemon is the right person to
> explicitly disable the export when required.
>
> Also considering FUSE_EXPORT_SUPPORT actually indicates the support for
> lookups of "." and "..", and there are existing fuse daemons supporting
> export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a new
> INIT flag for such purpose.

This looks good overall.

>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linux.alibaba.com/
> ---
>  fs/fuse/inode.c           | 11 ++++++++++-
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2a6d44f91729..851940c0e930 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1110,6 +1110,11 @@ static struct dentry *fuse_get_parent(struct dentry *child)
>         return parent;
>  }
>
> +/* only for fid encoding; no support for file handle */
> +static const struct export_operations fuse_fid_operations = {

Nit: I'd call this fuse_no_export_operations (or something else that
emphasizes the fact that this is only for encoding and not for full
export support).

Thanks,
Miklos

