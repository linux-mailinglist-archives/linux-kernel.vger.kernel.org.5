Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC876711C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjG1Pxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjG1Pxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:53:36 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D17F2;
        Fri, 28 Jul 2023 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559615; x=1722095615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oQf/S1ueoDews0oxh0qBtYpU3yruH6wicxcwWAyEZqk=;
  b=gVFBZB/X8H1uLZyvAUHfGo6g8D13bqlScUwaMXO0mp1na1vAcC8mbaPO
   BNBcZtTVE1+lSkWHwQ/di/Zb9q8aT6LG/8UIC1NT55Yi5EUDPmkKJ6kkd
   9yZorTFHaRXxsArLVYdIS6Rozm/kGE+TdWSanzKubcj0+XUGKEY0iGlLl
   9pAMMgc2AzFLfBcuB4bqFGRFGjyVKJTYQEl4pK05UHIYnOsYXkOq/9vR9
   h/u7EtQ2ZJSsBvu7DlkRRhx0QCTdGn1xCkisLUWdBT5/L3zZKMf45QW9d
   mH3gfCEH7eZWvQ/OczCromcW0ooPrqiw2Ch4lz0Oilwf9L7cvdEFwS3rp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372246655"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="372246655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727512158"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="727512158"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 08:53:31 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] virtchnl: fix fake 1-elem arrays
Date:   Fri, 28 Jul 2023 17:52:04 +0200
Message-ID: <20230728155207.10042-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
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

6.5-rc1 started spitting warning splats when composing virtchnl
messages, precisely on virtchnl_rss_key and virtchnl_lut:

[   84.167709] memcpy: detected field-spanning write (size 52) of single
field "vrk->key" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1095
(size 1)
[   84.169915] WARNING: CPU: 3 PID: 11 at drivers/net/ethernet/intel/
iavf/iavf_virtchnl.c:1095 iavf_set_rss_key+0x123/0x140 [iavf]
...
[   84.191982] Call Trace:
[   84.192439]  <TASK>
[   84.192900]  ? __warn+0xc9/0x1a0
[   84.193353]  ? iavf_set_rss_key+0x123/0x140 [iavf]
[   84.193818]  ? report_bug+0x12c/0x1b0
[   84.194266]  ? handle_bug+0x42/0x70
[   84.194714]  ? exc_invalid_op+0x1a/0x50
[   84.195149]  ? asm_exc_invalid_op+0x1a/0x20
[   84.195592]  ? iavf_set_rss_key+0x123/0x140 [iavf]
[   84.196033]  iavf_watchdog_task+0xb0c/0xe00 [iavf]
...
[   84.225476] memcpy: detected field-spanning write (size 64) of single
field "vrl->lut" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1127
(size 1)
[   84.227190] WARNING: CPU: 27 PID: 1044 at drivers/net/ethernet/intel/
iavf/iavf_virtchnl.c:1127 iavf_set_rss_lut+0x123/0x140 [iavf]
...
[   84.246601] Call Trace:
[   84.247228]  <TASK>
[   84.247840]  ? __warn+0xc9/0x1a0
[   84.248263]  ? iavf_set_rss_lut+0x123/0x140 [iavf]
[   84.248698]  ? report_bug+0x12c/0x1b0
[   84.249122]  ? handle_bug+0x42/0x70
[   84.249549]  ? exc_invalid_op+0x1a/0x50
[   84.249970]  ? asm_exc_invalid_op+0x1a/0x20
[   84.250390]  ? iavf_set_rss_lut+0x123/0x140 [iavf]
[   84.250820]  iavf_watchdog_task+0xb16/0xe00 [iavf]

Gustavo already tried to fix those back in 2021[0][1]. Unfortunately,
a VM can run a different kernel than the host, meaning that those
structures are sorta ABI.
However, it is possible to have proper flex arrays + struct_size()
calculations and still send the very same messages with the same sizes.
The common rule is:

elem[1] -> elem[]
size = struct_size() + <difference between the old and the new msg size>

The "old" size in the current code is calculated 3 different ways for
10 virtchnl structures total. Each commit addresses one of the ways
cumulatively instead of per-structure.

I was planning to send it to -net initially, but given that virtchnl was
renamed from i40evf and got some fat style cleanup commits in the past,
it's not very straightforward to even pick appropriate SHAs, not
speaking of automatic portability. I may send manual backports for
a couple of the latest supported kernels later on if anyone needs it
at all.

[0] https://lore.kernel.org/all/20210525230912.GA175802@embeddedor
[1] https://lore.kernel.org/all/20210525231851.GA176647@embeddedor

Alexander Lobakin (3):
  virtchnl: fix fake 1-elem arrays in structs allocated as `nents + 1` -
    1
  virtchnl: fix fake 1-elem arrays in structures allocated as `nents +
    1`
  virtchnl: fix fake 1-elem arrays for structures allocated as `nents`

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   9 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_client.c |   4 +-
 drivers/net/ethernet/intel/iavf/iavf_client.h |   2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  75 +++++------
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
 include/linux/avf/virtchnl.h                  | 127 +++++++++++-------
 7 files changed, 124 insertions(+), 101 deletions(-)

-- 
2.41.0

