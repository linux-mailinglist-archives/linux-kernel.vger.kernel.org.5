Return-Path: <linux-kernel+bounces-125295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12548923A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110841C222DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F341304A2;
	Fri, 29 Mar 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrJpwYPI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613045013
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738487; cv=none; b=Dwacy/b3UsjqX2xE/viZV2by5exnhVPkcY0GgPO1Sx97My807xr6XoLbFyeGmlJpHgs2yBR6/EPNgY+5l1bBCODA6hpGIX1sf2q0ZBDocRmaZJaH6+GdTjiiAy3gRNDcQH9xztcy0Ony5kjJnUC7/+DMB56GOevsjk1Um28Q/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738487; c=relaxed/simple;
	bh=3QA/wELDjfOly3SoK3JbqflTPPsTAzGm3BpN54bG+T0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oEuU6UUr3PCAaLLumbtcd65tx+tlohJiXM8vyHbWWJFCWFO2GLwpjmfRtJ9Ey7gacimPBH16bCzUPHIBzJM0pXKbs5AP5SYZop1HcKFQMiM6x3l6JFAuGlfuQJrWTvOCpQ4LeGoEWOxiOjgcWNG0ngfBEPO2Sut/ZVQ8FNEQ/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KrJpwYPI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4715991c32so282324866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711738483; x=1712343283; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEoJt6PTt2qpbe2pE1qKEsmwN83YlKQDSAv770KyGdc=;
        b=KrJpwYPIkSvRT7ZiiVNn/Z8evIwEpZSuDwLQn0USXZLCeDReT7Si7JCYnbFczliUlm
         8Njgx60v6XGHxdxPUz0vsQGobCB0mNqZGtTMmC6GwV9ukzSE4j7h7plYjbYc78HeTEI9
         WE4O+7CGZrx4pMQgIqnzk9mRZw1SPA+ZRizu99L79ucXu7BSXLJ7J48GUc0UQzSuNdJU
         zZ4+D0sAu3QyRA2fgPZrWEPQxJlYW74eXIaIiWxc7X0wgM0lCRGeI05ruxJlBXFSdE4e
         gbd1vWGBzt9XCPxW3qVoB9nZcPgKiQUWGyT5A3pDSYAAJOPtkm4L0KduYY3/B35K56Zz
         yYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738483; x=1712343283;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEoJt6PTt2qpbe2pE1qKEsmwN83YlKQDSAv770KyGdc=;
        b=fsmLp8CeIGq/Fjxb3Fyqta3hxXVMjQWikSKfPsdhQegkPcEvOm605AUot74gpbybIb
         1sl+PcO1reuhuj1LcKX0whik/az2C17gvv8fEBVRdWsrxLUr8h+WiFwfHWdufVm+vXDx
         FOgIZj1DIlFYQ1RTyXk2lAd8XPPrHdMNRKEsW5yu07z5ufC/+tgIYT1sUmZ8No4OnANi
         MbQ+rYcMfbZAPuepakmpjJOUNB4X05JXvSeC/awPYgqXLLoGq5BNfnHypZ+ajBqMKVL/
         ZuhmlUkGRF6+2S8dMFMJCHtqPkwxYTFKslRFSa0CiTefZzBALCs+MXPR/5BZqFuofah1
         ArKw==
X-Forwarded-Encrypted: i=1; AJvYcCUCrJmnbRA7NDRG6yXDmbTWipROyJe/hJx0kLfseCcvmxYLHaGG+4vACpmpyxlch3ub53gBm/byYejiFRTJ1hkTYhBmEenEZ8Mk4cgu
X-Gm-Message-State: AOJu0YyY1j2gh3e6uUEH/odHU5dAEhfFVT3RyEOk/hh1gUNp3mWxpgFa
	yzjvS65B4RqDTrRzZIdHIBgE7Wz4uVy6GwE8R8EjdJQS14HJmctR8D9+0snj1Xc=
X-Google-Smtp-Source: AGHT+IHiQbZaByTqx1a8yLXtEDMIaraAkghg/jn8TQ1vw3pG3HRmO5i2EtQWeRCNZLTt6veW2dJqgw==
X-Received: by 2002:a17:906:b288:b0:a4e:4441:1024 with SMTP id q8-20020a170906b28800b00a4e44411024mr370498ejz.68.1711738482866;
        Fri, 29 Mar 2024 11:54:42 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm2235618ejb.148.2024.03.29.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:54:42 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v7 0/6] spmi: pmic-arb: Add support for multiple buses
