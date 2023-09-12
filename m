Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C0479C9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjILIVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjILIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:21:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5FE6F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694506885; x=1726042885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AmELVUeBBy4RL6SU7kfC0jZI+3ejOs0GDXlThj+fPLY=;
  b=ZpKORljsA9gmACk6AWDx80BXNwP+DK9HPT4NRxTm3Jyno83OzNabSSRb
   MnQoDOnOO6RqU/Su0gi5I4FY9uN5HaOfMYCF4xhDrGZJj1oYbjpx94VUN
   mCCOBueLXcW/VrJ1quLcpgvzsyZCaKDoRNUtxD5bnpCquk4rKh7iuBNuj
   /kufZO47vLkCqueQI2s+/hDWO072ZdTAZc70hR3VMDrhjdpGA7S6MuBM+
   oFKgOUOKvhoDAzvipXKmkSfTvu8tglEDR3H7aqtgFlJ6rPmu+0TfsBYRR
   T+P4Mam3kBK4iqxkX6ltb3MMMDM9K5uI9iAIASdFhyhlmRtXZ9qFsjzHQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442322950"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="442322950"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746787588"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746787588"
Received: from shicha9x-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.213])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:21:18 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH -V3 0/4] memory tiering: calculate abstract distance based on ACPI HMAT
Date:   Tue, 12 Sep 2023 16:20:57 +0800
Message-Id: <20230912082101.342002-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the explicit memory tiers framework to manage systems with
multiple types of memory, e.g., DRAM in DIMM slots and CXL memory
devices.  Where, same kind of memory devices will be grouped into
memory types, then put into memory tiers.  To describe the performance
of a memory type, abstract distance is defined.  Which is in direct
proportion to the memory latency and inversely proportional to the
memory bandwidth.  To keep the code as simple as possible, fixed
abstract distance is used in dax/kmem to describe slow memory such as
Optane DCPMM.

To support more memory types, in this series, we added the abstract
distance calculation algorithm management mechanism, provided a
algorithm implementation based on ACPI HMAT, and used the general
abstract distance calculation interface in dax/kmem driver.  So,
dax/kmem can support HBM (high bandwidth memory) in addition to the
original Optane DCPMM.

Changelog:

v3:

- Move algorithm to calculate abstract distance from read/write
  latency/bandwidth from hmat.c to memory-ters.c per Alistair's
  comments.

- Fix memory types putting in kmem.c for error path.

V2:

- Fix a typo in 4/4.

- Collected reviewed-by and tested-by.

V1 (from RFC):

- Added some comments per Aneesh's comments, Thanks!

Best Regards,
Huang, Ying
