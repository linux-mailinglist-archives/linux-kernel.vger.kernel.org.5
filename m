Return-Path: <linux-kernel+bounces-112791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA7887E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1738C1F21280
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D511AACF;
	Sun, 24 Mar 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cuz/wuUi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BC17555
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302321; cv=none; b=jIx2hvvJca3mF0MbAb/gQbYNU9MqBeyvPzawk1ox/UnzOqzOgIwUkcUzToEPVD4d+e3OmZt7fpDoxh7A8tE50zi21FT+/h/23r27ItFg3QUORU+lSRSDiayJ5jTMkeWHeVig91/VXEFHFw+dXvwS98eC1Hr4gQTiqwXGILeEUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302321; c=relaxed/simple;
	bh=xdIW6mBPIRVyFNi0g6EGkmhDMUnRw/D1b7czg+0i/ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/AYlfRZ6xF7Ck1fY1KenXxew+So8PBVBpmtticYqreY3I9NjA2WQFpl6BQpsP4dOH4zizxPSbrpAYX0BDV71mm3ZSpdxqdZsKm8BoFFEU6OqKRJzwd1dF5Z9+OFLOwxtVkH+b2NiSNjyQkavw3seZAdMLoLaNDCF/EzG9TMB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cuz/wuUi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51381021af1so5588187e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711302317; x=1711907117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oe6GIQzO/C567doEXwsmBSySXlt6oy2RX728KJkYzKg=;
        b=cuz/wuUik3HMnipgbKl49knUONIng5nCb6owYldFOa8oqyekrKdz8CXhHZDcF0c36r
         yJ+3e1lI1BSlsZoioQ1RfsMcVut2iEYDDUOmggpVxkKILQQMu3+DH/N635ZR5F/6ys+h
         spbWrOaD7TFDHtX9/U3C/jO8S2YN4bEP7C1is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711302317; x=1711907117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe6GIQzO/C567doEXwsmBSySXlt6oy2RX728KJkYzKg=;
        b=AGi2XcxLusoD9gysmtKEEdimdAQLHCwcuH/nO5S4B1ywY1nS54zlFps9sgNFTZgNBC
         b7lp7q3KuHvxnEiQ2jswQRSp8ySKkLV/GptNk0juXkvAwHZsxtUCkswLI3Um15FBbBXM
         4e/Iw2EmC4izxaBBiuIY2Hu3I3HBZ5SO0F4hXoE7jeF7mmn25xo0B6n/DS17+HB5n58M
         CbWKKjcf1o/woHXmSoTdENkUw4GRuug7Anf4+goEwEQacrv502XgttKnG352AzSciw9c
         HMTVaXhwvPL+JEm0IHhMI+E0XLEkmc4UH2GTYQh1G5PUOtsIiVqlohGq+3XQOMRLx+Up
         lQkw==
X-Forwarded-Encrypted: i=1; AJvYcCVpcZezP+6ipgK8+ui1Eq/n736UE7QLrqpBeGf8wlRFLHNlQDw43xSPaZaqmDKSX/5M/xAyLB7yfDE+F52aeLeGPhC0SUaK2qXzv9ZY
X-Gm-Message-State: AOJu0YxT4FFnbRqRz08jDX8DtsBhhtpNHFztxVSzVpOdHVe9GYvMWVCX
	uyLr6M0QxvXAiqdFwHcEuxPgtWwrDxj4B1qkRXQg6LGhhy/z+2Zl2bCz/Hly32xd3FOfZYIuSgn
	1DzHT8Q==
X-Google-Smtp-Source: AGHT+IHyXCi92r/SsM99N1uBJykepDc9bb3pcnU5LDSDZPiYCwKEU2QQptL2KdRyBZiBYloqyGTkfw==
X-Received: by 2002:ac2:504c:0:b0:513:c223:f0e4 with SMTP id a12-20020ac2504c000000b00513c223f0e4mr4007907lfm.10.1711302317209;
        Sun, 24 Mar 2024 10:45:17 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709060d9300b00a45c9945251sm2142167eji.192.2024.03.24.10.45.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4147c4862caso19513365e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXR4OVs7njxhKFGPcHARvkjxSriJTFkdhK4uLV3tW4PddcA1mUF0hb3AY3TTladFOQWo5/KAMYB7coTRu3OhNSTxdZXM8OmOR/lVjiE
X-Received: by 2002:a19:ca19:0:b0:515:9ce3:daa3 with SMTP id
 a25-20020a19ca19000000b005159ce3daa3mr3631407lfg.37.1711302295763; Sun, 24
 Mar 2024 10:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz> <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
 <20240324022731.GR538574@ZenIV>
In-Reply-To: <20240324022731.GR538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Mar 2024 10:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBQPxKh1cGhGoo=SmJq72H4VObrkVxQepooaq18H4=oA@mail.gmail.com>
Message-ID: <CAHk-=wgBQPxKh1cGhGoo=SmJq72H4VObrkVxQepooaq18H4=oA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Al, I hope your email works now ]

On Sat, 23 Mar 2024 at 19:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We can have the same file occuring in many slots of many descriptor tables,
> obviously.  So it would have to be a flag (in ->f_mode?) set by it, for
> "someone's already charged for it", or you'll end up with really insane
> crap on each fork(), dup(), etc.

Nope.

That flag already exists in the slab code itself with this patch. The
kmem_cache_charge() thing itself just sets the "I'm charged" bit in
the slab header, and you're done. Any subsequent fd_install (with dup,
or fork or whatever) simply is irrelevant.

In fact, dup and fork and friends won't need to worry about this,
because they only work on files that have already been installed, so
they know the file is already accounted.

So it's only the initial open() case that needs to do the
kmem_cache_charge() as it does the fd_install.

> But there's also MAP_ANON with its setup_shmem_file(), with the resulting
> file not going into descriptor tables at all, and that's not a rare thing.

Just making alloc_file_pseudo() do a SLAB_ACOUNT should take care of
all the normal case.

For once, the core allocator is not exposed very much, so we can
literally just look at "who does alloc_file*()" and it turns out it's
all pretty well abstracted out.

So I think it's mainly the three cases of 'alloc_empty_file()' that
would be affected and need to check that they actually do the
fd_install() (or release it).

Everything else should either not account at all (if they know they
are doing temporary kernel things), or always account (eg
alloc_file_pseudo()).

               Linus

