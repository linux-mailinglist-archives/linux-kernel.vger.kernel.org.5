Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAFE77C38E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjHNWhG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjHNWg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:36:56 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 15:36:55 PDT
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1FAB;
        Mon, 14 Aug 2023 15:36:55 -0700 (PDT)
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
        by neil.brown.name with esmtp (Exim 4.95)
        (envelope-from <neil@brown.name>)
        id 1qVfF1-00Grlp-43;
        Mon, 14 Aug 2023 21:36:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neil@brown.name>
To:     "Song Liu" <song@kernel.org>
Cc:     "Yu Kuai" <yukuai1@huaweicloud.com>, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 01/13] md: remove rdev flag 'RemoveSynchronized'
In-reply-to: <CAPhsuW5m0bzO_FKw4VxE9S4KK6p7EZaffX+ZoYJZ6VGZQrf1hQ@mail.gmail.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>,
 <20230803132426.2688608-2-yukuai1@huaweicloud.com>,
 <CAPhsuW5m0bzO_FKw4VxE9S4KK6p7EZaffX+ZoYJZ6VGZQrf1hQ@mail.gmail.com>
Date:   Tue, 15 Aug 2023 07:36:46 +1000
Message-id: <169204900650.11073.14374074900186832485@noble.neil.brown.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023, Song Liu wrote:
> + Neil
> 
> RemoveSynchronized was added by Neil not too long ago. I wonder whether
> we still need it in some cases (large raid10 losing a large set of disks).

We have customers with thousands of members in a raid10.  They do
sometimes need to remove half of them.  Dropping RemoveSynchronized
would significantly increase the time it takes to do that.

Removing an rdev is not often a hot path.  But sometimes it can be.

NeilBrown


