Return-Path: <linux-kernel+bounces-112831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF161887EC9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212751C20BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1DFC1C;
	Sun, 24 Mar 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxQ5Ls9W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bl5OoF1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7DF9DE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310740; cv=none; b=cDiHV9R2GZ9AApdeCq7uiTUt7xNAx4Fkbq5kWIs6dbP73jk49FfI/qvGIfSFNAWO8PFDIlPL91BRG9oLHsxF++36Pfc39ucO0JM7mSe2+MhzYa8ELa0uMAwMZkSFnXCJQECu4HN39sZ4JbZqXoW9wucPm/+yE/mFvhUYIaHe76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310740; c=relaxed/simple;
	bh=MklU3DYa778v4ZDWFXMxmTI+sKqEUz89Ifhdj7zrlEE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=lapRmOhkAZGKzvjRTk6TWkQ7q6Krue/lwmtCTR1/I8KLkBd6tS6vHTI/2sJJeQOpwV/WQbU7Mcop9fGLgHGfrg4260xtVVWO4fNRMNYVwzIfj8WsnWqA/DlFgyxvJ68C5lb6CK/0n0rdCp97HwD9x8cs88Y/+Bli0/4GzKMckNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AxQ5Ls9W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bl5OoF1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711310736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=tEQkubM2Zqs51Lu+6zFTonIBP1O9zapY/XByNh3O9KE=;
	b=AxQ5Ls9WHGsg+/L7l6fVJ+FYRs0dCJZhZqv4lzn8ilJUG7/281abD67NSBHWg+ADOz4zhg
	NYCg/az9ZqQBYNIKcyfy3SZCJvphBFPZQQ7XwBybUXtnKZHNU8G0fiqNHFgfGnhVmf21t5
	DyJ0ybGwqyPeRdceWPdtnZe2K6VyF3vINjRZ69yt90PbTW9ZjMPhUKQKgOjDhP0Tt9Kcr+
	w1diJI0jdyGiWOBGYtPpOb0IXL/wb9ihxpFXmoMm7MnQztl3DG7ZP3mwzdHiC7zJ1D65nJ
	iTTEkrHKfcLKoznPgtP/YyXwAfIDN+mbJ5gdTXqv7sREShefdAjxsryidstGVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711310736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=tEQkubM2Zqs51Lu+6zFTonIBP1O9zapY/XByNh3O9KE=;
	b=1bl5OoF135n3KM4dsxyeTA6m6aUzU53gitNgkAs88vPDVUOxVSsDgnFBtIkwP8qgThS4hk
	VtCqDd0u15GMqFAQ==
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Russ Anderson <russ.anderson@hpe.com>, Dimitri
 Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
In-Reply-To: <Ze9r47riIq9ovBCY@hpe.com>
Date: Sun, 24 Mar 2024 21:05:35 +0100
Message-ID: <87plvjfl9s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dimitri!

On Mon, Mar 11 2024 at 15:38, Dimitri Sivanich wrote:
> On Thu, Feb 29, 2024 at 11:18:37PM +0100, Thomas Gleixner wrote:
>> What you really want is a cpu hotplug state in the CPUHP_BP_PREPARE_DYN
>> space which enables the interrupt for the node _before_ the first AP of
>> the node is brought up. That will solve the problem nicely w/o any of
>> the above issues.
>>
>
> Initially this sounds like a good approach.  As things currently stand, however,
> there are (at least) several problems with attempting to allocate interrupts on
> cpus that are not running yet via the existing dmar_set_interrupt path.
>
> - The code relies on node_to_cpumask_map (cpumask_of_node()), which has been
>   allocated, but not populated at the CPUHP_BP_PREPARE_DYN stage.
>
> - The irq_matrix cpumaps do not indicate being online or initialized yet, except
>   for the boot cpu instance, of course.
>
> So things still revert to boot cpu allocation, until we exhaust the
> vectors.

I thought about the following:

    CPUHP_BP_PREPARE_DYN allocates the hardware interrupt on the control
    CPU (the boot CPU during early boot).
    
    CPUHP_AP_ONLINE_DYN moves it over to the AP. This needs to set
    affinity and then retrigger the interrupt so that the horrible
    non-remapped MSI migration logic is invoked.

Though that does not work for parallel bringup as then the prepare stage
is invoked for all CPUs before any of them gets to the online phase,
which obviously ends up with the same problem.

> Of course, running the dmar_set_interrupt code from a CPUHP_AP_ONLINE_DYN state
> does work (although I believe there is a concurrency issue that could show up
> with the current dmar_set_interrupt path).

Which concurrency issue? CPU hotplug is fully serialized.

> So the code seems to have been designed based on the assumption that it will be
> run on an already active (though not necessarily fully onlined?) cpu.  To make
> this work, any code based on that assumption would need to be fixed.  Otherwise,
> a different approach is needed.

Yes, the interrupt vector code it is designed that way and for the
general case this is absolutely the right thing to do.

Thanks,

        tglx

