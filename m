Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999B480BC31
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjLJQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 11:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjLJQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 11:37:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B8F2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 08:37:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CE1C433C7;
        Sun, 10 Dec 2023 16:37:52 +0000 (UTC)
Date:   Sun, 10 Dec 2023 11:38:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231210113829.780c7097@gandalf.local.home>
In-Reply-To: <a684a5f8-9a60-4e16-93f5-747117d08371@efficios.com>
References: <20231209175003.63db40ab@gandalf.local.home>
        <2683467e-cadb-4bb8-8c50-87ef052edacb@efficios.com>
        <20231210103009.29010d00@gandalf.local.home>
        <a684a5f8-9a60-4e16-93f5-747117d08371@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 11:07:22 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > It just allows more to be written in one go.
> > 
> > I don't see why the tests need to cover this or detect this change.  
> 
> If the purpose of this change is to ensure that the entire
> trace marker payload is shown within a single event, then
> there should be a test which exercises this, and which
> validates that the end result is that the entire payload
> is indeed shown within a single event record.

No, the purpose of the change is not to do that, because there can always
be a bigger trace marker write than a single event can hold. This is the
way it has always worked. This is an optimization or "enhancement". The 1KB
restriction was actually because of a previous implementation years ago
(before selftests even existed) that wrote into a temp buffer before
copying into the ring buffer. But since we now can copy directly into the
ring buffer, there's no reason not to use the maximum that the ring buffer
can accept.

> 
> Otherwise there is no permanent validation that this change
> indeed does what it is intended to do, so it can regress
> at any time without any test noticing it.

What regress? The amount of a trace_marker write that can make it into a
the buffer in one go? Now, I agree that we should have a test to make sure
that all of the trace marker write gets into the buffer. But it's always
been allowed to break up that write however it wanted to.

Note, because different architectures have different page sizes, how much
that can make it in one go is architecture dependent. So you can have a
"regression" by simply running your application on a different architecture.

Again, it's not a requirement, it's just an enhancement.

-- Steve
