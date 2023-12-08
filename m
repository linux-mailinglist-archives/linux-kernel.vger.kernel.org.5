Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40780A072
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573537AbjLHKKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573570AbjLHKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:10:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5631727
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:10:07 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso23673137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030206; x=1702635006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4MXXH5cbPxzFQMx+eKCBMLxcs0KvqjK2kPkW0nLFkA=;
        b=N3QOUT7B/2U9w0TIVO9Yaxwm3671HaMgZ5oIpgtryVcoN3WkcNoYKTtnOI/8Yxc/qS
         U47kE6h/WP1McWitCqImdtG/mllGttk+w1GHfaqTqVTI/VC8E7GNlYbhFkGSYX0/lwDR
         3GA8FyMeONKItTIF73tIWVsYTL2bNQYW4bf5NNbvypkq5vjMbT9N1OYZWQzRi2EJTUGl
         RDW3qwuYb/D3PuCaWMpsXbAO78OkAFZVk80ygFkvRLUnRKgoaCJnv6o4e1rRIT8ylUDw
         3A5mR86qCWGY9JMuRW0jWkdnGp+nO0j78t0YjclCV3zIZSilVfCEEaKQoffj4qlmBWC7
         J/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030206; x=1702635006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4MXXH5cbPxzFQMx+eKCBMLxcs0KvqjK2kPkW0nLFkA=;
        b=oAgmFVhiahg3exvp62EtGlHBHFFL2beLVJdXlcUEG/DZbx6Io6UP9F0+FREscFwL0V
         ObnDJd27HxIzs0qYRgW6lbJa69YZg9+ENC/HybiO2BY28UUzVSTLZMomZ7EhXWA74eAY
         x08t2xkO3QRXjPBVmtevNWyVLVh8SV2mZcLxUqMpMyX6h216rYLpBJd7udcNt2EhtGde
         P5wKSGWGG/WZ9teqf63jw2sINwf2707uAe9CQEEQUdoH7Ew1zGX38AZw1Z7gi7t3OOWp
         m1tqraf4Rig2k7F9g0ETdVxg3+pFafyIPXohUXCaWm0KPmO6s1v8bS67ivRCJtlna1mO
         ZCsQ==
X-Gm-Message-State: AOJu0YwuC+9f8gey9uc3NrWheMtSmqvhUp57C6MzXyzqWxBGGx8trX0n
        Fg/OHVA2tFQN34zfe6havz7T9g6gVj0D8A==
X-Google-Smtp-Source: AGHT+IGRCKchlwDieJP65LzkIospb19LMxwfhEMGz5PddR5fY3t/b8MjzABJjvWV9MENqxn3YYZ6m3IfVjrfog==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:be18:0:b0:5d4:27ab:83c with SMTP id
 i24-20020a81be18000000b005d427ab083cmr58978ywn.1.1702030206337; Fri, 08 Dec
 2023 02:10:06 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:09:32 +0800
In-Reply-To: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
Mime-Version: 1.0
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231208-kunit_bus-v2-4-e95905d9b325@google.com>
Subject: [PATCH v2 4/4] ASoC: topology: Replace fake root_device with
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

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 sound/soc/soc-topology-test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index 2cd3540cec04..70cbccc42a42 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -9,6 +9,7 @@
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
+#include <kunit/device.h>
 #include <kunit/test.h>
 
 /* ===== HELPER FUNCTIONS =================================================== */
@@ -21,26 +22,19 @@
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
 }
 
 /*

-- 
2.43.0.472.g3155946c3a-goog

