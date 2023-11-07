Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC27E49F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjKGUh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjKGUhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:37:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE258A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:37:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso4938487b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389442; x=1699994242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaEivRGYQgWty+lkiDpJ6XgknaKLFgZ+tZbiPi4ULqE=;
        b=Xk8zz9b3Lfb8DBOsXsc6j86GBeVy3szLMGvHJEbJR5h5/p8fBXndB8VbaZEm+r5qtk
         fZ8i1Cpwi6uLWAyQv2sw+iy7BQYzKn07JIuZwyZ+nPLnl5ndivgZV7TMo7EuX+o5URB1
         ZHSl6F5j15ajmZA25R/UTBcr4+TJq0hUMfN78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389442; x=1699994242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaEivRGYQgWty+lkiDpJ6XgknaKLFgZ+tZbiPi4ULqE=;
        b=D9jbk7wZcTFEJ5Z70ceZ+Fp2OOYTuQaMVPaIX+1f3y8qgp6KJsv2wFrcZlrcbUTMJy
         QJZyWT1MqpWBbTAGpcfCwQG9EUiJY8ttyGe3aQhFdRMEHeyf57MznxXBP52h6Ff1jY51
         AHwZKOR/aM4RLOZOp3K6o3CbpZoWDkp4yhGYM3BGKB0z4cjYoZEEl+/Nbq+kZTDEZ/yX
         SEiE3kdg+lmRKuRHjvtjJKFpeIqC2bgcPTTTbeYXx2V6TR8bVfUIBCCqN2PsA3AQnbGM
         +vKFBO7s6h9laCb5/ZxTUVNDCswZTiuyevrE8raq2GiGw1BIM208EjpxJMAx2OqZP9Oe
         djhQ==
X-Gm-Message-State: AOJu0YwOHkWA179Ct5PYqTOU55k1kLujCLt257ndQYVrfPzNMF1drK8i
        RXb8mTPKNUFWKCoddrzy9napPDd53i84FnUYCjTHJA==
X-Google-Smtp-Source: AGHT+IE+1gfPggREs0LKHC4iwp9aPM5a+Hkng8JZERX1SSzCn3TpDE0hw34nJeMnxNX73PXMAinopw==
X-Received: by 2002:a05:6a21:9988:b0:181:98d6:6afd with SMTP id ve8-20020a056a21998800b0018198d66afdmr126141pzb.41.1699389442297;
        Tue, 07 Nov 2023 12:37:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a740800b0026801e06ac1sm219553pjg.30.2023.11.07.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:37:21 -0800 (PST)
Date:   Tue, 7 Nov 2023 12:37:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311071236.71CDE62@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
> Currently, execve allocates an mm and parses argv and envp before
> checking if the path exists. However, the common case of a $PATH search
> may have several failed calls to exec before a single success. Do a
> filename lookup for the purposes of returning ENOENT before doing more
> expensive operations.
> 
> This does not create a TOCTTOU race, because this can only happen if the
> file didn't exist at some point during the exec call, and that point is
> permitted to be when we did our lookup.
> 
> To measure performance, I ran 2000 fork and execvpe calls with a
> seven-element PATH in which the file was found in the seventh directory
> (representative of the common case as /usr/bin is the seventh directory
> on my $PATH), as well as 2000 fork and execve calls with an absolute
> path to an existing binary. I recorded the minimum time for each, to
> eliminate noise from context switches and similar.
> 
> Without fast-path:
> fork/execvpe: 49876ns
> fork/execve:  32773ns
> 
> With fast-path:
> fork/execvpe: 36890ns
> fork/execve:  32069ns
> 
> The cost of the additional lookup seems to be in the noise for a
> successful exec, but it provides a 26% improvement for the path search
> case by speeding up the six failed execs.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
> 
> Discussed this at Plumbers with Kees Cook; turned out to be even more of
> a win than anticipated.
> 
>  fs/exec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9a5ca7b82bfc..fe786aeb2f1b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1881,6 +1881,16 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	if (IS_ERR(filename))
>  		return PTR_ERR(filename);
>  
> +	/* Fast-path ENOENT for $PATH search failures, before we alloc an mm or
> +	 * parse arguments. */
> +	if (fd == AT_FDCWD && flags == 0 && filename->name[0] == '/') {
> +		struct path path;
> +		retval = filename_lookup(AT_FDCWD, filename, 0, &path, NULL);
> +		if (retval == -ENOENT)

Oh, actually, I see the 0-day problem. This should be:

		if (retval < 0)

> +			goto out_ret;
> +		path_put(&path);

Otherwise this put will happen for an non-successful lookup that wans't
ENOENT. I've fixed this in my tree.

-Kees

> +	}
> +
>  	/*
>  	 * We move the actual failure in case of RLIMIT_NPROC excess from
>  	 * set*uid() to execve() because too many poorly written programs
> -- 
> 2.37.2
> 

-- 
Kees Cook
