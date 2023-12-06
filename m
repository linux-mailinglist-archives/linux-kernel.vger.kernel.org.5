Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A8806C99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377733AbjLFKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377780AbjLFKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F029819A1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9DEC433CA;
        Wed,  6 Dec 2023 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859587;
        bh=jsiRVfncrHRM2AIU4O5SIGJ79Nqy1LXdw+HeTp82cow=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KcdOPfNz2E9P+1tCzgv1MupU3xhkHRHkjxCjUHqQp3x+oPHbAcR5JHN5QuPQyxOs/
         iztMQ/iWSRlE2rxCw2RhZXtttPD/hIyPt++UXgjAdhFXHj9WbYbMWtj2JBCiKFXcFV
         7bo6Wgg1lXFo7qFnxqIiphao1fM9mPgV/Aht2OqUwVgycgHM8BffXouVau044f35Y2
         06VHyoOVOaXZRw52whX7G2JkVS0Jlem2dncGXgl4jveOMjtohShGEWpFC0J3g/8M+f
         y8t/+auU8dXPBujTtg0YE+WYRpRQSLX8wsZAm6+Oxv+KcfyFX4JoTvRrz8+vex7b0C
         3W/WQ8/3PT61w==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:46:01 +0100
Subject: [PATCH v2 10/15] selftests/hid: tablets: add variants of states
 with buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-10-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=11431;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=jsiRVfncrHRM2AIU4O5SIGJ79Nqy1LXdw+HeTp82cow=;
 b=b5sOJeEJEIOzOXgSLYmSD7p4xWbbPLnbaCGyOnBHR7VvRA2Oda0GlNrccaRRbqUN9Q0FYgAZj
 u85u3sAuJWMCuKjAo1sJFQb9wO5WpL/u/HvMvn09neZO8L7s428bJJE
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

Turns out that there are transitions that are unlikely to happen:
for example, having both the tip switch and a button being changed
at the same time (in the same report) would require either a very talented
and precise user or a very bad hardware with a very low sampling rate.

So instead of manually building the button test by hand and forgetting
about some cases, let's reuse the state machine and transitions we have.

This patch only adds the states and the valid transitions. The actual
tests will be replaced later.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- adapt to use dedicated Enum BtnPressed
---
 tools/testing/selftests/hid/tests/test_tablet.py | 173 +++++++++++++++++++++--
 1 file changed, 160 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index cec65294c9ec..a77534f23c75 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -30,25 +30,72 @@ class ToolType(Enum):
     RUBBER = libevdev.EV_KEY.BTN_TOOL_RUBBER
 
 
+class BtnPressed(Enum):
+    """Represents whether a button is pressed on the stylus"""
+
+    PRIMARY_PRESSED = libevdev.EV_KEY.BTN_STYLUS
+    SECONDARY_PRESSED = libevdev.EV_KEY.BTN_STYLUS2
+
+
 class PenState(Enum):
     """Pen states according to Microsoft reference:
     https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
-    """
 
