Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F407F7875
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbjKXQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbjKXQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:02:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0066F19A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:02:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF82C433C7;
        Fri, 24 Nov 2023 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700841726;
        bh=margAB1FzEUm28u+SgniGfAuXbnIN6dTK7wX7ICYgeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPTG2RvjkMuXUNhYhCCpRkG9RWlYusNzNY8XVGNsFSwmwojcfr807/m/8S1bsnSL3
         RS87G+2bFn/fJXYKzCSGpYaqm56tO+XtMYAoe0Mpur3NGPNMMo6rwxsEFbQ1KKNC7j
         wOYT5+m+P1LFDRfeUDcax3hvJQzZR4dXyrXlMfjrnfEHSbEajqd2fTCpCCcnQYSgCB
         OwjMNCiCQKmkCleo77Z2TJXIHLZ5ADqSqPU/4o6OlaPOMkeYShs7bIq9AIgv3ACpW4
         MG83wjLWH/KRYQCA+JmD6cLfisi16jk7pCNDbuUFglJXvsrSKrmO3z5Y6IWppJdbKN
         aFAPCO4rEbksw==
Date:   Fri, 24 Nov 2023 17:02:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue
 pipe_write()
Message-ID: <20231124-gearbeitet-unberechenbar-70241992a995@brauner>
References: <20231124150822.2121798-1-jannh@google.com>
 <1210483.1700841227@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1210483.1700841227@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:53:47PM +0000, David Howells wrote:
> Jann Horn <jannh@google.com> wrote:
> 
> > +	/*
> > +	 * Reject writing to watch queue pipes before the point where we lock
> > +	 * the pipe.
> > +	 * Otherwise, lockdep would be unhappy if the caller already has another
> > +	 * pipe locked.
> > +	 * If we had to support locking a normal pipe and a notification pipe at
> > +	 * the same time, we could set up lockdep annotations for that, but
> > +	 * since we don't actually need that, it's simpler to just bail here.
> > +	 */
> > +	if (pipe_has_watch_queue(pipe))
> > +		return -EXDEV;
> > +
> 
> Linus wanted it to be possible for the user to write to a notificaiton pipe.

Since it has been disabled from the start and nothing has ever actually
materialized we just don't need to care. If we start caring this needs
more work anyway iirc.
