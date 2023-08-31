Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBB78E6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjHaGvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjHaGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:51:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8DAB;
        Wed, 30 Aug 2023 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693464665; x=1725000665;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vpk5sOevamTYSoOMQUv0RfujFkQagcssabdouNLSXWo=;
  b=jwFN+Lqt9Qnuko4IqSHB9DbQ/c0SHPfecRY3kJRuyrIkGiSFcOdlyfw0
   ayx+/OGlL1FRUUuiy6Lfk+s3xKwK7yymhgDTPEwVCDx1/Qj6WJeOkwQK5
   mUFYZbLDj9l3Vr6hmAAU/C41gQo+GCBjeF1vpiWIG7E5th0e1JY2Jo+IL
   fUbS0n9lEhzDWkn0+BX8HPB6nBEOsq2dohI56HSTnK20P1LiGZl7NkhgR
   ttjCTr/pWQFnxlgxGhPt0Kzo9x2hx9TiTkcF10iy5//v41sdb+zT+cyWl
   3fvpruVJh7epkil8O+FJHFzePX5yF/N/ZAp/hKI7wZ/dBqgqyetf+JETK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374748446"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="374748446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 23:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="986072486"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="986072486"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.134.233])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 23:51:02 -0700
Date:   Thu, 31 Aug 2023 08:50:57 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Song Liu <song@kernel.org>, AceLan Kao <acelan@gmail.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Message-ID: <20230831085057.00001795@linux.intel.com>
In-Reply-To: <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
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
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 10:28:44 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi, Acelan,
>=20
> =E5=9C=A8 2023/08/28 21:50, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > =E5=9C=A8 2023/08/28 13:20, Song Liu =E5=86=99=E9=81=93: =20
> >> Hi AceLan,
> >>
> >> Thanks for running the experiments.
> >>
> >> On Fri, Aug 25, 2023 at 9:32=E2=80=AFPM AceLan Kao <acelan@gmail.com> =
wrote:
> >> [...] =20
> >>>>
> >>>> Could you please run the follow two experiments?
> >>>>
> >>>> 1. Confirm 12a6caf273240a triggers this. Specifically:
> >>>> =C2=A0=C2=A0=C2=A0 git checkout 12a6caf273240a =3D> repros
> >>>> =C2=A0=C2=A0=C2=A0 git checkout 12a6caf273240a~1 =3D> cannot repro =
=20
> >>> Yes, I'm pretty sure about this, that's my bisect result and I just
> >>> confirmed it again.
> >>> I also tried reverting 12a6caf273240a and the issue is gone. =20
> >>
> >> The log doesn't match my guess. Specifically:
> >>
> >> [=C2=A0 420.068142] systemd-shutdown[1]: Stopping MD /dev/md123 (9:123=
).
> >> [=C2=A0 420.074718] md_open:md123 openers++ =3D 1 by systemd-shutdow
> >> [=C2=A0 420.080787] systemd-shutdown[1]: Failed to sync MD block device
> >> /dev/md123, ignoring: Input/output error
> >> [=C2=A0 420.090831] md: md123 stopped.
> >> [=C2=A0 420.094465] systemd-shutdown[1]: Stopping MD /dev/md122 (9:122=
).
> >> [=C2=A0 420.101045] systemd-shutdown[1]: Could not stop MD /dev/md122:
> >> Device or resource busy =20
> >=20
> > I see that:
> >=20
> > systemd-shutdown[1]: Couldn't finalize remaining=C2=A0 MD devices, tryi=
ng again.
> >=20
> > Can we make sure is this why power off hang?
> >=20
> > Because in my VM, power off is not hang and I got:
> >=20
> > systemd-shutdown[1]: Could not stop MD /dev/md1: Device or resource busy
> > systemd-shutdown[1]: Failed to finalize MD devices, ignoring. =20
> >>
> >> For a successful stop on md123, we reach the pr_info() in md_open().
> >> For a failed stop on md122, the kernel returns -EBUSY before that
> >> pr_info() in md_open(). There are some changes in md_open() in
> >> the past few release, so I am not quite sure we are looking at the
> >> same code. =20
> >=20
> > By the way, based on code review, looks like md_open never return
> > -EBUSY, and I think following is the only place can return -EBUSY before
> > md_open() is called:
> >=20
> > blkdev_open
> >  =C2=A0blkdev_get_by_dev
> >  =C2=A0 bd_prepare_to_claim
> >  =C2=A0=C2=A0 bd_may_claim=C2=A0=C2=A0=C2=A0=C2=A0 -> -EBUSY
> >=20
> > Acelan, can you add following debug patch on the top of Song's patch
> > and reporduce it again? Hope it'll confirm why stop array failed with
> > -EBUSY.
> >  =20
>=20
> I saw your reply:
>=20
> https://lore.kernel.org/all/CAMz9Wg9VXJzZkKWCosm0_=3DRz6gG9r3pCMrhvBZQVCQ=
b8i0kd-w@mail.gmail.com/
>=20
> But I didn't recieve you emails, please reply to me through this email
> address: yukuai3@huawei.com. yukuai1@huaweicloud.com is just used for
> sending, and I always missing emails from huaweicloud.com, my apologize
> for this inconvenience, I have to do it this way due to my company
> policy.
>=20
> There is something interesting on test result:
>=20
> At first, md122 is the root device, I guess this is why I can't repoduce
> this problem in my local VM.
> [   14.478619] systemd-gpt-auto-generator[585]: md122p3: Root device=20
> /dev/md122.
> [   14.481823] block md122: the capability attribute has been deprecated.
>=20
> Then, before trying to stop md122, following log shows that md122 is
> still mounted:
> [ 1368.369926] [3462]: Remounting '/' read-only with options=20
> 'errors=3Dremount-ro,stripe=3D128'.
> [ 1368.396287] EXT4-fs (md122p3): re-mounted=20
> 6d53dc8e-3f45-4efa-bc0e-4af477fac217 ro. Quota mode: none.
>=20
> And since then, there is no log aboug md_open(), which means no one
> ever open md122 since this remount.
>=20
> At last, there are lots of log shows that md122 can't be opened
> exclusively:
> [ 1368.812952] md122:systemd-shutdow bd_prepare_to_claim return -16
> [ 1368.819189] md122:systemd-shutdow blkdev_get_by_dev return -16
>
> Which indicate that md122 is still mounted, and systemd-shutdow can't
> stop this array. This behaviour looks correct to me, because rootfs
> can't be umounted while systemd-shutdown is still running.
>=20
> However, there are some questions I don't have answers for now, I'm not
> familiar with how systemd works:
>=20
> 1) In the normal case that raid is root device, how can systemd-shutdown
> make progress and how is rootfs unmounted?

