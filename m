Return-Path: <linux-kernel+bounces-94212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28D873B66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5C1C219F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9618135A67;
	Wed,  6 Mar 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUaidoa8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD815DF3C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740813; cv=none; b=cFreS/RoC70NAJzHDKASCOG5eme8qGSs8997v4DOELFmFojj/6uEZV3mNJ+v3wnrNeQlmx/p90TSUfO91QpVTK+XZalYoGOaBqE/w/L2/VywWZDP7ZlP2kIYcQyVEsIHQjIO0/ewF+iWbqaH4LYyIez9fz/y/gxHH+gxeBcJEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740813; c=relaxed/simple;
	bh=yErQmxsqshrBcM8l6AwNJI7JsDiBKwPq6xd5fRjHqwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReRwn8GHylXepzeXKzeOGlzZGurpIVYdbkz5pwlvhOtTAFSQPiKJ4F9zq5jWfxtfi11b53smEZ25rtGx7uQekVz726Gl6hJsaXrArL7KAQlWwj5w5khGyQiwE9EpSR3Lk1ZvA2mmayKK0obos8HamqEyxF5sQYLjjCho8rO7Glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUaidoa8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709740810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIIdw8ckHvVn5igXTzUjHRLg6rvzXoUvv9uYoYgw/8Q=;
	b=NUaidoa8pyoMf/h2TS5oJDfPIGfdPRjRl+lWMQbckUrEIUiouTZMAHGL1Pv7Uk4ZtvooY9
	PRBjpGnv61nkAa0fdBdRlo9a9Lt/DJBJGpzWEyCdxc+Ia/eDqDrd6cCPm2Ppen1nBuxm1m
	VgV/UiF4InMmji/dzpeuSt5Pb5JzbrY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-VkHvEyVUPY-rUx7UgScF8w-1; Wed,
 06 Mar 2024 11:00:08 -0500
X-MC-Unique: VkHvEyVUPY-rUx7UgScF8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 184761C54062;
	Wed,  6 Mar 2024 16:00:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6165D200AD5B;
	Wed,  6 Mar 2024 16:00:01 +0000 (UTC)
Date: Wed, 6 Mar 2024 23:59:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>,
	Patrick Plenefisch <simonpatp@gmail.com>
Cc: Goffredo Baroncelli <kreijack@inwind.it>, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	regressions@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: LVM-on-LVM: error while submitting device barriers
Message-ID: <ZeiS/bjJaRcrerWW@fedora>
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
 <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
 <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>
 <ZedaKUge-EBo4CuT@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZedaKUge-EBo4CuT@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Mar 05, 2024 at 12:45:13PM -0500, Mike Snitzer wrote:
> On Thu, Feb 29 2024 at  5:05P -0500,
> Goffredo Baroncelli <kreijack@inwind.it> wrote:
> 
> > On 29/02/2024 21.22, Patrick Plenefisch wrote:
> > > On Thu, Feb 29, 2024 at 2:56 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> > > > 
> > > > > Your understanding is correct. The only thing that comes to my mind to
> > > > > cause the problem is asymmetry of the SATA devices. I have one 8TB
> > > > > device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
> > > > > extents, lowerVG/single spans (3TB+3TB), and
> > > > > lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
> > > > > the other leg of raid1 on the 8TB drive, but my thought was that the
> > > > > jump across the 1.5+3TB drive gap was at least "interesting"
> > > > 
> > > > 
> > > > what about lowerVG/works ?
> > > > 
> > > 
> > > That one is only on two disks, it doesn't span any gaps
> > 
> > Sorry, but re-reading the original email I found something that I missed before:
> > 
> > > BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> > > 0, rd 0, flush 1, corrupt 0, gen 0
> > > BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
> >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > tolerance is 0 for writable mount
> > > BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
> > > failure (errors while submitting device barriers.)
> > 
> > Looking at the code, it seems that if a FLUSH commands fails, btrfs
> > considers that the disk is missing. The it cannot mount RW the device.
> > 
> > I would investigate with the LVM developers, if it properly passes
> > the flush/barrier command through all the layers, when we have an
> > lvm over lvm (raid1). The fact that the lvm is a raid1, is important because
> > a flush command to be honored has to be honored by all the
> > devices involved.

Hello Patrick & Goffredo,

I can trigger this kind of btrfs complaint by simulating one FLUSH failure.

If you can reproduce this issue easily, please collect log by the
following bpftrace script, which may show where the flush failure is,
and maybe it can help to narrow down the issue in the whole stack.


#!/usr/bin/bpftrace

#ifndef BPFTRACE_HAVE_BTF
#include <linux/blkdev.h>
#endif

kprobe:submit_bio_noacct,
kprobe:submit_bio
/ (((struct bio *)arg0)->bi_opf & (1 << __REQ_PREFLUSH)) != 0 /
{
	$bio = (struct bio *)arg0;
	@submit_stack[arg0] = kstack;
	@tracked[arg0] = 1;
}

kprobe:bio_endio
/@tracked[arg0] != 0/
{
	$bio = (struct bio *)arg0;

	if (($bio->bi_flags & (1 << BIO_CHAIN)) && $bio->__bi_remaining.counter > 1) {
		return;
	}

	if ($bio->bi_status != 0) {
		printf("dev %s bio failed %d, submitter %s completion %s\n",
			$bio->bi_bdev->bd_disk->disk_name,
			$bio->bi_status, @submit_stack[arg0], kstack);
	} 
	delete(@submit_stack[arg0]);
	delete(@tracked[arg0]);
}

END {
	clear(@submit_stack);
	clear(@tracked);
}



Thanks, 
Ming


