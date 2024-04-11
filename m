Return-Path: <linux-kernel+bounces-140659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60408A1767
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764871F21987
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D7CA73;
	Thu, 11 Apr 2024 14:38:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37AB646
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846287; cv=none; b=s12d25hPDAVYj5PIpfgz9iRp49L8/snVdb6E4eY9eKWGL+qquzUXFO91eEug4JjHIcbDDyHvIMlusvTrMHIHpWkQZgAOHszs+u0qMFSNLn7k+YT3G1sZos+sgFompmmSYb0dNMfFW99nxadP+kwY+QcRlAVI+tceu8NW33PCA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846287; c=relaxed/simple;
	bh=92wBbAB6KhpN+zXwllSeBQokZidS5cHSIVW7bjUyxsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEmUsERvjbVWO3oo/ewEStVF/mqa0k3gukeeFFQKKaHAGX24BjkRZ4RElRJEv2AP9g87ujTZH6sS7WWtbBucRlE6my+s1Eoc6QCuix9e4dRYOh+AnstqzarBlOEOIh0bxWMZjKTr+7JB/ZZjxAH8o4Xj6cDiOd/e4GRALgRmTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CF08339;
	Thu, 11 Apr 2024 07:38:35 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33973F64C;
	Thu, 11 Apr 2024 07:38:02 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:38:00 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
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
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Zhf1yF7Qc/df67jn@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
 <a8a95b4f-8913-4896-b01c-cbf80f931894@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a95b4f-8913-4896-b01c-cbf80f931894@intel.com>

On Mon, Apr 08, 2024 at 08:43:30PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:51 AM, James Morse wrote:
> > resctrl is linux's defacto interface for managing cache and bandwidth
> > policies for groups of tasks.
> > 
> > To allow other architectures to make use of this pseudo filesystem,
> > move it live in /fs/resctrl instead of /arch/x86.
> 
> "move it live" -> "move it to live"?

Noted, thanks.

> > 
> > This move leaves behind the parts of resctrl that form the architecture
> > interface for x86.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> > Discussion needed on how/when to merge this, as it would conflict with
> > all outstanding series. It's probably worth deferring to some opportune
> > time, but is included here for illustration.
> > ---
> 
> For reference, there are currently two series that are ready to be
> considered for inclusion:
> 
> https://lore.kernel.org/lkml/20240308213846.77075-1-tony.luck@intel.com/
> https://lore.kernel.org/lkml/20240408092303.26413-1-haifeng.xu@shopee.com/
> 
> Reinette

Understood.

Cheers
---Dave

