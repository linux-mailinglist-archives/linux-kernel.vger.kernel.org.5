Return-Path: <linux-kernel+bounces-53041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4853A849FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5282B24095
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917345974;
	Mon,  5 Feb 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEh7YN0P"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FE40BE7;
	Mon,  5 Feb 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151750; cv=none; b=MwkERUCJgMyqxSOgWlf+rtik7Fyg3a57C8cWmRHIaNZ99h8/atgt6WuktTV/182R+YOYpe5eJfRz1nCpXSTZCtuyTP8T7S2l2dzN3V6sk8fhiUP7BMpIfrEFY79FbaU3s9zrVZrWPXyhHQXIG32b9YDOxblx/0FfqUuA15+NrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151750; c=relaxed/simple;
	bh=Og5Cxg2unNdb74R5cOmUSglesmMWnLWZ6HhHgIx2ia8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB1BYVpqaxMXwsQU373yy+Uqda/WCEslQN8dTrsgzKNpWdkAuM0Jh9Y6mrJJMcR0IUo/jcB2/bnKqXTTp3MVbCLW8V/Nve8csR0VQ8WLOOjDTfAoucS9xY5EJFN1n5sJGpBlRRCymsW2I7yfZ89tqpIJjdj5YJdAquF1C+mvxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEh7YN0P; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5112a04c7acso7437600e87.3;
        Mon, 05 Feb 2024 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151747; x=1707756547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOdvH1bIIsmqoTot3Fl0cDk3IRpxfG68ITGLhwsu3rw=;
        b=BEh7YN0PO1uPHbZbCC13KGKz9lGbLcTWqK57Vezlf9BmZpen4rnwhZUrqXHpZWK9V2
         VtbwE9QbaqzIghTJuOIjad9QAoaKu2rOH3Uu0e9DPbRrGvd/biuGJt8AeU2V82ZADsTZ
         Kod8wkv1YFFfEvc2HSpEDyXzypUp9UkcL2pxZ1eEznY8EmIHFiJ1zslNp5T1ENulTeNG
         /oIp0F2wJnLyBAELXvu1fQQOMXA52XeR1pD7EupsliPh6ow7hjMxFUXafsG981xlknEp
         P5A/gHYcVcnp/onTBVuZxXHwLRDZesMO+Qw04qS0UF+TL5qAy+Ib9yYiwm0NZfwNBbhm
         xlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151747; x=1707756547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOdvH1bIIsmqoTot3Fl0cDk3IRpxfG68ITGLhwsu3rw=;
        b=j6JUVqCGnB1HKnUvs9TeL4N5F+8qNBiYKrDFzXdOan5+UFJLT2mN3VSyn/mbocjGEz
         /wgyNvHlfw43YgJ6ParfSdwI6jBw7eFHrG+QlgK4DjxOBXDEXfbnHzYBmzzdc50VnaNt
         4Aa5kfy2BxXkXqsA9Cb7iroY4VVp4+WeD6uZtsrNxKxaDI7Cfnuc5zFDO6mA1Uu9uWax
         9ydVmjtOvizWwM7j9Tq+XZraJk4dYXeb3OUDYSjsvYYek+raJ238y63JZdi2K0vwZp1E
         i6nYGsW4WEcWZy9XAcjXgc2/tlctl4Uet+c4xdWM4sCaawCe8DuD0dLwuA3yvn8a4RTB
         LDyg==
X-Gm-Message-State: AOJu0Ywy4kN0lYn53gdQaQz8DhOZQJ/m3Yo4Fk06b7gValn0claShiAh
	ewXI1cNncfXazePktbz2L2ERp9TvXNvd8lx0doT/sVNK2kbdaokg
X-Google-Smtp-Source: AGHT+IEMD06ygfXVcu9qumaDiOb5730gV1sMXVwFlTtwSaAjXb6/utNw1v9vr3cW+LES0GLzTNwVeg==
X-Received: by 2002:a05:6512:3b20:b0:511:4dfb:17d8 with SMTP id f32-20020a0565123b2000b005114dfb17d8mr132377lfv.40.1707151746614;
        Mon, 05 Feb 2024 08:49:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXm2T+gGul4pDsD/F3CnTbKDW3yrsyAl6RfkK3AMmUpDuv9BQLTd3lW340Zjbncr+SAgQ2AHBQkQ8XfknrH6QcUJWEfWvgMUWZVSe7Et6M/ihHSdx/Zy2HmveFVKcsinsX8kh5p7e5HWtNRhhiNaPNk0EDPl7ocjl1rmXLp9/Q324ZFDaP0TQXml5MTn4hP3O5xOrpN/kFAH53xIcTq8ukrYiLbQqF3UaugIHEEg0BiozJWoQg1KD0D1KpkT3dCpM8XnkN9G5VYlJYn5RJG1KehNLlOHA3/iQm20uHjvmkWQ7K+Ac6ISsF9kgFZplU8JoAswjf5NayNRiZmA9Igw6yMXcm+SJYbEu7eegWqz//cGSlVRcfGDG1LDcA9RTlPRmYlvrORLS1MXHcVYecEatH+zrn7zMxTU51DkV04PQ8ANgTKorpaGrZljZ698qZW539HErMNiNb7lfHk+qPVyMfyQcptDtAeAd44E1LFVhJmXw63iTl4ykjKjGEyT+POLLUS+BQEle6wEWCS5NIkx707heiBkBsCv5VWpwcRcUi9GGbU/WWe8RXfZsdzZuloCubznpXb6a+e+ukmC66sxjq5su50eu+Y2VvdbcgoibzF793QHA5UaBtLgnW1fmDg5llWjxFMlZMda/ioIln8HgsUb5QJ2M6c6WPK+kAEsm0PUmPJCcSndw==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:06 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 03/10] net: phy: add devm/of_phy_package_join helper
