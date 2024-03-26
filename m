Return-Path: <linux-kernel+bounces-118242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D988B6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1580E1C37850
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C461CD37;
	Tue, 26 Mar 2024 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va8CB32L"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6E1CA8A;
	Tue, 26 Mar 2024 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415694; cv=none; b=aoaGrE7xvzmu9JI/bzymEym2RiJNRAzHjze0VGDZ/JBRd/ZMLjOv17PVNnq5wkSwpuMn00CvXLDRl5XuCLq0GYoIVLiE4EcYFYeBN6ift/68JC3lzgTmuZUko4zTy0eO4ovZcHveOIUYmW5RocsxD3j/3O2PmRkBV/D7+kp9X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415694; c=relaxed/simple;
	bh=LNamZ53n+sf21S1d37n51soSjho7bKz8IPCYfm5DExQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRTZN1uzhswLee5GDQSXEQYKCaxnGxTEFCjpJPevqDxZT+34F42v/2B+7eTbPDUYG/w1o3/SVRsBnVj2vtGznf9IdYZ4KuiRHZwgkO1ee8ODCI2kyqP/bIWZdqVCi0UT2cHN2HCl3gEBtiz6amWlOlU/jbXHMoixFDMek7+LEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va8CB32L; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-789e6e1d96eso341297085a.3;
        Mon, 25 Mar 2024 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711415692; x=1712020492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+qYgUKU9q0TXu31eGFg1uSz+Dtr3jRQUSc53hkqfKA=;
        b=Va8CB32L+G943QxTZFEzujdV69geUZBs99OQ3ZromGPd+W6lG5ISKmgLEiF+UzdDQ5
         ybeALOgLLMTeGTMOGgI/VzmOQ0z8NMv8A9ulQfxqZOJffD5O66e6Z8/yTSi+/u7hfy7r
         duUsXKKJYjXzyJtp1Yh0RNy1Xt3QMCxwAocJt7G9g9eHJhc+10UIPeDGv0ZFKr2Wg0Qf
         ia9UbIMFBirRA4OILcS8eYKY1J3dddNaZIBZp5A/oDiQmPi/dtI0UbiWrbOKNhSICvUi
         1lOWe5so9d4Z3MArHR2VW9ciUhdDDdNUZUrnBTtbIS5zV2Z8QRhxbYH5p/AkD5ktImk7
         sgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711415692; x=1712020492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+qYgUKU9q0TXu31eGFg1uSz+Dtr3jRQUSc53hkqfKA=;
        b=phvkuzBmeBvUGg1T5edfPzTiVw5KWVs1Ob/XiznZDItu6zyAEwxjtTWpjAAB2jgAgA
         3awsWTK92xmfHCkT0imm2A/cmfMNQ8cYwlz4Y8PSKwuJVy8p3zv9ZS1YCKbSWPFK1MMV
         IVPahn/f7PHv+YnOu80cPnRXM8S+IKB5OLqDG+rHTHEF9e7drbS1pRs7h4oFVcSmVqDt
         n3CxFZBsU6EDbysGz3XXG4498ku/bbkDXVANRUISutt2irgeqWMfCLq36HM23coxM6jS
         7QwXR74qF66VUvZphE1w/HnVKicyILGipHLN6u3WOTWSAbzHdldTztgTtzDmTChPl+Ly
         vRsw==
X-Forwarded-Encrypted: i=1; AJvYcCV8BLmAFVL+Zc7bTscSak3T3c6xZ87kD2yvmCgvYs+T7d4fX+nJq32dRNrUsDUiA2WfolYvGDmhscRhwh2nRSmcDOL0408Epoyb5I4qLJhvmY7BEHsT5k+7RCBYT1ElnQEYTLxKXstyk9WaJOBAE1BlyivnuOHPfPsuXgHCaw==
X-Gm-Message-State: AOJu0YwLo93FQG3nMy3/TZtsUWtTqusvTjwSYqtV9tQIQsf+LSM4qCac
	xPfcgImRgbL+49lxeU6C8Km30E3H2VkRWp1PRtcIvYFhLLbQRxRC
