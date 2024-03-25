Return-Path: <linux-kernel+bounces-117978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C75888B1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D221F63ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E381272AA;
	Mon, 25 Mar 2024 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZKCIos0"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84C126F05;
	Mon, 25 Mar 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399541; cv=none; b=OjPDVGbfSdPr2I3HS06V1IT82MPLP15A9z+U23MJm9QCUrHW5eXJr80/6bok8xxN6hlD0Y6rJtn9/y4jHADbj8MpLkAXeQFsvNBdSlqQbGFI1HiKube5p140x6Xi774wn1MxGVDr5BhV1CEkINYDTYK3S0/LfFyWTmZ1S46wEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399541; c=relaxed/simple;
	bh=msFwLUgoInL49KijPQT3psq55laeDSaMjfTc1uVOExQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmafQ2lHcLpr4bIFCm1TGWlUzv69AOe2pU6wxcO6V9+954DM2nr5GyGWpbxKdda3lT/8Z3QPmDKN+4zpH1gDPYhwv0O+m1CjeObyhxYVrX7EhoH9NF/nvJOcPpo2L93QAPQIuZfTY+nelGCGIGV/brRVij2+rikE9NKPHt0Sw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZKCIos0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so5954206a12.2;
        Mon, 25 Mar 2024 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399537; x=1712004337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es8X5rKWvUhOVlQ7heJvrLyXvex4sJ4OBGyiyZz9Njc=;
        b=YZKCIos0TEMt3OHDb7PWzSNVYzGk2s+uTxr/fJpBsGp7e7wsOBCmVHUwj16q0xTefS
         egCR5Jv1bKhAre6HKc458/IKxvr7LpGTtOUbHT/f1hWdvlh5t/vKJKlZyAK4y7KQFRWa
         bjAYoaeON4x4riOK3kBvLcD7cE+gXl6yyRKddHVG+VyPHPGULT4ggBoFpE2beezzxMef
         BcZ68pL8hxtMFDwCSCvbnKA044sURb741TuNr6dHzwFPk7mr0/8+Ml5r1X1vsegGjueM
         FND2l5E1B7bhDv5T+3pcQlvIMXkYPuXQ03tujye3Cwp5LKqDoX2XI8gCLfnEnOXNfUM0
         bwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399537; x=1712004337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es8X5rKWvUhOVlQ7heJvrLyXvex4sJ4OBGyiyZz9Njc=;
        b=ZzyKKeiNNTB2oGT17NVSy2LfTJ9SxUv244+oFKBrRrF5rlwu5EgiyOaWsJ7uT59PUv
         Ms5uledj7HpxGfNXx3hEwRj02UDtioClZNtfjlb6cdyOoC53BZ5IL3slgM9FgxugAQE7
         9wB38k/wixxDIuLlhn8IR5Q5afHW9rYSXk2jGAjqn3AvqxLFHJhPQsNm0Xfx2tOQogJB
         rEOOVKdDWDINPWtxxK3ZdPGUua0Bi8cdcdOQDDb1xmybsWOG4Qyke8Q9nvsowkCjFHS7
         qsdHGL868sdaID+lgWE4EaOW+kgMZGEmr6j3s44KFBQk/rJrgdklJNwAHLBMKVkswCqG
         f/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUvt5i2ljoCv82jnqD9HbWMzCIa5t4PeCkNuswDwVjRiCasDa4rzzgM2oW/xxaxX+oQmZHaFXlkE4woTNxkyy7+VmWpXBGzpCzAy0M/
X-Gm-Message-State: AOJu0YwZaIy8sRwZg+FFMp8RNyaS9JoaedCu9+/bkSuorxHQqYM6W4sH
	9qBKeBrfojQijzGEV0G7Yfov/dgu2uI9IvUPgpNpN3PSHw4r8rSrt0q2wPuhYNM=
X-Google-Smtp-Source: AGHT+IGAMnjq3J0/O7f3rW1mKQF1cazGi150PHih2hz7HvEBnpeqOORATCMj5xfrL8v2v42qwrabYQ==
X-Received: by 2002:a50:9352:0:b0:56c:274a:31df with SMTP id n18-20020a509352000000b0056c274a31dfmr277188eda.5.1711399537360;
        Mon, 25 Mar 2024 13:45:37 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:37 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next v7 16/16] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Mon, 25 Mar 2024 21:43:41 +0100
Message-Id: <20240325204344.2298241-17-paweldembicki@gmail.com>
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

This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
which are required for properly treating the BR_LEARNING flag. Also,
port_stp_state_set() is tweaked and now disables learning for standalone
ports.

Disabling learning for standalone ports is required to avoid situations
where one port sees traffic originating from another, which could cause
packet drops.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v7:
  - added 'Acked-by' and 'Reviewed-by' and improve  commit message
v6:
  - fix arranging local variables in reverse xmas tree order
v5:
  - introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 5bfb8aba7428..8408f86d0936 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1588,6 +1588,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					 struct switchdev_brport_flags flags,
+					 struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsc73xx_port_bridge_flags(struct dsa_switch *ds, int port,
+				     struct switchdev_brport_flags flags,
+				     struct netlink_ext_ack *extack)
+{
+	if (flags.mask & BR_LEARNING) {
+		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;
+		struct vsc73xx *vsc = ds->priv;
+
+		return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					   VSC73XX_LEARNMASK, BIT(port), val);
+	}
+
+	return 0;
+}
+
 static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
 				    struct dsa_bridge bridge,
 				    bool *tx_fwd_offload,
@@ -1693,19 +1718,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				       u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	u32 val = 0;
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		val = dp->learning ? BIT(port) : 0;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
 
 	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
 	      0 : BIT(port);
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), val);
 
-	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
-	      BIT(port) : 0;
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_LEARNMASK, BIT(port), val);
-
 	/* CPU Port should always forward packets when user ports are forwarding
 	 * so let's configure it from other ports only.
 	 */
@@ -1727,6 +1754,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_pre_bridge_flags = vsc73xx_port_pre_bridge_flags,
+	.port_bridge_flags = vsc73xx_port_bridge_flags,
 	.port_bridge_join = vsc73xx_port_bridge_join,
 	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
-- 
2.34.1