Date: Fri, 29 Mar 2024 20:54:17 +0200
Message-Id: <20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkOB2YC/43OwWrDMAwG4FcpPs9Dluw46WnvMXaQHbs1tE2w0
 7BR8u5ze8oIhF0Ev+D/pIcoIadQxPHwEDnMqaThVoN9Owh/5tspyNTXLBBQA4KVZbwmeb1fpjq
 5TCHLch/HIU+yJWQL2lnbOVH7Yw4xfb/sz6+az6lMQ/55nZrVc/sfdVYSpA/GRgLlbew/LunGe
 Xgf8kk82RlXlKI9CqWSjpwCJGw6aDYUrSm9R1H9ChwHCBF05Lih9IpC2KN0pXrfKvKtbR23G8q
 sKbVHmUoRGuNZK2JwG6pZU7hHNZVynnTgzjSq5z/Usiy/44Uk4ToCAAA=
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=3QA/wELDjfOly3SoK3JbqflTPPsTAzGm3BpN54bG+T0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmBw5lpJ0vA3Lm4pFAQDl5UcaM29FU6Ch6r0Qnj
 Sv/XR5jmjGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgcOZQAKCRAbX0TJAJUV
 VnurEACg1vlmC9fBDZAwTHc4srOY5w9xZz0XOUprEVRhM0fxGhv05xLgLZN3ORmuoQAJ7MnX6WQ
 KFGlIjO6AL5PRe9HqwRK+zk5xomLrdxxgBTB4g2v8zreSdHikzd3MxYxiRea87m0jE6+C6cow38
 HKAH5nqmoZjn0/Fm30BXE+b19E3q7xXvtMU95De/QlW774pHjV6RLpvX+xR57/U7E9ycbR2ky/c
 LMrLyFVzWE1IkzjigaQ6+jogfFniCdLjgAeX6q3tI3Ech+zS0+iWOAvozP31gZ1SiDfBqHsVBwK
 8QCCGF5UZlBnMZp440OU2A1A6DEaH4a62TPiE2+4J4FmaJC2W/LXDEC5jVOiBbqyVreq1Fj3bIW
 ox6g6eW383GY10eVwFytxdF+RGwATmig8yqEO6sSYu2yoddYwsRD2WOWrlPWcJ+DuQvBhZGXVS+
 rsxROBVZarCwsK6FMVG44zldrB/sQfebZhpQLh2ClaAm9udC6fAPw7cGRKOaQsbsY1XGpxHURgO
 jZ/yA5k9PYuqpMWiLauFxJRmCmJxLquIb33TzUxrtUuTMwUMIBcioz/hWuUN12m2Rm9EjQ9olsP
 rfyEeG4tfUe8uta0/r2PvL8RLmeVDSuPDFVX1V2to5XRebN9pvxfXAZkFcrplqWeOcXpybor0fh
 5/chTNvcThq7a0g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This RFC prepares for and adds support for 2 buses, which is supported
in HW starting with version 7. Until now, none of the currently
supported platforms in upstream have used the second bus. The X1E80100
platform, on the other hand, needs the second bus for the USB2.0 to work
as there are 3 SMB2360 PMICs which provide eUSB2 repeaters and they are
all found on the second bus.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v7:
- This time really collected Krzysztof's R-b tags
- Added Neil's R-b tag to the 4th patch
- Split the multi bus patch into two separate patches, one for adding
  the bus object and one for the secondary bus, as per Neil's suggestion
- Fixed regression for single bus platforms triggered by casting to
  pmic_arb instead of bus in pmic_arb_non_data_cmd_v1
- Fixed bus object allocation by using ctrl drvdata instead
- Prefixed the spmi node property in x1e80100 schema with '^'
- Fixed struct and function documentation warnings reported by Neil

Changes in v6 (resend):
- Collected Krzysztof's R-b tags
- Link to v6: https://lore.kernel.org/r/20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org

Changes in v6:
- Changed the compatible to platform specific (X1E80100) along with the
  schema. Fixed the spmi buses unit addresses and added the empty ranges
  property. Added missing properties to the spmi buses and the
  "unevaluatedProperties: false".
- Deprecated the "qcom,bus-id" in the legacy schema.
- Changed the driver to check for legacy compatible first
- Link to v5: https://lore.kernel.org/r/20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org

Changes in v5:
- Dropped the RFC as there aren't any concerns about the approach anymore
- Dropped the unused dev and res variables from pmic_arb_get_obsrvr_chnls_v2
- Link to v4: https://lore.kernel.org/r/20240220-spmi-multi-master-support-v4-0-dc813c878ba8@linaro.org

Changes in v4:
- Fixed comment above pmic_arb_init_apid_v7 by dropping the extra "bus" word
- Swicthed to devm_platform_ioremap_resource_byname for obsrvr and chnls.
  The core remains with platform_get_resource_byname as we need the core size.
- Dropped comment from probe related to the need of platform_get_resource_byname
  as it not true anymore.
- Dropped the qcom,bus-id optional property.
- Link to v3: https://lore.kernel.org/r/20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org

Changes in v3:
- Split the change into 3 separate patches. First 2 patches are moving
  apid init and core resources into version specific ops. Third one is
  adding the support for 2 buses and dedicated compatible.
- Added separate bindings patch
- Link to v2: https://lore.kernel.org/r/20240213-spmi-multi-master-support-v2-1-b3b102326906@linaro.org

Changes in v2:
- Reworked it so that it registers a spmi controller for each bus
  rather than relying on the generic framework to pass on the bus
  (master) id.
- Link to v1: https://lore.kernel.org/r/20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org

---
Abel Vesa (6):
      dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB schema
      dt-bindings: spmi: Deprecate qcom,bus-id
      spmi: pmic-arb: Make the APID init a version operation
      spmi: pmic-arb: Make core resources acquiring a version operation
      spmi: pmic-arb: Register controller for bus instead of arbiter
      spmi: pmic-arb: Add multi bus support

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |   1 +
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml | 136 +++
 drivers/spmi/spmi-pmic-arb.c                       | 953 +++++++++++++--------
 3 files changed, 723 insertions(+), 367 deletions(-)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240207-spmi-multi-master-support-832a704b779b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


