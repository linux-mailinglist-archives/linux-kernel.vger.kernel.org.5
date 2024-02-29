Return-Path: <linux-kernel+bounces-87059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824286CED4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A0D1C2273B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63514EA29;
	Thu, 29 Feb 2024 16:12:37 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 403691361DF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223157; cv=none; b=swYHECdtX7egygYsHZQXl/zonMYp6MDT5bcjCNDGi9OX0Nwg+4h45A8iJDD+xx55u9I+vtRuxh4y65JjvcvXdj9vtl1fisUCDqnECrAY+wTTo80HGGmDyt/71AxuMGPKCAqYU8oGRu4WBsr8A29pN04Al/yCumlwyToqRlxQKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223157; c=relaxed/simple;
	bh=xE7eCf2afOkbN/IXPS0kJovnnnCwLLZjFOX4LCX4JMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIcxo74xvdZaenKyPiLqKVkjUNXaYW3NJXDnPo/YCh5QcQxHaa6cGhwh2BBwr+kDE2xAqQfDUNTKdi1p6Q9RhSaspagm0LVC27vtR97OXRUUa7Je64c3/18pK5PJ6/oqBI6BvtgafODnoxpFRKJbQ0V5OLTD+sXPEzw3EkxQxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 827938 invoked by uid 1000); 29 Feb 2024 11:12:27 -0500
Date: Thu, 29 Feb 2024 11:12:27 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
  bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
  tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
Message-ID: <914a01e5-9c7d-4f2c-9d2b-c5c8c99b4a0e@rowland.harvard.edu>
References: <8fe3f46c-4ee5-4597-bf2d-12a5d634a264@rowland.harvard.edu>
 <0000000000008b026406126a4bbe@google.com>
 <13add23d-af18-4f84-9f1a-043932a9712b@rowland.harvard.edu>
 <CANp29Y4DUvL5zsnqQmhPGkbc=EN6UjFrWF9EZGE5U_=0C9+1Nw@mail.gmail.com>
 <380909e4-6e0a-402f-b3ac-de07e520c910@rowland.harvard.edu>
 <CANp29Y6hPF--pjWCa4bsAXWY15XoP2kmSg8BFP4ATGUpVbQgHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y6hPF--pjWCa4bsAXWY15XoP2kmSg8BFP4ATGUpVbQgHQ@mail.gmail.com>

On Thu, Feb 29, 2024 at 04:40:05PM +0100, Aleksandr Nogikh wrote:
> On Wed, Feb 28, 2024 at 8:18 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Feb 28, 2024 at 05:52:50PM +0100, Aleksandr Nogikh wrote:
> > > Hi Alan,
> > >
> > > Please try it once more with the full commit hash.
> >
> > Thanks for the advice.  Are you a good person to complain to about the
> > difference between what syzbot provides and what it will accept?  This
> > bug report states
> >
> > HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
> > git tree:       upstream
> >
> > But if I specify "upstream" as the git tree on a syz test request, it
> > doesn't accept it.  Now you're suggesting that if I put f2e367d6ad3b as
> > the commit ID, it won't accept it.
> >
> > There's probably already a bugfix request for this, but I'd like to push
> > on it some more.  Syzbot's output should be acceptable as its input!
> 
> That all totally makes sense. Thanks for highlighting the problems!
> 
> For accepting "upstream" (and alike) as input, there was already a github issue:
> https://github.com/google/syzkaller/issues/2265
> That syzbot is not able to fetch commits by their short hashes was
> only discovered yesterday.
> 
> I've just sent PRs with fixes for both issues.
> 
> If there's anything else that can make syzbot reports better, please
> let me know :)

That's great news!  Thanks a lot.

How will we know when the fixes have been accepted and we can use them?

Alan Stern

