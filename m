Return-Path: <linux-kernel+bounces-140709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F58A1806
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11AC284F16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B466310799;
	Thu, 11 Apr 2024 15:02:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38EEAC7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847765; cv=none; b=pv88BDUr7FZzRc/71O6RwQ2nHzmCLQu/1KLr+10UJmVB/nuaglyPvEeQjgPV/Z+1xj+H9xu5vdopx5ZisM70GEqXvsD3G1iMrF5GnohE3as7i7DN8vuZ8hBG5O8VZtm+27vNSexWoNO3VMK3dYM/grvpWOXcZRW/d9mo1rTQu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847765; c=relaxed/simple;
	bh=GxW7D8iDkkqi0EJ/T0AcUYMtwyqpLWSID7jQo7v8e2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVlxmgty2fI69dErLsbwX5/h4roGzjglohjXLe4tKh6Hp7lTe4II2ghHtNvfmrgQnzUNg2j6SboO5eh+3WjfsVH3FL3CJlEDw2YnhgY2Ts7Ig88tGKwgMlwLQUwZSSXxIqoHqG1BbjOqE5fRRETrA4nK2xZuW5NK1Uyf00zamoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C5C113E;
	Thu, 11 Apr 2024 08:03:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08B223F6C4;
	Thu, 11 Apr 2024 08:02:39 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:02:37 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
Message-ID: <Zhf7jZFPARAWFDyO@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
 <8d1d39ca-60f0-47e9-a090-f630c6df19ae@intel.com>
 <735f18df-0f63-44ba-adfc-70ead9ce9495@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <735f18df-0f63-44ba-adfc-70ead9ce9495@redhat.com>

On Tue, Apr 09, 2024 at 05:06:03PM +0200, David Hildenbrand wrote:
> On 09.04.24 17:02, Reinette Chatre wrote:
> > Hi David,
> > 
> 
> Hi,
> 
> > (Thank you very much for taking a look at these)
> 
> I'm planning on reviewing more; as most of resctrl is code I haven't really
> read before, I'm not able to make progress as fast as I normally would in
> core-MM ... :)

[...]

> -- 
> Cheers,
> 
> David / dhildenb

Thanks, all review is appreciated (I'm somewhat in the same boat myself,
but gradually finding my way around...)

Cheers
---Dave

