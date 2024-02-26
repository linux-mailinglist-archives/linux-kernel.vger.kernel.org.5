Return-Path: <linux-kernel+bounces-82125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13154867FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D9C28E9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E812F36D;
	Mon, 26 Feb 2024 18:13:11 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0473C604A7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971191; cv=none; b=hAt35xcvpz7yYI82xHvxx2vGm39Ia025RPRl5Y6T46P1PSsPjNRT9ldZyltclQMYcC05rKp915xF9TNn0RGx5QZvypBhZ65Qkn68hNXgllYHqre1Fx6Cyo/66lL6QvRHgTrgHpKMu7te1glfdFhx0AUcNBa2EBPpeW4Cu1lXL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971191; c=relaxed/simple;
	bh=bGVzXfqLQhGpM8schnRSrwLEEAcEF5Ccp60yUJd38R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMmz1MXGLOjM/o6MuGpVl3EOFRckPKNXHfJdEEoDCSeXavoD7gRtZFmXtrQfpb7LlvJev3Rp93g0VK7wrQFQsvDJ76BQDPIcpCyYIxZ1FfwAvgW+I4IEA2Zqbe52b1fxmX2loFQ9pPjBJX5OjQGxx7a/oCtarYhtc16jPGBzNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 738450 invoked by uid 1000); 26 Feb 2024 13:13:01 -0500
Date: Mon, 26 Feb 2024 13:13:01 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
  bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
  tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
Message-ID: <9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu>
References: <0000000000003eb868061245ba7f@google.com>
 <99b0fb1b-37b3-4da4-8129-e502ed8e479a@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b0fb1b-37b3-4da4-8129-e502ed8e479a@suse.com>

On Mon, Feb 26, 2024 at 11:59:06AM +0100, Oliver Neukum wrote:
> Hi,
> 
> On 26.02.24 10:42, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=114e10e4180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=28748250ab47a8f04100
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1064b372180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aca6ac180000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c55ca1fdc5ad/disk-f2e367d6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4556a82fb4ed/vmlinux-f2e367d6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/95338ed9dad1/bzImage-f2e367d6.xz
> > 
> > The issue was bisected to:
> > 
> > commit 321da3dc1f3c92a12e3c5da934090d2992a8814c
> > Author: Martin K. Petersen <martin.petersen@oracle.com>
> > Date:   Tue Feb 13 14:33:06 2024 +0000
> > 
> >      scsi: sd: usb_storage: uas: Access media prior to querying device properties
> 
> preliminary analysis:
> 
> It oopses here:
> 
> 		} else {
> 			if (!id[ATA_ID_SECTORS] || !id[ATA_ID_HEADS])
> 				goto too_early;

Those two lines are debugging code you added, right?

> 			sectnum = (u8)((lba % id[ATA_ID_SECTORS]) + 1);
> 			cylinder = (u16)(lba / (id[ATA_ID_SECTORS] *
> 					id[ATA_ID_HEADS]));
> 
> in isd200_scsi_to_ata() because it must not be called before isd200_get_inquiry_data()
> has completed.

It can't be; isd200_get_inquiry_data is called by isd200_Initialization 
during probe before any SCSI commands are transmitted.

> That raises two questions.
> 
> 1) should we limit the read_before_ms flag to the cases transparent SCSI is used?

That won't help; the inquiry data will still be wrong.

> 2) does isd200_get_inquiry_data() need to validate what it reads?

Yes.  At least to make sure that we're not going to divide by 0.  This 
means that id[ATA_ID_SECTORS] and id[ATA_ID_HEADS] must both be > 0.  
Since they are 16-bit quantities, we don't have to worry about them 
overflowing.

Do you want to submit a fix for syzbot to test?

Alan Stern


