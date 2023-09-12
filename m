Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D250E79D103
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjILM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjILM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:27:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE910DB;
        Tue, 12 Sep 2023 05:27:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007616b756so9160286e87.3;
        Tue, 12 Sep 2023 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521620; x=1695126420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvJnLKH3iVusfXwT0xX8TegBSkGglWIW+YxRLtmLGrs=;
        b=Efg6KtBB/rDCG00i06B/5BDBYIwZ4YMloP4dZPUXt8bTkACQ/9+0hAT1gZTpyVAT7T
         9kp6tLcIgS6iLt/wVbjFTLg56ub4wlY6JKbbSFahHmF78tawzQkZD10lrDWpB8nRnfa1
         HUpm+Z2CAI9YYCmnLN1FTgV2MIuvJLPQ919cO9YG0UBcd4VYTxDpsleissa3K/MSBDWK
         5lT1dJV8le3ARn/EBDUbLysumiMdwsC3S0hojTZv0sfFCw4y4TjmB/S2theGiEpam9VI
         D8LSLYTBUt3AZOXEOR2s8peLpo00EhmKltjDXvK7MySGBgVVFwZN7zTL/1pm7VBb5WMI
         vO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521620; x=1695126420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvJnLKH3iVusfXwT0xX8TegBSkGglWIW+YxRLtmLGrs=;
        b=qigOt7ikvH8aVbWKOcVgKXcFr2oHdA0xHPv51RDeVAAGcOos401Efyug1D+NyRLF8K
         pd7A2Esi7fAOTvtUVEEoqOOcauHtFY6GOJGfEb/9Ekc7rn52fNtaqRdcWxpzGmikdSC6
         ILFsZCNOmsTqQaX59hIdF6dc2BLF59eVqnWTPApiYhq52kd6Eg6b4rqKwpX+BB9wx5yH
         pwLYX5y8OJGbqvF51LpEDBuk0qhHU2XzZKM625kS6n+hIL22/xcYcpCTn28VvY5MYnuL
         3Qa4NBoXNo62sGvYMcDmDi7xCd0bPQRBjGZDxC1NtR3qvDZ2B1AOrgc1Y+7BeirBBLoK
         RFug==
X-Gm-Message-State: AOJu0YwRAea+VCxxCJNF+B961kE7CXBn+VEa+oLFONBdPzkZzkVOOUEO
        aSYEhQvg4tfHVEWqwe5+yBektrGEze8MYQ==
X-Google-Smtp-Source: AGHT+IFFrPGs5s80pFW/Ru+TxpbORaPe12iwLWa4jd0lrL6+9vIFjMZu626zo0YT7MoBtUy1NSGuow==
X-Received: by 2002:a19:8c4b:0:b0:500:d8d6:fbe4 with SMTP id i11-20020a198c4b000000b00500d8d6fbe4mr9195419lfj.49.1694521620090;
        Tue, 12 Sep 2023 05:27:00 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:59 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 8/8] net: dsa: vsc73xx: Add bridge support
Date:   Tue, 12 Sep 2023 14:22:02 +0200
Message-Id: <20230912122201.3752918-9-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912122201.3752918-1-paweldembicki@gmail.com>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index bf903502bac1..9d0367c2c52c 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -600,6 +600,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = 7;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1456,6 +1459,73 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, 0);
 }
 
+static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
+{
+	int i;
+
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		u32 val;
+
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			     VSC73XX_SRCMASKS + i, &val);
+		/* update only if port is in forwarding state */
+		if (val & VSC73XX_SRCMASKS_PORTS_MASK)
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + i,
+					    VSC73XX_SRCMASKS_PORTS_MASK,
+					    vsc->forward_map[i]);
+	}
+}
+
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+
+	*tx_fwd_offload = true;
+
+	for (i = 0; i < ds->num_ports; i++) {
+		/* Add this port to the forwarding matrix of the
+		 * other ports in the same bridge, and viceversa.
+		 */
+		if (!dsa_is_user_port(ds, i))
+			continue;
+
+		if (i == port)
+			continue;
+
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		vsc->forward_map[port] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(i);
+		vsc->forward_map[i] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(port);
+	}
+	vsc73xx_update_forwarding_map(vsc);
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+
+	/* configure forward map to CPU <-> port only */
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		if (i == CPU_PORT)
+			continue;
+		vsc->forward_map[i] &= VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(port);
+	}
+	vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
+
+	vsc73xx_update_forwarding_map(vsc);
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -1557,6 +1627,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_sset_count = vsc73xx_get_sset_count,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1

