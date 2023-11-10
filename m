Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E47E8306
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbjKJToP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbjKJTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:43:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F620B430
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:22:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E36C433B6;
        Fri, 10 Nov 2023 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699640562;
        bh=dyMQhGcWZjzZfmcqgh0a8rICldiyzNXwXP7ITv8rhaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3srt1Ly1o/qDEDNL+eya2zX0xuLm8X12MVvD1EN4K4oxmdjy5mhnx8YSwG3oIFpi
         pZDyU3qfdYjHiAScVczzHVaZZ6IVVfy7S8Rk+op1NBBQnHRI8p+/viB0b843KLfBKw
         Tx5S6JgndAXZDVhwScwTbSIEzNFjB1ZIsvvkev8+xPHtLhvhbsJKP3BN/VAASMPI5C
         lut0Se9SiKS5Pne8TGkJAZ990C1Bd9/6WnjNpIQYs0XBmJgMmITUQfsz8MolLtisVe
         bu10oMknarSV0RZqDv09k3t8rPfbrYq4dhhyXoleO4yq8Hiv4hDUD5VDpeACozdtwJ
         EewGbBBiqEjsg==
From:   SeongJae Park <sj@kernel.org>
To:     Hyeongtak Ji <hyeongtak.ji@gmail.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
Date:   Fri, 10 Nov 2023 18:22:40 +0000
Message-Id: <20231110182240.65426-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hyueongtak,

On Fri, 10 Nov 2023 14:37:09 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:

> The function '__damos_filter_out()' causes DAMON to always filter out
> schemes whose filter type is anon or memcg if its matching value is set
> to false.
> 
> This commit addresses the issue by ensuring that '__damos_filter_out()'
> no longer applies to filters whose type is 'anon' or 'memcg'.

Nice catch, thank you!

checkpatch.pl shows one warning, though:

    WARNING: From:/Signed-off-by: email address mismatch: 'From: Hyeongtak Ji <hyeongtak.ji@gmail.com>' != 'Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>'

> 
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bcd2bd9d6c10..d5ef8945a343 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -920,7 +920,7 @@ static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
>  		matched = true;
>  		break;
>  	default:
> -		break;
> +		return false;


>  	}
>  
>  	return matched == filter->matching;
> -- 
> 2.7.4
> 
> 
