Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73C78C82D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjH2PAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjH2O7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:59:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C1CFE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693321162; x=1724857162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4ZA78TdD4dLE0BOLrtYnIvKSfgxxvybhjyOfipu8sE=;
  b=E6sdCTe+vKlZcA1LTy3UUepMXijSBe90f4WicJk3WD/o2i49LzrdIUqq
   JUALbvhBC2GUJxFRTF7Z5pRWhm8DHAekXx7zvDT4MNRxYTF1MESxgWLQN
   JjviKtaaxJdLuYu7/Uik+ZRmqJ2jb0K/yp/vMRMKXS/wkvHwv/D+sac2j
   a05ywOLc+cbP4Yw7pq7BMmIyaC+ow7HQq94G/t06S46jPeVTDxVdOzBh0
   qH/ciwMIujTrabYfxWUJmJ7lrTY7jXEEECXKga/buSjxDhatwNWuVvA7u
   AuVHcb+j4ddhCglPZFJh5y5YAoGmhxvLz2x9k9u8gSoMblIpqNJEJPXA7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379155628"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="379155628"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808710875"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="808710875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 07:59:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0BY-004uPL-2E;
        Tue, 29 Aug 2023 17:59:16 +0300
Date:   Tue, 29 Aug 2023 17:59:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: tlv320aic32x4-i2c: Simplify probe()
Message-ID: <ZO4HxMErjEPvHuM2@smile.fi.intel.com>
References: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
 <20230828191014.138310-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828191014.138310-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:10:14PM +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_node() and i2c_match_id() with
> i2c_get_match_data().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
assuming that you finish this by converting SPI part as well.

-- 
With Best Regards,
Andy Shevchenko


