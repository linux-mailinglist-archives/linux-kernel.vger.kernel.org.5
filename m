Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC079963A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 06:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjIIE2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 00:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIIE2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 00:28:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B071BFF;
        Fri,  8 Sep 2023 21:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA0C433C8;
        Sat,  9 Sep 2023 04:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694233726;
        bh=H70h3tlx65WrCD5j7y6Z+VNbAELomiPSp2KnK/UNUgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KrJ4vl4KfcX0lqxWKHJZr5K5Ji+OgRs9Qqrf/MT18qk20gz7skRoQWFQiS8WVg6iJ
         u6Ut9vw+gcnLrt0Pj46Jqu9Mi9iF2lVVwI9Y82X2Bc9Q4WfN8yROyguJdyAlNfPvld
         xVOXcbHiIHeZllHZzUYrzYpmlOkaWsbeYrRhrxKN02wIzL+NJV/OhOu4iIXUYbmx5h
         8f4f+Y0N/7lSN2fQO+U+0ggHkBA00m3iY1B3gYA8tRNJtwKj/zJ0el+x21NZlKkYmn
         EpOeu53brnq8KypyqOGti3oiuQiGrYii6ZZR6FBZPSSKlpMorx9Y9z6G0AdEr3iZgF
         SnadX03noVdMw==
Date:   Sat, 9 Sep 2023 13:28:42 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] tracing/synthetic: Fix order of struct
 trace_dynamic_info
Message-Id: <20230909132842.47dca1388145412f7a65c0ea@kernel.org>
In-Reply-To: <20230908160157.1152301f@gandalf.local.home>
References: <20230908160157.1152301f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2023 16:01:57 -0400
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

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Link: https://lore.kernel.org/all/20230908154417.5172e343@gandalf.local.home/
> 
> Cc: stable@vger.kernel.org
> Fixes: ddeea494a16f3 ("tracing/synthetic: Use union instead of casts")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
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
