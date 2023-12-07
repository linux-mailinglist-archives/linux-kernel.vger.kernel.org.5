Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5D88088B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379517AbjLGNAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjLGM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:59:58 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9810D5;
        Thu,  7 Dec 2023 05:00:02 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B193A120004;
        Thu,  7 Dec 2023 15:59:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B193A120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701953999;
        bh=4eh1bkZ2epzcouaRBV0c2tUqzILYZ5ZFUIXkSuweLvc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=uWG7Nt0tau8TDjwxjgzQ5QnX4stB3NMsMtnR4ZJly7sVtoRnZNv5DwLmE3LxlfEo1
         y0pPnMMhtc0SYk+UGE0+kLjBfLz5Wp0AqqTsv3KT/oIwYs50LhdVTWxqL2LKMWW+lQ
         WaluwxmxjMZgTiQCpBE4/JyoKHjb/D+3MnQbSoFjBLYtVsDeHNSX1AfMthyZ5Ac3zt
         eqVx5Ukbs/sk0AHiGoDGjhKiRjAl4QfaWLG9pG/p1Axq6PuwEe1Hhho+fBpEZZJi2/
         njOZZbigMfrGzvGlab2ZvqKb6aqa3lLIPHm+huaTBDUkPOd3SEmWDDUNcrq5YhH+d+
         3URb+2vu4r10w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu,  7 Dec 2023 15:59:59 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 15:59:59 +0300
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kernel@salutedevices.com>,
        Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Date:   Thu, 7 Dec 2023 15:59:37 +0300
