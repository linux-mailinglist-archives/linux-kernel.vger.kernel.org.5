Return-Path: <linux-kernel+bounces-13390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163FE82046D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCADA282065
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5E258C;
	Sat, 30 Dec 2023 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDVIFxVW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BF20EA;
	Sat, 30 Dec 2023 10:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8405BC433C8;
	Sat, 30 Dec 2023 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933906;
	bh=8jyz6J2LW3mt3sCjl8zoQF4EqO3LKwzRdDigq943sAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xDVIFxVWAL2N+h4ZkCJcxGDZdybqW/kXLjElPQj3TLx0dqcjj+M490OqEFPuDHoCa
	 o7ftRMpl5vdnEZORUgXW2bZZcqnJpMcP+oE5LtcjRxY0IPt3ge2HquMhrwRbdZFvFZ
	 PQrjC+F/JrFWMSppnxutARJX1kZdW3PN5RLV31pI=
Date: Sat, 30 Dec 2023 10:58:23 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Sagar Biradar <sagar.biradar@microchip.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Hannes Reinecke <hare@suse.de>, scsi <linux-scsi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Gilbert Wu <gilbert.wu@microchip.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Message-ID: <2023123013-dose-skirmish-27c2@gregkh>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
 <2023112456-disinfect-undoing-b5ef@gregkh>
 <34c5b291-b69e-4592-bc9f-fc1b2ef5c5d7@leemhuis.info>
 <ZY8oXge0QKYUkO1b@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY8oXge0QKYUkO1b@eldamar.lan>

On Fri, Dec 29, 2023 at 09:13:18PM +0100, Salvatore Bonaccorso wrote:
> Hi all,
> 
> On Sat, Nov 25, 2023 at 08:10:35AM +0100, Thorsten Leemhuis wrote:
> > On 24.11.23 17:25, Greg KH wrote:
> > > On Tue, Nov 21, 2023 at 10:50:57AM +0100, Thorsten Leemhuis wrote:
> > >> * @SCSI maintainers: could you please look into below please?
> > >>
> > >> * @Stable team: you might want to take a look as well and consider a
> > >> revert in 6.1.y (yes, I know, those are normally avoided, but here it
> > >> might make sense).
> > >>
> > >> Hi everyone!
> > >>
> > >> TLDR: I noticed a regression (Adaptec 71605z with aacraid sometimes
> > >> hangs for a while) that was reported months ago already but is still not
> > >> fixed. Not only that, it apparently more and more users run into this
> > >> recently, as the culprit was recently integrated into 6.1.y; I wonder if
> > >> it would be best to revert it there, unless a fix for mainline comes
> > >> into reach soon.
> > >>
> > >> Details:
> > >>
> > >> Quite a few machines with Adaptec controllers seems to hang for a few
> > >> tens of seconds to a few minutes before things start to work normally
> > >> again for a while:
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=217599
> > >>
> > >> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
> > >> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
> > >> commit despite a warning of mine to Sasha recently made it into 6.1.53
> > >> -- and that way apparently recently reached more users recently, as
> > >> quite a few joined that ticket.
> > >[...]
> > > I am loath to revert a stable patch that has been there for so long as
> > > any upgrade will just cause the same bug to show back up. Why can't we
> > > just revert it in Linus's tree now and I'll take that revert in the
> > > stable trees as well?
> > 
> > FWIW, I know and in general agree with that strategy, that's why I
> > normally wouldn't have brought a stable-only revert up for
> > consideration. But this issue to me looked somewhat special and urgent
> > for two and a half reasons: (1) that backport apparently made a lot more
> > people suddenly hit the issue (2) there was also this data corruption
> > aspect one of the reporters mentioned (not sure if that is real and/or
> > if this might be just a 6.1.y thing). Furthermore for 6.1.y it was
> > recently confirmed that reverting the change fixes things, while we iirc
> > had no such confirmation for recent mainline kernels at that point. So
> > it looked like it would take a while to get this sorted out in mainline.
> > But it seems we finally might get closer to that now, so yeah, maybe
> > it's not worth a stable revert.
> 
> If I'm not completely wrong, finally indeed the commit has been
> reverted in mainline, with c5becf57dd56 ("Revert "scsi: aacraid: Reply
> queue mapping to CPUs based on IRQ affinity"") .
> 
> This is what was mentioned here:
> https://bugzilla.kernel.org/show_bug.cgi?id=217599#c52
> 
> So should/can it be reverted it now as well on the 6.1.y stable series
> (and the others up as needed?)

Now queued up, thanks.

greg k-h

