Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7FC7F8B16
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjKYNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjKYNKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:10:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190F0B5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:10:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE46C433C7;
        Sat, 25 Nov 2023 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700917856;
        bh=7j6ntO1H0+nqJqtu3V8a5oFSFshosbKcXWeIEXFbRjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdemR95SUNaQqW0vqdigJ4y5z3gGC/BgDa4iFeJm8SBWuk+BIJjuz6EyKrVurqtuk
         C7Yk/+fGqOjFqYziZR4ShXtNygezEHphRlCZa+0HobMNnLOE9qnezQINirFvkGw7qE
         nCqrGyyJV3vGn16TH+HB7oyOfnCC1xqDvQpcfEbOUgCoZDabcJ+mtKmS4zZakVKG8v
         jFNbrni8VJH4SJ5btGj1wX3m3jxTEdl3aKIWHjutsN7m9LfyFJYwkcDZWHm5dN/+zp
         xSwvjndO4idNLfWkxX8OythL0/+Aexaec3YSZk4txeySzMlR7Gsr1LxHnOIASI5cIF
         yT/ksRq1H0Wiw==
Date:   Sat, 25 Nov 2023 14:10:52 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@fb.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231125-manifest-hinauf-7007f16894b6@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:25:15AM -0800, Linus Torvalds wrote:
> On Fri, 24 Nov 2023 at 02:28, Christian Brauner <brauner@kernel.org> wrote:
> >
> > * Fix a bug introduced with the iov_iter rework from last cycle.
> >
> >   This broke /proc/kcore by copying too much and without the correct
> >   offset.
> 
> Ugh. I think the whole /proc/kcore vmalloc handling is just COMPLETELY broken.

Ugh, I didn't even look at that closely because the fix was obviously
correct for that helper alone. Let's try and just return zeroed memory
like you suggested in your last mail before we bother fixing any of
this.

Long-term plan, it'd be nice to just get distros to start turning
/proc/kcore off. Maybe I underestimate legitimate users but this
requires CAP_SYS_RAW_IO so it really can only be useful to pretty
privileged stuff anyway.
