Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A157F45F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbjKVMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbjKVMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:24:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D398
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700655872; x=1732191872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SX370jZj/iiF375wRpaiuBBt7qWPi41IvDXuLfaDWac=;
  b=fygggFJ6G46mx2xhChMDAw390As1r/sqKAxRUSy+n22AiXJCRPxC59dh
   LcRns773Oxnkxn0H/BJ574EmnWLZTPNjG6kzD3an5eQdFPTvUufjarbF5
   jnG+5nqxUC9wvN7w6Bzsj5Leh4mdkWiWpbuhfnkNAfMtdB6u5tbdG30xN
   51dsIa9ChjU5nuFrD5xXl4jaw70GSwb2l3nAXPISQxkZUfn+3LKu5u7/0
   W553UNrqdvsDy4GMtsnS8MYpxoqNP+YhEiWqB6AD/EG679Z3X4Ik1eWWN
   XBNFh71Sh/ZqfsbLAAifKstfInMpErz+FZH9n29w3RVl8fpzem3JF02i9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5184348"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="5184348"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014216736"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1014216736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:24:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5mHJ-0000000G5Qe-04tS;
        Wed, 22 Nov 2023 14:24:25 +0200
Date:   Wed, 22 Nov 2023 14:24:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Jean Delvare <jdelvare@suse.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 19/39] mtd: rawnand: add support for ts72xx
Message-ID: <ZV3y-IJ7JSD3fJeI@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-19-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-19-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:57AM +0300, Nikita Shubin wrote:
> Technologic Systems has it's own nand controller implementation in CPLD.

...

> +static int ts72xx_nand_attach_chip(struct nand_chip *chip)
> +{
> +	switch (chip->ecc.engine_type) {
> +	case NAND_ECC_ENGINE_TYPE_SOFT:
> +		if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
> +			chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
> +		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
> +		break;
> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		return -EINVAL;

> +	default:
> +		break;
> +	}
> +
> +	return 0;

Move this to default.

> +}

...

> +		for (i = 0; i < instr->ctx.addr.naddrs; i++)
> +			iowrite8(instr->ctx.addr.addrs[i], data->base);

iowrite8_rep() ?

> +	case NAND_OP_DATA_IN_INSTR:
> +		ioread8_rep(data->base, instr->ctx.data.buf.in, instr->ctx.data.len);

Hehe, you are even using it...

...

> +	if (instr->delay_ns)

What will happen if you drop this check?

> +		ndelay(instr->delay_ns);

...

> +	int ret;
> +
> +	ret = mtd_device_unregister(nand_to_mtd(chip));
> +	WARN_ON(ret);

Is this a requirement by MTD to have return value being checked?

-- 
With Best Regards,
Andy Shevchenko


