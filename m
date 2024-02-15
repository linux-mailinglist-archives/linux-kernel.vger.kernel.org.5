Return-Path: <linux-kernel+bounces-67270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF488568F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C951C2341E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846213A883;
	Thu, 15 Feb 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AjzUQ1In"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFA1386A1;
	Thu, 15 Feb 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013018; cv=none; b=aFnN/bnA3aqsMGIb8blEMdh3SInxyNQxULjvcHSBUw18RoLKSxgQfTgd5hM+1QCU4AYNzutrD9Q10oi9oxTepIwtfNoLqprBzclgV40z4A25zv3q8ZamMXcWs7F+lZslFJBqSjmYKzRUoAs1b2Oe84o6YSq/DWKQqtZSaT3c8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013018; c=relaxed/simple;
	bh=Gyv8Z31vxM3KIHGgdU6X7T8iozqwdNVj//r80VHQI8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/AnIMqP1tPfaoRZniEVwgSOuVwvIUGt4t67khCiKBNAh1TO+y9DQ2hRLUFSIHex0S3XGotVHExT26kLIg20aiaxrdrnyqcru/CuPRJvb39GfSlVqPaHbcii971V5br+ZqKB1NYHhoLeAv3z/57T76xbNon6yWjmK0DXnXnDNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AjzUQ1In; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5ABDD20010;
	Thu, 15 Feb 2024 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWAnQ2Me0c/aZS4jKmiRBTHvn2d7UQsJve0K8aYkjUk=;
	b=AjzUQ1InMUlWLSEWl2/e1H3ZYpfFFwn9QsJRdSpEgQCxyTtipQ5u1tt1BsHDymIHGRB97U
	F75/uCv6LgmbQ6eJWXQrhdEqLX0aPx0N6qkMCBB+4xG7xtGk78/kkQIK4bQauKD4dC7q0k
	kGPe4e/gs4Ft2HwMKPeMwg0LbqYEZa9cfidNsIiWmW68u5wqFsE9BTlvM3C7jfhcLTbcBJ
	Ls7jXuSwWooqrEhpkQPj6Ak4oAkxw8hHwSuSxLo5f/4c9j3PdG7PvWym2A0N24bE6aw+Gi
	QSiqdrv7SB4166LV9J7sHmvHGCP453iYP57nJ0gek2I6ZRvH0bBiHz2sholY0g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:51 +0100
Subject: [PATCH net-next v4 10/17] net: pse-pd: Add support for PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-feature_poe-v4-10-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Add support for getting the PSE controller node through PSE PI device
subnode.
This supports adds a way to get the PSE PI id from the pse_pi devicetree
subnode of a PSE controller node simply by reading the reg property.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 Documentation/networking/pse-pd/index.rst  |   1 +
 Documentation/networking/pse-pd/pse-pi.rst | 275 +++++++++++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c              | 223 ++++++++++++++++++-----
 include/linux/pse-pd/pse.h                 |  38 +++-
 4 files changed, 493 insertions(+), 44 deletions(-)

diff --git a/Documentation/networking/pse-pd/index.rst b/Documentation/networking/pse-pd/index.rst
index 18197bc7303d..de28a5aee316 100644
--- a/Documentation/networking/pse-pd/index.rst
+++ b/Documentation/networking/pse-pd/index.rst
@@ -7,3 +7,4 @@ Power Sourcing Equipment (PSE) Documentation
    :maxdepth: 2
 
    introduction
