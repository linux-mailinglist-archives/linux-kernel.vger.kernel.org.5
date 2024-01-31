Return-Path: <linux-kernel+bounces-45670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A48433CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E20B2633F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58663A7;
	Wed, 31 Jan 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPPgOhnm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FAFBEA;
	Wed, 31 Jan 2024 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667997; cv=none; b=pc2biBnq2H0bvSlybyF4triKPPJUSpaT+PPcVYh/mddoPH3dTFqqeGZkBjuv8iCwjg1wWrXSilRCNVTg4PtDoVTH8oXRfLINEozJHJ4HWsm5j/61tt55r4lg+DDBgAh2wsTvr3JAcW1CgPtMPjI6iS+gkL7zR/INCEuyewo1pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667997; c=relaxed/simple;
	bh=/caAATAC3YlAgHJWcLd2PRWxBcWyFww9t7GlhCaKJgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXnZcpkopda94KmebXzcu3Lck8YLna62+kWPqfWl+B0dOAos/fdVUd0J4uxDPYGxUCWRJ9o4xIqpA4UAOuuen3ezsBfJFlaZHidmGYIXxyiwSqkNR5ZwIGrQEIsYYbJhR83rXQyBU9BCWU9rptxbKzeuBHMWvyrtZOGEDY1sbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPPgOhnm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so21248915e9.2;
        Tue, 30 Jan 2024 18:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706667994; x=1707272794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2j01IiI6zfUsJF9a2WQ/9OjdhPJsQd8hNy4wmMlPXc=;
        b=OPPgOhnmo2o80nAd8FlW/pyMi/mbL8WkfJL8+H+uKPVm/gT/aohAviTEJRynY5Miqa
         z0Is+8kEO1nwmKzQHszcGWK8z8GMuW0Ejjg2TAMdCVcGMnZTFP1wmuEr5q+CTmjZgwnL
         m7N0H49lWNgNKOM7wH9KdXofK/gJguZGTQr+o3TGl3x5/2OCRUX83wVAxSZWW6PvWaGu
         8dHg4upSlkBLaK07wEaWTRJ4SGXQyVdNYUT/VNXdP4h6dGenNEBZN9MpXqXh+p4aftIL
         3W6apMwYFlhoT3dxupTY28EQ2uVkuZvqihVW5ha/gf+ftCIi+ZCEwEYsowgx6iTr0Pwu
         M6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706667994; x=1707272794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2j01IiI6zfUsJF9a2WQ/9OjdhPJsQd8hNy4wmMlPXc=;
        b=iPQWlWShXEP7TGcznIYOHFhGYiED5iB5AZLHnMh+Oas89wfPWagWQiVWi0Z+AhJsSK
         45HSiomDsJM82rfTvfWUoO9HnLgQW0eiMBo5QobFaMo32MhEEcn2PhDcoHCSahD9RQZX
         p34gf2tbKEO3Dt2LS2TcIExboqjoYV0pWFmMfkALAQAbXyDCORCN0+bGJTTv/NvW9mhN
         WEDFy+vZ/iI1o60s6sFxPbmc1AT56KjRv829NbleEqJaEyDBoGCeKJ0gRSJ2k131fM8b
         /wpPl/wS22COs4tmWGIs2onvO2U89VNBU5vP9ojAUnNK23ixS4lRggSq8pPjFn0Pg7gs
         ps6Q==
X-Gm-Message-State: AOJu0YxGpJoYPNYNrAlfE0Up9suF92xA7dmxBVMhbGrTu2Nv7isRPQrI
	75ALr5HVngdc2ZPC5IsxkTAudgydWlMxT1Ug22mP8b1fLYjLARWAZKQN0NlQ
X-Google-Smtp-Source: AGHT+IH6wXtZiOCKa9k9rmOs0Q0DrW3c2cdodtlHXpUNhdraZpJnpHiL3I3Fm+ftJPcBqxv/nYRFYg==
X-Received: by 2002:a05:600c:35d5:b0:40e:f557:738d with SMTP id r21-20020a05600c35d500b0040ef557738dmr177060wmq.26.1706667993713;
        Tue, 30 Jan 2024 18:26:33 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b0040eea5dc778sm757722wml.1.2024.01.30.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:26:33 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 0/2] net: mdio-ipq4019: fix wrong default MDC rate
Date: Wed, 31 Jan 2024 03:26:02 +0100
Message-ID: <20240131022606.1532-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was a long journey to arrive and discover this problem.

To not waste too much char, there is a race problem with PHY and driver
probe. This was observed with Aquantia PHY firmware loading.

With some hacks the race problem was workarounded but an interesting
thing was notice. It took more than a minute for the firmware to load
via MDIO.

This was strange as the same operation was done by UBoot in at max 5
second and the same data was loaded.

A similar problem was observed on a mtk board that also had an
Aquantia PHY where the load was very slow. It was notice that the cause
was the MDIO bus running at a very low speed and the firmware
was missing a property (present in mtk sdk) that set the right frequency
to the MDIO bus.

It was fun to find that THE VERY SAME PROBLEM is present on IPQ in a
different form. The MDIO apply internally a division to the feed clock
resulting in the bus running at 390KHz instead of 6.25Mhz.

Searching around the web for some documentation and some include and
analyzing the uboot codeflow resulted in the divider being set wrongly
at /256 instead of /16 as the value was actually never set.
Applying the value restore the original load time for the Aquantia PHY.

This series mainly handle this by adding support for the "clock-frequency"
property.

Changes v3:
- Add Reviewed-by tag
- Fix english grammar error in comment
- Drop DTS patch
Changes v2:
- Use DIV_ROUND_UP
- Introduce logic to chose a default value for 802.3 spec 2.5MHz

Christian Marangi (2):
  dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
  net: mdio: ipq4019: add support for clock-frequency property

 .../bindings/net/qcom,ipq4019-mdio.yaml       |  15 +++
 drivers/net/mdio/mdio-ipq4019.c               | 109 +++++++++++++++++-
 2 files changed, 118 insertions(+), 6 deletions(-)

-- 
2.43.0


