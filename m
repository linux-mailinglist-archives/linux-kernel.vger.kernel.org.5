Return-Path: <linux-kernel+bounces-97597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84685876C59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39712281809
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF04085D;
	Fri,  8 Mar 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NhY887xU"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2353373
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932938; cv=none; b=kZnQ+KEsza2zqEw64VKPg4o6VNBy5OmVB+4vyWuOEms4YxyKTQL+S8yDrALTqlI6Vk8VCJjnsyV/OV9ZcjUs+bB8zwOqW2Jyy8xjLIMq37rDYxkQO06NqDPZ4vqhWXwJxeGMtBgb0jNHuicbEHxWHpoSUOnhxZv4fY5pIYMi/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932938; c=relaxed/simple;
	bh=etIcExCJKSr7h1nDa+rmExMmNvZNyxCOFxa/98KM4ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4o9BNWj2SHCHQ3/8S7TW2TRhsgQJdRkSRcLxmMNDTdiqZKgByMxggp1FBSCpw91lpDA1MCpE31O0ahdjJWIaxMmp1lHdqlV+4o4eRDdytRP9X6cfg1mxyk3NCcbsVaXh5Jz6wSd/8v6dwNmJHBrt8LRnpKHWrCnBCifzmdd4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NhY887xU; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7dae66def19so1256446241.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709932934; x=1710537734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XL80Q/LEC1hNeoVDgvQ1NRtgFUnKBazWk6zXTz/pdtI=;
        b=NhY887xUlHxzJTnVnQXjma5B4qLWCsH6xC6Bz6pbtSQRhqKpnSVUCdT64gDNUu0tCj
         cKNGa3WyXiSe7PPj0blKh80bnr80pfuwNKuLElHh68m1RaDjhFHMJcuDj45bVPL5hlJL
         mRzGnPOcXy5U+kdrGloZLt3YtUSlKn5aouelti8l77X4z9fIAo5omIFh9/WxNvJYRIAf
         jzsMj5RuowMLtIorTyYBC4s8ZvhQm0ZhOPsM0Mwu/Uchg5lXfuov5Pw2RxTN3FusY0ll
         LH+LsGB+9/w0lbZRpNtqMMJDg7tSd5zrAuqo6rkGqIrvuNVi4EmWbXCr+YVrhkcYm79w
         PGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709932934; x=1710537734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XL80Q/LEC1hNeoVDgvQ1NRtgFUnKBazWk6zXTz/pdtI=;
        b=eG0ugggQRyi0b1sRbehj1O16pLmRcGEzTMRXziw672d0ait8aPfrQ3PX0/iva9O0ZU
         KJZ8P0e1LV2t9Ur52NpFM9LChz/8D8uZuk83KlOZAgC0osolCRhSMiBtmp+lTJf9Qq0I
         U4sz0vUj64rJrv/bdg+T5qSE16BXiT2Knjl81OCrbiXhVYtsmKENiS5/sYuUYNZk215R
         CcLymn/gLrRtEk1UZeeF8ha9Pw11J+usGPKgaqaRbKNwPgfPycDPiSoh5H7DDrzae2Jd
         CXTfUCqoNE0tcqmd+8TRrzx3aFfemubqGf9aJAu6HehCN6f45NSMnZSxE4OYeRgwYJnK
         DXMA==
X-Forwarded-Encrypted: i=1; AJvYcCWQQsi33MhSFAwv+hyGGdTUpo/VZEt4K2dOjL5TiGN2qvdxZ2z3Ki8H5QyOTeVlQrWNTWhqLnzW351kNbEsqpVSzl3fAwwFMCM7HssT
X-Gm-Message-State: AOJu0Yz7J9uRA/WxvmD0gkbnXZwM45rpM92NE+cur/aMWLN6PrvKyYr5
	9oWyCeXdVbv3UYaDiKABxNIxZ7BscqkqO9BDMeB/KGexpzXLOJFpWdUyQ4chEhI=
X-Google-Smtp-Source: AGHT+IEwQHXBgf936c0Xa021NeRFaNfDWXzdfuhZY3RXu2CzjdaZ96VxQTmJPXIO3pIeRXQSm9EaYQ==
X-Received: by 2002:a05:6122:1784:b0:4d1:4e40:bd6f with SMTP id o4-20020a056122178400b004d14e40bd6fmr592980vkf.10.1709932933927;
        Fri, 08 Mar 2024 13:22:13 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ej5-20020ad45a45000000b0068fc8e339b8sm122593qvb.136.2024.03.08.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:22:13 -0800 (PST)
Date: Fri, 8 Mar 2024 16:22:12 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
	kernel-team@fb.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, yuzhao@google.com
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <20240308212212.GA38843@cmpxchg.org>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>

