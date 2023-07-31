Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12437690A8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGaIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGaIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:46:36 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173B210C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690793121; x=1722329121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNv+VnT3QZhrJhTeH4mAsNhZCJHGfzshQLFDmQm7ORQ=;
  b=XaCSVVHDZ77jtqE8MtP60QMe0ywPT77ul9dk5+SkkvKu384R5YDLrVmM
   VTMpC5yWiAuZhNhXYbquZmHd8YsTo1THq0/QSDZaucLvEEdqGTtGETfrX
   /Hys6iqcyT1qoJnge3enk0KIlur71tI5EeDLgY9QiMgkkUBxbdCkjKN+p
   PBd8BSnrjM3OyOxdT95UE4emmLQphXjQzGMfOZys5QaNg6CzMt/a9rbUj
   ihurVzO2oWMW2PJl3sgckMqDEVhKnQ28P3RKQ8d7scem0QpkCzSaBFXju
   QPIFZuV59ExqBtSyUF2yOWVauw8G5bJKDwsOLLZq2JN5WvtANwgpTW4P1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348557426"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348557426"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678232190"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678232190"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 01:45:19 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/3] soundwire: allow for more than 8 devices, keep IDA for wake-capable devices
Date:   Mon, 31 Jul 2023 17:13:30 +0800
Message-Id: <20230731091333.3593132-1-yung-chuan.liao@linux.intel.com>
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

This series suggests a hybrid strategy for device number allocation, where
only wake-capable devices use a system-unique Device Number which will be
used on LunarLake to handle wake-ups using the HDaudio WAKEEN and WAKESTS.

Pierre-Louis Bossart (3):
  soundwire: extend parameters of new_peripheral_assigned() callback
  soundwire: bus: add callbacks for device_number allocation
  soundwire: intel_auxdevice: add hybrid IDA-based device_number
    allocation

v2:
 - Move the device numver allocation from bus.c to intel_auxdevice.c
 - List the codecs with wake capability in a quirk table, and assign device
   number according to that quirk table. 

 drivers/soundwire/bus.c             | 18 +++---
 drivers/soundwire/intel_auxdevice.c | 85 ++++++++++++++++++++++++++---
 include/linux/soundwire/sdw.h       | 12 ++--
 include/linux/soundwire/sdw_intel.h |  7 +++
 4 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.25.1

