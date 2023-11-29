Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323647FDC08
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbjK2P0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjK2PZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1921BC6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B6C433C9;
        Wed, 29 Nov 2023 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271522;
        bh=w/995xxVqtTO8u3lC0LbwRgYuG2cz3TbNhfloMXAPlw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CyskxjdQbab85B6WOL09u/AiVOaGlrIRQv8Q45u21Mg19mAm1UEKoiAqwYnfwclgv
         ZhbnuZEx5eHH9wAxv7Kn1ao3xymaIpF+ALVTlrf7h/4CRt1eq402hFp+AeboN5HPww
         IoN8Xn1GrnGwgKMLa9y6ln4bfFkZEDraF2qvtE7dkkVXhk/5uIBfDuQiIYtw7SstoG
         1xTlEVJiHH0Wdw7dKrYXBmqFsIGw8k7wbScJSnFYqJP0P93ZBV/Ae5Mtaqjf4r+VNY
         aZtqaiPPnBWwcNRdivx+CWE+e3myRPuYNt2YDnGt7y9tsIpM4KUbKhzL+xbeCXYE2Z
         3iGgAmfBrEUjA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:36 +0100
Subject: [PATCH 11/12] selftests/hid: tablets: add a secondary barrel
 switch test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-11-ba15a1fe1b0d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=4576;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=w/995xxVqtTO8u3lC0LbwRgYuG2cz3TbNhfloMXAPlw=;
 b=ucW8VetRL0kO5xtEuqwr+BNOFlcTIG0bV37zbqf9YqTWowmFybNeamE/JypnOBJBzhknjY5sg
 YmR5vZ+H+JpA39N5Q3GwldF5BNuty5+5TlrTd4/5LNH2EK2hVl26QgG
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

Some tablets report 2 barrel switches. We better test those too.

Use the same transistions description from the primary button tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 440a87170db1..f24cf2e168a4 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -351,6 +351,56 @@ class PenState(Enum):
             ),
         }
 
+    @staticmethod
+    def legal_transitions_with_secondary_button() -> Dict[str, Tuple["PenState", ...]]:
+        """We revisit the Windows Pen Implementation state machine:
+        we now have a secondary button.
+        Note: we don't looks for 2 buttons interactions.
+        """
+        return {
+            "hover-button": (PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,),
+            "hover-button -> out-of-range": (
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+            ),
+            "in-range -> button-press": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+            ),
+            "in-range -> button-press -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> touch -> button-press -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+            ),
+            "in-range -> touch -> button-press -> release -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> button-press -> touch -> release -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> button-press -> touch -> button-release -> release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+        }
+
     @staticmethod
     def tolerated_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """This is not adhering to the Windows Pen Implementation state machine
@@ -429,6 +479,7 @@ class Pen(object):
         self.width = 10
         self.height = 10
         self.barrelswitch = False
+        self.secondarybarrelswitch = False
         self.invert = False
         self.eraser = False
         self.xtilt = 1
@@ -721,6 +772,22 @@ class BaseTest:
             """Rework the transition state machine by adding the primary button."""
             self._test_states(state_list, scribble)
 
+        @pytest.mark.skip_if_uhdev(
+            lambda uhdev: "Secondary Barrel Switch" not in uhdev.fields,
+            "Device not compatible, missing Secondary Barrel Switch usage",
+        )
+        @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
+        @pytest.mark.parametrize(
+            "state_list",
+            [
+                pytest.param(v, id=k)
+                for k, v in PenState.legal_transitions_with_secondary_button().items()
+            ],
+        )
+        def test_valid_secondary_button_pen_states(self, state_list, scribble):
+            """Rework the transition state machine by adding the secondary button."""
+            self._test_states(state_list, scribble)
+
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
             "Device not compatible, missing Invert usage",

-- 
2.41.0

