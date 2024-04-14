Return-Path: <linux-kernel+bounces-144201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D48A430F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019091F2127C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2353E0E;
	Sun, 14 Apr 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UxgMXjLN"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1A59B77;
	Sun, 14 Apr 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104627; cv=none; b=DnZgehBMAMrVBwwB3K3XOJz0J9F8jGmVX2Q27mmjRVVf4K4SMJdqouxVpHxLyEMzkOodcRdN6jGEvUbYVt+x33LTkllVgVRFkia/+zSMpimuPYzOsooWOQjtHPUBIdgY1alqLfGnCIghSzks7E1mryD7/DsdFwiOkwmBWr4eeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104627; c=relaxed/simple;
	bh=+NeOsmxenQ0MnQazGS8pB3asMV3MMRVUdgP6mlcgg5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQrlVBct2Db9twPJaov3zJvOHSvS7pACpmpd99ZGp0pbRlXfQsqfiQaEXj0MmrKacGssXBsEyFC10P64izUwIk/9PpigGz+ly1OQOertopeP/hTybcDlLL4SLPI3Q6+5R8Z+KCrZZpJNm/KVClMF/WtB0Rt5d10RDTCVcAsgDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UxgMXjLN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FA02C0008;
	Sun, 14 Apr 2024 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNb7VBX19YKKHvUgAfOzrJm0JHWcBZPF/oUtpGD75zI=;
	b=UxgMXjLN9WP1x9N7NVm9EVU+FVq9goK3w5ryjY5FBXozTbrmBPHKhiW4J5yMwDgn2PTuv9
	w65RwHCKHqESnxEk8oW/ioXFad38w3+zYnLIzzShLr2PJyAUMe4yuNSdDu3NdxiF5s5S9e
	IhgjEmrCdsXnHWf7OE3/LqOj3gBgQ8jJfusZ4QODxJxOKh3muI4EYEccwsTqztRzGIZk7H
	/kNeNkCBv+A8bdTm4mKE4HMaj58KRbRxmje+ak9Tw5G9GMKkCsH8bRU7+he4nOYNY37aED
	Q+91yDeVe8r5tZNc0LTqJb3HMaZHgigEx/L7vbk0zAIVvzU/aBHkxodorcZ/tw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:59 +0200
Subject: [PATCH net-next v8 10/17] net: pse-pd: Add support for PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-10-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
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
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

The Power Sourcing Equipment Power Interface (PSE PI) plays a pivotal role
in the architecture of Power over Ethernet (PoE) systems. It is essentially
a blueprint that outlines how one or multiple power sources are connected
to the eight-pin modular jack, commonly known as the Ethernet RJ45 port.
This connection scheme is crucial for enabling the delivery of power
alongside data over Ethernet cables.

This patch adds support for getting the PSE controller node through PSE PI
device subnode.

This supports adds a way to get the PSE PI id from the pse_pi devicetree
subnode of a PSE controller node simply by reading the reg property.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch.

Changes in v4:
- Add PSE PI documentation.

Changes in v5:
- Update PSE PI documentation.

Changes in v6:
- Add error messages.
- Add kdoc.
- Rename of_legacy to no_of_pse_pi.
- Create new function for readibility.
- Fix few nit.

Changes in v7:
- Fixes Doc and kdoc nit.
- Add PSE PI node path in error messages.
---
 Documentation/networking/pse-pd/index.rst  |   1 +
 Documentation/networking/pse-pd/pse-pi.rst | 302 +++++++++++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c              | 258 ++++++++++++++++++++----
 include/linux/pse-pd/pse.h                 |  38 +++-
 4 files changed, 560 insertions(+), 39 deletions(-)

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
index 000000000000..86f150fb3512
--- /dev/null
+++ b/Documentation/networking/pse-pd/pse-pi.rst
@@ -0,0 +1,302 @@
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
+Table 145-3 PSE Pinout Alternatives
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
+PSE PI compatibilities
+----------------------
+
+The following table outlines the compatibility between the pinout alternative
+and the 1000/2.5G/5G/10GBaseT in the PSE 2 pairs connection.
+
++---------+---------------+---------------------+-----------------------+
+| Variant | Alternative   | Power Feeding Type  | Compatibility with    |
+|         | (A/B)         | (Direct/Phantom)    | 1000/2.5G/5G/10GBaseT |
++=========+===============+=====================+=======================+
+| 1       | A             | Phantom             | Yes                   |
++---------+---------------+---------------------+-----------------------+
+| 2       | B             | Phantom             | Yes                   |
++---------+---------------+---------------------+-----------------------+
+| 3       | B             | Direct              | No                    |
++---------+---------------+---------------------+-----------------------+
+
+.. note::
+    - "Direct" indicate a variant where the power is injected directly to pairs
+       without using magnetics in case of spare pairs.
+    - "Phantom" indicate power path over coils/magnetics as it is done for
+       Alternative A variant.
+
+In case of PSE 4 pairs, a PSE supporting only 10/100BaseT (which mean Direct
+Power on pinout Alternative B) is not compatible with a 4 pairs
+1000/2.5G/5G/10GBaseT.
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
+ 4  -----+      |             Rail 2   |  PSE 1
+ 3  -----+------/         +------------+
+ 2  -----+--+-------------/            |
+ 1  -----+--/                          +-------------+
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
index fed006cbc185..25558158048e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -27,38 +27,176 @@ struct pse_control {
 	struct kref refcnt;
 };
 
