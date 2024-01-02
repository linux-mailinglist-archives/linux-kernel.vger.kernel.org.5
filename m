Return-Path: <linux-kernel+bounces-14828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A143F8222F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550771F235AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1E1772B;
	Tue,  2 Jan 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxlR/JRm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD699168CE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ba8c218fe1so522823739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229727; x=1704834527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvEk8+CF0e0obxZ9GfqxQDlPWDurZBaCRVB9kdh79UY=;
        b=mxlR/JRmwEzQ24gQbrDuASfLAvbvVtviILTojV9tH+legi9uf4b7ADzWQF5EqQddIX
         xT6pNgZodzRXQHKsKbDQwzJoHjqoQgx2e8tm8tSVI049sJzPbI2KiAidhangrsB5MK5I
         4w9xwxX7r/qLSQrGz9oBndIzZwjj3vIDlt9Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229727; x=1704834527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvEk8+CF0e0obxZ9GfqxQDlPWDurZBaCRVB9kdh79UY=;
        b=LRJfQIkwSrxdwEU6EwcDCOIapDE3q0xotBFrNGejOWRJwUwJYSdTtTT2MdgbXH9L16
         BT0t7gRFMokCI22gOnYr7HORiseIt/MgAI/hm7oJ2nic9l6uzWYO0MgVEdpvsDcnOs/e
         B/jKcLd2oEGmZesz+/q/u4YWX5sfeBK/37GzWUr45OrQPCOhhmdl2CWnwC6TaZ8yXQKN
         ntby6M0cTIa//M5GNcRtfOrBIe5WYzhPAqP1j41Q5RWgvdSDvg/Cgcx2v5YImEspj8cz
         Wm650xQ8cox4fyzTRAp7O8xgW6tcl55Ch3IftVp0w7ReDBAGks0m+XGAcxujc8xQYnoQ
         aelQ==
X-Gm-Message-State: AOJu0YzAHu7NBfQJgfmIBeRxWSdEQKF9vWbsMzJpljqLdsxY75u194G1
	yXipm9+k/H4FNgM3IIOlzZHBnWl2sEkQ8QKTZ8zU7r3lC7wx
X-Google-Smtp-Source: AGHT+IHI75xAGPFlil09eKYafdEG2aev9jD01DbjIlsGjx+6zXyEPaBuo+v0kDgukm1xT+F/6TUdeA==
X-Received: by 2002:a6b:500e:0:b0:7ba:af56:55b4 with SMTP id e14-20020a6b500e000000b007baaf5655b4mr12329868iob.3.1704229726966;
        Tue, 02 Jan 2024 13:08:46 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:46 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v4 04/24] dt-bindings: power: Clarify wording for wakeup-source property
Date: Tue,  2 Jan 2024 14:07:28 -0700
Message-ID: <20240102140734.v4.4.I1016a45ac9e8daf8a9ebc9854ab90ec3542e7c30@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

(no changes since v3)

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


