Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD57AED25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjIZMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjIZMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9309F;
        Tue, 26 Sep 2023 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695732345; x=1727268345;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32xstV7h7uDBPR+FMiuzfPpGPKpEK/U4tWONTBVDoZs=;
  b=NqHrP2ikUmycnSTLDNrN4fL8KYoDddQB1WZuo/ATMIAR0GLuAZUmJqWL
   MJO5kzHk6VBqwE8QZ7K+DMjgRXPrQ2zGMAOlnuU7YJXUPFCGXvSGw6Yt5
   lvCP+C6rUzdQphXTgt7N85xkNVrFgAD6CJ/g8EFqHOpCqNK2m9jaCZIiV
   dnRLKtEzqq0yFoxIZeZ+jBPWclJcsdq/3Zcj4CDSPNwZAuOI3JC8F8uui
   OFTKtZ+fhSruQtJGY7T6jdQmTPmGo0ompk7+1tmYQDE+KtVcO40N6yb9Q
   MXacNeiLJcQg8auuufgdm1DvghD9fyhQLmc5Bxt9OEMtg1XT52k7E3BFj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467839457"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467839457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 05:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698454904"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698454904"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.130.254])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 05:45:41 -0700
Date:   Tue, 26 Sep 2023 14:45:36 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/2] md: factor out a new helper to put mddev
Message-ID: <20230926144536.0000017d@linux.intel.com>
In-Reply-To: <20230926025827.671407-2-yukuai1@huaweicloud.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
        <20230926025827.671407-2-yukuai1@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 10:58:26 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are no functional changes, the new helper will still hold
> 'all_mddevs_lock' after putting mddev, and it will be used to simplify
> md_seq_ops.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 10cb4dfbf4ae..a5ef6f7da8ec 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -616,10 +616,15 @@ static inline struct mddev *mddev_get(struct mddev
> *mddev) 
>  static void mddev_delayed_delete(struct work_struct *ws);
>  
> -void mddev_put(struct mddev *mddev)
> +static void __mddev_put(struct mddev *mddev, bool locked)
>  {
> -	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
> +	if (locked) {
> +		spin_lock(&all_mddevs_lock);
> +		if (!atomic_dec_and_test(&mddev->active))
> +			return;

It is "locked" and we are taking lock? It seems weird to me. Perhaps "do_lock"
would be better? Do you meant "lockdep_assert_held(&all_mddevs_lock);"

Something is wrong here, we have two paths and in both cases we are
taking lock.

> +	} else if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
>  		return;
> +
>  	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
>  	    mddev->ctime == 0 && !mddev->hold_active) {
>  		/* Array is not configured at all, and not held active,
> @@ -633,7 +638,14 @@ void mddev_put(struct mddev *mddev)
>  		 */
>  		queue_work(md_misc_wq, &mddev->del_work);
>  	}
> -	spin_unlock(&all_mddevs_lock);
> +
> +	if (!locked)
> +		spin_unlock(&all_mddevs_lock);
As above, I'm not sure if it is correct.

Thanks,
Mariusz
