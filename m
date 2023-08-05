Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5C77103A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHEOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHEOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:50:55 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802EB1B9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 07:50:54 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qSIcC-0000Po-2Q;
        Sat, 05 Aug 2023 14:50:48 +0000
Date:   Sat, 5 Aug 2023 15:50:41 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v7 6/7] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Message-ID: <ZM5hwcuxKIE0N_iJ@makrotopia.org>
References: <20230801182132.1058707-1-miquel.raynal@bootlin.com>
 <20230801182132.1058707-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801182132.1058707-7-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:21:31PM +0200, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of each
> cell regardless of their position/size in the underlying device, but
> these information were not accessible to the user.
> 
> By exposing the nvmem cells to the user through a dedicated cell/ folder
> containing one file per cell, we provide a straightforward access to
> useful user information without the need for re-writing a userland
> parser. Content of nvmem cells is usually: product names, manufacturing
> date, MAC addresses, etc,
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/ABI/testing/sysfs-nvmem-cells | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> 
> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
> new file mode 100644
> index 000000000000..a1d140dcbd5d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> +Description:
> +		The "cells" folder contains one file per cell exposed by the
> +		NVMEM device. The name of the file is: <name>@<where>, with
> +		<name> being the cell name and <where> its location in the NVMEM
> +		device, in hexadecimal (without the '0x' prefix, to mimic device
> +		tree node names). The length of the file is the size of the cell
> +		(when known). The content of the file is the binary content of
> +		the cell (may sometimes be ASCII, likely without trailing
> +		character).
> +		Note: This file is only present if CONFIG_NVMEM_SYSFS
> +		is enabled.
> +
> +		Example::
> +
> +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name

Location is missing here, should be something like
  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name@f00

> +		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
> +		  0000000a
> -- 
> 2.34.1
> 
