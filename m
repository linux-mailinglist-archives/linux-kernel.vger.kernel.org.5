Return-Path: <linux-kernel+bounces-140619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EC8A16F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBD0B29B20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AAD14EC4C;
	Thu, 11 Apr 2024 14:15:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1A14F10B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844947; cv=none; b=lOqrKF4ZBi/GlQ5M7KUSjHFqGUAen6sKkL3LfICbs6swvVHT6E9/IZj40PURkU/ip5/JpInzXP+w4lUOqT0R9orbFLQRj7QCSypT1/VBdYUvdAAjoJv33NKmMNO5+N1p9rae+NnIeDJnKiAs3k3cIAwU3sNLTWB6MRzVsrfoHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844947; c=relaxed/simple;
	bh=ddUj8LERv2D+oA+42bVqj+XXkwRPZ6pGmvFDhHrgfc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7Vcr67ZgPz8genc3JHX89avjFO4IkZeYBrWsDGcoAtatkg0ut1CQKmKmF3urJcihyc3KDnaofVL1jjT9B4qhXjDuQJmheQ75+MZPY1sPetq2L5qDOzrQwQ5EbSVUeDAZFYMIJR1WhEZH9aBgFwQRt2NGXYQ5IPeV19ZTy9adq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDBDA339;
	Thu, 11 Apr 2024 07:16:14 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70B133F64C;
	Thu, 11 Apr 2024 07:15:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:15:40 +0100
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
Subject: Re: [PATCH v1 12/31] x86/resctrl: Move max_{name,data}_width into
 resctrl code
Message-ID: <ZhfwjBJPeTvO04BL@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-13-james.morse@arm.com>
 <fc4ee516-54b7-47cb-b881-00ce10d311a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4ee516-54b7-47cb-b881-00ce10d311a9@intel.com>

On Mon, Apr 08, 2024 at 08:19:15PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > @@ -2595,6 +2601,12 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
> >  	if (cl > max_name_width)
> >  		max_name_width = cl;
> >  
> > +	/*
> > +	 * Choose a width for the resource data based on the resource that has
> > +	 * widest name and cbm.
> 
> Please check series to ensure upper case is used for acronyms.

[...]

> Reinette

This patch is just moving existing code around AFAICT.  See:
commit de016df88f23 ("x86/intel_rdt: Update schemata read to show data in tabular format")

Since no new usage of any term is being introduced here, can it be
left as-is?

There seem to be other uses of "cbm" with this sense in the resctrl
code already.

Cheers
---Dave

