Return-Path: <linux-kernel+bounces-27037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3282E97F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58591C22CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BB10976;
	Tue, 16 Jan 2024 06:27:38 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2D10A01;
	Tue, 16 Jan 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andred.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33678156e27so8164066f8f.1;
        Mon, 15 Jan 2024 22:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705386454; x=1705991254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLmIQO5gjNwewjIEyYlXBATMFk8RP9bB5NwlP7qSviQ=;
        b=KUAc9zIs71bitA50xACTq/g38twzHNNVRZIReguasU8NP9yuesQuhTXDp3IfTbZC3M
         oOeeNTF6dD7xxBF+fzGwy7G4A/4Y3iwnwhZTUotePwXp+T7IQJ/XQcYSKAy8NYlN8t24
         pn2bi7Wk/0aAufOdGe0tzio6L0z0TPAShVu67aUjrVcOQ1V6FUaofFjcnTGLX9g/fCE/
         +TgZOg9Tj1w/+BOWuAyHbRqmboXarKYmuU6B7jbSKTC2SGtI9S4FLutsmUJJMc9DFxw2
         W90nQVpay4DMAfllm8oWiaXZsdYTa2OTq81FGj2DiTPANaGu7s8OQEjhqej6IqRGUjlu
         mj9g==
X-Gm-Message-State: AOJu0Yyj0LmwIBxu/FocXgiCLNDpiw1CQUOOjIT2GiRrZDT2zsPzc28a
	m2BI2PrwyzcmUvoRVVS5BLEsOm3WiLkFLWPi
X-Google-Smtp-Source: AGHT+IHva935nGbu7TVWrQNK2PSWvc56wD9J2fu4K27ZngGatoogEF/kVpgRvlHnjgTGnxGy6WMUKg==
X-Received: by 2002:a5d:5646:0:b0:337:7c91:d75d with SMTP id j6-20020a5d5646000000b003377c91d75dmr4277549wrw.27.1705386453745;
        Mon, 15 Jan 2024 22:27:33 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id t5-20020adff045000000b00337b47ae539sm934426wro.42.2024.01.15.22.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 22:27:33 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH] dt-bindings: don't anchor DT_SCHEMA_FILES to bindings directory
Date: Tue, 16 Jan 2024 06:27:31 +0000
Message-ID: <20240116062731.2810067-1-git@andred.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@linaro.org>

Commit 5e3ef4546819 ("dt-bindings: ignore paths outside kernel for
DT_SCHEMA_FILES") anchored all searches to the bindings directory
(since bindings only exist below that), but it turns out this is not
always desired.

Just anchor to the base kernel source directory and while at it, break
the overly long line for legibility.

Reported-by: Michal Simek <michal.simek@amd.com>
Closes: https://lore.kernel.org/all/827695c3-bb33-4a86-8586-2c7323530398@amd.com/
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 2323fd5b7cda..129cf698fa8a 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -28,7 +28,10 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' \)
 
-find_cmd = $(find_all_cmd) | sed 's|^$(srctree)/$(src)/||' | grep -F -e "$(subst :," -e ",$(DT_SCHEMA_FILES))" | sed 's|^|$(srctree)/$(src)/|'
+find_cmd = $(find_all_cmd) | \
+		sed 's|^$(srctree)/||' | \
+		grep -F -e "$(subst :," -e ",$(DT_SCHEMA_FILES))" | \
+		sed 's|^|$(srctree)/|'
 CHK_DT_DOCS := $(shell $(find_cmd))
 
 quiet_cmd_yamllint = LINT    $(src)
-- 
2.43.0


