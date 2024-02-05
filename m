Return-Path: <linux-kernel+bounces-53823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4D84A6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397141F29BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B795EE8C;
	Mon,  5 Feb 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPTqsTqF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25C5EE74
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161762; cv=none; b=V5bNC9vwzDeY33q5eYZKwAlhCoOOzbIDhxkqPBmS8OhrwvVErJiATnBdTh3uigXl0+sMnYTAYkRame9EpTKy+0FW6ln4E/rvgLxzxkgfvlDzPtKPzVWEolNvwJnS8wnTrfQgF3KVkBFLsuHT2mZt8018n7aTJ6dP+9e/+mwzj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161762; c=relaxed/simple;
	bh=I60Kbiz2eYDbo0Z4mIWuC/t1tOECDbiVgpLgXb4sXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgzcOwXVyqdxG9ft4xKSi1y0IjRyCeOVasYh+OmoNkBroDz8G5wT8coz5xSQdw+pEmfUE+6C8ghPcYkdfoL7jWilhLCTIl0zpibhz9gmp3cT0ZMWbNIBx36iAwWh4Q/z9ZaDOvCWDywcr4RJ75/SYEIO+CSeM5f1k7yP9haH0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPTqsTqF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707161759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilTY1dmg8mtueiwClLm1IE9zrHDO0gkI6KigsdPN0Fw=;
	b=MPTqsTqFtal7+T5NZ8eTT0IklNe/P2XiMj7ngEf+bO61YKngJC6JXgti10ecO+JgPzIpsm
	pdMxyG9Pq0GOXExQSkEXEmsmoWf243fhPjzHLPxpFLgQtpTekWeaWyUXXx/2zZ3vhh+yMk
	snAQXc9BO1Whw7BMiDlxZdoXPkrIdFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-ejG2862xMZylSOTuv236Hg-1; Mon, 05 Feb 2024 14:35:56 -0500
X-MC-Unique: ejG2862xMZylSOTuv236Hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0CB2185A784;
	Mon,  5 Feb 2024 19:35:54 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1C451D5;
	Mon,  5 Feb 2024 19:35:54 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with ESMTPS id 415JZrts137788
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 14:35:54 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id 415JZqkG137787;
	Mon, 5 Feb 2024 14:35:52 -0500
Date: Mon, 5 Feb 2024 14:35:52 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, xni@redhat.com,
        blazej.kucman@linux.intel.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
        neilb@suse.de, shli@fb.com, akpm@osdl.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
