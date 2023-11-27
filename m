Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AC7FA94E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjK0Swm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0Swl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:52:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A54D53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701111168; x=1732647168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PPBIE6cpgWRt0aOkO4Ilhqr7AooU9+BSua75NG//P5Y=;
  b=euPMm/T4INzkfCXnvEo9+GiPf11tfhXi7I/0tvclFTq4Egflag4VZ0Y+
   oMk46sjAfRJ5kwhThtcY4kwHtiN6t9ieUxE0Nn+VIKCgaOayy64hzWiHz
   KNwIO+TEcGLfPIk5QdJFPPcQKtuNx8cL/G3vl1tJyLmbln3f1KdyaBQjM
   r+rRNwOClJB8ffN4BzyhOYeiJAbHXqah5SrR14t/wYwmDqxt8+pCPMOgG
   yFM0qgH/nS8PtnF/btXjlj55bgx1uOul0oCHAGsDTeY8dH+R8RFNwKi0k
   Q6gAgkuxlREzZoAhDU69r9mWomjilHxvkgio8uf39W4HlQ/A13thCp9TO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457099426"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457099426"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="772021665"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="772021665"
Received: from jfdev013vml03.jf.intel.com ([10.165.161.72])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2023 10:52:47 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, kyle.meyer@hpe.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v2 0/2] Fix NULL pointer dereference issue during discovering UPI topology
Date:   Mon, 27 Nov 2023 10:52:44 -0800
Message-Id: <20231127185246.2371939-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

From: Alexander Antonov <alexander.antonov@linux.intel.com>

The NULL dereference happens inside upi_fill_topology() procedure in
case of disabling one of the sockets on the system.

For example, if you disable the 2nd socket on a 4-socket system then
uncore_max_dies() returns 3 and inside pmu_alloc_topology() memory will
be allocated only for 3 sockets and stored in type->topology.
In discover_upi_topology() memory is accessed by socket id from CPUNODEID
registers which contain physical ids (from 0 to 3) and on the line:

    upi = &type->topology[nid][idx];

out-of-bound access will happen and the 'upi' pointer will be passed to
upi_fill_topology() where it will be dereferenced.

To avoid this issue update the code to convert physical socket id to
logical socket id in discover_upi_topology() before accessing memory.

Changed in v2:
 1. Factor out topology_gidnid_map() with common code for GIDNIDMAP procedure

Alexander Antonov (2):
  perf/x86/intel/uncore: Fix NULL pointer dereference issue in
    upi_fill_topology()
  perf/x86/intel/uncore: Factor out topology_gidnid_map()

 arch/x86/events/intel/uncore_snbep.c | 71 ++++++++++++++++------------
 1 file changed, 40 insertions(+), 31 deletions(-)

-- 
2.25.1

