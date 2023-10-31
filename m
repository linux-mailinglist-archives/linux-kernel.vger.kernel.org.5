Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9117DD0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjJaPiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbjJaPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:38:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067CFE4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:38:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E57EC433C8;
        Tue, 31 Oct 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698766687;
        bh=dCDFZB8B9f/JdOi0RnunoHzfl2Qan9ZHBj6X6d5O/tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOlrkHuYeLzDP2Ti7+Rlu20HSW+VmJOqDcOhnPGbHa3IS4eOB4e685EQ7AuyVkZce
         H1LBRydTvIxod/40hlbde8B5ZyGf8fA3/GXv146Iq02/lYBzxJangSUpswnz3u0+Bb
         DFAAlgnTLgaSTbzaxmThNivQQYm6pvbEsxf4teuUPl5QVdAWcWP2NbPqdg1xTz1KDh
         DMJxTPbcAAY3JAZfCK1vh9FtP955Irx/OaGYRdtn/DGfAwC8Tr6svlxSYA5uLBzNaw
         vCd/Ua6yHSXh0UskOn3VPrX6VdEamZ3LeoNf9ZZ7mSu2/iU3SUN1f5znhAx8yQOHdU
         GzA9mfomNbO2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B99C4035D; Tue, 31 Oct 2023 12:38:05 -0300 (-03)
Date:   Tue, 31 Oct 2023 12:38:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/2] perf lock info: Enforce exactly one of --map and
 --thread
Message-ID: <ZUEfXU34ZijKe8aA@kernel.org>
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-3-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031120526.11502-3-nick.forrington@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 31, 2023 at 12:05:25PM +0000, Nick Forrington escreveu:
> Improve error reporting for command line arguments.
> 
> Display error/usage if neither --map or --thread are specified (rather
> than a non user-friendly error "Unknown type of information").
> 
> Display error/usage if both --map and --thread are specified (rather
> than ignoring "--map" and displaying only thread information).

Shouldn't one of them be the default so that we type less for the most
common usage?

- Arnaldo
 
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>  tools/perf/builtin-lock.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 3aa8ba5ad928..cf29f648d291 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2021,6 +2021,27 @@ static int check_lock_report_options(const struct option *options,
>  	return 0;
>  }
>  
> +static int check_lock_info_options(const struct option *options,
> +				   const char * const *usage)
> +{
> +	if (!info_map && !info_threads) {
> +		pr_err("Requires one of --map or --threads\n");
> +		parse_options_usage(usage, options, "map", 0);
> +		parse_options_usage(NULL, options, "threads", 0);
> +		return -1;
> +
> +	}
> +
> +	if (info_map && info_threads) {
> +		pr_err("Cannot show map and threads together\n");
> +		parse_options_usage(usage, options, "map", 0);
> +		parse_options_usage(NULL, options, "threads", 0);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int check_lock_contention_options(const struct option *options,
>  					 const char * const *usage)
>  
> @@ -2709,6 +2730,10 @@ int cmd_lock(int argc, const char **argv)
>  			if (argc)
>  				usage_with_options(info_usage, info_options);
>  		}
> +
> +		if (check_lock_info_options(info_options, info_usage) < 0)
> +			return -1;
> +
>  		/* recycling report_lock_ops */
>  		trace_handler = &report_lock_ops;
>  		rc = __cmd_report(true);
> -- 
> 2.42.0
> 
> 

-- 

- Arnaldo
