Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA67CED90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjJSBWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSBWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:22:23 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5C114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:22:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuS1j91_1697678536;
Received: from 30.221.128.175(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VuS1j91_1697678536)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 09:22:18 +0800
Message-ID: <7a8b2331-a252-58ef-6553-ceb73a9a63c9@linux.alibaba.com>
Date:   Thu, 19 Oct 2023 09:22:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ocfs2: replace BUG_ON() at ocfs2_num_free_extents() with
 ocfs2_error()
Content-Language: en-US
To:     Jia Rui <jindui71@gmail.com>, mark@fasheh.com,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231018191811.412458-1-jindui71@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20231018191811.412458-1-jindui71@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 3:18 AM, Jia Rui wrote:
> The BUG_ON() at ocfs2_num_free_extents() handles the error that
> l_tree_deepth of leaf extent block just read form disk is invalid.
> This error is mostly caused by file system metadata corruption on
> the disk. There is no need to call BUG_ON() to handle such errors.
> We can return error code, since the caller can deal with errors
> from ocfs2_num_free_extents(). Also, we should make the file
> system read-only to avoid the damage from expanding.
> 
> Therefore, BUG_ON() is removed and ocfs2_error() is called instead.
> 
> Signed-off-by: Jia Rui <jindui71@gmail.com>

Looks reasonable.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/alloc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index aef58f1395c8..d6bcf00f6843 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -967,7 +967,14 @@ int ocfs2_num_free_extents(struct ocfs2_extent_tree *et)
>  		el = &eb->h_list;
>  	}
>  
> -	BUG_ON(el->l_tree_depth != 0);
> +	if (el->l_tree_depth != 0) {
> +		retval = ocfs2_error(ocfs2_metadata_cache_get_super(et->et_ci),
> +				"Owner %llu has leaf extent block %llu with an invalid l_tree_depth of %u\n",
> +				(unsigned long long)ocfs2_metadata_cache_owner(et->et_ci),
> +				(unsigned long long)last_eb_blk,
> +				le16_to_cpu(el->l_tree_depth));
> +		goto bail;
> +	}
>  
>  	retval = le16_to_cpu(el->l_count) - le16_to_cpu(el->l_next_free_rec);
>  bail:
