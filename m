Return-Path: <linux-kernel+bounces-103599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D587C1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821941C20F33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E496745E1;
	Thu, 14 Mar 2024 17:01:10 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5FDF53;
	Thu, 14 Mar 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435669; cv=none; b=Z7EW4qShg/lMDZ+5fBcTzjvlIpuiJUSXrPgAuyna1PdDdZevQmiEkPUe8bapmN+t1tTHK9xhoEPkQeWWIVMNOiTF5gnEe3o7sj7zIaJVgAt2bI9xtTT18QqlxFulbIK16LBeeyLzFJi8mbXJJkD1TCoIfTT/AMiJhH2oPbBkvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435669; c=relaxed/simple;
	bh=+/9AxFGa0W6Y9R5mfC2f2mSSAFoTOTJWGLqKpWY3otM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TH4Kdnla81SDuB1v1O60bpNHOxRN+TWdYXHz6e3mDfAvTDBrwNPke3A9l2Sn5/HB1tzCHVC8aeTwdT5Ck1SDuhUuw0zKcDxbdg+VtrngTg6WrBOzwKsKtwrrGlitc/WIcATloQODTMSzlP4wVGvfH1o+CeszkGsGmyT6qAv2S6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 08A9040AB2; Thu, 14 Mar 2024 10:01:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0604D40AAD;
	Thu, 14 Mar 2024 10:01:01 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:01:01 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
    Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com, 
    Matteo.Carlini@arm.com, Valentin.Schneider@arm.com, 
    akpm@linux-foundation.org, anshuman.khandual@arm.com, 
    Eric Mackay <eric.mackay@oracle.com>, dave.kleikamp@oracle.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, robin.murphy@arm.com, 
    vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com, 
    Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
In-Reply-To: <ZfL40N6HYzEQaEj1@shell.armlinux.org.uk>
Message-ID: <ec8f9afa-ea35-9a73-7238-b29d4a32dacb@linux.com>
References: <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com> <Ze9TsQ-qVCZMazfI@arm.com> <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com> <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com> <ZfCXJRJSMK4tt_Cm@arm.com> <ZfG5oyrgGOkpHYD6@bogus>
 <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com> <ZfHevcKpcb6i1fn5@shell.armlinux.org.uk> <ZfK30r8M6zx2aWU6@arm.com> <a210104f-a3af-4554-b734-097cfa77a470@samsung.com> <ZfL40N6HYzEQaEj1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 14 Mar 2024, Russell King (Oracle) wrote:

>> It is really surprising that this didn't blow up for anyone else so
>> far... This means that the $subject patch is fine.
>
> Wow. I guess we've been lucky with that allocation hitting memory
> containing zeros. Well done at tracking it down!

It would have blown up with slub_debug because that includes poisoning the 
contents of all allocations via the slab allocator. Why did that not 
occur? We should have seen a backtrace with data in registers etc showing 
poisoning values for an unitialized object.

Note that this was indeed triggered by OFFSTACK because 
(z)alloc_cpumask_var() only generates a kmalloc allocation if that option 
is set.

The config option was never set before my patch was applied on ARM64.


