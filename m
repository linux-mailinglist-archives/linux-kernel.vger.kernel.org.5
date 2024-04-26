Return-Path: <linux-kernel+bounces-159835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA358B34EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032511C214D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2531428F8;
	Fri, 26 Apr 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tkWD9+yC"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4313FD9B;
	Fri, 26 Apr 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126079; cv=none; b=ig8IjSuF4gr3R9j/xjybKQ5LgE2ZvubLjFa3d2Kumd8UU8tUYvGMuiOnk/G4rkMqzaaYyWeRTdqYc7usGG4oZEFOuCzWnAuCcgFkDdNnIzeTH64ra8L5TIXmVtfXQnFSa2whiLY3ct5ydGGNxGoj2HfZkflhPzONtX6hm/wgTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126079; c=relaxed/simple;
	bh=ROQPW28f+YqmHnZpNtgoEUCyWbPcwUXFXrPacMNkuDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8Fuh1XTEt+cwNP2t/yUwERQ4rrIOTqPdL0TWKoCA23VwzVkhrxcDUY1iJANk7B2ieDVMX6MoFeXPYxqH4GkjbbEtFtet3vJVcFzVqC54y70EcUNS6myDowp1UMHUfj+9rEevFkeC25j0MYYTRYAT3jHJupZJ9GORq/BwMjNWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=tkWD9+yC; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 85D281C7DB9;
	Fri, 26 Apr 2024 12:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714126076;
	bh=ROQPW28f+YqmHnZpNtgoEUCyWbPcwUXFXrPacMNkuDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkWD9+yC1nQszByH93JUjZ7PJerqv34yWuUQbF2u8uvwyEiig+zAG+QOT5sdjn7Dn
	 Tvln3lrfMZVYTNIX3BiFCFiBN/kFWY0Oqoe9zylnAY22YK9aYJGUPNpEGVPpASdFU6
	 tk+DYUrmJoGt1opeoyCB1J01fwrCft0B7P6fj+ImxzcwH4lhtuGSDgY5cXBdFH9Q0n
	 dT6+0wldLCFgJ2k+63mN4s+/u6ZDDjWot1stiAUmrhnIVVdJO3yPsPkQS7L8624/81
	 QUHeIj5xgi1oKojsLL/XAyeqMiWwDlJSvSJr2CpwliD1LUuJEyWSuUPWGu+g0+uILg
	 tITNwtkFB4vFQ==
Date: Fri, 26 Apr 2024 12:07:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>,
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
Subject: Re: [PATCH v4 0/7] iommu, dma-mapping: Simplify arch_setup_dma_ops()
Message-ID: <Zit8-z7jfbzLoQKf@8bytes.org>
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

On Fri, Apr 19, 2024 at 05:54:39PM +0100, Robin Murphy wrote:
> Since this ended up missing the boat for 6.9, here's a rebase and resend
> with the additional tags from v3 collected.

Applied, thanks.

