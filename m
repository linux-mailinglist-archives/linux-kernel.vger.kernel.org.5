Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19B87BA134
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjJEOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbjJEOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8293250
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696515603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/M/mDfnV0O1UQMEklooDLZvgibVMpXp93dsISQC12dY=;
        b=JUinUkLi84aWmaiX/p6WzafbKAIRhSyEcPSf8jeJx/OcIZVJNiRWtkbXCQbJq1dOiPgKlG
        d+z6cnlO+J/FR1LKiKqArNyOCtHIN6p8c2fqYWrBDn/nM/hfqP7+weqUtNYs93lPdFvMiU
        in6m7VPjO2Rp9tPAVcfODp2ceQF60Uk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-YciYf3GKOOCx-hhuUbdJTg-1; Thu, 05 Oct 2023 07:18:46 -0400
X-MC-Unique: YciYf3GKOOCx-hhuUbdJTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4CD3800BB7;
        Thu,  5 Oct 2023 11:18:45 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw1.lab.eng.bos.redhat.com [10.16.200.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1CF40C2015;
        Thu,  5 Oct 2023 11:18:45 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     David Arcari <darcari@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: fix mismatch in get function for max_idle
Date:   Thu,  5 Oct 2023 07:17:57 -0400
Message-ID: <20231005111757.1293740-1-darcari@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported this

      [ 444.853098] BUG: KASAN: global-out-of-bounds in param_get_int+0x77/0x90
      [ 444.853111] Read of size 4 at addr ffffffffc16c9220 by task cat/2105
      ...
      [ 444.853442] The buggy address belongs to the variable:
      [ 444.853443] max_idle+0x0/0xffffffffffffcde0 [intel_powerclamp]

There is a mismatch between the param_get_int and the definition of
max_idle.  Replacing param_get_int with param_get_byte resolves this
issue.

Fixes: ebf519710218 ("thermal: intel: powerclamp: Add two module parameters")

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 36243a3972fd..5ac5cb60bae6 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -256,7 +256,7 @@ static int max_idle_set(const char *arg, const struct kernel_param *kp)
 
 static const struct kernel_param_ops max_idle_ops = {
 	.set = max_idle_set,
-	.get = param_get_int,
+	.get = param_get_byte,
 };
 
 module_param_cb(max_idle, &max_idle_ops, &max_idle, 0644);
-- 
2.41.0