> 
> Thanks,
> Song
> 
> 
> On Thu, Aug 3, 2023 at 9:27 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > When multiple rdevs are removed from array in remove_and_add_spares(),
> > which is only possible from daemon thread(user can only remove one rdev
> > through ioctl/sysfs at one time), the flag is used to avoid calling
> > synchronize_rcu() multiple times for each rdev.
> >
> > However, remove rdev from daemon thread really is super cold path, while
> > removing n rdevs, it doesn't matter sync rcu n times or just one time.
> > Hence remove this flag and make code simpler.
> >
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/md/md-multipath.c | 15 +++++++--------
> >  drivers/md/md.c           | 26 ++------------------------
> >  drivers/md/md.h           |  5 -----
> >  drivers/md/raid1.c        | 15 +++++++--------
> >  drivers/md/raid10.c       | 15 +++++++--------
> >  drivers/md/raid5.c        | 15 +++++++--------
> >  6 files changed, 30 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> > index d22276870283..9e4ddd5240cd 100644
> > --- a/drivers/md/md-multipath.c
> > +++ b/drivers/md/md-multipath.c
> > @@ -258,14 +258,13 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
> >                         goto abort;
> >                 }
> >                 p->rdev = NULL;
> > -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> > -                       synchronize_rcu();
> > -                       if (atomic_read(&rdev->nr_pending)) {
> > -                               /* lost the race, try later */
> > -                               err = -EBUSY;
> > -                               p->rdev = rdev;
> > -                               goto abort;
> > -                       }
> > +
> > +               synchronize_rcu();
> > +               if (atomic_read(&rdev->nr_pending)) {
> > +                       /* lost the race, try later */
> > +                       err = -EBUSY;
> > +                       p->rdev = rdev;
> > +                       goto abort;
> >                 }
> >                 err = md_integrity_register(mddev);
> >         }
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index a3d98273b295..cd7ac1dee3b8 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -9155,7 +9155,6 @@ static int remove_and_add_spares(struct mddev *mddev,
> >         struct md_rdev *rdev;
> >         int spares = 0;
> >         int removed = 0;
> > -       bool remove_some = false;
> >
> >         if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> >                 /* Mustn't remove devices when resync thread is running */
> > @@ -9165,28 +9164,9 @@ static int remove_and_add_spares(struct mddev *mddev,
> >                 if ((this == NULL || rdev == this) &&
> >                     rdev->raid_disk >= 0 &&
> >                     !test_bit(Blocked, &rdev->flags) &&
> > -                   test_bit(Faulty, &rdev->flags) &&
> > +                   !test_bit(In_sync, &rdev->flags) &&
> > +                   !test_bit(Journal, &rdev->flags) &&
> >                     atomic_read(&rdev->nr_pending)==0) {
> > -                       /* Faulty non-Blocked devices with nr_pending == 0
> > -                        * never get nr_pending incremented,
> > -                        * never get Faulty cleared, and never get Blocked set.
> > -                        * So we can synchronize_rcu now rather than once per device
> > -                        */
> > -                       remove_some = true;
> > -                       set_bit(RemoveSynchronized, &rdev->flags);
> > -               }
> > -       }
> > -
> > -       if (remove_some)
> > -               synchronize_rcu();
> > -       rdev_for_each(rdev, mddev) {
> > -               if ((this == NULL || rdev == this) &&
> > -                   rdev->raid_disk >= 0 &&
> > -                   !test_bit(Blocked, &rdev->flags) &&
> > -                   ((test_bit(RemoveSynchronized, &rdev->flags) ||
> > -                    (!test_bit(In_sync, &rdev->flags) &&
> > -                     !test_bit(Journal, &rdev->flags))) &&
> > -                   atomic_read(&rdev->nr_pending)==0)) {
> >                         if (mddev->pers->hot_remove_disk(
> >                                     mddev, rdev) == 0) {
> >                                 sysfs_unlink_rdev(mddev, rdev);
> > @@ -9195,8 +9175,6 @@ static int remove_and_add_spares(struct mddev *mddev,
> >                                 removed++;
> >                         }
> >                 }
> > -               if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
> > -                       clear_bit(RemoveSynchronized, &rdev->flags);
> >         }
> >
> >         if (removed && mddev->kobj.sd)
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index 8ae957480976..b25b6d061372 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -189,11 +189,6 @@ enum flag_bits {
> >                                  * than other devices in the array
> >                                  */
> >         ClusterRemove,
> > -       RemoveSynchronized,     /* synchronize_rcu() was called after
> > -                                * this device was known to be faulty,
> > -                                * so it is safe to remove without
> > -                                * another synchronize_rcu() call.
> > -                                */
> >         ExternalBbl,            /* External metadata provides bad
> >                                  * block management for a disk
> >                                  */
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index 23d211969565..acb6d6542619 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -1859,15 +1859,14 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
> >                         goto abort;
> >                 }
> >                 p->rdev = NULL;
> > -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> > -                       synchronize_rcu();
> > -                       if (atomic_read(&rdev->nr_pending)) {
> > -                               /* lost the race, try later */
> > -                               err = -EBUSY;
> > -                               p->rdev = rdev;
> > -                               goto abort;
> > -                       }
> > +               synchronize_rcu();
> > +               if (atomic_read(&rdev->nr_pending)) {
> > +                       /* lost the race, try later */
> > +                       err = -EBUSY;
> > +                       p->rdev = rdev;
> > +                       goto abort;
> >                 }
> > +
> >                 if (conf->mirrors[conf->raid_disks + number].rdev) {
> >                         /* We just removed a device that is being replaced.
> >                          * Move down the replacement.  We drain all IO before
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index 7704a4c7f469..64dd5cb6133e 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -2247,15 +2247,14 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
> >                 goto abort;
> >         }
> >         *rdevp = NULL;
> > -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> > -               synchronize_rcu();
> > -               if (atomic_read(&rdev->nr_pending)) {
> > -                       /* lost the race, try later */
> > -                       err = -EBUSY;
> > -                       *rdevp = rdev;
> > -                       goto abort;
> > -               }
> > +       synchronize_rcu();
> > +       if (atomic_read(&rdev->nr_pending)) {
> > +               /* lost the race, try later */
> > +               err = -EBUSY;
> > +               *rdevp = rdev;
> > +               goto abort;
> >         }
> > +
> >         if (p->replacement) {
> >                 /* We must have just cleared 'rdev' */
> >                 p->rdev = p->replacement;
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index 4cdb35e54251..37d9865b180a 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -8267,15 +8267,14 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
> >                 goto abort;
> >         }
> >         *rdevp = NULL;
> > -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> > -               lockdep_assert_held(&mddev->reconfig_mutex);
> > -               synchronize_rcu();
> > -               if (atomic_read(&rdev->nr_pending)) {
> > -                       /* lost the race, try later */
> > -                       err = -EBUSY;
> > -                       rcu_assign_pointer(*rdevp, rdev);
> > -               }
> > +       lockdep_assert_held(&mddev->reconfig_mutex);
> > +       synchronize_rcu();
> > +       if (atomic_read(&rdev->nr_pending)) {
> > +               /* lost the race, try later */
> > +               err = -EBUSY;
> > +               rcu_assign_pointer(*rdevp, rdev);
> >         }
> > +
> >         if (!err) {
> >                 err = log_modify(conf, rdev, false);
> >                 if (err)
> > --
> > 2.39.2
> >
> 

