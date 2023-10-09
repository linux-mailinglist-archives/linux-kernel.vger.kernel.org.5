Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F27BED85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377177AbjJIVpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjJIVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:45:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CAD9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:45:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73A2C433C8;
        Mon,  9 Oct 2023 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696887936;
        bh=1ndakU5ZrJNV6n/t729+HGi50h9X41d0pjJ8GuYWV7A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eAoIc2gU/zMHHHJw+1Cd/NcYRsM/noqrYMfeG/x7l54J43MQTDh4ewB0ykeNh2GDD
         L82gHRh0PzE3QqqCQox0srHMk7X4kj5w7+nhrva8wFgnjSIg+vsX3FWAm1QX91W7X3
         yB5BZnVBN7x1WX3JdQH3fdV32isSeHR7LzaCkiqGDGhzkWlB4Oq0zdzb2d0DSPQJLD
         VJKsRoM+J2d9CsmevmZburewXWpZ0CjAeulY/5Z+NkdXaYQ6xHzXOprocL7ad8J3sQ
         J+bSO5uxsSwSrjn8VQUnx2Iq/4mfJLHdbwp3ZdHXBNdGJL+fcOzm/RYlWn/CBpvnle
         RRw038BUlJn0A==
Message-ID: <d11a47c9-c422-47d8-9049-2743314a9924@kernel.org>
Date:   Tue, 10 Oct 2023 00:45:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: Fix __rcu type comparison warning
Content-Language: en-US
To:     Mike Tipton <quic_mdtipton@quicinc.com>, gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20230922134512.5126-1-quic_mdtipton@quicinc.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230922134512.5126-1-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.23 16:45, Mike Tipton wrote:
> Sparse reports the following:
> 
> fs/debugfs/file.c:942:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> fs/debugfs/file.c:942:9: sparse:    char [noderef] __rcu *
> fs/debugfs/file.c:942:9: sparse:    char *
> 
> rcu_assign_pointer() expects that it's assigning to pointers annotated
> with __rcu. We can't annotate the generic struct file::private_data, so
> cast it instead.
> 
> Fixes: 86b5488121db ("debugfs: Add write support to debugfs_create_str()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309091933.BRWlSnCq-lkp@intel.com/
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>

Reviewed-by: Georgi Djakov <djakov@kernel.org>

> ---
>   fs/debugfs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 87b3753aa4b1..c45e8c2d62e1 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -939,7 +939,7 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
>   	new[pos + count] = '\0';
>   	strim(new);
>   
> -	rcu_assign_pointer(*(char **)file->private_data, new);
> +	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
>   	synchronize_rcu();
>   	kfree(old);
>   

