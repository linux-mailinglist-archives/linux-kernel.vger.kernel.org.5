Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E0784B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjHVUV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHVUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:21:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50910B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:21:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a41035828so2064292b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692735684; x=1693340484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CoIShF4nm+Y+TTq/y1T+mYqaAIRb3s+laDow41BW7Y=;
        b=JprU1KL33Lf+lJpoZAp0GtjuJ3ozT/dIA/XZAwT42K9+Rma03OCSu2M5j/mM5wfIQA
         TiGWUeaJRhgUcAAWaN0bo6JWNAmWoe4Lh6IHpYzcST4eRrQBJTo6NXgsWGD0qCn9YY9J
         Adskx5+uU+hQW9cDkhg19oXZFcCXjGjZDpPp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735684; x=1693340484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CoIShF4nm+Y+TTq/y1T+mYqaAIRb3s+laDow41BW7Y=;
        b=WmGrxyNlyM3My0IJKnwD1Hm/SUXoIAbIT8iZafCX9LWrqjwrftpm5uSqKzbzoeihW+
         LJ6op5NnxLyYlWdgv3VG/4LGIB/R7gzYbkXF0P+INqgBlI8s4HhJika7DyhWul/OE9RL
         9S35cF5v9TjfzORAQclpgnnzH0Q0QcJRkdtYsaKKmlDzXqkJXYUEIZN2UXDmDMLfV7ax
         NwFvGPy9IzfbpUt4VxVaE7bWucaHDVlfVMWBEjVsCDP2ppYY+2ch0JwfhQsK3kOny8Ih
         +RIddCwh1oZMsxllYSB+bYEjoA/BPxLhtyonKZDtV6MP1z+AlhkVTihITuV/hNezxbVZ
         Yj1w==
X-Gm-Message-State: AOJu0Yw437o7hw19CBhoEs6DPMGKVo82xg2Ov7Ro4n1apIoP1XHp/OlY
        yGoJ3xEI8yW59lv348vwPiYsSg==
X-Google-Smtp-Source: AGHT+IEOd1vneyKiVpEjHFGaH9Q1mMseOqcs4FdujoDsrT8ncCLzzNclMLLcp4LQh6q8MNEdCdwUMA==
X-Received: by 2002:a05:6a20:199:b0:130:9638:36d4 with SMTP id 25-20020a056a20019900b00130963836d4mr7946558pzy.33.1692735684540;
        Tue, 22 Aug 2023 13:21:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id w29-20020a63935d000000b00563df2ba23bsm8254729pgm.50.2023.08.22.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:21:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kgdb: Flush console before entering kgdb on panic
Date:   Tue, 22 Aug 2023 13:19:46 -0700
Message-ID: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When entering kdb/kgdb on a kernel panic, it was be observed that the
console isn't flushed before the `kdb` prompt came up. Specifically,
when using the buddy lockup detector on arm64 and running:
  echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

I could see:
  [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
  [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
  [   32.552865] Sending NMI from CPU 5 to CPUs 6:
  [   32.557359] NMI backtrace for cpu 6
  ... [backtrace for cpu 6] ...
  [   32.558353] NMI backtrace for cpu 5
  ... [backtrace for cpu 5] ...
  [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
  [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP

  Entering kdb (current=..., pid 0) on processor 5 due to Keyboard Entry
  [5]kdb>

As you can see, backtraces for the other CPUs start printing and get
interleaved with the kdb PANIC print.

Let's replicate the commands to flush the console in the kdb panic
entry point to avoid this.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/debug_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index d5e9ccde3ab8..3a904d8697c8 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
 	if (panic_timeout)
 		return;
 
+	debug_locks_off();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	if (dbg_kdb_mode)
 		kdb_printf("PANIC: %s\n", msg);
 
-- 
2.42.0.rc1.204.g551eb34607-goog

