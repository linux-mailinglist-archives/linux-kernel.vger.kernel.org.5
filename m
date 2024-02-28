Return-Path: <linux-kernel+bounces-84315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910686A4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F411F27B30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF84A4A35;
	Wed, 28 Feb 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJHLqcK8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B420F1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083189; cv=none; b=Td/LX6UwzYekwvX9LlJXupsCdqOl41/6X03AW6+b/3IaAOKkgOjlLqTb6x9yl6BTYQ3zu0ppXL9ULghwy2nkKyOhS3JHSPiKssHGqjksNtd8I6h7NzJCc9wABcQv8wdpkhyfmdsZiclNltTj174yW6nN5+NVeNYVf9het+6OFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083189; c=relaxed/simple;
	bh=jUjuP1ba97xMxa8s8XEAr69TPTAFRtYzXYGh0GnZ11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYgBGEsqOW7AC30ZBFDQVkZk3HxiWpMzOAAOBkXPUnYV+D2G1I7jDCdpsxKnwazxbl6MK3G2J/ub/GjLLW/F0OiTmWc3wnyOa1Lc26peS4Xxs6jB89kag3WHqGSmTdym2mFhOy9M7eL/y+Q1Iju0i+BLEeXTFa72NNVkbPfWkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJHLqcK8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709083186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xODwkh6lWJ+prRzk9B4MVint+BajL8I0Z+w8JnGYEJs=;
	b=fJHLqcK8Gvcbt0W/FA1Grv5wlxsFC5DCVMziRLO9ZKMYYF0WKGGT9O8Xh4+3Eu5aGZIBD4
	dd7zHBrNL/3HZF1C+YfIT0wwmrbpaT+FtIaZzujkdEOkkHJpS+hO7ZWb32J+2jtIXRd4bp
	1i2qS/Thycnmd9glisl5OrZDmYMeJQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1-sefNxRNwmT3rc5jP8TDw-1; Tue, 27 Feb 2024 20:19:44 -0500
X-MC-Unique: 1-sefNxRNwmT3rc5jP8TDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53311185A780;
	Wed, 28 Feb 2024 01:19:43 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D39901121312;
	Wed, 28 Feb 2024 01:19:42 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with ESMTPS id 41S1Jghx666443
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 20:19:42 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id 41S1JfXs666441;
	Tue, 27 Feb 2024 20:19:41 -0500
Date: Tue, 27 Feb 2024 20:19:41 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Song Liu <song@kernel.org>, mpatocka@redhat.com, heinzm@redhat.com,
        xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com,
        neilb@suse.de, shli@fb.com, akpm@osdl.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
Message-ID: <Zd6KLf1pOkMmfR5g@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
 <Zc72uQln4bXothru@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <0083c330-1d3f-43b0-1d11-caf09d7c27c8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0083c330-1d3f-43b0-1d11-caf09d7c27c8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Feb 22, 2024 at 05:00:56PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/02/16 13:46, Benjamin Marzinski 写道:
> > On Thu, Feb 15, 2024 at 02:24:34PM -0800, Song Liu wrote:
> > > On Thu, Feb 1, 2024 at 1:30 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > > > 
> > > [...]
> > > > 
> > > > [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com/
> > > > 
> > > > Yu Kuai (14):
> > > >    md: don't ignore suspended array in md_check_recovery()
> > > >    md: don't ignore read-only array in md_check_recovery()
> > > >    md: make sure md_do_sync() will set MD_RECOVERY_DONE
> > > >    md: don't register sync_thread for reshape directly
> > > >    md: don't suspend the array for interrupted reshape
> > > >    md: fix missing release of 'active_io' for flush
> > > 
> > > Applied 1/14-5/14 to md-6.8 branch (6/14 was applied earlier).
> > > 
> > > Thanks,
> > > Song
> > 
> > I'm still seeing new failures that I can't reproduce in the 6.6 kernel,
> > specifically:
> > 
> > lvconvert-raid-reshape-stripes-load-reload.sh
> > lvconvert-repair-raid.sh
> > 
> > with lvconvert-raid-reshape-stripes-load-reload.sh Patch 12/14
> > ("md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> > reshape") is changing a hang to a corruption. The issues is that we
> > can't simply fail IO that crosses the reshape position. I assume that
> > the correct thing to do is have dm-raid reissue it after the suspend,
> > when the reshape can make progress again. Perhaps something like this,
> > only less naive (although this patch does make the test pass for me).
> > Heinz, any thoughts on this? Otherwise, I'll look into this a little
> > more and post a RFC patch.
> > 
> > =========================================================
> > diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> > index ed8c28952b14..ff481d494b04 100644
> > --- a/drivers/md/dm-raid.c
> > +++ b/drivers/md/dm-raid.c
> > @@ -3345,6 +3345,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
> >   	return DM_MAPIO_SUBMITTED;
> >   }
> > +static int raid_end_io(struct dm_target *ti, struct bio *bio,
> > +		       blk_status_t *error)
> > +{
> > +	if (*error != BLK_STS_IOERR || !dm_noflush_suspending(ti))
> > +		return DM_ENDIO_DONE;
> > +	return DM_ENDIO_REQUEUE;
> > +}
> 
> I love this idea, however, there could be other reasonable case to
> return BLK_STS_IOERR, and we probably shouldn't requeue in this case.
> 
> Are we agree with the idea to let dm-raid reissue the IO after the
> suspend? If so, we can let raid_map return DM_MAPIO_REQUEUE directly in
> this special case.
> 
> Benjamin, can you test the following patch on the top of this set? I
> verified in my VM for 20+ times that the test pass for me.