+   pse-pi
diff --git a/Documentation/networking/pse-pd/pse-pi.rst b/Documentation/networking/pse-pd/pse-pi.rst
new file mode 100644
index 000000000000..534e5be9dc70
--- /dev/null
+++ b/Documentation/networking/pse-pd/pse-pi.rst
@@ -0,0 +1,275 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+PSE Power Interface (PSE PI) Documentation
+==========================================
+
+The Power Sourcing Equipment Power Interface (PSE PI) plays a pivotal role in
+the architecture of Power over Ethernet (PoE) systems. It is essentially a
+blueprint that outlines how one or multiple power sources are connected to the
+eight-pin modular jack, commonly known as the Ethernet RJ45 port. This
+connection scheme is crucial for enabling the delivery of power alongside data
+over Ethernet cables.
+
+Documentation and Standards
+---------------------------
+
+The IEEE 802.3 standard provides detailed documentation on the PSE PI.
+Specifically:
+
+- Section "33.2.3 PI pin assignments" covers the pin assignments for PoE
+  systems that utilize two pairs for power delivery.
+- Section "145.2.4 PSE PI" addresses the configuration for PoE systems that
+  deliver power over all four pairs of an Ethernet cable.
+
+PSE PI and Single Pair Ethernet
+-------------------------------
+
+Single Pair Ethernet (SPE) represents a different approach to Ethernet
+connectivity, utilizing just one pair of conductors for both data and power
+transmission. Unlike the configurations detailed in the PSE PI for standard
+Ethernet, which can involve multiple power sourcing arrangements across four or
+two pairs of wires, SPE operates on a simpler model due to its single-pair
+design. As a result, the complexities of choosing between alternative pin
+assignments for power delivery, as described in the PSE PI for multi-pair
+Ethernet, are not applicable to SPE.
+
+Understanding PSE PI
+--------------------
+
+The Power Sourcing Equipment Power Interface (PSE PI) is a framework defining
+how Power Sourcing Equipment (PSE) delivers power to Powered Devices (PDs) over
+Ethernet cables. It details two main configurations for power delivery, known
+as Alternative A and Alternative B, which are distinguished not only by their
+method of power transmission but also by the implications for polarity and data
+transmission direction.
+
+Alternative A and B Overview
+----------------------------
+
+- **Alternative A:** Utilizes RJ45 conductors 1, 2, 3 and 6. In either case of
+  networks 10/100BaseT or 1G/2G/5G/10GBaseT, the pairs used are carrying data.
+  The power delivery's polarity in this alternative can vary based on the MDI
+  (Medium Dependent Interface) or MDI-X (Medium Dependent Interface Crossover)
+  configuration.
+
+- **Alternative B:** Utilizes RJ45 conductors 4, 5, 7 and 8. In case of
+  10/100BaseT network the pairs used are spare pairs without data and are less
+  influenced by data transmission direction. This is not the case for
+  1G/2G/5G/10GBaseT network. Alternative B includes two configurations with
+  different polarities, known as variant X and variant S, to accommodate
+  different network requirements and device specifications.
+
+Table 145–3—PSE Pinout Alternatives
+-----------------------------------
+
+The following table outlines the pin configurations for both Alternative A and
+Alternative B.
+
++------------+-------------------+-----------------+-----------------+-----------------+
+| Conductor  | Alternative A     | Alternative A   | Alternative B   | Alternative B   |
+|            |    (MDI-X)        |      (MDI)      |        (X)      |        (S)      |
++============+===================+=================+=================+=================+
+| 1          | Negative V        | Positive V      | -               | -               |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 2          | Negative V        | Positive V      | -               | -               |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 3          | Positive V        | Negative V      | -               | -               |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 4          | -                 | -               | Negative V      | Positive V      |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 5          | -                 | -               | Negative V      | Positive V      |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 6          | Positive V        | Negative V      | -               | -               |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 7          | -                 | -               | Positive V      | Negative V      |
++------------+-------------------+-----------------+-----------------+-----------------+
+| 8          | -                 | -               | Positive V      | Negative V      |
++------------+-------------------+-----------------+-----------------+-----------------+
+
+.. note::
+    - "Positive V" and "Negative V" indicate the voltage polarity for each pin.
+    - "-" indicates that the pin is not used for power delivery in that
+      specific configuration.
+
+PSE Power Interface (PSE PI) Connection Diagram
+-----------------------------------------------
+
+The diagram below illustrates the connection architecture between the RJ45
+port, the Ethernet PHY (Physical Layer), and the PSE PI (Power Sourcing
+Equipment Power Interface), demonstrating how power and data are delivered
+simultaneously through an Ethernet cable. The RJ45 port serves as the physical
+interface for these connections, with each of its eight pins connected to both
+the Ethernet PHY for data transmission and the PSE PI for power delivery.
+
+.. code-block::
+
+    +--------------------------+
+    |                          |
+    |          RJ45 Port       |
+    |                          |
+    +--+--+--+--+--+--+--+--+--+                +-------------+
+      1| 2| 3| 4| 5| 6| 7| 8|                   |             |
+       |  |  |  |  |  |  |  o-------------------+             |
+       |  |  |  |  |  |  o--|-------------------+             +<--- PSE 1
+       |  |  |  |  |  o--|--|-------------------+             |
+       |  |  |  |  o--|--|--|-------------------+             |
+       |  |  |  o--|--|--|--|-------------------+  PSE PI     |
+       |  |  o--|--|--|--|--|-------------------+             |
+       |  o--|--|--|--|--|--|-------------------+             +<--- PSE 2 (optional)
+       o--|--|--|--|--|--|--|-------------------+             |
+       |  |  |  |  |  |  |  |                   |             |
+    +--+--+--+--+--+--+--+--+--+                +-------------+
+    |                          |
+    |       Ethernet PHY       |
+    |                          |
+    +--------------------------+
+
+Simple PSE PI Configuration for Alternative A
+---------------------------------------------
+
+The diagram below illustrates a straightforward PSE PI (Power Sourcing
+Equipment Power Interface) configuration designed to support the Alternative A
+setup for Power over Ethernet (PoE). This implementation is tailored to provide
+power delivery through the data-carrying pairs of an Ethernet cable, suitable
+for either MDI or MDI-X configurations, albeit supporting one variation at a
+time.
+
+.. code-block::
+
+         +-------------+
+         |    PSE PI   |
+ 8  -----+                             +-------------+
+ 7  -----+                    Rail 1   |
+ 6  -----+------+----------------------+
+ 5  -----+      |                      |
+ 4  -----+     /              Rail 2   |  PSE 1
+ 3  -----+----´          +-------------+
+ 2  -----+----+---------´              |
+ 1  -----+---´                         +-------------+
+         |
+         +-------------+
+
+In this configuration:
+
+- Pins 1 and 2, as well as pins 3 and 6, are utilized for power delivery in
+  addition to data transmission. This aligns with the standard wiring for
+  10/100BaseT Ethernet networks where these pairs are used for data.
+- Rail 1 and Rail 2 represent the positive and negative voltage rails, with
+  Rail 1 connected to pins 1 and 2, and Rail 2 connected to pins 3 and 6.
+  More advanced PSE PI configurations may include integrated or external
+  switches to change the polarity of the voltage rails, allowing for
+  compatibility with both MDI and MDI-X configurations.
+
+More complex PSE PI configurations may include additional components, to support
+Alternative B, or to provide additional features such as power management, or
+additional power delivery capabilities such as 2-pair or 4-pair power delivery.
+
+.. code-block::
+
+         +-------------+
+         |    PSE PI   |
+         |        +---+
+ 8  -----+--------+   |                 +-------------+
+ 7  -----+--------+   |       Rail 1   |
+ 6  -----+--------+   +-----------------+
+ 5  -----+--------+   |                |
+ 4  -----+--------+   |       Rail 2   |  PSE 1
+ 3  -----+--------+   +----------------+
+ 2  -----+--------+   |                |
+ 1  -----+--------+   |                 +-------------+
+         |        +---+
+         +-------------+
+
+Device Tree Configuration: Describing PSE PI Configurations
+-----------------------------------------------------------
+
+The necessity for a separate PSE PI node in the device tree is influenced by
+the intricacy of the Power over Ethernet (PoE) system's setup. Here are
+descriptions of both simple and complex PSE PI configurations to illustrate
+this decision-making process:
+
+**Simple PSE PI Configuration:**
+In a straightforward scenario, the PSE PI setup involves a direct, one-to-one
+connection between a single PSE controller and an Ethernet port. This setup
+typically supports basic PoE functionality without the need for dynamic
+configuration or management of multiple power delivery modes. For such simple
+configurations, detailing the PSE PI within the existing PSE controller's node
+may suffice, as the system does not encompass additional complexity that
+warrants a separate node. The primary focus here is on the clear and direct
+association of power delivery to a specific Ethernet port.
+
+**Complex PSE PI Configuration:**
+Contrastingly, a complex PSE PI setup may encompass multiple PSE controllers or
+auxiliary circuits that collectively manage power delivery to one Ethernet
+port. Such configurations might support a range of PoE standards and require
+the capability to dynamically configure power delivery based on the operational
+mode (e.g., PoE2 versus PoE4) or specific requirements of connected devices. In
+these instances, a dedicated PSE PI node becomes essential for accurately
+documenting the system architecture. This node would serve to detail the
+interactions between different PSE controllers, the support for various PoE
+modes, and any additional logic required to coordinate power delivery across
+the network infrastructure.
+
+**Guidance:**
+
+For simple PSE setups, including PSE PI information in the PSE controller node
+might suffice due to the straightforward nature of these systems. However,
+complex configurations, involving multiple components or advanced PoE features,
+benefit from a dedicated PSE PI node. This method adheres to IEEE 802.3
+specifications, improving documentation clarity and ensuring accurate
+representation of the PoE system's complexity.
+
+PSE PI Node: Essential Information
+----------------------------------
+
+The PSE PI (Power Sourcing Equipment Power Interface) node in a device tree can
+include several key pieces of information critical for defining the power
+delivery capabilities and configurations of a PoE (Power over Ethernet) system.
+Below is a list of such information, along with explanations for their
+necessity and reasons why they might not be found within a PSE controller node:
+
+1. **Powered Pairs Configuration**
+
+   - *Description:* Identifies the pairs used for power delivery in the
+     Ethernet cable.
+   - *Necessity:* Essential to ensure the correct pairs are powered according
+     to the board's design.
+   - *PSE Controller Node:* Typically lacks details on physical pair usage,
+     focusing on power regulation.
+
+2. **Polarity of Powered Pairs**
+
+   - *Description:* Specifies the polarity (positive or negative) for each
+     powered pair.
+   - *Necessity:* Critical for safe and effective power transmission to PDs.
+   - *PSE Controller Node:* Polarity management may exceed the standard
+     functionalities of PSE controllers.
+
+3. **PSE Cells Association**
+
+   - *Description:* Details the association of PSE cells with Ethernet ports or
+     pairs in multi-cell configurations.
+   - *Necessity:* Allows for optimized power resource allocation in complex
+     systems.
+   - *PSE Controller Node:* Controllers may not manage cell associations
+     directly, focusing instead on power flow regulation.
+
+4. **Support for PoE Standards**
+
+   - *Description:* Lists the PoE standards and configurations supported by the
+     system.
+   - *Necessity:* Ensures system compatibility with various PDs and adherence
+     to industry standards.
+   - *PSE Controller Node:* Specific capabilities may depend on the overall PSE
+     PI design rather than the controller alone. Multiple PSE cells per PI
+     do not necessarily imply support for multiple PoE standards.
+
+5. **Protection Mechanisms**
+
+   - *Description:* Outlines additional protection mechanisms, such as
+     overcurrent protection and thermal management.
+   - *Necessity:* Provides extra safety and stability, complementing PSE
+     controller protections.
+   - *PSE Controller Node:* Some protections may be implemented via
+     board-specific hardware or algorithms external to the controller.
+
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 090e04c32f9e..e03d36793d18 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -27,38 +27,137 @@ struct pse_control {
 	struct kref refcnt;
 };
 