Thanks for digging into!

In that case systemd-shutdown should skip this device. It should be umounte=
d by
dracut. systemd-shutdown implements naive way to try stop MD devices, simple
ioctl(fd, STOP_ARRAY, NULL).
We are expecting failure if resource is still mounted.

Here dracut code:
https://github.com/dracutdevs/dracut/blob/master/modules.d/90mdraid/md-shut=
down.sh

Ohh, it is ubuntu so it is handled by initramfs-tools not by dracut, but I =
hope
you will find it useful for the future.=20

and system-shutdown:
https://github.com/systemd/systemd/blob/main/src/shutdown/shutdown.c#L483C7=
-L483C7

When the functionality in systemd-shutdown was fixed by me, I asked if we c=
an
make it configurable- Lennart disagreed so there is now way to disable it n=
ow.=20

> 2) How does this scenario related to commit 12a6caf273240a.

I'm unable to reproduce it on Redhat, Ubuntu is on the way now.
I'm starting to be convinced that it could be related with initramfs-tools =
but
I cannot prove this theory yet. I need to reproduce the issue first.

Thanks,
Mariusz
>=20
> I must read systemd source code to get answers, and it'll be appreciated
> if someone has answers.
>=20
> Thanks,
> Kuai
>=20
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 979e28a46b98..699739223dcb 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -789,8 +789,11 @@ struct block_device *blkdev_get_by_dev(dev_t dev,=
=20
> > blk_mode_t mode, void *holder,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (holder) {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode |=3D BLK_OPEN_EXCL;
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D bd_prepare_to_claim(bdev, holder, hops);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("%s=
:%s bd_prepare_to_claim return %d\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk->disk_name, current->comm, ret);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
put_blkdev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL)) {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
> > diff --git a/block/fops.c b/block/fops.c
> > index eaa98a987213..2d69119c71f6 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -587,8 +587,11 @@ static int blkdev_open(struct inode *inode, struct=
=20
> > file *filp)
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdev =3D blkdev_get_by_dev(=
inode->i_rdev, file_to_blk_mode(filp),
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filp->private_data, NULL);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(bdev))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(bdev)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_warn("%pD:%s blkdev_get_by_dev return %ld\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filp, curre=
nt->comm, PTR_ERR(bdev));
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(bdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdev_nowait(bdev))
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 filp->f_mode |=3D FMODE_NOWAIT;
> >=20
> > Thanks,
> > Kuai
> >  =20
> >>
> >> Therefore, could you please help clarify:
> >>
> >> 1. Which base kernel are you using?
> >> =20
> >>> From the log, you are using 6.5-rc7-706a74159504. However, =20
> >> I think we cannot cleanly revert 12a6caf273240a on top of
> >> 6.5-rc7-706a74159504. Did you manually fix some issue in the
> >> revert? If so, could you please share the revert commit?
> >>
> >> 2. If you are not using 6.5-rc7-706a74159504 as base kernel, which
> >> one are you using?
> >>
> >> Thanks,
> >> Song
> >> =20
> >>> =20
> >>>>
> >>>> 2. Try with the following change (add debug messages), which hopeful=
ly
> >>>> =C2=A0=C2=A0=C2=A0 shows which command is holding a reference on mdd=
ev->openers.
> >>>>
> >>>> Thanks,
> >>>> Song
> >>>>
> >>>> diff --git i/drivers/md/md.c w/drivers/md/md.c
> >>>> index 78be7811a89f..3e9b718b32c1 100644
> >>>> --- i/drivers/md/md.c
> >>>> +++ w/drivers/md/md.c
> >>>> @@ -7574,11 +7574,15 @@ static int md_ioctl(struct block_device *bde=
v,
> >>>> blk_mode_t mode,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mddev->pers && atomic_read(&mddev->opene=
rs) > 1) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mutex_unlock(&mddev->open_mutex);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 err =3D -EBUSY;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn(=
"%s return -EBUSY for %s with
> >>>> mddev->openers =3D %d\n",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, mdname(mddev),
> >>>> atomic_read(&mddev->openers));
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_and_set_bit(MD_CLOSING, &mddev->fla=
gs)) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mutex_unlock(&mddev->open_mutex);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 err =3D -EBUSY;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn(=
"%s return -EBUSY for %s with
> >>>> MD_CLOSING bit set\n",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, mdname(mddev));
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 did_set_md_closing =3D true;
> >>>> @@ -7789,6 +7793,8 @@ static int md_open(struct gendisk *disk,=20
> >>>> blk_mode_t mode)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&mddev->=
openers);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("%s:%s openers++ =3D %=
d by %s\n", __func__,=20
> >>>> mdname(mddev),
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atomic_read(&mddev->openers), current->comm);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&mddev=
->open_mutex);
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_check_media_ch=
ange(disk);
> >>>> @@ -7807,6 +7813,8 @@ static void md_release(struct gendisk *disk)
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!mddev);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&mddev->=
openers);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("%s:%s openers-- =3D %=
d by %s\n", __func__,=20
> >>>> mdname(mddev),
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atomic_read(&mddev->openers), current->comm);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev_put(mddev);
> >>>> =C2=A0 } =20
> >>> It's pretty strange that I can't reproduce the issue after applied=20
> >>> the patch.
> >>>
> >>> I tried to figure out which part affect the issue and found when I
> >>> comment out the pr_info() In md_release(), the issue could be
> >>> reproduced.
> >>>
> >>> --=20
> >>> Chia-Lin Kao(AceLan)
> >>> http://blog.acelan.idv.tw/
> >>> E-Mail: acelan.kaoATcanonical.com (s/AT/@/) =20
> >> .
> >> =20
> >=20
> > .
> >  =20
>=20

