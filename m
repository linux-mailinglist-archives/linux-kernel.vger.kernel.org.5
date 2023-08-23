Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181A3785041
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjHWF57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjHWF5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:57:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F23CA1;
        Tue, 22 Aug 2023 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692770272; x=1724306272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6zbNh99vqUgCHNp+Zme9ID2vkev0Ls+UC8FQ+p7DB0=;
  b=Gmsy/5HzmD8B2BZXiUFdwlSDrLXP4Q/L71sy2e+S6pSd9ku2jM7uRQ6T
   gJACnhUZ0JuXiqiBbYruE1f9I/4kBbR7ySck9efShS8Fx6kjphfBnbnMN
   sISXvDsom5xFVFLQw6NBJcEdV8eXdXHsf8+tr7FQg9c0F1hH8t//UY3Ru
   YWc0cbQ76rhuAveTgjH7Gleyb33u9LXhYgZGcf7FTglxKlZTW7nj8nRX8
   JlI7thvT8ODdcY7VFU6whbXOvTCy9xqmeczEPb15RoZ/gtWHi4hu2+nLs
   +ltX2jS7kMnBBsKvfkMiKM6S8qWS/NUF11adEuHVZkK7QzrKol6ZArOfn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="438009755"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438009755"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983140554"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983140554"
Received: from ebold-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.213.156])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:57:47 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     dave.hansen@linux.intel.com, tglx@linutronix.de, x86@kernel.org,
        bp@alien8.de
Cc:     artem.bityutskiy@linux.intel.com, acme@kernel.org,
        bpf@vger.kernel.org, namhyung@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, hpa@zytor.com, mark.rutland@arm.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH 1/2] perf/x86/cstate: Allow reading the package statistics from local CPU
Date:   Wed, 23 Aug 2023 08:56:52 +0300
Message-Id: <20230823055653.2964237-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823055653.2964237-1-tero.kristo@linux.intel.com>
References: <20230823055653.2964237-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSR registers for reading the package residency counters are
available on every CPU of the package. To avoid doing unnecessary SMP
calls to read the values for these from the various CPUs inside a
package, allow reading them from any CPU of the package.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Suggested-by: Kan Liang <kan.liang@intel.com>
---
 arch/x86/events/intel/cstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 835862c548cc..5cfe021edc65 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -336,6 +336,9 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!(pkg_msr_mask & (1 << cfg)))
 			return -EINVAL;
+
+		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
 				      topology_die_cpumask(event->cpu));
-- 
2.25.1

