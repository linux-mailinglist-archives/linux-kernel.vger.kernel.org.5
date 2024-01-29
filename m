Return-Path: <linux-kernel+bounces-42872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F99E840801
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87184288B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CF664AB;
	Mon, 29 Jan 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzD8R0/r"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785465BC4;
	Mon, 29 Jan 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537800; cv=none; b=Z5luHKSpcp9p8gAIT8DMBIEVlXoT1DuBnVQF52ppR2gZQWD1fSwO+FNdIX06ox2/a0EwsM2Vlv2R+yLC8yYyx5ULlI5XWPvhuLBLf2/sIcSGvsOXU5VG/Oa/SPEdrXUTSPB8OO6CHeDn4fYFPw8+k15aM1yNwRFbQH32UdU8TpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537800; c=relaxed/simple;
	bh=T5c1Dbp1sJsEszxptNZeBvyymhs1/yh2Ifd/y4EA61I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krsCHnIoVoHaq4fD1/9ixU35mm8xMKCYyRIgjYBzc2+GcK2bOR/rMy+wVgqN5fLy6GJsy1NmGRIQfT3aaZ1aTzPZmEOcb3uilY1w7+4rs+VRK1GhSyl99ompUE3WWNSRikbHz6KuLcvNI5J6RSug07Zp47FkEvr/ir2zbiSTDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzD8R0/r; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51115621f4fso728140e87.3;
        Mon, 29 Jan 2024 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537796; x=1707142596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbzAJ0F2mFrz3jQVdwTJPWtdp7o4RjOP6PbQdpOhSSQ=;
        b=CzD8R0/rAPcdP/X0jvCwHEvsKMOs7qweanJAJDDt/FBx4keNoR6QD7FM7OuD6E8pNE
         HpepxjPoaYnAJ8kGnh0vQpGBECfiziVcK5IMouQQfWR22BFeYb3qvraJTJhp6zw2dhLR
         ll4Gh3am8SMJanPTrrqCWYzG8AgEOz7JNPCfJ+LYPZSf/0JNhjfTnhc5R7aGgC+g9I2s
         Xo+DnDeDCVX20Wmnuw+GlFhjpQHz3fuetdRmADSJJBAF0EfLoCtjFVgLcJxkk4KmVqEp
         2UZFWM4ivCz8wszNzHuWl4Z+bP5LBMjwVjRQ3AscBsjhgyEbL2Gu446giTQl5pFiLlJ1
         Fiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537796; x=1707142596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbzAJ0F2mFrz3jQVdwTJPWtdp7o4RjOP6PbQdpOhSSQ=;
        b=UsNXZoS+/Z21y1ynT8R4jfxjKKKOTNa5Sv7pwGOY3Cak3BLouqEi/HVeA0LMAICCCS
         oTBxDA0mD8lzz2ru2++sk6ZfysbopvMdKp7ddlvdNXrjxL+7wQwG/+4oRgHiGQgjRrgQ
         JejseLMi33xbLiyg2wUrW6N3VN79WQm6gL1xPgedTkjqgQv/b6H7EXOTXSsqaHGmLLX2
         2w9mN47INTACEe2FlV/DJkW5MeaIWNOLoGpyivL0ZDa2yHf5pYgvwq/Fy7MP5K+bWDOI
         BS5Y/AHIDL3dHQKW0oMYVQJwKDyzC5xGjgNIyzmSOONwytzMoaG8La1jSNHm5K6msRdv
         Fk4g==
X-Gm-Message-State: AOJu0YyHOGVsIblXPP5zU1c0WxsUf4WWRfl4Jxa7bkUHcfsr/E0c1IjD
	bAKTEUs9S7Nma0ZBw0er/kzyBWhuVs9JmadP/+TJgbYuGroyK3yv
X-Google-Smtp-Source: AGHT+IFwgkRoUE6Vqua20McJWLUkMmAZbTZCWg4d/w7ktsAgPSXgJV+JLW52Rwav19reovtLOABSdw==
X-Received: by 2002:a05:6512:1082:b0:50e:75ee:ec4c with SMTP id j2-20020a056512108200b0050e75eeec4cmr4819222lfg.11.1706537796100;
        Mon, 29 Jan 2024 06:16:36 -0800 (PST)
Received: from localhost.localdomain ([78.208.142.203])
        by smtp.googlemail.com with ESMTPSA id cu12-20020a170906ba8c00b00a27a32e6502sm3919470ejd.117.2024.01.29.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:16:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 0/5] net: phy: split at803x
Date: Mon, 29 Jan 2024 15:15:18 +0100
Message-ID: <20240129141600.2592-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last patchset of a long series of cleanup and
preparation to make at803x better maintainable and permit
the addition of other QCOM PHY Families.

A shared library modules is created since many QCOM PHY share
similar/exact implementation and are reused.

This series doesn't introduce any new code but just move the
function around and introduce a new module for all the functions
that are shared between the 3 different PHY family.

Since the drivers are actually detached, new probe function are
introduced that allocate the specific priv struct for the PHYs.

After this patch, qca808x will be further generalized as LED
and cable test function are also used by the QCA807x PHYs.
This is just for reference and the additional function move will
be done on the relates specific series.

This is also needed in preparation for the introduction of
qca807x PHYs family and PHY package concept.

Changes v4:
- Add Reviwed-by tag
- Correctly sort new define in makefile
Changes v3:
- Fix compilation error on testing single change till
  patch 4. (improve bisectability of the series)
Changes v2:
- Out of RFC (at808x dependency got merged)

Christian Marangi (5):
  net: phy: move at803x PHY driver to dedicated directory
  net: phy: qcom: create and move functions to shared library
  net: phy: qcom: deatch qca83xx PHY driver from at803x
  net: phy: qcom: move additional functions to shared library
  net: phy: qcom: detach qca808x PHY driver from at803x

 drivers/net/phy/Kconfig             |    7 +-
 drivers/net/phy/Makefile            |    2 +-
 drivers/net/phy/at803x.c            | 2759 ---------------------------
 drivers/net/phy/qcom/Kconfig        |   22 +
 drivers/net/phy/qcom/Makefile       |    5 +
 drivers/net/phy/qcom/at803x.c       | 1140 +++++++++++
 drivers/net/phy/qcom/qca808x.c      |  934 +++++++++
 drivers/net/phy/qcom/qca83xx.c      |  275 +++
 drivers/net/phy/qcom/qcom-phy-lib.c |  429 +++++
 drivers/net/phy/qcom/qcom.h         |  120 ++
 10 files changed, 2927 insertions(+), 2766 deletions(-)
 delete mode 100644 drivers/net/phy/at803x.c
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 create mode 100644 drivers/net/phy/qcom/at803x.c
 create mode 100644 drivers/net/phy/qcom/qca808x.c
 create mode 100644 drivers/net/phy/qcom/qca83xx.c
 create mode 100644 drivers/net/phy/qcom/qcom-phy-lib.c
 create mode 100644 drivers/net/phy/qcom/qcom.h

-- 
2.43.0


