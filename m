Return-Path: <linux-kernel+bounces-131148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4328983B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FC81C21829
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67874407;
	Thu,  4 Apr 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXvJs2oc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01629D1C;
	Thu,  4 Apr 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221666; cv=none; b=VtQGmL+Zgcdt0EbSf6fM4KU3UDW4MZvtVmEAOADj9hq+5IDfZEO38/oHWVkGJtXz+kOt6HAabdS2kxh1u1mgdF1GIk4R5PX9DIlTT+5SLsKOZuHtSKg8o/xAJuPii/sbJ0a5dJ5CzEc7Hv0/pkosQVObHuBRXncYp4XYtzgT9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221666; c=relaxed/simple;
	bh=8Z1eeKz5NWn8FkA1s2nndfTKnz8oh2Mh0NHsNggFhtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jVhYUXR7APRAjmDfLt/KAz52Ve08wQeJ2G6fhyeCLKTG69xkgQxHfsmP+6/Vc5pAfuXrX23Rw+HbeZp+YSBxm2rsvLHHQBnAm7O2Dn7UG2DqO1zRAMg2RfLGPAAygADsZ6QnyD9nLOBulAPx04YZcGPtuKHoT6ilL76+Y3EpuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXvJs2oc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso752583a12.0;
        Thu, 04 Apr 2024 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221663; x=1712826463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFK96jCZIN2tAhA3ygmvv/m8c90WRy9LmwJaVtRHJPw=;
        b=BXvJs2ocXEvXu92tv1kx6xWMtP4YJf5HE5TJHwKZ102vbW3Cly4i3zGvj2oWflmVe1
         7bJ8q61zMr89RehHeN8BmtQqmiaIwQbaCmO+Bc7bQtNa3gw/+dK56uYwNhg5rdYdfIas
         c+EgPJ04iGZa+MiHlS2Ienu9igIWwv2WmB4+dHGcCMycutJhrtjG01zx+2XRqcbZtuUy
         zy7Bvv6awp9M8SgowyI9ZM3g1RoykOKWuX7FXfiEkgJwTrov6YcAuqdTCwPYZqMID+VF
         MsDSugW5EuxxdhL7d8RfYBb+ggysrfy5PneBzOxrub1AnV5UhYqweUM1poUGc13h7EnT
         RQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221663; x=1712826463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFK96jCZIN2tAhA3ygmvv/m8c90WRy9LmwJaVtRHJPw=;
        b=jm2IEcARniGtOapYQxsY6Gx9lgTKw3Wfz7f9+9b5rE2yruCkgxkIAhMxre590qmi8g
         ErIdQBZmpvL1luHunLT3ieuElNNpzOoI8zE8lYw6sH1UAxgJ8OH1/Z86hrm/puGargI1
         TV7QKcEaUnxoUJAOTRabfeGZ+wtoxGHMK1T/3IYjqaM4N+voN3FofPw3sl/tTRjWG1Uf
         ekwblE1jlreNkez7sgbNmJqm8ndu7Hv8tmG2cRfzzprh1sRzUozv29tpoRtuNf1b6eyc
         BvndVoH9fSTa0eU/i5vPywaucP8GsRWo64d1/BNTf8uuJMOkhll9BUjvwAVcpGzlMqII
         EwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE63uRj/SOVrqZ753A845bgDy31ATkrCk9QpDCdaldGU6kWA/w5Qc+RQTtTbrh3EfyPppmfiLrB8Zn7X+VYIFglQ9owbW2YtWtCEfx
X-Gm-Message-State: AOJu0YzReavnOi5sL/k+27qK/gEcdsYAYvbhluc9YB9jGl1BToHt2ap8
	fH+FjAh7Z9j33K01SHeKweHjrRnxpeUANGOs/evOV2p8YFGbKn7r18dWkKX/p0k=
X-Google-Smtp-Source: AGHT+IE9pfnYFX+mC8L/Nlk/CqP5YoK09qK6zbYxUaYYcmgjL+cSHEUe6I5dhHixWhZwlwa3OpZpDA==
X-Received: by 2002:a50:9f67:0:b0:568:b48e:bb2 with SMTP id b94-20020a509f67000000b00568b48e0bb2mr1157869edf.25.1712221662605;
        Thu, 04 Apr 2024 02:07:42 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id i23-20020a05640200d700b0056ddc4415eesm3977305edu.14.2024.04.04.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:07:42 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: marvell: implement cable test for 88E1111
