Return-Path: <linux-kernel+bounces-33740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D42836E00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD1F286DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD20481B8;
	Mon, 22 Jan 2024 17:03:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE13CF75
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942982; cv=none; b=FrgLhcwEsUQTQ42xNy/a7gq7grURblcU2coVo/0MlpEo8DughTv2EHD1L/l4gYd0qY0Ch7CchCMICb3334WbAfEse0fufAxmZONL690mPZ9DEN4vZrprUjOcz/XvfIJyTh5/1Q0CeiPh6sp0oBVQ+cd66rbZskDYN6A2s/eQ3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942982; c=relaxed/simple;
	bh=VU0ItME50ybDzXwR3CBIHMkFjO4Bnlzrbk3pCd4K1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMNXuLMiVLFcdR9U0xyJeivnEeSgCuL1tT6/rcDGTnls2GGwnE2hfQAUTOm0VYo1DnGBasv2zPaCB0yfB96kJNcbqUNX0KkcmRJHAETKUf2ZPtlABJZRHraGhiomSoVPi2qZgtw++HAao2zyWHhZJD18W5gIjy2Ca2qNbCI769Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BF81FB;
	Mon, 22 Jan 2024 09:03:45 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE1A3F5A1;
	Mon, 22 Jan 2024 09:02:58 -0800 (PST)
Date: Mon, 22 Jan 2024 17:02:55 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Conor Dooley <conor@kernel.org>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	conor.dooley@microchip.com, robh@kernel.org, pierre.gondois@arm.com,
	suagrfillet@gmail.com, linux-riscv@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: cacheinfo: add init_cache_level()
Message-ID: <Za6fvzkrkZTxj_G5@bogus>
References: <20240122013510.55788-1-cuiyunhui@bytedance.com>
 <20240122-boxcar-conical-c728a709aa5c@spud>
 <CAEEQ3wmX7_VP-YM9NkesAhd+5zetw79AW9bo0YO7KGAeJX4eRQ@mail.gmail.com>
 <20240122-jawline-handling-e190c90ddcfc@spud>
 <CAEEQ3wn3vuPMG_=6skXcXNvnktv767nAENp=wmXoD_MAi7EuPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wn3vuPMG_=6skXcXNvnktv767nAENp=wmXoD_MAi7EuPw@mail.gmail.com>

On Mon, Jan 22, 2024 at 06:57:49PM +0800, yunhui cui wrote:
> Hi Conor,
> 
> On Mon, Jan 22, 2024 at 4:55 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Mon, Jan 22, 2024 at 04:32:15PM +0800, yunhui cui wrote:
> > > Hi Conor,
> > >
> > > On Mon, Jan 22, 2024 at 4:09 PM Conor Dooley <conor@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 22, 2024 at 09:35:10AM +0800, Yunhui Cui wrote:
> > > > > When cacheinfo_sysfs_init() is executed, the general weak function
> > > > > init_cache_level() returns -ENOENT, causing failure to add the "cache"
> > > > > node to /sys/devices/system/cpu/cpux/. Implement the init_cache_level()
> > > > > function on RISC-V to fix it.
> > > >
> > > > If you recall correctly, I asked you to explain how to reproduce this
> > > > when you sent the patch.
> > >
> > > In fact, the reason has been explained in the commit log. As for how
> > > to reproduce it, you can check whether there is a "cache" node in
> > > /sys/devices/system/cpu/cpux/ on the riscv platform.
> >
> > That's the thing - I tried to reproduce this several times and either:
> > a) The system had cache information in DT and the directory was
> >    created. If I hot unplugged and re-plugged the directory was
> >    re-created.
> > b) The system had no cache information in DT and the directory was never
> >    created.
> 
> Indeed, I verified it again, it’s because there is no cache node in
> dts, thank you for reminding me.
>

That's good. I wasn't able to figure out why the issue could occur without
issues in DT/ACPI.

-- 
Regards,
Sudeep

