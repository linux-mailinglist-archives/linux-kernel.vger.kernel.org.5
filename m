Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A97E5F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKHUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:25:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173E213B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:25:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46376C433C8;
        Wed,  8 Nov 2023 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699475103;
        bh=uDClDpeG63HKg8UTkQh+J6zOVgqjK4bLCSdFNcx3a9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDfh2+VYcowoBa+e62qqNH+/WHuJTRJKkxX8yy051twrXZRJanamOK65DHLtMJ28u
         BaIlmUtHMUhKUPXlcihwfUNdZzw8JEpDSK6t0Zv5f0U38as43hKI1IUs40PwKe0sLG
         wYx4vZ6d8PvORzPX22EK2/AH47QBCz2lg9m70gYjJWkdBEtA/Z2QNUTcMAjxSMvd82
         u/s/gg9YignKKW2FKtVlR6PbEYi9Djrkn1FNBNS1Rt5dE7L61+TeKonjGAQQq0y/y7
         SNyBZtsRApT3RuEwO4SSCMWOOVyuLpEKv+bDB1NWQmUeFOnhCbHm4z5XnFtdNQoi9M
         y9FjaQ8mWYmDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B75374035D; Wed,  8 Nov 2023 17:25:00 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:25:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/5] perf annotate: Split struct annotated_branch
Message-ID: <ZUvunNH93dvqAOOx@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
 <20231103191907.54531-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103191907.54531-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 03, 2023 at 12:19:04PM -0700, Namhyung Kim escreveu:
> The cycles info is only meaningful when sample has branch stacks.  To
> save the memory for normal cases, move those fields to annotated_branch
> and dynamically allocate it when needed.  Also move cycles_hist from
> annotated_source as it's related here.

<SNIP>

> +static void annotated_branch__delete(struct annotated_branch *branch)
> +{
> +	if (branch) {
> +		free(branch->cycles_hist);

I changed the above free to zfree

> +		free(branch);
> +	}
> +}
