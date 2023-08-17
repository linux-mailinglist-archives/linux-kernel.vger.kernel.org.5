Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9A77F19F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348686AbjHQH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348664AbjHQH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:58:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC81AE;
        Thu, 17 Aug 2023 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692259104; x=1723795104;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZtNC0dQl0IK7DsZFeYyjmaf30kbws2e2ns5LGtsrbho=;
  b=dpLFp+bjrscsaO1ku61TQyEi4/1Ri1E/bqYZSmVt4mpyz6xa0RdypHoI
   XpuleVEPvwgt8Joz7YKegdH0vOMbxe/Zsn8vx2Qyt7Yb+SvA1Zldo8pH2
   lo5aY4U84JYDYOmqJcZkAorsv/1oMdNTubP9m5a+VZbrqplGfZTYHY0MQ
   4ZB6Duyy1GZ/Y+IK6DOZPbitmiWelY9Oxc4dN0baGo4pcOkIbIK2/lekH
   M3hZo1pSGfQj2SctoffrOsbTLqVDTvYU7Nzjq6hKqG/ySjPxdDym4levM
   mmTg6lfYVlQYm6tb1/1Q852It+4cKCmcQZJPZjRatKmiBh9R1YJJdeP8Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375509434"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375509434"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908312458"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="908312458"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.138.165])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:58:19 -0700
Date:   Thu, 17 Aug 2023 09:58:14 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 2/7] md: factor out a helper to choose sync
 direction from md_check_recovery()
Message-ID: <20230817095814.00005530@linux.intel.com>
In-Reply-To: <20230815030957.509535-3-yukuai1@huaweicloud.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
        <20230815030957.509535-3-yukuai1@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 11:09:52 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are no functional changes, on the one hand make the code cleaner,
> on the other hand prevent following checkpatch error in the next patch to
> delay choosing sync direction to md_start_sync().
> 
> ERROR: do not use assignment in if condition
> +       } else if ((spares = remove_and_add_spares(mddev, NULL))) {
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 68 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 90815be1e80f..4846ff6d25b0 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9246,6 +9246,48 @@ static int remove_and_add_spares(struct mddev *mddev,
>  	return spares;
>  }
>  
> +static bool md_choose_sync_direction(struct mddev *mddev, int *spares)

The naming is little confusing because as a direction I would expect forward or
backward - from end to start or or from start to end. In this case you are
determining the type of the background operation needed. Assuming that reshape
is a kind of "sync" operation I would say "md_choose_sync_action".

Anyway, it looks good to me.

Thanks,
Mariusz
