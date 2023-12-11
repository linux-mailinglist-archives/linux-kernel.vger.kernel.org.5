Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9080C54F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjLKJ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:56:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4EB7;
        Mon, 11 Dec 2023 01:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702288588; x=1733824588;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgmW+M6hS+f0kHxkbdAPbuME2AfhGlY3DYl+PlZLxeY=;
  b=n1nMQ4F7jXAZ0IsdFJAjLlhoq89+wzL1Hbc6uytN1riibRa+kod+aXwE
   R8oqhxziDejAxTcqxr2X6frwJW0FJ7c/va6fIVUyBMeRcFI75d9sU9B4G
   2c8np0OzaQqVm397TesyVbBfepJnT8uoViLc5G9xwLvvA3Op5KX1VWg8F
   N2JausqY0UD2+UibgoGIUrgkAcMWWiPClzsJazmQwQLo2QOkHyhIrpDBb
   sD5qfeiv8/TuSgMDCxP7OVLiptNIAzYca0Ahv543Bnna1NZdyIp9agGgl
   /5D7FjSA1L9v8DvExhWD011R3Q5DahpYb8BZKgNumZ3tOYrVPLBjbjWFf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1434318"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1434318"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 01:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="843449203"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="843449203"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.237.142.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 01:56:25 -0800
Date:   Mon, 11 Dec 2023 10:56:20 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     linan666@huaweicloud.com
Cc:     song@kernel.org, zlliu@suse.com, neilb@suse.com, shli@fb.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] md: Don't clear MD_CLOSING when the raid is about to
 stop
Message-ID: <20231211105620.00001753@linux.intel.com>
In-Reply-To: <20231211081714.1923567-1-linan666@huaweicloud.com>
References: <20231211081714.1923567-1-linan666@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 16:17:14 +0800
linan666@huaweicloud.com wrote:

> From: Li Nan <linan122@huawei.com>
> 
> The raid should not be opened anymore when it is about to be stopped.
> However, other processes can open it again if the flag MD_CLOSING is
> cleared before exiting. From now on, this flag will not be cleared when
> the raid will be stopped.
> 
> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called
> md_set_readonly or do_md_stop") Signed-off-by: Li Nan <linan122@huawei.com>

Hello Li Nan,
I was there when I needed to fix this:
https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=md-next&id=c8870379a21fbd9ad14ca36204ccfbe9d25def43

For sure, you have to consider applying same solution for array_store "clear".
Minor nit below.

Thanks,
Mariusz

> ---
>  drivers/md/md.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4e9fe5cbeedc..ebdfc9068a60 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6238,7 +6238,6 @@ static void md_clean(struct mddev *mddev)
>  	mddev->persistent = 0;
>  	mddev->level = LEVEL_NONE;
>  	mddev->clevel[0] = 0;
> -	mddev->flags = 0;

I recommend (safety recommendation):
	mddev->flags = MD_CLOSING;

Unless you can prove that other flags cannot race.

>  	mddev->sb_flags = 0;
>  	mddev->ro = MD_RDWR;
>  	mddev->metadata_type[0] = 0;

