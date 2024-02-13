Return-Path: <linux-kernel+bounces-63457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21751852FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CC01F26686
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA137715;
	Tue, 13 Feb 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLKDQ3Z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589B376F7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824723; cv=none; b=IhwvWKBiYSR75W0jTaXzcJYVCZtO9IbzN0f4SNsMnPklznn1NI4E75+x3YUZAbHJhJPmFsuZ2z0ePDWgOUZmDx6N6L6VyAEYzur4TxqTQtLruFDwZ8lx7doiQSJjx3PeHIh5E+SHnMiaRViNHiIDH/6IFcR8bmoWMDasawhSlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824723; c=relaxed/simple;
	bh=Iro2uYYnfnYe+OWzj+GsG7aHp915R3LpIFlDLSEohDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2PaX1OnHwrctNPV5bnJ5UZoxS+SP6uHg75ZxF0cWd8SY47JJItm65YWFRHei9BWN33mZGTirqehc4oQDJtiY+i/PctmWX8CtKuAkRzsFsiqvQvl7zeZN5w7MRWn+5CbW92oHTG1LBEKzShKpRXDzJDhzX/A1+SdsZ5UA3KHRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLKDQ3Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DBEC433F1;
	Tue, 13 Feb 2024 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707824722;
	bh=Iro2uYYnfnYe+OWzj+GsG7aHp915R3LpIFlDLSEohDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLKDQ3Z+dxTk3P+E2A70GmxAn6yxMYtA0scHWyLcCyNZc+7LwV/R401QyDDzCoWMl
	 B+YR/qyWbp8zHUrtOo/eMHz9GYROsjVBq4ZYYaWectCht8mdyJMZQPNNzFiPx4l0ia
	 PAon9ys47LQuiIj/gmBM03m59Ecy9wf3O6EDYecM=
Date: Tue, 13 Feb 2024 12:45:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, vschneid@redhat.com,
	bristot@redhat.com, mgorman@suse.de, bsegall@google.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com,
	juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
	lukasz.luba@arm.com, ionela.voinescu@arm.com,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
Message-ID: <2024021357-stranger-supremacy-a985@gregkh>
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
 <75f0bfc7-fb95-409a-a5d9-b00732e892f0@bp.renesas.com>
 <8108129e-d7b8-4540-bf53-ed29cd4bbff9@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8108129e-d7b8-4540-bf53-ed29cd4bbff9@bp.renesas.com>

On Tue, Feb 13, 2024 at 11:06:48AM +0000, Paul Barker wrote:
> Hi Greg,
> 
> On 23/01/2024 16:23, Paul Barker wrote:
> > On 17/01/2024 19:05, Vincent Guittot wrote:
> >> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
> >> normalization step which includes setting per_cpu capacity_freq_ref.
> >> Always register the notifier but skip the capacity normalization if
> >> raw_capacity is null.
> >>
> >> Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() method")
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > 
> > We've had some Ethernet performance issues with linux-next and v6.8-rc1
> > on the Renesas RZ/G2L and RZ/G2UL arm64 SoCs. I've confirmed that the
> > CPU frequency is stuck at the minimum (150MHz) in v6.8-rc1, even when
> > running iperf3. Applying this patch allows the SoC to switch up the the
> > maximum frequency (1200MHz) when needed and fixes our Ethernet
> > performance.
> > 
> > iperf3 results in Mbps for RZ/G2L SMARC evaluation board:
> >                 TCP TX    TCP RX    UDP TX    UDP RX
> > v6.8-rc1        255       175       102       (*)
> > +this patch     874       650       802       948
> > 
> > (*) Testing UDP RX in v6.8-rc1 with a server sending traffic at 1Gbps
> > locks up our NFS rootfs mount so we don't get any result at all.
> > 
> > Results with v6.8-rc1 + this patch are in line with what we see in v6.7.
> > 
> > Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> 
> I see this patch landed in the 'driver-core-linus' branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> on 2024-01-30 as commit 98323e9d7017, however it looks like that hasn't
> been merged to Linus' tree yet. In v6.8-rc4 I see the same issue on the
> RZ/G2L with the CPU frequency stuck at 150MHz.
> 
> Is there anything I need to do to help get this patch merged before v6.8
> is released?

It will get there, sorry, been traveling for weeks and will catch up and
send my trees to Linus later this week.

greg k-h

