Return-Path: <linux-kernel+bounces-75132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6C85E3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071771C220C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88682D8F;
	Wed, 21 Feb 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GAtX7yd"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352E1DA32
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533727; cv=none; b=Xe77tcNw5E4RrlsY1HgkG4mgMsMvv0mJmKdmWg1j6SuxF2CFy9h9rZNa80BGKw6U7k+VNN2vhUFAJlo4zvvtIUhYU1rSxkoKpHkMJZGhyDHvrGuJTFKB1DNyl0Km59AYNuH96wz8jLPe1P5F/amlPTBhvUDs5a438n7oNA1HPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533727; c=relaxed/simple;
	bh=5QvEqAnoo4+rJMB/03f8vFSvfBFHh/I8MNbKCyj6Q8s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lEWcgpMI6iDYHO4htES1cSDIegGCsLdhJf+B8pbb/GuvY5asJ+2OUBlXRAeoEBGwMZhdAlMa8WlLgszlaudE9CIFx5iM3EYebgN41/ieXHZvQyWyJ0/2n9PQv51YeHtVqLhEQZWaQfpyMEkghnjUoMXmr2klVaQnehtkrlW1v3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vilasbhat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GAtX7yd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vilasbhat.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso10555978276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708533725; x=1709138525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KbnKqBJ3sCc2xkK0NDD9vN4I2lfLk3JwJvt5ev19VfU=;
        b=1GAtX7ydJCksB1JKmRt1pa/tIOc0QF5C9ZHBvQpOh4XSiRgneWacp5bTYCvJ1pHD94
         MzCfOEwsp1cok54wdoXCKBz7qhncpApABqogTpoKNIgGZGHlow8cjb7xwQe5LQiUgGm/
         JAcx7vI76+TEJtt3dp9YIuP6S5Uj0dWf0IZG0S1STQaaQi/P0XHHHOnNo9plwEemtv+A
         2Fo+2USg5aIIJ7xBHSvefR9vnXWlFxk6tDKwXWTZy+e9m9BvdOC4GziOeucv+sprVlFk
         PbjaKg0IYlOL3GFvfVc94bjVcpghZ6ImEEzWwTUQg86dGaUwMDbKiWcaIwoEJhbSKIPm
         W3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533725; x=1709138525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbnKqBJ3sCc2xkK0NDD9vN4I2lfLk3JwJvt5ev19VfU=;
        b=HxD5XySdcmypOIdl0TOhfpqFFTG7OcW8y6WAOpE4mmNSQzK/2sFmOavQDCRaKMCeE7
         id6//Ai0R6DUQhSl3W302bdgdcpOlowNPyBXBTSKAOhchmtZAnk1ji8MqhjwIABQTcMR
         HoPbqyDd6seEo43u8B7lerteobxcDp85doyCnzrpwRiQjWG3EbaZVRiGdeSullGG0gLR
         y4QU2pvlv4kmm8eWuUV93Bl8Vo9EOjQBrrDyWR9g8LaUhpf5EgW03YEC1hYWKa1Fc/av
         U88vSdIel9eGNWtl3nDHxRtzIK0fif5fUqhFHmqfZgFSvnAEtYaPisCMtTRaJMTgQuuw
         Eh0A==
X-Forwarded-Encrypted: i=1; AJvYcCXgRgQ9of4Vxc3MSe0e7IXpDv/9maDNRDXq5WCdIiR8zL8STfiluSd0HAuyYbk8LHZDiYAWFLjDXUo8WRlt3mIVY00Zk6thTtaHVP/G
X-Gm-Message-State: AOJu0YzRN0I7e0lym8UsYgtV/8tIsRUD+4WrQFTO3ufY4iq0ny5Bywzw
	8spUPOY7QU0MmWtiV0QtlGNcEi70S3w0chrw3UrIiQ4z3bgBqO9h9G4HA276szJmaeFMg+tAy56
	4m+TmiLbNiXz65Q==
