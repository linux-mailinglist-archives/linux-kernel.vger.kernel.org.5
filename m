Return-Path: <linux-kernel+bounces-140496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43A8A1570
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5116284463
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3D714D299;
	Thu, 11 Apr 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQ1wSwA7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A614B088;
	Thu, 11 Apr 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841803; cv=none; b=b87BBN/ML0fMYN9idTfEU/YGiuC2I6K4/T8y+0ADBs7Yd0LY3mtRJ4NOBFqYuMaskQeR1RyzYTyrCjm8xWZg//DWQnm7kXeNiuszYoWvXdp7gVFhDm4npEEmG9kucWwNkfB/cP8/VGsa+fwByaNlfjHfQtKzZXSkCCJ8B81L3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841803; c=relaxed/simple;
	bh=q/DrqC1YT/r2hjYi0RMw/ryM1Q0NJ4drp4UF4UuyA+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+/yOsszuVX3Lpwg3B8tz56EYtg03nKWhdnoA4kZHGv7JNNpGX6M5EtFOxizbhSFB6caTE41IGtSplPC8cAxfCThCqp4hHT1ExU1zcevznxiqkT4YIdHAgSNYFJTSPBwVnIiQo4cP2sEQGXYzOca8N4xPrG1e7jnN1MQh7weouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQ1wSwA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF953C43175;
	Thu, 11 Apr 2024 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712841802;
	bh=q/DrqC1YT/r2hjYi0RMw/ryM1Q0NJ4drp4UF4UuyA+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQ1wSwA7CQcyM26Jabj34qfja5akmsQWS46zckZv/TaqJb/SLK+XDOlczbIMI+0/j
	 AWZqxefPTDGwn0BcG4rhV2ipAZy/WksDJdKYqrOql9kKz9qGM3pMYQdHWforFTk67O
	 F/NxcRgMXPYmBbU16oJZrLbGzAA7V/YozEFyLyU8=
Date: Thu, 11 Apr 2024 15:23:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 0/2] Synchronize DT overlay removal with devlink
 removals
Message-ID: <2024041111-unsaid-shrine-63f8@gregkh>
References: <20240307111036.225007-1-herve.codina@bootlin.com>
 <20240308200548.GA1189199-robh@kernel.org>
 <CAGETcx8ReCH2z64_PGhmbqdH_ge3B_xOqTOP-yanRf3T8TkzLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8ReCH2z64_PGhmbqdH_ge3B_xOqTOP-yanRf3T8TkzLg@mail.gmail.com>

On Fri, Mar 08, 2024 at 02:29:28PM -0800, Saravana Kannan wrote:
> On Fri, Mar 8, 2024 at 12:05 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Mar 07, 2024 at 12:09:59PM +0100, Herve Codina wrote:
> > > Hi,
> > >
> > > In the following sequence:
> > >   of_platform_depopulate(); /* Remove devices from a DT overlay node */
> > >   of_overlay_remove(); /* Remove the DT overlay node itself */
> > >
> > > Some warnings are raised by __of_changeset_entry_destroy() which  was
> > > called from of_overlay_remove():
> > >   ERROR: memory leak, expected refcount 1 instead of 2 ...
> > >
> > > The issue is that, during the device devlink removals triggered from the
> > > of_platform_depopulate(), jobs are put in a workqueue.
> > > These jobs drop the reference to the devices. When a device is no more
> > > referenced (refcount == 0), it is released and the reference to its
> > > of_node is dropped by a call to of_node_put().
> > > These operations are fully correct except that, because of the
> > > workqueue, they are done asynchronously with respect to function calls.
> > >
> > > In the sequence provided, the jobs are run too late, after the call to
> > > __of_changeset_entry_destroy() and so a missing of_node_put() call is
> > > detected by __of_changeset_entry_destroy().
> > >
> > > This series fixes this issue introducing device_link_wait_removal() in
> > > order to wait for the end of jobs execution (patch 1) and using this
> > > function to synchronize the overlay removal with the end of jobs
> > > execution (patch 2).
> > >
> > > Compared to the previous iteration:
> > >   https://lore.kernel.org/linux-kernel/20240306085007.169771-1-herve.codina@bootlin.com/
> > > this v5 series:
> > > - Remove a 'Fixes' tag
> > > - Update a comment
> > > - Add 'Tested-by' and ''Reviewed-by' tags
> > >
> > > This series handles cases reported by Luca [1] and Nuno [2].
> > >   [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
> > >   [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/
> > >
> > > Best regards,
> > > Hervé
> > >
> > > Changes v4 -> v5
> > >   - Patch 1
> > >     Remove the 'Fixes' tag
> > >     Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
> > >     Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'
> > >
> > >   - Patch 2
> > >     Update comment as suggested
> > >     Add 'Reviewed-by: Saravana Kannan <saravanak@google.com>'
> > >     Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
> > >     Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'
> > >
> > > Changes v3 -> v4
> > >   - Patch 1
> > >     Uses flush_workqueue() instead of drain_workqueue().
> > >
> > >   - Patch 2
> > >     Remove unlock/re-lock when calling device_link_wait_removal()
> > >     Move device_link_wait_removal() call to of_changeset_destroy()
> > >     Update commit log
> > >
> > > Changes v2 -> v3
> > >   - Patch 1
> > >     No changes
> > >
> > >   - Patch 2
> > >     Add missing device.h
> > >
> > > Changes v1 -> v2
> > >   - Patch 1
> > >     Rename the workqueue to 'device_link_wq'
> > >     Add 'Fixes' tag and Cc stable
> > >
> > >   - Patch 2
> > >     Add device.h inclusion.
> > >     Call device_link_wait_removal() later in the overlay removal
> > >     sequence (i.e. in free_overlay_changeset() function).
> > >     Drop of_mutex lock while calling device_link_wait_removal().
> > >     Add       'Fixes' tag and Cc stable
> > >
> > > Herve Codina (2):
> > >   driver core: Introduce device_link_wait_removal()
> > >   of: dynamic: Synchronize of_changeset_destroy() with the devlink
> > >     removals
> > >
> > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > >  drivers/of/dynamic.c   | 12 ++++++++++++
> > >  include/linux/device.h |  1 +
> > >  3 files changed, 36 insertions(+), 3 deletions(-)
> >
> > This looks good to me. I can take this given the user is DT. Looking for
> > a R-by from Saravana and Ack from Greg. A R-by from Rafael would be
> > great too.
> 
> Reviewed-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

