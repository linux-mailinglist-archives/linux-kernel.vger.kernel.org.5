Return-Path: <linux-kernel+bounces-145383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD808A5583
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304CE1F2244C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D374BEB;
	Mon, 15 Apr 2024 14:47:48 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A45181E4B1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192467; cv=none; b=TYViVaihpVIVOFeY5Xxn4bKHgaPunEmWPUpF/QA9R3oy+IQ21FkP3TLVGTK2ukE0HqGIw0vWLyxcrrCokM9XsW5fVFMaHmSF3oEO4pPVep4rJJ3fdiaNhRQqiz7nC9FJCjNZruTANq8xHXHn2N0btWJG/CGznBwoRlhMTwAZZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192467; c=relaxed/simple;
	bh=m4Kte0giezl+If8hqhuQU7p0YsRvGoGX4kkW0p3OyhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iuu50bZg6OF/Ju2f/7kyukt5wtH6B1JhdB98xMPnwW0qVL+lET4SfYlxIjE/sS2MJ5qAQgNsM9elpzu5CVseSu3kHBoUkf1FiFc+9XP2GicxfFZza2vEXg70l2HoHFq9XoIcHQp/zk89+Z6BmucMuvSFAsSQMs9oHexuXicynh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 127300 invoked by uid 1000); 15 Apr 2024 10:47:37 -0400
Date: Mon, 15 Apr 2024 10:47:37 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org,
  ricardo@marliere.net, hkallweit1@gmail.com, heikki.krogerus@linux.intel.com,
  mathias.nyman@linux.intel.com, royluo@google.com,
  syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] general protection fault in disable_store
Message-ID: <5704ac63-5e5b-416c-a2a1-57528e76a02f@rowland.harvard.edu>
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
 <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
 <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com>

On Sat, Apr 13, 2024 at 01:08:41PM +0800, Sam Sun wrote:
> On Sat, Apr 13, 2024 at 2:11 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sat, Apr 13, 2024 at 12:26:07AM +0800, Sam Sun wrote:
> > > On Fri, Apr 12, 2024 at 10:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > I suspect the usb_hub_to_struct_hub() call is racing with the
> > > > spinlock-protected region in hub_disconnect() (in hub.c).
> > > >
> > > > > If there is any other thing I could help, please let me know.
> > > >
> > > > Try the patch below.  It should eliminate that race, which hopefully
> > > > will fix the problem.
> >
> > > I applied this patch and tried to execute several times, no more
> > > kernel core dump in my environment. I think this bug is fixed by the
> > > patch. But I do have one more question about it. Since it is a data
> > > race bug, it has reproducibility issues originally. How can I confirm
> > > if a racy bug is fixed by test? This kind of bug might still have a
> > > race window but is harder to trigger. Just curious, not for this
> > > patch. I think this patch eliminates the racy window.
> >
> > If you don't what what is racing, then testing cannot prove that a race
> > is eliminated.  However, if you do know where a race occurs then it's
> > easy to see how mutual exclusion can prevent the race from happening.
> >
> > In this case the bug might have had a different cause, something other
> > than a race between usb_hub_to_struct_hub() and hub_disconnect().  If
> > that's so then testing this patch would not be a definite proof that the
> > bug is gone.  But if that race _is_ the cause of the bug then this patch
> > will fix it -- you can see that just by reading the code with no need
> > for testing.
> >
> > Besides, the patch is needed in any case because that race certainly
> > _can_ occur.  And maybe not only on this pathway.
> >
> 
> Thanks for explaining! I will check the related code next time.
> 
> > May I add your "Reported-and-tested-by:" to the patch?
> 
> Sure, thanks for your help!

Actually, I've got a completely different patch which I think will fix 
the problem you encountered.  Instead of using mutual exclusion to 
avoid the race, it prevents the two routines from being called at the 
same time so the race can't occur in the first place.  It also should 
guarantee the usb_hub_to_struct_hub() doesn't return NULL when 
disable_store() calls it.

Can you try the patch below, instead of (not along with) the first 
patch?  Thanks.

Alan Stern



Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -1788,16 +1788,15 @@ static void hub_disconnect(struct usb_in
 
 	mutex_lock(&usb_port_peer_mutex);
 
+	for (port1 = hdev->maxchild; port1 > 0; --port1)
+		usb_hub_remove_port_device(hub, port1);
+
 	/* Avoid races with recursively_mark_NOTATTACHED() */
 	spin_lock_irq(&device_state_lock);
-	port1 = hdev->maxchild;
 	hdev->maxchild = 0;
 	usb_set_intfdata(intf, NULL);
 	spin_unlock_irq(&device_state_lock);
 
-	for (; port1 > 0; --port1)
-		usb_hub_remove_port_device(hub, port1);
-
 	mutex_unlock(&usb_port_peer_mutex);
 
 	if (hub->hdev->speed == USB_SPEED_HIGH)


