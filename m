Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9B7CC873
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjJQQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjJQQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:11:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591D9E;
        Tue, 17 Oct 2023 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559077; x=1729095077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sQ3SeCPd+0Lqa046J6tIMPZMzDJgd5cO8vP1Z8zMzJM=;
  b=dzGkz4D00k8ez9XGa5BAnYIFU/uDHXUxxna0w2acPjUIROqTBW+E3u0J
   0448j/V7PxuXutinUT+QsD4mposTB27ETD2KNQquqvSjNZLy0MS7ef0/n
   Iqr1eW5N0IGjCL6jod0YNqevdCln9sKEMbiOZ5IPLMQZEZORNKake8E15
   R+KK9KcH7rTg+Q7z9S4Ni0iem8s8fiMa6u4vZgJlX7p36t7rm026lr0e+
   93cJXOt50j+WsnroiOJDRecIpUHYY2ZPznt1Zaj1jcdSl1DRK4nNmwbrJ
   ZpiSwr+45/pMPwdgPvMbSWOP+12pTxgNgL3jRwv+t83mCuQwVHQOmQ9Zm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365167493"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="365167493"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="759865013"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="759865013"
Received: from asprado-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.55.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:09:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/2] soundwire: introduce controller ID
Date:   Tue, 17 Oct 2023 11:09:31 -0500
Message-Id: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an alternate proposal to the solution suggested in
[1], which breaks Intel machine drivers.

The only difference is to use a known controller ID instead of an IDA,
which wouldn't work with the hard-coded device name.

This patchset was tested on Intel and AMD platforms, testing on
Qualcomm platforms is required - hence the RFC status.

[1] https://lore.kernel.org/alsa-devel/20231004130243.493617-1-krzysztof.kozlowski@linaro.org/

Krzysztof Kozlowski (1):
  soundwire: fix initializing sysfs for same devices on different buses

Pierre-Louis Bossart (1):
  soundwire: bus: introduce controller_id

 drivers/soundwire/amd_manager.c     |  8 ++++++++
 drivers/soundwire/bus.c             |  4 ++++
 drivers/soundwire/debugfs.c         |  2 +-
 drivers/soundwire/intel_auxdevice.c |  3 +++
 drivers/soundwire/master.c          |  2 +-
 drivers/soundwire/qcom.c            |  3 +++
 drivers/soundwire/slave.c           | 12 ++++++------
 include/linux/soundwire/sdw.h       |  4 +++-
 sound/soc/intel/boards/sof_sdw.c    |  4 ++--
 9 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.39.2

