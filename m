Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B1806C94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377737AbjLFKqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377735AbjLFKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED81710
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6464C433D9;
        Wed,  6 Dec 2023 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859577;
        bh=G76isOTHhVXpWD11gFuYYieLqy+Qq1w644GLBDYxL0E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Z4nPFDnNWYMrIsi4btVQ5tiwX1Oh9Rrol3runID6mfWpoNLyeJd6Ct9R2E4mJ7tYB
         dSOcVPNfz45m19lwjXQV/V4rlMFOgxu6J4SJSRe1ztOXziB7PtpnXAv31AjV0rDYaf
         +mGtYtaP4q4InMbDnDwbmF5PX2jb8jmQNEDQ61neOXn2IZntnG0DZbOml1KnmY7nZG
         jSf9dv/K3cqZ5oLFCetDk15VvgAdtiL5YnNurs+x22UebGUfzBN7xs2JCs5y4NlGMa
         rW2d17tE6KFWKtrOfjMom3aIw/lrJY/hC09yUtvEc+rnNqrcNXyOt80Gq/7Q8BLxM1
         FE7DjEh3H1k2A==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:56 +0100
Subject: [PATCH v2 05/15] selftests/hid: tablets: move the transitions to
 PenState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-5-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=11789;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=G76isOTHhVXpWD11gFuYYieLqy+Qq1w644GLBDYxL0E=;
 b=aiQ16EfLF7GZKGT93LsDlJ4o49rt0tpbJeeFCXC0cl+eHUA5sjFblKjGMoiKFS9RqXRPKJDlo
 vmPHsp2dicpDEgepVVv5v8vSScy77DcCB9JVHQKEOzmNGPP/e6r+3X+
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

Those transitions have nothing to do with `Pen`, so migrate them to
`PenState`.

The hidden agenda is to remove `Pen` and integrate it into `PenDigitizer`
so that we can tweak the events in each state to emulate firmware bugs.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 215 ++++++++++++-----------
 1 file changed, 109 insertions(+), 106 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index cd9c1269afa6..ddf28c245046 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -132,104 +132,8 @@ class PenState(Enum):
 
         return tuple()
 
-
-class Pen(object):
-    def __init__(self, x, y):
-        self.x = x
-        self.y = y
-        self.tipswitch = False
-        self.tippressure = 15
-        self.azimuth = 0
-        self.inrange = False
-        self.width = 10
-        self.height = 10
-        self.barrelswitch = False
-        self.invert = False
-        self.eraser = False
-        self.x_tilt = 0
-        self.y_tilt = 0
-        self.twist = 0
-        self._old_values = None
-        self.current_state = None
-
-    def _restore(self):
-        if self._old_values is not None:
-            for i in [
-                "x",
-                "y",
-                "tippressure",
-                "azimuth",
-                "width",
-                "height",
-                "twist",
-                "x_tilt",
-                "y_tilt",
-            ]:
-                setattr(self, i, getattr(self._old_values, i))
-
-    def move_to(self, state):
-        # fill in the previous values
-        if self.current_state == PenState.PEN_IS_OUT_OF_RANGE:
-            self._restore()
-
-        print(f"\n  *** pen is moving to {state} ***")
-
-        if state == PenState.PEN_IS_OUT_OF_RANGE:
-            self._old_values = copy.copy(self)
-            self.x = 0
-            self.y = 0
-            self.tipswitch = False
-            self.tippressure = 0
-            self.azimuth = 0
-            self.inrange = False
-            self.width = 0
-            self.height = 0
-            self.invert = False
-            self.eraser = False
-            self.x_tilt = 0
-            self.y_tilt = 0
-            self.twist = 0
-        elif state == PenState.PEN_IS_IN_RANGE:
-            self.tipswitch = False
-            self.inrange = True
-            self.invert = False
-            self.eraser = False
-        elif state == PenState.PEN_IS_IN_CONTACT:
-            self.tipswitch = True
-            self.inrange = True
-            self.invert = False
-            self.eraser = False
-        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
-            self.tipswitch = False
-            self.inrange = True
-            self.invert = True
-            self.eraser = False
-        elif state == PenState.PEN_IS_ERASING:
-            self.tipswitch = False
-            self.inrange = True
-            self.invert = True
-            self.eraser = True
-
-        self.current_state = state
-
-    def __assert_axis(self, evdev, axis, value):
-        if (
-            axis == libevdev.EV_KEY.BTN_TOOL_RUBBER
-            and evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER] is None
-        ):
-            return
-
-        assert (
-            evdev.value[axis] == value
-        ), f"assert evdev.value[{axis}] ({evdev.value[axis]}) != {value}"
-
-    def assert_expected_input_events(self, evdev):
-        assert evdev.value[libevdev.EV_ABS.ABS_X] == self.x
-        assert evdev.value[libevdev.EV_ABS.ABS_Y] == self.y
-        assert self.current_state == PenState.from_evdev(evdev)
-
     @staticmethod