Date: Thu,  4 Apr 2024 11:07:26 +0200
Message-Id: <20240404090726.3059610-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same implementation is also valid for 88E1145. VCT in 88E1111 is
similar to the 88E609x family. The main difference lies in register
organization and required workarounds.

It utilizes the same fields in registers but requires a simpler
implementation.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/phy/marvell.c | 93 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 7c00f47e4ded..0003276452f6 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -281,6 +281,7 @@
 
 #define MII_VCT_TXPINS			0x1A
 #define MII_VCT_RXPINS			0x1B
+#define MII_VCT_SR			0x1C
 #define MII_VCT_TXPINS_ENVCT		BIT(15)
 #define MII_VCT_TXRXPINS_VCTTST		GENMASK(14, 13)
 #define MII_VCT_TXRXPINS_VCTTST_SHIFT	13
@@ -2623,6 +2624,92 @@ static int m88e3082_vct_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
+static int m88e1111_vct_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = marvell_cable_test_start_common(phydev);
+	if (ret)
+		return ret;
+
+	/* It needs some magic workarounds described in VCT manual for this PHY.
+	 */
+	ret = phy_write(phydev, 29, 0x0018);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x00c2);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x00ca);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x00c2);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_paged(phydev, MII_MARVELL_COPPER_PAGE, MII_VCT_SR,
+			      MII_VCT_TXPINS_ENVCT);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 29, 0x0018);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, 30, 0x0042);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static u32 m88e1111_vct_distrfln_2_cm(u8 distrfln)
+{
+	if (distrfln < 36)
+		return 0;
+
+	/* Original function for meters: y = 0.8018x - 28.751 */
+	return (8018 * distrfln - 287510) / 100;
+}
+
+static int m88e1111_vct_cable_test_get_status(struct phy_device *phydev,
+					      bool *finished)
+{
+	u8 vcttst_res, distrfln;
+	int ret, result;
+
+	*finished = false;
+
+	/* Each pair use one page: A-0, B-1, C-2, D-3 */
+	for (u8 i = 0; i < 4; i++) {
+		ret = phy_read_paged(phydev, i, MII_VCT_SR);
+		if (ret < 0)
+			return ret;
+		else if (i == 0 && ret & MII_VCT_TXPINS_ENVCT)
+			return 0;
+
+		distrfln = ret & MII_VCT_TXRXPINS_DISTRFLN;
+		vcttst_res = (ret & MII_VCT_TXRXPINS_VCTTST) >>
+			      MII_VCT_TXRXPINS_VCTTST_SHIFT;
+
+		result = m88e3082_vct_cable_test_report_trans(vcttst_res,
+							      distrfln);
+		ethnl_cable_test_result(phydev, i, result);
+
+		if (distrfln < MII_VCT_TXRXPINS_DISTRFLN_MAX) {
+			u32 cm = m88e1111_vct_distrfln_2_cm(distrfln);
+
+			ethnl_cable_test_fault_length(phydev, i, cm);
+		}
+	}
+
+	*finished = true;
+	return 0;
+}
+
 #ifdef CONFIG_HWMON
 struct marvell_hwmon_ops {
 	int (*config)(struct phy_device *phydev);
@@ -3534,6 +3621,7 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1111",
 		/* PHY_GBIT_FEATURES */
+		.flags = PHY_POLL_CABLE_TEST,
 		.probe = marvell_probe,
 		.config_init = m88e1111gbe_config_init,
 		.config_aneg = m88e1111_config_aneg,
@@ -3549,6 +3637,8 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1111_get_tunable,
 		.set_tunable = m88e1111_set_tunable,
+		.cable_test_start = m88e1111_vct_cable_test_start,
+		.cable_test_get_status = m88e1111_vct_cable_test_get_status,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1111_FINISAR,
@@ -3642,6 +3732,7 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1145",
 		/* PHY_GBIT_FEATURES */
+		.flags = PHY_POLL_CABLE_TEST,
 		.probe = marvell_probe,
 		.config_init = m88e1145_config_init,
 		.config_aneg = m88e1101_config_aneg,
@@ -3656,6 +3747,8 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.get_tunable = m88e1111_get_tunable,
 		.set_tunable = m88e1111_set_tunable,
+		.cable_test_start = m88e1111_vct_cable_test_start,
+		.cable_test_get_status = m88e1111_vct_cable_test_get_status,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1149R,
-- 
2.25.1


