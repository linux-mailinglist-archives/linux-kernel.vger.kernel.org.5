Return-Path: <linux-kernel+bounces-48377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590D845B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E105A294C30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3477A1C;
	Thu,  1 Feb 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXqcbYT1"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721B626DB;
	Thu,  1 Feb 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800701; cv=none; b=XCmmLoJaoBpuzYZmxgYus2uJZlie7SvQSrVz+7OLYgFLAv5ed1rkJPZska4rX4zFbD6qoiTF4WBz6V1D2sy0BxELC/D/xZ52tNiQFp5c1h7Ttxs+dbqIEC1u+ImV3Ej/HLbpqkUf/GxUBLXpMNiRwcw60NgUUsrpMPSe2bB2GNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800701; c=relaxed/simple;
	bh=MZjVKpbNTkdLb4dpisF+qO5QzzzVXyxNiuLsaugcmgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzpfgoOX0OoSsFdoOqBF65+3ZDvCSXQnAn0Ib4e8UFYSCY5Nllp4XCszHJx/VZSD3NbZyHNC4+Yj239jqtEGGgeXBCwQtqat/5yCeAYQMt0YIsHoG5V966/N+J8hrvgBwKEhFCDwRYM7W8OpuHNbUwDWjmZD2MuOSchygopFi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXqcbYT1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso14103351fa.3;
        Thu, 01 Feb 2024 07:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800698; x=1707405498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TX7yG3ubKYLaqdAEsMkR7yz6TrAsdQtaBAIynW+z9Ow=;
        b=UXqcbYT1DcgzSWJ3JwcFLZ7rH4cxPBFss4Scf2QqWnc7f/144N/hb4W0XjakO9J86t
         ZaRfRig7VH3TBjP0PZlwdrpU7PWiArVEin9L5AjXy7qP1LxtNH2ORgyKbFxUJD4uQZeg
         1qrBTeal2xLQQM/lf8YfUbJsXcH7qUgCfN4L+lyasruw1U0vAWpes3mG6q7mdJMoHrrs
         A790J0dYdB4SbC02UhtzhJWX/+GAI088Ql1iJXvi8QfenUtpzeAhBm69XDn6rGOqWFZC
         dcMNqhNgcEdHnJj3iA6KUvEDxnKWvys3l0f9I6t1XQGBiHowFLgaKAcWaIX5m9pQWqFu
         EFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800698; x=1707405498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX7yG3ubKYLaqdAEsMkR7yz6TrAsdQtaBAIynW+z9Ow=;
        b=UVRLCljOC4+0RDufonKYb6bVxW+SFUuFvfhd2A+UAqFkVTKfGQAyuvwp5Y4+/ruQ1p
         Q3soXdm5aOKXRNt0XYHpp0Vf0VoNY+0yH9E1k3ZfAN+Cw0Wjs7aISyxJPhZW2RjR69PU
         vS8O+W0lml7ZV0L9GzbN6gllfDOuuOhGPGjkmABUZ/8BriFG1Pz7K0nMPMuAtuL5gnuI
         CKIxz1nB/wfcvhN0dUVx44XBAeBes2l9Ls7L6+ZUKka0xc2meoaFvaAdjKw08oQlJ0r/
         9oN8bKE7rfe6n2HJhdHk2yiSGT5p+P1a70yQcdDWC2DcIMG0X/wdel4nz6tKocetZw1Q
         IopA==
X-Gm-Message-State: AOJu0YwrusTDAkrwvWaCpFVb9b7P0FzsLSBsPAh4eQnfweMRD+KPfHvs
	glucV8qcmPsgKaOy5/PwAjZkJX9skI8Usrpwwk+Lq55tDtRZK/1c
X-Google-Smtp-Source: AGHT+IEXbbifOjMcTszBlARNfT6lhP3jpdC41hx8qVtHsOTMqyHgGJU+UiFmZ9kagF4ivc9QTqTGvA==
X-Received: by 2002:a2e:7011:0:b0:2cf:2ef2:87f7 with SMTP id l17-20020a2e7011000000b002cf2ef287f7mr3403843ljc.53.1706800697655;
        Thu, 01 Feb 2024 07:18:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVt7t3hAKimEwfI+a/oJ2cBeFLrfQg6euL8zGfALcLFjOpeZztuIUeraRtctg7AqzfCs6BTYhxLxBvHPLj80XqczgfKMz8j1agUrQb406//czQW+Ps96RMPWJfYL++bMyyFX6tzH8msLwQadUz6xYyGgbNd1bSjvBmsjDFDKqI4vxxzSH6PxFc4nZwS9pr5WGG66mRIVBPHANzmAc1L71QOpG4w5rRVw+/lg3t46aqs1/v1ee9CKWWuImlMzMGYpZWsAx20VALMiaPFpKCol8klQ/bGAzfwLAMQbKJerZctHSbz6Uv/5IriwoLsSD39lmSj77/ySoCrmEK6lGTEIQM8YZaVlLdSobJ9sOpMaehbzsC3orYNx5qGMqUIqpsu2C/ALYAnm3PKfzHltKUI2+Xgt0j+YCZGugIjPr4DypHlhNzBiyK+OCyfaYIh5aw8QEAK4RgjuODtpcwO+zmUjwk1TD6K6fpyvBEbDPKKFpsE8z2FZBUL6CUuAMks/6P7Jj2rp+A6lik9WW/h/nx3rB3l074japgTbxW0BrREo3/ZeUuOswI/zXxtI4C0lqrFQYBUhPUNo2EF2/n417zsLrFlt6sdlrrBtlzLQzxnRK6WSbvtP7j5HRA7
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:17 -0800 (PST)
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
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 3/9] net: phy: add devm/of_phy_package_join helper
Date: Thu,  1 Feb 2024 16:17:29 +0100
Message-ID: <20240201151747.7524-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/phy_device.c | 84 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  6 +++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 52828d1c64f7..50874192e807 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1730,6 +1730,56 @@ int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size)
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
+ * Returns < 1 on error, 0 on success. Esp. calling phy_package_join()
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
+	if (!of_node_name_eq(package_node, "ethernet-phy-package"))
+		return -EINVAL;
+
+	if (of_property_read_u32(package_node, "reg", &base_addr))
+		return -EINVAL;
+
+	ret = phy_package_join(phydev, base_addr, priv_size);
+	if (ret)
+		return ret;
+
+	phydev->shared->np = package_node;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_phy_package_join);
+
 /**
  * phy_package_leave - leave a common PHY group
  * @phydev: target phy_device struct
@@ -1798,6 +1848,40 @@ int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
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


