Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C67FC15F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjK1OyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345803AbjK1OyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED1D60
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583DDC433C8;
        Tue, 28 Nov 2023 14:54:15 +0000 (UTC)
Date:   Tue, 28 Nov 2023 09:54:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmytro Maluka <dmaluka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <20231128095437.423f5f88@gandalf.local.home>
In-Reply-To: <20231128092029.342f5f03@gandalf.local.home>
References: <20231127174108.3c331c9c@gandalf.local.home>
        <ZWXntcHNflkbrxd7@google.com>
        <20231128092029.342f5f03@gandalf.local.home>
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

On Tue, 28 Nov 2023 09:20:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 28 Nov 2023 14:14:29 +0100
> Dmytro Maluka <dmaluka@chromium.org> wrote:
> 
> 
> > This limitation will cause (unrelated) events created by modules that
> > are insmoded after creating the instance to be also added to the
> > instance. Why not filter those as well?  
> 
> I did think of that. But that would be a separate patch. Where I would save
> the string that is passed in, and whenever a new module is loaded, it would
> only add the events if the events' system matches in the string. This would
> also allow adding event systems that do not yet exist.

Now that I'm implementing this, it makes more sense to just do that as one
patch. Otherwise the check against the systems string is redundant, as the
creation of the events needs to check against the tr->systems too. I found
that I was deleting most of this patch to implement the change.

-- Steve
