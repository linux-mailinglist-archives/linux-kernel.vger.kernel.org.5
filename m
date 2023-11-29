Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EC7FDB52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjK2PZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjK2PZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92AE10E2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEFCC433C7;
        Wed, 29 Nov 2023 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271513;
        bh=cc0b1jiuNKRXpLCKlecakBm8q8bu4sRt8EzldFhVXEg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=r8czLiG4SA/CrUJNFmFmVRqOyTquHJcSu4YN0Pglq3iArYsmbJL9uPF5mLJQxGkT6
         V2ZDAZtjZbdUDb3nImKNxYc3yNN00wL87AWjRQ7Dp7ZDlxHrrwihQEPfuAYbL71qUh
         JPlXg3UMrdRUP/+bm7Yrcziqa/fnkdd9FXFLrjZ1/vf8w8q+NpRAK22KSyiX7uuqSf
         qIVDpYZd0ZyYoW8E+D+0d7YxnGdA9pG13y3m5Z0i02x4eSjM4LSQW+BzeEVUXoMSgY
         AcHhroL+tU1nPo9OVNwkuUh6ItLeuKTNXf9m+5RVgZOSnKm8L7UmJ8/esfn93JjdXH
         Qd4BUXYDPEz4w==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:31 +0100
Subject: [PATCH 06/12] selftests/hid: tablets: move move_to function to
 PenDigitizer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-6-ba15a1fe1b0d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=5281;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cc0b1jiuNKRXpLCKlecakBm8q8bu4sRt8EzldFhVXEg=;
 b=s/G95xyyW0nb0zcopdvpLLf34B8+2cViUddub6Sm8ZpAJ8SZV9dQGN4Q8b8B6X1vmzjqn9E/u
 C3hARQugD3BBBvLb5+wTmL8/YyUyj4nUUQYyAAPdyH1FjyBEBuAish5
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

We can easily subclass PenDigitizer for introducing firmware bugs when
subclassing Pen is harder.

Move move_to from Pen to PenDigitizer so we get that ability

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 97 ++++++++++++------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 18961758e4aa..44a004ca69d1 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -282,7 +282,7 @@ class Pen(object):
         self._old_values = None
         self.current_state = None
 
-    def _restore(self):
+    def restore(self):
         if self._old_values is not None:
             for i in [
                 "x",
@@ -297,50 +297,8 @@ class Pen(object):
             ]:
                 setattr(self, i, getattr(self._old_values, i))
 
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
+    def backup(self):
+        self._old_values = copy.copy(self)
 
     def __assert_axis(self, evdev, axis, value):
         if (
@@ -384,6 +342,51 @@ class PenDigitizer(base.UHIDTestDevice):
                     continue
                 self.fields = [f.usage_name for f in r]
 
+    def move_to(self, pen, state):
+        # fill in the previous values
+        if pen.current_state == PenState.PEN_IS_OUT_OF_RANGE:
+            pen.restore()
+
+        print(f"\n  *** pen is moving to {state} ***")
+
+        if state == PenState.PEN_IS_OUT_OF_RANGE:
+            pen.backup()
+            pen.x = 0
+            pen.y = 0
+            pen.tipswitch = False
+            pen.tippressure = 0
+            pen.azimuth = 0
+            pen.inrange = False
+            pen.width = 0
+            pen.height = 0
+            pen.invert = False
+            pen.eraser = False
+            pen.x_tilt = 0
+            pen.y_tilt = 0
+            pen.twist = 0
+        elif state == PenState.PEN_IS_IN_RANGE:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+        elif state == PenState.PEN_IS_IN_CONTACT:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = False
+        elif state == PenState.PEN_IS_ERASING:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = True
+
+        pen.current_state = state
+
     def event(self, pen):
         rs = []
         r = self.create_report(application=self.cur_application, data=pen)
@@ -462,7 +465,7 @@ class BaseTest:
             cur_state = PenState.PEN_IS_OUT_OF_RANGE
 
             p = Pen(50, 60)
-            p.move_to(PenState.PEN_IS_OUT_OF_RANGE)
+            uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE)
             events = self.post(uhdev, p)
             self.validate_transitions(cur_state, p, evdev, events)
 
@@ -475,7 +478,7 @@ class BaseTest:
                     events = self.post(uhdev, p)
                     self.validate_transitions(cur_state, p, evdev, events)
                     assert len(events) >= 3  # X, Y, SYN
-                p.move_to(state)
+                uhdev.move_to(p, state)
                 if scribble and state != PenState.PEN_IS_OUT_OF_RANGE:
                     p.x += 1
                     p.y -= 1

-- 
2.41.0

