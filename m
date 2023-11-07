Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B17E3AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjKGLWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjKGLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:21:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89491;
        Tue,  7 Nov 2023 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356116; x=1730892116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4Tpz5L6PCxNOS3E/Mpmben/vumZjjJ+Uyr4CUFs7VU=;
  b=D42oczmo5P6ehk84XyX3PDRwcKWAUXm1yek00Cp6XNqJYIeXto5z6YEZ
   vXG6yF71EGKO4RAe5It+fR2CuUthZa7s/Rs/UW+PjHVKgWvmti4nZ2dta
   nsL2ZY8+eaEYJv5fzrSeQKRqu79EgIZM2y8UW7T4ZTLRoXcbeLBR45RH0
   2Ps8UYsJGcAXC3GFZrP5tCzFYmdIIF+xNf8kibPj7IWQyx9Z5q9e2ohgt
   afppx+TUWURRanR+2bG/luKhbXe0uQjx4wlWAxXGS3NUVVCdW3YoBG3On
   RI52vkF5A6Qv8uCdiH88hJoFHHD6ObnJuqYXzn62fYVRccirNtLCswQzw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727076"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579774"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579774"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:21:54 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id C4038580D61;
        Tue,  7 Nov 2023 03:21:51 -0800 (PST)
From:   Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/7] qbv cycle time extension/truncation
Date:   Tue,  7 Nov 2023 06:20:16 -0500
Message-Id: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
the Cycle Time Extension variable allows this extension of the last old
cycle to be done in a defined way. If the last complete old cycle would
normally end less than OperCycleTimeExtension nanoseconds before the new
base time, then the last complete cycle before AdminBaseTime is reached
is extended so that it ends at AdminBaseTime.

Changes in v2:

- Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
- Removed sched_changed created in v1 since the new cycle_time_correction
  field can also serve to indicate the need for a schedule change.
- Added 'bool correction_active' in 'struct sched_entry' to represent
  the correction state from the entry's perspective and return corrected
  interval value when active.
- Fix cycle time correction logics for the next entry in advance_sched()
- Fix and implement proper cycle time correction logics for current
  entry in taprio_start_sched()

v1 at:
https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/

Faizal Rahim (7):
  net/sched: taprio: fix too early schedules switching
  net/sched: taprio: fix cycle time adjustment for next entry
  net/sched: taprio: update impacted fields during cycle time adjustment
  net/sched: taprio: get corrected value of cycle_time and interval
  net/sched: taprio: fix delayed switching to new schedule after timer
    expiry
  net/sched: taprio: fix q->current_entry is NULL before its expiry
  net/sched: taprio: enable cycle time adjustment for current entry

 net/sched/sch_taprio.c | 263 ++++++++++++++++++++++++++++++++---------
 1 file changed, 209 insertions(+), 54 deletions(-)

-- 
2.25.1

