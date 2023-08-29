Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71678C03B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjH2I1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjH2I1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:27:14 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A4E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:27:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vqqcbs2_1693297626;
Received: from 30.221.128.242(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vqqcbs2_1693297626)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 16:27:07 +0800
Message-ID: <48e57434-abf9-5e1f-c24e-46a0eb7ddc16@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 16:27:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] ocfs2: correct range->len in ocfs2_trim_fs()
Content-Language: en-US
To:     Yuanheng Zhang <yuanhengzhang1214@gmail.com>, mark@fasheh.com,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230828051741.204577-1-yuanhengzhang1214@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230828051741.204577-1-yuanhengzhang1214@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 1:17 PM, Yuanheng Zhang wrote:
> global bitmap is a cluster allocator,so after we traverse
> the global bitmap and finished the fstrim,the trimmed range
> should be 'trimmed * clustersize'.otherwise,the trimmed range
> printed by 'fstrim -v' is not as expected.
> 
> Signed-off-by: Yuanheng Zhang <yuanhengzhang1214@gmail.com>

Thanks for pointing this out. It looks fine to me.

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 51c93929a146..bced551240cf 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -7642,7 +7642,7 @@ int ocfs2_trim_mainbm(struct super_block *sb, struct fstrim_range *range)
>  		goto next_group;
>  	}
>  out:
> -	range->len = trimmed * sb->s_blocksize;
> +	range->len = trimmed * osb->s_clustersize;
>  	return ret;
>  }
>  
