Return-Path: <linux-kernel+bounces-107855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2B288028F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88E228552B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4A111B1;
	Tue, 19 Mar 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Bjc+xpQA"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A69F50D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866473; cv=none; b=pAaEvDNxxzEkg+qWg5JwM6VeU6bQdCIv0Yi3b3dEYAYy94KOk9+XQsUptqQwNa5xs2l5B5Kc8V3L8jh8HuchJpo1NZxFKvb1V+Q1TI8/ge+bGkYbvKNnE9W1zNOOwKJva2zY4uMMUAbZAu7JSSea5R70s7KXMYa3/uthCdch8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866473; c=relaxed/simple;
	bh=nRp7+YyTBHw31NX7xj7EtsXhg3dkAR+p6w1ZMt+sOEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThEpqmgwh85lGDivYXOnw1GbijIkET8zgTgFNC7ANOMoAyn1Dcr6FhulTKQMdkgphbhmzfnXCc6/sY0QBYN5xhOcsZ4LmkFG7TnWAS/l7XadJNGxcqoT+JOmuFUtAL8Ph4fYHdTYepw0yhKUv7jyRjoKOLWCqh7KHbyTrsCesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Bjc+xpQA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56ba72fffd6so328591a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710866470; x=1711471270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=Bjc+xpQAwY3z3fbUSs5mWFZqOgAsXiWOfTt2fETf32xVt5LGMFFT8BlXOVa1nShF4e
         u3hKGCc3sXooS8tjsd1KJrhLeAY0AsQHmlDDydrwglGH1JSvNWnPALsWFn98NxkI4Uc4
         VoScTVzsNWKZM++T29YZIQ9ySLCKZz1WGzusQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866470; x=1711471270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=WMF8QSaeNIhg0cydB/CHLdiFZbJAdJyzkcDrOH+vNzUwmwXfrFlrllEw5FJ4pZpiCA
         +XwNbjOTRFCXgyTxnbO8CUndGAWYZ2bUUhcQIju0ZB7C9U+sKFzat3PeP+ggZIv1AgcM
         I2PGrxhQL2Chlb5UFSb5MaQVZvgTPWoE2tYFsepqiccz4m+YOmSYTypG7E2bLhLk7na7
         S48pY03VDwaNM3Q0C2zgCHed3HtpnvEfRduaBDDk3U79gD3erI7k03FRQM3FsjpoSFFd
         kHSa62CoSmYpFaT4ZKldFt9llcxbNUMTTah3133UdT/4Gr/+w+85bkV29Dpiz4ABYB44
         Ir8A==
X-Forwarded-Encrypted: i=1; AJvYcCW4oOEmyMaabWIGENkzyyR7zlXPIk9WUJltZ+rejgCQFs9RjgCksQB3NB2qU2q7Ha8QzAEK9ilaGjhgO/rmIPDP3xdUlI26IwSOZc0a
X-Gm-Message-State: AOJu0Yy4g5sccUOtQ20MCKDD6qhkpwzGET4kjiTpmaPmOl6hUVc/yOEW
	o8bawI9FvZsdy9VxJE2IyRksmgazhn7QUp3KShdMsa13yxYOqq/duqK4OJ5QOF+NAsTFrlURsqg
	iD52/H/ZyY3K7MfFHLX5jvNkHdL9geIkpXWDjBgFpOuVtRtVAyzg=
X-Google-Smtp-Source: AGHT+IFDeEEaIOtSBG5DGppYGHWRw4rXZqpgILKwzYCMW4SSXhcYWj+KFRDuw5xeuXxFLrQ0w0/J7Jaydr+ESekL/l8=
X-Received: by 2002:a17:906:70c9:b0:a46:6bb8:1ec4 with SMTP id
 g9-20020a17090670c900b00a466bb81ec4mr8429584ejk.76.1710866470240; Tue, 19 Mar
 2024 09:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk> <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
In-Reply-To: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:40:58 +0100
Message-ID: <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:13, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:
>
> > What particular usage case of invalidate_inode_pages2() are you thinking of?
>
> FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
> to clean up the cache.
>
> The server is free to discard writes resulting from this invalidation
> and delay reads in the region until the invalidation finishes.  This
> would no longer work with your change, since the mapping could
> silently be reinstated between the writeback and the removal from the
> cache due to the page being unlocked/relocked.

This would also matter if a distributed filesystem wanted to implement
coherence even if there are mmaps.   I.e. a client could get exclusive
access to a region by issuing FUSE_NOTIFY_INVAL_INODE on all other
clients and blocking reads.  With your change this would fail.

Again, this is purely theoretical, and without a way to differentiate
between the read-only and write cases it has limited usefulness.
Adding leases to fuse (which I plan to do) would make this much more
useful.

Thanks,
Miklos

