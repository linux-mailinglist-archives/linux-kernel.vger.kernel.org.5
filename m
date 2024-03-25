Return-Path: <linux-kernel+bounces-117977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25388B1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040251F631FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13186655;
	Mon, 25 Mar 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4c56MXF"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0CC86279;
	Mon, 25 Mar 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399537; cv=none; b=Noy8INhpWV5KCZEx9B5q3uk8pYi+zpNmGyTOPRZIVIP9JaoFPA7tYpdGsBNo03TuP9Y6fH+OX8TTJpSCSbyVjbeqnY6hg8aYlXWgd7oOagls+MNval5uUBfLi/606wnE+2MdYuDr0m3WjpxMRAy1unJ9dvcUnG1yUhp0VUZ4z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399537; c=relaxed/simple;
	bh=S51/LPCB5EdTpEZfibpDIYuyrDG10p2ILcElzdF65t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXG5TXZQtY6tJmSPOr0T98Ed1+5p6aCaWKvzxbMmBlS5tNFMaUWnTZdcQGRaQYFOCzhgJb6BVJPnL1qgyNzkhWMSpLXDab/ldl1tYEjfR8flFaG58D2ZQSJmB9nPRfR/AYyLYGPDi8icRCN7+n8XJGLRF+ldwC3H339qFc3G5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4c56MXF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c2818e977so138961a12.0;
        Mon, 25 Mar 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399533; x=1712004333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE1BA5ViLMATtt4YKzjKBWlb/e+klcdW1qAoMPTU4A4=;
        b=g4c56MXFpHYH0a/gWc+DyEeFKNbljJYRlHo/8kocW/BFZYH61ZKTNhXyCuX1ekGIZ6
         REVXuMb40grXyHmj7aYlqDMfT17H+TAX6rTb/gtHnDlIXd/DS3GaR+WDKDCrNsG/JVcN
         BhZQR1jxkdeQpgSv3ua+ny9g/OdldBXr9XGwGSqPvNYWLQ+sLa8oT8jnYaYufRV7SPH6
         81UrErjbPIUJ9IHut5zSXu8kO0dAyn4zGahRrXjv+8pPYR3ISxv5xhP5gyWpYMQuZZOX
         h4apWx6aduXdrUpjOIh+L6Bkww7tlcxhzDHFfm+gbGrjZMS1Ov13jTbCyy9hHBqNrOrh
         QXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399533; x=1712004333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE1BA5ViLMATtt4YKzjKBWlb/e+klcdW1qAoMPTU4A4=;
        b=NpBfuz+kT0K2k7e5cpJ9Ap3uOIYNb3KDicFtsU4WjGgEmZmxS3cNXWpuvdmHREHpdl
         j3tHKD6R95IoJ6M0FcFji72P7esmajLrT9DOmBCGZUDLoMOSVZ+wpIAiUXdW/4dmZfmS
         MqACCX7PV2wI3r1mxYJ0gDBwWzg7x0RD4Qwq475f/oHPkXDN/K4k7FRtNucKKrd9P1m1
         8gwaC0okFmqUobCmwZKTU1bDi/8nnkVtH5TiH753QXs2ZX6B8HMzM30RcwYrooyf/CU7
         42odKe5ix4UfGJC8kLVN3uD7y3Q59PzhjB7VMo9QIfB99+LykhXCNwP40kQRhIE3+5u7
         gMSw==
X-Forwarded-Encrypted: i=1; AJvYcCXkQmafZnshX+yhSOMIN5sQCCqOJrylqY1T3hyHcHY4YaP0RHSa2n0j8wqYY5msGobbEPJeu1Oe8118FS3RJIvU2v1aewFuZN9MEgO6
X-Gm-Message-State: AOJu0Ywu8IHqAwy5H/4xmc2IemTtEG1YNnOxR3nmTmwbfA44Rry/ioXF
	+fQW8F7ZKKTauRK79ZaL729vW1YNtbJ7uCWRE1eW/ni/6SABmqCA8wQGOHRorPc=
X-Google-Smtp-Source: AGHT+IEMu3/aehjdG/+D5Th8XKPTWx4YIxNxfkzwGWAMFbqK51uCSEMK3xQk34IQS25GgcbOud2Llg==
X-Received: by 2002:a50:a456:0:b0:56c:d20:22df with SMTP id v22-20020a50a456000000b0056c0d2022dfmr609112edb.20.1711399533304;
        Mon, 25 Mar 2024 13:45:33 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:33 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 15/16] net: dsa: vsc73xx: Add bridge support
Date: Mon, 25 Mar 2024 21:43:40 +0100
Message-Id: <20240325204344.2298241-16-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - remove forward configuration after stp patch refactoring
  - implement new define with max num of bridges for tag8021q devices
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 9d678414f3ca..5bfb8aba7428 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -691,6 +691,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1585,6 +1588,22 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	*tx_fwd_offload = true;
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx_portinfo *portinfo;
@@ -1708,6 +1727,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


