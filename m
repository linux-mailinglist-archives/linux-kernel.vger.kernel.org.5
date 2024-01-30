Return-Path: <linux-kernel+bounces-45490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61A843167
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04741C23576
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42A7995C;
	Tue, 30 Jan 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aIykwy+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA77339AD;
	Tue, 30 Jan 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657882; cv=none; b=oCKh6rFgT02qKDs/0G7H6Zg0ANZ05IDfeLgJ+ClPj3ik5mVhyrUGF3GzcsMVr8Zy03tqtW3aPTqx87R5zavCREnSFkDj5lAPmmWDcRAPFKAqlhXLBV5cDoN8pu+7t3dSUpd9YxJEW83fDsl3fZYJCsxmN4Rp8BLX+R/+pZY9lwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657882; c=relaxed/simple;
	bh=LqEbxy5HFwLmJ2Rg9GQ3/teWihbE1b+vjKDjuZxmXg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED55YSwTq92QzzEaPmF+Ch4EZSIZ2xvt+Hwj5TnfiAyrWiwMTfl7sBxaKc7pBqojl7HxZiC4MWhHkIuMfEUrj/PESWueEnM20SAWW6Ug/Y1S/edCCbm5K4HQBq+V1eluMO+xI+1MpBIj+ezhs/HH4qV0bGVY/eoJ7Q/cOasuHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aIykwy+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F9BC43390;
	Tue, 30 Jan 2024 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706657882;
	bh=LqEbxy5HFwLmJ2Rg9GQ3/teWihbE1b+vjKDjuZxmXg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIykwy+BCwLMAq+2b9xkOhneoaDOecqNWdPGSi6LBLwN7i3ltTjP7dNc0pgNVgDJH
	 Eznt2PcLNCX8VDyyBOQIRwLLPVJ0Iq8g5iMqc/xWAtdkqBQlB9Iy2yJeEGr5dUZkTW
	 wOV60NI4KXrT1ImjNe88gZRIpyIT+ZmzfVlHLuEI=
Date: Tue, 30 Jan 2024 15:38:01 -0800
From: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
To: "Corona, Ernesto" <ernesto.corona@intel.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
	"'omar.eduardo.castro@linux.intel.com'" <omar.eduardo.castro@linux.intel.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
	"'davem@davemloft.net'" <davem@davemloft.net>,
	"'nicolas.ferre@microchip.com'" <nicolas.ferre@microchip.com>,
	"'robh@kernel.org'" <robh@kernel.org>,
	"'andriy.shevchenko@linux.intel.com'" <andriy.shevchenko@linux.intel.com>,
	"'lukas.bulwahn@gmail.com'" <lukas.bulwahn@gmail.com>,
	"Filary, Steven A" <steven.a.filary@intel.com>,
	"'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>,
	"Chen, Luke" <luke_chen@aspeedtech.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	"'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 6/7] Add JTAG core driver Maintainers
Message-ID: <2024013028-material-germless-aa23@gregkh>
References: <LV8PR11MB846312B6C1F23325DACDF3778B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB846312B6C1F23325DACDF3778B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 11:32:33PM +0000, Corona, Ernesto wrote:
> JTAG class driver provide infrastructure to support hardware/software JTAG platform drivers. It provide user layer API interface for flashing and debugging external devices which equipped with JTAG interface using standard transactions.
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jiri Pirko <jiri@nvidia.com>
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Steven Filary <steven.a.filary@intel.com>
> Cc: Amithash Prasad <amithash@fb.com>
> Cc: Patrick Williams <patrickw3@fb.com>
> Cc: Luke Chen <luke_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: Rgrs <rgrs@protonmail.com>
> ---
> MAINTAINERS | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..764732f1fe19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11532,6 +11532,19 @@ L:                linux-serial@vger.kernel.org
> S:           Orphan
> F:           drivers/tty/serial/jsm/
> +JTAG SUBSYSTEM
> +M:        Oleksandr Shamray <oleksandrs@mellanox.com>
> +M:        Vadim Pasternak <vadimp@mellanox.com>
> +M         Ernesto Corona <ernesto.corona@intel.com>
> +M:        Omar Castro <omar.eduardo.castro@linux.intel.com>
> +M:        Jiri Pirko <jiri@nvidia.com>
> +S:          Maintained
> +F:          Documentation/ABI/testing/jtag-dev
> +F:          Documentation/devicetree/bindings/jtag/
> +F:          drivers/jtag/
> +F:          include/linux/jtag.h
> +F:          include/uapi/linux/jtag.h
> +
> K10TEMP HARDWARE MONITORING DRIVER
> M:         Clemens Ladisch <clemens@ladisch.de>
> L:            linux-hwmon@vger.kernel.org

Something went wrong, your patch is corrupted and your mix of spaces and
tabs is not right (and you forgot a blank line before your entry) :(


