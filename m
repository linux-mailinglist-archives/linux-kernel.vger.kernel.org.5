Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ACD7F8B31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjKYOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:04:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1D127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:04:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45EC433C7;
        Sat, 25 Nov 2023 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700921069;
        bh=oR2FZCEmyWJs3H/Sq60sOFaa52q/UAD9T3D3m2taMI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTefBvIHrBsWV7IYBI+6/VC4t2Vsw588aPNliu4s4L00U9hvRFxqa2qdx+kJwD9+b
         w0oHnWAzg8e8JiXyLkaDlNs+/YB6pfT/EzhNY2X67o91uw6gEzED8IlppfXOpXkQTE
         E51e1m9UvKCUu16Kx6Kv/+GlZFWklHNblVu7FSf+cSU6xpagLVQG6fBT9/LjIW0w9n
         7odR9euCXZ//r8uTqh0AUw2QzRoH9TIkEF5sxO1v1XS2GmFnqmtveBWx/LyDJlB/bw
         3ZthPdU8LNULQr9ENhQ5UVt40Nvqg4sMd73z4OSWPPLRaquwb8YFZuthiN0GemE1M9
         HdqP8S7Ra6tig==
Date:   Sat, 25 Nov 2023 15:04:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231125-kurhotel-zuwege-10cce62a50fd@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <20231125-manifest-hinauf-7007f16894b6@brauner>
 <ZWH2kSJXcXEohpyd@telecaster>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWH2kSJXcXEohpyd@telecaster>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 05:28:49AM -0800, Omar Sandoval wrote:
> On Sat, Nov 25, 2023 at 02:10:52PM +0100, Christian Brauner wrote:
> > On Fri, Nov 24, 2023 at 10:25:15AM -0800, Linus Torvalds wrote:
> > > On Fri, 24 Nov 2023 at 02:28, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > * Fix a bug introduced with the iov_iter rework from last cycle.
> > > >
> > > >   This broke /proc/kcore by copying too much and without the correct
> > > >   offset.
> > > 
> > > Ugh. I think the whole /proc/kcore vmalloc handling is just COMPLETELY broken.
> > 
> > Ugh, I didn't even look at that closely because the fix was obviously
> > correct for that helper alone. Let's try and just return zeroed memory
> > like you suggested in your last mail before we bother fixing any of
> > this.
> > 
> > Long-term plan, it'd be nice to just get distros to start turning
> > /proc/kcore off. Maybe I underestimate legitimate users but this
> > requires CAP_SYS_RAW_IO so it really can only be useful to pretty
> > privileged stuff anyway.
> 
> drgn needs /proc/kcore for debugging the live kernel, which is a very
> important use case for lots of our users. And it does in fact read from
> KCORE_VMALLOC segments, which is why I found and fixed this bug. I'm
> happy to clean up this code, although it's a holiday weekend here so I
> won't get to it immediately of course. But please don't rip this out.

Ugh, I see. I just grepped through the drgn repo. I didn't realize that
you were actively using it and not just testing it. If this is actively
used then we won't break you ofc.

And yeah, if you would fix it that would be great. Given that you're the
main active user who happens to have kernel experience you might even
want to be made responsible for this file in the future. ;)
