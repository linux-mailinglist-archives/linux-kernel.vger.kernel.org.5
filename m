Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4679D104
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjILM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjILM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:27:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D12510DC;
        Tue, 12 Sep 2023 05:26:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so94669131fa.2;
        Tue, 12 Sep 2023 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521615; x=1695126415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgSiRWdgC/hwg8MbvdGK6CbTNx/MfKCBd8+7AqLBFRs=;
        b=DBrGfpj0YAPt07jvbvXQLELOhfXIg+GNvApcKL5krt20XHcuLrl6vLY7HbCG2zEDLb
         glXZOArZvJ7WRF0lLJknFLW2eyFabvp+fLxZgO2OMwdgD/4CsKu4MS7MfmqWXxuOFmNx
         PrLtSNzu+e23NbKwQoEEB3xfkFmaB689C2i5TFuxS6ENipsoHFnKubxZHbntL9LstDL+
         8EjU8KJvWXqgt33GcGRXCpbgNIxRL9amSit73dOdduFM10UePeZKR3n+EA5HojjRmw6n
         AE9ZHaWo+a4LQIiAQgp5tdjapuLKw/9wZRnRc6imJ82YZ6YJiauMtOJYBEg/rBkDHOfD
         RsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521615; x=1695126415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgSiRWdgC/hwg8MbvdGK6CbTNx/MfKCBd8+7AqLBFRs=;
        b=Z2qcqwou0lcaMUq60S31vuRIQ2NH+BqNNGD6nXM/FW0gcZ1RvMFydP0tPoI8TjF4Wa
         7w5pMAFiPJQF3/yCFHJ+Pn0/KHN/YxnfcA2BOb1ONCFNyvhlR3eQOBgHBAgTpc00x4dt
         VL6uy362JDM3zufOy2DqKUTze/BaCX/+8ebduVY+oMJITGiF9fjzBRjMuHhDxdtOOT6m
         FRw1Q5Rep5riURfurI7aqARgHf0/sclmEnRvoU65L9MiE1hu5vK9SPVS3gC34k3ZtBaa
         J99rXK/e8xX92p2EVAgjiRp9FIFp77KPNJ74tTM3LaGUIomvKKcsWeNqRd7N+qOZS2xn
         x3ag==
X-Gm-Message-State: AOJu0YyZ9Gul2twK2otTFaJWDG3+AZk0xiSdNvscQGtG+jPA8pYd8f9+
        49sPGuwgABBqycLQdjhvxz/mJXNENn4AaQ==
X-Google-Smtp-Source: AGHT+IGM/fX1K476MGy00gQkMLyz6VufQElplzFwP3q36tEsF6yt9IDNWIw4jaX3e7K7+EHKOgCQQA==
X-Received: by 2002:a19:8c4b:0:b0:500:d8d6:fbe4 with SMTP id i11-20020a198c4b000000b00500d8d6fbe4mr9195198lfj.49.1694521615356;
        Tue, 12 Sep 2023 05:26:55 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:55 -0700 (PDT)
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
Subject: [PATCH net-next v3 7/8] net: dsa: vsc73xx: Implement vsc73xx 8021q tagger
Date:   Tue, 12 Sep 2023 14:22:01 +0200
Message-Id: <20230912122201.3752918-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912122201.3752918-1-paweldembicki@gmail.com>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a simple implementation of 802.1q tagging in the vsc73xx
driver. Currently, devices with DSA_TAG_PROTO_NONE are not functional.
The VSC73XX family doesn't provide any tag support for external Ethernet
ports.

The only option available is VLAN-based tagging, which requires constant
hardware VLAN filtering. While the VSC73XX family supports provider
bridging, it only supports QinQ without full implementation of 802.1AD.
This means it only allows the doubled 0x8100 TPID.

In the simple port mode, QinQ is enabled to preserve forwarding of
VLAN-tagged frames.

The tag driver introduces the most basic functionality required for
proper tagging support.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - Split tagger and tag implementation into separate commits

 drivers/net/dsa/Kconfig                |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 48 +++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index f8c1d73b251d..120bc3ded9f2 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -126,7 +126,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
 
 config NET_DSA_VITESSE_VSC73XX
 	tristate
-	select NET_DSA_TAG_NONE
+	select NET_DSA_TAG_VSC73XX_8021Q
 	select FIXED_PHY
 	select VITESSE_PHY
 	select GPIOLIB
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d9a6eac1fcce..bf903502bac1 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
@@ -589,7 +590,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static int vsc73xx_setup(struct dsa_switch *ds)
@@ -664,6 +665,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	mdelay(50);
 
+	rtnl_lock();
+	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+	rtnl_unlock();
+	if (ret)
+		return ret;
+
 	/* Release reset from the internal PHYs */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_PHY_RESET);
@@ -1412,6 +1419,43 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	struct vsc73xx *vsc = ds->priv;
+	int ret;
+
+	if (untagged) {
+		if (!dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+			ret = vsc73xx_vlan_set_untagged(ds, port, vid, false);
+			if (ret)
+				return ret;
+		} else {
+			vsc->untagged_storage[port] = vid;
+		}
+	}
+	if (pvid) {
+		if (!dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+			ret = vsc73xx_vlan_set_pvid(ds, port, vid, false);
+			if (ret)
+				return ret;
+		} else {
+			vsc->pvid_storage[port] = vid;
+		}
+	}
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, 1);
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, 0);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -1519,6 +1563,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1

