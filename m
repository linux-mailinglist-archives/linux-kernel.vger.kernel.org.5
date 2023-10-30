Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737077DB313
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJ3GFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjJ3GFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:05:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BA6C1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698645911; x=1730181911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pwncb6T0eW2Uq8n6x+uGybwl8osJ5Cv6Ek3h44u2Tic=;
  b=Y3zLa7aqoPsZwPhxBe2HRE3+SUt2cT95NBgfBQB9ZfGLDGT4n4sHo63Y
   icLDGd3f/JhwNub96WExRNRVNOuv35xrX78IoxEO9Ru/o1NPFxBYmrVyw
   KQbFNlAjv+PYLj7yGMf8d5MvGRLgdYo3HKC1xGoClrwAjbiS0RsXEh6PF
   r25anzE4mIqAP0AA3A+QyTIlpTtBAflMOSfwJTv9v0kAoVZNmy51llyyi
   ARmYuNXttWAvm/JSEg/drV8LGgDjF/jTMGG7IEXN2EvDjx3Hy+FozeZ+L
   sgR5wG/DOL5ZItHmt6ScSlXfxPnG1pvWUefGrp7tJuHr9bOw/G1Av7eIC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="367362411"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="367362411"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 23:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="763814127"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="763814127"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 23:05:08 -0700
Date:   Mon, 30 Oct 2023 07:05:06 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/ivpu: avoid build failure with CONFIG_PM=n
Message-ID: <ZT9HkiflwVKnZlzk@linux.intel.com>
References: <20231027152633.528490-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027152633.528490-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:26:23PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The usage count of struct dev_pm_info is an implementation detail that
> is only available if CONFIG_PM is enabled, so printing it in a debug message
> causes a build failure in configurations without PM:
> 
> In file included from include/linux/device.h:15,
>                  from include/linux/pci.h:37,
>                  from drivers/accel/ivpu/ivpu_pm.c:8:
> drivers/accel/ivpu/ivpu_pm.c: In function 'ivpu_rpm_get_if_active':
> drivers/accel/ivpu/ivpu_pm.c:254:51: error: 'struct dev_pm_info' has no member named 'usage_count'
>   254 |                  atomic_read(&vdev->drm.dev->power.usage_count));
>       |                                                   ^
> include/linux/dev_printk.h:129:48: note: in definition of macro 'dev_printk'
>   129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
>       |                                                ^~~~~~~~~~~
> drivers/accel/ivpu/ivpu_drv.h:75:17: note: in expansion of macro 'dev_dbg'
>    75 |                 dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
>       |                 ^~~~~~~
> drivers/accel/ivpu/ivpu_pm.c:253:9: note: in expansion of macro 'ivpu_dbg'
>   253 |         ivpu_dbg(vdev, RPM, "rpm_get_if_active count %d\n",
>       |         ^~~~~~~~
> 
> The print message does not seem essential, so the easiest workaround is
> to just remove it.
> 
> Fixes: c39dc15191c4 ("accel/ivpu: Read clock rate only if device is up")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Applied to drm-misc-next

Thanks
Stanislaw
