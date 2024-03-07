Return-Path: <linux-kernel+bounces-96204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 228FE875885
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7693B25C29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EE13664A;
	Thu,  7 Mar 2024 20:35:18 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 89BDA64AB6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843718; cv=none; b=BhZTH9bJnzVb3L13kkHK+YsS/kKCuW5NpbPnsTloIeyRPKlt2oMpbfUa8KasLNPGa9hsGJUwsJV++kCqQEAixUgOBESEAwsr0GHS52HqJFFKUa4Ld5bjCT6hK3LYWrAugZbDBMuHgalAznTwNAp3D8Gq0/Uub4o3wsL1Oz6x+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843718; c=relaxed/simple;
	bh=sljL2bAz7fGa4csXLlDQhqA6Biu86JZwj+HTMWssYf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcTYrrXDFS+XHTZD0Sa4vdy/+jDdgW9qzU2gn5PQo+oa7NTS+ZhWVBAgLleLNnUWYivCWeFs2TiSez+oGC8sX+G5GW8MawIfvXmuebXryQYb5bfLl69thQmRMm/XwbmmxilPv+nYkrtgbJp5Pyoo6aY/PBw6/mVF6uQ96Fs4qpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 232122 invoked by uid 1000); 7 Mar 2024 15:35:15 -0500
Date: Thu, 7 Mar 2024 15:35:15 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  "xrivendell7@gmail.com" <xrivendell7@gmail.com>,
  Greg KH <gregkh@linuxfoundation.org>, hgajjar@de.adit-jv.com,
  quic_ugoswami@quicinc.com, stanley_chang@realtek.com,
  heikki.krogerus@linux.intel.com
Subject: Re: [Bug] INFO: task hung in hub_activate
Message-ID: <0afd0885-1650-47db-b2b3-43b597352e6b@rowland.harvard.edu>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>

On Mon, Mar 04, 2024 at 08:10:02PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We encountered a task hung in function hub_activate(). It was reported
> before by Syzbot several years ago
> (https://groups.google.com/g/syzkaller-lts-bugs/c/_komEgHj03Y/m/rbcVKyLXBwAJ),
> but no repro at that time. We have a C repro this time and kernel
> config is attached to this email. The bug report is listed below.

> If you have any questions, please contact us.
> 
> Reported by Yue Sun <samsun1006219@gmail.com>
> Reported by xingwei lee <xrivendell7@gmail.com>

Yue:

Can you try testing the patch below?  Thanks.

Alan Stern



Index: usb-devel/drivers/usb/core/sysfs.c
===================================================================
--- usb-devel.orig/drivers/usb/core/sysfs.c
+++ usb-devel/drivers/usb/core/sysfs.c
@@ -1168,14 +1168,24 @@ static ssize_t interface_authorized_stor
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	bool val;
+	struct kernfs_node *kn;
 
 	if (kstrtobool(buf, &val) != 0)
 		return -EINVAL;
 
-	if (val)
+	if (val) {
 		usb_authorize_interface(intf);
-	else
-		usb_deauthorize_interface(intf);
+	} else {
+		/*
+		 * Prevent deadlock if another process is concurrently
+		 * trying to unregister intf or its parent device.
+		 */
+		kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+		if (kn) {
+			usb_deauthorize_interface(intf);
+			sysfs_unbreak_active_protection(kn);
+		}
+	}
 
 	return count;
 }

