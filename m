Return-Path: <linux-kernel+bounces-85590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A367186B813
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576A31F2295E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F574423;
	Wed, 28 Feb 2024 19:23:28 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id F1A7F71EB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148207; cv=none; b=KvlZaFGa3d80JjlCxJEaDQl0CB8t/g6kc5qdc7CxfTvVR5GPY0p5zd+WYEhIkIRAPnPEwG3awwYcn31Mc/e4ntupktBTVTEh7jd48+9uaCLGKgpUpMYv6bi1xmxSvVEqTQYT18b4tyQ5WoWhigBloM6XPtGF1z3raahxvFIHSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148207; c=relaxed/simple;
	bh=/ob7M7yrfVFKdy3ZAyUsgLJVGAIkaDCnpFHpEHTPS/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUY1Zx6qhne/8fjmnuDKcrr0zINHl0NgwIyAuNRZm6WwOSuWr18IRLgsEqWTl6j0EXHqWDOUKBonkoelHoGyOvWFj1RdX4M6wO8z7BeYwGd6xsi3K+uB3Z3zp9izpbWVgzVGRSmku27S3g+oFiUZAj9lGel08Wk4LYRHh2URm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 803267 invoked by uid 1000); 28 Feb 2024 14:23:25 -0500
Date: Wed, 28 Feb 2024 14:23:25 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
  bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
  tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
Message-ID: <d5328312-4cd0-426f-8db4-29d67790c213@rowland.harvard.edu>
References: <0000000000003eb868061245ba7f@google.com>
 <99b0fb1b-37b3-4da4-8129-e502ed8e479a@suse.com>
 <9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu>
 <12b30393-0b4b-400e-828b-231901d8933b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b30393-0b4b-400e-828b-231901d8933b@suse.com>

On Wed, Feb 28, 2024 at 05:20:29PM +0100, Oliver Neukum wrote:
> On 26.02.24 19:13, Alan Stern wrote:
> 
> > > It oopses here:
> > > 
> > > 		} else {
> > > 			if (!id[ATA_ID_SECTORS] || !id[ATA_ID_HEADS])
> > > 				goto too_early;
> > 
> > Those two lines are debugging code you added, right?
> 
> Yes, sorry about that.
> 
> > 
> > > 			sectnum = (u8)((lba % id[ATA_ID_SECTORS]) + 1);
> > > 			cylinder = (u16)(lba / (id[ATA_ID_SECTORS] *
> > > 					id[ATA_ID_HEADS]));
> > > 
> > > in isd200_scsi_to_ata() because it must not be called before isd200_get_inquiry_data()
> > > has completed.
> > 
> > It can't be; isd200_get_inquiry_data is called by isd200_Initialization
> > during probe before any SCSI commands are transmitted.
> 
> So, you are concluding that the bisection is spurious because
> without that patch the SCSI layer would see a capacity of zero
> and not even try to read anything?

I don't know.  My guess is that without this patch, the test would fail 
for some reason before the SCSI layer has a chance to issue a READ command.  
Maybe because of a zero capacity, like you said, or maybe something 
else.

Whatever the reason, it looks like Martin's commit merely exposed a 
problem which has existed all along.

Alan Stern

