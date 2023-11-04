Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F67E0ED1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 11:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjKDKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D1191;
        Sat,  4 Nov 2023 03:52:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C48C433C7;
        Sat,  4 Nov 2023 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699095128;
        bh=JAQzfnL7a2XNBBwy0ihLXq/4JX6Tfc5YeXjkF7JEm9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4NrV/C/8GIF+0H0zbZtQPYxVDEDCMLd4m+FsVXa1Rj+XWpC22zaSCG8QXRjYLjA9
         of9cchfnYtFBK0W5RasRZpy77ydRhq0H+hBkOk6YKNInyZPHlpedAe5Z2foH5DNu7A
         NKESoqXC1rol9dNinnXBD4gy2KLN99lMVw+KHWHgIBvLSimfrfi4S+gge536BlBNR/
         PDDs5YQqjKMPTUTWA0HqvLDyO/sRdMTKvbipwuTyzvqDinmrXqUNrkiqEj9oS4Olda
         XN18veNqzgZy9yJYiwpivh35AM4ZG9Fx8l7V5hAfPPPEQqcVOkE+6Rd3uI8gJSHOAp
         88nhJ+44DN7dA==
Date:   Sat, 4 Nov 2023 19:52:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 04/48] perf dwarf-aux: Fix die_get_typename() for void *
Message-Id: <20231104195202.e8c300fcdc3938e2bf13f5cf@kernel.org>
In-Reply-To: <20231012035111.676789-5-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-5-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:50:27 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_get_typename() is to return a C-like type name from DWARF debug
> entry and it follows data type if the target entry is a pointer type.
> But I found void pointers don't have the type attribte to follow and
> then the function returns an error for that case.  This results in a
> broken type string for void pointer types.
> 
> For example, the following type entries are pointer types.
> 
>  <1><48c>: Abbrev Number: 4 (DW_TAG_pointer_type)
>     <48d>   DW_AT_byte_size   : 8
>     <48d>   DW_AT_type        : <0x481>
>  <1><491>: Abbrev Number: 211 (DW_TAG_pointer_type)
>     <493>   DW_AT_byte_size   : 8
>  <1><494>: Abbrev Number: 4 (DW_TAG_pointer_type)
>     <495>   DW_AT_byte_size   : 8
>     <495>   DW_AT_type        : <0x49e>
> 
> The first one at offset 48c and the third one at offset 494 have type
> information.  Then they are pointer types for the referenced types.
> But the second one at offset 491 doesn't have the type attribute.

This looks good to me!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 2941d88f2199..4849c3bbfd95 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1090,7 +1090,14 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
>  		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
>  	}
>  	ret = die_get_typename(&type, buf);
> -	return ret ? ret : strbuf_addstr(buf, tmp);
> +	if (ret < 0) {
> +		/* void pointer has no type attribute */
> +		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
> +			return strbuf_addf(buf, "void*");
> +
> +		return ret;
> +	}
> +	return strbuf_addstr(buf, tmp);
>  }
>  
>  /**
> -- 
> 2.42.0.655.g421f12c284-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