On Fri, Mar 08, 2024 at 11:18:28AM -0800, Axel Rasmussen wrote:
> On Thu, Feb 29, 2024 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
> >
> > Axel Rasmussen writes:
> > >A couple of dumb questions. In your test, do you have any of the following
> > >configured / enabled?
> > >
> > >/proc/sys/vm/laptop_mode
> > >memory.low
> > >memory.min
> >
> > None of these are enabled. The issue is trivially reproducible by writing to
> > any slow device with memory.max enabled, but from the code it looks like MGLRU
> > is also susceptible to this on global reclaim (although it's less likely due to
> > page diversity).
> >
> > >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> > >flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
> > >Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
> > >looks like it simply will not do this.
> > >
> > >Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
> > >makes sense to me at least that doing writeback every time we age is too
> > >aggressive, but doing it in evict_folios() makes some sense to me, basically to
> > >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> >
> > Thanks! We may also need reclaim_throttle(), depending on how you implement it.
> > Current non-MGLRU behaviour on slow storage is also highly suspect in terms of
> > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, but one
> > thing at a time :-)
> 
> 
> Hmm, so I have a patch which I think will help with this situation,
> but I'm having some trouble reproducing the problem on 6.8-rc7 (so
> then I can verify the patch fixes it).
> 
> If I understand the issue right, all we should need to do is get a
> slow filesystem, and then generate a bunch of dirty file pages on it,
> while running in a tightly constrained memcg. To that end, I tried the
> following script. But, in reality I seem to get little or no
> accumulation of dirty file pages.
> 
> I thought maybe fio does something different than rsync which you said
> you originally tried, so I also tried rsync (copying /usr/bin into
> this loop mount) and didn't run into an OOM situation either.
> 
> Maybe some dirty ratio settings need tweaking or something to get the
> behavior you see? Or maybe my test has a dumb mistake in it. :)
> 
> 
> 
> #!/usr/bin/env bash
> 
> echo 0 > /proc/sys/vm/laptop_mode || exit 1
> echo y > /sys/kernel/mm/lru_gen/enabled || exit 1
> 
> echo "Allocate disk image"
> IMAGE_SIZE_MIB=1024
> IMAGE_PATH=/tmp/slow.img
> dd if=/dev/zero of=$IMAGE_PATH bs=1024k count=$IMAGE_SIZE_MIB || exit 1
> 
> echo "Setup loop device"
> LOOP_DEV=$(losetup --show --find $IMAGE_PATH) || exit 1
> LOOP_BLOCKS=$(blockdev --getsize $LOOP_DEV) || exit 1
> 
> echo "Create dm-slow"
> DM_NAME=dm-slow
> DM_DEV=/dev/mapper/$DM_NAME
> echo "0 $LOOP_BLOCKS delay $LOOP_DEV 0 100" | dmsetup create $DM_NAME || exit 1
> 
> echo "Create fs"
> mkfs.ext4 "$DM_DEV" || exit 1
> 
> echo "Mount fs"
> MOUNT_PATH="/tmp/$DM_NAME"
> mkdir -p "$MOUNT_PATH" || exit 1
> mount -t ext4 "$DM_DEV" "$MOUNT_PATH" || exit 1
> 
> echo "Generate dirty file pages"
> systemd-run --wait --pipe --collect -p MemoryMax=32M \
>         fio -name=writes -directory=$MOUNT_PATH -readwrite=randwrite \
>         -numjobs=10 -nrfiles=90 -filesize=1048576 \
>         -fallocate=posix \
>         -blocksize=4k -ioengine=mmap \
>         -direct=0 -buffered=1 -fsync=0 -fdatasync=0 -sync=0 \
>         -runtime=300 -time_based

By doing only the writes in the cgroup, you might just be running into
balance_dirty_pages(), which wakes the flushers and slows the
writing/allocating task before hitting the cg memory limit.

I think the key to what happens in Chris's case is:

1) The cgroup has a certain share of dirty pages, but in aggregate
they are below the cgroup dirty limit (dirty < mdtc->avail * ratio)
such that no writeback/dirty throttling is triggered from
balance_dirty_pages().

2) An unthrottled burst of (non-dirtying) allocations causes reclaim
demand that suddenly exceeds the reclaimable clean pages on the LRU.

Now you get into a situation where allocation and reclaim rate exceeds
the writeback rate and the only reclaimable pages left on the LRU are
dirty. In this case reclaim needs to wake the flushers and wait for
writeback instead of blowing through the priority cycles and OOMing.

Chris might be causing 2) from the read side of the copy also being in
the cgroup. Especially if he's copying larger files that can saturate
the readahead window and cause bigger allocation bursts. Those
readahead pages are accounted to the cgroup and on the LRU as soon as
they're allocated, but remain locked and unreclaimable until the read
IO finishes.

