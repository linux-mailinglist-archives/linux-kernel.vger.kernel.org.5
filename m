Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192375593D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGQBuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQBuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:50:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F690E52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689558631; x=1721094631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qB3NAj30rPuoPNG68khmlzX8qOwByr0gr+9AcMglQPQ=;
  b=NL6dScHYdOI865zNwnakreFWQYOfQzgqNhO+pHAQxN8Hh23zL9eoQGNh
   lwcdpW3kBkf9uJQawhAYjLjH2pg/od0mn9afdHZTj6VGoSuDBDTP+UeKe
   bNpPFZbwBCkYexYsj11brrnW+llD4oSIqtBno6EfvopaKBiWaEhcGo8RS
   mNwZOQDqpsC5om1jIEBtvrReVoREYb2ySSo/zRh9yLWMnR+GLow6VmgQB
   2G7/YjL5jeb4pzxMhmiKMgCRiDi6Q0F6U7qnqA1HLjejkPBUQzQSzN6M9
   6e0xvBomjObLjE7gz05PCJQcQM9govECSToCEfvEi37BEX9YW6SKimW5h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="364691895"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="364691895"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 18:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="836721119"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="836721119"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2023 18:50:29 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v3 0/2] Query the RSU SPT table offset to determine RSU page size
Date:   Mon, 17 Jul 2023 09:49:01 +0800
Message-Id: <cover.1689524302.git.kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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

Radu Bacrau (1):
  firmware: stratix10-rsu: query spt addresses

Teh Wen Ping (1):
  firmware: stratix10-svc: Generic Mailbox Command

 drivers/firmware/stratix10-rsu.c              | 100 +++++++++++++++++-
 drivers/firmware/stratix10-svc.c              |  18 ++++
 include/linux/firmware/intel/stratix10-smc.h  |  25 +++++
 .../firmware/intel/stratix10-svc-client.h     |   5 +
 4 files changed, 147 insertions(+), 1 deletion(-)


base-commit: 5133c9e51de41bfa902153888e11add3342ede18
-- 
2.25.1

