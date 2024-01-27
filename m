Return-Path: <linux-kernel+bounces-40946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187AD83E8A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB51C22668
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91445665;
	Sat, 27 Jan 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8rS4Tr6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE23C1C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316215; cv=none; b=Rl0iIQnM8mgY/Oj1SRilBmLvAipMqOKl3OJCcJiV9GTrnHFx0NeP3Pvc6MtGOXW5RAq1K5MQMFjHuCW6fEWm9UMOzviAeHqFzVnKvxcicP1SWe0jN7GcMD5G+US+aL6B5VqzroBQCuI8359yQin1wHQuDNnkRYAWYtUzEx9o1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316215; c=relaxed/simple;
	bh=FLh37MtrGgxAZbOEtksVIMPeDxGh9lhShCJV0PP9zsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e7aIf/Y4IsjolX3GY6R2pPof3MhKIt0AaviBtbaqg7zjsho8kUJqIEXGhkRt3VQ2ZtbYeZ7iWSZC9yLebuufCq8dbNQ3CBl1E1KgsA+5nRpUCIsRCMbVU7bMqprR4TiPztuy70w7j3cBPw0rZUcvljd5lBKYXQ4+LpeRssEhpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8rS4Tr6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1713656276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706316213; x=1706921013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWcySjj6Okvs9yBn0W41qrIqSKP3wnCoOn0mL6uTY9k=;
        b=g8rS4Tr6cxN0qQ6y2ez5wRpJwQe8CttNRVm8XTSa/Umc4aDOOTPUN7qfMQv6kGqeyF
         VcEK/H8W8zYzVMNsfCMOIwWgVA0mZrXu+hMIMYEuB2Ern+20nIfXgGBDtUCLCJJWkWMm
         0RcnpUK/KTHP42JFjErPSzBILCte7CdafjxK+vZopc3e8HrWT/H/6bK6lTJ4QkXDffXh
         WD20W+vXe6KP0V8VhqiNlvEQgWxAsyZU/gesJvNKOXhOrtNJpzioM9vI1izRyZUlJgwM
         jX6hoANKrCMuaVTuCVy6xtWX70XBDOMdl5dKfi66YDcPTRU5NoPy2OwTXoQcxSEvzPkx
         J+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706316213; x=1706921013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWcySjj6Okvs9yBn0W41qrIqSKP3wnCoOn0mL6uTY9k=;
        b=Hi46YwuTFcKEvDJwbV+G4rE889n9taBQIftspBO9++Rdu37DHItzuzCLjnP9HNd2b4
         YEszhEdG2mF/IFKoSDtS0fseOtrypECWzUIGSNcdT96f5PAUUi6P/PwVQEZdbjpZE5is
         LgnU4gQX+IJEeN4Fhm+rOO+nCOlXYFBvRElcGyw6VyXBcTfRgS8cuofLOrdxrCXzuGxi
         x76cAlawBjurnycY/JH7xnH1X+f8RG2m3k+LGMPuYMBq8aaDFqgdccBzeav07j9uT8SS
         xzG97sfUsGuABnCXvBIuNZ/kICFmdo5aQ36Nlb58uyb83eFi06q9qXmqmh/o0k/3/+qN
         weLw==
X-Gm-Message-State: AOJu0Yzg5k39TxrnSVvHfWa7w6Ny5ED2zSH7SRroC9KGY2tu6LwBhNMl
	zhI0HKqo1EkQr81lN5p3q9TU7biB+7wOn9dqC54/QdUe/rsgQGTc/bKybsMylABErNTZI4DIRdy
	FxflaHg==
X-Google-Smtp-Source: AGHT+IHE75xRExeRW8631Xw+f5EC+Wzp3aOn5SVy5OmK0nm2p16TAsb9X9xJgRY4CGuHCaB1HiVAMZrps4aD
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:d621:88fa:6f6:1b46])
 (user=davidai job=sendgmr) by 2002:a05:6902:2489:b0:dc2:2d2c:962a with SMTP
 id ds9-20020a056902248900b00dc22d2c962amr348609ybb.8.1706316213251; Fri, 26
 Jan 2024 16:43:33 -0800 (PST)
Date: Fri, 26 Jan 2024 16:43:15 -0800
In-Reply-To: <20240127004321.1902477-1-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240127004321.1902477-1-davidai@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240127004321.1902477-2-davidai@google.com>
Subject: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
From: David Dai <davidai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding bindings to represent a virtual cpufreq device.

