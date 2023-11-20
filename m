Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D77F1170
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjKTLOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjKTLOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:14:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053BEB;
        Mon, 20 Nov 2023 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478842; x=1732014842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzPsjJjcfyDfgR8LTQ4WEtUUvgvOSZlRwS0QORtco8Y=;
  b=ggdidZGCs8fcKCH6HV//1Z8wKabJBRM8JOKusu6CQlg8ELJOVmE+Gcu8
   ao2hZjNDcQX2H9uH+KWVGZ46Wn3yGeczmyHVritUwMCeorUOcl26YFMH2
   Dq9QY+iXwsePJSHPgYCNva8cHmROU7P5HpafgFhP1T3vAmlIwvJo0lY95
   7FtZWe5xiIFbSeCwBbPTKxyQPBPojyRie8kh4pyPzJH8XxrOO7AeJIE+I
   oHiPHmrBcblM7OrSNBf9cK9Crn6iL7S+fBtaSr3FfJOAT3Y6pEGZoshXC
   KN27SOrKR6K3LGbSh2wmwaBVSgATYnUf8cCQWbyntkjILmH/j8TmPD4LY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="390457334"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="390457334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="801126899"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="801126899"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:13:58 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 01/26] selftests/resctrl: Don't use ctrlc_handler() outside signal handling
Date:   Mon, 20 Nov 2023 13:13:15 +0200
Message-Id: <20231120111340.7805-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event_open_llc_miss() calls ctrlc_handler() to cleanup if
perf_event_open() returns an error. Those cleanups, however, are not
the responsability of perf_event_open_llc_miss() and it thus interferes
unnecessarily with the usual cleanup pattern. Worse yet,
ctrlc_handler() calls exit() in the end preventing the ordinary cleanup
done in the calling function from executing.

ctrlc_handler() should only be used as a signal handler, not during
normal error handling.

Remove call to ctrlc_handler() from perf_event_open_llc_miss(). As
unmounting resctrlfs and test cleanup are already handled properly
by error rollbacks in the calling functions, no other changes are
necessary.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index bcbca356d56a..8aa6d67db978 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -41,7 +41,6 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 				PERF_FLAG_FD_CLOEXEC);
 	if (fd_lm == -1) {
 		perror("Error opening leader");
-		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
 
-- 
2.30.2

