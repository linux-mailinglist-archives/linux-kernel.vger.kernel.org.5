Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D1804B30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjLEHcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjLEHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:32:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1301B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:32:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so4536995276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761529; x=1702366329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHfmQmZDYuyXCu0NGdHRUb/90Lva6Q2oB2rwJOjRS8=;
        b=gU77UWLf17NGFwns1NTtH4ufmlGXSuKUVMe0SMM3Z/hkuzpNhnNVs/ZdiK6v8qArF6
         1iPq9ZvY1n1XV3BuyBhS4bmkK8n6w20y/1zUlCfOFepTmp8dM/vEVUVW3ZPiyfbMRP09
         hCwu1fRloMi511BNUmei169Jh4wxlce0fe+rV9OB4IrxNpS6tsjOgXiLaRfHNMwnwex2
         ejrpMQ53Cn32gWbPxEVS1/Yjq8olZc8mk8my+okMtGnUhPA6d6nmXnJXs+6+EWW05mW0
         ifZyaaeAlZ2xHbNk+ndalBpIbTFFUgDECLafYNtE7lWJ7IA0Dp9H6goWe+DyqAqCVbkp
         Y9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761529; x=1702366329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHfmQmZDYuyXCu0NGdHRUb/90Lva6Q2oB2rwJOjRS8=;
        b=WJHBUv/3aH5vTPC6/v5Ayymx0wnaML/IWQJoelKvMUIMRtKQTlsKoqgHmYs/W9iEdC
         HIJ+UaM7VGiVFfE8xDah//YzzpkjtSMY24aa3dJWtw1jWr43+JCOLMg8CE05QhewwuSV
         qHvr7devcLpJfgk24lIkvukweyceHeSdfWq3HL0A1RUuk81bOaWv3gkIIGxT1XnTVC8e
         //EH4Jx4UtIqcIgdRrhG4wbxLfNR0vjm2EMnrPP95I0poe2wnXMoYBCJKA9dmbgNR66G
         rqbbB0Nc/6tmoGElJDAffBIrMLmwwB0IOidX+0vKhuJIvZKhsjNrVCHeuG52RsXLTV/l
         M61g==
X-Gm-Message-State: AOJu0YxFByyixq0qLQ5x3ciPT0esIwuxfSwxMquWVCz4WKEFNJmmGwMj
        dxCBRp86q7w+/FkH/H1WVyK9c2CJZaIv1g==
X-Google-Smtp-Source: AGHT+IHHF6+HTN+R7wTnVRWLqb4w18tX0Cim+QBivHuTkcMFGQFLnFtpexLAxiytHhXHivrQcbisM6rp+Y02ZQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d6d1:0:b0:db7:dce9:76d3 with SMTP id
 n200-20020a25d6d1000000b00db7dce976d3mr188630ybg.9.1701761529700; Mon, 04 Dec
 2023 23:32:09 -0800 (PST)
Date:   Tue, 05 Dec 2023 15:31:36 +0800
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Mime-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
Subject: [PATCH 4/4] ASoC: topology: Replace fake root_device with
 kunit_device in tests
From:   davidgow@google.com
To:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Signed-off-by: David Gow <davidgow@google.com>
---
 sound/soc/soc-topology-test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index 2cd3540cec04..1d7696e5bffc 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -10,6 +10,7 @@
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
 #include <kunit/test.h>
+#include <kunit/device.h>
 
 /* ===== HELPER FUNCTIONS =================================================== */
 
@@ -21,26 +22,20 @@
  */
 static struct device *test_dev;
 
-static struct device_driver test_drv = {
-	.name = "sound-soc-topology-test-driver",
-};
-
 static int snd_soc_tplg_test_init(struct kunit *test)
 {
-	test_dev = root_device_register("sound-soc-topology-test");
+	test_dev = kunit_device_register(test, "sound-soc-topology-test");
 	test_dev = get_device(test_dev);
 	if (!test_dev)
 		return -ENODEV;
 
-	test_dev->driver = &test_drv;
-
 	return 0;
 }
 
 static void snd_soc_tplg_test_exit(struct kunit *test)
 {
 	put_device(test_dev);
-	root_device_unregister(test_dev);
+	kunit_device_unregister(test, test_dev);
 }
 
 /*

-- 
2.43.0.rc2.451.g8631bc7472-goog

