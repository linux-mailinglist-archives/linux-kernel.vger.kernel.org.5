Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFE7BEAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378453AbjJITpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJITp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:45:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AEA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:45:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso842831266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696880720; x=1697485520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9IoVUFnZqWRaCM70mDq121GEnQ6kFXLINjENnMWdgE=;
        b=ee5uvAT80fSxSRtYDeyvxEuQ7zXOl8wdW0kO70gd08D47hzkRd+3mbkEUekmJUq06D
         8q777oRQSHZ6op/ZWJCsNQZHdOoWUoWw7duI1oSVMIVq6M0NdKQzZqs6MGy5XSqr2EmX
         BbA+2lv6IrYcf5dVP2Pc+icl6wM6wxHnu4EFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880720; x=1697485520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9IoVUFnZqWRaCM70mDq121GEnQ6kFXLINjENnMWdgE=;
        b=mB6MZhJ0szYg+u/P4zMZxduXCQrw2G8phT4qN76HasTgvbMUGhH8A+naP0cwaxciT2
         k6qBofaZS88byAcSYe2xsMFx4ULB5Ll4Y3smohV98Qu5z5IE0kGFQ4yNu2DGLc0YHxi9
         tuyZP6gzsZTi9+EZh61RHqncIyqRQGiSXCQomjAgYZO6nT/99siJ+D037ugW7EB5aKVi
         AKcsB/WxYoTe3pTrr3/wGWEJV2IrIYd52cThF+rfIYsvm/9qsIPSWhvbMURN14y2CYMZ
         kpuKaHcV7Iy5n8HZQgfE07TcDYHn1lHq+RNZrJ5HyujlLdWM7E/zZ5NNVSNW+TI4xh8C
         aXJA==
X-Gm-Message-State: AOJu0YwlmlZaPZ6fN2z1bBQ2qjBEUq6a8m0QpGZJtjw7QT+xeBQfDZPM
        xDzG//5VjJ2R2WBIYA5YdWzGkNNOujNEyi2s8Wm/oQ==
X-Google-Smtp-Source: AGHT+IE9/+jcV6HV7HriuNXF+o7ki9IxeNc8WkeAHgY0RIJH0VhVY2+4Rx5D1jMrroc6t+20is5KxtXPiyekxAgUTkw=
X-Received: by 2002:a17:906:1db2:b0:9ba:2b14:44fb with SMTP id
 u18-20020a1709061db200b009ba2b1444fbmr2323048ejh.47.1696880720133; Mon, 09
 Oct 2023 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
In-Reply-To: <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Oct 2023 21:45:08 +0200
Message-ID: <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 at 17:24, Krister Johansen <kjlx@templeofstupid.com> wrote:
>
> The submount code uses the parent nodeid passed into the function in
> order to create the root dentry for the new submount.  This nodeid does
> not get its remote reference count incremented by a lookup option.
>
> If the parent inode is evicted from its superblock, due to memory
> pressure for example, it can result in a forget opertation being sent to
> the server.  Should this nodeid be forgotten while it is still in use in
> a submount, users of the submount get an error from the server on any
> subsequent access.  In the author's case, this was an EBADF on all
> subsequent operations that needed to reference the root.
>
> Debugging the problem revealed that the dentry shrinker triggered a forget
> after killing the dentry with the last reference, despite the root
> dentry in another superblock still using the nodeid.

There's some context missing here.  There are two dentries: a mount
point in the parent mount and the root of the submount.

The server indicates that the looked up inode is a submount using
FUSE_ATTR_SUBMOUNT.  Then AFAICS the following happens:

 1) the mountpoint dentry is created with nlookup = 1.  The
S_AUTOMOUNT flag is set on the mountpoint inode.

 2) the lookup code sees S_AUTOMOUNT and triggers the submount
operation, which sets up the new super_block and the root dentry with
the user supplied nodeid and with nlookup = 0 (because it wasn't
actually looked up).

How the automount gets torn down is another story.  You say that the
mount point gets evicted due to memory pressure.  But it can't get
evicted while the submount is attached.  So the submount must first
get detached, and then the mount point can be reclaimed.   The
question is:  how does the submount gets detached.  Do you have an
idea?

Thanks,
Miklos
