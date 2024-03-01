Return-Path: <linux-kernel+bounces-89181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4786EBAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B01F2385A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708E5B673;
	Fri,  1 Mar 2024 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7X+RHrq"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BE5B5DE;
	Fri,  1 Mar 2024 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331473; cv=none; b=dvz6fPzW9fs2o4B+4wsJ6yS5O7kmbsS5G7DzMLPymph8qln1qhljLND5KPsMHUOUx/RHISd7FC8+2ZF+OnTOtKCMaeEmxd4jFotNg9o7Rppgbnw/PD55kTpDTLAd1S4irInpjtA/aySNZJmGvPJ8NLM8SukzaqDwyI4zqKWfRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331473; c=relaxed/simple;
	bh=vDrl10Ha6ROxrXIkoog7fre3HIJoCxXOX2Kvv9JHM9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhQ6N5WpjwdfLdKLdr5DbuVZP4EvNFgxEn0T5yI2ms9NzGw8e+CadBRLVo7+TBYGW1C+2T/kyXIKb3cTnmEGrmseQD0rm0XWYlo5/QWRUqLT4QJlzOgn6TRMBeF9Hsb6GjB2yrzmmaoFF3GbR1HaSgo+S7V1blRbVU5vGKqrSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7X+RHrq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso139712866b.0;
        Fri, 01 Mar 2024 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331470; x=1709936270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flIukc0OLjZlVsp2pS8pjLIhLLZZrkUNTCljng+ImU8=;
        b=X7X+RHrqMKmuUZ6Ez8YskMfkPJkD2R+CJkrgPr0LYolhCK8VTypDjFj01R8fslQQQI
         6RuLUg0sLV2E3M4P15FWuZ339O05BStqHzL8aP85zG4B53tUeBbVhT5rvlA+EyH9W31C
         VlAeveS69RwmQvoB9WLm6usuoD+GnN63X4WkmNc9jVIBjfcBgrkexee4qlNRcd/8hBf8
         4ifB3AkxDyCuEGocQBH08H7sDtuQ7rcPrEZBJ3Cwra33Osly/pTkdod+hovyEdH7AeA+
         slzhUHHiAe3hmVwVMSd1sBj9f6y8SjtCpcK3rlogQ2Ly2cUdUIv5i9ffSHcg9mogX/Ll
         Xj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331470; x=1709936270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flIukc0OLjZlVsp2pS8pjLIhLLZZrkUNTCljng+ImU8=;
        b=YVVCATP3iDe8XGEcr7ibTdhNKBOnsHsCsKzQwx/1G0rtPnuLkcC3l31WqR//pqQbLB
         /nfcrHNzSSF0+5ifU7lxcPlwDKMnlH/109UwWAsSfNr3LM/utH92lc+Bbayf2LXy5JAv
         z+ct4KP6dwPvPrwgJwCDK/3sQ/SwIvpdFdI6MJr1Kfc6H8+te3H+eFdG0IUfikYcFl99
         uvf2iHaUY743MHdOexFcH66qEkSIxHaAZ51ESDG0p3PgzGXT4d1xeXnptbXvN+0j6u2k
         3pwdoF3VYCWej6RBNbDwCnFdSbKUUGcG+MrfYVQlxFZ+0tT+LwI0dvbleiP4f2LUI5NO
         N/qg==
X-Forwarded-Encrypted: i=1; AJvYcCVbe79G00ru4xN0yKplQUjrD6rC/oTJc3LwrUrGhumtiXWtjnCKW2c9CNcnFK+AC0T1oEuHeCYzZfWvJtgtn7E4Z8mej3Yfh/8vMvFh
X-Gm-Message-State: AOJu0Yy9s8d5k1HtL7eiWKqCYROQl8GEDJIFc/R4Ohn+4f4WEXHxspDE
	yfdw1zlSQTsYfXx39jcgHZirX5TD7Y8s7JixJ03+LL++obVkMKNdJVbRX3lPgmY=
X-Google-Smtp-Source: AGHT+IEV303EzhuPOBwj5dMroP3csOKln7pMzBWFRCxB4aRHQGOBrFuQWJSum3Kv9bhp2w/3UPlIEA==
X-Received: by 2002:a17:906:3b0e:b0:a44:4ed8:6a53 with SMTP id g14-20020a1709063b0e00b00a444ed86a53mr2047732ejf.29.1709331470300;
        Fri, 01 Mar 2024 14:17:50 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:49 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v6 06/16] net: dsa: vsc73xx: add port_stp_state_set function
Date: Fri,  1 Mar 2024 23:16:28 +0100
Message-Id: <20240301221641.159542-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
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
v6:
  - fix inconsistent indenting
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
index 425999d7bf41..d1e84a9a83d1 100644
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
+		return;
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


