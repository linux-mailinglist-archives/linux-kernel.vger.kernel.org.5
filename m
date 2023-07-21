Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BCC75C40C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGUKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGUKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:09:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8D72706
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934186; x=1721470186;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zfD3fxGaaJVbEP0Mg/47kMaERmFrmee6teDl/NH72f4=;
  b=WhmLVa1Wn74YakXDpficloEjO5O8PHMkIUtPr7Rc6oG1NFjjzDfB2ef3
   IQEYJRSZ7bn1bVIYB1rkVI2WQK+f6cFQxrOvRP9xOOWv3xQPYFIC7Iydf
   wvu28aa1vL5ElU65Pgfkt3aITDQ4r+FAHbh+51ikahW/O2w3Qxk7UNH9x
   IzGG0trxHRTBFkKc/SeJFrIJStUiD8uzuyeGQj2h/HrsslVxnnvxKTCZP
   +vytraq4pf1z3SE0W5NCC37GjhtZP59Fi+oQ0i7ztDwhgS1VNEaoiT2QF
   WRV/89m0/lhUkhhBO7fkDWRA2EFN+Mro2pvAsv1pibIj3a63PvKBSCj+z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346581194"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346581194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674991008"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="674991008"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:09:41 -0700
Date:   Fri, 21 Jul 2023 13:06:21 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 0/9] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
In-Reply-To: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2307211300270.3532114@eliteleevi.tm.intel.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jul 2023, Maarten Lankhorst wrote:

> Explicitly loading i915 becomes a problem when upstreaming the new intel driver
> for Tiger Lake and higher graphics (xe). By loading i915, it doesn't wait for
> driver load of xe, and will fail completely before it loads.
> 
> -EPROBE_DEFER has to be returned before any device is created in probe(),
> otherwise the removal of the device will cause EPROBE_DEFER to try again
> in an infinite loop.

thanks, series looks good to me now. We'll need to adopt the new gpu_bind
parameter in a number of CI systems (where we test without i915/xe), but 
this looks perfectly doable.
  
I'll give my 

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

... for the hdac_i915.c changes. For AVS and SOF, I'd ask for some 
more review time to allow Cezary, Pierre et al to weigh in. I don't
personally recall e.g. where we've used CONFIG_SOF_FORCE_PROBE_WORKQUEUE
and do we have grounds to keep it even if workqueue is no longer set
for HDA codec support.

Br, Kai
