Return-Path: <linux-kernel+bounces-133261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B989A151
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0741F238DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C016FF38;
	Fri,  5 Apr 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ca6YWdRI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8C16F909
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331372; cv=none; b=EijHnTx/wWCy+znzUrXTZXEoX7RBSD4VirhbYKyailxAoE+B/ASNUuj4ETyDoaraNGXvp/oa+uX+Ymgd539wdA1xmuM/adJqQGBwSSgotMpwZz0OUE0v8UKH+65J/Hw1rVCy+MvqprAa9Ck2tZJ5tXqhtSqy5O5KnKMZ6mgPrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331372; c=relaxed/simple;
	bh=YcbU8YbgxGYibYCC2p8AxafJ7jq4ZK+nyVyigNEo1iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOPIFp/ID6usF+o6UydIVOPnqTrRQUxr6Dsnx8A4FLReY06S4yi1K28t8UG7m3iDkzwhu+cwZw7vH1Yppko3OGzpNr3Gte7ZU+rXLfxXynqTZXCaiPHaXtNJnta4++7ar9i/I+bmr1IjABKWQ6tZavX15LiXEClO903bqz3mRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ca6YWdRI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e223025ccbso12966405ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331370; x=1712936170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DL9cnO6A6++GnVHXhUTIhSz8alil+LEbB8cHezTz9EE=;
        b=Ca6YWdRIx6rUa9Q3t6mZox5f7BRKUXUfKAdJRYx4ziyiQT2D2IF/VHU7h3MrGLTUsf
         djJdX//1QXTR8lMCuDX2Z2ZOb8KdlCROziTmszwwMiLOoKRH3XTLLhG+EYEx2zk0Aruq
         A5t0k28uZ56rLy7x9STCO85hFgBS3fda44K8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331370; x=1712936170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL9cnO6A6++GnVHXhUTIhSz8alil+LEbB8cHezTz9EE=;
        b=dEXuEZ+5VckK/SfY7mFjSoMqO6rAGw/Kjw8BbPBZ2Pi6bj2tSysZa5WTB4yX6BIAqK
         ClFI+MIBpFi5V7UZZc+fmyWmnd9YgEdxiNNyTm+DHv8GZdbBDWbgGtRSCBqsHjmYzdzz
         LejbeJt/GEl9hP0tvuYhrsbp+NK67pL/c2VUGnQtNTroxA03UJhnB6yGEY4MVhjULtGK
         lkH2XWz2lMhBH3KVy/rjeRzyU8D7HCYXj+OlQkVjKY9++xslm4ejt6tYBTQnPLKbxgEA
         2WBG8y8MUkYHaCAJodbqX1wf+Ell1UL/Gc/qduOAsJqmqs+oMCRDKSTGf4Cfa2mcWURz
         M5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu2/daA2XqIVfl/8Yt5lDV9HDBw3sctMspmqxpvqSo4tQYauAFPjz3EkgbYweRMJK8MgAOhs4U6OQn24Fjajow0cOe/ErRb/ZjBvxD
X-Gm-Message-State: AOJu0YzBbhSqxwyeiZneXgr4tRDM8qE0RfGO4W+fskc2ehqwgnPPcA5t
	JY679ug9/QEAGpvSUNZS0c/i4si/SeVTRBXG21PVkvhfpfM/xPfL8DBBX+odzw==
X-Google-Smtp-Source: AGHT+IFco5AJZxEyadvlE+QE7FTCpcD4rzoP4C5Mn+eLlmw3cKuegzy1I8QBCMF856Ene+jdfsQ3aw==
X-Received: by 2002:a17:902:e409:b0:1e0:b76b:cfb8 with SMTP id m9-20020a170902e40900b001e0b76bcfb8mr1538892ple.19.1712331370046;
        Fri, 05 Apr 2024 08:36:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090332c500b001db5ecd115bsm1697478plr.276.2024.04.05.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:36:09 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:36:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
Message-ID: <202404050835.A17A35A50E@keescook>
References: <20240404211212.it.297-kees@kernel.org>
 <20240405102157.mmrralt5iohc2pz6@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405102157.mmrralt5iohc2pz6@quack3>

On Fri, Apr 05, 2024 at 12:21:57PM +0200, Jan Kara wrote:
> On Thu 04-04-24 14:12:15, Kees Cook wrote:
> > Since __counted_by(handle_bytes) was added to struct file_handle, we need
> > to explicitly set it in the one place it wasn't yet happening prior to
> > accessing the flex array "f_handle". For robustness also check for a
> > negative value for handle_bytes, which is possible for an "int", but
> > nothing appears to set.
> > 
> > Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-nfs@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> >  v2: more bounds checking, add comments, dropped reviews since logic changed
> >  v1: https://lore.kernel.org/all/20240403215358.work.365-kees@kernel.org/
> > ---
> >  fs/fhandle.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 8a7f86c2139a..854f866eaad2 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -40,6 +40,11 @@ static long do_sys_name_to_handle(const struct path *path,
> >  			 GFP_KERNEL);
> >  	if (!handle)
> >  		return -ENOMEM;
> > +	/*
> > +	 * Since handle->f_handle is about to be written, make sure the
> > +	 * associated __counted_by(handle_bytes) variable is correct.
> > +	 */
> > +	handle->handle_bytes = f_handle.handle_bytes;
> >  
> >  	/* convert handle size to multiple of sizeof(u32) */
> >  	handle_dwords = f_handle.handle_bytes >> 2;
> > @@ -51,8 +56,8 @@ static long do_sys_name_to_handle(const struct path *path,
> >  	handle->handle_type = retval;
> >  	/* convert handle size to bytes */
> >  	handle_bytes = handle_dwords * sizeof(u32);
> > -	handle->handle_bytes = handle_bytes;
> > -	if ((handle->handle_bytes > f_handle.handle_bytes) ||
> > +	/* check if handle_bytes would have exceeded the allocation */
> > +	if ((handle_bytes < 0) || (handle_bytes > f_handle.handle_bytes) ||
> 
> This is broken. Let me explain: Userspace passes in struct file_handle
> (ufh) and says how many bytes it has reserved for the variable length
> contents in ufh->handle_bytes. We call exportfs_encode_fh() to create
> the file handle. If it fits into the provided space, the function returns
> in handle_dwords how many uints it has actually stored. If the handle
> didn't fit, handle_dword contains number of uints we'd need in the variable
> length part to be able to fit the handle in.
> 
> Now your patch destroys this behavior by storing 0 to handle_bytes in case
> the handle didn't fit *before* the returned value is actually stored to a
> struct copied to userspace.

Ah yes, I see now how they're used for separate things. I will respin
again and possibly fix up the "int" to "u32" as suggested by willy.

-- 
Kees Cook

