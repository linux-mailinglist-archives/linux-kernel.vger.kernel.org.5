Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC07E4370
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjKGPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjKGP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:29:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF169E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:29:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648F4C433C8;
        Tue,  7 Nov 2023 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699370996;
        bh=cmxamXDMEWUMn8cEgNqWaQdc+pX1ObexCCh/OMwnfHI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=b4FN91eqriAaFztaTy2f+42mALgF03S0uKEpBnmgUhocuaniZd6h7Y8UPj3uEMr0q
         0OPCW/creEavn5kKuhQSbll4vxj25ID2Docy0fwdZsJsHQFUFFhUsgH6ug7XRdqt3h
         YNi9CPucW3PUjALzU/Zv328qAy32nRVtX0KbQu13wCTY1CcukMGx0x9W7L9YWcc2hr
         FGu1cFpqh20d2escaYfKmj2KDmj4aVQ2Fu+FQGpgWffFQopIsTnTYeJySCIpXibp3q
         Hfosa/XQ5yjnau/o+Aw82wsAVV+YcsnI/6R1UUxNmFYWGb6UIH8JkF7z/VfE/fRwkK
         ULfd7rEmE7s0Q==
Message-ID: <e2167506-2b0a-a0f5-c0e9-0e8b6139c69e@kernel.org>
Date:   Tue, 7 Nov 2023 23:29:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <20231025202019.5228-1-s.shtylyov@omp.ru>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: data: fix possible overflow in
 check_swap_activate()
In-Reply-To: <20231025202019.5228-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thanks for the patch.

On 2023/10/26 4:20, Sergey Shtylyov wrote:
> In check_swap_activate(), if the *while* loop exits early (0- or 1-page
> long swap file), an overflow happens while calculating the value of the
> span parameter as the lowest_pblock variable ends up being greater than
> the highest_pblock variable. Let's set *span to 0 in this case...

What do you think of returning -EINVAL for such case? I assume this is a
corner case.

> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> This patch is against the 'master' branch of Jaegeuk Kim's F2FS repo...
> 
>   fs/f2fs/data.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 916e317ac925..342cb0d5056d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4047,7 +4047,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
>   		cur_lblock += nr_pblocks;
>   	}
>   	ret = nr_extents;
> -	*span = 1 + highest_pblock - lowest_pblock;
> +	if (lowest_pblock <= highest_pblock)

if (unlikely(higest_pblock < lowest_pblock))
	return -EINVAL;

*span = 1 + highest_pblock - lowest_pblock;

Thanks,

> +		*span = 1 + highest_pblock - lowest_pblock;
> +	else
> +		*span = 0;
>   	if (cur_lblock == 0)
>   		cur_lblock = 1;	/* force Empty message */
>   	sis->max = cur_lblock;
