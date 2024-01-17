Return-Path: <linux-kernel+bounces-29240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A4830B79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62845285E51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFCB22613;
	Wed, 17 Jan 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BspoeQJt"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3F225CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510266; cv=none; b=WN3c49IX424RkDvZemJ7LvFzLaXfhlAR5jjLBvLyBzRMTg0PNoz+E+T0irr0p9gFMxWefWhx7Zgk3cml6w3MjqDXMIDeoQ1kx4qd88cgPWXHH45liK/b9v7TI2Qr25FPSpYY4oOKgO5bJtIQZgD7OFKm0r7LDo+T44V9C/FADbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510266; c=relaxed/simple;
	bh=faT2uRrQt3V7tKi/jCpPpD6mGOoqk18135qnLaMNQ6w=;
	h=Date:DKIM-Signature:X-Report-Abuse:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Migadu-Flow; b=BCpQc7jnhw52gpz0VMclEX3bIjnAfW/fN6+qwMUFnbyR08WoADN4AdNMJm5n7Mu0GkFWX/ZYQ1mbsoPpTLG5GkBF8cVJ6uhjfc3oyji2jWXU5TExk2Cw2Hi9bIEgSYbl8a1eqdLZGkye4f06ks9BjYe9dQ/oV9qsCKuBxiVCRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BspoeQJt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 17 Jan 2024 17:50:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705510261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsMBTqAbxvDSq34Y8PBcrq1QpEjPS4gVtR8AVs1aPo0=;
	b=BspoeQJtQ3UPfpuJmKzVnJGZaqu6V2IgvIXmri1tYRZK2y0xcxPjnsCRf7Xs6Hj33dsr19
	MNRPJ4vUXh4baAxJUXOshQkM6a9UfonXktAjkK426LQgS0DFmZbAQ1G6W9LQlRCO/cssRo
	KcxndU/YA7T217PRGN6/swdvxkMLfmA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: "sundongxu (A)" <sundongxu3@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, yuzenghui@huawei.com,
	james.morse@arm.com, suzuki.poulose@arm.com, will@kernel.org,
	catalin.marinas@arm.com, wanghaibin.wang@huawei.com,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jiangkunkun@huawei.com
Subject: Re: [bug report] GICv4.1: VM performance degradation due to not
 trapping vCPU WFI
Message-ID: <ZagFVNsA1aLuxorp@linux.dev>
References: <a481ef04-ddd2-dfc1-41b1-d2ec45c6a3b5@huawei.com>
 <86v87t8ras.wl-maz@kernel.org>
 <89fe1503-6d62-90ca-5edb-e11c74846a00@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89fe1503-6d62-90ca-5edb-e11c74846a00@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 17, 2024 at 10:20:32PM +0800, sundongxu (A) wrote:
> On 2024/1/16 19:13, Marc Zyngier wrote:
> > On Tue, 16 Jan 2024 03:26:08 +0000, "sundongxu (A)" <sundongxu3@huawei.com> wrote:
> >> We found a problem about GICv4/4.1, for example:
> >> We use QEMU to start a VM (4 vCPUs and 8G memory), VM disk was
> >> configured with virtio, and the network is configured with vhost-net,
> >> the CPU affinity of the vCPU and emulator is as follows, in VM xml:

<snip>

> >>   <cputune>
> >>     <vcpupin vcpu='0' cpuset='4'/>
> >>     <vcpupin vcpu='1' cpuset='5'/>
> >>     <vcpupin vcpu='2' cpuset='6'/>
> >>     <vcpupin vcpu='3' cpuset='7'/>
> >>     <emulatorpin cpuset='4,5,6,7'/>
> >>   </cputune>

</snip>

> > Effectively, we apply the same principle to vSGIs as to vLPIs, and it
> > was found that this heuristic was pretty beneficial to vLPIs. I'm a
> > bit surprised that vSGIs are so different in their usage pattern.
> 
> IMO, the point is hypervisor not trapping vCPU WFI, rather than
> vSGI/vLPI usage pattern.

Sure, that's what's affecting your use case, but the logic in the kernel
came about because improving virtual interrupt injection has been found
to be generally useful.

> > 
> > Does it help if you move your "emulatorpin" to some other physical
> > CPUs?
> 
> Yes，it does, in kernel 5.10 or 6.5rc1.

Won't your VM have a poor experience in this configuration regardless of WFx
traps? The value of vCPU pinning is to *isolate* the vCPU threads from
noise/overheads of the host and scheduler latencies. Seems to me that
VMM overhead threads are being forced to take time away from the guest.

Nevertheless, disabling WFI traps isn't going to work well for
overcommitted scenarios. The thought of tacking on more hacks in KVM has be
a bit uneasy, perhaps instead we can give userspace an interface to explicitly
enable/disable WFx traps and let it pick a suitable policy.

-- 
Thanks,
Oliver

