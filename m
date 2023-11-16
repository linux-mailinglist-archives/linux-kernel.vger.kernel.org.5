Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD8F7EDB73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjKPGM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPGMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:12:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB686199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:12:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABACC433C7;
        Thu, 16 Nov 2023 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700115172;
        bh=iy5Fs/OoTBft6okzKEHs4fWRTYP2PNevTk5pW3gTixU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N+usEBGNPd2bk9KP44cNiNV+2/hhvIGR0r4eabOjhvJVfTZ6aQQG3QNCMTXJYj9tV
         UnU2WdlJVpkiSLIt/FmK51ksMNZtxygpMRRi6PCoaNjIQ5if7KNKxGzXKSLzjUKiKG
         gnZg9dQDa1/uEl+8XzPm/4Y+c+LMkuX/043n4s5SbIDJfJNb8R7oUBDnEJbPUyLs7N
         2o3ZM+a+0ZY39vIHhPef4LLTqTP0UriN6TtiaDsMIV9mtQOqRwD2Xornmezz8fOd1a
         tHBY09sEcvo9/QgZagWT2g32TucDP8u2G4FZ0ju8tTbUpQQRSdYbZ4fdnLTn5WW85/
         dhTvrpazq3q3w==
Message-ID: <c37b72d8-f607-bbce-f5ba-58f554e07b85@kernel.org>
Date:   Thu, 16 Nov 2023 14:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/14 15:07, Jingbo Xu wrote:
> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:erofs_map_dev+0xbd/0x1c0
>   Call Trace:
>    <TASK>
>    erofs_fscache_data_read_slice+0xa7/0x340
>    erofs_fscache_data_read+0x11/0x30
>    erofs_fscache_readahead+0xd9/0x100
>    read_pages+0x47/0x1f0
>    page_cache_ra_order+0x1e5/0x270
>    filemap_get_pages+0xf2/0x5f0
>    filemap_read+0xb8/0x2e0
>    vfs_read+0x18d/0x2b0
>    ksys_read+0x53/0xd0
>    do_syscall_64+0x42/0xf0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