Virtual machines may expose MMIO regions for a virtual cpufreq device
for guests to read frequency information or to request frequency
selection. The virtual cpufreq device has an individual controller for
each frequency domain. Performance points for a given domain can be
normalized across all domains for ease of allowing for virtual machines
to migrate between hosts.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 .../cpufreq/qemu,cpufreq-virtual.yaml         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
new file mode 100644
index 000000000000..cd617baf75e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/qemu,cpufreq-virtual.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual CPUFreq
+
+maintainers:
+  - David Dai <davidai@google.com>
+  - Saravana Kannan <saravanak@google.com>
+
+description:
+  Virtual CPUFreq is a virtualized driver in guest kernels that sends frequency
+  selection of its vCPUs as a hint to the host through MMIO regions. Each vCPU
+  is associated with a frequency domain which can be shared with other vCPUs.
+  Each frequency domain has its own set of registers for frequency controls.
+
+properties:
+  compatible:
+    const: qemu,virtual-cpufreq
+
+  reg:
+    maxItems: 1
+    description:
+      Address and size of region containing frequency controls for each of the
+      frequency domains. Regions for each frequency domain is placed
+      contiguously and contain registers for controlling DVFS(Dynamic Frequency
+      and Voltage) characteristics. The size of the region is proportional to
+      total number of frequency domains. This device also needs the CPUs to
+      list their OPPs using operating-points-v2 tables. The OPP tables for the
+      CPUs should use normalized "frequency" values where the OPP with the
+      highest performance among all the vCPUs is listed as 1024 KHz. The rest
+      of the frequencies of all the vCPUs should be normalized based on their
+      performance relative to that 1024 KHz OPP. This makes it much easier to
+      migrate the VM across systems which might have different physical CPU
+      OPPs.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    // This example shows a two CPU configuration with a frequency domain
+    // for each CPU showing normalized performance points.
+    cpus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpu@0 {
+        compatible = "arm,armv8";
+        device_type = "cpu";
+        reg = <0x0>;
+        operating-points-v2 = <&opp_table0>;
+      };
+
+      cpu@1 {
+        compatible = "arm,armv8";
+        device_type = "cpu";
+        reg = <0x0>;
+        operating-points-v2 = <&opp_table1>;
+      };
+    };
+
+    opp_table0: opp-table-0 {
+      compatible = "operating-points-v2";
+
+      opp64000 { opp-hz = /bits/ 64 <64000>; };
+      opp128000 { opp-hz = /bits/ 64 <128000>; };
+      opp192000 { opp-hz = /bits/ 64 <192000>; };
+      opp256000 { opp-hz = /bits/ 64 <256000>; };
+      opp320000 { opp-hz = /bits/ 64 <320000>; };
+      opp384000 { opp-hz = /bits/ 64 <384000>; };
+      opp425000 { opp-hz = /bits/ 64 <425000>; };
+    };
+
+    opp_table1: opp-table-1 {
+      compatible = "operating-points-v2";
+
+      opp64000 { opp-hz = /bits/ 64 <64000>; };
+      opp128000 { opp-hz = /bits/ 64 <128000>; };
+      opp192000 { opp-hz = /bits/ 64 <192000>; };
+      opp256000 { opp-hz = /bits/ 64 <256000>; };
+      opp320000 { opp-hz = /bits/ 64 <320000>; };
+      opp384000 { opp-hz = /bits/ 64 <384000>; };
+      opp448000 { opp-hz = /bits/ 64 <448000>; };
+      opp512000 { opp-hz = /bits/ 64 <512000>; };
+      opp576000 { opp-hz = /bits/ 64 <576000>; };
+      opp640000 { opp-hz = /bits/ 64 <640000>; };
+      opp704000 { opp-hz = /bits/ 64 <704000>; };
+      opp768000 { opp-hz = /bits/ 64 <768000>; };
+      opp832000 { opp-hz = /bits/ 64 <832000>; };
+      opp896000 { opp-hz = /bits/ 64 <896000>; };
+      opp960000 { opp-hz = /bits/ 64 <960000>; };
+      opp1024000 { opp-hz = /bits/ 64 <1024000>; };
+
+    };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@1040000 {
+        compatible = "qemu,virtual-cpufreq";
+        reg = <0x1040000 0x10>;
+      };
+    };
-- 
2.43.0.429.g432eaa2c6b-goog