Message-ID: <ZcE4mGXCDwjqBXgf@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Sun, Feb 04, 2024 at 09:35:09AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/02/03 11:19, Benjamin Marzinski 写道:
> > On Thu, Feb 01, 2024 at 05:25:45PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > I apply this patchset on top of v6.8-rc1, and run lvm2 tests suite with
> > > folling cmd for 24 round(for about 2 days):
> > > 
> > > for t in `ls test/shell`; do
> > >          if cat test/shell/$t | grep raid &> /dev/null; then
> > >                  make check T=shell/$t
> > >          fi
> > > done
> > > 
> > > failed count                             failed test
> > >        1 ###       failed: [ndev-vanilla] shell/dmsecuretest.sh
> > >        1 ###       failed: [ndev-vanilla] shell/dmsetup-integrity-keys.sh
> > >        1 ###       failed: [ndev-vanilla] shell/dmsetup-keyring.sh
> > >        5 ###       failed: [ndev-vanilla] shell/duplicate-pvs-md0.sh
> > >        1 ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
> > >        2 ###       failed: [ndev-vanilla] shell/duplicate-vgnames.sh
> > >        1 ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
> > >        1 ###       failed: [ndev-vanilla] shell/integrity.sh
> > >        6 ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
> > >        2 ###       failed: [ndev-vanilla] shell/lvchange-rebuild-raid.sh
> > >        5 ###       failed: [ndev-vanilla] shell/lvconvert-raid-reshape-stripes-load-reload.sh
> > >        4 ###       failed: [ndev-vanilla] shell/lvconvert-raid-restripe-linear.sh
> > >        1 ###       failed: [ndev-vanilla] shell/lvconvert-raid1-split-trackchanges.sh
> > >       20 ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> > >       20 ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> > >       24 ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> > > 
> > > And I ramdomly pick some tests verified by hand that these test will
> > > fail in v6.6 as well(not all tests):
> > > 
> > > shell/lvextend-raid.sh
> > > shell/lvcreate-large-raid.sh
> > > shell/lvconvert-repair-raid.sh
> > > shell/lvchange-rebuild-raid.sh
> > > shell/lvchange-raid1-writemostly.sh
> > 
> > In my testing with this patchset on top of the head of linus's tree
> > (5c24e4e9e708) I am seeing failures in
> > shell/lvconvert-raid-reshape-stripes-load-reload.sh and
> > shell/lvconvert-repair-raid.sh in about 20% of my runs. I have never
> > seen either of these these fail running on the 6.6 kernel (ffc253263a13).
> 
> This sounds quite different in my testing, as I said, the test
> 
> shell/lvconvert-repair-raid.sh is very likely to fail in v6.6 already,
> I don't know why it never fail in your testing, test log in v6.6:
> 
> | [ 1:38.162] #lvconvert-repair-raid.sh:1+ aux teardown
> | [ 1:38.162] ## teardown.......## removing stray mapped devices with names
> beginning with LVMTEST3474:
> | [ 1:39.207] .set +vx; STACKTRACE; set -vx
> | [ 1:41.448] ##lvconvert-repair-raid.sh:1+ set +vx
> | [ 1:41.448] ## - /mnt/test/lvm2/test/shell/lvconvert-repair-raid.sh:1
> | [ 1:41.449] ## 1 STACKTRACE() called from
> /mnt/test/lvm2/test/shell/lvconvert-repair-raid.sh:1
> | [ 1:41.449] ## ERROR: The test started dmeventd (3718) unexpectedly.
> 
> And the same in v6.8-rc1. Perhaps do you know how to fix this error?

Could you run the test with something like

# make check_local T=lvconvert-repair-raid.sh VERBOSE=1 > out 2>&1

and post the output.

-Ben
 
