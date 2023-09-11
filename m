Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF779AD71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbjIKV0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbjIKOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:24:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E9E40;
        Mon, 11 Sep 2023 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694442238; x=1725978238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ivz/zd7ZOwiM8MwSBJmBtaR3E3Ai0q5FJ9ZsHHWB4pg=;
  b=RP+w97Sc5+k9c+lYQB1/o6weFjjMlThSxdNQlU/MYDzfHIMQ/o79HGcO
   YRcUvJj+9G6nKMjbAHJm+WNSSJUcbNA5CkqsOVNPhqWCKl5KjZvL9cQYs
   VlnByviG5aMMoIimYwDPxDZ7Vtf7m0bzGK7Bd/Re+PHhAmj0SUHd/e+Pm
   /5rZgdkCZoIOR2pfQaikV1OQwo1zSu/KBKPUp1ViWiMCYRQ42pjlgB07u
   9kJZWpBJPFUzaIn3Y43s7SKykUGju6I2DnmJyBT42txTQRXTpp13QhR0A
   iO+BLxT3mrDRIjVO5tl2NaM5jm3bOKofZsdWKBK/+EvWgX/80fcieRsgc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378007977"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378007977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="866961000"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="866961000"
Received: from pjayanat-mobl.gar.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.249.44.175])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:17:06 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     artem.bityutskiy@linux.intel.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] tracing/synthetic: Print out u64 values properly
Date:   Mon, 11 Sep 2023 17:17:04 +0300
Message-Id: <20230911141704.3585965-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synth traces incorrectly print pointer to the synthetic event values
instead of the actual value when using u64 type. Fix by addressing the
contents of the union properly.

Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
Cc: stable@vger.kernel.org
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 7fff8235075f..070365959c0a 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
 		break;
 
 	default:
-		trace_seq_printf(s, print_fmt, name, val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
 		break;
 	}
 }
-- 
2.40.1

