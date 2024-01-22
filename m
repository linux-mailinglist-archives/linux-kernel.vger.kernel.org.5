Return-Path: <linux-kernel+bounces-34199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532FA837573
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FC71C23F85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD04482E3;
	Mon, 22 Jan 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNsDXaOp"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D626481A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959235; cv=none; b=gpXhw+lFxfLAV7pn3wGryfkHpOGbKCxwVjP4BDq/xwfWVsWcYDzwD9/goGabW1Zv0DBhNpWzMiugMQFP6xp27zpL7OKFyZNj1vammsnTx3FDEwu4tH4tBKvs9ivCNE4LOVsKkv/P+JmzKYoK5/V7ZH31bf/pDkSlfUW0Jot3reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959235; c=relaxed/simple;
	bh=TkSzzHlJMv5ymESbhhEFVW/xRMNRu7PJMyyHPuMjYhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrn9BbW2wpvwbuvTzyOtC42q6IUG9LtYh9k7+vgGlp5VABw8RAfjiBs/7jbizH1dQy9BmgkUIYUk6laJaobDdRpbDTWaeY6r4TSjAQVLXj1SbPQH3rGwZKs+w9E4Tam/gyFwfcSwu1KYyz4gsY9rXfpH+v67TzttsLQjGclxfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kNsDXaOp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d72f71f222so8808635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959233; x=1706564033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZWI3WpoMebV3eDXtVRw22v3yZkn6Vbyx7fncfck9Jo=;
        b=kNsDXaOpP1RGwJQTRV0yw8Qgm2orvAghyCpFh0svTHrcPaJ5HnLtHtx7Kf11rmz2fn
         y244nGdhg5wkKpSRGddGBTsir0qJEAG6bai4OTA0Mh8swP9HbDxnu6Xrsa+YkJAbRLKt
         KLM4cs33/B4deijIOnoub4m0EJ3F2bNKoWx9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959233; x=1706564033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZWI3WpoMebV3eDXtVRw22v3yZkn6Vbyx7fncfck9Jo=;
        b=rNsq4E9onIGDESLH1DJosbFKb1IvY+y2GFSaqIE13gDIAz+PlczMm2TPiZmbeHmfn0
         w2LxS1cN+tl3dveO9nPp1IkoaNOWwsXeNuNOtsuGZ2Hpyk9qMWtFsW0QaGpifBTNYRcm
         dCb0R+DPZ+IrBzVPjVk9QkSC65/mH7VRQt38op1SxtpABFtaMWykteXYKAmyhvZQfH1z
         7Kmzgv39HvCbIVzLoJQpHq2GoSREDQVWKBVmNHbPCKJ3V4NUxu2XElo2jX4+9l5BkjbP
         QCDYFNFT1a560m51hVzCVHgkbS5Pt4Vm5cQgWwCGfyCpXP8PcEcZTrE9sf9hGuh6hFA8
         JlOQ==
X-Gm-Message-State: AOJu0Yw4zB+gLq1WFuAbkLswPwvJZutRhWREnPhbtP0S7cOOD84OjoHZ
	nFrkQzYs80KtB2vRWpYHxIzwmi0X4k4KsUczJKXQ3RvKXhIhBKbskEsMErW6RA==
X-Google-Smtp-Source: AGHT+IE7xm6dZ7c4n354FenxWtRO9QrHztdWKdVURlWwiAEbT2tJ5h9BpfPeHA4gT5b8bgilC4q1IQ==
X-Received: by 2002:a17:902:7897:b0:1d5:78db:4293 with SMTP id q23-20020a170902789700b001d578db4293mr2625287pll.29.1705959233541;
        Mon, 22 Jan 2024 13:33:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001d7284b9461sm4878354plb.128.2024.01.22.13.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:33:52 -0800 (PST)
Date: Mon, 22 Jan 2024 13:33:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <202401221333.B3661AD71@keescook>
References: <20240117143548.595884070@goodmis.org>
 <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home>
 <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home>
 <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
 <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
 <20240122144443.0f9cf5b9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122144443.0f9cf5b9@gandalf.local.home>

On Mon, Jan 22, 2024 at 02:44:43PM -0500, Steven Rostedt wrote:
> On Mon, 22 Jan 2024 10:19:12 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 22 Jan 2024 at 09:39, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Actually, why not juist add an inode number to your data structures,
> > > at least for directories? And just do a static increment on it as they
> > > get registered?
> > >
> > > That avoids the whole issue with possibly leaking kernel address data.  
> > 
> > The 'nlink = 1' thing doesn't seem to make 'find' any happier for this
> > case, sadly.
> > 
> > But the inode number in the 'struct eventfs_inode' looks trivial. And
> > doesn't even grow that structure on 64-bit architectures at least,
> > because the struct is already 64-bit aligned, and had only one 32-bit
> > entry at the end.
> > 
> > On 32-bit architectures the structure size grows, but I'm not sure the
> > allocation size grows. Our kmalloc() is quantized at odd numbers.
> > 
> > IOW, this trivial patch seems to be much safer than worrying about
> > some pointer exposure.
> 
> I originally wanted to avoid the addition of the 4 bytes, but your comment
> about it not making a difference on 64bit due to alignment makes sense.
> 
> Slightly different version below.
> 
> -- Steve
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6795fda2af19..6b211522a13e 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -34,7 +34,15 @@ static DEFINE_MUTEX(eventfs_mutex);
>  
>  /* Choose something "unique" ;-) */
>  #define EVENTFS_FILE_INODE_INO		0x12c4e37
> -#define EVENTFS_DIR_INODE_INO		0x134b2f5
> +
> +/* Just try to make something consistent and unique */
> +static int eventfs_dir_ino(struct eventfs_inode *ei)
> +{
> +	if (!ei->ino)
> +		ei->ino = get_next_ino();
> +
> +	return ei->ino;
> +}
>  
>  /*
>   * The eventfs_inode (ei) itself is protected by SRCU. It is released from
> @@ -396,7 +404,7 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
>  	inode->i_fop = &eventfs_file_operations;
>  
>  	/* All directories will have the same inode number */
> -	inode->i_ino = EVENTFS_DIR_INODE_INO;
> +	inode->i_ino = eventfs_dir_ino(ei);
>  
>  	ti = get_tracefs(inode);
>  	ti->flags |= TRACEFS_EVENT_INODE;
> @@ -802,7 +810,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  
>  		name = ei_child->name;
>  
> -		ino = EVENTFS_DIR_INODE_INO;
> +		ino = eventfs_dir_ino(ei_child);
>  
>  		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
>  			goto out_dec;
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 12b7d0150ae9..1a574d306ea9 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -64,6 +64,7 @@ struct eventfs_inode {
>  		struct llist_node	llist;
>  		struct rcu_head		rcu;
>  	};
> +	unsigned int			ino;
>  	unsigned int			is_freed:1;
>  	unsigned int			is_events:1;
>  	unsigned int			nr_entries:30;

I like it! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

