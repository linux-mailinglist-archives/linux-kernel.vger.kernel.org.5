Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF458091F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443848AbjLGT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjLGT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:56:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F0170E;
        Thu,  7 Dec 2023 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701978985; x=1733514985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t5VxIPCjhEqavPh7wbXuE5TbTXLyEI0R+msiZrynqtw=;
  b=SzfyP099vvvRJFc4KfKN3wteZH8Dx0gSBg2NorFoiB9GNl2g375YxCB7
   5GDm+FS48EEbZxRqWOff/P1mBT5StSViJkKSHw24bzayciA/FWx2MX/fE
   4ZHK6YMeC0+l7CqQN93FVSbb0CibahsRR8hwS6t78Y725NWnV1jQfWMtl
   HFtf3wR10ltukZIWEHIY/2Lm4dWUuiIOMVkzRD+DXkn3T2QFGKy+qZf7+
   IZuhlKXQuuTv/JKHaSlUuQjb1n0jPM+t91Z+zVu9F2ZZP1bEEKyl1e6lJ
   n47/WrPa/O/ySW0R/mHoc5qK74ctWB/Z0ZoNmmrH8RT+cDQnJnpKeBj9X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="15848966"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="15848966"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889858593"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="889858593"
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
Subject: [PATCH v6 2/3] x86/resctrl: Use total bandwidth for mba_MBps option when local isn't present
Date:   Thu,  7 Dec 2023 11:56:12 -0800
Message-ID: <20231207195613.153980-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207195613.153980-1-tony.luck@intel.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
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

On Intel systems the memory bandwidth monitoring events are
independently enumerated. It is possible for a system to support
total memory bandwidth monitoring, but not support local bandwidth
monitoring. On such a system a user could not enable mba_sc mode.
Users will see this highly unhelpful error message from mount:

 # mount -t resctrl -o mba_MBps resctrl /sys/fs/resctrl
 mount: /sys/fs/resctrl: wrong fs type, bad option, bad superblock on
 resctrl, missing codepage or helper program, or other error.
 dmesg(1) may have more information after failed mount system call.

dmesg(1) does not provide any additional information.

Modify the existing "mba_MBps" mount option to switch to total bandwidth
monitoring if local monitoring is not available.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5f64a0b2597c..7410513db45a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2725,6 +2725,8 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		if (is_mbm_local_enabled())
 			ctx->enable_mba_mbps_local = true;
+		else if (is_mbm_total_enabled())
+			ctx->enable_mba_mbps_total = true;
 		else
 			return -EINVAL;
 		return 0;
-- 
2.41.0

