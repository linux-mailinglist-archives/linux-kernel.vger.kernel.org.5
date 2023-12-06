Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F6806C96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377755AbjLFKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377751AbjLFKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0991730
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EAFC433C8;
        Wed,  6 Dec 2023 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859581;
        bh=MRNo+XMbxViAM6QklAQc01OfEHMsqB29e/uDsf8Pahs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=F2r1IxsJUzyyuuEMG92n25mZEfBigsCHqrDAAFsmAvqPcMYEKiV6uVv2Schh/ulFv
         82NhyYKwUegyYH/gAShHHmhZ1V8j2gNuz+9aRyET/LTPx5zLKqfWUTxrDhk2VpCjRP
         +UXu6N7atMZTgspigJsqlq3yKWyPbUxYk7NrJ2iamGceviBbjysssKSYxKWsFlNQVq
         GfoeDMCP8Kia0In4ykXzlLn9mpqKnO01r0HEt6XDk+TQw8+0olyb64ZmX0f7SntnNi
         vSUrrw/r5YiNplhcr0hVrRr0VLx9TEilarfJk3ElCLHxf/mLCfmVRRGwfqRM3rjyt4
         gzF9U6AlBVxGQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:58 +0100
Subject: [PATCH v2 07/15] selftests/hid: tablets: do not set invert when
 the eraser is used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-7-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=1121;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=MRNo+XMbxViAM6QklAQc01OfEHMsqB29e/uDsf8Pahs=;
 b=/+ck7Robg2xIxkHB76XRPHnYeZglxvF/1l97VSJK/2OOKxnOHCebYmmYUuYKkHAc06vYri0D4
 2j7VNM8A614Cgw+xOsZbEKOxsxLenadQ+tAWZJHew98oFcFB0eUORiv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that the chart from Microsoft is not exactly what I got here:
when the rubber is used, and is touching the surface, invert can (should)
be set to 0...

[0] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 27260dc02cc4..cb3955bf0ec5 100644
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

