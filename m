Return-Path: <linux-kernel+bounces-64435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA6853E46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53324284B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6747765F;
	Tue, 13 Feb 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO30Vd2S"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C67764A;
	Tue, 13 Feb 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861981; cv=none; b=S5Na0rNvXwKqUyClSPsE2kwDPjk5eL66B6lJfT3+L+dsaVHjM7Q0Y1L2xaVnwed8wtZypwahuSCnGUo1cOVgs7zsP8yF/P847AjBfOFx1jZMoR4Rx7Kniy9vlGfZjMVVQX89vAjd1ZVyC83f/pEeSYcf81tCYj39NY66HIi8Qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861981; c=relaxed/simple;
	bh=t5Q6M/UoaVsi7X00J7NumI0UnmtqZT+dvCNVTiQagf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUSPxvRt5HGTN2Twvlz5wHwnLJcdeNdm32h5/4gpSx7CA1FeZXyHgGI2WMC/rgIv8sYsr+P+ER2n/OBRisHYU7w/XW7vrt+8OnolbLtlGV5OZaT2JviCfvVOCW+PaCXVJTEOsbU7bWB6/YaaS5ypr95ag/k19fo/WQ8pBVZ0D64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO30Vd2S; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so6431449a12.1;
        Tue, 13 Feb 2024 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861977; x=1708466777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfZ9Os2zb9RyFiipFThksRCzRqGevVK9igii64D1Y2Q=;
        b=FO30Vd2S+BfeIPNTWA9vGw/ywpZ39RQp9M15jUADxrUDEmuNYfkftHhzfv6/4nxEyo
         0GyYi1CNWx95GDG56yMqjxbM+IeAkSOp55J7rKYz6QTze8wV+7y46SjEJvq+pMhwcJzw
         +zJuM5bZNe+sKzcm5nKrj4bqYWZWJBVAC898XwG27EhtPzOHZrs83KK/p74gVCyf0E/p
         z9InfZL/5BJfJNZRrxYIHQrdaCKEaDmLn+VdBwjJrXUa/38ZZXi6uBdHnNyggU8hXYcZ
         71FcHHBK4nBtteBuZjHYfJ9KffAckMaNANywD/tFxAMZqg9O5jBmjcdgfbPL87BmAzI6
         2IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861977; x=1708466777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfZ9Os2zb9RyFiipFThksRCzRqGevVK9igii64D1Y2Q=;
        b=jyTpvhzg0J3sfjFojM1ZFGm1PHV2i8yOc7JcZjgGvo/3dl2uj+nyhNPaDZSDosn0sm
         f4660EHVWHON//82tFbPeEMMmFncLSNNHEdERkLAvWByYNDC8evM5VWu3fW9M1ALnDhP
         1Jr6K+agE0GPvrUesqzNs0+MfkI6NhdsQWNqsxl5IoiILLwdSnr+CBsX/20KHMF+0Mfs
         PJi3PXWX9CV2S36lAVOV8orSUvR55K1NO64OFd+3lsG7XZUt3eTI0ER9mQX+1RanZ9QT
         SqifqyGx9ULUDKEtYiM+k2dOqIG1ICXFiGqoIU4iCncyGN/r8UuC90rh1vDJRFOq/T2d
         mhhw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+vHVKPY7mvqdTmoyiYh7Ht909JkBmtE86JJTJamt2VJ0ckD5QQO81xOwRa1Jg2StK8JRySdE6D7lsb9CEW8biqtvtPz5MnnqhKO5
X-Gm-Message-State: AOJu0YwjV6r7QAmfSkKu+X/0fy6/2jzm6qGlybsNG5/xhCFDegwVDLlW
	tLNzDVfd8h3MbHXub+DHER7IYOONJNu4SWSPpcxoPUJa9NMrCIkd2x34hu2YCb8=
X-Google-Smtp-Source: AGHT+IEwtdpk55uDslVpOwrs5rxinxSy17YGrsurMotrSsgq+pIKKHQ396gDqGUi5bi1nfHKiWFtag==
X-Received: by 2002:a17:906:7199:b0:a3c:f91d:ee10 with SMTP id h25-20020a170906719900b00a3cf91dee10mr425752ejk.5.1707861977153;
        Tue, 13 Feb 2024 14:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6RqQz2uCAeYoCezfNB55B61g9qnT055Q+w6LgTYjMLmCHJDRKeqaCjh8Wks6guhNtKuKKKpwUQmp5MtFI2aV+RH8B3c4maA+Jtlu2lYtRIfsxXIjO36WXNTx1/p4a1CGo6IhOJAkCP12sKGD0SeX0AvGWwHnfzm/4yZU9SfLSXNOsDFuFO7JikvTQfIZwETRN1rF7OqK5x1ej3ZZKe4X2/ctbXMIPob8mB/O+jT7JyLwURQoLDt3KSNtJZ6eEiDYyYNuIObM8VOuoQkXGuJMLnKh3XCwKXYq7QRyzRG6MtGXIw3GIBCP0VA6tdZCvxGh7JHgx/ms9Uc/qNP3sZE64R0v9M+CywwE3Gxw8iLNKrWDsz+LJGN5tp9GMdgQPRwkeBz5rK6BHqUnvYRcwawr6x4MaOz9wfeM9vAW5NSzAXxPWdHHcniXtk/TYFX9cEBzoQOf/dksHiA==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:06:16 -0800 (PST)
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
Subject: [PATCH net-next v4 13/15] net: dsa: vsc73xx: Implement vsc73xx 8021q tagger
Date: Tue, 13 Feb 2024 23:03:26 +0100
Message-Id: <20240213220331.239031-14-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v4:
  - adjust tag8021q implementation for changed untagged vlan storage
  - minor fixes
v3:
  - Split tagger and tag implementation into separate commits

 drivers/net/dsa/Kconfig                |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 38 ++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3092b391031a..22a04636d09e 100644
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
index 6c7bd1c200b4..9f94ae8c763a 100644
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
@@ -588,7 +589,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
@@ -670,7 +671,7 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i;
+	int i, ret;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -739,6 +740,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
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
@@ -1504,6 +1511,31 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	struct vsc73xx *vsc = ds->priv;
+	bool operate_on_storage;
+
+	operate_on_storage = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+
+	if (untagged)
+		vsc73xx_vlan_change_untagged(vsc, port, vid, true, operate_on_storage);
+	if (pvid)
+		vsc73xx_vlan_change_pvid(vsc, port, vid, true, operate_on_storage);
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, true);
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, false);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -1632,6 +1664,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


