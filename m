Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2A7EDD24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjKPIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:52:35 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CC182;
        Thu, 16 Nov 2023 00:52:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VwVkHLC_1700124749;
Received: from 30.221.146.6(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VwVkHLC_1700124749)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 16:52:29 +0800
Message-ID: <345e0d5c-b01b-361d-fbb1-a0c6b093431e@linux.alibaba.com>
Date:   Thu, 16 Nov 2023 16:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in
 fuse_dax_conn_free()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231116075726.28634-1-hbh25y@gmail.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20231116075726.28634-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/23 3:57 PM, Hangyu Hua wrote:
> fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
> after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
> virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
> superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
> resulting in a possible double free.
> 
> Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/fuse/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 23904a6a9a96..12ef91d170bb 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
>  	if (fc->dax) {
>  		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
>  		kfree(fc->dax);
> +		fc->dax = NULL;
>  	}
>  }
>  

-- 
Thanks,
Jingbo