-    def legal_transitions() -> Dict[str, Tuple[PenState, ...]]:
+    def legal_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """This is the first half of the Windows Pen Implementation state machine:
         we don't have Invert nor Erase bits, so just move in/out-of-range or proximity.
         https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
@@ -255,7 +159,7 @@ class Pen(object):
         }
 
     @staticmethod
-    def legal_transitions_with_invert() -> Dict[str, Tuple[PenState, ...]]:
+    def legal_transitions_with_invert() -> Dict[str, Tuple["PenState", ...]]:
         """This is the second half of the Windows Pen Implementation state machine:
         we now have Invert and Erase bits, so move in/out or proximity with the intend
         to erase.
@@ -293,7 +197,7 @@ class Pen(object):
         }
 
     @staticmethod
-    def tolerated_transitions() -> Dict[str, Tuple[PenState, ...]]:
+    def tolerated_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """This is not adhering to the Windows Pen Implementation state machine
         but we should expect the kernel to behave properly, mostly for historical
         reasons."""
@@ -306,7 +210,7 @@ class Pen(object):
         }
 
     @staticmethod
-    def tolerated_transitions_with_invert() -> Dict[str, Tuple[PenState, ...]]:
+    def tolerated_transitions_with_invert() -> Dict[str, Tuple["PenState", ...]]:
         """This is the second half of the Windows Pen Implementation state machine:
         we now have Invert and Erase bits, so move in/out or proximity with the intend
         to erase.
@@ -321,7 +225,7 @@ class Pen(object):
         }
 
     @staticmethod
-    def broken_transitions() -> Dict[str, Tuple[PenState, ...]]:
+    def broken_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """Those tests are definitely not part of the Windows specification.
         However, a half broken device might export those transitions.
         For example, a pen that has the eraser button might wobble between
@@ -359,6 +263,102 @@ class Pen(object):
         }
 
 
