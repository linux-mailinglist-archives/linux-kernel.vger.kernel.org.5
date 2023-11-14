Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BBB7EADF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjKNK0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:26:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292883;
        Tue, 14 Nov 2023 02:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699957593; x=1731493593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zwarH7arzcy5tlAYIhd5KTccW/23+URY4RVmEqL6/kc=;
  b=jsqe4cRA97bTIuM5Lv6hxjlO8CdyD2lOlO46QYykB7H8WlydCZZYEtrR
   11jdh4rBqFPtxIgdby6+Nmbzs16+sAoV7bemcTx0q+2IRnBC2M6Gz2TOG
   zM9ohEWUUExns3ONvmtpbyua1YmfH2nLnT5d5sVy1spgzAFs2LjDWba/2
   eiVd0mY43opOn6KtbHMJSZZ+p99jG/NaTcrCR5j3SDu8yDpdUYgjWEBIS
   IrXcwRrXi1qombI5KXcrr/lVaP42mSyuwg1mxGs/f8Cyiact3Zf5KIcGB
   KTk/o+MjSdf9ygwHJcZKov6I99sT2yICt70gaMNEKz5kco3OmByA65stG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3686984"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="3686984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="855240153"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="855240153"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.179])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:26:29 -0800
Message-ID: <fc7ac047-e604-4a1a-a850-de1d44189565@intel.com>
Date:   Tue, 14 Nov 2023 12:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
Content-Language: en-US
To:     Sven van Ashbrook <svenva@chromium.org>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>
References: <20231109111934.4172565-1-korneld@chromium.org>
 <CAG-rBijqw2VO8AQbwBh5Cu47gBbDsOGwPgw-8hSXMWCHXi6GLw@mail.gmail.com>
 <ZU3pTY0qbA6cDB7f@google.com>
 <CAG-rBiiXPzcMndhvT=vV7W--6i0O+26hgMcHL3wbCyKrnw6LsQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAG-rBiiXPzcMndhvT=vV7W--6i0O+26hgMcHL3wbCyKrnw6LsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 18:58, Sven van Ashbrook wrote:
> There's something happening in this driver that doesn't
> make much sense to me.
> 
> According to the pm runtime docs [1] the initial runtime pm
> status of all devices is 'suspended'. Which I presume, means:
> if the driver doesn't use any of the pm_runtime_*() functions
> to tell the core "actually, I am active after probe", then the
> device remains suspended until explicitly going active, at which
> point the runtime_resume() callback is invoked.
> 
> That's the theory. In practice, what do I see on a device
> containing this bridge?
> Intel SoC <-> PCIe bus <-> gl9763e bridge <-> eMMC bus <-> eMMC drive
> 
> at probe() (does not exist in this driver so I stubbed it):
> [ 0.601542] runtime pm is enabled = 1 (disable_depth == 0)
> [ 0.601552] runtime pm is active = 2 (usage_count)
> 
> at probe_slot():
> [ 0.602024] runtime pm is enabled = 1
> [ 0.602027] runtime pm is active = 2
> 
> At add_host():
> [ 0.602804] runtime pm is enabled = 1
> [ 0.602809] runtime pm is active = 3
> 
> It looks like:
> - nowhere does the gl9763e driver inform runtime pm it's active

PCI subsystem does it in pci_pm_init()

> - the device is active in probe(), probe_slot() and add_host()
> - the runtime_resume() callback did not get called before
> probe(), probe_slot(), or add_host().
> 
> Why is the runtime_resume() callback not invoked?

Most drivers expect the device to be active at probe().  How it
gets that way is up to the bus.  Note, the driver may call 
pm_runtime_set_active() but that doesn't call runtime_resume().

> Does the driver have a runtime_pm misconfiguration issue here?

No

> 
> Perhaps Rafael could clarify?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/power/runtime_pm.rst?h=v6.6.1#n563

