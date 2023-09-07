Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D297973F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbjIGPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbjIGPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE71FCF;
        Thu,  7 Sep 2023 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100659; x=1725636659;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aHVqwOrO+75etqT56c3Qz8PRUggG+wPxnNaCzndSWqw=;
  b=mFBT2I8SE7JHcDrKy82GW+e5DPTZX0QxA6Lo0p2XlUf1AsHiLL+lgm9y
   PvrWsB6qmuUCr2QVF3iIejzTp0rvTHCteUQ2L8xBW+RSifSyiNOE64RGD
   NLd34/Qmn65h+W3pYQtHC1tvXOpTfjqsIfo3vu19Vlh8MT7vWDchKaGh8
   EFxJqibNyjFBfbApD+c6HU2FZ8dC1wgjMRzVSVlLdF9TXHzDUTWzhT0a4
   dosBGqTaFlQJYxilfXefdTLrprqfoimIBzXLXF5fFVdshAMmIXKEslCBZ
   MV/P2RrgCdxt251fygv4TbCsd8xFKXxMeWbXdtH4ZwaOWov3KXD7I5/ee
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463693111"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="463693111"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="807488492"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="807488492"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.139.35])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:18:23 -0700
Date:   Thu, 7 Sep 2023 12:18:19 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     AceLan Kao <acelan@gmail.com>, Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Message-ID: <20230907121819.00005a15@linux.intel.com>
In-Reply-To: <43b0b2f4-17c0-61d2-9c41-0595fb6f2efc@huaweicloud.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
        <20230818101630.000027f4@linux.intel.com>
        <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
        <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
        <20230822083923.00007fb6@linux.intel.com>
        <CAMz9Wg8KE1rDkSaQnUTJ5ikzH7YGGYbkLM3AcrVue3=JgK+14w@mail.gmail.com>
        <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev>
        <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
        <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com>
        <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
        <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
        <354004ce-ad4e-5ad5-8fe6-303216647e0c@huaweicloud.com>
        <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
        <20230831085057.00001795@linux.intel.com>
        <CAMz9Wg8bhCG=qSLia943dwr=LV7Kum=bZPq2s_2coV6a_bmDeA@mail.gmail.com>
        <20230906122751.00001e5b@linux.intel.com>
        <43b0b2f4-17c0-61d2-9c41-0595fb6f2efc@huaweicloud.com>
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

On Thu, 7 Sep 2023 10:04:11 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
> 
> ÔÚ 2023/09/06 18:27, Mariusz Tkaczyk Ð´µÀ:
> > On Wed, 6 Sep 2023 14:26:30 +0800
> > AceLan Kao <acelan@gmail.com> wrote:
> >   
> >>  From previous testing, I don't think it's an issue in systemd, so I
> >> did a simple test and found the issue is gone.
> >> You only need to add a small delay in md_release(), then the issue
> >> can't be reproduced.
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 78be7811a89f..ef47e34c1af5 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -7805,6 +7805,7 @@ static void md_release(struct gendisk *disk)
> >> {
> >>         struct mddev *mddev = disk->private_data;
> >>
> >> +       msleep(10);
> >>         BUG_ON(!mddev);
> >>         atomic_dec(&mddev->openers);
> >>         mddev_put(mddev);  
> > 
> > I have repro and I tested it on my setup. It is not working for me.
> > My setup could be more "advanced" to maximalize chance of reproduction:
> > 
> > # cat /proc/mdstat
> > Personalities : [raid1] [raid6] [raid5] [raid4] [raid10] [raid0]
> > md121 : active raid0 nvme2n1[1] nvme5n1[0]
> >        7126394880 blocks super external:/md127/0 128k chunks
> > 
> > md122 : active raid10 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> >        104857600 blocks super external:/md126/0 64K chunks 2 near-copies
> > [4/4] [UUUU]
> > 
> > md123 : active raid5 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> >        2655765504 blocks super external:/md126/1 level 5, 32k chunk,
> > algorithm 0 [4/4] [UUUU]
> > 
> > md124 : active raid1 nvme0n1[1] nvme3n1[0]
> >        99614720 blocks super external:/md125/0 [2/2] [UU]
> > 
> > md125 : inactive nvme3n1[1](S) nvme0n1[0](S)
> >        10402 blocks super external:imsm
> > 
> > md126 : inactive nvme7n1[3](S) nvme1n1[2](S) nvme6n1[1](S) nvme4n1[0](S)
> >        20043 blocks super external:imsm
> > 
> > md127 : inactive nvme2n1[1](S) nvme5n1[0](S)
> >        10402 blocks super external:imsm
> > 
> > I have almost 99% repro ratio, slowly moving forward..
> > 
> > It is endless loop because systemd-shutdown sends ioctl "stop_array" which
> > is successful but array is not stopped. For that reason it sets "changed =
> > true".  
> 
> How does systemd-shutdown judge if array is stopped? cat /proc/mdstat or
> ls /dev/md* or other way?

Hi Yu,

It trusts return result, I confirmed that 0 is returned.
The most weird is we are returning 0 but array is still there, and it is
stopped again in next systemd loop. I don't understand why yet..

> > Systemd-shutdown see the change and retries to check if there is something
> > else which can be stopped now, and again, again...
> > 
> > I will check what is returned first, it could be 0 or it could be positive
> > errno (nit?) because systemd cares "if(r < 0)".  
> 
> I do noticed that there are lots of log about md123 stopped:
> 
> [ 1371.834034] md122:systemd-shutdow bd_prepare_to_claim return -16
> [ 1371.840294] md122:systemd-shutdow blkdev_get_by_dev return -16
> [ 1371.846845] md: md123 stopped.
> [ 1371.850155] md122:systemd-shutdow bd_prepare_to_claim return -16
> [ 1371.856411] md122:systemd-shutdow blkdev_get_by_dev return -16
> [ 1371.862941] md: md123 stopped.
> 
> And md_ioctl->do_md_stop doesn't have error path after printing this
> log, hence 0 will be returned to user.
> 
> The normal case is that:
> 
> open md123
> ioctl STOP_ARRAY -> all rdev should be removed from array
> close md123 -> mddev will finally be freed by:
> 	md_release
> 	 mddev_put
> 	  set_bit(MD_DELETED, &mddev->flags) -> user shound not see this mddev
> 	  queue_work(md_misc_wq, &mddev->del_work)
> 
> 	mddev_delayed_delete
> 	 kobject_put(&mddev->kobj)
> 
> 	md_kobj_release
> 	 del_gendisk
> 	  md_free_disk
> 	   mddev_free
> 
Ok thanks, I understand that md_release is called on descriptor closing, right?


> Now that you can reporduce this problem 99%, can you dig deeper and find
> out what is wrong?

Yes, working on it!

My first idea was that mddev_get and mddev_put are missing on md_ioctl() path
but it doesn't help for the issue. My motivation here was that md_attr_store and
md_attr_show are using them.

Systemd regenerates list of MD arrays on every loop and it is always
there, systemd is able to open file descriptor (maybe inactive?).
My fix with checking mddev_get and mddev_put should address that so it seems to
be something different.

BTW. I opened a discussion on slack proposed by Paul. I'm adding updates there
more frequently. If you are interested please join. I can see that you were
invited as:
Email Address
yukuai1@huaweicloud.com
Perhaps, that is the reason you can't join. Let me know, I will add you.

Thanks,
Mariusz