+class Pen(object):
+    def __init__(self, x, y):
+        self.x = x
+        self.y = y
+        self.tipswitch = False
+        self.tippressure = 15
+        self.azimuth = 0
+        self.inrange = False
+        self.width = 10
+        self.height = 10
+        self.barrelswitch = False
+        self.invert = False
+        self.eraser = False
+        self.x_tilt = 0
+        self.y_tilt = 0
+        self.twist = 0
+        self._old_values = None
+        self.current_state = None
+
+    def _restore(self):
+        if self._old_values is not None:
+            for i in [
+                "x",
+                "y",
+                "tippressure",
+                "azimuth",
+                "width",
+                "height",
+                "twist",
+                "x_tilt",
+                "y_tilt",
+            ]:
+                setattr(self, i, getattr(self._old_values, i))
+
+    def move_to(self, state):
+        # fill in the previous values
+        if self.current_state == PenState.PEN_IS_OUT_OF_RANGE:
+            self._restore()
+
+        print(f"\n  *** pen is moving to {state} ***")
+
+        if state == PenState.PEN_IS_OUT_OF_RANGE:
+            self._old_values = copy.copy(self)
+            self.x = 0
+            self.y = 0
+            self.tipswitch = False
+            self.tippressure = 0
+            self.azimuth = 0
+            self.inrange = False
+            self.width = 0
+            self.height = 0
+            self.invert = False
+            self.eraser = False
+            self.x_tilt = 0
+            self.y_tilt = 0
+            self.twist = 0
+        elif state == PenState.PEN_IS_IN_RANGE:
+            self.tipswitch = False
+            self.inrange = True
+            self.invert = False
+            self.eraser = False
+        elif state == PenState.PEN_IS_IN_CONTACT:
+            self.tipswitch = True
+            self.inrange = True
+            self.invert = False
+            self.eraser = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            self.tipswitch = False
+            self.inrange = True
+            self.invert = True
+            self.eraser = False
+        elif state == PenState.PEN_IS_ERASING:
+            self.tipswitch = False
+            self.inrange = True
+            self.invert = True
+            self.eraser = True
+
+        self.current_state = state
+
+    def __assert_axis(self, evdev, axis, value):
+        if (
+            axis == libevdev.EV_KEY.BTN_TOOL_RUBBER
+            and evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER] is None
+        ):
+            return
+
+        assert (
+            evdev.value[axis] == value
+        ), f"assert evdev.value[{axis}] ({evdev.value[axis]}) != {value}"
+
+    def assert_expected_input_events(self, evdev):
+        assert evdev.value[libevdev.EV_ABS.ABS_X] == self.x
+        assert evdev.value[libevdev.EV_ABS.ABS_Y] == self.y
+        assert self.current_state == PenState.from_evdev(evdev)
+
+
 class PenDigitizer(base.UHIDTestDevice):
     def __init__(
         self,
@@ -486,7 +486,7 @@ class BaseTest:
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
         @pytest.mark.parametrize(
             "state_list",
-            [pytest.param(v, id=k) for k, v in Pen.legal_transitions().items()],
+            [pytest.param(v, id=k) for k, v in PenState.legal_transitions().items()],
         )
         def test_valid_pen_states(self, state_list, scribble):
             """This is the first half of the Windows Pen Implementation state machine:
@@ -498,7 +498,10 @@ class BaseTest:
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
         @pytest.mark.parametrize(
             "state_list",
-            [pytest.param(v, id=k) for k, v in Pen.tolerated_transitions().items()],
+            [
+                pytest.param(v, id=k)
+                for k, v in PenState.tolerated_transitions().items()
+            ],
         )
         def test_tolerated_pen_states(self, state_list, scribble):
             """This is not adhering to the Windows Pen Implementation state machine
@@ -515,7 +518,7 @@ class BaseTest:
             "state_list",
             [
                 pytest.param(v, id=k)
-                for k, v in Pen.legal_transitions_with_invert().items()
+                for k, v in PenState.legal_transitions_with_invert().items()
             ],
         )
         def test_valid_invert_pen_states(self, state_list, scribble):
@@ -535,7 +538,7 @@ class BaseTest:
             "state_list",
             [
                 pytest.param(v, id=k)
-                for k, v in Pen.tolerated_transitions_with_invert().items()
+                for k, v in PenState.tolerated_transitions_with_invert().items()
             ],
         )
         def test_tolerated_invert_pen_states(self, state_list, scribble):
@@ -553,7 +556,7 @@ class BaseTest:
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
         @pytest.mark.parametrize(
             "state_list",
-            [pytest.param(v, id=k) for k, v in Pen.broken_transitions().items()],
+            [pytest.param(v, id=k) for k, v in PenState.broken_transitions().items()],
         )
         def test_tolerated_broken_pen_states(self, state_list, scribble):
             """Those tests are definitely not part of the Windows specification.

-- 
2.41.0

