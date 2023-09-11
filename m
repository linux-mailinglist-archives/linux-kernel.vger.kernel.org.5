Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3579BBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbjIKVhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjIKOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:05:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DADCF0;
        Mon, 11 Sep 2023 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694441148; x=1725977148;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0EJMEqElL7ywCI2JEL1bG0Qg/pB1AH4gYay1JxvZNmk=;
  b=XN5cHsCT0K9RIeF/ruQiurp3eZWcJYlsAfuWTpbBuu4zo9/GJCaRkAuY
   AEBi3AUcDLwmN/mFAFOz0dpobYaHxweATKupEameVjlg2fYZduSt2c7vY
   axE3+SBl1mJs1VZajUQaj6Lwlb0oNqG1cpPCMfdxo7jHENjFJflTbFU4W
   HMBv7c5IKcdlI9H0JiRz28xS1pgbPctis6uyRo+ZMJF25P/nb2npXJZO7
   bsULOXPHIQTudMLz86SzCMZELl4gxdEiN1PA20+WnFBh7fYRBUw3p+H3G
   +9KFU5I5w8rE68XnbhwUz1CZH/3fZ4DYaCrAjX83fMjB9HidvQ1pVbb2C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381894222"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381894222"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886522450"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886522450"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.141.71])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:05:21 -0700
Date:   Mon, 11 Sep 2023 16:05:40 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] md: simplify md_seq_ops
Message-ID: <20230911160540.0000060e@linux.intel.com>
In-Reply-To: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
References: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
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

On Mon, 11 Sep 2023 14:50:10 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Use seq_list_start/next/stop() directly. Move printing "Personalities"
> to md_sep_start() and "unsed devices" to md_seq_stop().
> 
> Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 124 ++++++++++++------------------------------------
>  1 file changed, 31 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0fe7ab6e8ab9..9c1155042335 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8192,105 +8192,14 @@ static int status_resync(struct seq_file *seq,
> struct mddev *mddev) return 1;
>  }
>  
> -static void *md_seq_start(struct seq_file *seq, loff_t *pos)
> -{
> -	struct list_head *tmp;
> -	loff_t l = *pos;
> -	struct mddev *mddev;
> -
> -	if (l == 0x10000) {
> -		++*pos;
> -		return (void *)2;
> -	}
> -	if (l > 0x10000)
> -		return NULL;
> -	if (!l--)
> -		/* header */
> -		return (void*)1;
> -
> -	spin_lock(&all_mddevs_lock);
> -	list_for_each(tmp,&all_mddevs)
> -		if (!l--) {
> -			mddev = list_entry(tmp, struct mddev, all_mddevs);
> -			if (!mddev_get(mddev))
> -				continue;
> -			spin_unlock(&all_mddevs_lock);
> -			return mddev;
> -		}
> -	spin_unlock(&all_mddevs_lock);
> -	if (!l--)
> -		return (void*)2;/* tail */
> -	return NULL;
> -}
> -
> -static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> -{
> -	struct list_head *tmp;
> -	struct mddev *next_mddev, *mddev = v;
> -	struct mddev *to_put = NULL;
> -
> -	++*pos;
> -	if (v == (void*)2)
> -		return NULL;
> -
> -	spin_lock(&all_mddevs_lock);
> -	if (v == (void*)1) {
> -		tmp = all_mddevs.next;
> -	} else {
> -		to_put = mddev;
> -		tmp = mddev->all_mddevs.next;
> -	}
> -
> -	for (;;) {
> -		if (tmp == &all_mddevs) {
> -			next_mddev = (void*)2;
> -			*pos = 0x10000;
> -			break;
> -		}
> -		next_mddev = list_entry(tmp, struct mddev, all_mddevs);
> -		if (mddev_get(next_mddev))
> -			break;
> -		mddev = next_mddev;
> -		tmp = mddev->all_mddevs.next;
> -	}
> -	spin_unlock(&all_mddevs_lock);
> -
> -	if (to_put)
> -		mddev_put(mddev);
> -	return next_mddev;
> -
> -}
> -
> -static void md_seq_stop(struct seq_file *seq, void *v)
> -{
> -	struct mddev *mddev = v;
> -
> -	if (mddev && v != (void*)1 && v != (void*)2)
> -		mddev_put(mddev);
> -}
> -
>  static int md_seq_show(struct seq_file *seq, void *v)
>  {
> -	struct mddev *mddev = v;
> +	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
>  	sector_t sectors;
>  	struct md_rdev *rdev;
>  
> -	if (v == (void*)1) {
> -		struct md_personality *pers;
> -		seq_printf(seq, "Personalities : ");
> -		spin_lock(&pers_lock);
> -		list_for_each_entry(pers, &pers_list, list)
> -			seq_printf(seq, "[%s] ", pers->name);
> -
> -		spin_unlock(&pers_lock);
> -		seq_printf(seq, "\n");
> -		seq->poll_event = atomic_read(&md_event_count);
> -		return 0;
> -	}
> -	if (v == (void*)2) {
> -		status_unused(seq);
> +	if (test_bit(MD_DELETED, &mddev->flags))
>  		return 0;
> -	}
>  
>  	spin_lock(&mddev->lock);
>  	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
> @@ -8366,6 +8275,35 @@ static int md_seq_show(struct seq_file *seq, void *v)
>  	return 0;
>  }
>  
> +static void *md_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct md_personality *pers;
> +
> +	seq_puts(seq, "Personalities : ");
> +	spin_lock(&pers_lock);
> +	list_for_each_entry(pers, &pers_list, list)
> +		seq_printf(seq, "[%s] ", pers->name);
> +
> +	spin_unlock(&pers_lock);
> +	seq_puts(seq, "\n");
> +	seq->poll_event = atomic_read(&md_event_count);
> +
> +	spin_lock(&all_mddevs_lock);

I would prefer to increase "active" instead holding lock when enumerating over
the devices. the main reason is that parsing mdstat is implemented in mdadm, so
it could kind of blocker action- for example mdmon follows mdstat so it is read
frequently. The time of getting other actions done can highly increase because
every open or sysfs_read/write requires this lock.

> +
> +	return seq_list_start(&all_mddevs, *pos);
> +}
> +
> +static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	return seq_list_next(v, &all_mddevs, pos);
> +}
Can it be so simple? Why previous versions takes care of holding "(void)*1" and
"(void)*2" then? Could you elaborate?

> +
> +static void md_seq_stop(struct seq_file *seq, void *v)
> +{
> +	status_unused(seq);
> +	spin_unlock(&all_mddevs_lock);
> +}
> +
>  static const struct seq_operations md_seq_ops = {
>  	.start  = md_seq_start,
>  	.next   = md_seq_next,

Thanks,
Mariusz
