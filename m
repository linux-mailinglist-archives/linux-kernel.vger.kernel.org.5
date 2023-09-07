Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044E797AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbjIGR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245621AbjIGR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3951700;
        Thu,  7 Sep 2023 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109488; x=1725645488;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HrqTxAusmEEEmb/UjBv9mKHXzcO8mYCUsE/3XcRzihM=;
  b=POdSJ9OE1zC3zySWsUCEH1dx8J9Hr7gXKr1tw/jPmx+q2Jryqe6R2ojQ
   5uJ0Vgz34yM10ji1D5frev7SBxN8v4MSAnURSy6fYglp5QzZId1wbCqwP
   fo04xL9PtZqT9bk3VGZEouuIyHnnaFu6X7p/6WI5h04g6SDHwgsvX2/SC
   pZJENebpDUXZQHwTQ1wK4cYumcllb+nnncktIt2tWkxxwc6JcMtvOP306
   sy+FFAADuMvXe9YNxLvY3PDFLsNnd7k+/Lrw6s75JDlxgOmbVeTnV8B22
   FlgBKHss0t3lbbs/Lyid3xAVnKYz0KYZfiNnqE46POo/Dl2mZfutsH0eC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367569482"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="367569482"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865619074"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="865619074"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.139.35])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:41:58 -0700
Date:   Thu, 7 Sep 2023 14:41:53 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     AceLan Kao <acelan@gmail.com>, Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Message-ID: <20230907144153.00002492@linux.intel.com>
In-Reply-To: <3e7edf0c-cadd-59b0-4e10-dffdb86b93b7@huaweicloud.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
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
        <20230907121819.00005a15@linux.intel.com>
        <cffca94f-5729-622d-9327-632b3ff2891a@huaweicloud.com>
        <3e7edf0c-cadd-59b0-4e10-dffdb86b93b7@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 20:14:03 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
>=20
> =E5=9C=A8 2023/09/07 19:26, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > =E5=9C=A8 2023/09/07 18:18, Mariusz Tkaczyk =E5=86=99=E9=81=93: =20
> >> On Thu, 7 Sep 2023 10:04:11 +0800
> >> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >> =20
> >>> Hi,
> >>>
> >>> =E5=9C=A8 2023/09/06 18:27, Mariusz Tkaczyk =E5=86=99=E9=81=93: =20
> >>>> On Wed, 6 Sep 2023 14:26:30 +0800
> >>>> AceLan Kao <acelan@gmail.com> wrote: =20
> >>>>> =C2=A0 From previous testing, I don't think it's an issue in system=
d, so I
> >>>>> did a simple test and found the issue is gone.
> >>>>> You only need to add a small delay in md_release(), then the issue
> >>>>> can't be reproduced.
> >>>>>
> >>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >>>>> index 78be7811a89f..ef47e34c1af5 100644
> >>>>> --- a/drivers/md/md.c
> >>>>> +++ b/drivers/md/md.c
> >>>>> @@ -7805,6 +7805,7 @@ static void md_release(struct gendisk *disk)
> >>>>> {
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mddev *mdde=
v =3D disk->private_data;
> >>>>>
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(10);
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!mddev);
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&mddev-=
>openers);
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev_put(mddev); =
=20
> >>>>
> >>>> I have repro and I tested it on my setup. It is not working for me.
> >>>> My setup could be more "advanced" to maximalize chance of reproducti=
on:
> >>>>
> >>>> # cat /proc/mdstat
> >>>> Personalities : [raid1] [raid6] [raid5] [raid4] [raid10] [raid0]
> >>>> md121 : active raid0 nvme2n1[1] nvme5n1[0]
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7126394880 blocks super e=
xternal:/md127/0 128k chunks
> >>>>
> >>>> md122 : active raid10 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 104857600 blocks super ex=
ternal:/md126/0 64K chunks 2=20
> >>>> near-copies
> >>>> [4/4] [UUUU]
> >>>>
> >>>> md123 : active raid5 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2655765504 blocks super e=
xternal:/md126/1 level 5, 32k chunk,
> >>>> algorithm 0 [4/4] [UUUU]
> >>>>
> >>>> md124 : active raid1 nvme0n1[1] nvme3n1[0]
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 99614720 blocks super ext=
ernal:/md125/0 [2/2] [UU]
> >>>>
> >>>> md125 : inactive nvme3n1[1](S) nvme0n1[0](S)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10402 blocks super extern=
al:imsm
> >>>>
> >>>> md126 : inactive nvme7n1[3](S) nvme1n1[2](S) nvme6n1[1](S)=20
> >>>> nvme4n1[0](S)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20043 blocks super extern=
al:imsm
> >>>>
> >>>> md127 : inactive nvme2n1[1](S) nvme5n1[0](S)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10402 blocks super extern=
al:imsm
> >>>>
> >>>> I have almost 99% repro ratio, slowly moving forward..
> >>>>
> >>>> It is endless loop because systemd-shutdown sends ioctl "stop_array"=
=20
> >>>> which
> >>>> is successful but array is not stopped. For that reason it sets=20
> >>>> "changed =3D
> >>>> true". =20
> >>>
> >>> How does systemd-shutdown judge if array is stopped? cat /proc/mdstat=
 or