X-Google-Smtp-Source: AGHT+IEa7/w1wZJ6dtNAPScNOQYk15s3E7Pu1UhRaNngaF89B9MLc6jMZ8CwFx7PUljKVceoyNzlaw==
X-Received: by 2002:a05:6214:d63:b0:696:9e90:e025 with SMTP id 3-20020a0562140d6300b006969e90e025mr220539qvs.42.1711415691857;
        Mon, 25 Mar 2024 18:14:51 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id c5-20020a056214224500b006968d8f1c05sm1697208qvc.26.2024.03.25.18.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 18:14:51 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: hodges.daniel.scott@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: [PATCH v2 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf trigger
Date: Mon, 25 Mar 2024 21:14:45 -0400
Message-ID: <da92268495053af38f6ae8e8efb12ceec0947130.1711415233.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
References: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a led trigger that interfaces with the bpf subsystem. It
allows for BPF programs to control LED activity through calling bpf
kfuncs. This functionality is useful in giving users a physical
indication that a BPF program has performed an operation such as
handling a packet or probe point.

Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
---
 drivers/leds/trigger/Kconfig       | 10 ++++
 drivers/leds/trigger/Makefile      |  1 +
 drivers/leds/trigger/ledtrig-bpf.c | 73 ++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 drivers/leds/trigger/ledtrig-bpf.c

diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index d11d80176fc0..30b0fd3847be 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -152,4 +152,14 @@ config LEDS_TRIGGER_TTY
 
 	  When build as a module this driver will be called ledtrig-tty.
 
+config LEDS_TRIGGER_BPF
+	tristate "LED BPF Trigger"
+	depends on BPF
+	depends on BPF_SYSCALL
+	help
+	  This allows LEDs to be controlled by the BPF subsystem. This trigger
+	  must be used with a loaded BPF program in order to control LED state.
+	  BPF programs can control LED state with kfuncs.
+	  If unsure, say N.
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index 25c4db97cdd4..ac47128d406c 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
 obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
 obj-$(CONFIG_LEDS_TRIGGER_AUDIO)	+= ledtrig-audio.o
 obj-$(CONFIG_LEDS_TRIGGER_TTY)		+= ledtrig-tty.o
+obj-$(CONFIG_LEDS_TRIGGER_BPF)		+= ledtrig-bpf.o
diff --git a/drivers/leds/trigger/ledtrig-bpf.c b/drivers/leds/trigger/ledtrig-bpf.c
new file mode 100644
index 000000000000..99cabf816da4
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-bpf.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LED BPF Trigger
+ *
+ * Author: Daniel Hodges <hodges.daniel.scott@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/rcupdate.h>
+
+
+DEFINE_LED_TRIGGER(ledtrig_bpf);
+
+__bpf_kfunc_start_defs();
+__bpf_kfunc void bpf_ledtrig_blink(const char *led_name__str, unsigned long
+		delay_on, unsigned long delay_off, int invert)
+{
+	struct led_classdev *led_cdev;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(led_cdev, &ledtrig_bpf->led_cdevs, trig_list) {
+		if (strcmp(led_name__str, led_cdev->name) == 0) {
+			led_blink_set_oneshot(led_cdev, &delay_on, &delay_off,
+					invert);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(ledtrig_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_ledtrig_blink, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(ledtrig_bpf_kfunc_ids)
+
+static const struct btf_kfunc_id_set ledtrig_bpf_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &ledtrig_bpf_kfunc_ids,
+};
+
+static int init_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+			&ledtrig_bpf_kfunc_set);
+	return ret;
+}
+
+static int __init ledtrig_bpf_init(void)
+{
+	led_trigger_register_simple("bpf", &ledtrig_bpf);
+
+	return init_bpf();
+}
+
+static void __exit ledtrig_bpf_exit(void)
+{
+	led_trigger_unregister_simple(ledtrig_bpf);
+}
+
+module_init(ledtrig_bpf_init);
+module_exit(ledtrig_bpf_exit);
+
+MODULE_AUTHOR("Daniel Hodges <hodges.daniel.scott@gmail.com>");
+MODULE_DESCRIPTION("BPF LED trigger");
+MODULE_LICENSE("GPL v2");
-- 
2.43.2


