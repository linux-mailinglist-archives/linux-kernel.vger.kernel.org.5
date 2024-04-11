Return-Path: <linux-kernel+bounces-140623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C732F8A16FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873EDB2A677
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C68114F10A;
	Thu, 11 Apr 2024 14:16:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B714D43D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844999; cv=none; b=OHZ0r8UStsc/cfU83YKwYUCeFcFZMeJeXv5AdCtlLIpU2SeCHYR+/9NPCv/lrf1BS2mUSA9MuJYMxlEcg9yyFaHBvPUOg5aSX2UiLyiZPwNRUK6OkNjyYf1/LfIbYokqeMkukW+AmH6QL6sfx8a+9W4XzTMkNU8dch9QxFYrh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844999; c=relaxed/simple;
	bh=zSAbjkFKCDta7vFkL6hXmhKpRKDYpI1+zNkB0vTle5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiEgxy5OAExyMFi/fYQTz1ECw9vV6z41SLVt8419eGZD7hQxSvOYnhh5UOYqm9oF0FPKrbce30bGXNDIhCyurdhqOfVbJCNk+eGOi8c1YkLDDQycSwJyotN938L66Q1IWQbjYDT5ZUsDO6vZdOgzrkXCSpFFPUecwURR6sdmva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98367339;
	Thu, 11 Apr 2024 07:17:07 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C193F64C;
	Thu, 11 Apr 2024 07:16:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:16:32 +0100
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
Subject: Re: [PATCH v1 16/31] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
Message-ID: <ZhfwwMVYjzyTgpz2@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-17-james.morse@arm.com>
 <8bc4cc50-ca1d-404b-9cb2-db31c89fbb13@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc4cc50-ca1d-404b-9cb2-db31c89fbb13@intel.com>

On Mon, Apr 08, 2024 at 08:20:41PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > mon_event_config_{read,write}() are called via IPI and access model
> > specific registers to do their work.
> > 
> > To support another architecture, this needs abstracting.
> > 
> > Rename mon_event_config_{read,write}() to have a resctrl_arch_ prefix,
> > and move their struct mon_config_info parameter into the restrl_types
> 
> Looks like this change is actually moving the struct into include/linux/resctrl.h,
> not resctrl_types.h.

Noted.

> 
> > header. This allows another architecture to supply an implementation
> > of these.
> > 
> > As struct mon_config_info is now exposed globally, give it a 'resctrl_'
> > prefix. MPAM systems need access to the domain to do this work, add
> > the resource and domain to struct resctrl_mon_config_info.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> 
> ..
> 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index bfc63e8219e5..975b80102fbe 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -192,6 +192,13 @@ struct resctrl_cpu_sync {
> >  	u32 rmid;
> >  };
> >  
> > +struct resctrl_mon_config_info {
> > +	struct rdt_resource *r;
> > +	struct rdt_domain   *d;
> > +	u32                  evtid;
> > +	u32                  mon_config;
> > +};
> > +
> 
> Please use tabs consistently in this file.
> 
> Reinette
> 

Noted; I have presumed that you mean tabs-only indentation before the
member declarator, and to line up the declarators (including the *),
e.g.:

struct resctrl_mon_config_info {
	struct rdt_resource	*r;
	struct rdt_domain	*d;
	u32			evtid;
	u32			mon_config;
};

(But if that's not what you meant, please shout!)

Cheers
---Dave

