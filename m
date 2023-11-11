Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B47E8C60
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKKThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKThT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:37:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB6385F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 11:37:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F77EC433C8;
        Sat, 11 Nov 2023 19:37:13 +0000 (UTC)
Date:   Sat, 11 Nov 2023 14:37:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
Subject: Re: [PATCH v4] bus: mhi: host: Add tracing support
Message-ID: <20231111143710.3474e05a@rorschach.local.home>
In-Reply-To: <20231111-ftrace_support-v4-1-c83602399461@quicinc.com>
References: <20231111-ftrace_support-v4-1-c83602399461@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Sat, 11 Nov 2023 11:25:22 +0530
Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:
> diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
> new file mode 100644
> index 000000000000..0e99318f5d08
> --- /dev/null
> +++ b/drivers/bus/mhi/host/trace.h
> +
> +TRACE_EVENT(mhi_update_channel_state_start,
> +
> +	TP_PROTO(const char *name, int ch_num, int state),
> +
> +	TP_ARGS(name, ch_num, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: ch%d: Updating state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  TO_CH_STATE_TYPE_STR(__entry->state))
> +);
> +
> +TRACE_EVENT(mhi_update_channel_state_end,
> +
> +	TP_PROTO(const char *name, int ch_num, int state),
> +
> +	TP_ARGS(name, ch_num, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: ch%d: Updated state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  TO_CH_STATE_TYPE_STR(__entry->state))
> +);
> +

The above three events have the same format. You can save kilobytes of
memory by converting them into a DECLARE_EVENT_CLASS() and use
DEFINE_EVENT() for each event.

A TRACE_EVENT() macro is really just a wrapper around
DECLARE_EVENT_CLASS() and DEFINE_EVENT(). The DECLARE_EVENT_CLASS()
does the bulk of the work and adds the most memory footprint. By
breaking it apart for several events, it does save memory.

Whenever you can use a single DECLARE_EVENT_CLASS() for multiple
events, I strongly suggest doing so.

Thanks,

-- Steve


> +#endif
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>
> 
> ---
> base-commit: 3006adf3be79cde4d14b1800b963b82b6e5572e0
> change-id: 20231005-ftrace_support-6869d4156139
> 
> Best regards,

