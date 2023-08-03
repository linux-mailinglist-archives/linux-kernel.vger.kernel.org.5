Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9515476EACF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjHCNkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjHCNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673B6EA8;
        Thu,  3 Aug 2023 06:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCAE161DA5;
        Thu,  3 Aug 2023 13:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AC7C433C8;
        Thu,  3 Aug 2023 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691069762;
        bh=kbndijpn661ViJ0yqb4XxntwoAf1jhrnvKk1x8ONpwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dD1YE5GjZJJKuUMBAHljbZgWr3k4qbXnig3jyY+0eD7S+Au6Khg+3KDv2PgKMRjco
         ORljVAhG+GDRqWfGOB2R+cUL9PqLbzz7NfAXEB6HJ/tyyTYR6JdjIHX9qWLb2emGMe
         GfaE5AoRxuTwQbOzdjfcWJhJHhxY+BKl74/8xZHOtK4MOZuvBeJ1DV73ppb5mUvM9B
         8HuEA0F0jwdIizBJ4X+EVsllomntSTzq8UNyD6yaXIZj9KUX/2bF7YFeFJncyGmWWr
         LKa5mRYYgFrx2runS8FKa5QU/OinGGxmXTjJNRmK3AWN9f5ftenA56e1uxBpiGUBQB
         uj8jKG1pnvI9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B840F4012D; Thu,  3 Aug 2023 10:35:59 -0300 (-03)
Date:   Thu, 3 Aug 2023 10:35:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] perf hists browser: Fix the number of entries for
 'e' key
Message-ID: <ZMutP7K0SewD7M9x@kernel.org>
References: <20230731094934.1616495-1-namhyung@kernel.org>
 <20230731094934.1616495-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094934.1616495-2-namhyung@kernel.org>
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

Em Mon, Jul 31, 2023 at 02:49:33AM -0700, Namhyung Kim escreveu:
> The 'e' key is to toglle expand/collapse the selected entry only.  But
> the current code has a bug that it only increases the number of entries
> by 1 in the hierarchy mode so users cannot move under the current entry
> after the key stroke.  This is due to a wrong assumption in the
> hist_entry__set_folding().
> 
> The commit b33f922651011 ("perf hists browser: Put hist_entry folding
> logic into single function") factored out the code, but actually it
> should be handled separately.  The hist_browser__set_folding() is to
> update fold state for each entry so it needs to traverse all (child)
> entries regardless of the current fold state.  So it increases the
> number of entries by 1.
> 
> But the hist_entry__set_folding() only cares the currently selected
> entry and its all children.  So it should count all unfolded child
> entries.  This code is implemented in hist_browser__toggle_fold()
> already so we can just call it.

Thanks, tested and applied.

- Arnaldo

 
> Fixes: b33f922651011 ("perf hists browser: Put hist_entry folding logic into single function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/hists.c | 58 ++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index d8b88f10a48d..70db5a717905 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -407,11 +407,6 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
>  	return container_of(ms, struct callchain_list, ms)->has_children;
>  }
>  
> -static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
> -{
> -	return browser->he_selection ? browser->he_selection->unfolded : false;
> -}
> -
>  static bool hist_browser__selection_unfolded(struct hist_browser *browser)
>  {
>  	struct hist_entry *he = browser->he_selection;
> @@ -584,8 +579,8 @@ static int hierarchy_set_folding(struct hist_browser *hb, struct hist_entry *he,
>  	return n;
>  }
>  
> -static void __hist_entry__set_folding(struct hist_entry *he,
> -				      struct hist_browser *hb, bool unfold)
> +static void hist_entry__set_folding(struct hist_entry *he,
> +				    struct hist_browser *hb, bool unfold)
>  {
>  	hist_entry__init_have_children(he);
>  	he->unfolded = unfold ? he->has_children : false;
> @@ -603,34 +598,12 @@ static void __hist_entry__set_folding(struct hist_entry *he,
>  		he->nr_rows = 0;
>  }
>  
> -static void hist_entry__set_folding(struct hist_entry *he,
> -				    struct hist_browser *browser, bool unfold)
> -{
> -	double percent;
> -
> -	percent = hist_entry__get_percent_limit(he);
> -	if (he->filtered || percent < browser->min_pcnt)
> -		return;
> -
> -	__hist_entry__set_folding(he, browser, unfold);
> -
> -	if (!he->depth || unfold)
> -		browser->nr_hierarchy_entries++;
> -	if (he->leaf)
> -		browser->nr_callchain_rows += he->nr_rows;
> -	else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
> -		browser->nr_hierarchy_entries++;
> -		he->has_no_entry = true;
> -		he->nr_rows = 1;
> -	} else
> -		he->has_no_entry = false;
> -}
> -
>  static void
>  __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
>  {
>  	struct rb_node *nd;
>  	struct hist_entry *he;
> +	double percent;
>  
>  	nd = rb_first_cached(&browser->hists->entries);
>  	while (nd) {
> @@ -640,6 +613,21 @@ __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
>  		nd = __rb_hierarchy_next(nd, HMD_FORCE_CHILD);
>  
>  		hist_entry__set_folding(he, browser, unfold);
> +
> +		percent = hist_entry__get_percent_limit(he);
> +		if (he->filtered || percent < browser->min_pcnt)
> +			continue;
> +
> +		if (!he->depth || unfold)
> +			browser->nr_hierarchy_entries++;
> +		if (he->leaf)
> +			browser->nr_callchain_rows += he->nr_rows;
> +		else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
> +			browser->nr_hierarchy_entries++;
> +			he->has_no_entry = true;
> +			he->nr_rows = 1;
> +		} else
> +			he->has_no_entry = false;
>  	}
>  }
>  
> @@ -659,8 +647,10 @@ static void hist_browser__set_folding_selected(struct hist_browser *browser, boo
>  	if (!browser->he_selection)
>  		return;
>  
> -	hist_entry__set_folding(browser->he_selection, browser, unfold);
> -	browser->b.nr_entries = hist_browser__nr_entries(browser);
> +	if (unfold == browser->he_selection->unfolded)
> +		return;
> +
> +	hist_browser__toggle_fold(browser);
>  }
>  
>  static void ui_browser__warn_lost_events(struct ui_browser *browser)
> @@ -732,8 +722,8 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
>  		hist_browser__set_folding(browser, true);
>  		break;
>  	case 'e':
> -		/* Expand the selected entry. */
> -		hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
> +		/* Toggle expand/collapse the selected entry. */
> +		hist_browser__toggle_fold(browser);
>  		break;
>  	case 'H':
>  		browser->show_headers = !browser->show_headers;
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 

-- 

- Arnaldo
