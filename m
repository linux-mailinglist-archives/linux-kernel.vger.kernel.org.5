Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D57E7FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjKJR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjKJR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F1A5D9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699612659; x=1731148659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jVszzgOebbHsDy73geqqJTXfu/Fq2n8OkHo7zcBEU74=;
  b=bKkZAMut3k+b2r0EuP58RYhjfa0CxveKYejVYzZ+o4EdJOu2M2qQsedz
   ax5W5/w+FGyAsAesFeWFvq4CxP2bmGPwFW1WDX2I3KK88agQEHr7WrUQm
   YzVwwo9FdE7ZeRc00C4O9Bip4qGdorNbqlIBCX9J+E0gDNDjP3EI25CO9
   EWvLlcnPkZvkq6FdgdJe2F1sMTo/jviwO10ue74EUkL7rHF0/pagI9Tfr
   xYhqPiKPFIMlkCvuOQtbOqAOm4giW+9qWZXfw8+b7tTnw/KBh0mWtFzct
   fARd6bVz1SATtbyRbOc9zAmK10uvzmSa6/Xy+1PwRJy3rqOTfFnDcS3rZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3152235"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3152235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 02:37:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907437432"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="907437432"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2023 02:37:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1616914F; Fri, 10 Nov 2023 12:37:34 +0200 (EET)
Date:   Fri, 10 Nov 2023 12:37:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op
 checking
Message-ID: <20231110103734.GJ17433@black.fi.intel.com>
References: <20231108094303.46303-1-acelan.kao@canonical.com>
 <20231110053721.GG17433@black.fi.intel.com>
 <CAFv23QnbG0QX=cGjVYA1GnQFf9HFd7M7gXuAxBDO4o-POvO9yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv23QnbG0QX=cGjVYA1GnQFf9HFd7M7gXuAxBDO4o-POvO9yg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 06:25:41PM +0800, AceLan Kao wrote:
> Hi Mika,
> 
> Mika Westerberg <mika.westerberg@linux.intel.com> 於 2023年11月10日 週五 下午1:37寫道：
> >
> > Hi,
> >
> > On Wed, Nov 08, 2023 at 05:43:02PM +0800, AceLan Kao wrote:
> > > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> > >
> > > No functional changes are introduced by this patch; it's a code cleanup
> > > to use the correct error code.
> >
> > Probably good to mention here that this affect only the "SPI MEM"
> > drivers and the core parts. Also you could explain here that the reaosn
> > for this is to make sure we use unified "operation not supported" return
> > code accross these.
> Got it.
> >
> > Does some kernel-doc need updating as well to make sure the future
> > drivers will return the correct one if they do not support given
> > optional operations?
> I have no idea where to add this, do you mean add a section in
> Documentation/spi/spi-summary.rst?

I mean in include/linux/spi/spi-mem.h kernel-doc of struct
spi_controller_mem_ops perhaps? Or kernel-doc of spi_mem_exec_op()?