+static int of_load_single_pse_pi_pairset(struct device_node *node,
+					 struct pse_pi *pi,
+					 int pairset_num)
+{
+	struct device_node *pairset_np;
+	const char *name;
+	int ret;
+
+	ret = of_property_read_string_index(node, "pairset-names",
+					    pairset_num, &name);
+	if (ret)
+		return ret;
+
+	if (!strcmp(name, "alternative-a")) {
+		pi->pairset[pairset_num].pinout = ALTERNATIVE_A;
+	} else if (!strcmp(name, "alternative-b")) {
+		pi->pairset[pairset_num].pinout = ALTERNATIVE_B;
+	} else {
+		pr_err("pse: wrong pairset-names value %s (%pOF)\n",
+		       name, node);
+		return -EINVAL;
+	}
+
+	pairset_np = of_parse_phandle(node, "pairsets", pairset_num);
+	if (!pairset_np)
+		return -ENODEV;
+
+	pi->pairset[pairset_num].np = pairset_np;
+
+	return 0;
+}
+
 /**
- * of_pse_zero_xlate - dummy function for controllers with one only control
- * @pcdev: a pointer to the PSE controller device
- * @pse_spec: PSE line specifier as found in the device tree
- *
- * This static translation function is used by default if of_xlate in
- * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
- * controllers with #pse-cells = <0>.
+ * of_load_pse_pi_pairsets - load PSE PI pairsets pinout and polarity
+ * @node: a pointer of the device node
+ * @pi: a pointer of the PSE PI to fill
+ * @npairsets: the number of pairsets (1 or 2) used by the PI
  */
-static int of_pse_zero_xlate(struct pse_controller_dev *pcdev,
-			     const struct of_phandle_args *pse_spec)
+static int of_load_pse_pi_pairsets(struct device_node *node,
+				   struct pse_pi *pi,
+				   int npairsets)
 {
-	return 0;
+	int i, ret;
+
+	ret = of_property_count_strings(node, "pairset-names");
+	if (ret != npairsets) {
+		pr_err("pse: amount of pairsets and pairset-names is not equal %d != %d (%pOF)\n",
+		       npairsets, ret, node);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < npairsets; i++) {
+		ret = of_load_single_pse_pi_pairset(node, pi, i);
+		if (ret)
+			goto out;
+	}
+
+	if (npairsets == 2 &&
+	    pi->pairset[0].pinout == pi->pairset[1].pinout) {
+		pr_err("pse: two PI pairsets can not have identical pinout (%pOF)",
+		       node);
+		ret = -EINVAL;
+	}
+
+out:
+	/* If an error appears, release all the pairset device node kref */
+	if (ret) {
+		of_node_put(pi->pairset[0].np);
+		pi->pairset[0].np = NULL;
+		of_node_put(pi->pairset[1].np);
+		pi->pairset[1].np = NULL;
+	}
+
+	return ret;
+}
+
+static void pse_release_pis(struct pse_controller_dev *pcdev)
+{
+	int i;
+
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		of_node_put(pcdev->pi[i].pairset[0].np);
+		of_node_put(pcdev->pi[i].pairset[1].np);
+		of_node_put(pcdev->pi[i].np);
+	}
+	kfree(pcdev->pi);
 }
 
 /**
- * of_pse_simple_xlate - translate pse_spec to the PSE line number
+ * of_load_pse_pis - load all the PSE PIs
  * @pcdev: a pointer to the PSE controller device
- * @pse_spec: PSE line specifier as found in the device tree
- *
- * This static translation function is used by default if of_xlate in
- * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
- * controllers with 1:1 mapping, where PSE lines can be indexed by number
- * without gaps.
  */
