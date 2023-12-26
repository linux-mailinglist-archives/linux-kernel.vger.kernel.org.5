Return-Path: <linux-kernel+bounces-11632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACF81E940
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21F61F21BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2618107B1;
	Tue, 26 Dec 2023 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cy/CqcB3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3292538A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bafda3999cso21319039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618525; x=1704223325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6bkILyn4KnLLU+kxlxlq+bLie/uQ2I8rSrs6iLt190=;
        b=Cy/CqcB3gF/OQgZj7mtBm/1Tl0SDmEZz5BIs1zLWTq/GtgWhCJCHaxDXmBn/J8zjmi
         ig2bxZRIEinHyw4PrdkUInhwMLN16E9wAgD4Xal4b8hugKm+DVVBmJ+yuMsNrWwyXeZm
         Ru2BgaBeG7fVU0obMfY48lI3RAVhdh6P4XmH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618525; x=1704223325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6bkILyn4KnLLU+kxlxlq+bLie/uQ2I8rSrs6iLt190=;
        b=fcclTfYMtOAzS4WrXPLRU+fNF00rfuvivT8V9+JHICVc9yCfQDHw2q0SYHhniWin11
         sACs/Cwjo4+Sqi45/sgCNg2Hg8ROeF/oIRL+FgFGLW83mGb0BdD95Sdwv/XSz2yU13Cq
         xgqgPled5dJpGLa1063NERuVb06zNRj/PqT1g/m4bkGLQ1MaiRnlTXLGMgbD2lWXS39j
         VmR05C6zkiWY4R4ds2UqOy0D5q5m6XsVx4yQYjiMdrD3xoORAmMTL8ooA0f30elvTS3s
         h/+DYvu4wlcC3AYpH74KPrbvs+GawtLwVeF0umjvbawtdx9LkxkYqUTj7LkeNkmnpDI3
         lzzw==
X-Gm-Message-State: AOJu0YzgvhzqKShn6apfYlPcovlrLeIYSdtgbZYFuos12R0dXqVQTgCI
	CtjWNEl3LK5LuGNbBAEy8SaXeSx8qvy0EB/DHh4W9lL1vIil
X-Google-Smtp-Source: AGHT+IExsAxEbXq1TtdWgrQ9/NpPCel1/j/cE8sOMacWX3i+Tc+l1Hpf5PLx4sWy2XX4HHrTsl4m1w==
X-Received: by 2002:a6b:7215:0:b0:7b7:fe53:ebdb with SMTP id n21-20020a6b7215000000b007b7fe53ebdbmr8548677ioc.32.1703618525657;
        Tue, 26 Dec 2023 11:22:05 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:05 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 04/24] dt-bindings: power: Clarify wording for wakeup-source property
Date: Tue, 26 Dec 2023 12:21:08 -0700
Message-ID: <20231226122113.v3.4.I1016a45ac9e8daf8a9ebc9854ab90ec3542e7c30@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wording in the current documentation is a little strong. The
intention was not to fix any particular interrupt as wakeup capable but
leave those details to the device. It wasn't intended to enforce any
rules as what can be or can't be a wakeup interrupt.

Soften the wording to not mandate that the 'wakeup-source' property be
used, and clarify what it means when an interrupt is marked (or not
marked) for wakeup.

Link: https://lore.kernel.org/all/ZYAjxxHcCOgDVMTQ@bogus/
Link: https://lore.kernel.org/all/CAL_Jsq+MYwOG40X26cYmO9EkZ9xqWrXDi03MaRfxnV-+VGkXWQ@mail.gmail.com/
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v3:
-Update commit title prefixes

Changes in v2:
-New patch

 .../bindings/power/wakeup-source.txt           | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
index 697333a56d5e2..75bc20b95688f 100644
--- a/Documentation/devicetree/bindings/power/wakeup-source.txt
+++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
@@ -3,16 +3,20 @@ Specifying wakeup capability for devices
 
 Any device nodes
 ----------------
-Nodes that describe devices which has wakeup capability must contain an
+Nodes that describe devices which have wakeup capability may contain a
 "wakeup-source" boolean property.
 
-Also, if device is marked as a wakeup source, then all the primary
-interrupt(s) can be used as wakeup interrupt(s).
+If the device is marked as a wakeup-source, interrupt wake capability depends
+on the device specific "interrupt-names" property. If no interrupts are labeled
+as wake capable, then it is up to the device to determine which interrupts can
+wake the system.
 
-However if the devices have dedicated interrupt as the wakeup source
-then they need to specify/identify the same using device specific
-interrupt name. In such cases only that interrupt can be used as wakeup
-interrupt.
+However if a device has a dedicated interrupt as the wakeup source, then it
+needs to specify/identify it using a device specific interrupt name. In such
+cases only that interrupt can be used as a wakeup interrupt.
+
+While various legacy interrupt names exist, new devices should use "wakeup" as
+the canonical interrupt name.
 
 List of legacy properties and respective binding document
 ---------------------------------------------------------
-- 
2.43.0.472.g3155946c3a-goog


