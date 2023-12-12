Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52680FB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377513AbjLLXp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjLLXp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:45:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B47B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:46:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC954C433C9;
        Tue, 12 Dec 2023 23:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702424762;
        bh=pGrGsb6BqxBVwTK3LkmsdHZprxehakyiO1idycywAO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gwJ8APWwAUn/s8Kn8zl7ScvgcxqA/yEKePvL7j0R1K7INopMzTXpKrtOv4A0JO5nj
         m11Hsk+B6NaVlH7AHuOxZFE+uQiKOviAP/APCmS4OFBIxyuFK0uQRPf4jP/hlJe/Nz
         QfsgDfyc9fqy8Kvw3EnKkUnJECSQfgSdsrYSuFkCV9CblO46Q4giWeRf7jFMgd5mkb
         LIlH/UWhYLQmg7V9fZ0PROuM5FXzUrScDc+ic/xbPOeNsjCJFPtxT76iCzYT35pUQR
         TnCk8LV+bl7wdQ/R24wPhxndUGdpulAvjSh2Uk3ZzfPTTd7nmVJaQBuGKQVio6YWdn
         /2Reh/5NTEf/w==
Date:   Wed, 13 Dec 2023 08:45:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v3] ring-buffer: Fix writing to the buffer with
 max_data_size
Message-Id: <20231213084558.90dc9a9064c48cebb3d0ab8f@kernel.org>
In-Reply-To: <20231212111617.39e02849@gandalf.local.home>
References: <20231212111617.39e02849@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 11:16:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The maximum ring buffer data size is the maximum size of data that can be
> recorded on the ring buffer. Events must be smaller than the sub buffer
> data size minus any meta data. This size is checked before trying to
> allocate from the ring buffer because the allocation assumes that the size
> will fit on the sub buffer.
> 
> The maximum size was calculated as the size of a sub buffer page (which is
> currently PAGE_SIZE minus the sub buffer header) minus the size of the
> meta data of an individual event. But it missed the possible adding of a
> time stamp for events that are added long enough apart that the event meta
> data can't hold the time delta.
> 
> When an event is added that is greater than the current BUF_MAX_DATA_SIZE
> minus the size of a time stamp, but still less than or equal to
> BUF_MAX_DATA_SIZE, the ring buffer would go into an infinite loop, looking
> for a page that can hold the event. Luckily, there's a check for this loop
> and after 1000 iterations and a warning is emitted and the ring buffer is
> disabled. But this should never happen.
> 
> This can happen when a large event is added first, or after a long period
> where an absolute timestamp is prefixed to the event, increasing its size
> by 8 bytes. This passes the check and then goes into the algorithm that
> causes the infinite loop.
> 
> For events that are the first event on the sub-buffer, it does not need to
> add a timestamp, because the sub-buffer itself contains an absolute
> timestamp, and adding one is redundant.
> 
> The fix is to check if the event is to be the first event on the
> sub-buffer, and if it is, then do not add a timestamp.
> 
> This also fixes 32 bit adding a timestamp when a read of before_stamp or
> write_stamp is interrupted. There's still no need to add that timestamp if
> the event is going to be the first event on the sub buffer.
> 
> Also, if the buffer has "time_stamp_abs" set, then also check if the
> length plus the timestamp is greater than the BUF_MAX_DATA_SIZE.
> 
> Link: https://lore.kernel.org/all/20231212104549.58863438@gandalf.local.home/
> Link: https://lore.kernel.org/linux-trace-kernel/20231212071837.5fdd6c13@gandalf.local.home
> 
> Cc: stable@vger.kernel.org
> Fixes: a4543a2fa9ef3 ("ring-buffer: Get timestamp after event is allocated")
> Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev> # (on IRC)
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This looks good to me :)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
> Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231212065922.05f28041@gandalf.local.home
> 
> - Just test 'w' first, and then do the rest of the checks.
> 
>  kernel/trace/ring_buffer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8d2a4f00eca9..b8986f82eccf 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3579,7 +3579,10 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * absolute timestamp.
>  		 * Don't bother if this is the start of a new page (w == 0).
>  		 */
> -		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
> +		if (!w) {
> +			/* Use the sub-buffer timestamp */
> +			info->delta = 0;
> +		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
>  			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
>  			info->length += RB_LEN_TIME_EXTEND;
>  		} else {
> @@ -3737,6 +3740,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
>  	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
>  		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
>  		info.length += RB_LEN_TIME_EXTEND;
> +		if (info.length > BUF_MAX_DATA_SIZE)
> +			goto out_fail;
>  	} else {
>  		add_ts_default = RB_ADD_STAMP_NONE;
>  	}
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
