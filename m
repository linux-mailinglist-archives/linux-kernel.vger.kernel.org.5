Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4514D772D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHGSOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHGSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC7171E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C8E620BB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26371C433C8;
        Mon,  7 Aug 2023 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691432051;
        bh=j3TEHYhp6hr1p4VgaxfK1CNIdkHjvCIlVn8A8sCNygc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsA6daF5bcPewpGwMVJ+pZDL+hUHfxed8UM7SgW9lSMBVmJMILfjHj857J4tPXy8x
         L4vKHLfXxOKg5h0JwzqHZ8QdchW6QIzU0cGyYRySEm2QZpm3Kp247gT00UgSix9oN8
         IBXzRbKFE+BGwGUBAHkJzaKLrNtDTPxEAHTCRzqMnPTHRdrH5rtpwF1fi9brT7fXaB
         FglMjHij54cZrpqJby/uVeabtdz7QFW5cd40rAJpHGviLKuZW7IbtVGUtFC+Scwlnu
         SG2lcOPiuZq6asjUXjEi/HwJ7m97pu74HH9QQH0/EtKfVdHuBCeE8zen9W6u0yKtcJ
         MzkremrskSpBQ==
From:   SeongJae Park <sj@kernel.org>
To:     Hyeongtak Ji <hyeongtak.ji@gmail.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: Re: [PATCH] mm/damon: Prevent unnecessary age reset for regions
Date:   Mon,  7 Aug 2023 18:14:09 +0000
Message-Id: <20230807181409.97310-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1691401475-3796-1-git-send-email-hyeongtak.ji@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeongtak,


Thank you for this patch!

On Mon, 7 Aug 2023 18:44:35 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:

> DAMON resets the age of each region after applying each scheme,
> regardless of whether the scheme has been successfully applied.
> 
> This patch adds a simple condition to prevent the age of regions from
> being reset when schemes have not been actually applied.

We consider applying the action as making a change to the region, and hence
reset the age to zero.  Even if the action was not completely applied,
that might be enough to make some change to the region.  The behavior is also
to limit a scheme too repeatedly and frequently applied to a region.

So, this is not a bug but an intended behavior, and I think this change might
not what really necessary.

Is there a specific use case that this change is needed?  If so, I think we can
think about extending the interface to support the case.


Thanks,
SJ

> 
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 91cff7f2997e..4044fcf18ac1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -908,7 +908,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  			quota->charge_addr_from = r->ar.end + 1;
>  		}
>  	}
> -	if (s->action != DAMOS_STAT)
> +	if (s->action != DAMOS_STAT && sz_applied > 0)
>  		r->age = 0;
>  
>  update_stat:
> -- 
> 2.7.4
> 
