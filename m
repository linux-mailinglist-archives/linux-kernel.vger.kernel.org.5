Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8A80A4AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573835AbjLHNsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573825AbjLHNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:48:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106621732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:48:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D31C433C9;
        Fri,  8 Dec 2023 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702043315;
        bh=HKakyx8zq6fOmZMYXMir1ka2znDXEo4ataLQzc31ar4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvSOlLqA2qq/XZBRLBixMaEvYWxt4NW3Lbbf2tJRbJnWW2vaiZptxhL0GhOW7ZTez
         6AdtUtbjy2X6nFxvtSxXFxhhPK0V/RwrNvTTr4aTtdqOSBoaUgB3FT5kFpzp7AD5aa
         7vhRx1i7jkWHdh+POPRxqmUX60WsoUnZZlxVuP3+jgL3qXcnMR9f4CszRcUbTS8h2j
         ltzQu8O3/IlR/DztllzO/q7/RfhEr4OhDIqasNEZtfKcytZVuHbtkPqnnlo+dvGXET
         h7790W94yku+ovP0+I9u5ZjjDu40FnVLp2usMbejEhdM5rfRgOGAb19mtxFBPcnsYf
         YfCnL0ZORHRhQ==
Date:   Fri, 8 Dec 2023 14:48:30 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231208-hitzig-charmant-6bbdc427bf7e@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
 <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
 <87wmtog7ht.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmtog7ht.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 02:15:58PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > File descriptors are reachable for all processes/threads that share a
> > file descriptor table. Changing that means breaking core userspace
> > assumptions about how file descriptors work. That's not going to happen
> > as far as I'm concerned.
> 
> It already has happened, though?  Threads are free to call
> unshare(CLONE_FILES).  I'm sure that we have applications out there that

If you unshare a file descriptor table it will affect all file
descriptors of a given task. We don't allow hiding individual or ranges
of file descriptors from close/dup. That's akin to a partially shared
file descriptor table which is conceptually probably doable but just
plain weird and nasty to get right imho.

This really is either LSM territory to block such operations or use
stuff like io_uring gives you.
