Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072317907A8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352100AbjIBLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352071AbjIBLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C692E6A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E533BB826CD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E93C433C9;
        Sat,  2 Sep 2023 11:51:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9q-000Jva-1I;
        Sat, 02 Sep 2023 07:51:18 -0400
Message-ID: <20230902115118.216006582@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 01/11] rv: Set variable da_mon_##name to static
References: <20230902115035.786076237@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Liao <liaoyu15@huawei.com>

gcc with W=1 reports
kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol 'da_mon_wip' was not declared. Should it be static?

The per-cpu variable 'da_mon_##name' is only used in its defining file, so
it should be static.

Link: https://lore.kernel.org/linux-trace-kernel/20230823020051.3184953-1-liaoyu15@huawei.com

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307280030.7EjUG9gR-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/rv/da_monitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 9eb75683e012..9705b2a98e49 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -262,7 +262,7 @@ static inline void da_monitor_destroy_##name(void)						\
 /*												\
  * per-cpu monitor variables									\
  */												\
-DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\
+static DEFINE_PER_CPU(struct da_monitor, da_mon_##name);					\
 												\
 /*												\
  * da_get_monitor_##name - return current CPU monitor address					\
-- 
2.40.1
