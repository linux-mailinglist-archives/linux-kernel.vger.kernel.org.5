Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A7812239
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442523AbjLMW70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLMW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:59:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD6EA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:59:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0881C433C9;
        Wed, 13 Dec 2023 22:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702508370;
        bh=tu87z2m0yzSYCrpZUb09UJnCb9MAH5ku9bxrta7xiXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hY36A9CwjW4Ty/pXdnOweeE+wQ0Ya22fO53ILzsQPxdcW0Jf/Y3ErRLmtdDojdFLp
         tOlP/tEgGDdQnxEqcVMB8djOZl8lHOfONUmdxWkIt9wTDtQt7X4ytnR28UZyMNu0od
         s8K4uM4/C8ohD8dgVoiiSZYs9+1p2cJyMU5+GWhzT2UCBHABuY6jH1zhKZdgeRM72x
         394b4GfPamjk/Rf+YqlH/xT1n+Gh1vxETzAy+2bOr/W1X4adoHGsS6PjDyAfbD3L74
         lyGW1M7BGXGcCKS/Yfjx4o59TPoWdNfy37S6w7cQwgiM/g1e5UeakK88leErFezb8l
         jOzra2NCdG2DA==
Date:   Thu, 14 Dec 2023 07:59:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4] tracing/selftests: Add test to test the trace_marker
Message-Id: <20231214075926.e3969c8746068953fe910ed0@kernel.org>
In-Reply-To: <20231213111527.6a4c9b58@gandalf.local.home>
References: <20231213111527.6a4c9b58@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 11:15:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a test that writes longs strings, some over the size of the sub buffer
> and make sure that the entire content is there.

This looks good to me. and tested.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v3: https://lore.kernel.org/linux-trace-kernel/20231212192317.0fb6b101@gandalf.local.home
> 
> - Removed / */ from regex, to catch more than one space added to the
>   beginning of the print. This would have caught the bug of using "%*s"
>   instead of "%.*s". Luckily, the trace_printk test caught that.
> 
>  .../ftrace/test.d/00basic/trace_marker.tc     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> new file mode 100755
> index 000000000000..9aa0db2b84fc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Basic tests on writing to trace_marker
> +# requires: trace_marker
> +# flags: instance
> +
> +get_buffer_data_size() {
> +	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
> +}
> +
> +get_buffer_data_offset() {
> +	sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/header_page
> +}
> +
> +get_event_header_size() {
> +	type_len=`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
> +	time_len=`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
> +	array_len=`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
> +	total_bits=$((type_len+time_len+array_len))
> +	total_bits=$((total_bits+7))
> +	echo $((total_bits/8))
> +}
> +
> +get_print_event_buf_offset() {
> +	sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftrace/print/format
> +}
> +
> +event_header_size=`get_event_header_size`
> +print_header_size=`get_print_event_buf_offset`
> +
> +data_offset=`get_buffer_data_offset`
> +
> +marker_meta=$((event_header_size+print_header_size))
> +
> +make_str() {
> +        cnt=$1
> +	# subtract two for \n\0 as marker adds these
> +	cnt=$((cnt-2))
> +	printf -- 'X%.0s' $(seq $cnt)
> +}
> +
> +write_buffer() {
> +	size=$1
> +
> +	str=`make_str $size`
> +
> +	# clear the buffer
> +	echo > trace
> +
> +	# write the string into the marker
> +	echo -n $str > trace_marker
> +
> +	echo $str
> +}
> +
> +test_buffer() {
> +
> +	size=`get_buffer_data_size`
> +	oneline_size=$((size-marker_meta))
> +	echo size = $size
> +	echo meta size = $marker_meta
> +
> +	# Now add a little more the meta data overhead will overflow
> +
> +	str=`write_buffer $size`
> +
> +	# Make sure the line was broken
> +	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; exit}' trace`
> +
> +	if [ "$new_str" = "$str" ]; then
> +		exit fail;
> +	fi
> +
> +	# Make sure the entire line can be found
> +	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; }' trace`
> +
> +	if [ "$new_str" != "$str" ]; then
> +		exit fail;
> +	fi
> +}
> +
> +test_buffer
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
