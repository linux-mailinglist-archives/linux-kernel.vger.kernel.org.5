Return-Path: <linux-kernel+bounces-68081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E218575BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E892E1C225EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912C14AA3;
	Fri, 16 Feb 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbwL9vnG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E514A85
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062403; cv=none; b=XFJDL39dzGlJmTFjUApHXlqyuH4ZzlVSkcZw3zNKiF/rKcemUpyGsaxbFo4QRm+B8KkBoXwoxyBpvIgHNZbsiCFDqXcbepO+GpL//+3vBeQlCrZSDByhq205YIj9/IFoNqP+Q5wCXilRvCXn/VEn0d6aI1gciPZLxblpJpJTUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062403; c=relaxed/simple;
	bh=xnES3SSIK1U2gP1DxNv1Vj/LpwvbOrQvXcC7yiLSyIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5I6rjaGohV1Whx1f5ZFNJiRz6CjaaTUVkXfGJ4f5EtAqetdKMfhzjEyQqvtEZgxxO9o+4etrcFdqsBJfZutEUWr3cVb5oZVDRUiQD+3aKRL5RSigGiWppFp0oMU9oYFq+s2cVBXiui2WngZPS7L+7KltzV28Z6QMrast00Cn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbwL9vnG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708062399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec9GQsV+tymXJStq1MxqZ2ua4Wrdy4hZxhXXYKvTEEw=;
	b=PbwL9vnGAOSUcfmPiM6ynIqII4ODgqTP5nQZd6pvKBwALzIhJrdsi70nDdxi2cqrNdi7MA
	2MDIPFSEsKicfu4kku/5AxKek/hh9RS+beYQBBDwqq+jCN60zSta3eFMoIGbK4gu7PeVd6
	PdgWLBp1V41SbArfUGUBTe0ZlRyUzGI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-ia91x7MMNMygHbE1etbllg-1; Fri, 16 Feb 2024 00:46:36 -0500
X-MC-Unique: ia91x7MMNMygHbE1etbllg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 323D710201E7;
	Fri, 16 Feb 2024 05:46:36 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ADC8C1596E;
	Fri, 16 Feb 2024 05:46:35 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with ESMTPS id 41G5kZ5K434328
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:46:35 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id 41G5kXiI434326;
	Fri, 16 Feb 2024 00:46:33 -0500
Date: Fri, 16 Feb 2024 00:46:33 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com, heinzm@redhat.com,
        xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev, yukuai3@huawei.com,
        jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
Message-ID: <Zc72uQln4bXothru@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Feb 15, 2024 at 02:24:34PM -0800, Song Liu wrote:
> On Thu, Feb 1, 2024 at 1:30 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >
> [...]
> >
> > [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com/
> >
> > Yu Kuai (14):
> >   md: don't ignore suspended array in md_check_recovery()
> >   md: don't ignore read-only array in md_check_recovery()
> >   md: make sure md_do_sync() will set MD_RECOVERY_DONE
> >   md: don't register sync_thread for reshape directly
> >   md: don't suspend the array for interrupted reshape
> >   md: fix missing release of 'active_io' for flush
> 
> Applied 1/14-5/14 to md-6.8 branch (6/14 was applied earlier).
> 
> Thanks,
> Song

I'm still seeing new failures that I can't reproduce in the 6.6 kernel,
specifically:

lvconvert-raid-reshape-stripes-load-reload.sh
lvconvert-repair-raid.sh

with lvconvert-raid-reshape-stripes-load-reload.sh Patch 12/14
("md/raid456: fix a deadlock for dm-raid456 while io concurrent with
reshape") is changing a hang to a corruption. The issues is that we
can't simply fail IO that crosses the reshape position. I assume that
the correct thing to do is have dm-raid reissue it after the suspend,
when the reshape can make progress again. Perhaps something like this,
only less naive (although this patch does make the test pass for me).
Heinz, any thoughts on this? Otherwise, I'll look into this a little
more and post a RFC patch.

=========================================================
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index ed8c28952b14..ff481d494b04 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3345,6 +3345,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_SUBMITTED;
 }
 
+static int raid_end_io(struct dm_target *ti, struct bio *bio,
+		       blk_status_t *error)
+{
+	if (*error != BLK_STS_IOERR || !dm_noflush_suspending(ti))
+		return DM_ENDIO_DONE;
+	return DM_ENDIO_REQUEUE;
+}
+
 /* Return sync state string for @state */
 enum sync_state { st_frozen, st_reshape, st_resync, st_check, st_repair, st_recover, st_idle };
 static const char *sync_str(enum sync_state state)
@@ -4100,6 +4108,7 @@ static struct target_type raid_target = {
 	.ctr = raid_ctr,
 	.dtr = raid_dtr,
 	.map = raid_map,
+	.end_io = raid_end_io,
 	.status = raid_status,
 	.message = raid_message,
 	.iterate_devices = raid_iterate_devices,
=========================================================
> 
> 
> >   md: export helpers to stop sync_thread
> >   md: export helper md_is_rdwr()
> >   dm-raid: really frozen sync_thread during suspend
> >   md/dm-raid: don't call md_reap_sync_thread() directly
> >   dm-raid: add a new helper prepare_suspend() in md_personality
> >   md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> >     reshape
> >   dm-raid: fix lockdep waring in "pers->hot_add_disk"
> >   dm-raid: remove mddev_suspend/resume()
> >
> >  drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
> >  drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
> >  drivers/md/md.h      |  16 ++++++
> >  drivers/md/raid10.c  |  16 +-----
> >  drivers/md/raid5.c   |  61 +++++++++++----------
> >  5 files changed, 192 insertions(+), 105 deletions(-)
> >
> > --
> > 2.39.2
> >
> >


