Return-Path: <linux-kernel+bounces-71638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD385A82C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187441C213B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFEB3CF53;
	Mon, 19 Feb 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKzJlsue"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0213399C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358746; cv=none; b=nOIWJlCDzQRTa4PUGjoKIRv975Ujp+f++bNtiVXU6PP54/pcoNU58Pf/fRUaF2NohjxbYDSsut3zEdGMWFJ0Ny4yKgTR2Klz4u12raS9574gYnWcmCbPPknuiGjrvifZdqeuyff0p2+d97mvwuvhg5Rigoeychx31oS/IcieC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358746; c=relaxed/simple;
	bh=YOb37R9t5QawZ6b9s7bPcOTSe9eOHUP6+CzZcAC6z7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfrqKjQ1jH12iGrt8nmud8kfzFcwNIjDfyjyk3tUyA66opN4wsdoOAPssUaGxk8c+RMRS2xVuHkTMwlOgf3jHfgKJw5Qiz0qeZWgMGWgV9OP2HS8yykcyz8pzFd7oRGfPuD0Uv/aZM+L+gzfT9X4x7DsURA4LnkpzrH88xRGIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKzJlsue; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708358743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkvDh7CLaezwgjxId5iWqRkNYyhAJAwpmVWnj2FWCMw=;
	b=aKzJlsueYbD9yKuvX7fEt/CKZqYrMrp3DY3vC4U0A+aeD8e4DFusL5+AY/Ha4wNAbDeW5K
	63nM8Jyyyop8PuSofejqqhN0YBlGbp4d4Ac7lmQInsWJLnQdfaDvLOVTXXBvi69i6LBbkP
	IDPEpps6ZT7LpOa7XEBXnrIwpsk1TwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-0vqBr0j7NGiOD3j_eyVUBg-1; Mon, 19 Feb 2024 11:05:39 -0500
X-MC-Unique: 0vqBr0j7NGiOD3j_eyVUBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D407185A781;
	Mon, 19 Feb 2024 16:05:39 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CC6351C02E2A;
	Mon, 19 Feb 2024 16:05:38 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with ESMTPS id 41JG5cnH476261
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 11:05:38 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id 41JG5bWs476260;
	Mon, 19 Feb 2024 11:05:37 -0500
Date: Mon, 19 Feb 2024 11:05:37 -0500
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
Message-ID: <ZdN8USOlyKRLVNgj@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
 <Zc72uQln4bXothru@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <b969c17d-3330-49c9-fb32-60156325949e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b969c17d-3330-49c9-fb32-60156325949e@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Sun, Feb 18, 2024 at 09:24:31AM +0800, Yu Kuai wrote:
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
> 
> Does the corruption looks like below?

There isn't a kernel stack trace.  The test
lvconvert-raid-reshape-stripes-load-reload.sh does some IO to a
filesytem on top of a raid device, and then starts a reshape, and
repeatedly suspends the device. After all that, it runs fsck to see if
the filesystem is clean, and on runs where I see "dm-raid456: io failed
across reshape position while reshape can't make progress" I see
filesystem errors:

------------------------------------------------------------------
[ 0:25.219] fsck from util-linux 2.39.2
[ 0:25.224] e2fsck 1.47.0 (5-Feb-2023)
[ 0:25.232] Warning: skipping journal recovery because doing a read-only
filesystem check.
[ 0:25.233] Pass 1: Checking inodes, blocks, and sizes
[ 0:25.233] Pass 2: Checking directory structure
[ 0:25.234] Pass 3: Checking directory connectivity
[ 0:25.234] Pass 4: Checking reference counts
[ 0:25.234] Pass 5: Checking group summary information
[ 0:25.234] Feature orphan_present is set but orphan file is clean.
[ 0:25.235] Clear? no
[ 0:25.235] 
[ 0:25.235] 
[ 0:25.235] /tmp/LVMTEST35943.Iuo9Ro5tCY/dev/mapper/LVMTEST35943vg-LV1:
********** WARNING: Filesystem still has errors **********
[ 0:25.235] 
[ 0:25.235] /tmp/LVMTEST35943.Iuo9Ro5tCY/dev/mapper/LVMTEST35943vg-LV1:
13/2560 files (0.0% non-contiguous), 5973/10240 blocks
------------------------------------------------------------------

O.k. corruption is too strong a word. Lets just call it a filesystem
that got a write error, and now is in an unclean state according to
fsck. I'm pretty sure that this is recoverable.

> [12504.959682] BUG bio-296 (Not tainted): Object already free
> [12504.960239]
> -----------------------------------------------------------------------------
> [12504.960239]
> [12504.961209] Allocated in mempool_alloc+0xe8/0x270 age=30 cpu=1 pid=203288
> [12504.961905]  kmem_cache_alloc+0x36a/0x3b0
> [12504.962324]  mempool_alloc+0xe8/0x270
> [12504.962712]  bio_alloc_bioset+0x3b5/0x920
> [12504.963129]  bio_alloc_clone+0x3e/0x160
> [12504.963533]  alloc_io+0x3d/0x1f0
> [12504.963876]  dm_submit_bio+0x12f/0xa30
> [12504.964267]  __submit_bio+0x9c/0xe0
> [12504.964639]  submit_bio_noacct_nocheck+0x25a/0x570
> [12504.965136]  submit_bio_wait+0xc2/0x160
> [12504.965535]  blkdev_issue_zeroout+0x19b/0x2e0
> [12504.965991]  ext4_init_inode_table+0x246/0x560
> [12504.966462]  ext4_lazyinit_thread+0x750/0xbe0
> [12504.966922]  kthread+0x1b4/0x1f0
> 
> I assum that this is a dm problem and I'm still trying to debug it.
> Can you explain more why IO that crosses the reshape position can't
> fail directly?

Maybe I'm missing something here, but if the filesystem is trying to
write out data to the device, and we fail that IO, why would that not
cause problems, whatever we call it? 

[ 0:18.792] 3,6342,47220996156,-;dm-raid456: io failed across reshape
position while reshape can't make progress
[ 0:18.792] 3,6343,47220996182,-;Aborting journal on device dm-39-8.
[ 0:18.792] 3,6344,47221411730,-;dm-raid456: io failed across reshape
position while reshape can't make progress
[ 0:18.792] 3,6345,47221411746,-;Buffer I/O error on dev dm-39, logical
block 740, lost sync page write
[ 0:18.792] 3,6346,47221416194,-;JBD2: I/O error when updating journal
superblock for dm-39-8.

Does this test not fail for you? Or does it simply also fail in the 6.6
kernel.

-Ben
 
> Thanks,
> Kuai
> 
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


