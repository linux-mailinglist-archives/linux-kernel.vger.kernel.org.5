Return-Path: <linux-kernel+bounces-90692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5112870371
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277BA1C215F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA73F8C0;
	Mon,  4 Mar 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pvl5NY5U"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E973B797;
	Mon,  4 Mar 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560623; cv=none; b=FKX7qqNz9VrUC80aQcU18Ct2SZvU/zPibTa+76yryfdQgA8saKJfQOQ9SVDpv/ui3MRHuT7oLZXcyZ1v836sO+hk0lzl2JlXzPWt4IxDlGbbyYjLdTgOmnxW/uWdq9fOc8aOLo8vGOYEcGTGyM2KJ57ouBpHop4u5QDp7txeBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560623; c=relaxed/simple;
	bh=LD/AgASlwrxqBIDBgB4m0hmo8Hapri/eJonpkMZCy1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZcCNF6sNfHnuaLJhvjfoIcSrW0h0EEBeiPg1g3lrpGQSXk32XUpwPRW6goxjedDnqp7uGL9DpUWHo/ZO4NnpS6kztcXQaE8N+T2CcLPDRnzmkYWEBr4XXSRv/U414I/W4SM96xmmGXrfHqDFiQ1M+Lk4U25QDjQNQjtKmutFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pvl5NY5U; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709560619;
	bh=LD/AgASlwrxqBIDBgB4m0hmo8Hapri/eJonpkMZCy1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pvl5NY5U/6KsC14RL4xbqefNMPgwztO8QUkpJqQ8yKpzZs3/Ix895cqDVNYxuhJan
	 e24WIbNh/3XsDD6pI9gSl/dPuPUmNKtcjwBnAJiXrATu/D/37wkvSCDYOJQlZtMWkp
	 vby9vUePcCzdLpy00bR6CizekNigfZJu6V/RsUKkyLEwyeilbiNJpVG4c+h6asqnjb
	 WHtJ02yqLYfaEn4rqbgKTYaZuoZk567fOe/qIu0n+VmjAVrhoW/Y0oK9w76XtTa1jN
	 Ubofr1xStvh+561IFwQU+iMnUnZdqvn1nGq+yKqiOHWwAajiIkN9co3VfZTPrDMbp5
	 rGRQPF+i/QofQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6509A37820C3;
	Mon,  4 Mar 2024 13:56:56 +0000 (UTC)
Date: Mon, 4 Mar 2024 08:56:54 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@collabora.com, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable
 cbmem in the arm64 defconfig
Message-ID: <36df8535-083f-4ce3-84c7-b8f652a9085b@notapiano>
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>

On Mon, Feb 12, 2024 at 09:50:04AM -0500, Nícolas F. R. A. Prado wrote:
> This series adds the missing pieces to the coreboot bus and the module
> alias generation to allow coreboot modules to be automatically loaded
> when matching devices are detected.
> 
> The configs for cbmem coreboot entries are then enabled in the arm64
> defconfig, as modules, to allow reading logs from coreboot on arm64
> Chromebooks, which is useful for debugging the boot process.
> 
> Changes in v4:
> - Added driver_data to device_id struct
> - Link to v3: https://lore.kernel.org/r/20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com
> 
> Changes in v3:
> - Merged all "add to module device table" commits into a single commit
>   which also changes the coreboot_driver struct to contain an id table
>   and avoid unused variable warnings for the id tables.
> 
> Changes in v2:
> - Added commits for vpd, memconsole and framebuffer drivers to add them
>   to the module device table
> 
> ---
> Nícolas F. R. A. Prado (4):
>       firmware: coreboot: Generate modalias uevent for devices
>       firmware: coreboot: Generate aliases for coreboot modules
>       firmware: coreboot: Replace tag with id table in driver struct
>       arm64: defconfig: Enable support for cbmem entries in the coreboot table

Hi Arnd,

is it ok for Tzung-Bi to merge this last patch for the defconfig through the
chrome-platform-firmware tree?

Thanks,
Nícolas

> 
>  arch/arm64/configs/defconfig                   |  3 +++
>  drivers/firmware/google/cbmem.c                |  8 +++++++-
>  drivers/firmware/google/coreboot_table.c       | 20 +++++++++++++++++++-
>  drivers/firmware/google/coreboot_table.h       |  3 ++-
>  drivers/firmware/google/framebuffer-coreboot.c |  8 +++++++-
>  drivers/firmware/google/memconsole-coreboot.c  |  8 +++++++-
>  drivers/firmware/google/vpd.c                  |  8 +++++++-
>  include/linux/mod_devicetable.h                | 10 ++++++++++
>  scripts/mod/devicetable-offsets.c              |  3 +++
>  scripts/mod/file2alias.c                       | 10 ++++++++++
>  10 files changed, 75 insertions(+), 6 deletions(-)
> ---
> base-commit: 0f067394dd3b2af3263339cf7183bdb6ee0ac1f8
> change-id: 20240117-coreboot-mod-defconfig-826b01e242d9
> 
> Best regards,
> -- 
> Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

