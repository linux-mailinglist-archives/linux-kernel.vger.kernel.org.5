Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D894E7527D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjGMP45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGMP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:56:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24480E4D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7j4q1Rny9N+eD4EQVhhjJLZ2Gojrgq5ScKuXneWBUww=; b=t7w9ve+J/zPxN8gSgP5nLFFmXb
        56oUaSkvpv6nNjz2/G2/L72mojFXePsb0sE8zK99tIfyOAi13IYDpE9gYDKsLvXp90s2Gche7VpzV
        bDS1Za9wt1+6eE1CFIMHiR5hY7dTfflJxFX+4wKHvABx3q5c+5+W6j34GE77je9Z1JYBG/VMITC05
        9qQcP47cD84hSapg//n8yc+YJv5OyvcSCwZDtIZIYCgPHJSIw6/XcPVASdPOwBt/c45rPxp2yReAA
        dChYxbABHnoGAeMXPmpaY2KuyKpKerVmeZ7fcMa6ICW5K7AJwzrdbzDjlulNUeNX5F2SoJTZ/k4iG
        FtqBo/Zg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJygT-003qEb-34;
        Thu, 13 Jul 2023 15:56:50 +0000
Message-ID: <153c8781-a83a-d7d9-92b2-b82ca9ab06aa@infradead.org>
Date:   Thu, 13 Jul 2023 08:56:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND v5 1/3] ABI: sysfs-nvmem-cells: Expose cells
 through sysfs
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
References: <20230713075508.485072-1-miquel.raynal@bootlin.com>
 <20230713075508.485072-2-miquel.raynal@bootlin.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713075508.485072-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/23 00:55, Miquel Raynal wrote:
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
>  Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> 
> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
> new file mode 100644
> index 000000000000..641a7d7dad76
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> @@ -0,0 +1,19 @@
> +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> +Description:
> +		The cells/ folder contains one file per cell exposed by

(My shell doesn't show "folders". ;)

> +		the nvmem device. The name of the file is the cell name.
> +		The length of the file is the size of the cell (when
> +		known). The content of the file is the binary content of
> +		the cell (may sometimes be ASCII, likely without
> +		trailing character).
> +		Note: This file is only present if CONFIG_NVMEM_SYSFS
> +		is enabled

add ending '.':    enabled.

> +
> +		ex::

		Example::
or
		E.g.::

> +
> +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
> +		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
> +		  0000000a

-- 
~Randy
