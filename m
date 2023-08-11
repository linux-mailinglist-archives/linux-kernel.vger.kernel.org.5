Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB90778545
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjHKCPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHKCPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB17726A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0736294C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BACC433C7;
        Fri, 11 Aug 2023 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691720152;
        bh=LIlQtLbvm5w/WB8aaUqKdtrk5OeIAXfmw6wC7KM1ZUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJDBhI/9vosasA4VInT3HhktogHJLRWwztSEeaGvEGUu3+QeUn1wB482KZG5FU4pF
         GyxqfqnAC3QIl1GKTD9pmTWPIeRVtnwGHX/Bsauz/iiGPP+HZEy3TaBy6vbYM2BYEY
         ur8YOul/U98RoVHycMJg/9VjmKARNRN1/iZmGAzrWWgaNNWZ1gborZTtpmzHav8ujB
         +lgw7yktro0W9TgduCSiRsXMATe1J7xdUo4qa0mUqKjiC82AGIEZrvXY8iyIrgSt1z
         hag6E9dy9BtA4t1DDuOmWyPC50z3u+tvbODnWHZYxFBFkLpwaX+HXpJandVSxLLj+s
         w0+IHgUV20vWg==
Date:   Fri, 11 Aug 2023 11:15:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf probe: Free string returned by
 synthesize_perf_probe_point() on failure in synthesize_perf_probe_command()
Message-Id: <20230811111548.227d9fb19f2540a3c6bb5273@kernel.org>
In-Reply-To: <ZM0mzpQktHnhXJXr@kernel.org>
References: <ZM0mzpQktHnhXJXr@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 13:26:54 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Building perf with EXTRA_CFLAGS="-fsanitize=address" a leak was detected
> elsewhere and lead to an audit, where we found that
> synthesize_perf_probe_command() may leak synthesize_perf_probe_point()
> return on failure, fix it.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/probe-event.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index c7bfeab610a3679a..2835d87cb97771f9 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2063,14 +2063,18 @@ char *synthesize_perf_probe_command(struct perf_probe_event *pev)
>  			goto out;
>  
>  	tmp = synthesize_perf_probe_point(&pev->point);
> -	if (!tmp || strbuf_addstr(&buf, tmp) < 0)
> +	if (!tmp || strbuf_addstr(&buf, tmp) < 0) {
> +		free(tmp);
>  		goto out;
> +	}
>  	free(tmp);
>  
>  	for (i = 0; i < pev->nargs; i++) {
>  		tmp = synthesize_perf_probe_arg(pev->args + i);
> -		if (!tmp || strbuf_addf(&buf, " %s", tmp) < 0)
> +		if (!tmp || strbuf_addf(&buf, " %s", tmp) < 0) {
> +			free(tmp);
>  			goto out;
> +		}
>  		free(tmp);
>  	}
>  
> -- 
> 2.37.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
