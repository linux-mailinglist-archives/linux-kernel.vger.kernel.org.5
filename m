Return-Path: <linux-kernel+bounces-57864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A784DE54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C1928C43F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B26F090;
	Thu,  8 Feb 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDE1XBjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F06F509;
	Thu,  8 Feb 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388185; cv=none; b=oiKb30AJ0io/u7mwfm6LsZCXK7Lxq/C0k6MTbBdapKWAhmpXtSESHsLBI8ROO3TkiPNG/WwT/bwhRkOV8U1HEY6v6Duyl0b4mJau7l15WFp99maH52BSH67kFvNAA5jLTGgNEbNhix4uAVXPVwNAni5HGriGO6SXkJnNhfzDWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388185; c=relaxed/simple;
	bh=qkRo7Q5No9t3NPm4Abl0ryUd6rcSfQnev/ZgDKvbQBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFU9SiL7PZHlZYlfkzCjZMdBgdN6p5uQwarM+tXfuKDD/l9bV33hykTE+c6uBzxoqxlup911pABHglDOJGuPjYF+ZqZle3CIxqybX2GO6+771Dduvw9IX6nufoLuzIq/i6EMTme4PrdZyVKoimW9bvLh8WlRk4aPZXtojHaWo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDE1XBjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745DCC433F1;
	Thu,  8 Feb 2024 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388184;
	bh=qkRo7Q5No9t3NPm4Abl0ryUd6rcSfQnev/ZgDKvbQBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDE1XBjE8ZOe0G+au2Wv6Ojw4kDDbxCa+M9/hV+l7bW7svfDswW89uSALgXYrVx2g
	 o9+cQRgWmwTWT7ir1BT1R2LQKFrHOfJaInNqoA9L80Mh7eReAUx3K5uRHdvhmQCeHM
	 N7zbu+higQ5XU2DBQZCFQCvreOOuz4pi7WEwviuKwx00NBp7khcX47lBH5eDTX6y//
	 PrjcECllhYX4ODckX9AsJGMxs6ZuyqDNU7KHHP7UX5XzcrZZb8UcDC5S9dRU7eaI7c
	 Ymhl+Wr40iifzZPiqErEdmXoSLABJYFTiiRh5LHSV0xOO4d5wC9Uk7YSbufofmUIrw
	 FyOKTwXTK/ziA==
Date: Thu, 8 Feb 2024 10:29:39 +0000
From: Lee Jones <lee@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <20240208102939.GF689448@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>

On Thu, 08 Feb 2024, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> Thanks for your patch!
> 
> On Thu, Feb 8, 2024 at 9:48 AM Lee Jones <lee@kernel.org> wrote:
> > There is a general misunderstanding amongst engineers that {v}snprintf()
> > returns the length of the data *actually* encoded into the destination
> > array.  However, as per the C99 standard {v}snprintf() really returns
> > the length of the data that *would have been* written if there were
> > enough space for it.  This misunderstanding has led to buffer-overruns
> > in the past.  It's generally considered safer to use the {v}scnprintf()
> > variants in their place (or even sprintf() in simple cases).  So let's
> > do that.
> 
> Confused... The return value is not used at all?

Future proofing.  The idea of the effort is to rid the use entirely.

 - Usage is inside a sysfs handler passing PAGE_SIZE as the size
   - s/snprintf/sysfs_emit/
 - Usage is inside a sysfs handler passing a bespoke value as the size
   - s/snprintf/scnprintf/
 - Return value used, but does *not* care about overflow
   - s/snprintf/scnprintf/
 - Return value used, caller *does* care about overflow
   - s/snprintf/seq_buf/
 - Return value not used
   - s/snprintf/scnprintf/

This is the final case.

> > --- a/drivers/scsi/NCR5380.c
> > +++ b/drivers/scsi/NCR5380.c
> > @@ -421,14 +421,14 @@ static int NCR5380_init(struct Scsi_Host *instance, int flags)
> >         if (!hostdata->work_q)
> >                 return -ENOMEM;
> >
> > -       snprintf(hostdata->info, sizeof(hostdata->info),
> > -               "%s, irq %d, io_port 0x%lx, base 0x%lx, can_queue %d, cmd_per_lun %d, sg_tablesize %d, this_id %d, flags { %s%s%s}",
> > -               instance->hostt->name, instance->irq, hostdata->io_port,
> > -               hostdata->base, instance->can_queue, instance->cmd_per_lun,
> > -               instance->sg_tablesize, instance->this_id,
> > -               hostdata->flags & FLAG_DMA_FIXUP     ? "DMA_FIXUP "     : "",
> > -               hostdata->flags & FLAG_NO_PSEUDO_DMA ? "NO_PSEUDO_DMA " : "",
> > -               hostdata->flags & FLAG_TOSHIBA_DELAY ? "TOSHIBA_DELAY " : "");
> > +       scnprintf(hostdata->info, sizeof(hostdata->info),
> > +                "%s, irq %d, io_port 0x%lx, base 0x%lx, can_queue %d, cmd_per_lun %d, sg_tablesize %d, this_id %d, flags { %s%s%s}",
> > +                instance->hostt->name, instance->irq, hostdata->io_port,
> > +                hostdata->base, instance->can_queue, instance->cmd_per_lun,
> > +                instance->sg_tablesize, instance->this_id,
> > +                hostdata->flags & FLAG_DMA_FIXUP     ? "DMA_FIXUP "     : "",
> > +                hostdata->flags & FLAG_NO_PSEUDO_DMA ? "NO_PSEUDO_DMA " : "",
> > +                hostdata->flags & FLAG_TOSHIBA_DELAY ? "TOSHIBA_DELAY " : "");
> >
> >         NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
> >         NCR5380_write(MODE_REG, MR_BASE);

-- 
Lee Jones [李琼斯]

