Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F863790304
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350758AbjIAU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350815AbjIAU6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:58:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EA01B0;
        Fri,  1 Sep 2023 13:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9713DCE24C2;
        Fri,  1 Sep 2023 20:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09643C433C8;
        Fri,  1 Sep 2023 20:57:47 +0000 (UTC)
Date:   Fri, 1 Sep 2023 16:57:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, ast@kernel.org,
        dcook@linux.microsoft.com
Subject: Re: [PATCH 0/3] tracing/user_events: Allow events to persist for
 perfmon_capable users
Message-ID: <20230901165757.13eb2793@gandalf.local.home>
In-Reply-To: <20230901204332.159-1-beaub@linux.microsoft.com>
References: <20230901204332.159-1-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Beau,

Just an FYI, except for fixes, it is never a good ideal to send out patches
while the merge window is open. They will likely be ignored for the
entirety of the merge window.

-- Steve


On Fri,  1 Sep 2023 20:43:29 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> There are several scenarios that have come up where having a user_event
> persist even if the process that registered it exits. The main one is
> having a daemon create events on bootup that shouldn't get deleted if
> the daemon has to exit or reload. Another is within OpenTelemetry
> exporters, they wish to potentially check if a user_event exists on the
> system to determine if exporting the data out should occur. The
> user_event in this case must exist even in the absence of the owning
> process running (such as the above daemon case).
> 
> Since persistent events aren't automatically cleaned up, we want to ensure
> only trusted users are allowed to do this. It seems reasonable to use
> CAP_PERFMON as that boundary, since those users can already do many things
> via perf_event_open without requiring full CAP_SYS_ADMIN.
> 
> This patchset brings back the ability to use /sys/kernel/tracing/dynamic_events
> to create user_events, as persist is now back to being supported. Both the
> register and delete of events that persist require CAP_PERFMON, which prevents
> a non-perfmon user from making an event go away that a perfmon user decided
> should persist.
> 
> Beau Belgrave (3):
>   tracing/user_events: Allow events to persist for perfmon_capable users
>   selftests/user_events: Test persist flag cases
>   tracing/user_events: Document persist event flags
> 
>  Documentation/trace/user_events.rst           | 21 ++++++-
>  include/uapi/linux/user_events.h              | 11 +++-
>  kernel/trace/trace_events_user.c              | 28 +++++-----
>  .../testing/selftests/user_events/abi_test.c  | 55 ++++++++++++++++++-
>  .../testing/selftests/user_events/dyn_test.c  | 54 +++++++++++++++++-
>  5 files changed, 149 insertions(+), 20 deletions(-)
> 
> 
> base-commit: f940e482b0f889e697372a22b6c15da87aa1f63a

