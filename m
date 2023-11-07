Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFEB7E4900
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjKGTKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:10:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D20119
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699384173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3J40+zQ/6dP9tvNGgIODUTJ9R+5seR+mVk01q9f45Uc=;
        b=AkWCmIm4FGB+ozV4JCeS9eBvArUd0nSetKfVWjNj1yyTBrL1ibzOiPUXC6OhPuBMMLOGy9
        TNSSuWdot26E0rHwjWxvob113D47e/f4xrCJfFDY1/fnpoUF4JbA8WPirQLfurW5eU2/Z6
        bVfdbw3dwPFNK4iuUVxRwsWVc7F75iQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-kwqMoIXeNfuFAdziF3K6Og-1; Tue, 07 Nov 2023 14:09:32 -0500
X-MC-Unique: kwqMoIXeNfuFAdziF3K6Og-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4094e5664a3so40140235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699384170; x=1699988970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3J40+zQ/6dP9tvNGgIODUTJ9R+5seR+mVk01q9f45Uc=;
        b=aCYhs2RsYynN248dgJjIcK/n23Ta8B8vUpzUwXGJT39c32zPZfxP32AsCTtNgwueNF
         KzxufQWDHs7dLplUHuv/xytDKsdlSVUlOl3NkXmCvE2cBGxOxhz+aENPo5uHclCtrgF8
         SpPgg0NNxRRy+EXbGsUgqbhnyEefA45tEh1WEekZmwx2xFPHgfO48e3pr0QwhxyLrbZw
         8xONYd4KECf+D80vMu7mvqSxtdFmon2qFqfy7ri2tlV7CgglGJCP2YOjLbkN8uZT4+TC
         m+WNnv8Z923JvfZbAFYj1AQ5WIhk7Poa2xoTg8+1y0cojezDXYsKL1bRZoqGnj03GlyW
         6a2Q==
X-Gm-Message-State: AOJu0YyPYrbRlrjX1a/PFcIn9gVqDyEQ1NFS3RqVw6MbJ9dL7BRXAAfd
        5lJw7bwfJRcRKzIx27r0xAUlRu2xDOFAuZibkz6B32h46EXwq+eDcYAB+W2zwKB6Z9BQTlTr/nc
        eJiBtGXS9uhozpkh8bphNfU3EstooQ9RVsgVla5bUdVZuHVtiMEoc4W16tq7N/EmvvDij0iJOLX
        g0YzI/zmY=
X-Received: by 2002:a05:600c:4448:b0:409:79cb:1df6 with SMTP id v8-20020a05600c444800b0040979cb1df6mr3032976wmn.14.1699384169634;
        Tue, 07 Nov 2023 11:09:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9xvdcop2cag0mJbvlGopE/xTO4Pcr5jJIkWEGHZ4CMIoXRHQH7Dm3WT+HPFFscnl+vjA+sg==
X-Received: by 2002:a05:600c:4448:b0:409:79cb:1df6 with SMTP id v8-20020a05600c444800b0040979cb1df6mr3032941wmn.14.1699384169220;
        Tue, 07 Nov 2023 11:09:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c43d400b003fbe4cecc3bsm16089746wmn.16.2023.11.07.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:09:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH v2] regulator: core: Add option to prevent disabling unused regulators
Date:   Tue,  7 Nov 2023 20:09:18 +0100
Message-ID: <20231107190926.1185326-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Brian Masney <bmasney@redhat.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:
- Grammar changes suggested by Randy Dunlap.
- Add collected tags from v1.

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 drivers/regulator/core.c                        | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..d7c83c8ae80d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5461,6 +5461,13 @@
 			print every Nth verbose statement, where N is the value
 			specified.
 
+	regulator_ignore_unused
+			[REGULATOR]
+			Prevents regulator framework from disabling regulators
+			that are unused, due no driver claiming them. This may
+			be useful for debug and development, but should not be
+			needed on a platform with proper driver support.
+
 	relax_domain_level=
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3137e40fcd3e..79777495cc3a 100644
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
+	 * regulators from being disabled.
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

