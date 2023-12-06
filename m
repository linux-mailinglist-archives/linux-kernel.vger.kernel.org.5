Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5D806C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377581AbjLFKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377604AbjLFKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5AB1BCC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A3DC433CB;
        Wed,  6 Dec 2023 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859593;
        bh=mIw1oFGJiDhomCZVsjF/1LmtAiicrkQ73NQnVRDv6Hg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uJEqENcphgvmkJFGrIkGwmTj5raO3dGA3v6OG6BeCSBwqC/IW/Qdv+H7Clm/CL4aq
         RxRLZCC+ViV9DzqrL9X48AHLRageDMy+3Hzh2LZCzJXNPkNERwf6rburqErN+xNHB1
         3tqxM4XWSm7Tobe2yrGKXPQhp4ssMY+zvf2J40fC8JVzRY1O5HRCnc8vkqPxdTdYgP
         Y/eiggUCAknhhEmdlC3Xqu/Y+Rhnhqdq7/25ZsVbYWoS4l7NicAPyZrpXL3arvguAy
         LN4UR97KLEnQg8OchwRINPV/iW2fbhonY41RHi97gNTpUEXkle+9OWu2fNfpNB8OLE
         ZD2ocVRomTfmA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:46:04 +0100
Subject: [PATCH v2 13/15] selftests/hid: tablets: be stricter for some
 transitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-13-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=12102;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mIw1oFGJiDhomCZVsjF/1LmtAiicrkQ73NQnVRDv6Hg=;
 b=MDpa/990k4zQzTul1ZaNwt/vN/CTf1UY3xsIlEQxve6V9v8Bg5Lw2VhnGcYL7Uq9t0UHxdU2w
 V94XV3wycq/A4HGImXCK7FayglmCahkkJWYgRpP9GeP4LvW32dbMwmL
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

To accommodate for legacy devices, we rely on the last state of a
transition to be valid:
for example when we test PEN_IS_OUT_OF_RANGE to PEN_IS_IN_CONTACT,
any "normal" device that reports an InRange bit would insert a
PEN_IS_IN_RANGE state between the 2.

This is of course valid, but this solution prevents to detect false
releases emitted by some firmware:
when pressing an "eraser mode" button, they might send an extra
PEN_IS_OUT_OF_RANGE that we may want to filter.

So define 2 sets of transitions: one that is the ideal behavior, and
one that is OK, it won't break user space, but we have serious doubts
if we are doing the right thing. And depending on the test, either
ask only for valid transitions, or tolerate weird ones.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- fixed type annotations for apply()
- s/historical/historically
- explicitly call self._test_states with
  allow_intermediate_states=(True|False)
---
 tools/testing/selftests/hid/tests/test_tablet.py | 132 +++++++++++++++++++----
 1 file changed, 113 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index a82db66264c5..9374bd7524ef 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -13,7 +13,7 @@ from hidtools.util import BusType
 import libevdev
 import logging
 import pytest
-from typing import Dict, Optional, Tuple
+from typing import Dict, List, Optional, Tuple
 
 logger = logging.getLogger("hidtools.test.tablet")
 
@@ -124,7 +124,7 @@ class PenState(Enum):
 
         return cls((touch, tool, button))
 
-    def apply(self, events) -> "PenState":
+    def apply(self, events: List[libevdev.InputEvent], strict: bool) -> "PenState":
         if libevdev.EV_SYN.SYN_REPORT in events:
             raise ValueError("EV_SYN is in the event sequence")
         touch = self.touch
@@ -163,13 +163,97 @@ class PenState(Enum):
             button = None
 
         new_state = PenState((touch, tool, button))
-        assert (
-            new_state in self.valid_transitions()
-        ), f"moving from {self} to {new_state} is forbidden"
+        if strict:
+            assert (
+                new_state in self.valid_transitions()
+            ), f"moving from {self} to {new_state} is forbidden"
+        else:
+            assert (
+                new_state in self.historically_tolerated_transitions()
+            ), f"moving from {self} to {new_state} is forbidden"
 
         return new_state
 
     def valid_transitions(self) -> Tuple["PenState", ...]:
