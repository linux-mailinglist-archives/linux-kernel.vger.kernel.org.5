Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6E76EACD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjHCNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjHCNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:39:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5836A7B;
        Thu,  3 Aug 2023 06:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CED661DAA;
        Thu,  3 Aug 2023 13:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E51CC433C9;
        Thu,  3 Aug 2023 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691069749;
        bh=C6Dxd0begEUdvL1T6Bif2dBYOfzhi5vekBRuMYfVre4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pul/QB31o3Ie8xAbAKUG7UdNEx34i0Ogvvph+xNmabZFUcFA3pAbJOFNymzVCUFpp
         c4CzlkTumOY5GnkmcihnEfxEyVSRNofxq2Koh2uqvKC2m6FnpkIZSNzsUUGMlt3ncF
         UdqyzpxnEExpCA1hr9T9FIInpxp+D1mYvrEp2ztdGjh4xFBfccSKbVBbjNT22TEjMj
         /GMG3ClS9egsJbevxamV1UYabeX7ElIdC9MAX4M+1EQE8+Qr5QDAKlwU1Pl134VYRJ
         RQU5UfU9KmscICcCmg9s5JU4Cn5HFfRh4X+0AIQGT09xCMGI7svKfnqb60jtwu3qU6
         TFiR/iti1CA3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF3FF4012D; Thu,  3 Aug 2023 10:35:46 -0300 (-03)
Date:   Thu, 3 Aug 2023 10:35:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf hists browser: Fix hierarchy mode header
Message-ID: <ZMutMm8C3LFU7K01@kernel.org>
References: <20230731094934.1616495-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094934.1616495-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 31, 2023 at 02:49:32AM -0700, Namhyung Kim escreveu:
> The commit ef9ff6017e3c4 ("perf ui browser: Move the extra title lines
> from the hists browser") introduced ui_browser__gotorc_title() to help
> moving non-title lines easily.  But it missed to update the title for
> the hierarchy mode so it won't print the header line on TUI at all.
> 
>   $ perf report --hierarchy

Thanks, tested and applied.

- Arnaldo

 
> Fixes: ef9ff6017e3c4 ("perf ui browser: Move the extra title lines from the hists browser")
> Cc: stable@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/hists.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index c7ad9e003080..d8b88f10a48d 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -1779,7 +1779,7 @@ static void hists_browser__hierarchy_headers(struct hist_browser *browser)
>  	hists_browser__scnprintf_hierarchy_headers(browser, headers,
>  						   sizeof(headers));
>  
> -	ui_browser__gotorc(&browser->b, 0, 0);
> +	ui_browser__gotorc_title(&browser->b, 0, 0);
>  	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
>  	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
>  }
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 

-- 

- Arnaldo
