Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2307C6458
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376996AbjJLFFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjJLFFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:05:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6890;
        Wed, 11 Oct 2023 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697087132; x=1728623132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qAqfjH4EeTiWuaON92xe5Ip4YWDBD4AvbFVckiNoGcs=;
  b=h/GgI+PdFp/Y/bnhHOuHXxjEk0/nGWMGwZCDNji5f5wZ7trSrsLzGGXk
   gCU+p96bvuKOGuQN0GBZK+PqJDxaWuRZmNRwbsSBWZXOKLKHfDExWUxE7
   ThOPuDJF/mwOKaElcxwugs/D+n0HkczgzdGOke4tSbQ3zKGJ89Oe+HBjm
   DZcr0D4Ex1pVda+H15R4as7oe+a9/4x+E7pm75tmIMoc7d74DZ6Ik/Yfh
   VWdzMhklCXCA8SQvE+Vku6e8MO1y8w0rHwOu/+QjLmNgPHNQIGL6h5FcS
   LazqihB8E92Zr3eRh3wSeRKxX86yo5un0eOO+oHSB0ax8i5Jztp3AL3rb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="382073058"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="382073058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870418848"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="870418848"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2023 22:05:30 -0700
Date:   Thu, 12 Oct 2023 13:04:34 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-ps-spi: Use spi_get_device_match_data()
Message-ID: <ZSd+YgDbS5L7jNPJ@yilunxu-OptiPlex-7050>
References: <20231006224624.444857-1-robh@kernel.org>
 <ZSEMLQS+9gFEAX89@yilunxu-OptiPlex-7050>
 <ZSEO5NrJl/kxd7LG@yilunxu-OptiPlex-7050>
 <CAL_JsqKB4gqT06NnWj0Qkd0TuryYA15tjMSom1f+dMJfevy2Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKB4gqT06NnWj0Qkd0TuryYA15tjMSom1f+dMJfevy2Zw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:48:07AM -0500, Rob Herring wrote:
> On Sat, Oct 7, 2023 at 2:56 AM Xu Yilun <yilun.xu@linux.intel.com> wrote:
> >
> > On Sat, Oct 07, 2023 at 03:43:41PM +0800, Xu Yilun wrote:
> > > On Fri, Oct 06, 2023 at 05:46:24PM -0500, Rob Herring wrote:
> > > > Use preferred spi_get_device_match_data() instead of of_match_device() and
> > > > spi_get_device_id() to get the driver match data. With this, adjust the
> > > > includes to explicitly include the correct headers.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > >
> > > Applied.
> > >
> > > >
> > > >  static const struct spi_device_id altera_ps_spi_ids[] = {
> > > > -   { "cyclone-ps-spi", CYCLONE5 },
> > > > -   { "fpga-passive-serial", CYCLONE5 },
> > > > -   { "fpga-arria10-passive-serial", ARRIA10 },
> > > > +   { "cyclone-ps-spi", (uintptr_t)&c5_data },
> > > > +   { "fpga-passive-serial", (uintptr_t)&c5_data },
> > > > +   { "fpga-arria10-passive-serial", (uintptr_t)&a10_data },
> >
> > Sorry, one more. Should cast to kernel_ulong_t?
> 
> Either will work. uintptr_t is somewhat new in the kernel and
> preferred now I think.

LGTM, Applied.

> 
> Rob
