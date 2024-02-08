Return-Path: <linux-kernel+bounces-58072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CFE84E0E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E841C23E34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B976046;
	Thu,  8 Feb 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d85Br8P/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843EE6E2DE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396227; cv=none; b=HC6OT0JMW6dYnUGy7J7XMTQhvSOU0w4i1azO61kqVp4kp37FCr8p3/yLK4oRyjNdqZZybcIWhYL/Be8J9QxlSmU5gYPVP10+Tgj3KkTBDP+aUA1/myr/zDazUDqgUHOThC89or71zJUfzjfgKyA4lTrUK+G7WbP8Sp0gRYNwCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396227; c=relaxed/simple;
	bh=4YzyhUoPY0n5wlQMtJwSrkS3+ZjUeV1jFH7EHUBufPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoEzMoTiEBLzsJoLFkIGinKJnRcXnZs9SwLL8/XxB34ijZHnOW2MzPdl63/dNcK9QTqJN4+FnBkMpuvSoDzSijXlM9j4QR2w3yRnHHozezyij2wFVZPEyXMpHJa00HIzPHe+hPQm1HorVJvXfyDm5xLJ9/ItokDokoGJln4DWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d85Br8P/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51168572090so2916982e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396222; x=1708001022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euiJLfBajM/ZFVIDyhIV5fjjCmiMvfIZ0T4coXTdvWE=;
        b=d85Br8P/U/eGstYU94yYzf4n4Ulgb6UAeu9slFgkiVcV4EoMfqJvRZ8zKT0WrRyzxt
         gikABKcEOU3sPkNMo4Bv0n9F6wqmHdQRt+e/6SlQ1eEDWBQ1/c1oWMN3Q3DYG7w+O/U6
         akGmOq7hLt+7HEVKbJcIkhiHgFCrrYEbsbzgZPDAGpREEn1NOFJC0gheBGEdhV2RgUNO
         0VPZbIO0P3ic77MbayIsXDvOJWg1YPNIzXvehiJRm1adLiR9ojah7B4DZpHYW7ZArK3h
         0L6HFLyWh5CzL/i3rnCsfAck3dLa+B9kG6J+UpScbvepTAVXJoBTnufd6j7LeX7KVKpM
         Ak+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396222; x=1708001022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euiJLfBajM/ZFVIDyhIV5fjjCmiMvfIZ0T4coXTdvWE=;
        b=Hs1OnHg87/NkIjMNKC2xCtSlmcU5eOlvyRXVaBs6r8a2tthkFxoozDIth1BQgKxjYA
         Y39Z4XOnOiM8iQOSiYdWmOg7A2bUdL56uEKo4CtYeGO9W7dF0Te1xcBu7t7CrW1RiZpN
         MIngmuv1DU80OO/DNS5dlSV9Nw9PVj/IrE83XJBXKZo0jSMl5pGKn4xY0UR8AHEBuxs4
         qXVmETZvJBWNQ7Pad6SBCK8fat8VTPCFAcxnh/1KS7BnavLDZivyN6j/IpAMPuQwY/+B
         gVPFG6Z6tXgyP+rvyHAgpyP60b1juU2AWdJEnVzgehFw49PZsahWebROLs7kHx99B6Dl
         1DmA==
X-Forwarded-Encrypted: i=1; AJvYcCXEono4sIlrJBMRc2OawEvljT7l6BLiMdyUWMroEGoIvKj7vj4WV4DIgpcUBQh4ir/jboRpIT/P8HQgljSGDAqAwM8AqxT7mr+das8O
X-Gm-Message-State: AOJu0YyrnKyqQZ/4gvq8Ty179Cg+sh3DpJYpcHBNEqQzgsa9g5Kuh5iF
	ayQCWynHCNsPoLWVnvfQvZp+MwFO9TC+noTnQ3iinFyDBIi/8WzGH15Nb4Kw6YY=