+        """Following the state machine in the URL above.
+
+        Note that those transitions are from the evdev point of view, not HID"""
+        if self == PenState.PEN_IS_OUT_OF_RANGE:
+            return (
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_ERASING,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE:
+            return (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+            )
+
+        if self == PenState.PEN_IS_IN_CONTACT:
+            return (
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            return (
+                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_ERASING,
+            )
+
+        if self == PenState.PEN_IS_ERASING:
+            return (
+                PenState.PEN_IS_ERASING,
+                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            return (
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+            )
+
+        if self == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            return (
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
+            return (
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+            )
+
+        if self == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
+            return (
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+            )
+
+        return tuple()
+
+    def historically_tolerated_transitions(self) -> Tuple["PenState", ...]:
         """Following the state machine in the URL above, with a couple of addition
         for skipping the in-range state, due to historical reasons.
 
@@ -693,10 +777,14 @@ class BaseTest:
             self.debug_reports(r, uhdev, events)
             return events
 
-        def validate_transitions(self, from_state, pen, evdev, events):
+        def validate_transitions(
+            self, from_state, pen, evdev, events, allow_intermediate_states
+        ):
             # check that the final state is correct
             pen.assert_expected_input_events(evdev)
 
+            state = from_state
+
             # check that the transitions are valid
             sync_events = []
             while libevdev.InputEvent(libevdev.EV_SYN.SYN_REPORT) in events:
@@ -706,12 +794,12 @@ class BaseTest:
                 events = events[idx + 1 :]
 
                 # now check for a valid transition
-                from_state = from_state.apply(sync_events)
+                state = state.apply(sync_events, not allow_intermediate_states)
 
             if events:
-                from_state = from_state.apply(sync_events)
+                state = state.apply(sync_events, not allow_intermediate_states)
 
-        def _test_states(self, state_list, scribble):
+        def _test_states(self, state_list, scribble, allow_intermediate_states):
             """Internal method to test against a list of
             transition between states.
             state_list is a list of PenState objects
@@ -726,7 +814,9 @@ class BaseTest:
             p = Pen(50, 60)
             uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE)
             events = self.post(uhdev, p)
-            self.validate_transitions(cur_state, p, evdev, events)
+            self.validate_transitions(
+                cur_state, p, evdev, events, allow_intermediate_states
+            )
 
             cur_state = p.current_state
 
@@ -735,14 +825,18 @@ class BaseTest:
                     p.x += 1
                     p.y -= 1
                     events = self.post(uhdev, p)
-                    self.validate_transitions(cur_state, p, evdev, events)
+                    self.validate_transitions(
+                        cur_state, p, evdev, events, allow_intermediate_states
+                    )
                     assert len(events) >= 3  # X, Y, SYN
                 uhdev.move_to(p, state)
                 if scribble and state != PenState.PEN_IS_OUT_OF_RANGE:
                     p.x += 1
                     p.y -= 1
                 events = self.post(uhdev, p)
-                self.validate_transitions(cur_state, p, evdev, events)
+                self.validate_transitions(
+                    cur_state, p, evdev, events, allow_intermediate_states
+                )
                 cur_state = p.current_state
 
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
@@ -755,7 +849,7 @@ class BaseTest:
             we don't have Invert nor Erase bits, so just move in/out-of-range or proximity.
             https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
             """
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=False)
 
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
         @pytest.mark.parametrize(
@@ -769,7 +863,7 @@ class BaseTest:
             """This is not adhering to the Windows Pen Implementation state machine
             but we should expect the kernel to behave properly, mostly for historical
             reasons."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=True)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Barrel Switch" not in uhdev.fields,
@@ -785,7 +879,7 @@ class BaseTest:
         )
         def test_valid_primary_button_pen_states(self, state_list, scribble):
             """Rework the transition state machine by adding the primary button."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=False)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Secondary Barrel Switch" not in uhdev.fields,
@@ -801,7 +895,7 @@ class BaseTest:
         )
         def test_valid_secondary_button_pen_states(self, state_list, scribble):
             """Rework the transition state machine by adding the secondary button."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=False)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -821,7 +915,7 @@ class BaseTest:
             to erase.
             https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
             """
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=False)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -841,7 +935,7 @@ class BaseTest:
             to erase.
             https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
             """
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=True)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -858,7 +952,7 @@ class BaseTest:
             For example, a pen that has the eraser button might wobble between
             touching and erasing if the tablet doesn't enforce the Windows
             state machine."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, allow_intermediate_states=True)
 
 
 class GXTP_pen(PenDigitizer):

-- 
2.41.0

