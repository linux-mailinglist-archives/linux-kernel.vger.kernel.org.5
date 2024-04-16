Return-Path: <linux-kernel+bounces-146608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C68A6812
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C4F1F21DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F11272B7;
	Tue, 16 Apr 2024 10:15:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE486244
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262559; cv=none; b=qUYt+1W5piLxE3Gbah1xs150ADMecFJ4K2XgzNwwKjBt2R30RnYmBALkqu+1KB/oozCylaoqg6KcIy4VbKH96RSItpVcxsu3oUOhZw7xnPGtUPcDy0kfRETDIE+/S+nrpF/q3dbgy6qpFK0M4o4C2OLF3GdOEcNvlCw69VioxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262559; c=relaxed/simple;
	bh=/Y9sQ9tapFlbwWSFHkx4sB2rpzb7IJgWVa7cAr/DRzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdv49y1OQ8CxAR10o8qhWB7wCZqZVKx7Jz/+Zr+P9injqmD0Fw7UbIy/3LAM3zZayQdkHq0VwBfu8cvj0R5avewikiL2M27k3LyA74Uev8C3fDcCAxKDnPl33BCjyjJSVaYlUGwlGUeu6nxjKggio/lDCXpy+vb/kJSoK4DNr3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92329339;
	Tue, 16 Apr 2024 03:16:23 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B173F64C;
	Tue, 16 Apr 2024 03:15:54 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:15:52 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Message-ID: <Zh5P2EtruMmTrgXM@pluto>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
 <Zh2R4FZPmVOigfT9@pluto>
 <DU0PR04MB9417AC020C28AD5847CAB24088082@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417AC020C28AD5847CAB24088082@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Tue, Apr 16, 2024 at 07:01:42AM +0000, Peng Fan wrote:
> Hi Cristian,
> 

Hi,

> > Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
> > command
> > 
> > On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Support System suspend notification. Using a work struct to call
> > > pm_suspend. There is no way to pass suspend level to pm_suspend, so
> > > use MEM as of now.
> > >
> > 
> > Hi Peng,
> > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../firmware/arm_scmi/scmi_power_control.c    | 20 ++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > 
> > This LGTM in general, the only obsservation here is that while on shutdown
> > by issuing a orderly_reboot() we in fact ask PID_1 to start a shutdown from
> 
> Would you please share why PID_1 is involved here? orderly_reboot is just
> schedule a work.

For the shutdown case, orderly_reboot related scheduled work ends up in a
call to /sbin/reboot via usermodehelper kernel facilities, so that, depending
on what PID_1 you have and how it is configured, PID_1 does have a chance to
perform some additional task (if configured) before triggering the real final
shutdown....this is done because the SCMI Notification is supposed to be a
graceful request, so we dont just kernel_poweroff or similar.

As an example with SystemD PID_1 /sbin/reboot is just a link to systemctl
and you can place whatever you want in

/usr/lib/systemd/system-shutdown/

and that it will executed by systemctl before kernel shutdown is really
triggered.

> > userspace, when triggering a system suspend with pm_suspend() we do not
> > involve userspace in the process, but I dont think there is another way indeed.
> 
> Userspace process should not be involved, otherwise the freezing process will
> never finish, and suspend will abort.
> 

Similarly in the suspend case when you initiate it from userspace (systemcl suspend)
you can place something in /usr/lib/systemd/system-sleep/ and have it executed before
suspend is passwed on to the kernel, BUT in our case we are not passing through
userspace and it seems there is no way to do it, indeed, like we do for shutdown with
orderly_reboot(). Moreover userspace, as Sudeep mentioned in the other thread, could
be configured to trigger a different type of suspend, it it was involved at all 
in this process.

But, as said, I dont think there is a way to trigger a userspace
suspennd from jernel like we do for shutdown/reboot...I'll try to
investigate a bit more.

Anyway the change seems good to me as I said.

Thanks,
Cristian

