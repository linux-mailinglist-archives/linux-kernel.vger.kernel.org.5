Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2897E80DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjKJSTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346212AbjKJSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA29ECD;
        Fri, 10 Nov 2023 02:26:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F3DC433C7;
        Fri, 10 Nov 2023 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611996;
        bh=n76Je2umvcSaid71IZlTqqdp2GtgwGMCUH+EilvbftA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cHwKi/IupLycs7qVNViSUZCNF2EdE8w0A3oyLL1gg8pMn7PY2KwYk+96d9QTz6HLj
         5GN2CRrmBrtBhCIzZ/1hUdFmns1GU0kTyq5Raoh1uDlrZ0BSNQktYp3IQlw3VxHyuZ
         34ZJDWTFir+mD4B+zblKcUCX105moXRE8YeStOxymxNV6VbBIsp3ZB7X4bHMk4oCZF
         w6k+xuAysc0P392yIUhrRoItqIOZBSgwAgLObvox1d8RAeYeTAUpd1VVft+rc4S6Ot
         PHNG1i9rwEi9wBGvjerGpKMmgY9hOe5k/bkwIEzy1r64a40jKa0xKSET61n8K8qYlz
         yiYwcsMrU+dog==
Date:   Fri, 10 Nov 2023 19:26:30 +0900
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 08/52] perf build: Add feature check for dwarf_getcfi()
Message-Id: <20231110192630.fd212e5f98049f1cf9cea72f@kernel.org>
In-Reply-To: <20231110000012.3538610-9-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
        <20231110000012.3538610-9-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 15:59:27 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> The dwarf_getcfi() is available on libdw 0.142+.  Instead of just
> checking the version number, it'd be nice to have a config item to check
> the feature at build time.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/Makefile.feature            | 1 +
>  tools/build/feature/Makefile            | 4 ++++
>  tools/build/feature/test-dwarf_getcfi.c | 9 +++++++++
>  3 files changed, 14 insertions(+)
>  create mode 100644 tools/build/feature/test-dwarf_getcfi.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 934e2777a2db..64df118376df 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -32,6 +32,7 @@ FEATURE_TESTS_BASIC :=                  \
>          backtrace                       \
>          dwarf                           \
>          dwarf_getlocations              \
> +        dwarf_getcfi                    \
>          eventfd                         \
>          fortify-source                  \
>          get_current_dir_name            \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index dad79ede4e0a..37722e509eb9 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -7,6 +7,7 @@ FILES=                                          \
>           test-bionic.bin                        \
>           test-dwarf.bin                         \
>           test-dwarf_getlocations.bin            \
> +         test-dwarf_getcfi.bin                  \
>           test-eventfd.bin                       \
>           test-fortify-source.bin                \
>           test-get_current_dir_name.bin          \
> @@ -154,6 +155,9 @@ endif
>  $(OUTPUT)test-dwarf_getlocations.bin:
>  	$(BUILD) $(DWARFLIBS)
>  
> +$(OUTPUT)test-dwarf_getcfi.bin:
> +	$(BUILD) $(DWARFLIBS)
> +
>  $(OUTPUT)test-libelf-getphdrnum.bin:
>  	$(BUILD) -lelf
>  
> diff --git a/tools/build/feature/test-dwarf_getcfi.c b/tools/build/feature/test-dwarf_getcfi.c
> new file mode 100644
> index 000000000000..50e7d7cb7bdf
> --- /dev/null
> +++ b/tools/build/feature/test-dwarf_getcfi.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <elfutils/libdw.h>
> +
> +int main(void)
> +{
> +	Dwarf *dwarf = NULL;
> +	return dwarf_getcfi(dwarf) == NULL;
> +}
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