This looks sensible to me, and I have not hit an error in over a hundred
runs.

-Ben

> Thanks,
> Kuai
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index ed8c28952b14..bd37ec94663e 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3340,7 +3340,8 @@ static int raid_map(struct dm_target *ti, struct bio
> *bio)
>         if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
>                 return DM_MAPIO_REQUEUE;
> 
> -       md_handle_request(mddev, bio);
> +       if (unlikely(!md_handle_request(mddev, bio)))
> +               return DM_MAPIO_REQUEUE;
> 
>         return DM_MAPIO_SUBMITTED;
>  }
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index a8db84c200fe..59411d20cbfd 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -366,7 +366,7 @@ static bool is_suspended(struct mddev *mddev, struct bio
> *bio)
>         return true;
>  }
> 
> -void md_handle_request(struct mddev *mddev, struct bio *bio)
> +bool md_handle_request(struct mddev *mddev, struct bio *bio)
>  {
>  check_suspended:
>         if (is_suspended(mddev, bio)) {
> @@ -374,7 +374,7 @@ void md_handle_request(struct mddev *mddev, struct bio
> *bio)
>                 /* Bail out if REQ_NOWAIT is set for the bio */
>                 if (bio->bi_opf & REQ_NOWAIT) {
>                         bio_wouldblock_error(bio);
> -                       return;
> +                       return true;
>                 }
>                 for (;;) {
>                         prepare_to_wait(&mddev->sb_wait, &__wait,
> @@ -390,10 +390,14 @@ void md_handle_request(struct mddev *mddev, struct bio
> *bio)
> 
>         if (!mddev->pers->make_request(mddev, bio)) {
>                 percpu_ref_put(&mddev->active_io);
> +               if (!mddev->gendisk && mddev->pers->prepare_suspend &&
> +                   mddev->reshape_position != MaxSector)
> +                       return false;
>                 goto check_suspended;
>         }
> 
>         percpu_ref_put(&mddev->active_io);
> +       return true;
>  }
>  EXPORT_SYMBOL(md_handle_request);
> 
> @@ -8765,6 +8769,23 @@ void md_account_bio(struct mddev *mddev, struct bio
> **bio)
>  }
>  EXPORT_SYMBOL_GPL(md_account_bio);
> 
> +void md_free_cloned_bio(struct bio *bio)
> +{
> +       struct md_io_clone *md_io_clone = bio->bi_private;
> +       struct bio *orig_bio = md_io_clone->orig_bio;
> +       struct mddev *mddev = md_io_clone->mddev;
> +
> +       if (bio->bi_status && !orig_bio->bi_status)
> +               orig_bio->bi_status = bio->bi_status;
> +
> +       if (md_io_clone->start_time)
> +               bio_end_io_acct(orig_bio, md_io_clone->start_time);
> +
> +       bio_put(bio);
> +       percpu_ref_put(&mddev->active_io);
> +}
> +EXPORT_SYMBOL_GPL(md_free_cloned_bio);
> +
>  /* md_allow_write(mddev)
>   * Calling this ensures that the array is marked 'active' so that writes
>   * may proceed without blocking.  It is important to call this before
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8e81f9e2fb20..08db2954006e 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -763,6 +763,7 @@ extern void md_finish_reshape(struct mddev *mddev);
>  void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
>                         struct bio *bio, sector_t start, sector_t size);
>  void md_account_bio(struct mddev *mddev, struct bio **bio);
> +void md_free_cloned_bio(struct bio *bio);
> 
>  extern bool __must_check md_flush_request(struct mddev *mddev, struct bio
> *bio);
>  extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
> @@ -791,7 +792,7 @@ extern void md_stop_writes(struct mddev *mddev);
>  extern int md_rdev_init(struct md_rdev *rdev);
>  extern void md_rdev_clear(struct md_rdev *rdev);
> 
> -extern void md_handle_request(struct mddev *mddev, struct bio *bio);
> +extern bool md_handle_request(struct mddev *mddev, struct bio *bio);
>  extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>  extern void mddev_resume(struct mddev *mddev);
>  extern void md_idle_sync_thread(struct mddev *mddev);
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 812d7ec64da5..9a6a1d9eed3d 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -760,6 +760,7 @@ enum stripe_result {
>         STRIPE_RETRY,
>         STRIPE_SCHEDULE_AND_RETRY,
>         STRIPE_FAIL,
> +       STRIPE_WAIT_RESHAPE,
>  };
> 
>  struct stripe_request_ctx {
> @@ -6036,9 +6037,9 @@ static enum stripe_result make_stripe_request(struct
> mddev *mddev,
>  out:
>         if (ret == STRIPE_SCHEDULE_AND_RETRY && !mddev->gendisk &&
>             reshape_disabled(mddev)) {
> -               bi->bi_status = BLK_STS_IOERR;
> -               ret = STRIPE_FAIL;
> -               pr_err("dm-raid456: io failed across reshape position while
> reshape can't make progress");
> +               bi->bi_status = BLK_STS_RESOURCE;
> +               ret = STRIPE_WAIT_RESHAPE;
> +               pr_err_ratelimited("dm-raid456: io across reshape position
> while reshape can't make progress");
>         }
>         return ret;
>  }
> @@ -6161,7 +6162,7 @@ static bool raid5_make_request(struct mddev *mddev,
> struct bio * bi)
>         while (1) {
>                 res = make_stripe_request(mddev, conf, &ctx, logical_sector,
>                                           bi);
> -               if (res == STRIPE_FAIL)
> +               if (res == STRIPE_FAIL ||res == STRIPE_WAIT_RESHAPE)
>                         break;
> 
>                 if (res == STRIPE_RETRY)
> @@ -6199,8 +6200,13 @@ static bool raid5_make_request(struct mddev *mddev,
> struct bio * bi)
> 
>         if (rw == WRITE)
>                 md_write_end(mddev);
> -       bio_endio(bi);
> -       return true;
> +       if (res == STRIPE_WAIT_RESHAPE) {
> +               md_free_cloned_bio(bi);
> +               return false;
> +       } else {
> +               bio_endio(bi);
> +               return true;
> +       }
>  }
> 
> > +
> >   /* Return sync state string for @state */
> >   enum sync_state { st_frozen, st_reshape, st_resync, st_check, st_repair, st_recover, st_idle };
> >   static const char *sync_str(enum sync_state state)
> > @@ -4100,6 +4108,7 @@ static struct target_type raid_target = {
> >   	.ctr = raid_ctr,
> >   	.dtr = raid_dtr,
> >   	.map = raid_map,
> > +	.end_io = raid_end_io,
> >   	.status = raid_status,
> >   	.message = raid_message,
> >   	.iterate_devices = raid_iterate_devices,
> > =========================================================
> > > 
> > > 
> > > >    md: export helpers to stop sync_thread
> > > >    md: export helper md_is_rdwr()
> > > >    dm-raid: really frozen sync_thread during suspend
> > > >    md/dm-raid: don't call md_reap_sync_thread() directly
> > > >    dm-raid: add a new helper prepare_suspend() in md_personality
> > > >    md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> > > >      reshape
> > > >    dm-raid: fix lockdep waring in "pers->hot_add_disk"
> > > >    dm-raid: remove mddev_suspend/resume()
> > > > 
> > > >   drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
> > > >   drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
> > > >   drivers/md/md.h      |  16 ++++++
> > > >   drivers/md/raid10.c  |  16 +-----
> > > >   drivers/md/raid5.c   |  61 +++++++++++----------
> > > >   5 files changed, 192 insertions(+), 105 deletions(-)
> > > > 
> > > > --
> > > > 2.39.2
> > > > 
> > > > 
> > 
> > .
> > 


