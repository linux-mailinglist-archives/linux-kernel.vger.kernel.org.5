Return-Path: <linux-kernel+bounces-152792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C737A8AC44B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F02282DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E9481D1;
	Mon, 22 Apr 2024 06:37:43 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E93F9ED;
	Mon, 22 Apr 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767862; cv=none; b=QPnyx0WzX/Df2OSk2+wIUff4WI8gUJzSznsVEA4co8tSl6Qu0ddVBsUYGsD8F6DXeEKflXHbPI5MFjtAk95wUn6f4vh+h9N9eQphTC5xpUkxPdebxuD6u9gJn/beROlchzGq8CTqb/yeTHid04AffG1r3x22t502H8tpAxgEqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767862; c=relaxed/simple;
	bh=JC1IIk6PjUEaa0fE6CEQRFVeHjWHlAFA0r0s8+x8o4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0UYrwxlm8p9f9GMaDNrS/ZRBsaUV9vIU7HSgYRgv4VsuACuALjQ786ydOeyvWNvKafXbaD5O7DV/gYjHBsguK8C27pALD9uYCQRLp5JdiTlbyLagTJMvK4Y94xiUZRaHNCqTxMWv+zZrYjRgrTBpsuAu7k9jdA2xdXXOC6oO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A37E227A87; Mon, 22 Apr 2024 08:37:34 +0200 (CEST)
Date: Mon, 22 Apr 2024 08:37:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] iommu, dma-mapping: Simplify
 arch_setup_dma_ops()
Message-ID: <20240422063734.GA3750@lst.de>
References: <cover.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713523152.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 19, 2024 at 05:54:39PM +0100, Robin Murphy wrote:
> v3: https://lore.kernel.org/linux-iommu/cover.1707493264.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Since this ended up missing the boat for 6.9, here's a rebase and resend
> with the additional tags from v3 collected.

And just to clarify:  I expect this to go in through the iommu tree.
If you need further action from me, just let me know.


