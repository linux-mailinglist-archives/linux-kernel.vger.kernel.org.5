Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1149977BC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjHNPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjHNPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97293E77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24AD062C37
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF095C433C9;
        Mon, 14 Aug 2023 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692025876;
        bh=2vONX/zuKVfdFQtNVXMZ91+HTgjrSQBXcGDwBf4sKIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbAnHrbL9Sc3SG+ekCyhNFPWAAzr8RvsCa5UYE96rzEMztgEdlQmv4vL2nE6Aig/G
         ZSzfhxitC8XyPTfw+hIWogtp+vbwzP1i0wwJ3x1q5rb5LkkO3pPOe6XpumVoE4cjuX
         wBdzzWlQQqYfomnwsGhGPGESr//2Axz5MPs8829p7MRfvlLwWZnvFKi5vuU/rYYyO7
         bUp6ykWNgcGw2YKVW9mkxsF9jJH6f0CPHpVaLwi+AZpL4dMu+Jb6UImb0gAjAN9eNr
         GZ3kH1Vlpb3I+qjKnF1P9QYkHpmR3jnEhz1GTpkzgXKrHKSz3jaU3nGfCl+IeBoz2O
         VQ5ZyhYPdZqBg==
Date:   Mon, 14 Aug 2023 17:11:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Rheinsberg <david@readahead.eu>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Message-ID: <20230814-rangieren-gastarbeiter-bb0bf10152c2@brauner>
References: <20230807085203.819772-1-david@readahead.eu>
 <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
 <20230811112911.GA22566@redhat.com>
 <20230811-perplex-installieren-899f5925534d@brauner>
 <20230811115710.GA21779@redhat.com>
 <6feef7e0-ea72-412d-837e-34b6fdd3b869@app.fastmail.com>
 <20230814132039.GA17738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814132039.GA17738@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:20:39PM +0200, Oleg Nesterov wrote:
> On 08/14, David Rheinsberg wrote:
> >
> > Hi Oleg,
> >
> > On Fri, Aug 11, 2023, at 1:57 PM, Oleg Nesterov wrote:
> > >> What code do we need to allow userspace to open a pidfd to a leader pid
> > >> even if it has already been exited and reaped (without also accidently
> > >> allowing to open non-lead pid pidfds)?
> > >
> > > I'll try to think more, but can you also explain why do we need this?
> > >
> > > See my another email. Can't we simply shift the pid_has_task(PIDTYPE_TGID)
> > > check from pidfd_prepare() to pidfd_create() ? (and then we can kill
> > > pidfd_prepare and rename __pidfd_prepare to pidfd_prepare).
> >
> > Yes, the easiest solution would be to use `__pidfd_prepare()` and ensure
> > that the caller only ever calls this on tg-leaders. This would work just
> > fine, imo. And this was my initial approach.
> 
> Great,
> 
> > I think Christian preferred an explicit assertion that ensures we do not
> > accidentally hand out pidfds for non-tg-leaders. The question is thus whether
> > there is an easy way to assert this even for reaped tasks?
> > Or whether there is a simple way to flag a pid that was used as tg-leader?
> 
> I do not see how can we check if a detached pid was a leader pid, and I don't
> think it makes sense to add a new member into struct pid...
> 
> > Or, ultimately, whether this has limited use and we should just use
> > `__pidfd_prepare()`?
> 
> Well, if you confirm that sk->sk_peer_pid and scm->pid are always initialized with
> task_tgid(current), I'd certainly prefer this approach unless Christian objects.

No no, I'm absolutely not objecting. I specifically want you to take the
opinionated lead here. :) Thanks for chiming in!
