Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8636A7F8B20
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjKYN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjKYN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:28:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B29DE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:28:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ccc9e6a38aso115933b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1700918930; x=1701523730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhBkKuI0fbhzEilDcSEndZwSBUCGMGB5hB9S6RQoSuM=;
        b=ZDsE5X5I8qxxAK7qx0g743hbMLx4KwOFOZtJHYq/OkAmmnxkCLqOGDXj6Clzpsa6fi
         ArXELUDP9hc5sXpbmG/yVwYyVWtYQZrjMAC4wVKYIIxUwyIWfpD/cE2JBx88naXG11r4
         /nCv7RIDNBzb/KwbgucmKog3El0zG2OEqUTl3St+AaqQ55LBRbKQ9Z7DETFlUFSN5oQo
         +f9+uh1fbO/NhJtJtKh1PBNc2rwTJrWxkls/YyttXeW8dgTjOzoC41GjO0v7N3jKUQYE
         xjKVZROWMP8m/K5UEgAw1Ta9SVjUgkOmA2bEiKdlyG9gUDjq1hys2Hiww06iP1ZZFlcu
         0ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700918930; x=1701523730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhBkKuI0fbhzEilDcSEndZwSBUCGMGB5hB9S6RQoSuM=;
        b=h06xTdbEFHtwSfijzAz0tT5p9NR3oLPEjZZVgcgGMOy06xrmpVuB0kPMP/tC9OSSXS
         czPTN+EIE/yIBELqw4k3xt9cpI3z9oUm9fP+NbY2KpPlPL912WE9crgX7lwM6GIwOIMy
         Qzi6gAEDt4oqNA+bEgevuuxxMqkh4I1Is+/lSxGq93iVF4jFphyGLrZlnxpTYpdGbldT
         2t+Hy7wMKj5Z3uVfczrgDn4W0ze+Cp1AUNFH6fAtGuGBSKjUlgDMOBaoU0F9Q/mVxCxp
         ZchU+8cGgaxq/LepDTNCxD9j6lBWFFFJQL1HGpl/xBQVeJ7HaE71Z97Rnp05GcfhzEX3
         YPDg==
X-Gm-Message-State: AOJu0YykLmPfkDCOZiuxGnEHS2id4IjgLKw02fJG7RaezdMPg01dkhHr
        i0DPv6rirLVzRVjP/RgM3quzxA==
X-Google-Smtp-Source: AGHT+IEiSGWhWT6eayr99X2E4BBgRz0QRwNCxk4p6EBFiHOcTMr6rIe36BrEaF+XzZ7App03i0QClw==
X-Received: by 2002:a05:6a00:8e03:b0:6c2:cb4a:73c3 with SMTP id io3-20020a056a008e0300b006c2cb4a73c3mr6700182pfb.11.1700918930618;
        Sat, 25 Nov 2023 05:28:50 -0800 (PST)
Received: from telecaster ([2601:602:a300:3bc0::1923])
        by smtp.gmail.com with ESMTPSA id fi14-20020a056a00398e00b006a77343b0ccsm4340925pfb.89.2023.11.25.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 05:28:50 -0800 (PST)
Date:   Sat, 25 Nov 2023 05:28:49 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <ZWH2kSJXcXEohpyd@telecaster>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <20231125-manifest-hinauf-7007f16894b6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125-manifest-hinauf-7007f16894b6@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 02:10:52PM +0100, Christian Brauner wrote:
> On Fri, Nov 24, 2023 at 10:25:15AM -0800, Linus Torvalds wrote:
> > On Fri, 24 Nov 2023 at 02:28, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > * Fix a bug introduced with the iov_iter rework from last cycle.
> > >
> > >   This broke /proc/kcore by copying too much and without the correct
> > >   offset.
> > 
> > Ugh. I think the whole /proc/kcore vmalloc handling is just COMPLETELY broken.
> 
> Ugh, I didn't even look at that closely because the fix was obviously
> correct for that helper alone. Let's try and just return zeroed memory
> like you suggested in your last mail before we bother fixing any of
> this.
> 
> Long-term plan, it'd be nice to just get distros to start turning
> /proc/kcore off. Maybe I underestimate legitimate users but this
> requires CAP_SYS_RAW_IO so it really can only be useful to pretty
> privileged stuff anyway.

drgn needs /proc/kcore for debugging the live kernel, which is a very
important use case for lots of our users. And it does in fact read from
KCORE_VMALLOC segments, which is why I found and fixed this bug. I'm
happy to clean up this code, although it's a holiday weekend here so I
won't get to it immediately of course. But please don't rip this out.

Omar
