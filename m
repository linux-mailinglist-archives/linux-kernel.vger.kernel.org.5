Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702F77DF701
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377058AbjKBPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377049AbjKBPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:48:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF1191;
        Thu,  2 Nov 2023 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698940106; x=1730476106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Vj/umKp6KCEEXAyYuUc1ZRbWwXpcTVXJs6xLHU+IwWA=;
  b=HqDpr0+Be1Y1EYOgT2TCscxOyoNFwUG/y3rrHXCTKpLwXhEOYYfUCQ6+
   /YfN4+U+qrnhHW7l1ffASAzO3C6rmgxaKRdE5FdVHLd3q9TagTcafkW9q
   2GHvStVFstDDLUFMJNKxcc2NAHy41CI69/Xc2clGXf+IJHjg5mshCyKQ2
   QSkGunOX2b5dKnDlFo57Hup4i/wvOMOzHT/Z98C0J96L+sL9t/B3Tankr
   zaJkL7+xprlOip0qfSX2ODVL/AxNIHuhlHTtsPFg082vp6kVgPqR7Vlcr
   i5qqDSRj7wR7WpqhEvd2Ht2m6/CutGOVsWsthEP+IvkOMJ483fLEhUVmL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368088491"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="368088491"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878295300"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="878295300"
Received: from pasangle-nuc10i7fnh.iind.intel.com ([10.223.107.83])
  by fmsmga002.fm.intel.com with ESMTP; 02 Nov 2023 08:48:24 -0700
From:   Parshuram Sangle <parshuram.sangle@intel.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, jaishankar.rajendran@intel.com,
        parshuram.sangle@intel.com
Subject: [PATCH 2/2] KVM: documentation update to halt polling
Date:   Thu,  2 Nov 2023 21:16:28 +0530
Message-Id: <20231102154628.2120-3-parshuram.sangle@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102154628.2120-1-parshuram.sangle@intel.com>
References: <20231102154628.2120-1-parshuram.sangle@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected kvm documentation to reflect current handling of
polling interval on successful and un-successful polling events.
Also updated the description about newly added halt_poll_ns_grow_start
parameter.

Co-developed-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
Signed-off-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
Signed-off-by: Parshuram Sangle <parshuram.sangle@intel.com>
---
 Documentation/virt/kvm/halt-polling.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/virt/kvm/halt-polling.rst b/Documentation/virt/kvm/halt-polling.rst
index 64f32a81133f..cff388d9dc72 100644
--- a/Documentation/virt/kvm/halt-polling.rst
+++ b/Documentation/virt/kvm/halt-polling.rst
@@ -44,12 +44,14 @@ or in the case of powerpc kvm-hv, in the vcore struct:
 
 Thus this is a per vcpu (or vcore) value.
 
-During polling if a wakeup source is received within the halt polling interval,
-the interval is left unchanged. In the event that a wakeup source isn't
-received during the polling interval (and thus schedule is invoked) there are
-two options, either the polling interval and total block time[0] were less than
-the global max polling interval (see module params below), or the total block
-time was greater than the global max polling interval.
+During polling if a wakeup source is not received within the halt polling
+interval (and thus schedule is invoked), the interval is always shrunk in
+shrink_halt_poll_ns(). In the event that a wakeup source is received during
+the polling interval, polling interval is left unchanged if total block time
+is below or equal to current interval value otherwise there are two options,
+either the polling interval and total block time[0] were less than the global
+max polling interval (see module params below), or the total block time was
+greater than the global max polling interval.
 
 In the event that both the polling interval and total block time were less than
 the global max polling interval then the polling interval can be increased in
@@ -79,11 +81,11 @@ adjustment of the polling interval.
 Module Parameters
 =================
 
-The kvm module has 3 tuneable module parameters to adjust the global max
-polling interval as well as the rate at which the polling interval is grown and
-shrunk. These variables are defined in include/linux/kvm_host.h and as module
-parameters in virt/kvm/kvm_main.c, or arch/powerpc/kvm/book3s_hv.c in the
-powerpc kvm-hv case.
+The kvm module has 4 tunable module parameters to adjust the global max
+polling interval, initial value (to grow from 0) as well as the rate at which
+the polling interval is grown and shrunk. These variables are defined in
+include/linux/kvm_host.h and as module parameters in virt/kvm/kvm_main.c, or
+arch/powerpc/kvm/book3s_hv.c in the powerpc kvm-hv case.
 
 +-----------------------+---------------------------+-------------------------+
 |Module Parameter	|   Description		    |	     Default Value    |
-- 
2.17.1

