Return-Path: <linux-kernel+bounces-118243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96DF88B6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91BCB285EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0261CD39;
	Tue, 26 Mar 2024 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsSH8IrK"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573C1CFB9;
	Tue, 26 Mar 2024 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415699; cv=none; b=kqb+I6Lg6KT8Q/6yuXMufntP5T7KPnljHEIEAUmjn1hg/wmHblfC+1NXRYGFutASGZVIM9sM8DvFlkIHDkv2JOotXQtIuZY9NsvldlFoy5g+jqnTP+vWos7qH95Hy8Z6eI3Y1Q3+QMWJtee+nWUYkJpkqD71eS88Hzy8HEo6E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415699; c=relaxed/simple;
	bh=M+BsVnMf+g67qs1SA+qAhNNLZnMvvsIucUdMjPkinPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw7gf78Qsi6bJkfNnJwqT/NmkYApZ7E8nBv3EEe1AlgAXABHFfYZWgk4o3VUjmBBaeHjSXuke8va/AzzfYjXXIZep149WtWLMGZTaq6x5J01OdWBGb6x2cjocdLBWV7yS4d0vQSmdvEw9qhXAZw75tuhVo2DMGJy+ErN/2h5G2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsSH8IrK; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-696499bd61eso47967316d6.0;
        Mon, 25 Mar 2024 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711415696; x=1712020496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHLkuarhJN7RySXMXypyHFsucB45L1ocZHQUOCELI/A=;
        b=IsSH8IrK6HuTaz7/zlAkjR4DZAcfJTC6usEpAoBKFc2+BvUmiZ4QqTT4D+JlA1ONnw
         rpmwnjylyvLxfDzb4re+DoNTCaG65FfPRscSGdIVoHceyjWMtMiRVvIFf/HG+LxH9qjY
         7m7rUh4+XvcaN8pdS5+e2kXYbqMnNCeZoGW5e7sludtlLZWXg1yfDS1mhVlUIXfCpqdF
         kZUQrWp38hWdX6GQw+7O2WZD17E0zMilPD2lF5EitGNhZYQ/n1AM4Q4SVTjUqH5FZtIz
         rgWC3/dRYojGF6ba3M28xAZYGRMRzqrpimyfxJ5JwNU/J303UaUImUd1LwIVpuZMjyY5
         egKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711415696; x=1712020496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHLkuarhJN7RySXMXypyHFsucB45L1ocZHQUOCELI/A=;
        b=v1WT4JmkzgjcXGK7emnTScL1lAatHsq0tsdGrRoc3MQ1CJAlGKXgMxyTDIQwHj+NkD
         XF/DZ7/sWRmnjfWeIuG90GqsHtBJI2VP6A22Gp9GwLVNdBamqtyHf2qY3V9LQjv1vRVd
         i/7WABEOF5LQvW3kwCNJI0OTdVBozQLPbfwiZ4PrtkokSR3xBEx5X1JVXesqFsuw0sry
         VUILhLTlfPSMkpiCFQKFq2M9jRSkUJpnVnjGLfc54Uq/cOga/aadYqjfBP68W1ylHeW2
         tJHV/OeV/6wyz1jApyU9CPCZlqoF/dsOzfEE8Dvx75t57lfYXhX3HkK5mjtFxjzA8nEd
         ndZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnltSf0FIbjMQQyzXFm7NlMTE0IWQevyH6Y4kJxf5GYVkP27WaxdMDzX0XTXYN1ZEnEGnQpv7fwVJXXbFqv20R4+whRsFd3gn4aD4DC1IcisWzCgC0JyeLp3Pa4s5udHCGLj8rLcb3IIOm3+fnwQHDMKVPppIsLmMbFmxxBg==
X-Gm-Message-State: AOJu0YzSEejsldLjVC8FjUd3prbdtGZZsQtjMPQo27CVvFjOAKm/LQWA
	iYLWzI7hu8ToyRyidWsY6n3/jH7OrE5W7HTEJBbwL3zUH2AX00NJqadpCpOc4KU=
X-Google-Smtp-Source: AGHT+IFM0W4EV5psIPVeZrrsINiZeNegya11qTR6utIwolZBlz3euoGtForb1TvcUdg3zsfbWf2zhw==
X-Received: by 2002:a05:6214:cc8:b0:696:1e36:6d0a with SMTP id 8-20020a0562140cc800b006961e366d0amr13848280qvx.14.1711415696334;
        Mon, 25 Mar 2024 18:14:56 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id c5-20020a056214224500b006968d8f1c05sm1697208qvc.26.2024.03.25.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 18:14:56 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: hodges.daniel.scott@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: [PATCH v2 2/3] selftests/bpf: Add selftests for bpf led programs
Date: Mon, 25 Mar 2024 21:14:46 -0400
Message-ID: <ac20b89cb46ddfb59150971d0bd836617515565c.1711415233.git.hodges.daniel.scott@gmail.com>
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

Add selftests for led trigger bpf programs. To run the tests use the
"test_progs -t ledtrig_bpf" helper.

Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
---
 tools/testing/selftests/bpf/config            |  1 +
 .../testing/selftests/bpf/progs/ledtrig_bpf.c | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/ledtrig_bpf.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 01f241ea2c67..17a027905dcd 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -42,6 +42,7 @@ CONFIG_IPV6_SEG6_BPF=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
+CONFIG_LEDS_TRIGGER_BPF=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
 CONFIG_MODULE_SIG=y
diff --git a/tools/testing/selftests/bpf/progs/ledtrig_bpf.c b/tools/testing/selftests/bpf/progs/ledtrig_bpf.c
new file mode 100644
index 000000000000..d2096f13e5b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ledtrig_bpf.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+
+extern void bpf_ledtrig_blink(const char *led_name, unsigned long delay_on,
+		unsigned long delay_off, int invert) __weak __ksym;
+
+
+SEC("perf_event")
+int perf_blink(void)
+{
+	const char *led = "test_led";
+
+	bpf_ledtrig_blink(led, 30, 30, 0);
+	return 0;
+}
+
+
+SEC("syscall")
+int fork_blink(void)
+{
+	const char *led = "test_led";
+
+	bpf_ledtrig_blink(led, 30, 30, 0);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.2