Date: Mon,  5 Feb 2024 17:48:35 +0100
Message-ID: <20240205164851.1351-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devm/of_phy_package_join helper to join PHYs in a PHY package. These
are variant of the manual phy_package_join with the difference that
these will use DT nodes to derive the base_addr instead of manually
passing an hardcoded value.

An additional value is added in phy_package_shared, "np" to reference
the PHY package node pointer in specific PHY driver probe_once and
config_init_once functions to make use of additional specific properties
defined in the PHY package node in DT.

The np value is filled only with of_phy_package_join if a valid PHY
package node is found. A valid PHY package node must have the node name
set to "ethernet-phy-package".

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 96 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  6 +++
 2 files changed, 102 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 52828d1c64f7..c30907dc9fb7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1708,6 +1708,7 @@ int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size)
 			shared->priv_size = priv_size;
 		}
 		shared->base_addr = base_addr;
+		shared->np = NULL;
 		refcount_set(&shared->refcnt, 1);
 		bus->shared[base_addr] = shared;
 	} else {
@@ -1730,6 +1731,63 @@ int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size)
 }
 EXPORT_SYMBOL_GPL(phy_package_join);
 
+/**
+ * of_phy_package_join - join a common PHY group in PHY package
+ * @phydev: target phy_device struct
+ * @priv_size: if non-zero allocate this amount of bytes for private data
+ *
+ * This is a variant of phy_package_join for PHY package defined in DT.
+ *
+ * The parent node of the @phydev is checked as a valid PHY package node
+ * structure (by matching the node name "ethernet-phy-package") and the
+ * base_addr for the PHY package is passed to phy_package_join.
+ *
+ * With this configuration the shared struct will also have the np value
+ * filled to use additional DT defined properties in PHY specific
+ * probe_once and config_init_once PHY package OPs.
+ *
+ * Returns < 0 on error, 0 on success. Esp. calling phy_package_join()
+ * with the same cookie but a different priv_size is an error. Or a parent
+ * node is not detected or is not valid or doesn't match the expected node
+ * name for PHY package.
+ */
+int of_phy_package_join(struct phy_device *phydev, size_t priv_size)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device_node *package_node;
+	u32 base_addr;
+	int ret;
+
+	if (!node)
+		return -EINVAL;
+
+	package_node = of_get_parent(node);
+	if (!package_node)
+		return -EINVAL;
+
+	if (!of_node_name_eq(package_node, "ethernet-phy-package")) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (of_property_read_u32(package_node, "reg", &base_addr)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = phy_package_join(phydev, base_addr, priv_size);
+	if (ret)
+		goto exit;
+
+	phydev->shared->np = package_node;
+
+	return 0;
+exit:
+	of_node_put(package_node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_phy_package_join);
+
 /**
  * phy_package_leave - leave a common PHY group
  * @phydev: target phy_device struct
@@ -1746,6 +1804,10 @@ void phy_package_leave(struct phy_device *phydev)
 	if (!shared)
 		return;
 
+	/* Decrease the node refcount on leave if present */
+	if (shared->np)
+		of_node_put(shared->np);
+
 	if (refcount_dec_and_mutex_lock(&shared->refcnt, &bus->shared_lock)) {
 		bus->shared[shared->base_addr] = NULL;
 		mutex_unlock(&bus->shared_lock);
@@ -1798,6 +1860,40 @@ int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(devm_phy_package_join);
 
+/**
+ * devm_of_phy_package_join - resource managed of_phy_package_join()
+ * @dev: device that is registering this PHY package
+ * @phydev: target phy_device struct
+ * @priv_size: if non-zero allocate this amount of bytes for private data
+ *
+ * Managed of_phy_package_join(). Shared storage fetched by this function,
+ * phy_package_leave() is automatically called on driver detach. See
+ * of_phy_package_join() for more information.
+ */
+int devm_of_phy_package_join(struct device *dev, struct phy_device *phydev,
+			     size_t priv_size)
+{
+	struct phy_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_phy_package_leave, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_phy_package_join(phydev, priv_size);
+
+	if (!ret) {
+		*ptr = phydev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_package_join);
+
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a66f07d3f5f4..2aed925e6c23 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -329,6 +329,7 @@ struct mdio_bus_stats {
  * struct phy_package_shared - Shared information in PHY packages
  * @base_addr: Base PHY address of PHY package used to combine PHYs
  *   in one package and for offset calculation of phy_package_read/write
+ * @np: Pointer to the Device Node if PHY package defined in DT
  * @refcnt: Number of PHYs connected to this shared data
  * @flags: Initialization of PHY package
  * @priv_size: Size of the shared private data @priv
@@ -340,6 +341,8 @@ struct mdio_bus_stats {
  */
 struct phy_package_shared {
 	u8 base_addr;
+	/* With PHY package defined in DT this points to the PHY package node */
+	struct device_node *np;
 	refcount_t refcnt;
 	unsigned long flags;
 	size_t priv_size;
@@ -1999,9 +2002,12 @@ int phy_ethtool_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd);
 int phy_ethtool_nway_reset(struct net_device *ndev);
 int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size);
+int of_phy_package_join(struct phy_device *phydev, size_t priv_size);
 void phy_package_leave(struct phy_device *phydev);
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 			  int base_addr, size_t priv_size);
+int devm_of_phy_package_join(struct device *dev, struct phy_device *phydev,
+			     size_t priv_size);
 
 int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
-- 
2.43.0


