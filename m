Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B17AEDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjIZNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:19:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE387B4;
        Tue, 26 Sep 2023 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695734381; x=1727270381;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lf62UQGmTCqlco4CJCiAyyIvEOjAt59aFgXbx9/WEtk=;
  b=S4T27s4ZwYYQtYf1HcyC2qJ20yVaFBGsZWnCqwaVdZX5hVCL2L0T3aXx
   z0kM4mmROjli8RT9dU6fkPj0mh2gntlLgzrP/ce01EEwJ27QjcZ8aJNQs
   euvXM8TzHkvNUXZv65RiizGt2nAZ6AOMl7ZCwfBcasjB+41uPkZnrbkMX
   wjk2HrNu1BEE2xL+H4/6cEZSK2ikNTXbU38qVhsxZpGuYeUmXBZRr2AaI
   BrVPSS5VJ7PDHPozho8Bn3guIXe4W0DzS7u/9u/hl9gv7YQUupXy6ReRu
   GHd7oBfD7ZiTKzxYUZOKklkO9+WcNEz6JEnPvh2+mgASfEV9/8BfQLkUA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="448058765"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="448058765"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922414055"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922414055"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.130.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:19:39 -0700
Date:   Tue, 26 Sep 2023 15:19:34 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] md: factor out a new helper to put mddev
Message-ID: <20230926151934.00003cb1@linux.intel.com>
In-Reply-To: <3d304e39-60c1-8f3c-f8b3-de8850d70b82@huaweicloud.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
        <20230926025827.671407-2-yukuai1@huaweicloud.com>
        <20230926144536.0000017d@linux.intel.com>
        <3d304e39-60c1-8f3c-f8b3-de8850d70b82@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 20:54:01 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
> 
> ÔÚ 2023/09/26 20:45, Mariusz Tkaczyk Ð´µÀ:
> > On Tue, 26 Sep 2023 10:58:26 +0800
> > Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >   
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> There are no functional changes, the new helper will still hold
> >> 'all_mddevs_lock' after putting mddev, and it will be used to simplify
> >> md_seq_ops.
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 18 +++++++++++++++---
> >>   1 file changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 10cb4dfbf4ae..a5ef6f7da8ec 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -616,10 +616,15 @@ static inline struct mddev *mddev_get(struct mddev
> >> *mddev)
> >>   static void mddev_delayed_delete(struct work_struct *ws);
> >>   
> >> -void mddev_put(struct mddev *mddev)
> >> +static void __mddev_put(struct mddev *mddev, bool locked)
> >>   {
> >> -	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
> >> +	if (locked) {
> >> +		spin_lock(&all_mddevs_lock);
> >> +		if (!atomic_dec_and_test(&mddev->active))
> >> +			return;  
> > 
> > It is "locked" and we are taking lock? It seems weird to me. Perhaps
> > "do_lock" would be better? Do you meant
> > "lockdep_assert_held(&all_mddevs_lock);"  
> 
> Yes, do_lock is a better name, true means this function will return with
> lock held.
> > 
> > Something is wrong here, we have two paths and in both cases we are
> > taking lock.  
> 
> No, in the first path, lock is held unconditionaly, that's what we
> expected in md_seq_show(); in the next path, lock will only be held if
> active is decreased to 0.
> 

Ok I see, you described it in commit message.
IMO it is bad practice to return with locked resource and not highlight it in
function name.In this case, I would prefer to respect that device is already
locked, not lock it here:

(assuming bool means "locked")
spin_lock(&all_mddevs_lock);
__mddev_put(mddev, true); <- function known that lock is held.
spin_unlock((mddev);

your "do_lock" approach:
__mddev_put(mddev, true); <- lock is taken here and we are returning 
spin_unlock((mddev);

You could change name to something like "all_mddev_lock_and_put(mddev)" to
indicate that we are locking all_mddevs. It fits for me too.
Note: it is just my preference, feel free to ignore :)

Mariusz
