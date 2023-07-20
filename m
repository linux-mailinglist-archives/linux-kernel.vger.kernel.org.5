Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB875A3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGTBcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGTBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:32:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB9A2103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689816760; x=1721352760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EEH92Op2Nr+VsnZvGqzZkmZfh8Q0ed/IE38X40WNBaE=;
  b=ic0dMrHQRPDE8HLBOnCaXYjYG9IRXZM882gNq6FFWubmwuxGe5WasWwo
   Y8Ydw6aPPzdwLRe35S+o+VakAWDuilazFy2OkhI6By0umWSLtkjPF4w4i
   gpSrqsLhWEiBkFaq4gi7KHr+QeR+2Hww0RdFE+SeV8wV8sJinK1pLPNdE
   5txZmr4mLhpvENPK8LGUE7DkRryrLNqN49h5+baKv3LyRmskerxvUo6H1
   F84Dw1dzk3hVTlijAMv0DXhb0mIpg1g1xoPHl8x0ldQZ9skaaknUCKQzp
   QqJ7OM3GQrjEQ+1DB4vj1XaWejvs2HbAWxA9lyAGwOy074oyy38IfXhOz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="364067929"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="364067929"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 18:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867681273"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2023 18:32:37 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/2] Intel: sof_rt5682: remove quirk flag
Date:   Thu, 20 Jul 2023 17:26:26 +0800
Message-Id: <20230720092628.758834-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a helper funcion to detect amplifier number according to device instance
in ACPI table so the SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag and a dmi quirk
for 4-amplifier configuration could be safely removed.

Also refactory the max_98390_hw_params() function to use an array to handle the
TDM parameter.

Amplifier number detection and TDM parameter are tested on two Chromebooks. One
with 2 MAX98390 and one with 4 MAX98390 amplifier.


*** BLURB HERE ***

Brent Lu (2):
  ASoC: Intel: maxim-common: get codec number from ACPI
  ASoC: Intel: sof_rt5682: remove SOF_MAX98390_TWEETER_SPEAKER_PRESENT
    flag

 sound/soc/intel/boards/sof_maxim_common.c | 174 +++++++++++++---------
 sound/soc/intel/boards/sof_maxim_common.h |  21 ++-
 sound/soc/intel/boards/sof_rt5682.c       |  37 +----
 3 files changed, 115 insertions(+), 117 deletions(-)

-- 
2.34.1

