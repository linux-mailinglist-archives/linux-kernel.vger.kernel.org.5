Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18279C621
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjILFDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjILFDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:03:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB08211D;
        Mon, 11 Sep 2023 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694494976; x=1726030976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I60HdwBlPxOrrglt4IdST/dJqZyEc8Pl4UhQ06LR5y0=;
  b=Tp+5ilNZBiZsSO5pnue/F1RUjdbSU6zV0Zzh/9SwdM4sH4MtirlFPxXo
   1sFHe14GILKeE5eQS55GK2gPlwjM6H7YKDuxhi5sQVe/fayaI5xrOvewj
   1vG7xxL+/wDj/5djgAvIfLd2YOZ3tg3oioZH5fboEPOUE2vUUD9PMMTSP
   MGSL42Z5xltA9OEUnrYESzt4y2Sgu7fz8rvFTx0T431XurmAGPBOjIkqE
   jiHD+kHqMZ4Lab/wDNn4ie1BQ9aH5LVbfxkauMCAGSA9ZfVgvrKmXSabU
   /8t8Aof8SGMZwXM2i2T9+3OTfID7eCyvizEHBcFc7hpVPTwcNWrCpc1FX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357712280"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="357712280"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 22:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746723219"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746723219"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2023 22:02:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4E1C5248; Tue, 12 Sep 2023 08:02:52 +0300 (EEST)
Date:   Tue, 12 Sep 2023 08:02:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 1/4] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
Message-ID: <20230912050252.GD1599918@black.fi.intel.com>
References: <20230911193937.302552-1-swboyd@chromium.org>
 <20230911193937.302552-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911193937.302552-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:39:33PM -0700, Stephen Boyd wrote:
> It's possible for the polling loop in busy_loop() to get scheduled away
> for a long time.
> 
>   status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
>   <long time scheduled away>
>   if (!(status & IPC_STATUS_BUSY))
> 
> If this happens, then the status bit could change while the task is
> scheduled away and this function would never read the status again after
> timing out. Instead, the function will return -ETIMEDOUT when it's
> possible that scheduling didn't work out and the status bit was cleared.
> Bit polling code should always check the bit being polled one more time
> after the timeout in case this happens.
> 
> Fix this by reading the status once more after the while loop breaks.
> The read_poll_timeout() macro implements all of this, and it is
> shorter, so use that macro here to consolidate code and fix this.
> 
> There were some concerns with using read_poll_timeout() because it uses
> timekeeping, and timekeeping isn't running early on or during the late
> stages of system suspend or early stages of system resume, but an audit
> of the code concluded that this code isn't called during those times so
> it is safe to use the macro.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
