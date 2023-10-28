Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714727DA666
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjJ1KZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjJ1KZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060010A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698488689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/MCG0fKq7dkA5vfmyvu/Vw865nGk2FxWSZE8uUZKj/c=;
        b=WPh3KBX/6SpxAVBfSugaFe+JKAZr3rgO4g6LtL/aX971ik7RlVL955sC2lyIyUeHK5Jg1T
        rQxhKwDsqYF1QlH+T0CTA0fWr1tPqOj2VPHOr7x7KqN3e3rElDsHw8MlzMEcqbKtX8c2zS
        uvGGa8pcy7ydMz3DKEbEkj5xRZ0pzog=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-mc9gE-OdNSCZwKZujsOKlw-1; Sat, 28 Oct 2023 06:24:47 -0400
X-MC-Unique: mc9gE-OdNSCZwKZujsOKlw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso22153635e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698488686; x=1699093486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MCG0fKq7dkA5vfmyvu/Vw865nGk2FxWSZE8uUZKj/c=;
        b=cZr3kKdMQFag1Ju/f6vYGxxh8xZq8BaZor873Y80hmkM7cTVnF7+b9f+wuSxMQJ7o2
         BY0XsEBmtCbBMRVN+rKJfSaSfqlywJd22mb7ZQxAPXvKvxk7VJY98pXEg5vj1MjhZHQL
         l3mFJINtAqGkjAQJy7aP+JLSaa3QFA6KgYJMjBAxyyIz/wBFKmNBpbTuNKa3m2auy2cs
         +4ljzeJ2/KaMfqph/+dtU8OnLVEvIyYjOPo/VNim9NhjjYst2aa/jrsVDGM5Lthl9gpT
         5WGdWo0d7hWOJ23dcYBIeUpOQLl/TMHS5aOUjQX6knFVv7iOXJofgh7tzA9MHaZ9kZeH
         Cv0g==
X-Gm-Message-State: AOJu0YwG3ZtjrgATcoWJ1q9KOdpJGg6ZOOoIG9ebVweMTYAOrHmQDCDf
        yVeiHhSgHKJvk7SO4rwN7dK09KUY78jpzGR3AFhI0IYyas7af68mBOictXh6ord0gfaTzPM7EFU
        JD6SK3C5cuxmLqByg1f88vo2Jy/xWKMQ1cGIewQOff9LA1B4UgmrnvmmjyNpCZUwzIG4Kfx3ftU
        57ZPqw4b0=
X-Received: by 2002:a05:6000:156f:b0:32f:62d5:79fd with SMTP id 15-20020a056000156f00b0032f62d579fdmr5354111wrz.23.1698488686515;
        Sat, 28 Oct 2023 03:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxEi/dA8WtnLFBPkzL53od+apnFqRBy6Qk5B3lHlCfa6pklRkOawp3tUVmzPuyiyXpqZ299Q==
X-Received: by 2002:a05:6000:156f:b0:32f:62d5:79fd with SMTP id 15-20020a056000156f00b0032f62d579fdmr5354082wrz.23.1698488686028;
        Sat, 28 Oct 2023 03:24:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b00326f0ca3566sm3552032wro.50.2023.10.28.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 03:24:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH] regulator: core: Add option to prevent disabling unused regulators
Date:   Sat, 28 Oct 2023 12:24:03 +0200
Message-ID: <20231028102423.179400-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This may be useful for debugging and develompent purposes, when there are
drivers that depend on regulators to be enabled but do not request them.

It is inspired from the clk_ignore_unused and pd_ignore_unused parameters,
that are used to keep firmware-enabled clocks and power domains on even if
these are not used by drivers.

The parameter is not expected to be used in normal cases and should not be
needed on a platform with proper driver support.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 drivers/regulator/core.c                        | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..91b58d767c2c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5461,6 +5461,13 @@
 			print every Nth verbose statement, where N is the value
 			specified.
 
+	regulator_ignore_unused
+			[REGULATOR]
+			Prevents the regulator framework to disable regulators
+			that are unused due not driver claiming them. This may
+			be useful for debug and development, but should not be
+			needed on a platform with proper driver support.
+
 	relax_domain_level=
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3137e40fcd3e..220034ff0273 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6234,6 +6234,14 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 	return 0;
 }
 
+static bool regulator_ignore_unused;
+static int __init regulator_ignore_unused_setup(char *__unused)
+{
+	regulator_ignore_unused = true;
+	return 1;
+}
+__setup("regulator_ignore_unused", regulator_ignore_unused_setup);
+
 static void regulator_init_complete_work_function(struct work_struct *work)
 {
 	/*
@@ -6246,6 +6254,15 @@ static void regulator_init_complete_work_function(struct work_struct *work)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_register_resolve_supply);
 
+	/*
+	 * For debugging purposes, it may be useful to prevent unused
+	 * regulators to be disabled.
+	 */
+	if (regulator_ignore_unused) {
+		pr_warn("regulator: Not disabling unused regulators\n");
+		return;
+	}
+
 	/* If we have a full configuration then disable any regulators
 	 * we have permission to change the status for and which are
 	 * not in use or always_on.  This is effectively the default
-- 
2.41.0

