Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139AF79BE34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356980AbjIKWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjIKJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C7E40;
        Mon, 11 Sep 2023 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694425576; x=1725961576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYRDvoE7lgXht+BNocpgzZz5d2+b/mY+Hmn7D6BVF4M=;
  b=J4gSuxhRFtHkb94hNxkn+zo7GEgp9pJKD+mkRgllj578RBiAoGOYVETz
   dZYsZJQxKkJqE53LrEKKijEg/ZlxeTELpwIS5PGQpda+wfuSD2p7AkkK7
   +9GW96p2A4fOpnBZ0Sy4d6LesC3L2eBdjqoS83hkKylYMrcVQb/7vM0Yw
   EwRlGYAkljqqe/RH2KsBNFuvO61K/eJSpZrMK7yefYtbbnciZKIf/inw3
   EDFGmJ/2RQUqk2pA71hGsliogKJVXA+Xwpr26Cnp4fLEiP4zN93GpJzwN
   UZhUU3fkUUccroDlmP30LQAnTAIfaItI1AWEi/tv0Zw+Ag/QL32/Tuoyb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="377956314"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="377956314"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="1074076621"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="1074076621"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:46:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdUg-008HX3-2R;
        Mon, 11 Sep 2023 12:46:10 +0300
Date:   Mon, 11 Sep 2023 12:46:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V2 1/6] pinctrl: sprd: Modify the probe function
 parameters
Message-ID: <ZP7h4vd9kRsRPXDG@smile.fi.intel.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-2-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-2-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:51:41PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, the offset values of the common register and
> misc register will be different. Thus put these in the probe function
> parameters.

...

> +#define	PINCTRL_REG_OFFSET		0x20

0x0020 to make it look as related to the other one, as they are of the same
type: register offsets.

> +#define	PINCTRL_REG_MISC_OFFSET		0x4020

-- 
With Best Regards,
Andy Shevchenko


