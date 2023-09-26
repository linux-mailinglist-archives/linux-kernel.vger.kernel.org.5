Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FF7AE577
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjIZGGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjIZGGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:06:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA5DE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708403; x=1727244403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BTeQjxFqqPQbTYtnjfB/3At0ooEzs++Phg1kXxCT1Pw=;
  b=I4GlE4HS8D4BCfbJHf3iQjVU1BEXlUfxCL0KF8qK8O0UR5BfBC9kYTu/
   DfMppQPYI4mvuFMAp/hwK82LOygEUCqwbRMLglI0F4zICi+TgEKfrgG80
   hgaxoPLnB5aqnv1f3rJKhVhiTqcCWTzPl2zBNlIfwk2hWcyot8NE2gews
   3+H8Poe7td3chEfohNuLp+EAUf8e9kyFA/z1ajCY0V9vOmqEh0J9voril
   HMeH2pPnPZ6rHw8tkqquMb09oj2jP/2Nh/7iNRybGPzRmNGH+U+s9rp24
   VoFQCVaVGG3bhpYnGeV3cUjzDwGJPyNX6OG/X1f5RWaAM6XTg6ViDUyoo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447990793"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447990793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892074766"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892074766"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:05:33 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH -V4 0/4] memory tiering: calculate abstract distance based on ACPI HMAT
Date:   Tue, 26 Sep 2023 14:06:24 +0800
Message-Id: <20230926060628.265989-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v4:

- Fix and optimize the error processing.  Thanks Alistair's comments!

- Collected reviewed-by.

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
