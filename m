Return-Path: <linux-kernel+bounces-53038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DA849FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF841F21A65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5993D99A;
	Mon,  5 Feb 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPg74+eQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB223FE3F;
	Mon,  5 Feb 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151746; cv=none; b=U9WSuWDbAKYbs/4Zx3xJ1g73Tdqnpy/u4ZrVeMFelW4pLneWLdrg8QKw/+Kmva98gahL2n4zUtYo51JiQAte2aTA2bYgB4nBJLw6NdFCYZvUK/7mTEnTT9TDNw3i31gBNhKop6LkA4MxNcZDCtK0CprufX05qO/qdi1nPjPQ0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151746; c=relaxed/simple;
	bh=GcGSsubY4dcKkjecU9LmqR3P0fzbFrmAaN9LWIN7gCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qBafUDFbj92gRk52+VdXr2eYbEHJgSRK0CRI5PvKjcdX90seQ+sAKrLWHwCeVq+qpWBvft7CQ5M5OXfyocbrOu1bQfhkmyqT0uBkX/AK+CAY0X7RgAUXUJbgrzoXEvaHRjH+Zdp7uU4ugPToxANqYUqv/mmqMMkCk0zP9A+r4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPg74+eQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fdd65a9bdso6819795e9.2;
        Mon, 05 Feb 2024 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151743; x=1707756543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2dGla21HbnOwMEyomZ214LPRA+72clAPATlIVdVHlg=;
        b=cPg74+eQBe/uQzei4brtF0fTuUhyW/WIIISAxELChkrlSeYwbPfjOGavVo9QkXt9oD
         z+nNVRj/dHqAUoitMJwqvGUxN7iMDE85FAXkv0vW1RN6Yo5gf99HqM4SKYbnmVtjVmuy
         2ILVMi5Cx95yVTk/nWKdyeucGy5Z2HUqVXmh95Yz3MUWLh6fEaj4HxB21oVTuM/Sv1TW
         ou+/DEkK7LUThsENEcRnybDPLR+TOBlSbPFD1qyYjGWrGHh+yXyOTwRpsReVCQSAMmP2
         G7n1V96Q53+CcCsVm69vxrsgpfmEXJWzDW4oZ+tWs3AK03m0d+DRsRGgdyjwrZnVJsRY
         IpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151743; x=1707756543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2dGla21HbnOwMEyomZ214LPRA+72clAPATlIVdVHlg=;
        b=vYiLJLIxdjgFZmwW1UDKBtse6YdLMLIO+2Fld4CvVu5jroJ0dpm5fcQL2aCoX5F6AP
         BRzrZr3PFJcuhLFtudIxxj/KqY40aaTTp2GajUnCPMNOKdiRdSO2a7yN2MWim0A3+i8L
         LnnYhRNe53Ry0WiStITR/eNWcss+NLpNUk4dKy4ux4gUNfj1VGW4ZlBdkrQ4KZZ1yfB+
         UlJUeJRv2x+Ua5WIbit+R8QIoJaHn8GmG1LaBx/ve5xrB8DdT0mA784kgSPCLMmulfSv
         0a48fhDrjlNm8IIp0XF0dSqFJAe9Evc552zHtsPWs+b7eWOERGgXfw/b3jROuwR+m1vk
         5d7w==
X-Gm-Message-State: AOJu0Ywye3v/6OUR4nD/iXe0eotsvy/Hp15OfCoA9D6Rwvg63skkXise
	ZK6ZliM/8muzm8AfTO2+xYThIO4ju4GsPEq1PE4HgLZKoO9qpPd4
X-Google-Smtp-Source: AGHT+IF825TrmkBo9cBGnBXKNUh54zxVp/NY8JWiCdUK5ktPt/ppFXd6vluy/uXt03iHa+YibzLgXA==
X-Received: by 2002:a05:600c:1e0f:b0:40f:d908:a4dd with SMTP id ay15-20020a05600c1e0f00b0040fd908a4ddmr263827wmb.21.1707151742746;
        Mon, 05 Feb 2024 08:49:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUNy2US1B/HiGwZVwESeCU+H3OIZKuiXpU7QN0rKuufL67b8d3J3UieV/kWS1mFI2BEwsvEHvgRunXFpcxUHj/uQtDx7L6RCsapAsk4gRM0ypM/r4NSWaYhuV1lUGeSNQxrGtp9CmVr6MxdXU1VduUwbc8ANQZkefIRpmBwzVRuhl81+7FqyuVslY3oXEm7BVY0XCk2wwIiANLuobmOz4A+8usr21n9zvJDiyuI27xEFysNRGeeli1dJJcPMats+CiEixz0CeNedTIE6kX1f9wpSS1lFbMJxCnd/vMaSPJrcmtOjZd1NshC1ku6f19aIY2w8qsAHpwdtYuZwLVH127Y1phNEiBq5tmf0RKvanNOGYgNYC1WoG/iWowJ3bUWa9FTCpDs9V20xRxHeKFGdnXPcxzng72YhyOv57VZRVMcW1g2WuS3uHh0Ej89kLnSGfagNE+I2ZvATwIo684qRUvGs8xjYo8/xq7uTrTPGV4NWlBIu6oWDEP0MthVKuM4Qdej8k+Ihc7VFpxzFCibkTehZMZgZriTZjSogWw7UQHF3HOgOuH8rrUE9NkEuk5+ZVtuuioHjvm+anHt2k7tFSCtT0AIj6RrAYFtfxv9+AWffKE0IQNYFW+Mc3hHKMnhdzSpe2TqydymAEkbczcrMdEEKm/053D4HJ6Qvt36Fav5eHXVsQYVHg==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:02 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 00/10] net: phy: Introduce PHY Package concept
