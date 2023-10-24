Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB507D4C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjJXJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjJXJ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7E2120;
        Tue, 24 Oct 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139726; x=1729675726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSB8pAAViMB/8p//BjKSeKwLOijnQ7uOJx1vlqPV8yg=;
  b=d2pycOIegWmaiBPuhL0h9V7Rwvf6X6JJnSDd7LFcZcEP+mQgcROs44xe
   FZVMWHkKU83iek/6+K3s5qtX4BwU7UbjUfUGbzWj6jOLbHXJCAl0C8+3W
   u92kotQVO487mJ13BTNdSKp4wb5PDv0x2VtaC2LZi44VGuQBg4dy0pDJU
   6Y033a/ed2f8KMgUPJTBeD0cumS7orMMBPIa49yhnSbsTY1s+avs5u+zs
   G5YOI42yKFQTrslzzrVB1IIWQyXvROqbPfODyrsOJh6+YkQMatK1gI6NM
   yav9LWgJerxpxlae412EFRx/KuSvMohp15v1L4m9PCqnT8BsCiGII9CzS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451251855"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="451251855"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089786072"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089786072"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2023 02:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 55BD794; Tue, 24 Oct 2023 12:28:39 +0300 (EEST)
Date:   Tue, 24 Oct 2023 12:28:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        andriy.shevchenko@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 1/6] ACPI: utils: Introduce acpi_dev_uid_match() for
 matching _UID
Message-ID: <20231024092839.GE3208943@black.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-2-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:50:13AM +0530, Raag Jadav wrote:
> +/**
> + * acpi_dev_uid_match - Match device by supplied UID
> + * @adev: ACPI device to match.
> + * @uid2: Unique ID of the device.
> + *
> + * Matches UID in @adev with given @uid2.
> + *
> + * Returns:
> + *  - %true if matches.
> + *  - %false otherwise.

Nit: these actually do not get formatted like above so you can just
write it as

Returns: %true in case UIDs match, %false otherwise.

If it is even needed, I think it is pretty obvious from the function
name what it returns.
