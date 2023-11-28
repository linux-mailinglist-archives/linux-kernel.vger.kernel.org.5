Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6997FC1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346419AbjK1Pwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344823AbjK1Pwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:52:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB31BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:52:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B3AC433C7;
        Tue, 28 Nov 2023 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701186757;
        bh=W49ajMFtN9aTN86Tnl430idPA/txjACjmrkpyxn3DE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhCM0efNQ55/CadBsgmu3A+z7I663gGmRlop+aHtsSVP3W3KCJxS4fFnJj2rO9RpG
         y+R924PIXTrR+evJd3GTxqaL5irmDkrqNbRWw9SV1YHNS71I8J/El1OHEQtPkEIRyr
         Afc1O5Xcnr2agGFbz1OiKZ75NeDBlttGNDF5zEkddR7IRkSJ/bYJXRhvwXvYTDouWl
         WOc9GyV32DURezCRx7CTi+a6DGNmgsBWfsB2RHkt8xIdcAxiZzDkyVQICDB2vFML3C
         hmh8wYtpto+fz3KlsQeu2I/pmzyU/Po0vKVV7MZySBCX95gqixVMLw42/5bpJlCqj3
         T2wz5oaTTY4Gw==
Date:   Tue, 28 Nov 2023 16:52:31 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <20231128-serpentinen-sinnieren-e186ea8742e9@brauner>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
 <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>
 <20231127-kirschen-dissens-b511900fa85a@brauner>
 <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:10:54AM -0800, Linus Torvalds wrote:
> On Mon, 27 Nov 2023 at 02:27, Christian Brauner <brauner@kernel.org> wrote:
> >
> > So I've picked up your patch (vfs.misc). It's clever alright so thanks
> > for the comments in there otherwise I would've stared at this for far
> > too long.
> 
> Note that I should probably have commented on one other thing: that
> whole "just load from fd[0] is always safe, because the fd[] array
> always exists".

I added a comment to that effect in the code.

> 
> IOW, that whole "load and mask" thing only works when you know the
> array exists at all.
> 
> Doing that "just mask the index" wouldn't be valid if "size = 0" is an
> option and might mean that we don't have an array at all (ie if "->fd"
> itself could be NULL.
> 
> But we never have a completely empty file descriptor array, and
> fdp->fd is never NULL.  At a minimum 'max_fds' is NR_OPEN_DEFAULT.
> 
> (The whole 'tsk->files' could be NULL, but only for kernel threads or
> when exiting, so fget_task() will check for *that*, but it's a
> separate thing)

Yep.

> 
> So that's why it's safe to *entirely* remove the whole
> 
>                 if (unlikely(fd >= fdt->max_fds))
> 
> test, and do it *all* with just "mask the index, and mask the resulting load".

Yep.
