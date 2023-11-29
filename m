Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD77FDB53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjK2PZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjK2PZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D581705
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C383C433D9;
        Wed, 29 Nov 2023 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271515;
        bh=ALQSUwIpXqcEh03ppshskh+FaGQmb8S9LPkrgK0UVXM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pjfaA5lG4wRnePTeuMezTeQNR3cQJMV+w9wh7qyCxTfSh6HoR2K587L8Gq9hpx0n7
         uEwbK6mH1stOabGtj/fUMIf4ZqOty9O96MhUWSmBfe8nHraYdmYpHZQw0D4g1YfNlA
         jckFEC2XQ2BWf1wIUrX4H7/jJSTui7qNmQeZBd4LRrfAA/0sEm7i5tbEeTHEA2XHVn
         fPuWhSk3a+aHdaAO7ncU88ZQaIlo3Nn9ulhFrJWSBnBX5lYtCPi076CQOOcCr55b39
         ozIgyrKLSd5GV20l7uMyuv/nUEM5l4QRrtLlG/iOtQPRhiwAExMOVaXX41uiBDRjS/
         NDVoLiegViOtQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:32 +0100
Subject: [PATCH 07/12] selftests/hid: tablets: do not set invert when the
 eraser is used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-7-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1038;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ALQSUwIpXqcEh03ppshskh+FaGQmb8S9LPkrgK0UVXM=;
 b=Ww9wUd/GRVTn1WpgOseXPPpOG+0ScJMar5njGQwo+gu43hi61Hw4ji4jWyhXEkih6ES2OAmJA
 RTNvk9zuLSEBut7pBFs6A9moqRluGVPc7wrwJCOk1f4lYJZpQ+tLIs2
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that the chart from Microsoft is not exactly what I got here:
when the rubber is used, and is touching the surface, invert can (should)
be set to 0...

[0] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 44a004ca69d1..f93dfbb2a3e5 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -382,7 +382,7 @@ class PenDigitizer(base.UHIDTestDevice):
         elif state == PenState.PEN_IS_ERASING:
             pen.tipswitch = False
             pen.inrange = True
-            pen.invert = True
+            pen.invert = False
             pen.eraser = True
 
         pen.current_state = state

-- 
2.41.0

