Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6379A0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjIKA0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjIKA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:26:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE319C;
        Sun, 10 Sep 2023 17:26:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2942BC433C7;
        Mon, 11 Sep 2023 00:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694391976;
        bh=NlU/rEti1tbmCr8YAFrkbrxfNfLfiM9Akt+e5eaoOnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IpOPMHXvh/jFYr4NJYFGMB4tpwbKYcpE46SLh8txDsLKL07HleZ3+mF52uWmmItyN
         uuEqH/di3TrOEwDbRvyYLExIuqB/XwUShmP3Dn1FCgjAc4uJt6jYFHthczePTuoN7j
         XiCHdSJduTYFOnYHqR8cJ5S+0M19RzAP+ZdSn27plXasyAk1vvmpDQDdJQga1xLv0g
         PRdtWnb05VKXC0gLF/TBhC5ASUP49gG6k7umRCY7buOgyqRE13mIUWGVjK7bK28HzR
         oLXmeUM55p1EBN7alIDLot1bdfXfqPtcQZXSqTzBg5co6lfk5Xv27fR+XiO1tnsVrA
         wm4sNjLO+wZ+Q==
Date:   Mon, 11 Sep 2023 09:26:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RESEND][PATCH] tracing/synthetic: Fix order of struct
 trace_dynamic_info
Message-Id: <20230911092612.775372d425e97da96da6f047@kernel.org>
In-Reply-To: <20230908163929.2c25f3dc@gandalf.local.home>
References: <20230908163929.2c25f3dc@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2023 16:39:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> To make handling BIG and LITTLE endian better the offset/len of dynamic
> fields of the synthetic events was changed into a structure of:
> 
>  struct trace_dynamic_info {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> 	u16	offset;
> 	u16	len;
>  #else
> 	u16	len;
> 	u16	offset;
>  #endif
>  };
> 
> to replace the manual changes of:
> 
>  data_offset = offset & 0xffff;
>  data_offest = len << 16;
> 
> But if you look closely, the above is:
> 
>   <len> << 16 | offset
> 
> Which in little endian would be in memory:
> 
>  offset_lo offset_hi len_lo len_hi
> 
> and in big endian:
> 
>  len_hi len_lo offset_hi offset_lo
> 
> Which if broken into a structure would be:
> 
>  struct trace_dynamic_info {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> 	u16	len;
> 	u16	offset;
>  #else
> 	u16	offset;
> 	u16	len;
>  #endif
>  };
> 
> Which is the opposite of what was defined.
> 
> Fix this and just to be safe also add "__packed".
> 
> Link: https://lore.kernel.org/all/20230908154417.5172e343@gandalf.local.home/

Good catch! I'm not sure why this worked. Maybe we don't have any testcase
for this feature?

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Cc: stable@vger.kernel.org
> Fixes: ddeea494a16f3 ("tracing/synthetic: Use union instead of casts")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
>  [ Resending to the correct mailing list this time :-p ]
> 
>  include/linux/trace_events.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 12f875e9e69a..21ae37e49319 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -62,13 +62,13 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
>  /* Used to find the offset and length of dynamic fields in trace events */
>  struct trace_dynamic_info {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> -	u16	offset;
>  	u16	len;
> +	u16	offset;
>  #else
> -	u16	len;
>  	u16	offset;
> +	u16	len;
>  #endif
> -};
> +} __packed;
>  
>  /*
>   * The trace entry - the most basic unit of tracing. This is what
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
