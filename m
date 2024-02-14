Return-Path: <linux-kernel+bounces-65417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E8B854CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118F92814C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063115C911;
	Wed, 14 Feb 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQC8f84J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D85A0FB;
	Wed, 14 Feb 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924533; cv=none; b=GCLrjxj+yw8pLuP+wCSwI1Pwy18DDy4f7ev60oNAikKQ0w+Et67z1AEmab/PYwWvHgur38CEHUzuvrWmNmftEeJbloVH7jcpPR3QuQ1Jh492Aw6I2AUbKQzQnPVLVzwp4UJSKEgAj04YDwD5TA+IVglgg9qhon+1qVhxuvsghQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924533; c=relaxed/simple;
	bh=/5re9uwAhjRh/Dvs/PjZcKYRVJX4Mawl39c28gZZtzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwvMvJ/drZlXRrOXhzJdV0tseW1T9QeGcJKA6dYIm0mqCtOminof8xEzY2CK7eHoKitZ1yEQ3mQ3PmWbG/n/1GBVemrmLg8oTGMPBmFlAax9mzpqpI2DSIAMka4qN/uEhM6JR6SdmJQ3pqdpFZeCr1yAqdDx7J8eM8tw2g7dbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQC8f84J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC46C433C7;
	Wed, 14 Feb 2024 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924533;
	bh=/5re9uwAhjRh/Dvs/PjZcKYRVJX4Mawl39c28gZZtzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQC8f84JIBRyEAhPojBIqtxXOFd127/eeGx6LffRh0u5RioYRpV0jYsQsjq1ma3hM
	 6Bu5SoKvh8eJYVDFMJeOZwUGG3PgiHHPyjEWchFnJZbPRvAeJ5bCF8ER8b3sPHF2K5
	 33I2OO4PV4VofZ6DUnBe6Nx1/lAjjoN4uOmyaMWs=
Date: Wed, 14 Feb 2024 16:28:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	regressions@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Chen-Yu Tsai <wenst@chromium.org>, asahi@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Message-ID: <2024021438-rental-pretzel-4969@gregkh>
References: <20240209163454.98051-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209163454.98051-1-srinivas.kandagatla@linaro.org>

On Fri, Feb 09, 2024 at 04:34:54PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc1 on
> Apple M1, which (in downstream dts files) has multiple nvmem cells that use the
> same byte address. This causes the device probe to fail with
> 
> [    0.605336] sysfs: cannot create duplicate filename '/devices/platform/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
> [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                 6.8.0-rc1-arnd-5+ #133
> [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
> [    0.605362] Call trace:
> [    0.605365]  show_stack+0x18/0x2c
> [    0.605374]  dump_stack_lvl+0x60/0x80
> [    0.605383]  dump_stack+0x18/0x24
> [    0.605388]  sysfs_warn_dup+0x64/0x80
> [    0.605395]  sysfs_add_bin_file_mode_ns+0xb0/0xd4
> [    0.605402]  internal_create_group+0x268/0x404
> [    0.605409]  sysfs_create_groups+0x38/0x94
> [    0.605415]  devm_device_add_groups+0x50/0x94
> [    0.605572]  nvmem_populate_sysfs_cells+0x180/0x1b0
> [    0.605682]  nvmem_register+0x38c/0x470
> [    0.605789]  devm_nvmem_register+0x1c/0x6c
> [    0.605895]  apple_efuses_probe+0xe4/0x120
> [    0.606000]  platform_probe+0xa8/0xd0
> 
> As far as I can tell, this is a problem for any device with multiple cells on
> different bits of the same address. Avoid the issue by changing the file name
> to include the first bit number.
> 
> Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
> Link: https://github.com/AsahiLinux/linux/blob/bd0a1a7d4/arch/arm64/boot/dts/apple/t600x-dieX.dtsi#L156
> Cc: regressions@lists.linux.dev
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Rafał Miłecki <rafal@milecki.pl>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: asahi@lists.linux.dev
> Cc: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Hi Greg, 
> 
> Here is a fix in nvmem for 6.8, could you queue these for next possible rc.
> 
> Did not cc Stable as this is only targeted for 6.8 and no backporting is
> required.

Sorry for the delay, now queued up.

greg k-h

