Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBC806C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377793AbjLFKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377602AbjLFKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1739D19A8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB92EC433CC;
        Wed,  6 Dec 2023 10:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859589;
        bh=OoqmC4Pw/8fhP04WnZybsenjId387ZEbXBhKeYmIoVg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TD66XrJ6uWb0gclXQTkAOg8MGIoSskV1kXdPJ0kKYuAFOklGGJdste5qwydlxPkFu
         kUpxuwOAN0nL9OdyD4Gx5B38Q5G/aIpZoLp7XzuOcQvoQRK6UNuwDh9WxI0BJOVQFV
         MPCU9bt4lSBN9CTbr/87u4Y79BbaOSYMvv+4uYzgMnlVdj3TSm4vM2q0mYRfI/CDWh
         pW/ErROcD66aWFLAxzha2IjcwL34v16/BF/gX3bSw9qB8SRgF8bEZBhyYXXqcXLTQY
         SxkCW1P6EBMuaIg60riyf11S3CaPiZ3/usbaSCgKo0hm8U2t6GPM/XCnY2D5ZKTqSt
         +y0n/PIXMILdA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:46:02 +0100
Subject: [PATCH v2 11/15] selftests/hid: tablets: convert the primary
 button tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-11-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=8645;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=OoqmC4Pw/8fhP04WnZybsenjId387ZEbXBhKeYmIoVg=;
 b=vk/1M8DMdVlisGfM3sduSPeaB4MJTn23FrM+264q/aGiNwvU1IAHPB35PHp3RnjmU3wYLEAY6
 wJ+lb++ahWFBjbgSTF693T8SGzV5U6ygFCtKz+08Id6Y7/iCwO+DI53
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

We get more descriptive in what we are doing, and also get more
information of what is actually being tested. Instead of having a non
exhaustive button changes that are semi-randomly done, we can describe
all the states we want to test.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 160 +++++++++--------------
 1 file changed, 65 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index a77534f23c75..20a7a7fdcd9d 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -317,6 +317,55 @@ class PenState(Enum):
             ),
         }
 
+    @staticmethod
+    def legal_transitions_with_primary_button() -> Dict[str, Tuple["PenState", ...]]:
+        """We revisit the Windows Pen Implementation state machine:
+        we now have a primary button.
+        """
+        return {
+            "hover-button": (PenState.PEN_IS_IN_RANGE_WITH_BUTTON,),
+            "hover-button -> out-of-range": (
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+            ),
+            "in-range -> button-press": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+            ),
+            "in-range -> button-press -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> touch -> button-press -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+            ),
+            "in-range -> touch -> button-press -> release -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> button-press -> touch -> release -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> button-press -> touch -> button-release -> release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+        }
+
     @staticmethod
     def tolerated_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """This is not adhering to the Windows Pen Implementation state machine
@@ -671,6 +720,22 @@ class BaseTest:
             reasons."""
             self._test_states(state_list, scribble)
 
+        @pytest.mark.skip_if_uhdev(
+            lambda uhdev: "Barrel Switch" not in uhdev.fields,
+            "Device not compatible, missing Barrel Switch usage",
+        )
+        @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
+        @pytest.mark.parametrize(
+            "state_list",
+            [
+                pytest.param(v, id=k)
+                for k, v in PenState.legal_transitions_with_primary_button().items()
+            ],
+        )
+        def test_valid_primary_button_pen_states(self, state_list, scribble):
+            """Rework the transition state machine by adding the primary button."""
+            self._test_states(state_list, scribble)
+
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
             "Device not compatible, missing Invert usage",
@@ -728,101 +793,6 @@ class BaseTest:
             state machine."""
             self._test_states(state_list, scribble)
 
-        @pytest.mark.skip_if_uhdev(
-            lambda uhdev: "Barrel Switch" not in uhdev.fields,
-            "Device not compatible, missing Barrel Switch usage",
-        )
-        def test_primary_button(self):
-            """Primary button (stylus) pressed, reports as pressed even while hovering.
-            Actual reporting from the device: hid=TIPSWITCH,BARRELSWITCH,INRANGE (code=TOUCH,STYLUS,PEN):
-              { 0, 0, 1 } <- hover
-              { 0, 1, 1 } <- primary button pressed
-              { 0, 1, 1 } <- liftoff
-              { 0, 0, 0 } <- leaves
-            """
-
-            uhdev = self.uhdev
-            evdev = uhdev.get_evdev()
-
-            p = Pen(50, 60)
-            p.inrange = True
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 1) in events
-            assert evdev.value[libevdev.EV_ABS.ABS_X] == 50
-            assert evdev.value[libevdev.EV_ABS.ABS_Y] == 60
-            assert not evdev.value[libevdev.EV_KEY.BTN_STYLUS]
-
-            p.barrelswitch = True
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS, 1) in events
-
-            p.x += 1
-            p.y -= 1
-            events = self.post(uhdev, p)
-            assert len(events) == 3  # X, Y, SYN
-            assert libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 51) in events
-            assert libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, 59) in events
-
-            p.barrelswitch = False
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS, 0) in events
-
-            p.inrange = False
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 0) in events
-
-        @pytest.mark.skip_if_uhdev(
-            lambda uhdev: "Barrel Switch" not in uhdev.fields,
-            "Device not compatible, missing Barrel Switch usage",
-        )
-        def test_contact_primary_button(self):
-            """Primary button (stylus) pressed, reports as pressed even while hovering.
-            Actual reporting from the device: hid=TIPSWITCH,BARRELSWITCH,INRANGE (code=TOUCH,STYLUS,PEN):
-              { 0, 0, 1 } <- hover
-              { 0, 1, 1 } <- primary button pressed
-              { 1, 1, 1 } <- touch-down
-              { 1, 1, 1 } <- still touch, scribble on the screen
-              { 0, 1, 1 } <- liftoff
-              { 0, 0, 0 } <- leaves
-            """
-
-            uhdev = self.uhdev
-            evdev = uhdev.get_evdev()
-
-            p = Pen(50, 60)
-            p.inrange = True
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 1) in events
-            assert evdev.value[libevdev.EV_ABS.ABS_X] == 50
-            assert evdev.value[libevdev.EV_ABS.ABS_Y] == 60
-            assert not evdev.value[libevdev.EV_KEY.BTN_STYLUS]
-
-            p.barrelswitch = True
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS, 1) in events
-
-            p.tipswitch = True
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1) in events
-            assert evdev.value[libevdev.EV_KEY.BTN_STYLUS]
-
-            p.x += 1
-            p.y -= 1
-            events = self.post(uhdev, p)
-            assert len(events) == 3  # X, Y, SYN
-            assert libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 51) in events
-            assert libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, 59) in events
-
-            p.tipswitch = False
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 0) in events
-
-            p.barrelswitch = False
-            p.inrange = False
-            events = self.post(uhdev, p)
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 0) in events
-            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS, 0) in events
-
 
 class GXTP_pen(PenDigitizer):
     def event(self, pen):

-- 
2.41.0

