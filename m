Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACEF806C98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377597AbjLFKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377591AbjLFKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A5D49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9261C433C9;
        Wed,  6 Dec 2023 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859585;
        bh=JOoHr4zAh5sfVvjyOaC6fr3FGC2Kr/B8zXOBA3bqE5E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ql38TF2+Bk/+3SWO2B0vtrJl1LH67UPi+W3aBdUcu36509XjXAinFya3ZY8LZihoR
         cr4zTTXdHt9PngxxE00RtOtIAPfRiGndKrnrWmqNAEItx/2D9HNlQt4zv1p5KsbjcU
         1XB1WMl7mblniHfhMzY1Y16WtltTXn9O4f6GOAo88aihjH1iryMsqnEhk8IgVk44gb
         Y0FEbi2hcsO90ZtVqTt0h2rEgPbpV7RjVUi8yfRG9w4GQGL993iJFJVbs8vsTI+nVs
         ZDvmvFHfHwI7D8GTwEB/Zd7KYobhNIIhSYy+m5Os1vX5H9AeycYj9BvW4hddtEKQsz
         foXaMJu4VJ72w==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:46:00 +0100
Subject: [PATCH v2 09/15] selftests/hid: tablets: define the elements of
 PenState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-9-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=3714;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JOoHr4zAh5sfVvjyOaC6fr3FGC2Kr/B8zXOBA3bqE5E=;
 b=D07701ttFW/wdwLhzQVrnkMz0OMzwa3lqAwd05byE2uHsSte7/gzL5eDxfGQVPMQfVCJiSRWR
 3QBcnmPPYS+CdmB7l0MRXLqTMf6abw8BmkTcDtvJyqJD6/PglTR2mpR
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

This introduces a little bit more readability by not using the raw values
but a dedicated Enum

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 36 ++++++++++++++++--------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 0ddf82695ed9..cec65294c9ec 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -13,40 +13,52 @@ from hidtools.util import BusType
 import libevdev
 import logging
 import pytest
-from typing import Dict, Tuple
+from typing import Dict, Optional, Tuple
 
 logger = logging.getLogger("hidtools.test.tablet")
 
 
+class BtnTouch(Enum):
+    """Represents whether the BTN_TOUCH event is set to True or False"""
+
+    DOWN = True
+    UP = False
+
+
+class ToolType(Enum):
+    PEN = libevdev.EV_KEY.BTN_TOOL_PEN
+    RUBBER = libevdev.EV_KEY.BTN_TOOL_RUBBER
+
+
 class PenState(Enum):
     """Pen states according to Microsoft reference:
     https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
     """
 
-    PEN_IS_OUT_OF_RANGE = (False, None)
-    PEN_IS_IN_RANGE = (False, libevdev.EV_KEY.BTN_TOOL_PEN)
-    PEN_IS_IN_CONTACT = (True, libevdev.EV_KEY.BTN_TOOL_PEN)
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = (False, libevdev.EV_KEY.BTN_TOOL_RUBBER)
-    PEN_IS_ERASING = (True, libevdev.EV_KEY.BTN_TOOL_RUBBER)
+    PEN_IS_OUT_OF_RANGE = BtnTouch.UP, None
+    PEN_IS_IN_RANGE = BtnTouch.UP, ToolType.PEN
+    PEN_IS_IN_CONTACT = BtnTouch.DOWN, ToolType.PEN
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = BtnTouch.UP, ToolType.RUBBER
+    PEN_IS_ERASING = BtnTouch.DOWN, ToolType.RUBBER
 
-    def __init__(self, touch, tool):
+    def __init__(self, touch: BtnTouch, tool: Optional[ToolType]):
         self.touch = touch
         self.tool = tool
 
     @classmethod
     def from_evdev(cls, evdev) -> "PenState":
-        touch = bool(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
+        touch = BtnTouch(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
         tool = None
         if (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
         ):
-            tool = libevdev.EV_KEY.BTN_TOOL_RUBBER
+            tool = ToolType(libevdev.EV_KEY.BTN_TOOL_RUBBER)
         elif (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
         ):
-            tool = libevdev.EV_KEY.BTN_TOOL_PEN
+            tool = ToolType(libevdev.EV_KEY.BTN_TOOL_PEN)
         elif (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
             or evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
@@ -68,7 +80,7 @@ class PenState(Enum):
                 if touch_found:
                     raise ValueError(f"duplicated BTN_TOUCH in {events}")
                 touch_found = True
-                touch = bool(ev.value)
+                touch = BtnTouch(ev.value)
             elif ev in (
                 libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN),
                 libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_RUBBER),
@@ -77,7 +89,7 @@ class PenState(Enum):
                     raise ValueError(f"duplicated BTN_TOOL_* in {events}")
                 tool_found = True
                 if ev.value:
-                    tool = ev.code
+                    tool = ToolType(ev.code)
                 else:
                     tool = None
 

-- 
2.41.0