X-Google-Smtp-Source: AGHT+IHXWaPLyNfBDOUrupOCFt26TQxeRbB1i6NKLfWplBjOilufWplqhgM19MdKKwZATUX83JfPRq4Jh/dX/Vk=
X-Received: from vilasbhat-emu.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:8f2])
 (user=vilasbhat job=sendgmr) by 2002:a25:1984:0:b0:dce:5218:c89b with SMTP id
 126-20020a251984000000b00dce5218c89bmr478937ybz.5.1708533724903; Wed, 21 Feb
 2024 08:42:04 -0800 (PST)
Date: Wed, 21 Feb 2024 16:41:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221164112.846409-1-vilasbhat@google.com>
Subject: [PATCH v1] PM: runtime: add tracepoint for runtime_status changes
From: Vilas Bhat <vilasbhat@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vilas Bhat <vilasbhat@google.com>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Existing runtime PM ftrace events (`rpm_suspend`, `rpm_resume`,
`rpm_return_int`) offer limited visibility into the exact timing of device
runtime power state transitions, particularly when asynchronous operations
are involved. When the `rpm_suspend` or `rpm_resume` functions are invoked
with the `RPM_ASYNC` flag, a return value of 0 i.e., success merely
indicates that the device power state request has been queued, not that
the device has yet transitioned.

A new ftrace event, `rpm_status`, is introduced. This event directly logs
the `power.runtime_status` value of a device whenever it changes providing
granular tracking of runtime power state transitions regardless of
synchronous or asynchronous `rpm_suspend` / `rpm_resume` usage.

Signed-off-by: Vilas Bhat <vilasbhat@google.com>
---
 drivers/base/power/runtime.c |  1 +
 include/trace/events/rpm.h   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 05793c9fbb84..d10354847878 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -94,6 +94,7 @@ static void update_pm_runtime_accounting(struct device *dev)
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
 {
 	update_pm_runtime_accounting(dev);
+	trace_rpm_status(dev, status);
 	dev->power.runtime_status = status;
 }
 
diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
index 3c716214dab1..f1dc4e95dbce 100644
--- a/include/trace/events/rpm.h
+++ b/include/trace/events/rpm.h
@@ -101,6 +101,42 @@ TRACE_EVENT(rpm_return_int,
 		__entry->ret)
 );
 
+#define RPM_STATUS_STRINGS \
+	{ RPM_INVALID, "RPM_INVALID" }, \
+	{ RPM_ACTIVE, "RPM_ACTIVE" }, \
+	{ RPM_RESUMING, "RPM_RESUMING" }, \
+	{ RPM_SUSPENDED, "RPM_SUSPENDED" }, \
+	{ RPM_SUSPENDING, "RPM_SUSPENDING" }
+
+/*
+ * ftrace's __print_symbolic requires that all enum values be wrapped in the
+ * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
+ * ring buffer.
+ */
+TRACE_DEFINE_ENUM(RPM_INVALID);
+TRACE_DEFINE_ENUM(RPM_ACTIVE);
+TRACE_DEFINE_ENUM(RPM_RESUMING);
+TRACE_DEFINE_ENUM(RPM_SUSPENDED);
+TRACE_DEFINE_ENUM(RPM_SUSPENDING);
+
+TRACE_EVENT(rpm_status,
+	TP_PROTO(struct device *dev, enum rpm_status status),
+	TP_ARGS(dev, status),
+
+	TP_STRUCT__entry(
+		__string(name,	dev_name(dev))
+		__field(int,	status)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, dev_name(dev));
+		__entry->status = status;
+	),
+
+	TP_printk("%s status=%s", __get_str(name),
+		__print_symbolic(__entry->status, RPM_STATUS_STRINGS))
+);
+
 #endif /* _TRACE_RUNTIME_POWER_H */
 
 /* This part must be outside protection */
-- 
2.44.0.rc0.258.g7320e95886-goog


