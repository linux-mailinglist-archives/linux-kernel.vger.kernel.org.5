Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7572080960E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjLGW65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjLGW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:58:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CED5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:58:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E2EC433C8;
        Thu,  7 Dec 2023 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701989938;
        bh=fdYFS4UIedapRqvC5EhadTwBycy5c+nIp6a9D9KoFRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ajlap/dwWcOOVf6xWLdUG5Vsge9GGLtQW+REAyRu744RSdrP4n5ULO78N2vxy2FpO
         2UQRb1NaMqxYWufUFrnoowD7r/oY745sxRF4hvL7U7wgJFyEu6V4ot6H2SLMPN/A7s
         RQClP11Zuo72c7tQdSXd0+5hGtIhElFMpVn4V7xYGr9/T/DSmUcSUnVOHSR1AnyVdN
         0aOErRZIffzAFLl1Bv9qL3teozDTKGTZkSdhi8MVeyOWxRGJw5/Q87/ecbZZw0eITJ
         Z4yqFVk3Tj3sayaYk77t+kFOq5GySnmbwvVK7VbauzX4nteC7cEjaNh/Y/7C88vHsu
         DP0pH+tmg5rvA==
Date:   Thu, 7 Dec 2023 23:58:53 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttp3rprd.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adjusting Cc as that's really a separate topic]

On Thu, Nov 30, 2023 at 08:43:18PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> >>> I'd like to offer a userspace API which allows safe stashing of
> >>> unreachable file descriptors on a service thread.

Fwiw, systemd has a concept called the fdstore:

https://systemd.io/FILE_DESCRIPTOR_STORE

"The file descriptor store [...] allows services to upload during
runtime additional fds to the service manager that it shall keep on its
behalf. File descriptors are passed back to the service on subsequent
activations, the same way as any socket activation fds are passed.

[...]

The primary use-case of this logic is to permit services to restart
seamlessly (for example to update them to a newer version), without
losing execution context, dropping pinned resources, terminating
established connections or even just momentarily losing connectivity. In
fact, as the file descriptors can be uploaded freely at any time during
the service runtime, this can even be used to implement services that
robustly handle abnormal termination and can recover from that without
losing pinned resources."

> 
> >> By "safe" here do you mean not accessible via pidfd_getfd()?
> 
> No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
> intra-process transfer using /proc, but I'm hoping for something nicer.

File descriptors are reachable for all processes/threads that share a
file descriptor table. Changing that means breaking core userspace
assumptions about how file descriptors work. That's not going to happen
as far as I'm concerned.

We may consider additional security_* hooks in close*() and dup*(). That
would allow you to utilize Landlock or BPF LSM to prevent file
descriptors from being closed or duplicated. pidfd_getfd() is already
blockable via security_file_receive().

In general, messing with fds in that way is really not a good idea.

If you need something that awkward, then you should go all the way and
look at io_uring which basically has a separate fd-like handle called
"fixed files".

Fixed file indexes are separate file-descriptor like handles that can
only be used from io_uring calls but not with the regular system call
interface.

IOW, you can refer to a file using an io_uring fixed index. The index to
use can be chosen by userspace and can't be used with any regular
fd-based system calls.

The io_uring fd itself can be made a fixed file itself

The only thing missing would be to turn an io_uring fixed file back into
a regular file descriptor. That could probably be done by using
receive_fd() and then installing that fd back into the caller's file
descriptor table. But that would require an io_uring patch.
