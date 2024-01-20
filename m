Return-Path: <linux-kernel+bounces-31754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4483337F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4621F223A0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B70D268;
	Sat, 20 Jan 2024 10:02:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41EE3222;
	Sat, 20 Jan 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705744956; cv=none; b=pPB9MsQkTCg0HA4wnqDAXkGllLHv8/7Dm+U1wKGoVkyTiUZcQyYePF9QbeYiER0CwWi20EcZUaAVqtX4VAINoUAuQWoJ4jfIcrzqIh9B/h+2C0G9LsYVIVZ6mj3ir+lyttBKJrP9kERI/MduZ6jh7w8qzx/roTrULfhm5gNoSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705744956; c=relaxed/simple;
	bh=1mq/TzDDXHVp5Q39X59Xe+zvOA2DB6bcQQvkeWJI9TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfYSc18oqyXyY19othwQULuqlW3WUq8rRHhMCn4+7/yDW53haPJKU2kT4VZ28xtSG6aS6WPUeRBaBCiLOq5uJg3V6D/Ns6sZTfSqcdo3UfeQVveC3hk//KrbiCw/tbaF/RecMMikHReOcVGvDCwNT8hwlG/1IWEpyIoYR2gTHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8264DA7;
	Sat, 20 Jan 2024 02:03:18 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35D873F73F;
	Sat, 20 Jan 2024 02:02:31 -0800 (PST)
Date: Sat, 20 Jan 2024 10:02:28 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/2] clk: scmi: support state_ctrl_forbidden
Message-ID: <ZauaNDGTs8LFvnwT@pluto>
References: <20240115060203.813168-1-peng.fan@oss.nxp.com>
 <20240115060203.813168-2-peng.fan@oss.nxp.com>
 <ZaltgIGyx1al-F9x@pluto>
 <c9385ba8-b225-4c8d-b09f-971d9e6008ab@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9385ba8-b225-4c8d-b09f-971d9e6008ab@oss.nxp.com>

On Sat, Jan 20, 2024 at 10:44:06AM +0800, Peng Fan wrote:
> 
> 
> 在 1/19/2024 2:27 AM, Cristian Marussi 写道:
> > On Mon, Jan 15, 2024 at 02:02:03PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > Some clocks may exported to linux, while those clocks are not allowed
> > > to configure by Linux. For example:
> > > 
> > > SYS_CLK1-----
> > >               \
> > > 	     --MUX--->MMC1_CLK
> > >               /
> > > SYS_CLK2-----
> > > 
> > > MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> > > then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> > > So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
> > > the clock of MMC1.
> > > 
> > 
> > Hi,
> > 
> > so this looks good to me and apparently (as noted) the CLK framework is OK
> > with a driver swallowing the -EACCESS when a clock is immutable, BUT at the
> > end of the day do we even need to try this SCMI call and hide the failure in
> > case of immutable clocks ?
> > 
> > I mean, what if we just dont provide any callback for enable/disable...I can
> > see plenty of drivers not providing those callbacks ?
> > Maybe this is probably more of a question for Stephen...
> > 
> > IOW what about doing something like below...does it make any difference
> > in your setup ? works fine in my emulated env
> 
> It should be fine to use your changes. Do you expect me to use your patch or
> make it as a follow up patch?
> 

It was just a suggestion, if you think is fine just include it in your
series, I dont mind.

> > 
> > (Note that last snippet in clk_gate_restore_context() is probably a fix
> >   that needs to be added anyway by looking at the code in clk.c)
> 
> This API seems only used by TI gate driver, this change should be in a
> standalone change go through clk tree. So I would your changes
> as a standalone optimization follow up patch, while not included
> in my patchset.

Yes, indeed I have made a small patch of it to post it separately..and I
forgot :D... sending it now.

Thanks,
Cristian

