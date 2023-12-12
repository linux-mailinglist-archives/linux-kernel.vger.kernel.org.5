Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4527A80F0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377070AbjLLP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376850AbjLLP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:28:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1D0D71
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:28:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7AC433C9;
        Tue, 12 Dec 2023 15:28:09 +0000 (UTC)
Date:   Tue, 12 Dec 2023 10:28:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker
 output
Message-ID: <20231212102851.5e181e33@gandalf.local.home>
In-Reply-To: <148974c2-df17-4c71-a59a-6e056e10910e@efficios.com>
References: <20231212084444.4619b8ce@gandalf.local.home>
        <148974c2-df17-4c71-a59a-6e056e10910e@efficios.com>
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

On Tue, 12 Dec 2023 09:23:54 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-12 08:44, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > If for some reason the trace_marker write does not have a nul byte for the
> > string, it will overflow the print:  
> 
> Does this result in leaking kernel memory to userspace ? If so, it
> should state "Fixes..." and CC stable.

No, it was triggered because of a bug elsewhere ;-)

  https://lore.kernel.org/linux-trace-kernel/20231212072558.61f76493@gandalf.local.home/

Which does have a Cc stable and Fixes tag.

The event truncated the trace_marker output and caused the buffer overflow
here. The trace_marker always adds a '\0', but that got dropped due to the
other bug. This is just hardening the kernel.

Note, this can only happen with the new code that allows trace_marker to
use the max size of the buffer, which is for the next kernel release.

-- Steve
