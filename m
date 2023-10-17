Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4D7CC6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjJQPFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjJQPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:05:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204D8A45
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:54:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C14BC433C7;
        Tue, 17 Oct 2023 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697554441;
        bh=vnsbyvUsINWA4gxAuTzBrSWt2oEb7/9dfvOu0utyd1s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AlSrKzuHvCpqKf0Z3SUmI8IRy2tsD+kCXrOzkaMUesVzHE6W+/faz0mJmkdPBylnr
         9GRSNlynWwqByD5yzHwmBcAyfdECIOT+n2EA33VRYQ+e5HwWEXeHQCYE3/nFXkXMpj
         7DxPUf0G/FDXFFPYyFB3lLSx7F2k2SI5S1Ur+AgNp6vSV6VMh/7Cm+wJx0UNYk90PO
         QbdrtuSZ1BGVNVhYP1/AU8D+2Io/Cmd+dtQumHbM69iOrxNgndo8XueQhDpjjNt4vg
         x4BCka/S8HAYTNchm7IMkYH6pTLr8PvtKIBZZiAMTt/dLJWw6UXZMzqH3YSe8T+541
         PNMfvnPnY930A==
Message-ID: <eb34b339-b4f1-aeea-ccff-cbe62fb126c9@kernel.org>
Date:   Tue, 17 Oct 2023 08:54:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 6:49 AM, Geert Uytterhoeven wrote:
> When CONFIG_IPV6=n, and building with W=1:
> 
>     In file included from include/trace/define_trace.h:102,
> 		     from include/trace/events/neigh.h:255,
> 		     from net/core/net-traces.c:51:
>     include/trace/events/neigh.h: In function ‘trace_event_raw_event_neigh_create’:
>     include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
>        42 |                 struct in6_addr *pin6;
> 	  |                                  ^~~~
>     include/trace/trace_events.h:402:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
>       402 |         { assign; }                                                     \
> 	  |           ^~~~~~
>     include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
>        44 |                              PARAMS(assign),                   \
> 	  |                              ^~~~~~
>     include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
>        23 | TRACE_EVENT(neigh_create,
> 	  | ^~~~~~~~~~~
>     include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
>        41 |         TP_fast_assign(
> 	  |         ^~~~~~~~~~~~~~
>     In file included from include/trace/define_trace.h:103,
> 		     from include/trace/events/neigh.h:255,
> 		     from net/core/net-traces.c:51:
>     include/trace/events/neigh.h: In function ‘perf_trace_neigh_create’:
>     include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
>        42 |                 struct in6_addr *pin6;
> 	  |                                  ^~~~
>     include/trace/perf.h:51:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
>        51 |         { assign; }                                                     \
> 	  |           ^~~~~~
>     include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
>        44 |                              PARAMS(assign),                   \
> 	  |                              ^~~~~~
>     include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
>        23 | TRACE_EVENT(neigh_create,
> 	  | ^~~~~~~~~~~
>     include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
>        41 |         TP_fast_assign(
> 	  |         ^~~~~~~~~~~~~~
> 
> Indeed, the variable pin6 is declared and initialized unconditionally,
> while it is only used and needlessly re-initialized when support for
> IPv6 is enabled.
> 
> Fix this by dropping the unused variable initialization, and moving the
> variable declaration inside the existing section protected by a check
> for CONFIG_IPV6.
> 
> Fixes: fc651001d2c5ca4f ("neighbor: Add tracepoint to __neigh_create")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> No changes in generated code.
> 
>  include/trace/events/neigh.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

Google put your email in the spam folder, BTW.