Date: Mon,  5 Feb 2024 17:48:32 +0100
Message-ID: <20240205164851.1351-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Idea of this big series is to introduce the concept of PHY package in DT
and give PHY drivers a way to derive the base address from DT.

The concept of PHY package is nothing new and is already a thing in the
kernel with the API phy_package_join/leave/read/write.

What is currently lacking is describing this in DT and better reference
a base address to calculate offset from.

In the scenario of a PHY package where multiple address are used and
there isn't a way to get the base address of the PHY package from some
regs, getting the information from DT is the only way.

A possible example to this problem is this:

        ethernet-phy-package@0 {
            compatible = "qcom,qca8075-package";
            #address-cells = <1>;
            #size-cells = <0>;

            reg = <0>;
            qcom,package-mode = "qsgmii";

            ethernet-phy@1 {
              reg = <1>;
            };

            phy4: ethernet-phy@4 {
              reg = <4>;
            };
        };

The mdio parse functions are changed to address for this additional
special node, the function is changed to simply detect this node and
search also in this. (we match the node name to be "ethernet-phy-package")

PHY driver can then use introduced helper of_phy_package_join to join the
PHY to the PHY package and derive the base address from DT.

Changes v6:
- Back to absolute PHY implementation
- Correctly drop refcount for node on error condition and on PHY leave
- Drop DT include patch in favor for 3 boolean vendor property
- Fix Documentation problem for compatible and missing type and
  description
- Drop redundand gpio-controller dependency and description
- Skip scanphy with invalid PHY Package node and make reg mandatory
- Rework fiber read status to use more generic function
- Split qca808x LED generalization patch to permit easier review
- Correctly return -EINVAL with wrong data passed to vendor property
- Drop removing LED ops for qca807x PHY driver with gpio-controller
Changes v5:
- Rebase on top of net-next
- Change implementation to base addr + offset in subnode
- Adapt to all the changes and cleanup done to at803x
Changes v4:
- Rework DT implementation
- Drop of autojoin support and rework to simple helper
- Rework PHY driver to the new implementation
- Add compatible for qca807x package
- Further cleanup patches
Changes v3:
- Add back compatible implementation
- Detach patch that can be handled separately (phy_package_mmd, 
  phy_package extended)
- Rework code to new simplified implementation with base addr + offset
- Improve documentation with additional info and description
Changes v2:
- Drop compatible "ethernet-phy-package", use node name prefix matching
  instead
- Improve DT example
- Add reg for ethernet-phy-package
- Drop phy-mode for ethernet-phy-package
- Drop patch for generalization of phy-mode
- Drop global-phy property (handle internally to the PHY driver)
- Rework OF phy package code and PHY driver to handle base address
- Fix missing of_node_put
- Add some missing docs for added variables in struct
- Move some define from dt-bindings include to PHY driver
- Handle qsgmii validation in PHY driver
- Fix wrong include for gpiolib
- Drop reduntant version.h include

Christian Marangi (9):
  dt-bindings: net: document ethernet PHY package nodes
  net: phy: add support for scanning PHY in PHY packages nodes
  net: phy: add devm/of_phy_package_join helper
  net: phy: qcom: move more function to shared library
  dt-bindings: net: Document Qcom QCA807x PHY package
  net: phy: provide whether link has changed in c37_read_status
  net: phy: qcom: move common qca808x LED define to shared header
  net: phy: qcom: generalize some qca808x LED functions
  net: phy: qca807x: add support for configurable LED

Robert Marko (1):
  net: phy: qcom: add support for QCA807x PHY Family

 .../bindings/net/ethernet-phy-package.yaml    |  52 ++
 .../devicetree/bindings/net/qcom,qca807x.yaml | 184 ++++
 drivers/net/mdio/of_mdio.c                    |  79 +-
 drivers/net/phy/broadcom.c                    |   3 +-
 drivers/net/phy/mdio_bus.c                    |  44 +-
 drivers/net/phy/phy_device.c                  | 107 ++-
 drivers/net/phy/qcom/Kconfig                  |   8 +
 drivers/net/phy/qcom/Makefile                 |   1 +
 drivers/net/phy/qcom/at803x.c                 |  38 +-
 drivers/net/phy/qcom/qca807x.c                | 849 ++++++++++++++++++
 drivers/net/phy/qcom/qca808x.c                | 308 +------
 drivers/net/phy/qcom/qcom-phy-lib.c           | 247 +++++
 drivers/net/phy/qcom/qcom.h                   | 123 +++
 include/linux/phy.h                           |   8 +-
 14 files changed, 1676 insertions(+), 375 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qcom/qca807x.c

-- 
2.43.0