> >>> ls /dev/md* or other way? =20
> >>
> >> Hi Yu,
> >>
> >> It trusts return result, I confirmed that 0 is returned.
> >> The most weird is we are returning 0 but array is still there, and it =
is
> >> stopped again in next systemd loop. I don't understand why yet..
> >> =20
> >>>> Systemd-shutdown see the change and retries to check if there is=20
> >>>> something
> >>>> else which can be stopped now, and again, again...
> >>>>
> >>>> I will check what is returned first, it could be 0 or it could be=20
> >>>> positive
> >>>> errno (nit?) because systemd cares "if(r < 0)". =20
> >>>
> >>> I do noticed that there are lots of log about md123 stopped:
> >>>
> >>> [ 1371.834034] md122:systemd-shutdow bd_prepare_to_claim return -16
> >>> [ 1371.840294] md122:systemd-shutdow blkdev_get_by_dev return -16
> >>> [ 1371.846845] md: md123 stopped.
> >>> [ 1371.850155] md122:systemd-shutdow bd_prepare_to_claim return -16
> >>> [ 1371.856411] md122:systemd-shutdow blkdev_get_by_dev return -16
> >>> [ 1371.862941] md: md123 stopped.
> >>>
> >>> And md_ioctl->do_md_stop doesn't have error path after printing this
> >>> log, hence 0 will be returned to user.
> >>>
> >>> The normal case is that:
> >>>
> >>> open md123
> >>> ioctl STOP_ARRAY -> all rdev should be removed from array
> >>> close md123 -> mddev will finally be freed by:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0md_release
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 mddev_put
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(MD_DELETED, &mddev->flags) -> =
user shound not see this=20
> >>> mddev
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(md_misc_wq, &mddev->del_wor=
k)
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0mddev_delayed_delete
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 kobject_put(&mddev->kobj)
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0md_kobj_release
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 del_gendisk
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_free_disk
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev_free
> >>> =20
> >> Ok thanks, I understand that md_release is called on descriptor=20
> >> closing, right?
> >> =20
> >=20
> > Yes, normally close md123 should drop that last reference. =20
> >> =20
> >>> Now that you can reporduce this problem 99%, can you dig deeper and f=
ind
> >>> out what is wrong? =20
> >>
> >> Yes, working on it!
> >>
> >> My first idea was that mddev_get and mddev_put are missing on=20
> >> md_ioctl() path
> >> but it doesn't help for the issue. My motivation here was that=20
> >> md_attr_store and
> >> md_attr_show are using them.
> >>
> >> Systemd regenerates list of MD arrays on every loop and it is always
> >> there, systemd is able to open file descriptor (maybe inactive?). =20
> >=20
> > md123 should not be opended again, ioctl(STOP_ARRAY) already set the
> > flag 'MD_CLOSING' to prevent that. Are you sure that systemd-shutdown do
> > open and close the array in each loop? =20
>=20
> I realized that I'm wrong here. 'MD_CLOSING' is cleared before ioctl
> return by commit 065e519e71b2 ("md: MD_CLOSING needs to be cleared after
> called md_set_readonly or do_md_stop").
>=20
> I'm confused here, commit message said 'MD_CLOSING' shold not be set for
> the case STOP_ARRAY_RO, but I don't understand why it's cleared for
> STOP_ARRAY as well.
>=20
Not related with your findings but:

I replaced if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
because that is the way to exit without queuing work:

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0fe7ab6e8ab9..80bd7446be94 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -618,8 +618,7 @@ static void mddev_delayed_delete(struct work_struct *ws=
);

=20

void mddev_put(struct mddev *mddev)
{
-       if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
-               return;
+       spin_lock(&all_mddevs_lock);
        if (!mddev->raid_disks && list_empty(&mddev->disks) &&
            mddev->ctime =3D=3D 0 && !mddev->hold_active) {
                /* Array is not configured at all, and not held active,
@@ -634,6 +633,7 @@ void mddev_put(struct mddev *mddev)
                INIT_WORK(&mddev->del_work, mddev_delayed_delete);
                queue_work(md_misc_wq, &mddev->del_work);
        }
+       atomic_dec(&mddev->active);
        spin_unlock(&all_mddevs_lock);
}

After that I got kernel panic but it seems that workqueue is scheduled:

 51.535103] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   51.539115] ------------[ cut here ]------------
[   51.543867] #PF: supervisor read access in kernel mode
1;[3 9 m S5t1a.r5tPF: error_code(0x0000) - not-present page
[   51.543875] PGD 0 P4D 0
.k[ 0 m5.1
 54ops: 0000 [#1] PREEMPT SMP NOPTI
[   51.552207] refcount_t: underflow; use-after-free.
[   51.556820] CPU: 19 PID: 368 Comm: kworker/19:1 Not tainted 6.5.0+ #57
[   51.556825] Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS
WLYDCRB1.SYS.0027.P82.2204080829 04/08/2022 [   51.561979] WARNING: CPU: 26
PID: 376 at lib/refcount.c:28 refcount_warn_saturate+0x99/0xe0 [   51.56727=
3]
Workqueue:  mddev_delayed_delete [md_mod] [   51.569822] Modules linked in:
[   51.574351]  (events)
[   51.574353] RIP: 0010:process_one_work+0x10f/0x3d0
[   51.579155]  configfs

In my case, it seems to be IMSM container device is stopped in loop, which =
is an
inactive from the start. It is not something I'm totally sure but it could =
lead
us to the root cause. So far I know, the original reported uses IMSM arrays=
 too.

Thanks,
Mariusz
