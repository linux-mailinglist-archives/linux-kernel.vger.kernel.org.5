Return-Path: <linux-kernel+bounces-75428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D4385E88D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E521C2202A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0A12EBC6;
	Wed, 21 Feb 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtC+K8Ky"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7A12E1D7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544989; cv=none; b=S8USJ5Os4mmlB0mzP7/XwdxSqFHpN1AnW+qVmPWXbmB5Cr98xX3N+Ra2I9jTfn3f+RWOOTaFScydiY2zob3WhD6H9+CVgHg7d1MoM2odpPedc0SYNFVDuxS8HLdXaM6dsIdVTWrNIggk9/T7Vtfty24RPTRISpzX9NCp4/2JchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544989; c=relaxed/simple;
	bh=dHsou/hd8ny3LwFZsjdRpHG0mjn9OJ8AgEw33Ge0uiQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gg+IsmEf9mnahl0KQyEWtQW+AWG/xX9+3L9og3h5h+k/Fs1pFfGJiwlsn4UP0KIFxWAxZtoFiivPPMXd4Zd4Cjs3saoRql/MCmqS9iGJyp3k4YHajBSuEr+WYnjgPnlaoZl4Fy1eKwsvc1JhEIYAJKycKtAFLpPUYixDsJ9sHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vilasbhat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtC+K8Ky; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vilasbhat.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so9048511276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544986; x=1709149786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dY3bbKQ8BuzJKDn9eA4y8nGoIVfjx/oyPxLya0zWCzo=;
        b=QtC+K8KymGSyWXQXRZw3+gsPVh21/O9+nbP8grLN+uHSavHeKQCHvQNUug/kNhfSS8
         fNeu1nEXtZGa7+dwqAHefeWs9Gq1iSCx8rbUe+o0KG4XWiecCgRgt4vPu+BELWj/Erqi
         5LGC9rUkIhlLvz9mr1Zk+mLzF6ifW7DS4OI4kKZjJSANhES8wUtPp8czdn5c1mGkv7iS
         YNC43CNLCei/n7MXxWvY4rv2xT6/7/aqjb6DXn2vNy26detZlE+tmmjTTQXupdbO2OEY
         UfE9fHvOzBPOytn/v5Hx6SaxBtewSL+F7cJNE8r5IXDwNMKMaCdGfumRxvNxKITo/Zqe
         VD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544986; x=1709149786;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dY3bbKQ8BuzJKDn9eA4y8nGoIVfjx/oyPxLya0zWCzo=;
        b=sbxWSl0N8C/Zz8RNL/N/GKxUs5v6sreB6fp5ivU5Mm915QPwEDFiot3xLbRy5WuNaY
         t+VlH49BBqb9VVtVRLbnLWK1X5IUWPyKaO70R6Gn8j1g5ooH56pdeCdKeVjUqfti1xL5
         lCK1qO+bCxPGfmZQZMefzLDV6t196KK0qmgcE2ofW62TJtFfvuKGwjTeEsKzDbHEHOtP
         u2YKoUOQ56OEM0RRTT8BhzJWmfLmvQxv757xD6iM5ziOR7rJ+sWK+yY57k3taVBvUScG
         361vyrXaoDaY+gi8YNu0v9nyCZb+9YHZ8aVV025BudC146Dr6udDMtco9EVGJeop3Tgl
         5ipg==
X-Forwarded-Encrypted: i=1; AJvYcCU05fAALZifmHtRQCCYI5t08pbTLEKiGfts2yauVA1ODJCz1LknngfcjnGxWJCDX3QWxXxuu3ZNNAdYJTdevhRX7oeQGTHI3pxC+C1R
X-Gm-Message-State: AOJu0YyWMUU3IjjQGNxuDT4G2oUgbt8wGMOHW6uc/kbVkxt8sRSvgpHW
	GBolf3HtUQHUBlkG1GKwiR9rVcs69exBe54JOYT/aYyo7+6Kpitw1qwGDonepMhjOZoPofiuI0i
	YImst1BlB19MO0Q==
X-Google-Smtp-Source: AGHT+IGVZJXwF6/QCuP/A9p4bu1a4NrgucjWHGMyzguHpAm/ajLSlOvbRCDMJ+PRNq41mWXAZmFOJh1k/WHVZQM=
X-Received: from vilasbhat-emu.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:8f2])
 (user=vilasbhat job=sendgmr) by 2002:a05:6902:701:b0:dc8:27e6:cde1 with SMTP
 id k1-20020a056902070100b00dc827e6cde1mr18718ybt.5.1708544986720; Wed, 21 Feb
 2024 11:49:46 -0800 (PST)
Date: Wed, 21 Feb 2024 19:47:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194754.986300-1-vilasbhat@google.com>
Subject: [PATCH v2] PM: runtime: add tracepoint for runtime_status changes
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
V1 -> V2: Modified enum value definition as per reviewer comments.
---
 drivers/base/power/runtime.c |  1 +
 include/trace/events/rpm.h   | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
index 3c716214dab1..bd120e23ce12 100644
--- a/include/trace/events/rpm.h
+++ b/include/trace/events/rpm.h
@@ -101,6 +101,48 @@ TRACE_EVENT(rpm_return_int,
 		__entry->ret)
 );
 
+#define RPM_STATUS_STRINGS \
+	EM(RPM_INVALID, "RPM_INVALID") \
+	EM(RPM_ACTIVE, "RPM_ACTIVE") \
+	EM(RPM_RESUMING, "RPM_RESUMING") \
+	EM(RPM_SUSPENDED, "RPM_SUSPENDED") \
+	EMe(RPM_SUSPENDING, "RPM_SUSPENDING")
+
+/* Enums require being exported to userspace, for user tool parsing. */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+RPM_STATUS_STRINGS
+
+/*
+ * Now redefine the EM() and EMe() macros to map the enums to the strings that
+ * will be printed in the output.
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)	{ a, b },
+#define EMe(a, b)	{ a, b }
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


