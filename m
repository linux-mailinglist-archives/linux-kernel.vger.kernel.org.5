Return-Path: <linux-kernel+bounces-71107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA6485A0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91C9B20F59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289425616;
	Mon, 19 Feb 2024 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCIaCRfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC625578;
	Mon, 19 Feb 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337664; cv=none; b=pzuYf89n0KZg2svws5eOKhk4iIlyElWJqV9K0GqrB0PlV08N4KeV7n9LhYCHhpZEYcmn11Q9+2kBOobscp1Rx1hHnYVj5E3umlzo0fv8J0Xw1Du/trvjmAJTRfwYkyA3KVrAUH8xu0vamS/eW47a6twA8vPx1IfdnV2hC01lrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337664; c=relaxed/simple;
	bh=K3J0vKJVPad+IJa84bJTXYXRmr6TrQbBJDYX8wAuwh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPyCfZavgWwxr7LKvHcL+5xJgBxxLGOKEcaoK6Qe1HbS/1fKSGzSBYEjRNrO9q5/GQA3v+pCPeLTL6YpaM0ceoJClEGzksar+AozmyEYvJDQnTeQ++l/WjqFDfS9ARSQ6YhN94pf1fHIBN5Y+Q0trhl6d3kp7iPOWiHvNII93FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCIaCRfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF580C433F1;
	Mon, 19 Feb 2024 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708337664;
	bh=K3J0vKJVPad+IJa84bJTXYXRmr6TrQbBJDYX8wAuwh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCIaCRfm9+Hj4pbM8C1HiQhH3bo/YSgXtM16y/TjgebFrTqXMmsWrz8v5bZFXU8UZ
	 NZI5AtP4cqrDeWVqmWeW42NM8Nc29jV6uTYbZhK8tam/2zZiQs1PEOgsJCCrujbBSK
	 GVKncyOhmeS+RiKH3WXrgaAtdLqFdhbaHZBFVpOggbuG1rx2KMLHPAw7Wb0Tmcrowz
	 O4luoa5cDRruqZPUX1Lc7RvdUj6vBO3wNGbAB8osw2B7ijQOS7GLTFp39YaeUUfMSC
	 k8ia4Lu4J/rwDkfTs4xe+AS5KyYr/fVqAhgbE5LGkFma3E01MYOctZBwlo1jJTIhPX
	 e0Rg33lxZF6OQ==
Date: Mon, 19 Feb 2024 11:14:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, p.zabel@pengutronix.de, axboe@kernel.dk,
	michal.simek@amd.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Message-ID: <ZdMp+QBiays6fprk@x1-carbon>
References: <1708107297-1798828-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708107297-1798828-1-git-send-email-radhey.shyam.pandey@amd.com>

On Fri, Feb 16, 2024 at 11:44:57PM +0530, Radhey Shyam Pandey wrote:
> Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
> error path.
> 
> To fix introduce the function ceva_ahci_platform_enable_resources() which
> is a customized version of ahci_platform_enable_resources() and inline with
> SATA IP programming sequence it does:
> 
> - Assert SATA reset
> - Program PS GTR phy
> - Bring SATA by de-asserting the reset
> - Wait for GT lane PLL to be locked
> 
> ceva_ahci_platform_enable_resources() is also used in the resume path
> as the same SATA programming sequence (as in probe) should be followed.
> Also cleanup the mixed usage of ahci_platform_enable_resources() and custom
> implementation in the probe function as both are not required.
> 
> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> Changes for v3:
> - Modified commit description as suggested by Damien Le Moal.
> - Add missing return in dev_err_probe("failed to get reset")
>   pointed by Niklas.
> 
> Changes for v2:
> 
> - Create wrapper ceva_ahci_platform_enable_resources()
> - Remove legacy ahci_platform_enable_resources() and its related code.
> - Modified commit description and merge 1/2 and 2/2 fix as it is
>   automatically done when reusing ahci_platform_enable_resources()
>   logic.
> - Drop Reviewed-by: Damien Le Moal <dlemoal@kernel.org> tag.
> ---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes

