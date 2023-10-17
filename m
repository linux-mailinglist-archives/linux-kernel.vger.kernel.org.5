Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C577CC00D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjJQJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjJQJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:59:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2BC8E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:59:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36854C433C7;
        Tue, 17 Oct 2023 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697536790;
        bh=Uye4W9O8kTvER67qDMlch+hav48ZMIcnc4Vr6afxx+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6WsQkoTVoumk03Agu7C9q2I+hV+tebvoyvgftrwcMd6giSSM1mHugm0gaPRMWvlQ
         S+jKMNmjmERpRLKMFRedgawg3u0uQngxJWSY6febbMHsdHwURiRUvUZwZwIkeBlESw
         0Nm9xFfNNq6RNGm4/565WTkVBVkSFRDSWgPTuMHed5F/+J6MaIKRNBTz+6bOoB+uHp
         e8pcOe8BDoPLRat4g7g2VW0nWSNYNTUCYgd5h2h5wcWxu4jgSdxv5KnOCQ3MAzVrWF
         DCIsYSRxbhUbeySKfVvDTDXm4/n+dqIQQcZs+XPyJR9cZQ74WDAm+wf7SOh+XGyAgZ
         RuIuCgSCwDHMQ==
Date:   Tue, 17 Oct 2023 11:59:47 +0200
From:   Simon Horman <horms@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
Message-ID: <20231017095947.GX1751252@kernel.org>
References: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:49:04PM +0200, Geert Uytterhoeven wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

