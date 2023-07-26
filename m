Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB81762A86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGZE71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGZE7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:59:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581D1FC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690347556; x=1721883556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TTQweHb9px5w+WSSg/IXmEMaMZomGcINs6qdcew+w+k=;
  b=J5ATywCaCoyfxMootTvKWlF7/Tb+4IVoQYGnFY/DjyK2dYIBgKo5IV4P
   DR+i1v/I5m7towtLnv9HNvch7GWsvKYJY+x9QSD6I/9lefdxR5Y/puOeP
   oz9g6Vw8MgmD+cjD94C4g5SMTGt9IBpSiRcVNdvhEPE2I2IiJReAHZTWx
   H6hte+4tAwD3PNWWceVxHFrtDttziwlkxz+PfB3g0aj5o6e9mDwsJ/Imf
   lPchiP9r15Dv8eHotyejMFwFw/loIADpBOw6jEz35s28EirqHQLAeNZJu
   w/B6DhG0dJOT9yjGMbPiqw4uIZoYk2RppqPnT9tjbe++aOliq4sPht3aK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="365371841"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="365371841"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 21:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="756047739"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="756047739"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2023 21:59:14 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v4 0/2] Query the RSU SPT table offset to determine RSU page size
Date:   Wed, 26 Jul 2023 12:57:19 +0800
Message-Id: <cover.1690347245.git.kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi,
This patchset is to add the generic mailbox command in the svc driver
to enable the rsu driver to query spt address.
SPT0 address - lower range & SPT1 address - upper range address will be
queried in order to determine the page size of RSU, whether it is
32kB or 64kB that is supported.

Thanks,
KJ

changelog v2:
- Update the comment on svc COMMAND_MBOX_SEND_CMD
- Update the rsu mailbox cmd ret_val to use already defined ret

changelog v3:
- Check for IS_ERR on stratix10_svc_allocate_memory return

changelog v4:
- Fix checkpatch alignment issue

Radu Bacrau (1):
  firmware: stratix10-rsu: query spt addresses

Teh Wen Ping (1):
  firmware: stratix10-svc: Generic Mailbox Command

 drivers/firmware/stratix10-rsu.c              | 102 +++++++++++++++++-
 drivers/firmware/stratix10-svc.c              |  18 ++++
 include/linux/firmware/intel/stratix10-smc.h  |  25 +++++
 .../firmware/intel/stratix10-svc-client.h     |   5 +
 4 files changed, 148 insertions(+), 2 deletions(-)


base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
-- 
2.25.1