-static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
-			       const struct of_phandle_args *pse_spec)
+static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 {
-	if (pse_spec->args[0] >= pcdev->nr_lines)
-		return -EINVAL;
+	struct device_node *np = pcdev->dev->of_node;
+	struct device_node *node, *pis;
+	int ret;
 
-	return pse_spec->args[0];
+	if (!np)
+		return -ENODEV;
+
+	pis = of_get_child_by_name(np, "pse-pis");
+	if (!pis) {
+		/* no description of PSE PIs */
+		pcdev->no_of_pse_pi = true;
+		return 0;
+	}
+
+	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
+	if (!pcdev->pi)
+		return -ENOMEM;
+
+	for_each_child_of_node(pis, node) {
+		struct pse_pi pi = {0};
+		u32 id;
+
+		if (!of_node_name_eq(node, "pse-pi"))
+			continue;
+
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret) {
+			dev_err(pcdev->dev,
+				"can't get reg property for node '%pOF'",
+				node);
+			goto out;
+		}
+
+		if (id >= pcdev->nr_lines) {
+			dev_err(pcdev->dev,
+				"reg value (%u) is out of range (%u) (%pOF)\n",
+				id, pcdev->nr_lines, node);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (pcdev->pi[id].np) {
+			dev_err(pcdev->dev,
+				"other node with same reg value was already registered. %pOF : %pOF\n",
+				pcdev->pi[id].np, node);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = of_count_phandle_with_args(node, "pairsets", NULL);
+		/* npairsets is limited to value one or two */
+		if (ret == 1 || ret == 2) {
+			ret = of_load_pse_pi_pairsets(node, &pi, ret);
+			if (ret)
+				goto out;
+		} else if (ret != ENOENT) {
+			dev_err(pcdev->dev,
+				"error: wrong number of pairsets. Should be 1 or 2, got %d (%pOF)\n",
+				ret, node);
+			ret = -EINVAL;
+			goto out;
+		}
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
+	pse_release_pis(pcdev);
+	of_node_put(node);
+	of_node_put(pis);
+	return ret;
 }
 
 /**
@@ -67,16 +205,18 @@ static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
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
@@ -91,6 +231,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	pse_release_pis(pcdev);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -203,8 +344,46 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 	return psec;
 }
 
-struct pse_control *
-of_pse_control_get(struct device_node *node)
+/**
+ * of_pse_match_pi - Return the PSE PI id of the device node phandle
+ * @pcdev: a pointer to the PSE controller device
+ * @np: a pointer to the device node
+ */
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
+/**
+ * psec_id_xlate - translate pse_spec to the PSE line number according
+ *		   to the number of pse-cells in case of no pse_pi node
+ * @pcdev: a pointer to the PSE controller device
+ * @pse_spec: PSE line specifier as found in the device tree
+ *
+ * Return 0 if #pse-cells = <0>. Return PSE line number otherwise.
+ */
+static int psec_id_xlate(struct pse_controller_dev *pcdev,
+			 const struct of_phandle_args *pse_spec)
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
@@ -222,7 +401,14 @@ of_pse_control_get(struct device_node *node)
 	mutex_lock(&pse_list_mutex);
 	pcdev = NULL;
 	list_for_each_entry(r, &pse_controller_list, list) {
-		if (args.np == r->dev->of_node) {
+		if (!r->no_of_pse_pi) {
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
@@ -238,10 +424,12 @@ of_pse_control_get(struct device_node *node)
 		goto out;
 	}
 
-	psec_id = pcdev->of_xlate(pcdev, &args);
-	if (psec_id < 0) {
-		psec = ERR_PTR(psec_id);
-		goto out;
+	if (pcdev->no_of_pse_pi) {
+		psec_id = psec_id_xlate(pcdev, &args);
+		if (psec_id < 0) {
+			psec = ERR_PTR(psec_id);
+			goto out;
+		}
 	}
 
 	/* pse_list_mutex also protects the pcdev's pse_control list */
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 19589571157f..e19d58b5e777 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -64,6 +64,36 @@ struct device_node;
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
@@ -73,11 +103,11 @@ struct pse_control;
  * @pse_control_head: head of internal list of requested PSE controls
  * @dev: corresponding driver model device struct
  * @of_pse_n_cells: number of cells in PSE line specifiers
- * @of_xlate: translation function to translate from specifier as found in the
- *            device tree to id as given to the PSE control ops
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
  * @types: types of the PSE controller
+ * @pi: table of PSE PIs described in this controller device
+ * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -86,11 +116,11 @@ struct pse_controller_dev {
 	struct list_head pse_control_head;
 	struct device *dev;
 	int of_pse_n_cells;
-	int (*of_xlate)(struct pse_controller_dev *pcdev,
-			const struct of_phandle_args *pse_spec);
 	unsigned int nr_lines;
 	struct mutex lock;
 	enum ethtool_pse_types types;
+	struct pse_pi *pi;
+	bool no_of_pse_pi;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.34.1


