Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6E7DEE73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbjKBIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjKBIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0318B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:54:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56789C433C8;
        Thu,  2 Nov 2023 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698915268;
        bh=A7FoYJUUU5fM6KDQZG7+WD2UG90QXjzmTG48GuucSeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odffH41401if0nynpcNzmku2bPes9u+NXTnn3/94mJEdsp9QMJqQPk9qH5NKaxWsn
         /lSKcAaj1SO+piCDEqR/x3kPUJxK3KtKZYEC+bLhliNZVI62+ztUkNvVn0oaqc8npe
         NXexRyK5JnpWtGKEeUTTLuFD0Ih9tcrdTqPQkEDzNTmoKIXtHxESH/x882yPlE4twJ
         5WjXMPZEdoAhJdKOdrmTEcgJCM8qDsf0snG+AQK0vAd86swQdWsh6SIIK8ZJ+7x3dM
         43qflqT2U0FzRfEnoujJm1q9wO6HOGspX1uhiSLe8X6COkqrWaSxMawbfxtOcQfBTd
         aUGcv/nwmWSyA==
Date:   Thu, 2 Nov 2023 10:54:18 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     huanglllzu@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Liangliang Huang <huangll@lemote.com>
Subject: Re: [PATCH] mm/memblock.c: using judgment statement can reduce loop
 and enhance readability.
Message-ID: <20231102085418.GM2824@kernel.org>
References: <20231102023710.13023-1-huanglllzu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102023710.13023-1-huanglllzu@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Subject: [PATCH] mm/memblock.c: using judgment statement can reduce loop and enhance readability.

I disagree.

On Thu, Nov 02, 2023 at 10:37:10AM +0800, huanglllzu@gmail.com wrote:
> From: Liangliang Huang <huangll@lemote.com>
> 
> Signed-off-by: Liangliang Huang <huangll@lemote.com>
> ---
>  mm/memblock.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 913b2520a9a0..e48dea7144bb 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -655,7 +655,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  			}
>  		}
>  		/* area below @rend is dealt with, forget about it */
> -		base = min(rend, end);
> +		if (end < rend) {
> +			base = end;
> +			break;
> +		} else
> +			base = rend;

min() is perfectly clear and there no change in number of iterations of the
loop.

>  	}
>  
>  	/* insert the remaining portion */
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
