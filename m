Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9C7E31AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjKFXzR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 18:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjKFXzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:55:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B98BD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 15:55:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3B7C433C8;
        Mon,  6 Nov 2023 23:55:11 +0000 (UTC)
Date:   Mon, 6 Nov 2023 18:55:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v1 04/12] dyndbg: add 2 trace-events: pr_debug, dev_dbg
Message-ID: <20231106185513.79411f9a@gandalf.local.home>
In-Reply-To: <20231103131011.1316396-5-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
        <20231103131011.1316396-5-lb@semihalf.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 14:10:03 +0100
Łukasz Bartosik <lb@semihalf.com> wrote:

> +/* capture pr_debug() callsite descriptor and message */
> +TRACE_EVENT(prdbg,
> +	    TP_PROTO(const struct _ddebug *desc, const char *text, size_t len),
> +
> +	    TP_ARGS(desc, text, len),
> +
> +	    TP_STRUCT__entry(
> +			__field(const struct _ddebug *, desc)
> +			__dynamic_array(char, msg, len + 1)
> +		    ),
> +
> +	    TP_fast_assign(
> +			__entry->desc = desc;
> +			/*
> +			 * Each trace entry is printed in a new line.
> +			 * If the msg finishes with '\n', cut it off
> +			 * to avoid blank lines in the trace.
> +			 */
> +			if (len > 0 && (text[len - 1] == '\n'))
> +				len -= 1;
> +
> +			memcpy(__get_str(msg), text, len);
> +			__get_str(msg)[len] = 0;
> +		    ),
> +


> +	    TP_printk("%s.%s %s", __entry->desc->modname,
> +		      __entry->desc->function, __get_str(msg))
> +);
> +

That TP_printk() is dangerous. How do you know __entry->desc still exists
when reading the buffer?

Is the struct _ddebug permanent? Can it be freed? If so, the above can
easily cause a crash.

-- Steve
