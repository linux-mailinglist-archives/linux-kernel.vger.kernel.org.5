Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3099C75603B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjGQKSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CABB1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9uZnNi/X5LAplhAECNi5MK9XPEkBrvNM7bX0mtceGCo=;
        b=SMxW/8U/nPc5DeruV5X0WZQfDFWPa93S7shlwm8cBGv6LU5mm7iONPbOPWn6AWATP3KXt9
        LaWuWHfLJAoLkFD1Ffs18UNkPzhZ99fuVwcqOuMEsNgTD4JoWHxp/707pMjjq0ZtUijAzx
        qUd7nkHPbrYaua8cKYwM5wNQA63lNzk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-DbrMMteZNtG7zTB2ibnWHw-1; Mon, 17 Jul 2023 06:17:49 -0400
X-MC-Unique: DbrMMteZNtG7zTB2ibnWHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81896800B35;
        Mon, 17 Jul 2023 10:17:48 +0000 (UTC)
Received: from dhcp-134-122.lab.eng.brq2.redhat.com (dhcp-134-122.lab.eng.brq2.redhat.com [10.37.134.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1FF040C6F4C;
        Mon, 17 Jul 2023 10:17:46 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        carsten.haitzler@arm.com, james.clark@arm.com, acme@kernel.org,
        jstancek@redhat.com
Subject: [PATCH] perf test coresight: asm_pure_loop: add .note.GNU-stack
Date:   Mon, 17 Jul 2023 06:17:42 -0400
Message-Id: <e79288922fbd0bad6facf06488735ec74f811d1b.1689588798.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add .note.GNU-stack annotation to indicate it does not need
executable stack.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
index 75cf084a927d..bb39d8089331 100644
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
@@ -26,3 +26,5 @@ skip:
 	mov	x0, #0
 	mov	x8, #93 // __NR_exit syscall
 	svc	#0
+
+.section .note.GNU-stack,"",@progbits
-- 
2.39.0