X-Google-Smtp-Source: AGHT+IGFiG7OHJfzRNPbhImwwPJamXoJQIEhIgb6vjVPNybgWE5Mqmkj9l3PB8njMa4WiG5eqbRvxQ==
X-Received: by 2002:a05:6512:33cc:b0:511:5724:dcd1 with SMTP id d12-20020a05651233cc00b005115724dcd1mr7734788lfg.11.1707396222387;
        Thu, 08 Feb 2024 04:43:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWr+/IOtPfh0lK3AG+Z2s/nxleo8pO7DNwgvhzMfvQOlQeo0BQH94pIvapJvPkZXT7ludRt0V+zlZx62qzOHVY6SOOcwiztRENMNS5ttT/QzvChrqrk00aJIsWx4Vt2c8wBXhfHRFyHj0pfjdVpU7qL9XL3h2uHIjX+E7WNTj0cpaKRyvNm0Ja/l6yLSd2P7yTY4IQaZ92erU6P8uUKz8hmle7apJ+YzTGyWowtGq1LPEZgwSEAbqbd6qmrGfD82zRqVopXiTjBd9o1q/O2VuW2925SPB81j28coIaRlNJGyYSaOyoJnO+6WJv+jOAu1Al7abQ5TRMvglgi01KlUN7O4UzNnBLcnBifcAp4n9tiE8pt9WciwX8RLricE7vehrbXPiZO0hUKk0+70QjmIIMB6VblERZovT9GO0WUuFeZ4mBpnldemseNCZvJRdbwuapgoOjy/ZCYeiCUWltUFkgtTHU6x32rHfEft9nTEJwO7R5uAH93iOlpTFw5ClvujCf+oGbGn2ihPSlUFlgFBJC1rQymxDr6CZ5hqwN/a9/82ti6abyqsOL/jMmqXHulG9k=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:43:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 00/17] clk: renesas: rzg2l: Add support for power domains
Date: Thu,  8 Feb 2024 14:42:43 +0200
Message-Id: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds support for power domains on rzg2l driver.

RZ/G2L kind of devices support a functionality called MSTOP (module
stop/standby). According to hardware manual the module could be switch
to standby after its clocks are disabled. The reverse order of operation
should be done when enabling a module (get the module out of standby,
enable its clocks etc).

In [1] the MSTOP settings were implemented by adding code in driver
to attach the MSTOP state to the IP clocks. But it has been proposed
to implement it as power domain. The result is this series.

Along with MSTOP functionality there is also module power down
functionality (which is currently available only on RZ/G3S). This has
been also implemented through power domains.

The DT bindings were updated with power domain IDs (plain integers
that matches the DT with driver data structures). The current DT
bindings were updated with module IDs for the modules listed in tables
with name "Registers for Module Standby Mode" (see HW manual) exception
being RZ/G3S where, due to the power down functionality, the DDR,
TZCDDR, OTFDE_DDR were also added, to avoid system being blocked due
to the following lines of code from patch 7/17.

+       /* Prepare for power down the BUSes in power down mode. */
+       if (info->pm_domain_pwrdn_mstop)
+               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);

Domain IDs were added to all SoC specific bindings to avoid breaking
dt schema validation failures.

If the proposed dt-binding update is good for you, please let me know
if you want me to also update the individual dt schemas to reflect
the newly introduced power domain IDs in schema examples, if any.

Thank you,
Claudiu Beznea 

[1] https://lore.kernel.org/all/20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (17):
  dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
  dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
  dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
  dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
  dt-bindings: clock: r9a09g011-cpg: Add always-on power domain IDs
  dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells =
    <1>
  clk: renesas: rzg2l: Extend power domain support
  clk: renesas: r9a07g043: Add initial support for power domains
  clk: renesas: r9a07g044: Add initial support for power domains
  clk: renesas: r9a08g045: Add support for power domains
  clk: renesas: r9a09g011: Add initial support for power domains
  arm64: dts: renesas: rzg3s-smarc-som: Guard the ethernet IRQ GPIOs
    with proper flags
  arm64: dts: renesas: r9a07g043: Update #power-domain-cells = <1>
  arm64: dts: renesas: r9a07g044: Update #power-domain-cells = <1>
  arm64: dts: renesas: r9a07g054: Update #power-domain-cells = <1>
  arm64: dts: renesas: r9a08g045: Update #power-domain-cells = <1>
  arm64: dts: renesas: r9a09g011: Update #power-domain-cells = <1>

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   4 +-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  84 +++----
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   6 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 100 ++++----
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 100 ++++----
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  20 +-
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  28 +--
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   2 +-
 drivers/clk/renesas/r9a07g043-cpg.c           |   9 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  13 +
 drivers/clk/renesas/r9a08g045-cpg.c           |  27 +++
 drivers/clk/renesas/r9a09g011-cpg.c           |   9 +
 drivers/clk/renesas/rzg2l-cpg.c               | 227 ++++++++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h               |  68 ++++++
 include/dt-bindings/clock/r9a07g043-cpg.h     |  48 ++++
 include/dt-bindings/clock/r9a07g044-cpg.h     |  58 +++++
 include/dt-bindings/clock/r9a07g054-cpg.h     |  58 +++++
 include/dt-bindings/clock/r9a08g045-cpg.h     |  70 ++++++
 include/dt-bindings/clock/r9a09g011-cpg.h     |   3 +
 20 files changed, 752 insertions(+), 186 deletions(-)

-- 
2.39.2


