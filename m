Return-Path: <linux-kernel+bounces-79165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C583861E64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A0CB21665
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1DD14DFCC;
	Fri, 23 Feb 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjJfLlRb"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F8146E71;
	Fri, 23 Feb 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722138; cv=none; b=kk94k0a/AgQgCL3NytM9xkBtoAFymr82BT6f4qXG12/9I89+5B7dTc7V32690OA8YEq7VGl2FFEnsbQ0zCxxY7hNvAWGRD4vclpOF2SEjDBVy2URS9DmQpKFIYntP3owaooL+TiIHLXkzRIUExr6v6ub/jxGVB7gQkiuhJGUZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722138; c=relaxed/simple;
	bh=IUnbtBh/jU7L8ituS+NKI77KKtYzeb3KBPhVBtjGX9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1pr4di+LxFxMAYXUF3J2Qf3sYihw/DZROHh1nidcUwurLhyUZ7nENTzZKIVAhfRkvSF/5/kEvgenuOp6Mp8ofEN2ql5t7gpBX2Alh2jAkTUa8zPlp2zDfHhv5y14OQ/fH9NJ8zFF4lDuGIIBFQP1OtVmviJmjTlfgxd0p3/9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjJfLlRb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso1563422e87.1;
        Fri, 23 Feb 2024 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722134; x=1709326934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmSDk0c3liZ0FTN/I0gFbiEYHUdcrbT6AD0dmbXbwOI=;
        b=CjJfLlRb4i63vq+cXiiB8rKMfEm5wsbSGDJeWcVAbNBJMW8j4WblNnHVid4yN9W9le
         hwD20dthzP4pWDq6paB05Yt70dmizotE2J5NACsUVZgCb0rF2Q+whOxsm2ZIs0PkfxyY
         L3RYun7HFWjYGCdB4hcjC6ycRRLS7Rk3sO+4HFaT5twKEqGSleRSFFWF6PULHs2vFADE
         zDi8fYToAGKJVx072BjJC9sWZzDt3TUkO61r+kioEKYegp8FBktjH1OWxzOlV5KY2/V8
         Gr1z1lmYYWieSs4GwabVT64VTDWHxRn984/6Ic+MXs4QCGYhcJ7jhHEiYENFZmNWStBh
         Nybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722134; x=1709326934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmSDk0c3liZ0FTN/I0gFbiEYHUdcrbT6AD0dmbXbwOI=;
        b=opCKGBvaip6N8VGKB/clpnR0jfBMuYmKHPkoehfU9hIn3sOPOFDvdBZp+GHTL0fCMV
         nFq2UyUQS+XLYRtpwG4QQtzoaorVG+fXfWSivxpjZ7iTAgSNuAltQKIEIpmIt4XP12pk
         bvCnIPQpS1ONuFOFWTM97I6Py1ABoEKVWNGKh1uLxCIt//cCs9/hUQjB/ZEbs1ejGMjU
         IArgoXlzGRTcyfIn5dVRV4N3jHHJcn14pb6ENTQ/4NylTOMzkNHM+DzJgp2uPsCk1a5U
         bL4XZuJEzrYXiwdsmnHzJBG5LUFDYScVrjhFzdJLo3R/qrWfCMlM9IL9cN6NKC46NoPw
         3qTg==
X-Forwarded-Encrypted: i=1; AJvYcCWRwO45njiqgTD6oIvqqB1t2kCiXF4V7uWItqZLVQynaKYKPuH3O0HYVsHUYdsAGDiNGorwbQYzRnaH2A2071Z19BQgxeikRMcnGnku
X-Gm-Message-State: AOJu0Yw3/FF0fmfWZ1cQqGKLSAdZk5VGXQ8ge1If5GE8DFDHYjMwaclP
	ft8dnWSuC/M7N70oNjYIctIBu9XX0VjIP1t/ywsCpfhMx4bxOk3izaWH+vrPTuc=
X-Google-Smtp-Source: AGHT+IFbDZzCgqCG02LpbKUr8+Lywgq+0F3Ytefd8LyP+AzgpNCX1OPXjxUU97zY2c/MQyK5Jvrb3g==
X-Received: by 2002:ac2:5970:0:b0:512:b362:e790 with SMTP id h16-20020ac25970000000b00512b362e790mr546591lfp.34.1708722134333;
        Fri, 23 Feb 2024 13:02:14 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:13 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 06/16] net: dsa: vsc73xx: add port_stp_state_set function
Date: Fri, 23 Feb 2024 22:00:36 +0100
Message-Id: <20240223210049.3197486-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - remove unneeded 'RECVMASK' operations
  - reorganise vsc73xx_refresh_fwd_map function
v4:
  - fully reworked port_stp_state_set
v3:
  - use 'VSC73XX_MAX_NUM_PORTS' define
  - add 'state == BR_STATE_DISABLED' condition
  - fix style issues
v2:
  - fix kdoc

 drivers/net/dsa/vitesse-vsc73xx-core.c | 99 +++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 425999d7bf41..c3ef4c22f687 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -164,6 +164,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -623,9 +627,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -785,10 +786,6 @@ static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
 	/* Allow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
-
-	/* Receive mask (disable forwarding) */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), 0);
 }
 
 static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
@@ -841,10 +838,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_ARBDISC, BIT(port), 0);
 
-	/* Enable port (forwarding) in the receieve mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
-
 	/* Disallow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), 0);
@@ -1036,6 +1029,89 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
+{
+	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
+	struct vsc73xx *vsc = ds->priv;
+	u16 mask;
+
+	if (state != BR_STATE_FORWARDING) {
+		/* Ports that aren't in the forwarding state must not
+		 * forward packets anywhere.
+		 */
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+
+		dsa_switch_for_each_available_port(other_dp, ds) {
+			if (other_dp == dp)
+				continue;
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + other_dp->index,
+					    BIT(port), 0);
+		}
+
+	return;
+	}
+
+	/* Forwarding ports must forward to the CPU and to other ports
+	 * in the same bridge
+	 */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
+
+	mask = BIT(CPU_PORT);
+
+	if (dp->bridge) {
+		dsa_switch_for_each_user_port(other_dp, ds) {
+			if (other_dp->bridge == dp->bridge &&
+			    other_dp->index != port &&
+			    other_dp->stp_state == BR_STATE_FORWARDING) {
+				int other_port = other_dp->index;
+
+				mask |= BIT(other_port);
+				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER,
+						    0,
+						    VSC73XX_SRCMASKS +
+						    other_port,
+						    BIT(port), BIT(port));
+			}
+		}
+	}
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + port,
+			    VSC73XX_SRCMASKS_PORTS_MASK, mask);
+}
+
+/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
+ * forwarded only from and to PI/SI interface. For more info see chapter
+ * 2.7.1 (CPU Forwarding) in datasheet.
+ * This function is required for tag_8021q operations.
+ */
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
+				       u8 state)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+
+	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
+	      0 : BIT(port);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), val);
+
+	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
+	      BIT(port) : 0;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
+
+	/* CPU Port should always forward packets when user ports are forwarding
+	 * so let's configure it from other ports only.
+	 */
+	if (port != CPU_PORT)
+		vsc73xx_refresh_fwd_map(ds, port, state);
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
@@ -1051,6 +1127,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
-- 
2.34.1


