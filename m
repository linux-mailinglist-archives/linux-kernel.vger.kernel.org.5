Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7C8091F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjLGT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:56:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D110EF;
        Thu,  7 Dec 2023 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701978984; x=1733514984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J23aFV6iwILzuNztzQ1fpjCoJLBjXYWEnIF8zssZEKU=;
  b=DD7KdeP5xGzOlZNHQ9ksJWmfPVDbVPLARXS5uWPQB81qeFispzyzqz4g
   1KLH2yCsXQ7MihmV92lZz4dRsTk74WzDZvzuYS/hcSO7A/ogKW3+wy/4h
   08bbxACe9rCFvsT+xFAyVDL51KmV/3upxhi8xkO1jfamb/Tdoj2OsuuVW
   0fJu4kCLqKefW00v75bsX1ZFxsndXnBgJM5Adh6ppRMASBY25XOYp3Uws
   Js4CsL34OGmhd/qeigVcDWhPh+LAou1S9D4rMHp7OFTkY0SV9/N9qxXWZ
   0hU4EKF8Z58t4PVO/2FurQiA987oTBIFlWfZavk9e3IdNXX0aKtt47L2b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="15848938"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="15848938"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889858586"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="889858586"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:56:23 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 0/3] x86/resctrl: mba_MBps enhancements
Date:   Thu,  7 Dec 2023 11:56:10 -0800
Message-ID: <20231207195613.153980-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201214737.104444-1-tony.luck@intel.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two changes relating to the MBA Software Controller(mba_sc):

1) Add a new mount option so the user can choose which memory
bandwidth monitoring event to use as the input to the feedback
loop.

2) Update the "mba_MBps" mount option to make use of total memory
bandwidth event on systems that do not support local bandwidth
event.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes since v5:

Babu: Split into separate patches for the new mount option and the
update to the exising mount option. Since this is now a series, I
also moved the Documentation change to its own patch.

Reinette: Use "mbm_local_bytes", "mbm_total_bytes" as the strings for
the new "mba_MBps_event" option. This sets a precedent that new events
should follow the naming convention for the monitor files for the event.

Reinette: Update rdtgroup_show_options(). I'd completely missed this in
the earlier versions. Note that when the legacy "mba_MBps" mount option
is used, this will show in /proc as if the new option was used:

	# mount -t resctrl -o mba_MBps resctrl /sys/fs/resctrl/
	# grep resctrl /proc/mounts
	resctrl /sys/fs/resctrl resctrl rw,relatime,mba_MBps_event=mbm_local_bytes 0 0

Changing this to exacly match what the user typed would lose the detail
of which event is being used.

Reinette: More documentation needed. I added some text on why using
total instead of local might be useful to some users.

Tony Luck (3):
  x86/resctrl: Add mount option "mba_MBps_event"
  x86/resctrl: Use total bandwidth for mba_MBps option when local isn't
    present
  x86/resctrl: Add new "mba_MBps_event" mount option to documentation

 Documentation/arch/x86/resctrl.rst     | 16 ++++++-
 include/linux/resctrl.h                |  2 +
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 21 ++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 63 +++++++++++++++++++++-----
 5 files changed, 79 insertions(+), 26 deletions(-)


base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.41.0

