Return-Path: <linux-kernel+bounces-128024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1A89550F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF0D1F232C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EA84A22;
	Tue,  2 Apr 2024 13:17:06 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7668062A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063825; cv=none; b=m6tjfjMzbJPiI6bcpkTy1yQMURsgFM1M/HnnoE35MUj6k02clXkgL7VaDYC5wJHgYFnULE5he7v/C7CK5dfcI3AkN3k/P2ZpmWqpxv41WM5Le0/6QVRoNoJCDPwk5xOVHijoXPouIPIhtNy2D58ulgU/hDKYU9e3M09Ktqr0IcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063825; c=relaxed/simple;
	bh=Vs95lcleQMyylaVurGFGyI+T8qiCucHT2M+4xwX9kcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPMC2WAXshX0K0kE+UFKnPcNjnr+jwLxD+1nD6DnWocaU/VMsbLCiyi2K4JYHgKkpUmKvSpreeAHOF1zdN0OIiOUPr4f5PAvWuABUgDrRFh7bBu9iMRWB7/azJ5dsRAOXTdtjFyk76zxmNz38YL+gFMyZh8ZImy9apspx/9VW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54EA368BFE; Tue,  2 Apr 2024 15:16:58 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:16:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Message-ID: <20240402131658.GA31963@lst.de>
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328130923.61752-1-wse@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
> power consumption in s2idle sleep (2-3 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a
> sleep with a lower power consumption, typically around 0.5 watts.

Does this only apply to a specific SSD or all SSDs on this platform?
How do these platforms even get into the conditional?  Probably
through acpi_storage_d3 setting, which probably is set incorrectly
for the platform?  Any chance to just fix that?


