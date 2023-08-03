Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC4776E027
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjHCGY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjHCGYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:24:55 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650010FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691043887; x=1722579887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5dHLhZfkM4fPP4ODNsxE3CV5Tq4sdvHjv7CD0L/AoHo=;
  b=FAHFSbanMaAiaBuFdSAfI3SAEiP9YVwlsVqTJ4bv0FhEodZuqXQW+89p
   SENZKtLJXJQhsn3gG5uGYX5LuPPMR/1ybhiDb8qgj+NAYJlSul6+LArB7
   CL7QEgBIVs5WHTsgm/F56eZ1I+VRRMzIpecDrjKBe5cKh36Twc3rCiTJJ
   mC6EPBT6Py3f/+Xq8uohhVf6ktyzT/Rz1mW5qlX8Uf9yC5ISZ1ii4OP+v
   wTwQgoE4JoQDu+ugsvOrbyThrZeX3mkUx1JEZaC3OwxTVkLHFf+OHx3Eo
   R4LahTaBRNz2/5QdHhpMHJa0DIYY5Ti0TdmJKLOc75NOKqZUKMRjdj0+L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350075218"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350075218"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060117879"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="1060117879"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:23:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: improve pm_runtime handling
Date:   Thu,  3 Aug 2023 14:52:18 +0800
Message-Id: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset improves the pm_runtime behavior in rare corner cases
identified by the Intel CI in the last 6 months.

a) in stress-tests, it's not uncommon to see the following type of
warnings when the codec reports as ATTACHED

    "rt711 sdw:0:025d:0711:00: runtime PM trying to activate child device
    sdw:0:025d:0711:00 but parent (sdw-master-0) is not active"

This warning was not correlated with any functional issue, but it
exposed a design issue on when to enable pm_runtime. The recommended
practice in the pm_runtime documentation is to keep the devices in
'suspended' mode and mark them as 'active' when they are really
functional.

Pierre-Louis Bossart (2):
  soundwire: intel_auxdevice: enable pm_runtime earlier on startup
  soundWire: intel_auxdevice: resume 'sdw-master' on startup and system
    resume

 drivers/soundwire/intel_auxdevice.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.25.1

