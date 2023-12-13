Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0C81088F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378397AbjLMDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378288AbjLMDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:09:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4AAB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:09:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B41CC433C8;
        Wed, 13 Dec 2023 03:09:27 +0000 (UTC)
Date:   Tue, 12 Dec 2023 22:10:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker
 output
Message-ID: <20231212221010.70c84d2d@gandalf.local.home>
In-Reply-To: <20231212084444.4619b8ce@gandalf.local.home>
References: <20231212084444.4619b8ce@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 08:44:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If for some reason the trace_marker write does not have a nul byte for the
> string, it will overflow the print:
> 
>   trace_seq_printf(s, ": %s", field->buf);
> 
> The field->buf could be missing the nul byte. To prevent overflow, add the
> max size that the buf can be by using the event size and the field
> location.
> 
>   int max = iter->ent_size - offsetof(struct print_entry, buf);
> 
>   trace_seq_printf(s, ": %*s", max, field->buf);

Bah, this needs to be:

   trace_seq_printf(s, ": %.*s", max, field->buf);

Note the '.' between % and *. Otherwise it right aligns the output.

This did fail the selftest for trace_printk(), but I modified the new one
to add " *" to accommodate it :-p

Sending out v2.

-- Steve

