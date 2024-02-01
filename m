Return-Path: <linux-kernel+bounces-47684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0560845132
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652981F27D93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9584A20;
	Thu,  1 Feb 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LY85O9h"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678182D73
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767583; cv=none; b=KyysFRAgN99IwKAaOIodlByAAtTlmklL/I3Y/gTSnRvbG9IYQKRd90uTcnncnPoZ7gn2rMUb9iZl/X5O6IUyKIeGQ11mS3sX0PDD8GFrNGi/30KL/Hg0gj/MYVrWX7JNifpYOokXK6GMNpxCcgrZw/8ilQ/J7hMB3Igl2fTnTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767583; c=relaxed/simple;
	bh=0LRxdChxLmKEhnOYVLzmM5OXlQ0XC+cmLb43Z7+cynM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dcmSxHO/ffpVcYx2w0P6Q9MsyWQv1zqc98CGQXwYreR+N3+YKMUZIAiUyyCumU35WnyZfQytSeoWYIZ5gfUXzXL0XVwB/rD24kGTJzTNGXmmFuy9SgtUwBkwFhvw8uv6FGgd4DpGorzIZtoLbXtyzbJRgknCcUCIHC2ZeOQJ28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LY85O9h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6cd10fd4aso899352276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706767581; x=1707372381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+R+QwEvKVG52HCupcuvyMyVixKSfMEwsPllchfsZTgU=;
        b=0LY85O9h72c4jUBvNZCjsSNl9tDmeiIwvLt7tNGNn6Z8suRSBZ01xM2oLDvhQrOIxO
         e8/rexbGGV6qLd3Vk+tFrDNDsI4CWhUh5VLUhearaVAHK08bcNrNoyCbt3Ed9T4sNe6/
         fIbaThBUjiCGgL3fAOYQmKe2qJhORoWCKH9Th6ZoYpeHi5BMydYfVwTlFICLeqgRKq11
         bn83jNXwX4FOHfEhRIWKG3IsRIbKDL76AvohXQWVErVhphEYmrKp5yx7K4Gtxf5uYMrS
         CX2GkKCQ6eEKHAYDIH5CTJxblIKi3S7qvFpAIPjTA3552Lhe9aYClLIfISAWQz/0Hu91
         3dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706767581; x=1707372381;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+R+QwEvKVG52HCupcuvyMyVixKSfMEwsPllchfsZTgU=;
        b=Z78uYBCJ/L/jMOqBSMu8D1kfwYcpJrlDCks9YTGFz8I5/IiLfLvfq6cErgOyLFVLBN
         EL9EZ1MN9t8/ZU8FXDo8BtFKxzd5lwxrNXyekrtWPT8VIb257rlWbuCsHDV2AQIp0iB6
         t6k4WnNi5qbrhwVu0eag4yrU1uOM2sQ9kw7OcgEBQja40HdoDF1us0D+gn3P1Pc/a61C
         Y9dqsOtLF90UKupuLYryyIhigqxjEk+8VDH+jVCNjnLYCtUD5fa3ukDEqUT/TSV1oE9H
         cII8TIpzD3Y8PKkktUGt8p4TIrm84kphPu/wdKGnYtA8Taltd0Rhh5IPm+6vFJtv+uSW
         JxLA==
X-Gm-Message-State: AOJu0Yx4Ni4Okkw4hLdlTtlsptaJg1FfAyoPavpSoYsX+gKYKHyTMVFv
	xSEZcyIdld22lk04R4K+QqMb/iWi+m1taTW5eppjGAOf4X4c0MG4gS3L1HUIfuFJrdkzdFrZ67k
	t6X+B77mM+A==
X-Google-Smtp-Source: AGHT+IH9ZcrmRVPK1BcEkoPLLW9uzYcuLK5XpwTitIVSUboPpipeCUTTfA1c8/oZ1Sjbi+UPYG3ZprHTGqrSQA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1584:b0:dbe:387d:a8ef with SMTP
 id k4-20020a056902158400b00dbe387da8efmr41769ybu.1.1706767581338; Wed, 31 Jan
 2024 22:06:21 -0800 (PST)
Date: Thu,  1 Feb 2024 14:04:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201060437.861155-2-davidgow@google.com>
Subject: [PATCH] kunit: device: Unregister the kunit_bus on shutdown
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Maxime Ripard <mripard@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Borah@google.com, 
	Chaitanya Kumar <chaitanya.kumar.borah@intel.com>, Saarinen@google.com, 
	Jani <jani.saarinen@intel.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

If KUnit is built as a module, and it's unloaded, the kunit_bus is not
unregistered. This causes an error if it's then re-loaded later, as we
try to re-register the bus.

Unregister the bus and root_device on shutdown, if it looks valid.

In addition, be more specific about the value of kunit_bus_device. It
is:
- a valid struct device* if the kunit_bus initialised correctly.
- an ERR_PTR if it failed to initialise.
- NULL before initialisation and after shutdown.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Signed-off-by: David Gow <davidgow@google.com>
---

This will hopefully resolve some of the issues linked to from:
https://lore.kernel.org/intel-gfx/DM4PR11MB614179CB9C387842D8E8BB40B97C2@DM4PR11MB6141.namprd11.prod.outlook.com/

---
 lib/kunit/device-impl.h |  2 ++
 lib/kunit/device.c      | 14 ++++++++++++++
 lib/kunit/test.c        |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/lib/kunit/device-impl.h b/lib/kunit/device-impl.h
index 54bd55836405..5fcd48ff0f36 100644
--- a/lib/kunit/device-impl.h
+++ b/lib/kunit/device-impl.h
@@ -13,5 +13,7 @@
 
 // For internal use only -- registers the kunit_bus.
 int kunit_bus_init(void);
+// For internal use only -- unregisters the kunit_bus.
+void kunit_bus_shutdown(void);
 
 #endif //_KUNIT_DEVICE_IMPL_H
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 074c6dd2e36a..644a38a1f5b1 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -54,6 +54,20 @@ int kunit_bus_init(void)
 	return error;
 }
 
+/* Unregister the 'kunit_bus' in case the KUnit module is unloaded. */
+void kunit_bus_shutdown(void)
+{
+	/* Make sure the bus exists before we unregister it. */
+	if (IS_ERR_OR_NULL(kunit_bus_device))
+		return;
+
+	bus_unregister(&kunit_bus_type);
+
+	root_device_unregister(kunit_bus_device);
+
+	kunit_bus_device = NULL;
+}
+
 /* Release a 'fake' KUnit device. */
 static void kunit_device_release(struct device *d)
 {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 31a5a992e646..1d1475578515 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -928,6 +928,9 @@ static void __exit kunit_exit(void)
 #ifdef CONFIG_MODULES
 	unregister_module_notifier(&kunit_mod_nb);
 #endif
+
+	kunit_bus_shutdown();
+
 	kunit_debugfs_cleanup();
 }
 module_exit(kunit_exit);
-- 
2.43.0.429.g432eaa2c6b-goog


