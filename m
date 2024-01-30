Return-Path: <linux-kernel+bounces-43675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191D841787
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3962852B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE251339AD;
	Tue, 30 Jan 2024 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8Mu22Ys"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2D14F70;
	Tue, 30 Jan 2024 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574966; cv=none; b=SPjh4tPBDhZJ2Sd81cmM+mZ2px8JiqJmzn/9KgpGHYzldClrLBtqWyr6gF/ka1A0ItIXNrP1mKEnFS56/pRMGvCk6dIkaixDtzYOfdP4T9Ki2AdMf2DxSpdz0tl4i3mJo/X211Y2jDpsfoLnkAaJmag+Nofqpnwqe6cIKYEFxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574966; c=relaxed/simple;
	bh=ye34zMbl/QLi0u3MaSPXOmlJeFl9PUpZ9o0/z8YiMNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5PCROH58CGEl7Li7yoRKhUI44v854lGtzOTd6akgnd+K/hk97fzDRl/wSi4j8kVlS35x8UiwyXC/oUYDLc708W5tuTpuumA7SJnVT4uTn7GsfKKV1bGGI9u56SPOqnwi+PMdaa2W8+PYKgxbh6XzG07lNcyEVBAIYcpl6YWqhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8Mu22Ys; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ae3154cf8so1623605f8f.3;
        Mon, 29 Jan 2024 16:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706574962; x=1707179762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1kG9myj9Lva9ka/USySAgGs9YBQNCRf+gxiz/F3DH0=;
        b=b8Mu22Ysa7M7UXc3j03as7cABv+7Ys041fbHaPq9yeb7qhqB+swelK1Oedd1iy/Ffs
         2lxuGsOCFOOsUz3PbU3hOhsWijHWusOhAcn+eMOt5LbdMSPXrqQqthDNeGeLfVD6zSz9
         atnq0zDn28JbE9LhPovRCTLjxK6iX+y+EqajJ+vRmamm/ZcvrDYt22rFIozMhLLnia0C
         RWHhiCGPM0G6YRYux/vNsTGGOwhlgSfnJIfK9N3LlAyzcjAlhoTdamIMAE00iBW9Q4ft
         qyLEq2qAbgOQqcgM3VBN0I+A0nwBMI/pytnpiRixb6bGpVTaTQ6vCGTL1PjW9yVsxZcm
         EDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574962; x=1707179762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1kG9myj9Lva9ka/USySAgGs9YBQNCRf+gxiz/F3DH0=;
        b=sYKJkdWNBTeFzQElo7cYrpPdXZcsctgHY5AzKWO6dkg+LuSYaK6hXsmQj0PIDtL4ZE
         9635AtgTabLmNgKen4wDy+8e59gQDg7j6r/yNYnKUUulveys3fAHV2pAxyBztDos0A/q
         1ps6DIyD/h/k+HY4TIaLkrnD/YixW4ybFpIVfa66qz7u6PbEkfwJG00feEZt916taNwq
         CD0FZMhs32pmmpsNRLXbhXwSVGCRi7rdhdN4vltk95JNiZRiDQzlxmDDnyxTd9+kwIiX
         ieUssrWciLdpzT7mtViBc5/ONH5fst+AYLKUgOjGAPghzEbFxYZJ+Sm7FEWR332JDQiV
         X2+A==
X-Gm-Message-State: AOJu0YxTGeAT9g5GaH+IC2+dGJDiTrk10uePDwvjCVlTe4rGfs7Cpd9r
	kfNLjhLjvwXgsMihgqJ7xB5CpRzKjfGVkRcXjvGy02BTrJ/i1LDT
X-Google-Smtp-Source: AGHT+IGo/hs0v3RO2KlZSNUF83Bbqq3flwP55Gk7fwh2TkiN64Z6WvH1hJOj/ioiBe3qMHIdKR3yIA==
X-Received: by 2002:a5d:51ca:0:b0:33a:ee39:5b4a with SMTP id n10-20020a5d51ca000000b0033aee395b4amr3110196wrv.36.1706574962304;
        Mon, 29 Jan 2024 16:36:02 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l10-20020a056000022a00b0033af350fb88sm2542167wrz.25.2024.01.29.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:36:01 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 1/3] dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
Date: Tue, 30 Jan 2024 01:35:20 +0100
Message-ID: <20240130003546.1546-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130003546.1546-1-ansuelsmth@gmail.com>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for clock-frequency and add details on why this
property is needed and what values are supported.

From internal documentation, while other values are supported, the
correct function of the MDIO bus is not assured hence add only the
suggested supported values to the property enum.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/qcom,ipq4019-mdio.yaml           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 3407e909e8a7..0029e197a825 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -44,6 +44,21 @@ properties:
     items:
       - const: gcc_mdio_ahb_clk
 
+  clock-frequency:
+    description:
+      The MDIO bus clock that must be output by the MDIO bus hardware, if
+      absent, the default hardware values are used.
+
+      MDC rate is feed by an external clock (fixed 100MHz) and is divider
+      internally. The default divider is /256 resulting in the default rate
+      applied of 390KHz.
+
+      To follow 802.3 standard that instruct up to 2.5MHz by default, if
+      this property is not declared and the divider is set to /256, by
+      default 1.5625Mhz is select.
+    enum: [ 390625, 781250, 1562500, 3125000, 6250000, 12500000 ]
+    default: 1562500
+
 required:
   - compatible
   - reg
-- 
2.43.0


