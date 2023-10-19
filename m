Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180357CFD34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbjJSOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjJSOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:48:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52CE114;
        Thu, 19 Oct 2023 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697726929; x=1729262929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TTxcbDUvyh2vAsNIAVwilw773kfOc9seLoPaqLvLi/M=;
  b=iBeyiZmqHsbhKpw5JUYU1wuIcoG9LWv90Oh5qNU+29cHcIgCYlQgPK34
   a7lMf2eDIkE1dJxRMbgv32uwhM0oyU0DZlQL+E6+fXgerEOH3B+3BbtLK
   hi5aU7slquEMDdKZBFC/UtrPp8JBynCfkcedjLqnEw/iV/o6TrkECEfQ3
   Dv/pW7H8dBhMbbD4k1FsRJvLr0LsvEG5+JEpSioRAMuS2VW5c62k0WbZV
   X1AoTWwsVIXhKs+H+E+ykvBpZN1dXV0gxDQqROVY3r8C0NGqEoyTcgpkD
   wSHKEdtwF57LKtcIk8xmjtJhipRNNq2DdoV3hKrVRR/ywBNJRMldVTx2S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="7832255"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7832255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="706872108"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="706872108"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2023 07:48:45 -0700
Date:   Thu, 19 Oct 2023 22:47:39 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     gregkh@linuxfoundation.org, Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: disable KUnit test suites when module support is
 enabled
Message-ID: <ZTFBi7vfmEpR9TB0@yilunxu-OptiPlex-7050>
References: <20231018163814.100803-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018163814.100803-1-marpagan@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:38:13PM +0200, Marco Pagani wrote:
> The fpga core currently assumes that all manager, bridge, and region
> devices have a parent device associated with a driver that can be used
> to take the module's refcount. This behavior causes the fpga test suites
> to crash with a null-ptr-deref since parent fake devices do not have a
> driver. This patch disables all fpga KUnit test suites when loadable
> module support is enabled until the fpga core is fixed. Test suites
> can still be run using the KUnit default UML kernel.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

LGTM, I've tested on my machine.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Hi Greg:

Could you help review and pull it in for 6.6-final if it's OK.

https://lore.kernel.org/linux-fpga/2023101825-ligament-undergrad-cc4d@gregkh/

Thanks,
Yilun

> ---
>  drivers/fpga/tests/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
> index e4a64815f16d..d4e55204c092 100644
> --- a/drivers/fpga/tests/Kconfig
> +++ b/drivers/fpga/tests/Kconfig
> @@ -1,6 +1,6 @@
>  config FPGA_KUNIT_TESTS
> -	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> -	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
> +	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> +	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
>  	default KUNIT_ALL_TESTS
>          help
>            This builds unit tests for the FPGA subsystem
> -- 
> 2.41.0
> 