-    PEN_IS_OUT_OF_RANGE = BtnTouch.UP, None
-    PEN_IS_IN_RANGE = BtnTouch.UP, ToolType.PEN
-    PEN_IS_IN_CONTACT = BtnTouch.DOWN, ToolType.PEN
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = BtnTouch.UP, ToolType.RUBBER
-    PEN_IS_ERASING = BtnTouch.DOWN, ToolType.RUBBER
+    We extend it with the various buttons when we need to check them.
+    """
 
-    def __init__(self, touch: BtnTouch, tool: Optional[ToolType]):
+    PEN_IS_OUT_OF_RANGE = BtnTouch.UP, None, None
+    PEN_IS_IN_RANGE = BtnTouch.UP, ToolType.PEN, None
+    PEN_IS_IN_RANGE_WITH_BUTTON = BtnTouch.UP, ToolType.PEN, BtnPressed.PRIMARY_PRESSED
+    PEN_IS_IN_RANGE_WITH_SECOND_BUTTON = (
+        BtnTouch.UP,
+        ToolType.PEN,
+        BtnPressed.SECONDARY_PRESSED,
+    )
+    PEN_IS_IN_CONTACT = BtnTouch.DOWN, ToolType.PEN, None
+    PEN_IS_IN_CONTACT_WITH_BUTTON = (
+        BtnTouch.DOWN,
+        ToolType.PEN,
+        BtnPressed.PRIMARY_PRESSED,
+    )
+    PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON = (
+        BtnTouch.DOWN,
+        ToolType.PEN,
+        BtnPressed.SECONDARY_PRESSED,
+    )
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = BtnTouch.UP, ToolType.RUBBER, None
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON = (
+        BtnTouch.UP,
+        ToolType.RUBBER,
+        BtnPressed.PRIMARY_PRESSED,
+    )
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_SECOND_BUTTON = (
+        BtnTouch.UP,
+        ToolType.RUBBER,
+        BtnPressed.SECONDARY_PRESSED,
+    )
+    PEN_IS_ERASING = BtnTouch.DOWN, ToolType.RUBBER, None
+    PEN_IS_ERASING_WITH_BUTTON = (
+        BtnTouch.DOWN,
+        ToolType.RUBBER,
+        BtnPressed.PRIMARY_PRESSED,
+    )
+    PEN_IS_ERASING_WITH_SECOND_BUTTON = (
+        BtnTouch.DOWN,
+        ToolType.RUBBER,
+        BtnPressed.SECONDARY_PRESSED,
+    )
+
+    def __init__(self, touch: BtnTouch, tool: Optional[ToolType], button: Optional[BtnPressed]):
         self.touch = touch
         self.tool = tool
+        self.button = button
 
     @classmethod
     def from_evdev(cls, evdev) -> "PenState":
         touch = BtnTouch(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
         tool = None
+        button = None
         if (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
@@ -65,7 +112,17 @@ class PenState(Enum):
         ):
             raise ValueError("2 tools are not allowed")
 
-        return cls((touch, tool))
+        # we take only the highest button in account
+        for b in [libevdev.EV_KEY.BTN_STYLUS, libevdev.EV_KEY.BTN_STYLUS2]:
+            if bool(evdev.value[b]):
+                button = b
+
+        # the kernel tends to insert an EV_SYN once removing the tool, so
+        # the button will be released after
+        if tool is None:
+            button = None
+
+        return cls((touch, tool, button))
 
     def apply(self, events) -> "PenState":
         if libevdev.EV_SYN.SYN_REPORT in events:
@@ -74,6 +131,8 @@ class PenState(Enum):
         touch_found = False
         tool = self.tool
         tool_found = False
+        button = self.button
+        button_found = False
 
         for ev in events:
             if ev == libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH):
@@ -88,12 +147,22 @@ class PenState(Enum):
                 if tool_found:
                     raise ValueError(f"duplicated BTN_TOOL_* in {events}")
                 tool_found = True
-                if ev.value:
-                    tool = ToolType(ev.code)
-                else:
-                    tool = None
+                tool = ToolType(ev.code) if ev.value else None
+            elif ev in (
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS),
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS2),
+            ):
+                if button_found:
+                    raise ValueError(f"duplicated BTN_STYLUS* in {events}")
+                button_found = True
+                button = ev.code if ev.value else None
 
-        new_state = PenState((touch, tool))
+        # the kernel tends to insert an EV_SYN once removing the tool, so
+        # the button will be released after
+        if tool is None:
+            button = None
+
+        new_state = PenState((touch, tool, button))
         assert (
             new_state in self.valid_transitions()
         ), f"moving from {self} to {new_state} is forbidden"
@@ -109,14 +178,20 @@ class PenState(Enum):
             return (
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
                 PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_ERASING,
             )
 
         if self == PenState.PEN_IS_IN_RANGE:
             return (
                 PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_CONTACT,
             )
@@ -124,6 +199,8 @@ class PenState(Enum):
         if self == PenState.PEN_IS_IN_CONTACT:
             return (
                 PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_OUT_OF_RANGE,
             )
@@ -142,6 +219,38 @@ class PenState(Enum):
                 PenState.PEN_IS_OUT_OF_RANGE,
             )
 
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
+                PenState.PEN_IS_OUT_OF_RANGE,
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
+                PenState.PEN_IS_OUT_OF_RANGE,
+            )
+
         return tuple()
 
     @staticmethod
@@ -376,26 +485,64 @@ class PenDigitizer(base.UHIDTestDevice):
             pen.xtilt = 0
             pen.ytilt = 0
             pen.twist = 0
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
         elif state == PenState.PEN_IS_IN_RANGE:
             pen.tipswitch = False
             pen.inrange = True
             pen.invert = False
             pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
         elif state == PenState.PEN_IS_IN_CONTACT:
             pen.tipswitch = True
             pen.inrange = True
             pen.invert = False
             pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = True
+            pen.secondarybarrelswitch = False
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = True
+            pen.secondarybarrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = True
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = True
         elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
             pen.tipswitch = False
             pen.inrange = True
             pen.invert = True
             pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
         elif state == PenState.PEN_IS_ERASING:
             pen.tipswitch = False
             pen.inrange = True
             pen.invert = False
             pen.eraser = True
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
 
         pen.current_state = state
 

-- 
2.41.0

