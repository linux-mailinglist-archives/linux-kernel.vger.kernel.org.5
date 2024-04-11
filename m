Return-Path: <linux-kernel+bounces-140612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C88A16E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701DDB28BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6414EC4C;
	Thu, 11 Apr 2024 14:14:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B7514E2DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844853; cv=none; b=Rj+bsj97Jxj1Zade6YBlRBBL9oDMlQDq0T0yvM61YODivunUR6Dg8DatXGuWSJyuC52/mID0ptpni+ydHEv273GqoEGkxaATBbwqZix3RZ1avn78VAv8oW7KHt5T7jMdsnYRhsb346yB34phj/7DdyydLvKVNOb8mzOxLRGlmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844853; c=relaxed/simple;
	bh=lrH2+J0XXKxV+8Kj3RIW5S9eewJKSiihEZArAe73xUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+Rt/c+sAS89IzM8sOY8fd4jlUZ1bZjwPyRK9X020oe96iYbp5r1IbUCEZ9KGYPQV4jujTf7mpFhMkqK01jgd2nmaRly8uYO18vgWZCdgXmDXqgnJ6889H/X1/0r9FwT4OJlDnYxTbPJp6zfXtSSm/n5EEL+53FOkJZ2Fp2NFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2823339;
	Thu, 11 Apr 2024 07:14:40 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8537C3F64C;
	Thu, 11 Apr 2024 07:14:08 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:14:06 +0100
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
Subject: Re: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching
 into the arch code resource list
Message-ID: <ZhfwLunw/CFCekr8@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-3-james.morse@arm.com>
 <65e1a55f-eac7-4804-900e-abf1bc0a9041@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e1a55f-eac7-4804-900e-abf1bc0a9041@intel.com>

On Mon, Apr 08, 2024 at 08:13:58PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > Resctrl occasionally wants to know something about a specific resource,
> > in these cases it reaches into the arch code's rdt_resources_all[]
> > array.
> > 
> > Once the filesystem parts of resctrl are moved to /fs/, this means it
> > will need visibility of the architecture specific struct
> > resctrl_hw_resource definition, and the array of all resources.
> 
> rdt_hw_resource?

Looks like it.  Noted for James' attention.


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
> Patch looks good to me.
> 
> Reinette
> 

Noted, thanks.

Cheers
---Dave