Message-ID: <20231207125938.175119-2-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181937 [Dec 07 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/07 02:56:00 #22627289
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This led-controller supports 3 pattern controllers for auto breathing or
group dimming control. Each pattern controller can work in auto
breathing or manual control mode. All breathing parameters including
rising/falling slope, on/off time, repeat times, min/max brightness
and so on are configurable.

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
 Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
 drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
 3 files changed, 1031 insertions(+)
 create mode 100644 Documentation/leds/leds-aw200xx.rst

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx b/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
index 6d4449cf9d71..1d3d74fa6f08 100644
--- a/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
@@ -3,3 +3,111 @@ Date:		May 2023
 Description:	64-level DIM current. If you write a negative value or
 		"auto", the dim will be calculated according to the
 		brightness.
+
+What:		/sys/class/leds/<led>/device/<pattern>/clear_leds
+What:		/sys/class/leds/<led>/device/<pattern>/select_leds
+Date:		December 2023
+Description:	Bitmask for clear/select leds to pattern.
+
+What:		/sys/class/leds/<led>/device/<pattern>/fall_time
+What:		/sys/class/leds/<led>/device/<pattern>/off_time
+What:		/sys/class/leds/<led>/device/<pattern>/on_time
+What:		/sys/class/leds/<led>/device/<pattern>/rise_time
+Date:		December 2023
+Description:
+		Set the pattern fall, off, on and rise times (0..15), where:
+
+		==  =======  ===  ======
+		0   0 ms     8    2.1 s
+		1   130 ms   9    2.6 s
+		2   260 ms   10   3.1 s
+		3   380 ms   11   4.2 s
+		4   510 ms   12   5.2 s
+		5   770 ms   13   6.2 s
+		6   1.04 s   14   7.3 s
+		7   1.6 s    15   8.3 s
+		==  =======  ===  ======
+
+What:		/sys/class/leds/<led>/device/<pattern>/loop_begin
+Date:		December 2023
+Description:
+		Choose where to start the loop (0..3), where:
+
+		==  ==================
+		0   from 'rise' state
+		1   from 'on' state
+		2   from 'fall' state
+		3   from 'off' state
+		==  ==================
+
+What:		/sys/class/leds/<led>/device/<pattern>/loop_end_on
+Date:		December 2023
+Description:
+		Choose where to end the loop (0..1), where:
+
+		==  ========================
+		0   loop end at 'off' state
+		1   loop end at 'on' state
+		==  ========================
+
+What:		/sys/class/leds/<led>/device/<pattern>/max_breathing_level
+Date:		December 2023
+Description:	Maximum breathing Level.
+
+What:		/sys/class/leds/<led>/device/<pattern>/min_breathing_level
+Date:		December 2023
+Description:	Minimum breathing Level
+
+What:		/sys/class/leds/<led>/device/<pattern>/mode
+Date:		December 2023
+Description:	Pattern mode: manual or auto breathing (0, 1) where:
+
+		==  ====================
+		0   manual mode
+		1   auto breathing mode
+		==  ====================
+
+What:		/sys/class/leds/<led>/device/<pattern>/ramp
+Date:		December 2023
+Description:
+		The smooth ramp down/up function (0, 1), where (see ):
+
+		==  ==================
+		0   ramp mode disable
+		1   ramp mode enable
+		==  ==================
+
+		For more information, see Documentation/leds/leds-aw200xx.rst
+
+What:		/sys/class/leds/<led>/device/<pattern>/repeat
+Date:		December 2023
+Description:	Loop times (0..4095). 0 - the loop is end-less.
+
+What:		/sys/class/leds/<led>/device/<pattern>/running
+Date:		December 2023
+Description:	Reading this file will return the pattern state.
+		This file is read only and supports poll() to detect when the
+		pattern ended.
+		1 means pattern is running and number 0 are finish or not run.
+
+What:		/sys/class/leds/<led>/device/<pattern>/start
+Date:		December 2023
+Description:
+		Start/stop pattern (0, 1), where:
+
+		==  ==============
+		0   stop pattern
+		1   start pattern
+		==  ==============
+
+What:		/sys/class/leds/<led>/device/<pattern>/toggle
+Date:		December 2023
+Description:
+		Manual on/off control (0, 1), where:
+
+		==  =========
+		0   LEDs off
+		1   LEDs on
+		==  =========
+
+		For more information, see Documentation/leds/leds-aw200xx.rst
diff --git a/Documentation/leds/leds-aw200xx.rst b/Documentation/leds/leds-aw200xx.rst
new file mode 100644
index 000000000000..52e777b04885
--- /dev/null
+++ b/Documentation/leds/leds-aw200xx.rst
@@ -0,0 +1,274 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================
+Kernel driver for AW20036/AW20054/AW20072/AW20108
+=================================================
+
+Description
+-----------
+
+The AW20036/AW20054/AW20072/AW20108 is a 3x12/6x9/6x12/9x12 matrix LED driver
+programmed via an I2C interface. The brightness of each LED is independently
+controlled by FADE and DIM parameter.
+
+Three integrated pattern controllers provide auto breathing or group dimming
+control. Each pattern controller can work in auto breathing or manual control
+mode. All breathing parameters including rising/falling slope, on/off time,
+repeat times, min/max brightness and so on are configurable.
+
+Device attribute
+-----------------------------------
+
+**/sys/class/leds/<led>/dim** - 64-level DIM current. If write negative value
+or "auto", the dim will be calculated according to the brightness.
+
+The configuration files for each pattern are located::
+
+    /sys/bus/i2c/devices/xxxx/pattern0/
+    /sys/bus/i2c/devices/xxxx/pattern1/
+    /sys/bus/i2c/devices/xxxx/pattern2/
+
+Directory layout example for pattern
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    $ ls -l /sys/bus/i2c/devices/xxxx/pattern0/
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 clear_leds
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 fall_time
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_begin
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_end_on
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 max_breathing_level
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 min_breathing_level
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 mode
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 off_time
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 on_time
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 ramp
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 repeat
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 rise_time
+    -r--r--r--    1 root     root          4096 Jan  1 00:00 running
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 select_leds
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 start
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 toggle
+
+Timing parameters
+~~~~~~~~~~~~~~~~~
+
+- **on_time**
+
+- **rise_time**
+
+- **fall_time**
+
+- **off_time**
+
+See :ref:`auto_breath_mode`.
+
+Select from predefined times:
+
+.. flat-table::
+
+    * - Value
+      - Time (in seconds)
+      - Value
+      - Time (in seconds)
+
+    * - 0
+      - 0.00
+      - 8
+      - 2.1
+
+    * - 1
+      - 0.13
+      - 9
+      - 2.6
+
+    * - 2
+      - 0.26
+      - 10
+      - 3.1
+
+    * - 3
+      - 0.38
+      - 11
+      - 4.2
+
+    * - 4
+      - 0.51
+      - 12
+      - 5.2
+
+    * - 5
+      - 0.77
+      - 13
+      - 6.2
+
+    * - 6
+      - 1.04
+      - 14
+      - 7.3
+
+    * - 7
+      - 1.6
+      - 15
+      - 8.3
+
+Example set for rise-time=0.13s, on-time=0.26s,
+fall_time=6.2s, off_time=0.51s:
+
+.. code-block:: bash
+
+    echo 1 > rise_time
+    echo 2 > on_time
+    echo 13 > fall_time
+    echo 4 > off_time
+
+Maximum and minimum breathing Level
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- **max_breathing_level**
+
+- **min_breathing_level**
+
+Loop
+~~~~~
+
+- **loop_begin** - choose where to start the loop:
+
+    .. flat-table::
+
+        * - Value
+          - Description
+
+        * - 0
+          - Begin from 'rise' state
+
+        * - 1
+          - Begin from 'on' state
+
+        * - 2
+          - Begin from 'fall' state
+
+        * - 3
+          - Begin from 'off' state
+
+- **loop_end_on** - write ``1`` loop end at 'on' state.
+
+- **repeat** - loop times. When write ``0``, the loop is end-less.
+
+Others
+~~~~~~
+
+- **clear_leds** - bitmask for clear leds to pattern.
+        For example clear leds 1, 2, 3, 4, 5, 7 (``10111110``):
+
+        .. code-block:: bash
+
+            echo be > clear_leds
+
+- **select_leds** - bitmask for set leds to pattern.
+        For example select leds 0, 3, 6, 7 (``11001001``):
+
+        .. code-block:: bash
+
+            echo c9 > select_leds
+
+- **mode** - pattern mode:
+    ``0`` - manual control, ``1`` - auto breathing
+
+- **start** - start/stop pattern:
+    ``0`` - to stop, ``1`` - to start
+
+- **toggle** - manual on/off control (see :ref:`manual_breath_mode`):
+    ``0`` - LEDs off, ``1`` - LEDs on
+
+- **ramp** - the smooth ramp up/down function (see :ref:`manual_breath_mode`):
+    ``0`` - disable, ``1`` - enable
+
+- **running** - Reading this file will return the pattern state:
+    ``1`` - is running, ``0`` - is finished (or not running)
+
+This file supports poll() to detect when the pattern finished.
+
+.. _auto_breath_mode:
+
+Auto breathing mode
+~~~~~~~~~~~~~~~~~~~
+
+::
+
+    breathing level
+          ^
+      max _             ________________
+          |            /.              .\
+          |           / .              . \
+          |          /  .              .  \
+          |         /   .              .   \
+          |        /    .              .    \
+          |       /     .              .     \
+      min _   ___/      .              .      \_______
+          |      .      .              .      .
+          |      .      .              .      .
+          |      . rise .      on      . fall .  off
+          |
+         -|------------------------------------------------> time
+
+Example:
+
+.. code-block:: bash
+
+    echo 10 > rise_time # 3.1 seconds
+    echo 4 > on_time # 0.51 seconds
+    echo 1 > off_time # 0.13 seconds
+    echo 10 > fall_time # 3.1 seconds
+    echo 0 > min_breathing_level
+    echo 255 > max_breathing_level
+    echo 0 > loop_begin # begin from 'rise'
+    echo 0 > loop_end_on # loop end at 'off' state
+    echo 1 > mode # auto breathing mode
+    echo 5 > repeat # 5 times repeat
+    echo 1249 > select_leds # select 0, 3, 6, 9 12 leds (1001001001001)
+    echo 1 > start # run
+
+
+.. _manual_breath_mode:
+
+Manual control mode
+~~~~~~~~~~~~~~~~~~~
+
+When 'ramp' enabled (echo 1 > ramp)::
+
+    breathing level
+          ^
+      max _                ____________________
+          |               /                   .\
+          |              /                    . \
+          |             /                     .  \
+          |            /                      .   \
+          |           /                       .    \
+          |          /                        .     \
+      min _   ______/                         .      \_______
+          |         .                         .
+          |         .                         .
+          |         .                         .
+          |  (echo 1 > toggle)        (echo 0 > toggle)
+         -|---------------------------------------------------> time
+
+
+When 'ramp' disabled (echo 0 > ramp)::
+
+    breathing level
+          ^
+      max _          __________________________
+          |         |                          |
+          |         |                          |
+          |         |                          |
+          |         |                          |
+          |         |                          |
+          |         |                          |
+      min _   ______|                          |_______
+          |         .                          .
+          |         .                          .
+          |         .                          .
+          |   echo 1 > toggle          echo 0 > toggle
+         -|---------------------------------------------------> time
diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 1d3943f86f7f..8350a1a85bab 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -20,6 +20,8 @@
 #include <linux/time.h>
 #include <linux/units.h>
 
+#define AW200XX_LEDS_MAX                 108
+#define AW200XX_PATTERN_MAX              3
 #define AW200XX_DIM_MAX                  (BIT(6) - 1)
 #define AW200XX_FADE_MAX                 (BIT(8) - 1)
 #define AW200XX_IMAX_DEFAULT_uA          60000
@@ -68,6 +70,88 @@
 #define AW200XX_REG_FCD       AW200XX_REG(AW200XX_PAGE0, 0x04)
 #define AW200XX_FCD_CLEAR     0x01
 
+/* Interrupt status register */
+#define AW200XX_REG_ISRFLT          AW200XX_REG(AW200XX_PAGE0, 0x0B)
+#define AW200XX_ISRFLT_PATIS_MASK   GENMASK(6, 4)
+
+/* Pattern enable control register */
+#define AW200XX_REG_PATCR           AW200XX_REG(AW200XX_PAGE0, 0x43)
+#define AW200XX_PATCR_PAT_IE_MASK   GENMASK(6, 4)
+#define AW200XX_PATCR_PAT_IE_ALL    AW200XX_PATCR_PAT_IE_MASK
+#define AW200XX_PATCR_PAT_ENABLE(x) BIT(x)
+
+/*
+ * Maximum breathing level registers
+ * For patterns 0 - 0x44, 1 - 0x45, 2 - 0x46 (step 1)
+ */
+#define AW200XX_REG_PAT0_MAX_BREATH AW200XX_REG(AW200XX_PAGE0, 0x44)
+
+/*
+ * Minimum breathing level registers
+ * For patterns 0 - 0x47, 1 - 0x48, 2 - 0x49 (step 1)
+ */
+#define AW200XX_REG_PAT0_MIN_BREATH AW200XX_REG(AW200XX_PAGE0, 0x47)
+
+/*
+ * Template 1 (rise-time) & template 2 (on-time) configuration register
+ * For patterns 0 - 0x4A, 1 - 0x4E, 2 - 0x52 (step 4)
+ */
+#define AW200XX_REG_PAT0_T0 AW200XX_REG(AW200XX_PAGE0, 0x4A)
+
+/*
+ * Template 3 (fall-time) & template 4 (off-time) configuration register
+ * For patterns 0 - 0x4B, 1 - 0x4F, 2 - 0x53 (step 4)
+ */
+#define AW200XX_REG_PAT0_T1 AW200XX_REG(AW200XX_PAGE0, 0x4B)
+
+/*
+ * Loop configuration registers:
+ *   loop end point setting (LE)
+ *   loop beginning point setting (LB)
+ *   MSB of loop times (LT)
+ * For patterns 0 - 0x4C, 1 - 0x50, 2 - 0x54 (step 4)
+ */
+#define AW200XX_REG_PAT0_T2     AW200XX_REG(AW200XX_PAGE0, 0x4C)
+#define AW200XX_REG_PATX_T2(x) (AW200XX_REG_PAT0_T2 + (x))
+
+/*
+ * Loop configuration registers:
+ *    LSB of loop times (LT)
+ * For patterns 0 - 0x4D, 1 - 0x51, 2 - 0x55 (step 4)
+ */
+#define AW200XX_REG_PAT0_T3    AW200XX_REG(AW200XX_PAGE0, 0x4D)
+#define AW200XX_REG_PATX_T3(x) (AW200XX_REG_PAT0_T3 + (x))
+
+#define AW200XX_PAT_T2_LE_MASK      GENMASK(7, 6)
+#define AW200XX_PAT_T2_LB_MASK      GENMASK(5, 4)
+#define AW200XX_PAT_T2_LT_MASK      GENMASK(3, 0)
+#define AW200XX_PAT_T3_LT_MASK      GENMASK(7, 0)
+#define AW200XX_PAT0_T2_LT_MSB(x)   ((x) >> 8)
+#define AW200XX_PAT0_T3_LT_LSB(x)   ((x) & 0xFF)
+#define AW200XX_PAT0_T_LT(msb, lsb) ((msb) << 8 | (lsb))
+#define AW200XX_PAT0_T_LT_MAX       (BIT(12) - 1)
+
+#define AW200XX_PAT_T_STEP          4
+
+#define AW200XX_PAT_T1_T3_MASK      GENMASK(7, 4)
+#define AW200XX_PAT_T2_T4_MASK      GENMASK(3, 0)
+#define AW200XX_TEMPLATE_TIME_MAX   (BIT(4) - 1)
+
+/*
+ * Pattern mode configuration register
+ * For patterns 0 - 0x56, 1 - 0x57, 2 - 0x58 (step 1)
+ */
+#define AW200XX_REG_PAT0_CFG        AW200XX_REG(AW200XX_PAGE0, 0x56)
+#define AW200XX_PAT_CFG_MODE_MASK   BIT(0)
+#define AW200XX_PAT_CFG_RAMP_MASK   BIT(1)
+#define AW200XX_PAT_CFG_SWITCH_MASK BIT(2)
+
+/* Start pattern register */
+#define AW200XX_REG_PATGO           AW200XX_REG(AW200XX_PAGE0, 0x59)
+#define AW200XX_PATGO(x)            BIT(x)
+#define AW200XX_PATGO_RUN(x, run)   ((run) << (x))
+#define AW200XX_PATGO_STATE(x)      BIT((x) + 4)
+
 /* Display size configuration */
 #define AW200XX_REG_DSIZE          AW200XX_REG(AW200XX_PAGE0, 0x80)
 #define AW200XX_DSIZE_COLUMNS_MAX  12
@@ -79,6 +163,11 @@
 #define AW200XX_REG_DIM_PAGE1(x, columns) \
 	AW200XX_REG(AW200XX_PAGE1, AW200XX_LED2REG(x, columns))
 
+/* Pattern selection register*/
+#define AW200XX_REG_PAT_SELECT(x, columns) \
+	AW200XX_REG(AW200XX_PAGE3, AW200XX_LED2REG(x, columns))
+#define AW200XX_PATX_SELECT(x) ((x) + 1)
+
 /*
  * DIM current configuration register (page 4).
  * The even address for current DIM configuration.
@@ -117,12 +206,500 @@ struct aw200xx {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct mutex mutex;
+	DECLARE_BITMAP(pattern_leds[AW200XX_PATTERN_MAX], AW200XX_LEDS_MAX);
 	u32 num_leds;
 	u32 display_rows;
 	struct gpio_desc *hwen;
 	struct aw200xx_led leds[] __counted_by(num_leds);
 };
 
+struct aw200xx_attribute {
+	struct device_attribute dev_attr;
+	u32 reg;
+	u32 mask;
+	u32 max;
+};
+
+#define to_aw200xx_attr(attr) \
+	container_of(attr, struct aw200xx_attribute, dev_attr)
+
+#define AW200XX_ATTR(_n, _m, _sh, _st, _r, _msk, _max) {		\
+	.dev_attr = __ATTR(_n, _m, _sh, _st),				\
+	.reg = _r,							\
+	.mask = _msk,							\
+	.max = _max,							\
+}
+
+#define AW200XX_DEVICE_ATTR_RW(_v, _n, _sh, _st, _r, _msk, _max)	\
+struct aw200xx_attribute _v##_attr =					\
+	AW200XX_ATTR(_n, 0644, _sh, _st,				\
+		     _r, _msk, _max)
+
+#define AW200XX_DEVICE_ATTR_RO(_v, _n, _sh, _r, _msk, _max)		\
+struct aw200xx_attribute _v##_attr =					\
+	AW200XX_ATTR(_n, 0444, _sh, NULL,				\
+		     _r, _msk, _max)
+
+static ssize_t aw200xx_store_internal(struct device *dev,
+				      struct device_attribute *devattr,
+				      const char *buf, size_t count)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret < 0 || val > attr->max)
+		return -EINVAL;
+
+	val <<= __ffs(attr->mask);
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_update_bits(chip->regmap, attr->reg, attr->mask, val);
+	mutex_unlock(&chip->mutex);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t aw200xx_show_internal(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 val;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_read(chip->regmap, attr->reg, &val);
+	mutex_unlock(&chip->mutex);
+
+	if (ret)
+		return ret;
+
+	val = (val & attr->mask) >> __ffs(attr->mask);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t aw200xx_template_time_show(struct device *dev,
+					  struct device_attribute *devattr,
+					  char *buf)
+{
+	static const u32 ttimes_ms[] = {
+		0, 130, 260, 380, 510, 770, 1040, 1600,
+		2100, 2600, 3100, 4200, 5200, 6200, 7300, 8300,
+	};
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 ttime;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_read(chip->regmap, attr->reg, &ttime);
+	mutex_unlock(&chip->mutex);
+
+	if (ret)
+		return ret;
+
+	ttime = (ttime & attr->mask) >> __ffs(attr->mask);
+	if (ttime >= ARRAY_SIZE(ttimes_ms))
+		return -EIO;
+
+	ttime = ttimes_ms[ttime];
+
+	/* For On & Off time minimum is 40ms */
+	if (ttime == 0 && attr->mask == AW200XX_PAT_T2_T4_MASK)
+		ttime = 40;
+
+	return sysfs_emit(buf, "%ums\n", ttime);
+}
+
+static ssize_t aw200xx_pattern_leds_store(struct device *dev,
+					  struct device_attribute *devattr,
+					  const char *buf, size_t count,
+					  bool clear)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	unsigned long *pattern_leds = chip->pattern_leds[attr->reg];
+	u32 columns = chip->cdef->display_size_columns;
+	DECLARE_BITMAP(leds, AW200XX_LEDS_MAX);
+	u32 val = clear ? 0 : AW200XX_PATX_SELECT(attr->reg);
+	u32 i;
+	ssize_t ret;
+
+	ret = bitmap_parse(buf, count, leds, chip->num_leds);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+
+	for_each_set_bit(i, leds, chip->num_leds) {
+		u32 num = chip->leds[i].num;
+
+		ret = regmap_write(chip->regmap,
+				   AW200XX_REG_PAT_SELECT(num, columns), val);
+		if (ret)
+			goto out_unlock;
+
+		if (clear)
+			__clear_bit(i, pattern_leds);
+		else
+			__set_bit(i, pattern_leds);
+	}
+
+	ret = count;
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_select_leds_show(struct device *dev,
+						struct device_attribute *devattr,
+						char *buf)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = sysfs_emit(buf, "%*pb\n",
+			 chip->num_leds, chip->pattern_leds[attr->reg]);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_select_leds_store(struct device *dev,
+						 struct device_attribute *devattr,
+						 const char *buf, size_t count)
+{
+	return aw200xx_pattern_leds_store(dev, devattr, buf, count, false);
+}
+
+static ssize_t aw200xx_pattern_clear_leds_show(struct device *dev,
+					       struct device_attribute *devattr,
+					       char *buf)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	DECLARE_BITMAP(leds, AW200XX_LEDS_MAX);
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	bitmap_fill(leds, chip->num_leds);
+	bitmap_xor(leds, leds, chip->pattern_leds[attr->reg], chip->num_leds);
+	ret = sysfs_emit(buf, "%*pb\n", chip->num_leds, leds);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_clear_leds_store(struct device *dev,
+						struct device_attribute *devattr,
+						const char *buf, size_t count)
+{
+	return aw200xx_pattern_leds_store(dev, devattr, buf, count, true);
+}
+
+static ssize_t aw200xx_pattern_start_show(struct device *dev,
+					  struct device_attribute *devattr,
+					  char *buf)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 start = 0;
+	u32 val;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_read(chip->regmap, AW200XX_REG_PATCR, &val);
+	if (ret)
+		goto out_unlock;
+
+	if (val & AW200XX_PATCR_PAT_ENABLE(attr->reg)) {
+		ret = regmap_read(chip->regmap, AW200XX_REG_PATGO, &val);
+		if (ret)
+			goto out_unlock;
+
+		start = !!(val & AW200XX_PATGO(attr->reg));
+	}
+
+	ret = sysfs_emit(buf, "%u\n", start);
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_start_store(struct device *dev,
+					   struct device_attribute *devattr,
+					   const char *buf, size_t count)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 start;
+	ssize_t ret;
+
+	ret = kstrtouint(buf, 0, &start);
+	if (ret < 0 || start > attr->max)
+		return -EINVAL;
+
+	start = AW200XX_PATGO_RUN(attr->reg, start);
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_update_bits(chip->regmap, AW200XX_REG_PATCR,
+				 AW200XX_PATCR_PAT_ENABLE(attr->reg), start);
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_update_bits(chip->regmap, AW200XX_REG_PATGO,
+				 AW200XX_PATGO(attr->reg), start);
+	if (ret)
+		goto out_unlock;
+
+	ret = count;
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_running_show(struct device *dev,
+					    struct device_attribute *devattr,
+					    char *buf)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 running;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_read(chip->regmap, AW200XX_REG_PATGO, &running);
+	if (ret)
+		goto out_unlock;
+
+	running &= AW200XX_PATGO_STATE(attr->reg);
+	ret = sysfs_emit(buf, "%u\n", !!running);
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_repeat_show(struct device *dev,
+					   struct device_attribute *devattr,
+					   char *buf)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 repeat_msb;
+	u32 repeat_lsb;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_read(chip->regmap,
+			  AW200XX_REG_PATX_T2(attr->reg), &repeat_msb);
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_read(chip->regmap,
+			  AW200XX_REG_PATX_T3(attr->reg), &repeat_lsb);
+	if (ret)
+		goto out_unlock;
+
+	repeat_msb &= AW200XX_PAT_T2_LT_MASK;
+	repeat_lsb &= AW200XX_PAT_T3_LT_MASK;
+
+	ret = sysfs_emit(buf, "%u\n",
+			 AW200XX_PAT0_T_LT(repeat_msb, repeat_lsb));
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_repeat_store(struct device *dev,
+					    struct device_attribute *devattr,
+					    const char *buf, size_t count)
+{
+	const struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 repeat;
+	ssize_t ret;
+
+	ret = kstrtouint(buf, 0, &repeat);
+	if (ret < 0 || repeat > attr->max)
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_update_bits(chip->regmap,
+				 AW200XX_REG_PATX_T2(attr->reg),
+				 AW200XX_PAT_T2_LT_MASK,
+				 AW200XX_PAT0_T2_LT_MSB(repeat));
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_update_bits(chip->regmap,
+				 AW200XX_REG_PATX_T3(attr->reg),
+				 AW200XX_PAT_T3_LT_MASK,
+				 AW200XX_PAT0_T3_LT_LSB(repeat));
+	if (ret)
+		goto out_unlock;
+
+	ret = count;
+
+out_unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+#define AW200XX_DEVICE_ATTR_PAT_RW(_n, _sh, _st, _r, _step, _msk, _max)	\
+static AW200XX_DEVICE_ATTR_RW(_n##0, _n, _sh, _st,			\
+			      _r, _msk, _max);				\
+static AW200XX_DEVICE_ATTR_RW(_n##1, _n, _sh, _st,			\
+			      _r + (1 * (_step)), _msk, _max);		\
+static AW200XX_DEVICE_ATTR_RW(_n##2, _n, _sh, _st,			\
+			      _r + (2 * (_step)), _msk, _max)
+
+#define AW200XX_DEVICE_ATTR_PAT_RO(_n, _sh, _r, _step, _msk, _max)	\
+static AW200XX_DEVICE_ATTR_RO(_n##0, _n, _sh,				\
+			      _r, _msk, _max);				\
+static AW200XX_DEVICE_ATTR_RO(_n##1, _n, _sh,				\
+			      _r + (1 * (_step)), _msk, _max);		\
+static AW200XX_DEVICE_ATTR_RO(_n##2, _n, _sh,				\
+			      _r + (2 * (_step)), _msk, _max)
+
+#define AW200XX_DEFINE_ATTR_GROUP(_idx, _a0, _a1, _a2, _a3, _a4, _a5,	\
+		_a6, _a7, _a8, _a9, _a10, _a11, _a12, _a13, _a14, _a15)	\
+static struct attribute *aw200xx_pattern##_idx##_attributes[] = {	\
+	&_a0##_idx##_attr.dev_attr.attr,				\
+	&_a1##_idx##_attr.dev_attr.attr,				\
+	&_a2##_idx##_attr.dev_attr.attr,				\
+	&_a3##_idx##_attr.dev_attr.attr,				\
+	&_a4##_idx##_attr.dev_attr.attr,				\
+	&_a5##_idx##_attr.dev_attr.attr,				\
+	&_a6##_idx##_attr.dev_attr.attr,				\
+	&_a7##_idx##_attr.dev_attr.attr,				\
+	&_a8##_idx##_attr.dev_attr.attr,				\
+	&_a9##_idx##_attr.dev_attr.attr,				\
+	&_a10##_idx##_attr.dev_attr.attr,				\
+	&_a11##_idx##_attr.dev_attr.attr,				\
+	&_a12##_idx##_attr.dev_attr.attr,				\
+	&_a13##_idx##_attr.dev_attr.attr,				\
+	&_a14##_idx##_attr.dev_attr.attr,				\
+	&_a15##_idx##_attr.dev_attr.attr,				\
+	NULL};								\
+static const struct attribute_group aw200xx_pattern##_idx##_group = {	\
+	.attrs = aw200xx_pattern##_idx##_attributes,			\
+	.name = "pattern"#_idx,						\
+}
+
+#define AW200XX_DEFINE_ATTR_GROUPS(...)					\
+AW200XX_DEFINE_ATTR_GROUP(0, __VA_ARGS__);				\
+AW200XX_DEFINE_ATTR_GROUP(1, __VA_ARGS__);				\
+AW200XX_DEFINE_ATTR_GROUP(2, __VA_ARGS__);				\
+static const struct attribute_group *aw200xx_pattern_groups[] = {	\
+	&aw200xx_pattern0_group,					\
+	&aw200xx_pattern1_group,					\
+	&aw200xx_pattern2_group,					\
+	NULL}
+
+AW200XX_DEVICE_ATTR_PAT_RW(rise_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T0, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T1_T3_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(on_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T0, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_T4_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(fall_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T1, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T1_T3_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(off_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T1, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_T4_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(mode,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_CFG, 1,
+			   AW200XX_PAT_CFG_MODE_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(ramp,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_CFG, 1,
+			   AW200XX_PAT_CFG_RAMP_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(toggle,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_CFG, 1,
+			   AW200XX_PAT_CFG_SWITCH_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(loop_end_on,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T2, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_LE_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(loop_begin,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T2, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_LB_MASK, 3);
+
+AW200XX_DEVICE_ATTR_PAT_RW(max_breathing_level,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_MAX_BREATH, 1,
+			   0xFF, AW200XX_FADE_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(min_breathing_level,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_MIN_BREATH, 1,
+			   0xFF, AW200XX_FADE_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(start,
+			   aw200xx_pattern_start_show,
+			   aw200xx_pattern_start_store,
+			   0, 1, 1, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RO(running,
+			   aw200xx_pattern_running_show, 0, 1, 0, 0);
+
+AW200XX_DEVICE_ATTR_PAT_RW(repeat,
+			   aw200xx_pattern_repeat_show,
+			   aw200xx_pattern_repeat_store,
+			   0, AW200XX_PAT_T_STEP,
+			   0, AW200XX_PAT0_T_LT_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(select_leds,
+			   aw200xx_pattern_select_leds_show,
+			   aw200xx_pattern_select_leds_store,
+			   0, 1, 0, 0);
+
+AW200XX_DEVICE_ATTR_PAT_RW(clear_leds,
+			   aw200xx_pattern_clear_leds_show,
+			   aw200xx_pattern_clear_leds_store,
+			   0, 1, 0, 0);
+
+AW200XX_DEFINE_ATTR_GROUPS(start, running, mode, ramp, toggle, repeat,
+			   loop_end_on, loop_begin, select_leds, clear_leds,
+			   max_breathing_level, min_breathing_level,
+			   rise_time, on_time, fall_time, off_time);
+
 static ssize_t dim_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
@@ -212,6 +789,62 @@ static int aw200xx_brightness_set(struct led_classdev *cdev,
 	return ret;
 }
 
+static irqreturn_t aw200xx_irq_thread(int irq, void *dev_id)
+{
+	struct aw200xx *chip = dev_id;
+	unsigned long pattern_state;
+	u32 interrupt_state;
+	int i;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_read(chip->regmap, AW200XX_REG_ISRFLT, &interrupt_state);
+	mutex_unlock(&chip->mutex);
+
+	if (ret) {
+		dev_err(&chip->client->dev,
+			"Failed to get interrupt status: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	pattern_state = FIELD_GET(AW200XX_ISRFLT_PATIS_MASK, interrupt_state);
+
+	for_each_set_bit(i, &pattern_state, AW200XX_PATTERN_MAX) {
+		char dir[sizeof("patternx")];
+
+		snprintf(dir, sizeof(dir), "pattern%d", i);
+		sysfs_notify(&chip->client->dev.kobj, dir, "running");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int aw200xx_setup_interrupts(struct aw200xx *chip)
+{
+	struct i2c_client *i2c = chip->client;
+	int ret;
+
+	if (i2c->irq <= 0)
+		return 0;
+
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq,
+					NULL,
+					aw200xx_irq_thread,
+					IRQF_ONESHOT,
+					i2c->name,
+					chip);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to request irq\n");
+
+	ret = regmap_update_bits(chip->regmap, AW200XX_REG_PATCR,
+				 AW200XX_PATCR_PAT_IE_MASK,
+				 AW200XX_PATCR_PAT_IE_ALL);
+	if (ret)
+		dev_err_probe(&i2c->dev, ret, "Failed to enable interrupts\n");
+
+	return ret;
+}
+
 static u32 aw200xx_imax_from_global(const struct aw200xx *const chip,
 				    u32 global_imax_uA)
 {
@@ -511,6 +1144,7 @@ static const struct regmap_access_table aw200xx_readable_table = {
 
 static const struct regmap_range aw200xx_readonly_ranges[] = {
 	regmap_reg_range(AW200XX_REG_IDR, AW200XX_REG_IDR),
+	regmap_reg_range(AW200XX_REG_ISRFLT, AW200XX_REG_ISRFLT),
 };
 
 static const struct regmap_access_table aw200xx_writeable_table = {
@@ -518,6 +1152,15 @@ static const struct regmap_access_table aw200xx_writeable_table = {
 	.n_no_ranges = ARRAY_SIZE(aw200xx_readonly_ranges),
 };
 
+static const struct regmap_range aw200xx_volatile_registers[] = {
+	regmap_reg_range(AW200XX_REG_ISRFLT, AW200XX_REG_ISRFLT),
+};
+
+static const struct regmap_access_table aw200xx_volatile_table = {
+	.yes_ranges = aw200xx_volatile_registers,
+	.n_yes_ranges = ARRAY_SIZE(aw200xx_volatile_registers),
+};
+
 static const struct regmap_config aw200xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -526,6 +1169,7 @@ static const struct regmap_config aw200xx_regmap_config = {
 	.num_ranges = ARRAY_SIZE(aw200xx_ranges),
 	.rd_table = &aw200xx_readable_table,
 	.wr_table = &aw200xx_writeable_table,
+	.volatile_table = &aw200xx_volatile_table,
 	.cache_type = REGCACHE_MAPLE,
 	.disable_locking = true,
 };
@@ -586,6 +1230,10 @@ static int aw200xx_probe(struct i2c_client *client)
 		goto out_unlock;
 
 	ret = aw200xx_chip_init(chip);
+	if (ret)
+		goto out_unlock;
+
+	ret = aw200xx_setup_interrupts(chip);
 
 out_unlock:
 	if (ret)
@@ -650,6 +1298,7 @@ static struct i2c_driver aw200xx_driver = {
 	.driver = {
 		.name = "aw200xx",
 		.of_match_table = aw200xx_match_table,
+		.dev_groups = aw200xx_pattern_groups,
 	},
 	.probe_new = aw200xx_probe,
 	.remove = aw200xx_remove,
-- 
2.40.0

