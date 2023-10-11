Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3867C50BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbjJKLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjJKLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:02:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814BBB7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022130; x=1728558130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y5PY+/hV6/wrlFIbAS/3+SC0p6p4icSVgrCNrHkomwo=;
  b=hC5O7877ZkaMCO9oL8NS07oBYROb/2JH+vFsGGBHjV8GnMCVIr4yqr+r
   2e8TORLz195ULggnJi58nYE9EEXjvhyCWvsL+3q+0josPVkd86Z6/IJ9V
   OnHr/0SFzIH2BW9ImCTo5pQYM+jyHgG6slcZx2KhzG273Y4AysLNjv49Q
   7Dv1esY/dLgIucGGPc5D9dWcbrLK4DoT571eYzUdapFIXLc4zUnLlGcxO
   6BYabow6c5j+z9SaguhqDcOsir1bhxNrbcXphgfD+opmFIh6+LAsPv2hC
   xAwU+jz9WVljxCFDNh6URFUofMmzeDis6DbgaldX0Z3EXG9yDcbMOh9Tz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369696899"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369696899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788960256"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788960256"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/4] mei: enhance mei pxp recoverability
Date:   Wed, 11 Oct 2023 14:01:53 +0300
Message-ID: <20231011110157.247552-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add timeouts to send/receive API on mei bus to avoid
  infinite waits and consequent deadlock.
- Re-enable the mei pxp client upon loss.
- Retry receive operation in case of memory pressure related failure.

Alan Previn (1):
  mei: update mei-pxp's component interface with timeouts

Alexander Usyskin (3):
  mei: bus: add send and recv api with timeout
  mei: pxp: recover from recv fail under memory pressure
  mei: pxp: re-enable client on errors

 drivers/gpu/drm/i915/pxp/intel_pxp_tee.c |  8 ++-
 drivers/misc/mei/bus.c                   | 88 +++++++++++++++++++++++-
 drivers/misc/mei/pxp/mei_pxp.c           | 88 +++++++++++++++++++++---
 include/drm/i915_pxp_tee_interface.h     |  6 +-
 include/linux/mei_cl_bus.h               |  8 +++
 5 files changed, 183 insertions(+), 15 deletions(-)

-- 
2.41.0

