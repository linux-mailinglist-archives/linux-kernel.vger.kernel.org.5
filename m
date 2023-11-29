Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06537FDC07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbjK2P0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjK2PZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55910C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B3CC433C7;
        Wed, 29 Nov 2023 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271521;
        bh=gEeyh8PcwmBsx5enMTqDdJ7sk3c2gLkm4hxwW8bPHuU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HMD1DkvkjBXpqBr/IJYpJ5HptidFKUaqZ5CyUUjKFSBMGwTnl4702FFCMb7CENBCv
         LJBRiniiODMa9Vpk5fMXl0PO0BgNzL8PZXrofC/7fVBVczJr+lZxZOl3bh8VfmobCo
         A64KgpMqxR6X8CbMrhLJObq+z8d+B2UWhCDeFGrOgJKmC6/DKVpm9mvH/LZvNa74h1
         n5NhaPhVGyaikqR+IegGJ9QhQqKDrC/2f56e7kbAHbSFZ23vEm+DvqgoxsHEZltF/t
         +6uVpJEXGRUjN1QpeY5YvClVQ59v+vO0Q4e0tHmzmlsR4NoP22wYrzhbU2QPYTJZ2N
         1dY81DLGvh3Vg==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:35 +0100
Subject: [PATCH 10/12] selftests/hid: tablets: convert the primary button
 tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-10-ba15a1fe1b0d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=9157;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=gEeyh8PcwmBsx5enMTqDdJ7sk3c2gLkm4hxwW8bPHuU=;
 b=mafe8eed3tP3bUO98NSU3Gy+ANCreRp7ZV5qkx9CIOdaGD87Lzbb4Ic1lIbw4LyfUymNqZVNl
 mvEMPzQaS/+AgKQvpduAKCxwgi4gbhF1Mh6biwGWnZB1Ok8odqiB7kX
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

We get more descriptive in what we are doing, and also get more
information of what is actually being tested. Instead of having a non
exhaustive button changes that are semi-randomly done, we can describe
all the states we want to test.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 165 ++++++++++-------------
 1 file changed, 69 insertions(+), 96 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 80269d1a0f0a..440a87170db1 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -302,6 +302,55 @@ class PenState(Enum):
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
@@ -645,7 +694,10 @@ class BaseTest:
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
         @pytest.mark.parametrize(
             "state_list",
-            [pytest.param(v, id=k) for k, v in PenState.tolerated_transitions().items()],
+            [
+                pytest.param(v, id=k)
+                for k, v in PenState.tolerated_transitions().items()
+            ],
         )
         def test_tolerated_pen_states(self, state_list, scribble):
             """This is not adhering to the Windows Pen Implementation state machine
@@ -653,6 +705,22 @@ class BaseTest:
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
@@ -710,101 +778,6 @@ class BaseTest:
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

