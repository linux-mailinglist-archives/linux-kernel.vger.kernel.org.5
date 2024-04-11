Return-Path: <linux-kernel+bounces-140618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F78A16F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3543AB29868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74B14F103;
	Thu, 11 Apr 2024 14:15:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6D14B09C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844931; cv=none; b=QNozCxNdorbUrrFMhajqkCgVlsT21wcW7l39i/op9D+ozftA8X6oUAG7a9oApdkQDi+d53o1YptDHibeXCOiSp0CBKpVjIMidlIkInZkURUh6IAgf7eaHJevfvNGf+oBsTrl1RfLprPS5xvokHpVKK64OToPUhKdZJW3OsrMUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844931; c=relaxed/simple;
	bh=xYTEtJd3jX6lHoibME6XnWLIsyGQx9FKXlixpmOQ0D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puqqNcACXkVOs5RGHzPULZVoHhj1NljP4dYDwaWCKHX85Cf9vtIGPMImLlQyRf95d87oVcUYG8QMOTlddXCYCxGgrvv5bN79Ig70VBAKt9H0sPJJEjhPByKU0tv+GrW8+J2glRmTJf8q39+wJHVuDeV3RKuvvf3j19pI9gSwqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95ED2339;
	Thu, 11 Apr 2024 07:15:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48E393F64C;
	Thu, 11 Apr 2024 07:15:26 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:15:23 +0100
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
Subject: Re: [PATCH v1 11/31] x86/resctrl: Move monitor exit work to a restrl
 exit call
Message-ID: <Zhfwe6Xhyec20LzC@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-12-james.morse@arm.com>
 <92187846-374f-4b45-865e-543ba198b6b9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92187846-374f-4b45-865e-543ba198b6b9@intel.com>

On Mon, Apr 08, 2024 at 08:19:00PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > rdt_put_mon_l3_config() is called via the architecture's
> > resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
> > and closid_num_dirty_rmid[] arrays. In reality this code is marked
> > __exit, and is removed by the linker as resctl can't be built
> 
> resctl -> resctrl

Noted, thanks (also, there is "restrl" in the subject line.)

> 
> > as a module.
> > 
> > MPAM can make use of this code from its error interrupt handler,
> > a later patch drops all the __init/__exit annotations.
> 
> Reminder:
> https://lore.kernel.org/lkml/85f8756a-23a0-444e-b37d-a7817b600f46@intel.com/

The "Drop __init/__exit on assorted symbols" patch speaks for itself,
I guess. I think it's probably sufficient for now to comfirm that this
patch is deliberately not changing the annotations for now.

Does the following work?

--8<--

Since there is no immediate need to change them, leave the __exit
annotations as-is.  This will need to be revisited as and when there is
a need to call these functions other than at __exit time.

-->8--

Cheers
---Dave

