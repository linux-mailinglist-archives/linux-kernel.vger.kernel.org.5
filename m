Return-Path: <linux-kernel+bounces-33897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B7483702A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2858DB318E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951595D919;
	Mon, 22 Jan 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHkPipvt"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F615D8FB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946759; cv=none; b=lMq2ec9fdvEzhNGzM1/gyqs4pXbXno9pak6F7YOyDHL3o9p16mcXV01i3orZnT6SdcAOH/i0PfRmQOSAmnZvyyicUAqXhLiuRD3KZmJgl57rc+vssNc0NsdvAsZ4z1nlWeHSSQfp35YszS5QdPz/WcyT1jcK2pjQlPrpzqMv8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946759; c=relaxed/simple;
	bh=Pau3u1pSMU90mw/+jq91yMryRC3O6vxybyqDbQwM7Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzfQEAoLdfACm+xQfJ+DmC82zLTARJYIkEdfmA7TCdh5Fvech3d71LVTlKMv5bcgU2+gfx3vXGPH+rk7rFqcemjWjD9BiLA/ntt5j/UMJ9s1nEkatZ5imj6pyBhMNuqnt/GAFepJ4QzwJzLB2EBxqVtOWN9HdlMDRBMIaiuccbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHkPipvt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2398473a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705946758; x=1706551558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/zmSgXOMP3d5TPsaljeRJ/oWaf5SfG6/igeTaAa/iE=;
        b=lHkPipvtEqbwWDrC13mlU1R4qwhPohlZpWfVIwXPWvlLveZDK3wxMioz+O/7XJsxhV
         6ZU3KfrxmKRZJRK3cOa7FpdrHneJVbrdmcEmQxj+OiQ7xf8ZMkexp1ze5XWZd21tzEt9
         o9xq6QwxGivCLr21B5/mhYXfB0JNTyIosVJiV+Jkv1u5JiGgSRKUVWErjHzo8hdhH79m
         E6hhJRg4wzdr+ZmV0t5f4VCgotQp6Q2dw64cPA+Yx4amCf5+RdbAlk6SMddRiTNKW5Us
         00KC8OobVRumKAY8BidrBARtiyM8/LQ6ilzH7YtO1XEpk5UVcmDIk2GtATb0yEZ7ebbw
         Z1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946758; x=1706551558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/zmSgXOMP3d5TPsaljeRJ/oWaf5SfG6/igeTaAa/iE=;
        b=cIlnMRzmD/tUpU+60vJbgLhTN788sPs45a+nkzZ1KZIacx2ivcQX70j57Nmi38GD31
         VfTD9rgsuewMx24JuFdXyhpiKrfql5gnkFHgzXZRzGRQKiw7TDHjzPvfvnqsFsS84Lv9
         tCb8r+McZ0uT6F4j/brjz7iwPqCpEnl0MMUb/ikYJK61X8JDFUFVwCtIsLHs3iQuj0/y
         I2pojYVqPXBb88DD++5wm4d3C38WRioo5UH4RZeZpIzrXUYFFHBT7p5Xi9hlekwvykU2
         9PskW1qifurYBgsmO51HE6Tk4e/O3i4L8fL59a0/H5txDGJ+s86h1CR7CQDWyGR9PZ8X
         c6Sg==
X-Gm-Message-State: AOJu0YxfYqLnaCVbUvH75BPBC7bCNF+JwuO4m+8zRZ9jAT1/eZ5x2af/
	AwI84DVkd09UQGMZJt6hxaj24/Sba245FG19qijg2Xo/b+P3jcrNIliry3Xxjw==
X-Google-Smtp-Source: AGHT+IHTG2eh3/5KTZYk56ikFTlgu3LNz0dLdDi3iQ2IzbhQZU5KBT8z8gvQxdICnVNW6lTs7+pLXA==
X-Received: by 2002:a17:90b:1093:b0:28f:f706:f276 with SMTP id gj19-20020a17090b109300b0028ff706f276mr2177710pjb.80.1705946757876;
        Mon, 22 Jan 2024 10:05:57 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id km7-20020a17090327c700b001d752c4f36asm2025676plb.78.2024.01.22.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:05:57 -0800 (PST)
Date: Mon, 22 Jan 2024 18:05:53 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <Za6ugTv5lEMWa3Vg@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
 <Zal8A95q3jVl4nu5@google.com>
 <2024011935-placidly-justifier-4338@gregkh>
 <ZaqsBTQ1x5lQG9Rq@google.com>
 <ZaqzUrkfSqw0jKkG@google.com>
 <2024012013-zoologist-reawake-8ebe@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012013-zoologist-reawake-8ebe@gregkh>

On Sat, Jan 20, 2024 at 07:37:25AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 19, 2024 at 05:37:22PM +0000, Carlos Llamas wrote:
> > On Fri, Jan 19, 2024 at 05:06:13PM +0000, Carlos Llamas wrote:
> > > 
> > > Oops, here is the complete info:
> > > 
> > > Commit ID: 9a9ab0d963621d9d12199df9817e66982582d5a5
> > > Subject:   "binder: fix race between mmput() and do_exit()"
> > > Reason:    Fixes a race condition in binder.
> > > Versions:  v4.19+
> > > 
> > > Note this will have a trivial conflict in v4.19 and v5.10 kernels as
> > > commit d8ed45c5dcd4 is not there. Please let me know if I should send
> > > those patches separately.
> > > 
> > > Thanks,
> > > --
> > > Carlos Llamas
> > 
> > Sigh, I meant to type "conflict in v4.19 and v5.4". The patch applies
> > cleanly in v5.10+.
> 
> Yes, I need backported patches please.
> 
> thanks,
> 
> greg k-h

Backports have been sent.

linux-4.19.y:
https://lore.kernel.org/all/20240122174250.2123854-1-cmllamas@google.com/

linux-5.4.y:
https://lore.kernel.org/all/20240122175751.2214176-1-cmllamas@google.com/

The patch should apply cleanly in remaining stable branches.

Thanks,
--
Carlos Llamas

