Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5834806C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377675AbjLFKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377739AbjLFKqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B3719BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCAC4339A;
        Wed,  6 Dec 2023 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859591;
        bh=pOwfO/gTl6S07OObuc/xFJuitivPZGd6txL7TG2VpdI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Z/k8QP7ehxdzQ+wMfGwuGeX8E6NC+M7NKGeHf+LeZ2AIQCEGk9p4cyUv5364rTcJY
         6EBAVmvirMZuI6P8LWhmjY9o0ZjX27CYnNOetj+qRE4NoYPTrLBTWhsfBwUoU9X/GB
         kywlgKyHHQD829SGpt4exE28uA9VOsMzAM47hnxX2o244tNDrOT4+8BdqBTYk8qiAO
         eY4jJ0bxpduwNZ5qu4nqjRVd3xSM0XD0qWvlZUD/ZztYn+VCRUv/ZeEn5Nn3mB0sIE
         GkNiyui6EiUJSH2BBKurGqMILz67KkUrtCRf8ViKxLdepZam9vMwJ9/v56wPB18W1R
         CotAg5Y9VFSew==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:46:03 +0100
Subject: [PATCH v2 12/15] selftests/hid: tablets: add a secondary barrel
 switch test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-12-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=4659;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pOwfO/gTl6S07OObuc/xFJuitivPZGd6txL7TG2VpdI=;
 b=wrlXNzdiguWIptxukcqXa2fnRQeQcKRGiUx1HKABt9ZlVc6LtKjYqva/lT659XLdF+qqJIoyC
 qt9oypaa+67CswJPbaVhNdtT8xQEXXCis25SzooEX+8ArkOWfOd40L4
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

Some tablets report 2 barrel switches. We better test those too.

Use the same transistions description from the primary button tests.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 20a7a7fdcd9d..a82db66264c5 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -366,6 +366,56 @@ class PenState(Enum):
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
@@ -444,6 +494,7 @@ class Pen(object):
         self.width = 10
         self.height = 10
         self.barrelswitch = False
+        self.secondarybarrelswitch = False
         self.invert = False
         self.eraser = False
         self.xtilt = 1
@@ -736,6 +787,22 @@ class BaseTest:
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

