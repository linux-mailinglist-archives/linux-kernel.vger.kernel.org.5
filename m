Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3657769AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGaPV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGaPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002E2C3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 894CF61161
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EEDC433C8;
        Mon, 31 Jul 2023 15:21:24 +0000 (UTC)
Date:   Mon, 31 Jul 2023 11:21:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Jim Cromie <jim.cromie@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        daniel@ffwll.ch, sergey.senozhatsky@gmail.com,
        Simon Ser <contact@emersion.fr>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [RFC PATCH 1/1] tracefs: add TP_printk_no_nl - RFC
Message-ID: <20230731112122.41a76154@gandalf.local.home>
In-Reply-To: <ZMeLKTzSWh3kbw8c@alley>
References: <20230730222134.54547-1-jim.cromie@gmail.com>
        <87y1iwlc80.fsf@jogness.linutronix.de>
        <ZMeLKTzSWh3kbw8c@alley>
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

On Mon, 31 Jul 2023 12:21:29 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > Grepping through the kernel, I am surprised how many messages are
> > missing the trailing newline when it is obvious they are not intended to
> > be extended. I consider these bugs.  
> 
> I consider this bug as well.
> 
> My understanding is that this patch affects only messages printed to
> the ftrace buffer so that it does not affect printk() directly.
> 
> But still. It creates a habit that is bad for printk(). Also relies
> on the fact that people are aware of this macro and use it. IMHO,
> it will not work in practice. Or do I miss something?

I believe that the problem Jim is addressing is that there's printk()
messages that also go to a tracepoint() function. The tracepoint function
will add its own '\n' to the message, and now we have two '\n's and this
causes extra spaces in the output of the ftrace ring buffer.

Perhaps what we should do is to make sure that the output doesn't add more
newlines than just one.

Something like this: (totally untested)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index db575094c498..a1b73ffa1552 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -333,6 +333,8 @@ int trace_output_raw(struct trace_iterator *iter, char *name,
 
 	trace_seq_printf(s, "%s: ", name);
 	trace_seq_vprintf(s, trace_event_format(iter, fmt), ap);
+	trace_seq_trim_newlines(s);
+	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
 }
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index bac06ee3b98b..d4e2049809e3 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -221,6 +221,22 @@ void trace_seq_puts(struct trace_seq *s, const char *str)
 }
 EXPORT_SYMBOL_GPL(trace_seq_puts);
 
+/**
+ * trace_seq_trim_newlines - remove ending newlines
+ * @s: trace sequence descriptor
+ *
+ * Remove ending newlines from the buffer.
+ */
+void trace_seq_trim_newlines(struct trace_seq *s)
+{
+	if (unlikely(!s->seq.size || !s->seq.len))
+		return;
+
+	while (s->seq.len && s->buffer[s->seq.len - 1] == '\n') {
+		s->seq.len--;
+	}
+}
+
 /**
  * trace_seq_putc - trace sequence printing of simple character
  * @s: trace sequence descriptor



A similar thing would need to go into libtraceevent.

-- Steve
