Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B917670BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjG1Pht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjG1Phq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:37:46 -0400
Received: from 8.mo562.mail-out.ovh.net (8.mo562.mail-out.ovh.net [46.105.60.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943F10FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:37:44 -0700 (PDT)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id A72BF22DA6;
        Fri, 28 Jul 2023 15:37:42 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <conor+dt@kernel.org>; Fri, 28 Jul 2023 15:37:42 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.20.117])
        by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 72BB2101836;
        Fri, 28 Jul 2023 15:37:42 +0000 (UTC)
Received: from traphandler.com (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:37:41 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [RESEND] [PATCH v11 0/4] Add a multicolor LED driver for groups of monochromatic LEDs
Date:   Fri, 28 Jul 2023 17:37:27 +0200
Message-ID: <20230728153731.3742339-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS4.emp2.local (172.16.1.4) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 16196633111400692187
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrieeigdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeeuhfeklefghfelhfethfegkedtvedvgfekledtheegueejuedtheekuefhffdtnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopeguihhrvggtthhorhefrdguvghrphdrmhgrihhlqdhouhhtrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeivd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this series as the v11 didn't apply cleanly.
The patch adding devm_krealloc_array() has been dropped because this function is now available.

Below is the original cover-letter.



Some HW design implement multicolor LEDs with several monochromatic LEDs.
Grouping the monochromatic LEDs allows to configure them in sync and use
the triggers.
The PWM multicolor LED driver implements such grouping but only for
PWM-based LEDs. As this feature is also desirable for the other types of
LEDs, this series implements it for any kind of LED device.

changes v10->v11:
  - updated commit logs of patch 2 and 3
  - Improved comments

changes v9->v10:
  - updated comments and kconfig description
  - renamed all 'led_mcg_xxx' into 'leds_gmc_xxx'

changes v8->v9:
  - rebased on top of lee-leds/for-leds-next
  - updated kernel version and date for /sys/class/leds/<led>/color in
    Documentation/ABI/testing/sysfs-class-led
  - dropped patch "leds: class: simplify the implementation of
    devm_of_led_get()" because __devm_led_get() is now used by
    devm_led_get()

changes v7->v8:
 - consistently use "LEDs group multicolor" throughout the code.
 - rename some variables with more explicit names.
 - improve comments.
 - use the 100-characters per line limit.

changes v6->v7:
 - in led_mcg_probe() increment the counter at the end of the loop for
   clarity.

changes v5->v6:
 - restore sysfs access to the leds when the device is removed

changes v4->v5:
 - Use "depends on COMPILE_TEST || OF" in Kconfig to indicate that OF
   is a functional requirement, not just a requirement for the
   compilation.
 - in led_mcg_probe() check if devm_of_led_get_optional() returns an
   error before testing for the end of the list.
 - use sysfs_emit() instead of sprintf() in color_show().
 - some grammar fixes in the comments and the commit logs.

changes v2->v3, only minor changes:
 - rephrased the Kconfig descritpion
 - make the sysfs interface of underlying LEDs read-only only if the probe
   is successful.
 - sanitize the header files
 - removed the useless call to dev_set_drvdata()
 - use dev_fwnode() to get the fwnode to the device.

changes v1->v2:
 - Followed Rob Herrings's suggestion to make the dt binding much simpler.
 - Added a patch to store the color property of a LED in its class
   structure (struct led_classdev).
Jean-Jacques Hiblot (4):
  leds: provide devm_of_led_get_optional()
  leds: class: store the color index in struct led_classdev
  dt-bindings: leds: Add binding for a multicolor group of LEDs
  leds: Add a multicolor LED driver to group monochromatic LEDs

 Documentation/ABI/testing/sysfs-class-led     |   9 +
 .../bindings/leds/leds-group-multicolor.yaml  |  64 +++++++
 drivers/leds/led-class.c                      |  46 +++++
 drivers/leds/rgb/Kconfig                      |  12 ++
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-group-multicolor.c      | 169 ++++++++++++++++++
 include/linux/leds.h                          |   3 +
 7 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

-- 
2.34.1