> Thanks,
> Kuai
> 
> > 
> > lvconvert-repair-raid.sh creates a raid array and then disables one if
> > its drives before there's enough time to finish the initial sync and
> > tries to repair it. This is supposed to fail (it uses dm-delay devices
> > to slow down the sync). When the test succeeds, I see things like this:
> > 
> > [ 0:13.469] #lvconvert-repair-raid.sh:161+ lvcreate --type raid10 -m 1 -i 2 -L 64 -n LV1 LVMTEST191946vg /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv1 /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv2 /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv3 /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv4
> > [ 0:13.469]   Using default stripesize 64.00 KiB.
> > [ 0:13.483]   Logical volume "LV1" created.
> > [ 0:14.042] 6,8908,1194343108,-;device-mapper: raid: Superblocks created for new raid set
> > [ 0:14.042] 5,8909,1194348704,-;md/raid10:mdX: not clean -- starting background reconstruction
> > [ 0:14.042] 6,8910,1194349443,-;md/raid10:mdX: active with 4 out of 4 devices
> > [ 0:14.042] 4,8911,1194459161,-;mdX: bitmap file is out of date, doing full recovery
> > [ 0:14.042] 6,8912,1194563810,-;md: resync of RAID array mdX
> > [ 0:14.042]   WARNING: This metadata update is NOT backed up.
> > [ 0:14.042] aux disable_dev "$dev4"
> > [ 0:14.058] #lvconvert-repair-raid.sh:163+ aux disable_dev /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv4
> > [ 0:14.058] Disabling device /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv4 (253:5)
> > [ 0:14.101] not lvconvert -y --repair $vg/$lv1
> > 
> > When it fails, I see:
> > 
> > [ 0:13.831] #lvconvert-repair-raid.sh:161+ lvcreate --type raid10 -m 1 -i 2 -L 64 -n LV1 LVMTEST192248vg /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv1 /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv2 /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv3 /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv4
> > [ 0:13.831]   Using default stripesize 64.00 KiB.
> > [ 0:13.847]   Logical volume "LV1" created.
> > [ 0:14.499]   WARNING: This metadata update is NOT backed up.
> > [ 0:14.499] 6,8925,1187444256,-;device-mapper: raid: Superblocks created for new raid set
> > [ 0:14.499] 5,8926,1187449525,-;md/raid10:mdX: not clean -- starting background reconstruction
> > [ 0:14.499] 6,8927,1187450148,-;md/raid10:mdX: active with 4 out of 4 devices
> > [ 0:14.499] 6,8928,1187452472,-;md: resync of RAID array mdX
> > [ 0:14.499] 6,8929,1187453016,-;md: mdX: resync done.
> > [ 0:14.499] 4,8930,1187555486,-;mdX: bitmap file is out of date, doing full recovery
> > [ 0:14.499] aux disable_dev "$dev4"
> > [ 0:14.515] #lvconvert-repair-raid.sh:163+ aux disable_dev /tmp/LVMTEST192248.AT
> > cecgSGfE/dev/mapper/LVMTEST192248pv4
> > [ 0:14.515] Disabling device /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192
> > 248pv4 (253:5)
> > [ 0:14.554] not lvconvert -y --repair $vg/$lv1
> > 
> > To me the important looking difference (and I admit, I'm no RAID expert), is that in the
> > case where the test passes (where lvconvert fails as expected), I see
> > 
> > [ 0:14.042] 4,8911,1194459161,-;mdX: bitmap file is out of date, doing full recovery
> > [ 0:14.042] 6,8912,1194563810,-;md: resync of RAID array mdX
> > 
> > When it fails I see:
> > 
> > [ 0:14.499] 6,8928,1187452472,-;md: resync of RAID array mdX
> > [ 0:14.499] 6,8929,1187453016,-;md: mdX: resync done.
> > [ 0:14.499] 4,8930,1187555486,-;mdX: bitmap file is out of date, doing full recovery
> > 
> > Which appears to show a resync that takes no time, presumable because it happens before
> > the device notices that the bitmaps are wrong and schedules a full recovery.
> > 
> > 
> > lvconvert-raid-reshape-stripes-load-reload.sh repeatedly reloads the
> > device table during a raid reshape, and then tests the filesystem for
> > corruption afterwards. With this patchset, the filesystem is
> > occasionally corrupted.  I do not see this with the 6.6 kernel.
> > 
> > -Ben
> > > Xiao Ni also test the last version on a real machine, see [1].
> > > 
> > > [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com/
> > > 
> > > Yu Kuai (14):
> > >    md: don't ignore suspended array in md_check_recovery()
> > >    md: don't ignore read-only array in md_check_recovery()
> > >    md: make sure md_do_sync() will set MD_RECOVERY_DONE
> > >    md: don't register sync_thread for reshape directly
> > >    md: don't suspend the array for interrupted reshape
> > >    md: fix missing release of 'active_io' for flush
> > >    md: export helpers to stop sync_thread
> > >    md: export helper md_is_rdwr()
> > >    dm-raid: really frozen sync_thread during suspend
> > >    md/dm-raid: don't call md_reap_sync_thread() directly
> > >    dm-raid: add a new helper prepare_suspend() in md_personality
> > >    md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> > >      reshape
> > >    dm-raid: fix lockdep waring in "pers->hot_add_disk"
> > >    dm-raid: remove mddev_suspend/resume()
> > > 
> > >   drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
> > >   drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
> > >   drivers/md/md.h      |  16 ++++++
> > >   drivers/md/raid10.c  |  16 +-----
> > >   drivers/md/raid5.c   |  61 +++++++++++----------
> > >   5 files changed, 192 insertions(+), 105 deletions(-)
> > > 
> > > -- 
> > > 2.39.2
> > > 
> > 
> > .
> > 


