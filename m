Return-Path: <linux-kernel+bounces-147252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E658A718C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D91C2193A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17684E11;
	Tue, 16 Apr 2024 16:36:00 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E630711181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285359; cv=none; b=gsQmgY8Jktla5MG8zHA3fbmZvv/pdSjkLblyVhLtGRmSeNI7ORphTROPzGNmiXhvSPCGsYhj/TaLKfMDJmm5SNDZkp9g9okQ7+i7I8UZHF+L1rFll90Cc6ZJtYVgLEVduSugj7ykObCHI3fby7gLcJ+llcZh7rEqqKA5rbUb+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285359; c=relaxed/simple;
	bh=dslLUCHcOZAwM9Gd9ol8Q8GYxzbqoWNQ3zQBzTdhKSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRTn9QroVhSiVypwKAvnkwaGjs6E4HAc+yXYKU3ly9OJMkx9Ky2x9lke6qYcZQf3PZ8XmtoyHF9p0rFVgJYINo+5hH143ZWJZMyravPgw6GNpWfxWmdsz2OGEdpmaBj/T+WlKTZo24okp/hCD+5jRCTwLMNHFxb/vq76Ugah4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 169880 invoked by uid 1000); 16 Apr 2024 12:35:51 -0400
Date: Tue, 16 Apr 2024 12:35:51 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org,
  ricardo@marliere.net, hkallweit1@gmail.com, heikki.krogerus@linux.intel.com,
  mathias.nyman@linux.intel.com, royluo@google.com,
  syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] general protection fault in disable_store
Message-ID: <5f3526a6-6ede-4181-a4ff-076e022cfb49@rowland.harvard.edu>
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
 <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
 <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com>
 <5704ac63-5e5b-416c-a2a1-57528e76a02f@rowland.harvard.edu>
 <CAEkJfYMSwuikpBJudOaFYrxgf9e=_O4nig6sTPLLAtpdEKQuyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkJfYMSwuikpBJudOaFYrxgf9e=_O4nig6sTPLLAtpdEKQuyQ@mail.gmail.com>

On Tue, Apr 16, 2024 at 05:05:55PM +0800, Sam Sun wrote:
> On Mon, Apr 15, 2024 at 10:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Actually, I've got a completely different patch which I think will fix
> > the problem you encountered.  Instead of using mutual exclusion to
> > avoid the race, it prevents the two routines from being called at the
> > same time so the race can't occur in the first place.  It also should
> > guarantee the usb_hub_to_struct_hub() doesn't return NULL when
> > disable_store() calls it.
> >
> > Can you try the patch below, instead of (not along with) the first
> > patch?  Thanks.
> >
> > Alan Stern

> I tried this patch and it worked. I agree this patch is better and it
> avoids introducing new locks.

It turns out that patch is no good.  The reason is mentioned in the 
changelog for commit 543d7784b07f ("USB: fix race between hub_disconnect 
and recursively_mark_NOTATTACHED"); it says that the port devices have to 
be removed _after_ maxchild has been set to 0.

So okay, here's a third attempt to fix the problem.  This doesn't try to 
avoid the race or anything like that.  Instead it just adds checks for 
usb_hub_to_struct_hub() returning NULL.  That should be enough to prevent 
the invalid pointer dereference you encountered.

This should be tested by itself, without either of the first two patches.

Alan Stern



Index: usb-devel/drivers/usb/core/port.c
===================================================================
--- usb-devel.orig/drivers/usb/core/port.c
+++ usb-devel/drivers/usb/core/port.c
@@ -51,13 +51,15 @@ static ssize_t disable_show(struct devic
 	struct usb_port *port_dev = to_usb_port(dev);
 	struct usb_device *hdev = to_usb_device(dev->parent->parent);
 	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
-	struct usb_interface *intf = to_usb_interface(hub->intfdev);
+	struct usb_interface *intf = to_usb_interface(dev->parent);
 	int port1 = port_dev->portnum;
 	u16 portstatus, unused;
 	bool disabled;
 	int rc;
 	struct kernfs_node *kn;
 
+	if (!hub)
+		return -ENODEV;
 	hub_get(hub);
 	rc = usb_autopm_get_interface(intf);
 	if (rc < 0)
@@ -101,12 +103,14 @@ static ssize_t disable_store(struct devi
 	struct usb_port *port_dev = to_usb_port(dev);
 	struct usb_device *hdev = to_usb_device(dev->parent->parent);
 	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
-	struct usb_interface *intf = to_usb_interface(hub->intfdev);
+	struct usb_interface *intf = to_usb_interface(dev->parent);
 	int port1 = port_dev->portnum;
 	bool disabled;
 	int rc;
 	struct kernfs_node *kn;
 
+	if (!hub)
+		return -ENODEV;
 	rc = kstrtobool(buf, &disabled);
 	if (rc)
 		return rc;


