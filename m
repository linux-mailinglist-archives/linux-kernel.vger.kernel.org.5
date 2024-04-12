Return-Path: <linux-kernel+bounces-143182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C58A356F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B69DB23A91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F114EC57;
	Fri, 12 Apr 2024 18:11:59 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AC62A14D6FD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945518; cv=none; b=VtUWIWJ9Hn3YFzh82uGXd1Vt9JaqiQBTzVOid0Yuauq1qdv8oR/m6Ohaf2f4pJSxnB4Octmxfz6QT3IZd6z88/o0EhzTtzR5O7pYx/IV9aIiv7lhAjtSFzxGnYpXN56IoEM20pv+8hoiC6/P8rp8ME/Ab4ibJ9FzfRlHGnCxqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945518; c=relaxed/simple;
	bh=/VIpVejDThBXlmlTl+/jXMBsg9l38y+XANkevrDIb2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiwJgDv5vYoM3IYPawTOcCzUeecBBtEmN8S+naoW4hrbVVlXBIVU/2FsU0uLsX/qHK6OI8fIqP+f+rD0ohrixO4VK2cpVFIwcHUHsmOHq1aVtRgSb405wFOFz5CWJd3xhiHHhoCCv0fF7P7X49oBoMfgrURTCGoP4GWl3VXOd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 44530 invoked by uid 1000); 12 Apr 2024 14:11:49 -0400
Date: Fri, 12 Apr 2024 14:11:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org,
  ricardo@marliere.net, hkallweit1@gmail.com, heikki.krogerus@linux.intel.com,
  mathias.nyman@linux.intel.com, royluo@google.com,
  syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] general protection fault in disable_store
Message-ID: <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>

On Sat, Apr 13, 2024 at 12:26:07AM +0800, Sam Sun wrote:
> On Fri, Apr 12, 2024 at 10:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > I suspect the usb_hub_to_struct_hub() call is racing with the
> > spinlock-protected region in hub_disconnect() (in hub.c).
> >
> > > If there is any other thing I could help, please let me know.
> >
> > Try the patch below.  It should eliminate that race, which hopefully
> > will fix the problem.

> I applied this patch and tried to execute several times, no more
> kernel core dump in my environment. I think this bug is fixed by the
> patch. But I do have one more question about it. Since it is a data
> race bug, it has reproducibility issues originally. How can I confirm
> if a racy bug is fixed by test? This kind of bug might still have a
> race window but is harder to trigger. Just curious, not for this
> patch. I think this patch eliminates the racy window.

If you don't what what is racing, then testing cannot prove that a race 
is eliminated.  However, if you do know where a race occurs then it's 
easy to see how mutual exclusion can prevent the race from happening.

In this case the bug might have had a different cause, something other 
than a race between usb_hub_to_struct_hub() and hub_disconnect().  If 
that's so then testing this patch would not be a definite proof that the 
bug is gone.  But if that race _is_ the cause of the bug then this patch 
will fix it -- you can see that just by reading the code with no need 
for testing.

Besides, the patch is needed in any case because that race certainly 
_can_ occur.  And maybe not only on this pathway.

May I add your "Reported-and-tested-by:" to the patch?

Alan Stern

