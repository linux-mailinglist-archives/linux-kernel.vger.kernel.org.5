Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3362575A2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGSXf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSXf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:35:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C66C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689809755; x=1721345755;
  h=date:from:to:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nribv/50tQ/p1dQw3Z+dB+DDsgwwpop7bUHtWLTlHyY=;
  b=kyQdhYvTGPQnOl1qw3awF/VtUsO8hq02feQk2Tjqhts2f2hPU04/4L1I
   gqAvFZhyFERytAlg1aF+NjnWKenghRK26BKvrKBJfP7xjanLbAX96N7Qq
   u1ZDqJaMQadtI0Wothj5HDcyJeXjW/8BJ9qsVGqfgCCssL9D61DKcv7n3
   SktL51DFeCK6tbeB5qFo2LCTUAyG6IE6qJ1VbGwNhdNXJSpKggCOThTXm
   HbGJ9PK3T8+yQWAGqwfsJYggAL7tDFu2/L8IkECFid+vSiHP/kR5/ZcEh
   /zsy+z8PZicLDfCRJgkAf+jRqvhtvM27DDHNsVbOAzJm6W5GyMBaIvMl/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365475566"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365475566"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 16:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794220636"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794220636"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 16:35:55 -0700
Date:   Wed, 19 Jul 2023 16:35:54 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     rostedt@goodmis.org, Aristeu Rozanski <aris@ruivo.org>,
        linux-kernel@vger.kernel.org
Subject: rasdaemon broke between v6.0 and v6.3?
Message-ID: <ZLhzWoyRCWN0FmqE@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend as plain text - sorry for the earlier HTML]

An internal team is seeing tests that worked on v6.0 fail on v6.3. The problem is that
rasdaemon isn’t waking up to process the “mce_record” trace events.

Manually checking for them works:

root@R-4251:/sys/kernel/debug/tracing>systemctl stop rasdaemon
root@R-4251:/sys/kernel/debug/tracing>
root@R-4251:/sys/kernel/debug/tracing>
root@R-4251:/sys/kernel/debug/tracing>echo 1 > events/mce/mce_record/enable
root@R-4251:/sys/kernel/debug/tracing>
root@R-4251:/sys/kernel/debug/tracing>cat trace_pipe
           <...>-235     [000] .....   596.892583: mce_record: CPU: 0, MCGc/s: f000c15/0, MC13: 8c00004200800090, IPID: 0000000000000000, ADDR/MISC/SYND: 0000000123450000/08000a80c2982086/0000000000000000, RIP: 00:<0000000000000000>, TSC: 14120b051a1, PROCESSOR: 0:c06f1, TIME: 1689802780, SOCKET: 0, APIC: 0
     kworker/0:2-235     [000] .....   597.204343: mce_record: CPU: 0, MCGc/s: f000c15/0, MC255: 9c0000000000009f, IPID: 0000000000000000, ADDR/MISC/SYND: 0000000123450000/000000000000008c/0000000000000000, RIP: 00:<0000000000000000>, TSC: 0, PROCESSOR: 0:c06f1, TIME: 1689802781, SOCKET: 0, APIC: 0

So their tests are injecting errors, and the trace event is firing.

Is there some updated version of rasdaemon needed?

Some kernel CONFIG option problem?

-Tony



