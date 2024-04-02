Return-Path: <linux-kernel+bounces-128317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E9895944
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC56B266EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18379140396;
	Tue,  2 Apr 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXVpxTBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A03611A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074086; cv=none; b=SGngSSjhPAOTgz1/8t8kMMSH9KmXVog6RIgnh3JcJLmCUFvE2ssEdOnfk2/2zGUtgCTRykiZVgcQev5dlfivfMepZ8QQA3lG41XkvWYVcSguQA1qeVedMgEpZ2PFNNWZuHzKGAo4JejMaR2URQACZ7RKsq79TfOy7aMaHUl7gJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074086; c=relaxed/simple;
	bh=v7GW57i9E9k0EfqiWo2KVoW23hWJbROx8FjWEao2q4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdM/B1y5CoCgEB8uDYb10PkcGeg6lYGiIVDrU0GdlmsHissNpe3aUqtluoJyMCH9txT5H/L2VI2Ghx1OYw/hp0Vq17jF5WoQ4tHFZwN0o0MfIqYBXG7dOXZozW2tQkVnuX370itrwyJne87N75avT6/GvQA/EgqX/lz0Mdg2UtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXVpxTBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3F2C433C7;
	Tue,  2 Apr 2024 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074085;
	bh=v7GW57i9E9k0EfqiWo2KVoW23hWJbROx8FjWEao2q4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXVpxTBeREZDDlnPbDi7GFMTwk+Wyz5Iujn/4RO4km6aEiZO7T8fYxPac6iQmcY8U
	 60qK79cHg3kMF/Sx9IpO/u+y0UDZjc/NkHm3HhM+fsLFMGMMMImpctbsk8BqxV9lhF
	 8FboASrngFqQEADgtvPAHrBcfdsYL/TbQjLki6BcT8T9LKs7k0a+iHIEs2jpusg8x0
	 Y/MGL4T6zQwsXLqjo2fqlkfBao+Ym7+0epd1VsxGqHRXrcNivGJ8kKKdsKosWsB0eF
	 APcBK/Uc8GBVfIZV528bwKfJuMAkceB6g1HP+kYtj6wCE5R+5YRTs8IRirut/3thRu
	 flvSSe+lLBDqA==
Date: Tue, 2 Apr 2024 10:08:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Message-ID: <ZgwtYpbcyM_ffjaF@kbusch-mbp.dhcp.thefacebook.com>
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
 <20240402131658.GA31963@lst.de>
 <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>

On Tue, Apr 02, 2024 at 05:13:48PM +0200, Georg Gottleuber wrote:
> Am 02.04.24 um 15:16 schrieb Christoph Hellwig:
> > On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
> > > From: Georg Gottleuber <ggo@tuxedocomputers.com>
> > > 
> > > On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
> > > power consumption in s2idle sleep (2-3 watts).
> > > 
> > > This patch applies 'Force No Simple Suspend' quirk to achieve a
> > > sleep with a lower power consumption, typically around 0.5 watts.
> > 
> > Does this only apply to a specific SSD or all SSDs on this platform?
> > How do these platforms even get into the conditional?  Probably
> > through acpi_storage_d3 setting, which probably is set incorrectly
> > for the platform?  Any chance to just fix that?
> 
> Yes, this only apply to a specific SSD. I tested these SSDs (on
> PH4PRX1_PH6PRX1):
> * Kingston NV1, SNVS250G
> * Samsung 980, MZ-V8V500
> * Samsung 970 Evo, S46DNX0K900454D
> * Samsung 980 Pro, S69ENX0T709932L
> 
> S2idle consumes around 0.4 watts with these SSDs. But with a Samsung 990 Evo
> s2idle on this platform consumes 3.7 to 4.4 watts (6.8 vs 6.5 kernel).

For all these different SSDs you tested in this platform, do you see the
"platform quirk: setting simple suspend" in the dmesg? I just want to
confirm if the platform is changing the reported acpi_storage_d3 value
for different SSD models or if they're all the same.

