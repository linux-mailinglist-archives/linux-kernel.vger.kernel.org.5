Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AF7FACF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjK0WHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjK0WHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:07:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD611AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:07:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A481C433C8;
        Mon, 27 Nov 2023 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701122875;
        bh=Pd2lrvZN64SWRH0wcWaPWp9+PsGXR7gb152kvDVOw/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIAQJLBrEziTi5p0BsOU2Mjm3xwYQPS423Cd8EYL4zB5FSBsa6cqmv3/+ALqqfw5n
         ahJRQJ88CuhkYPcpLbItm3IXWrOQ47NhOr+RMcyh/0iYbZ31oz0WqkJUVVdTtmhhJl
         AMntYgTfJPt6c07KCaEJi0/8cTtojT0QGe6s0j6qDEQSF01Q78/hISAxSAAGJF4G3C
         qMWgaP7svBQxLT0U53YttBMtVrqlSF7N7wj2MqgAk0G8F7k47Q6j8iWEZqRgMZmFQr
         Qbc/VElhRRI9XspZRL9mAIzje9PPtITaR9tkosTObD91iZLVHc5EY46nLOcwzTDkkN
         92CIasqrKwh7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2118440094; Mon, 27 Nov 2023 19:07:53 -0300 (-03)
Date:   Mon, 27 Nov 2023 19:07:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 32/52] perf dwarf-aux: Add die_find_variable_by_addr()
Message-ID: <ZWUTOdJukt/GNp2t@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-33-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110000012.3538610-33-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 03:59:51PM -0800, Namhyung Kim escreveu:
> The die_find_variable_by_addr() is to find a variables in the given DIE
> using given (PC-relative) address.  Global variables will have a
> location expression with DW_OP_addr which has an address so can simply
> compare it with the address.
> 
>   <1><143a7>: Abbrev Number: 2 (DW_TAG_variable)
>       <143a8>   DW_AT_name        : loops_per_jiffy
>       <143ac>   DW_AT_type        : <0x1cca>
>       <143b0>   DW_AT_external    : 1
>       <143b0>   DW_AT_decl_file   : 193
>       <143b1>   DW_AT_decl_line   : 213
>       <143b2>   DW_AT_location    : 9 byte block: 3 b0 46 41 82 ff ff ff ff
>                                      (DW_OP_addr: ffffffff824146b0)
> 
> Note that the type-offset should be calculated from the base address of
> the global variable.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