-/**
- * of_pse_zero_xlate - dummy function for controllers with one only control
- * @pcdev: a pointer to the PSE controller device
- * @pse_spec: PSE line specifier as found in the device tree
- *
- * This static translation function is used by default if of_xlate in
- * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
- * controllers with #pse-cells = <0>.
- */
-static int of_pse_zero_xlate(struct pse_controller_dev *pcdev,
-			     const struct of_phandle_args *pse_spec)
+static int of_load_pse_pi_pairsets(struct device_node *node,
+				   struct pse_pi *pi,
+				   int npairsets)
 {
-	return 0;
+	struct device_node *pairset_np;
+	const char *name;
+	int i, ret;
+
+	for (i = 0; i < npairsets; i++) {
+		ret = of_property_read_string_index(node,
+						    "pairset-names",
+						     i, &name);
+		if (ret)
+			break;
+
+		if (strcmp(name, "alternative-a")) {
+			pi->pairset[i].pinout = ALTERNATIVE_A;
+		} else if (strcmp(name, "alternative-b")) {
+			pi->pairset[i].pinout = ALTERNATIVE_B;
+		} else {
+			pr_err("pse: wrong pairset-names value %s\n", name);
+			ret = -EINVAL;
+			break;
+		}
+
+		pairset_np = of_parse_phandle(node, "pairsets", i);
+		if (!pairset_np) {
+			ret = -ENODEV;
+			break;
+		}
+
+		pi->pairset[i].np = pairset_np;
+	}
+
+	if (i == 2 && pi->pairset[0].pinout == pi->pairset[1].pinout) {
+		pr_err("pse: two PI pairsets can not have identical pinout");
+		ret = -EINVAL;
+	}
+
+	/* If an error appears on the second pairset load, release the first
+	 * pairset device node kref
+	 */
+	if (ret) {
+		of_node_put(pi->pairset[0].np);
+		pi->pairset[0].np = NULL;
+		of_node_put(pi->pairset[1].np);
+		pi->pairset[1].np = NULL;
+	}
+
+	return ret;
 }
 
