Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4217BC5DB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbjJGH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbjJGH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:56:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92086D8;
        Sat,  7 Oct 2023 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696665368; x=1728201368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGqWmkWoM6afuulAuBmtxIaiirPB7kQUbXbidMCkQT0=;
  b=N6zyf85ovBwIPMiS1RbqYgp6vK1surMxKInLMqrTnhA10Q6QbT6MDVZh
   +qH38uGpPzjaJ9Kc4w021NvX3V0FndmIWj6Ee68/fTUFj340TwugsUKnG
   vx8E9Uhg5ISK5lTyi7hAa13MBOs7yqRxSeg8kgYSop2q4+fWKo7SxTPbc
   6uJ5O2WJ5GPCqImiVToV3rnku1MTT7XRGsaXvhBlgM9maQaIeXhSRaFJ3
   1j36TQvKU8XYmyBtqaDx6SEkJbr73Gxze/INphP+pSAfQD3lgjWFCBRx+
   mwYkun3B3oLZH5i9VpDN2wUJF/1PF3MF1Ln1Pyur+bVBsb3oNXVNenhcs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374239653"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="374239653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="926217051"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="926217051"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2023 00:56:06 -0700
Date:   Sat, 7 Oct 2023 15:55:16 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-ps-spi: Use spi_get_device_match_data()
Message-ID: <ZSEO5NrJl/kxd7LG@yilunxu-OptiPlex-7050>
References: <20231006224624.444857-1-robh@kernel.org>
 <ZSEMLQS+9gFEAX89@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSEMLQS+9gFEAX89@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 03:43:41PM +0800, Xu Yilun wrote:
> On Fri, Oct 06, 2023 at 05:46:24PM -0500, Rob Herring wrote:
> > Use preferred spi_get_device_match_data() instead of of_match_device() and
> > spi_get_device_id() to get the driver match data. With this, adjust the
> > includes to explicitly include the correct headers.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Applied.
> 
> >  
> >  static const struct spi_device_id altera_ps_spi_ids[] = {
> > -	{ "cyclone-ps-spi", CYCLONE5 },
> > -	{ "fpga-passive-serial", CYCLONE5 },
> > -	{ "fpga-arria10-passive-serial", ARRIA10 },
> > +	{ "cyclone-ps-spi", (uintptr_t)&c5_data },
> > +	{ "fpga-passive-serial", (uintptr_t)&c5_data },
> > +	{ "fpga-arria10-passive-serial", (uintptr_t)&a10_data },

Sorry, one more. Should cast to kernel_ulong_t?

Thanks,
Yilun

> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
> > -- 
> > 2.40.1
> > 
