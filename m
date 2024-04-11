Return-Path: <linux-kernel+bounces-140617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302B8A16EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2111288D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442C14EC49;
	Thu, 11 Apr 2024 14:15:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD914EC40
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844914; cv=none; b=pULCo3MnvDXcLl1P3WGyV96dXhIIhhL1flRtWbHQXRL55piDVGajeRW13/BRAWjzkjsZbfhSRpXNiKuF+5UFCNRMF7nKkRML+VF6+VGqGgss2b/OHB491gmGWDxg7LshdZJsUPIRM13a43JV5SuYD59y9lqxQl44z+1LZnw8e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844914; c=relaxed/simple;
	bh=tBwVtxSBMQcM3gTJe/ADrOfHAy0L66S9KG99F9o1+hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTqIcmQ4wBry6MXSlC57Nt1hDy8eA4O3ejy2rBJkhmc9LtbMih7oW/+mIojZROi+F2WdHjMRv7L3xc4/8JOzZrnyrbNmEfE2V6+EpKroJBqtI+3fMVWQQtCeE71+LSf4uMIhn9LFzE6seCwDlpCENvK6/Z3y9a6Xs/R8aM/VtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A628339;
	Thu, 11 Apr 2024 07:15:42 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D5AC3F64C;
	Thu, 11 Apr 2024 07:15:10 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:15:07 +0100
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
Subject: Re: [PATCH v1 07/31] x86/resctrl: Wrap resctrl_arch_find_domain()
 around rdt_find_domain()
Message-ID: <ZhfwazGdJk2NbWxI@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-8-james.morse@arm.com>
 <f0243dbb-f333-4c06-a315-ceaca8fa0bc2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0243dbb-f333-4c06-a315-ceaca8fa0bc2@intel.com>

On Mon, Apr 08, 2024 at 08:17:12PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > rdt_find_domain() finds a domain given a resource and a cache-id.
> > It's not quite right for the resctrl arch API as it also returns the
> > position to insert a new domain, which is needed when bringing a
> > domain online in the arch code.
> > 
> > Wrap rdt_find_domain() in a another function resctrl_arch_find_domain()
> 
> "in a another" -> "in another"

Noted for James' attention.


> > so we avoid the unnecessary argument outside the arch code.
> 
> Please do not impersonate code.

[...]

> Reinette

Noted.

Cheers
---Dave

