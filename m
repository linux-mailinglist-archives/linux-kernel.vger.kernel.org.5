Return-Path: <linux-kernel+bounces-143028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB68A3362
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A56F281DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19FF148FEE;
	Fri, 12 Apr 2024 16:13:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7D1487E4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938411; cv=none; b=GTj2Adcbv0L/uEPZ+d0bjVNqE5k5HoGqIR/Kvvg5xrZ7hXDCGquC8pSmXTQDUKCN2ZTxCoiV5eLznOQmikEAn+e/j0byDjlnXRVkZIybB5wzMQqp+NSWWf2wKijG+oLopWTsTwMMg7Xf3Lzu/EEXbHTAIyfe+A1JZe+Y26gsLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938411; c=relaxed/simple;
	bh=Q4V6Zn9TStSChaSxBLObNVv7hgA1ULUGeyWgeYmigkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtCbdldEl3II2Zp8m+4HzE3t3LpViZlZEeZtM3ISQYV66n9WP7tFQOoj6O1a4kiLZRcUCcu2IHHwDUDFNAZsXM7gLuohgdQbWyfa5sF5vR7QtsiIE/wWXUw/zIGhrmZy9ePIDfmI+J8Z4oafAxwZU7td4D96b8f/6FrRcHO1ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 255B0339;
	Fri, 12 Apr 2024 09:13:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 340723F64C;
	Fri, 12 Apr 2024 09:13:26 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:13:23 +0100
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
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
Message-ID: <Zhldo59cSmSLwFGZ@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-4-james.morse@arm.com>
 <1776b49b-3c0e-41a7-bbc5-19310c428429@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776b49b-3c0e-41a7-bbc5-19310c428429@redhat.com>

Hi,

On Tue, Apr 09, 2024 at 05:13:01PM +0200, David Hildenbrand wrote:

[...]

> > @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> >   	return 0;
> >   }
> > +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> > +{
> > +	if (res->fflags & RFTYPE_RES_CACHE)
> > +		return &parse_cbm;
> > +	else
> > +		return &parse_bw;
> > +}
> 
> Besides what Reinette said, I'd have added here something that would fire in
> case someone adds something unexpected in the future, like
> 
> WARN_ON_ONCE(!(res->fflags & (RFTYPE_RES_CACHE|RFTYPE_RES_MB));
> 
> At the beginning of the function.
> 
> 
> Apart from that, nothing jumped at me.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

Thanks for that -- I guess that would benefit from discussion; please
see my reply to Reinette on this patch.

Cheers
---Dave

