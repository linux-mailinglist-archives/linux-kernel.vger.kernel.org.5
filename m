Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01DC778DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjHKLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjHKLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8D26B6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4831B64135
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127ADC433C7;
        Fri, 11 Aug 2023 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754045;
        bh=8tm1jV+HgOUZp4y+wMYuaXLozGBvMcrHW58C6uqLa3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNCHCMWB0RtbouXa4zqOvJ8XOUk4TMLYIaY/ev7deRVfxrGA6Sa2NrX705bdL3l5p
         +tn/HQhNsyiWIlQvqlmu+z7oWcs8HtQ4gRWHe5iOtVHH8+F8cghe3II+SKJyBt21Qs
         ILuCOl7o6Y5ubDy9x1wba7D32Bs0ErMWfU4vYK3xkiEvb20porqh3opt8SopkQfdt7
         FIDWD36HL1uB2qvTekdJVkqBsZkhya7l0FtrXg1T9YXfORkB+V8G94wAJJ7PKXAzNo
         V6O6R0w+eJuCJH08eQ87sVpq1NqJ6Ol+WgpwmDUF7r6wl2YtOB+nkmEKyHoiO9dm4P
         IQbA4HlpRiEWQ==
Date:   Fri, 11 Aug 2023 13:40:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Rheinsberg <david@readahead.eu>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Message-ID: <20230811-perplex-installieren-899f5925534d@brauner>
References: <20230807085203.819772-1-david@readahead.eu>
 <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
 <20230811112911.GA22566@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811112911.GA22566@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:29:11PM +0200, Oleg Nesterov wrote:
> Hi Christian,
> 
> Sorry for delay, I've just returned from vacation and I am slowly

Absolutely no problem! Thanks for getting back to us.

> crawling my email backlog.
> 
> 
> 
> On 08/07, Christian Brauner wrote:
> >
> > >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> > >  {
> > > -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > > +	if (!pid)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Non thread-group leaders cannot have pidfds, but we allow them for
> > > +	 * reaped thread-group leaders.
> > > +	 */
> > > +	if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDTYPE_TGID))
> > >  		return -EINVAL;
> >
> > TL;DR userspace wants to be able to get a pidfd to an already reaped
> > thread-group leader. I don't see any issues with this.
> 
> I guess I need to read the whole thread carefully, but right now
> I don't understand this patch and the problem...
> 
> OK, suppose we have a group leader L with pid 100 and its sub-thread
> T with pid 101.
> 
> With this patch pidfd_open(101) can succeed if T exits right after
> find_get_pid(101) because pid_has_task(pid, PIDTYPE_PID) above will
> fail, right?
> 
> This looks wrong, 101 was never a leader pid...

Well, let me simplify the question:

What code do we need to allow userspace to open a pidfd to a leader pid
even if it has already been exited and reaped (without also accidently
allowing to open non-lead pid pidfds)?

I hope that clarifies?
