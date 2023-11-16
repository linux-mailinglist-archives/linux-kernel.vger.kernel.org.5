Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFE7EDF05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbjKPK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345048AbjKPK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:58:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBDCA5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:58:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF16AC433C7;
        Thu, 16 Nov 2023 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700132299;
        bh=M+8iKSmznVXEZTfGoN0FrGmEHGx1v9DKi1Ga7R7HHOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mB07d3Q7ViI4kjC0hpgE+fXB4OTqUzVdXsyIGTCCGOegiB21GcqULmwnQJ1EeDIBC
         Mws+buiwIwtecIwYobCeUxKnssn6vQ5jJFacZIp1SVpRNfjzqGSu56oolFFAymOxd7
         6k968IkW5nsJSH6lOdfjDPxhRJWlz3P4MipPYJcE0iZF8Gsc20G6DVyEi5VqvyjBT9
         n2YHEvJrEgTG1+SBeoKqlZzOp5tA6hca84d8wpMUjP+a2jAXZdtpXeALDYH+rPKhtf
         QLbNWffvtXyAaQNjl2UeRg9pBIFsPHhoOtKRDMiobAYX2it/qfuly2r8IQe9v+s6Eb
         oAMaUKeWCv70w==
From:   SeongJae Park <sj@kernel.org>
To:     FANG2508 <1031576200@qq.com>
Cc:     linux-mm@kvack.org, sj@kernel.org, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/ops-common.c: Fixup missing parentheses
Date:   Thu, 16 Nov 2023 10:58:17 +0000
Message-Id: <20231116105817.51824-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_3EF8231A65618FEEC716F90828433D6E9C09@qq.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello FANG2508,

On Thu, 16 Nov 2023 18:21:47 +0800 FANG2508 <1031576200@qq.com> wrote:

> In function 'damon_hot_score', the variable 'hotness' should be divided by the sum of 'freq_weight' and 'age_weight' instead of /'freq_weight'+'age_weight'.
> 
> Signed-off-by: FANG2508 <1031576200@qq.com>
> ---
>  mm/damon/ops-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d25d99cb5f2b..fc7886c63bf1 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -102,7 +102,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  
>  	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
>  	if (freq_weight + age_weight)
> -		hotness /= freq_weight + age_weight;
> +		hotness /= (freq_weight + age_weight);

Thank you for this patch.  However, I think the old code is ok, since the
precedence of the /= operation is right to left[1]?  I also checked that's true
by confirming below simple kunit passes.

    int abc = 3;

    abc /= 1 + 2;
    KUNIT_EXPECT_EQ(test, abc, 1);

Please let me know if I'm
missing something.


[1] https://en.cppreference.com/w/c/language/operator_precedence


Thanks,
SJ

>  	/*
>  	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
>  	 */
> -- 
> 2.39.2