-/**
- * of_pse_simple_xlate - translate pse_spec to the PSE line number
- * @pcdev: a pointer to the PSE controller device
- * @pse_spec: PSE line specifier as found in the device tree
- *
- * This static translation function is used by default if of_xlate in
- * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
- * controllers with 1:1 mapping, where PSE lines can be indexed by number
- * without gaps.
- */
-static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
-			       const struct of_phandle_args *pse_spec)
+static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 {
-	if (pse_spec->args[0] >= pcdev->nr_lines)
-		return -EINVAL;
+	struct device_node *np = pcdev->dev->of_node;
+	struct device_node *node, *pis;
+	int ret, i;
 
-	return pse_spec->args[0];
+	if (!np)
+		return -ENODEV;
+
+	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
+	if (!pcdev->pi)
+		return -ENOMEM;
+
+	pis = of_get_child_by_name(np, "pse_pis");
+	if (!pis) {
+		/* Legacy OF description of PSE PIs */
+		pcdev->of_legacy = true;
+		return 0;
+	}
+
+	for_each_child_of_node(pis, node) {
+		struct pse_pi pi = {0};
+		int npairsets;
+		u32 id;
+
+		if (!of_node_name_eq(node, "pse_pi"))
+			continue;
+
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret)
+			goto out;
+
+		if (id >= pcdev->nr_lines || pcdev->pi[id].np) {
+			dev_err(pcdev->dev, "wrong id of pse pi: %u\n",
+				id);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = of_property_count_strings(node, "pairset-names");
+		if (ret <= 0)
+			goto out;
+		npairsets = ret;
+
+		ret = of_count_phandle_with_args(node, "pairsets", NULL);
+		if (ret <= 0)
+			goto out;
+
+		/* npairsets is limited to value one or two */
+		if (ret != npairsets || ret > 2) {
+			dev_err(pcdev->dev,
+				"wrong number of pairsets or pairset-names for pse pi %d\n",
+				id);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = of_load_pse_pi_pairsets(node, &pi, npairsets);
+		if (ret)
+			goto out;
+
+		of_node_get(node);
+		pi.np = node;
+		memcpy(&pcdev->pi[id], &pi, sizeof(pi));
+	}
+
+	of_node_put(pis);
+	return 0;
+
+out:
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		of_node_put(pcdev->pi[i].pairset[0].np);
+		of_node_put(pcdev->pi[i].pairset[1].np);
+		of_node_put(pcdev->pi[i].np);
+	}
+	of_node_put(node);
+	of_node_put(pis);
+	kfree(pcdev->pi);
+	return ret;
 }
 
 /**
@@ -67,16 +166,18 @@ static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
  */
 int pse_controller_register(struct pse_controller_dev *pcdev)
 {
-	if (!pcdev->of_xlate) {
-		if (pcdev->of_pse_n_cells == 0)
-			pcdev->of_xlate = of_pse_zero_xlate;
-		else if (pcdev->of_pse_n_cells == 1)
-			pcdev->of_xlate = of_pse_simple_xlate;
-	}
+	int ret;
 
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
 
+	if (!pcdev->nr_lines)
+		pcdev->nr_lines = 1;
+
+	ret = of_load_pse_pis(pcdev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
@@ -91,6 +192,14 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	int i;
+
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		of_node_put(pcdev->pi[i].pairset[0].np);
+		of_node_put(pcdev->pi[i].pairset[1].np);
+		of_node_put(pcdev->pi[i].np);
+	}
+	kfree(pcdev->pi);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -203,8 +312,33 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 	return psec;
 }
 
