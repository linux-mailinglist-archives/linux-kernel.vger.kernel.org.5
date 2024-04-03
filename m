Return-Path: <linux-kernel+bounces-129774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15A896FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF741C27267
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFC2148305;
	Wed,  3 Apr 2024 13:03:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855D146D4A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149407; cv=none; b=cQ9LNWo64mgPfoUZZ7a/c+9sgrfyEaOQOYXXdbl6+LmBtDqN3CWy7BXfPVtFo1KbfDk4WLTN7qEkpLFBb+4aQQ5I8n0QKrdmvAFIvE/hlhiyFOrHH/CAPwSnHBtrsetiezwRkqoJsSE4NGvcZHXAn94Tp3b8mNVNz9ox9BGebpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149407; c=relaxed/simple;
	bh=kIOhYZcFjaultZWhhUObnw752oNQT7/I+/PK/rbt4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDHuAViTleXYS+srS+0AOpu3JmE3orba4Kxfnn6xA5dXpWdNhAxBbIx2+jNM99eCHA7doJcvbJAx6nyv6ePclKHnjVRXJvJoUlwm50nCbsIT10wvTbVd8meU9z5+gW5oXi9ZJQP97W3Y00m2RmaZ7OpzsBCQSScoFaR0JdaPA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3259D1007;
	Wed,  3 Apr 2024 06:03:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28AB33F7B4;
	Wed,  3 Apr 2024 06:03:24 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:03:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bertrand Marquis <Bertrand.Marquis@arm.com>
Subject: Re: [PATCH v2] firmware: arm_ffa: support running as a guest in a vm
Message-ID: <Zg1TmTcqRbzla3nN@bogus>
References: <20240325081335.2326979-1-jens.wiklander@linaro.org>
 <ZgLrQ7FtDy3INX8F@bogus>
 <CAHUa44HuuPE_cs3i4XEvHpSV+T0koCqBPo66uOmYyQ1=Rx=NWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HuuPE_cs3i4XEvHpSV+T0koCqBPo66uOmYyQ1=Rx=NWw@mail.gmail.com>

On Wed, Mar 27, 2024 at 10:23:35AM +0100, Jens Wiklander wrote:
> On Tue, Mar 26, 2024 at 4:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, Mar 25, 2024 at 09:13:35AM +0100, Jens Wiklander wrote:
> > > Add support for running the driver in a guest to a hypervisor. The main
> > > difference is introducing notification pending interrupt and that
> > > FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
> > >
> > > The guest may need to use a notification pending interrupt instead of or
> > > in addition to the schedule receiver interrupt.
> >
> > The above statement makes me worry a bit that we are still not on the same
> > page about NPI vs SRI. NPI need not exist in addition to SRI. And in v1
> > you did mention you have SRI in the guest as well. Then why do we need
> > NPI in addition to that. As part of SRI, the callback  ffa_self_notif_handle
> > gets registered and will be called as part of SRI handling. What you
> > do in  notif_pend_irq_handler(), exactly what ffa_self_notif_handle()
> > already does.
> 
> That's my understanding of what an NPI handler should do to be able to
> receive per-vCPU notifications.
> 
> >
> > I am still struggling to understand the usecase here. If you just have
> > NPI and no SRI when running the driver in the VM, then it aligns with
> > my understanding of possible use-case(not the one you mentioned in v1:
> > where FF-A driver in VM will have SRI as OPTEE is the secondary scheduler)
> 
> OP-TEE is not a secondary scheduler. OP-TEE (the SP) is scheduled as
> usual by the normal world using direct request. OP-TEE doesn't receive
> FF-A notifications and I'm not sure it will ever be needed.
>

Sorry for my poor choice of words yet again. I meant VM kernel(running
as NS virtual endpoint) with OPTEE driver running in it as secondary
scheduler. IIUC, there will be another instance of OPTEE driver in the
primary scheduler endpoint(i.e. host kernel) and it will take care of
running SRI handler ?

> >
> > If we are supporting NPI or SRI, I think we can see if we can further
> > simplify this change, but I want to get to an agreement with usage model
> > before we dig into implementation details in this patch.
>
> The spec doesn't as far as I know explicitly make NPI and SRI mutually
> exclusive, it doesn't make sense to use both in all configurations.
> I'm trying to be as dynamic as possible when configuring the NPI and
> SRI handlers.
>

Fair enough

> If the kernel is a physical endpoint, it's easy, it only uses SRI and
> the SPMC will not give an NPI when asked.
>

Agreed.

> If the kernel is a virtual endpoint it might be more complicated since
> a VM may need to act as a secondary scheduler. That's not fully
> supported in this patch, since it can only schedule itself. SRI is not
> used in my current configuration. If a hypervisor injects an SRI I
> expect it to filter what's returned by FFA_NOTIFICATION_INFO_GET for
> this VM so it doesn't interfere with notifications for other VMs.
>

OK

> In my current configuration, the hypervisor uses NPI to signal pending
> notifications to the guest. I do not need a secondary scheduler since
> OP-TEE doesn't receive notifications. At a later time, we may have SPs
> that need to be scheduled, but that's not a problem I'm trying to
> solve here.

Understood. I will take a look at the patch with the above information.

--
Regards,
Sudeep

