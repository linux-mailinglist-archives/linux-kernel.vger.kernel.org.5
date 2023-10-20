Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F557D0E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377036AbjJTLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377034AbjJTLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:14:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A2CA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:14:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E9C433C8;
        Fri, 20 Oct 2023 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697800477;
        bh=M8Sj1iq6gHWICvyY7V5UlksJucFiOAv+3a6dS9C+5Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJUsAE3i4sf1qzoMlcLNxkj6QHd4y6ngFBOTh9Fi8zVHSTZi5aMMnVgTJh/V4CW7n
         5RnvSpXe3rwLILWIrkl3d+lmwDDoiL5YjwlF2D6TESeT+FA5Ek4c/E+ovsZjXhAISS
         +bmLGLlA66KZqb9w7cEAoD0YuoEJTu37EoH9PG4WKr9qaQ0P5CV2KOY5rzY7CBJJd5
         gYbBbY3JHGTQBNcu01kkEfax2w1+1tn6nt6zBtWsl3Dc9HjJqzWnKyHnqxY4dXyhyf
         2Xlr0AKQ7+V2a8kEecLU/Tt69rqM2o8nQsitOXEE+rIE/2lZIW4LQt0Y5cxiar/rpD
         KFWXXdfLR8zyQ==
Date:   Fri, 20 Oct 2023 13:14:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231020-abringen-gesurft-5691e5a997ec@brauner>
References: <20231019-kampfsport-metapher-e5211d7be247@brauner>
 <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ouch. That filename ref by audit was always supposed to be
> thread-local in a "for this system call" kind of sense.

Yeah, I wasn't happy when that bug showed up.

> That said, using atomics for reference counting is our default
> behavior and should be normal, so the patch isn't wrong, it's just
> annoying since getname/putname is very much in the critical path of
> filename handling.

Yeah.

> That said, the extra atomics are hopefully not really noticeable.
> 
> Some people might want to use the non-refcounted version (ie we have
> getname/putname used by ksmbd too, for example), if they really care.
> 
> It already exists, as __getname/__putname.
> 
> But the normal open/stat/etc system call paths are obviously now going
> to hit those extra atomics. Not lovely, but I guess it's the best we
> can do.

I didn't spend too much time on this issue because it's -rc7 and the
straightforward seemed ok, if annoying.

But if we really really really really cared we could probably do a
deranged thing and massage both audit and io_uring to allows us to
separate the regular system call getname from the io_uring getname. But
I think that would be ugly and likely error prone.
