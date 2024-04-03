Return-Path: <linux-kernel+bounces-129905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B38971E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A940E1F2982A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719214A4C8;
	Wed,  3 Apr 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Xn8IhRa6"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438CE149E11
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152903; cv=none; b=nSMzsi/8yLoU2/zMKVI9cxu97aaKrAGHSOfmUaQbW4cWuFPKKrWRRWABzLE7TIIJT/47O1uMxSXECitVilL2jOodCWh1M/BhkpzTZD163GJdXBaCdYOmQU5qk1XYMcCP5Ebow8n1CI+yxZIJyd6p3Xqbz47n/TxXMpd9LPIF308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152903; c=relaxed/simple;
	bh=+HycdZGuj5OU1W/c5yOM/8/+whc2oRxO0Toug1yf4G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iu1aOI7qLte775pB+Z61UjgZkWXNjEpz+vEJdF7F+L/tzbo3apR8lhGVJnSDvFVbiTV9axSfu4tRkMR1VJQ6kiCkGO8KrpE/gJCluc/yR1xulXhxolQv57gdEDszE+KygRXb8kRjYb0kPF9tEchkyGyhVcE0xwUUuys+Z3XEmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Xn8IhRa6; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690c43c5b5aso36652786d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1712152900; x=1712757700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaWEC4wEGQ+YlZ6ti6+WrczlEY+i0roOx8Ci2YqikeE=;
        b=Xn8IhRa6Q1hH8JPkpsL76ia39K74etBsnq86QvXDJzGkDlu4UQISCgwi31tudYRt83
         jPhWkuvW0WWDPNO5GqkZlkamSdX5m/51kSnDSQgYHV4I90SE59QgGnExdChoF6Hyxsy/
         DEBPORJpE0l965/MP4/PLQef9cZTT3H12g9caRcNBv7jcQ5dxHGDpDKbBGyAdCqr7UmK
         ii2GkcFQTeoXQ0TKmt2dtFu9E3LqK/cgIBT1TdNEm8K+8WXd1kr3P+HKnrm3VftvFPtB
         iodG5/lerUuBzTCWeouSem4Ps7N6uKHKXjVY9g1NsXICLR9FA3KpMZ6aSUbRhyMslQY4
         5ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152900; x=1712757700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaWEC4wEGQ+YlZ6ti6+WrczlEY+i0roOx8Ci2YqikeE=;
        b=eCNGH5WDBQIti0Yk0uo6M14JcmwZzghDDbQ1CzA/frogkkJQdRK4Sd6rFF/6tTix3S
         OwoKme/rSP+NudwZhuR1r6TWG6+/LQMpu5KSHZj+1B78MXjkGQjgLdNBFd2LVY5e86mV
         sZbJw3pF9WopUFzyxbhGDYimqYX/TzPXWQtZqs1CcrPFtd992xOySlOseAouLzCf1Oui
         GiYXZ49iLwp5Xl9GBtM5P4ylkJmwCzYmlhLP2cPqd2FG+/czJkY+iM970Ok1d0zSc1cv
         riOrhtkSH6t6k5yjObvWFrM+I9SMnykqIs6R5QiNaVGIrJqbJfaFCgJTATn/+5gbU6Fv
         suhA==
X-Forwarded-Encrypted: i=1; AJvYcCWMatoqIMnNdBxgfkHKsLlUGQpcShvodKrOnWILxChDrAMvPEeBt58P4a/rjnh69ueBm8cyyWcWjgHDrsmk8O7vFepUGwHM29646JHy
X-Gm-Message-State: AOJu0Yz+h1znc3CumoDg8x1vtI+0Med956B/B+OYyMgjThHtKLwj9cuN
	TF0xDyNkE+vO86w8bSTY4+QFlHqV+eL6kBxcVGu22N/B75AvkKpH09gUg7aOXDc=
X-Google-Smtp-Source: AGHT+IGXzY5eGF4cfLmjKD8WCxnHKVScVbM/F99svOb+MTbMgCl4GsOWSudI3dDOqx11Q2sEA8gtCA==
X-Received: by 2002:a05:6214:1384:b0:699:1ad9:259 with SMTP id pp4-20020a056214138400b006991ad90259mr2834018qvb.31.1712152900149;
        Wed, 03 Apr 2024 07:01:40 -0700 (PDT)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id gf12-20020a056214250c00b00698d06df322sm5945706qvb.122.2024.04.03.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:01:39 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Ben Segall <bsegall@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	himadrics@inria.fr,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH v2 5/5] selftests/bpf: sample implementation of a bpf pvsched driver.
Date: Wed,  3 Apr 2024 10:01:16 -0400
Message-Id: <20240403140116.3002809-6-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403140116.3002809-1-vineeth@bitbyteword.org>
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A dummy skeleton of a bpf pvsched driver. This is just for demonstration
purpose and would need more work to be included as a test for this
feature.

Not-Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 .../testing/selftests/bpf/progs/bpf_pvsched.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_pvsched.c

diff --git a/tools/testing/selftests/bpf/progs/bpf_pvsched.c b/tools/testing/selftests/bpf/progs/bpf_pvsched.c
new file mode 100644
index 000000000000..a653baa3034b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_pvsched.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/pvsched_vcpu_reg")
+int BPF_PROG(pvsched_vcpu_reg, struct pid *pid)
+{
+	bpf_printk("pvsched_vcpu_reg: pid: %p", pid);
+	return 0;
+}
+
+SEC("struct_ops/pvsched_vcpu_unreg")
+void BPF_PROG(pvsched_vcpu_unreg, struct pid *pid)
+{
+	bpf_printk("pvsched_vcpu_unreg: pid: %p", pid);
+}
+
+SEC("struct_ops/pvsched_vcpu_notify_event")
+void BPF_PROG(pvsched_vcpu_notify_event, void *addr, struct pid *pid, __u32 event)
+{
+	bpf_printk("pvsched_vcpu_notify: pid: %p, event:%u", pid, event);
+}
+
+SEC(".struct_ops")
+struct pvsched_vcpu_ops pvsched_ops = {
+	.pvsched_vcpu_register		= (void *)pvsched_vcpu_reg,
+	.pvsched_vcpu_unregister	= (void *)pvsched_vcpu_unreg,
+	.pvsched_vcpu_notify_event	= (void *)pvsched_vcpu_notify_event,
+	.events				= 0x6,
+	.name				= "bpf_pvsched_ops",
+};
-- 
2.40.1


