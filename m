Return-Path: <linux-kernel+bounces-95712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A145587519F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7421F2705A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73C12DDB2;
	Thu,  7 Mar 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nlLClrEx"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488612D778
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820976; cv=none; b=MyXmmzXwfHS6Pg9jUaX4jKVBWlWuwvXgRCfUQG18jZpyOy7+ghzn1GT2ThHipz8xEJFaKr1lCA7e+eBeCAmJJRzxD93WCjZxqzW37Hgl/gwr9rfYNK5k4fFfFvrjUMpCvC31Zw5OAHdbJZ04+ofdvTTSgQAc0x3u9IRvbyXZmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820976; c=relaxed/simple;
	bh=xlFTWjmKTaG1KhSVa69PfGBOQeXT3C6k9vGtFDLXWqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLxXXW53p8f+M7HCG4CpFObvTi825+Z3bH8gJ48KVvyL+/4Ib0JiWa+wW4GJId5Z++x513dwHGQvPuzGCHifNqVA0BkM8JaGEehVDHDOskzBDNuQNPEgJSiMswMQuLfE1Rg5Tdmw8xkRnxvqbyxFBb2fyUFxOQXZN+CJZ6W9SW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nlLClrEx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51323dfce59so877238e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709820972; x=1710425772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UpZfTEQSdYNx5uhaLKw7TjT2VapTSjfAbjuJYLMFCvw=;
        b=nlLClrExaHPI0MNx4kbO6E3POqTG9+K1tNZ7CjQJWRSR+Xy07nJXNyLBJqYuvikH/G
         mhuwCABXdI9pO8iVpgYy+ZRNUXhyPO6M0L7cKcC1cYTQWCwLIFiiXzKBHIiosWhvOFGS
         M3bwEWPWDvUZ0FtKwVb2Nz/i0fSnrWzrByqZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820972; x=1710425772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpZfTEQSdYNx5uhaLKw7TjT2VapTSjfAbjuJYLMFCvw=;
        b=qfdYhUHbwgbnqHr65AcTd6GZSuJ2Xdi35CHwwyeHBoQIGBC0sYi0vkqofsLyFMAhIu
         iBTkJi2nvFlIKvWdbSAYCvcY8NtT6rvQpxTQ562YDdE4Y9wu1AeuSxnEYkXmCP4wvSLM
         611qbK7nOHDtAEjMLzWToabCQgR7uUEVhRlSop3tM7AqeVp+BLmXC3nCe5gFdTf8sbYo
         zIM4iMeob+XXcnAzwMeoxdXGrLOqEYnJ1yoWCu9+9SHUVhkBJoq8bXml623kCgDgR6Nq
         gLRzhjLwpuZqucHECWw5MkxtweB2tbpgISVL79P/jEEssamjAinmsWT1G0lZpWqMX55g
         apkA==
X-Forwarded-Encrypted: i=1; AJvYcCVYPKkUdexQuzikPCh7Chqm7VtmZUWVxQLmcgSceb4pSam/M3Y58LTuGSWUahwd8c9mbiSQepOoeMwnLGLvWvLt8jHnpGJhqG/AxtSD
X-Gm-Message-State: AOJu0Yzx7DIOjHOR8trAWv9AOXH5AtQujl+nYdkJ7KVYrqWRu1PEKM1c
	eDJF07YeUXAH7CXRdpI0t+LZraUQpyK6vaPH40SkWyqIofnLx0r3KgnoJxA9PsrforHUu7YsDBq
	Mj/25JrrdBpBoudbaxT8wxultdN0J6Xl2dPBKow==
X-Google-Smtp-Source: AGHT+IH2cIVIbaKYXKNB2vZEuZPQdGMxbkmqSZeZnvRwgB8uizuvsjvd5fm0tBYz2fKyiQ7jEqAmuqAkCln/OIaGSO4=
X-Received: by 2002:ac2:511b:0:b0:513:116d:4d9b with SMTP id
 q27-20020ac2511b000000b00513116d4d9bmr1474098lfb.60.1709820971654; Thu, 07
 Mar 2024 06:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306103438.2c0a6f44@canb.auug.org.au>
In-Reply-To: <20240306103438.2c0a6f44@canb.auug.org.au>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Mar 2024 15:16:00 +0100
Message-ID: <CAJfpegstDJ6p42itTiL33tMTcbV8tUiMowpk8y9A-52_Oasvnw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the fuse tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Alessio Balsini <balsini@android.com>, 
	Amir Goldstein <amir73il@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 00:34, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> diff --cc fs/fuse/inode.c
> index 516ea2979a90,02869edf72f3..000000000000
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@@ -930,14 -942,6 +942,16 @@@ void fuse_conn_init(struct fuse_conn *f
>   }
>   EXPORT_SYMBOL_GPL(fuse_conn_init);
>
>  +static void delayed_release(struct rcu_head *p)
>  +{
>  +      struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
>  +
>  +      put_user_ns(fc->user_ns);
> ++      if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> ++              fuse_backing_files_free(fc);
>  +      fc->release(fc);
>  +}
>  +

fuse_backing_files_free() doesn't need to be called after an RCU
delay, so it should be resolved like this:

diff --cc fs/fuse/inode.c
index 516ea2979a90,02869edf72f3..000000000000
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@@ -954,7 -959,9 +966,9 @@@ void fuse_conn_put(struct fuse_conn *fc
                        WARN_ON(atomic_read(&bucket->count) != 1);
                        kfree(bucket);
                }
+               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+                       fuse_backing_files_free(fc);
 -              fc->release(fc);
 +              call_rcu(&fc->rcu, delayed_release);
        }
  }
  EXPORT_SYMBOL_GPL(fuse_conn_put);

Thanks,
Miklos

