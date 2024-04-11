Return-Path: <linux-kernel+bounces-140610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E08A16E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABDA1F21BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6314EC55;
	Thu, 11 Apr 2024 14:13:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC014E2F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844838; cv=none; b=V+VTLeikPDibc3Q2t2foQblWs2/0oF5MaCAApbhe8+Q2JqqbX5p+shUiOTO9enqyacDh87k6DDnAJf34DJA4niMuCTZKLetTNP9jODP64JaFmxKCpALSf+LY6vOMXzJE6oEgW1UXAXz0vSIjxDob7AX2gg509fTrN2XI9n95U/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844838; c=relaxed/simple;
	bh=NByPv6yv5P75S9oumtguMO6kDK+RUnXUMoQAexiicwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxa4ZseSZsyiILind4tAZ/wZLnDEPKeOyU7rGx+hl/wO4oWraW5jxK0i4EorUiisvoSQJnA/n464dDLaiGKj6xdmi9lGnW/c0v99E24fL/b7RItlM3KayZJPLshnI9ocmMoQhl8A4Jubm+ocYfnjOXeoM06y0OV4MUnRmk6GkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A018C339;
	Thu, 11 Apr 2024 07:14:25 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 533E83F64C;
	Thu, 11 Apr 2024 07:13:53 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:13:50 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
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
Subject: Re: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching
 into the arch code resource list
Message-ID: <ZhfwHj0+Z1cVoAuM@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-3-james.morse@arm.com>
 <1488fa2e-9552-4f52-bcf9-aeef68049ce0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488fa2e-9552-4f52-bcf9-aeef68049ce0@redhat.com>

On Tue, Apr 09, 2024 at 10:09:20AM +0200, David Hildenbrand wrote:
> On 21.03.24 17:50, James Morse wrote:
> > Resctrl occasionally wants to know something about a specific resource,
> > in these cases it reaches into the arch code's rdt_resources_all[]
> > array.
> > 
> > Once the filesystem parts of resctrl are moved to /fs/, this means it
> > will need visibility of the architecture specific struct
> > resctrl_hw_resource definition, and the array of all resources.
> > All architectures would also need a r_resctrl member in this struct.
> > 
> > Instead, abstract this via a helper to allow architectures to do
> > different things here. Move the level enum to the resctrl header and
> > add a helper to retrieve the struct rdt_resource by 'rid'.
> > 
> > resctrl_arch_get_resource() should not return NULL for any value in
> > the enum, it may instead return a dummy resource that is
> > !alloc_enabled && !mon_enabled.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb

Thanks; noted for James' attention.

Cheers
---Dave
> 
> 

