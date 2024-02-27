Return-Path: <linux-kernel+bounces-82638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441D868781
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC985282C24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849471BC27;
	Tue, 27 Feb 2024 03:05:09 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 294FE17727
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003109; cv=none; b=CvqFfZgbOSkPitorkQcQg17ELucUtDXOZ8wxmg+k1scI0VaAY9YVROBULrXlP553abWqXaf4DclCdX9GaPnvyO4Uhp4+dOZ32eMJ2vY/i5g25xxXG69scWttsFkrD1jQqARyHwcvU+ceN4XOc335GzJbSE7aZJvac7AcfGar8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003109; c=relaxed/simple;
	bh=flJpjWg4G590GoBdzqL83kC4185Wq8tCMo9iI0foqpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usRpvHHzwkbP4fRsceyYj0XMSUCL+VQ7hSb8vwosIqw2VcFe+AX9EmmwN7ECWRYoccSQSj7TEVP4q7XywjnTE+Dk+3Rv0Mz4zlFubkZt45Qts3a1+MMGgoh6ewpW9iWBOpVwkaldZY1Vx8fADDUVVHGEGPCvCsy+IMEUwrUzqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 753798 invoked by uid 1000); 26 Feb 2024 22:05:06 -0500
Date: Mon, 26 Feb 2024 22:05:06 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Oliver Neukum <oneukum@suse.com>,
  syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
  bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  syzkaller-bugs@googlegroups.com, tasos@tasossah.com,
  usb-storage@lists.one-eyed-alien.net
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
Message-ID: <11ec2091-71c2-4dfb-be36-0cc21be32109@rowland.harvard.edu>
References: <0000000000003eb868061245ba7f@google.com>
 <99b0fb1b-37b3-4da4-8129-e502ed8e479a@suse.com>
 <9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu>
 <yq1cysi4obq.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1cysi4obq.fsf@ca-mkp.ca.oracle.com>

On Mon, Feb 26, 2024 at 09:46:39PM -0500, Martin K. Petersen wrote:
> 
> Alan,
> 
> >> in isd200_scsi_to_ata() because it must not be called before
> >> isd200_get_inquiry_data() has completed.
> >
> > It can't be; isd200_get_inquiry_data is called by
> > isd200_Initialization during probe before any SCSI commands are
> > transmitted.
> 
> How do we end up with bad inquiry data (or rather bad ATA ID data)?

The data doesn't come from an actual ISD200 device.  It's from a 
deliberately faulty (for the obvious reason) emulation in userspace, 
created by the syzbot test code.

Alan Stern

