Return-Path: <linux-kernel+bounces-7687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B045C81AB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A45728318A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E151621;
	Thu, 21 Dec 2023 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qln/fFKL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4F15AE;
	Thu, 21 Dec 2023 00:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0F4C433C7;
	Thu, 21 Dec 2023 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703118198;
	bh=bONeV2TAH0euPBDuLPIhi+40gf1nGz6dvjGS69mpuBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qln/fFKLUDylH87qzALmZ8B/BcYG78GcwSRhYU6FQxLdo4wp3H3h4x7mzwhJDq1MV
	 iTxJHxk4nKeJCpo6VzEp0z8Z8gJ7Ov9r3m0069Ig5aA1K8bDr3VW5dKMS9gD+7Fmxs
	 /Lebz1IetuWmBB4ezwS3cQChKLIoEjeuCxM6eyh/kvuO/LwPCQNvgPZeA9DJQwji18
	 zv+wYYod3WLcSrtJOGEcmqyLIl4QCv9aGmZATEIeJYvWTt03jLoxbPfUcHM30Dh4Ew
	 mdBJADGXBx/8Yh3qdwPbS80yHH/WT1O2WPg+vuYJRwrqlG2gfbChdn3C7w6AWsMANI
	 iWNyYU78DJbxA==
Date: Thu, 21 Dec 2023 09:23:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 14/15] ringbuffer/selftest: Add basic selftest to
 test changing subbuf order
Message-Id: <20231221092312.e5b077d66c6867ea7db75e44@kernel.org>
In-Reply-To: <20231219185631.520496304@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185631.520496304@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 13:54:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a self test that will write into the trace buffer with differ trace
> sub buffer order sizes.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/00basic/ringbuffer_order.tc | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
> new file mode 100644
> index 000000000000..ecbcc810e6c1
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
> @@ -0,0 +1,95 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Change the ringbuffer sub-buffer order
> +# requires: buffer_subbuf_order
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
> +	echo $str > trace_marker
> +
> +	echo $str
> +}
> +
> +test_buffer() {
> +	orde=$1
> +	page_size=$((4096<<order))
> +
> +	size=`get_buffer_data_size`
> +
> +	# the size must be greater than or equal to page_size - data_offset
> +	page_size=$((page_size-data_offset))
> +	if [ $size -lt $page_size ]; then
> +		exit fail
> +	fi
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
> +ORIG=`cat buffer_subbuf_order`
> +
> +# Could test bigger orders than 3, but then creating the string
> +# to write into the ring buffer takes too long

For testing purpose, I think it is better to check whether the maximum order
can pass or not. Or shrink down the max order to support. (I think order=3 is
enough big at this moment)

Thank you,

> +for a in 0 1 2 3 ; do
> +	echo $a > buffer_subbuf_order
> +	test_buffer $a
> +done
> +
> +echo $ORIG > buffer_subbuf_order
> +
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