-struct pse_control *
-of_pse_control_get(struct device_node *node)
+static int of_pse_match_pi(struct pse_controller_dev *pcdev,
+			   struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		if (pcdev->pi[i].np == np)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int psec_id_legacy_xlate(struct pse_controller_dev *pcdev,
+				const struct of_phandle_args *pse_spec)
+{
+	if (!pcdev->of_pse_n_cells)
+		return 0;
+
+	if (pcdev->of_pse_n_cells > 1 ||
+	    pse_spec->args[0] >= pcdev->nr_lines)
+		return -EINVAL;
+
+	return pse_spec->args[0];
+}
+
+struct pse_control *of_pse_control_get(struct device_node *node)
 {
 	struct pse_controller_dev *r, *pcdev;
 	struct of_phandle_args args;
@@ -222,7 +356,14 @@ of_pse_control_get(struct device_node *node)
 	mutex_lock(&pse_list_mutex);
 	pcdev = NULL;
 	list_for_each_entry(r, &pse_controller_list, list) {
-		if (args.np == r->dev->of_node) {
+		if (!r->of_legacy) {
+			ret = of_pse_match_pi(r, args.np);
+			if (ret >= 0) {
+				pcdev = r;
+				psec_id = ret;
+				break;
+			}
+		} else if (args.np == r->dev->of_node) {
 			pcdev = r;
 			break;
 		}
@@ -238,10 +379,12 @@ of_pse_control_get(struct device_node *node)
 		goto out;
 	}
 
-	psec_id = pcdev->of_xlate(pcdev, &args);
-	if (psec_id < 0) {
-		psec = ERR_PTR(psec_id);
-		goto out;
+	if (pcdev->of_legacy) {
+		psec_id = psec_id_legacy_xlate(pcdev, &args);
+		if (psec_id < 0) {
+			psec = ERR_PTR(psec_id);
+			goto out;
+		}
 	}
 
 	/* pse_list_mutex also protects the pcdev's pse_control list */
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index f006cbdf8b3b..6c48668cebe3 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -65,6 +65,36 @@ struct device_node;
 struct of_phandle_args;
 struct pse_control;
 
+/* PSE PI pairset pinout can either be Alternative A or Alternative B */
+enum pse_pi_pairset_pinout {
+	ALTERNATIVE_A,
+	ALTERNATIVE_B,
+};
+
+/**
+ * struct pse_pi_pairset - PSE PI pairset entity describing the pinout
+ *			   alternative ant its phandle
+ *
+ * @pinout: description of the pinout alternative
+ * @np: device node pointer describing the pairset phandle
+ */
+struct pse_pi_pairset {
+	enum pse_pi_pairset_pinout pinout;
+	struct device_node *np;
+};
+
+/**
+ * struct pse_pi - PSE PI (Power Interface) entity as described in
+ *		   IEEE 802.3-2022 145.2.4
+ *
+ * @pairset: table of the PSE PI pinout alternative for the two pairset
+ * @np: device node pointer of the PSE PI node
+ */
+struct pse_pi {
+	struct pse_pi_pairset pairset[2];
+	struct device_node *np;
+};
+
 /**
  * struct pse_controller_dev - PSE controller entity that might
  *                             provide multiple PSE controls
@@ -74,11 +104,11 @@ struct pse_control;
  * @pse_control_head: head of internal list of requested PSE controls
  * @dev: corresponding driver model device struct
  * @of_pse_n_cells: number of cells in PSE line specifiers
- * @of_xlate: translation function to translate from specifier as found in the
- *            device tree to id as given to the PSE control ops
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
  * @types: types of the PSE controller
+ * @pi: table of PSE PIs described in this controller device
+ * @of_legacy: flag set if the pse_pis devicetree node is not used
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -87,11 +117,11 @@ struct pse_controller_dev {
 	struct list_head pse_control_head;
 	struct device *dev;
 	int of_pse_n_cells;
-	int (*of_xlate)(struct pse_controller_dev *pcdev,
-			const struct of_phandle_args *pse_spec);
 	unsigned int nr_lines;
 	struct mutex lock;
 	u32 types;
+	struct pse_pi *pi;
+	bool of_legacy;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.25.1


