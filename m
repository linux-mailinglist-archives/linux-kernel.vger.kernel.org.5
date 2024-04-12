Return-Path: <linux-kernel+bounces-142411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E08A2B32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF211C208BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0150A6C;
	Fri, 12 Apr 2024 09:29:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F05027F;
	Fri, 12 Apr 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914149; cv=none; b=O1XlfIW84J6oSC42gc7caJiWxYSIyS7odgsP4NzwqGZDVd6JpqvsrOGj+2oog5/deGQP4ErW8jWrQIfJ42+c88ynyLe8+jR6E1jPg3rhRGsJl6RBYy6Cf3+ta/cter/XjeSbwuHr+hh6o5gJ9bYv3YZVXftaOtfvDVcmuML1/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914149; c=relaxed/simple;
	bh=MgpXt/Mx0O9V+zmtUlxzBjAX6HbJAB9BjXBA9DE4/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp2GkLVmVpmdIi3dK9N84nhzFUmGJcQDVW8eTtY7H5JLN0o5UmL2ax2xxfYt5ux2qs2mCZWYM56xp33iIwZ/6J6QOuErpRHq3la+l1MZYHGx4UBTjjpvlhke8tZiboEpegz3LqcrcjQRkBvpGDsvjZW6ztPEnfSnDUqZPeXoR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A07339;
	Fri, 12 Apr 2024 02:29:37 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA2F23F64C;
	Fri, 12 Apr 2024 02:29:06 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:29:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
Message-ID: <Zhj-4C7xlklG1m5B@bogus>
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <ZhetojJewygmTf6N@bogus>
 <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>

On Fri, Apr 12, 2024 at 10:10:05AM +0800, yunhui cui wrote:
> Hi Sudeep,
> 
> On Thu, Apr 11, 2024 at 5:30 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> > > When the type and level information of this_leaf cannot be obtained
> > > from arch, cacheinfo is completely filled in with the content of PPTT.
> > >
> >
> > Which platform is this ? Is this arm64 based or something else like RISC-V
> > based ? That would help to understand some context here.
> >
> 
> Thanks for your response, RISC-V currently has this requirement.
> Please see: https://patchwork.kernel.org/project/linux-riscv/patch/20240407123829.36474-2-cuiyunhui@bytedance.com/
> 

It would be helpful for the review if you have such information in the
commit message.

--
Regards,
Sudeep

