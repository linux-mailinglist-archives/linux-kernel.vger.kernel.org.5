Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230CA7E29C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjKFQbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjKFQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:31:39 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD4A4;
        Mon,  6 Nov 2023 08:31:35 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 628e8886795890bf; Mon, 6 Nov 2023 17:31:34 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id F0642667790;
        Mon,  6 Nov 2023 17:31:33 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
Date:   Mon, 06 Nov 2023 17:27:26 +0100
Message-ID: <1987710.usQuhbGJ8B@kreacher>
In-Reply-To: <4542595.LvFx2qVVIh@kreacher>
References: <4542595.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepjeehvdelteekjeelffffudfhffejveetffdtveeuffegffeujeethfeutdefgfeknecuffhomhgrihhnpehmihhpihdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes

Add information extracted from the MIPI DisCo for Imaging device
properties to software nodes created during the CSI-2 connection graph
discovery.

Link: https://www.mipi.org/specifications/mipi-disco-imaging
Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Change the name of the new file to mipi-disco-img.c
   * "DiSco" -> "DisCo" in multiple places
   * Fix the link in the Link: tag
   * Change the number of data lanes limit and add a comment regarding it
   * Use ACPI_DEVICE_CSI2_DATA_LANES directly in several places instead
     of array sizes equal to it

---
 drivers/acpi/internal.h       |    1 
 drivers/acpi/mipi-disco-img.c |  249 +++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/scan.c           |   12 +-
 include/acpi/acpi_bus.h       |   17 ++
 4 files changed, 275 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/mipi-disco-img.c
===================================================================
--- linux-pm.orig/drivers/acpi/mipi-disco-img.c
+++ linux-pm/drivers/acpi/mipi-disco-img.c
@@ -6,12 +6,16 @@
  *
  * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI-2 records defined in
  * Section 6.4.3.8.2.4 "Camera Serial Interface (CSI-2) Connection Resource
- * Descriptor" of ACPI 6.5.
+ * Descriptor" of ACPI 6.5 and using device properties defined by the MIPI DisCo
+ * for Imaging specification.
  *
  * The implementation looks for the information in the ACPI namespace (CSI-2
  * resource descriptors in _CRS) and constructs software nodes compatible with
  * Documentation/firmware-guide/acpi/dsd/graph.rst to represent the CSI-2
- * connection graph.
+ * connection graph.  The software nodes are then populated with the data
+ * extracted from the _CRS CSI-2 resource descriptors and the MIPI DisCo
+ * for Imaging device properties present in _DSD for the ACPI device objects
+ * with CSI-2 connections.
  */
 
 #include <linux/acpi.h>
@@ -431,6 +435,247 @@ void acpi_mipi_scan_crs_csi2(void)
 		prepare_crs_csi2_swnodes(csi2);
 }
 
+/*
+ * Get the index of the next property in the property array, with a given
+ * maximum value.
+ */
+#define NEXT_PROPERTY(index, max)			\
+	(WARN_ON((index) > ACPI_DEVICE_SWNODE_##max) ?	\
+	 ACPI_DEVICE_SWNODE_##max : (index)++)
+
+static void init_csi2_port_local(struct acpi_device *adev,
+				 struct acpi_device_software_node_port *port,
+				 struct fwnode_handle *port_fwnode,
+				 unsigned int index)
+{
+	acpi_handle handle = acpi_device_handle(adev);
+	unsigned int num_link_freqs;
+	int ret;
+
+	ret = fwnode_property_count_u64(port_fwnode, "mipi-img-link-frequencies");
+	if (ret <= 0)
+		return;
+
+	num_link_freqs = ret;
+	if (num_link_freqs > ACPI_DEVICE_CSI2_DATA_LANES) {
+		acpi_handle_info(handle, "Too many link frequencies: %u\n",
+				 num_link_freqs);
+		num_link_freqs = ACPI_DEVICE_CSI2_DATA_LANES;
+	}
+
+	ret = fwnode_property_read_u64_array(port_fwnode,
+					     "mipi-img-link-frequencies",
+					     port->link_frequencies,
+					     num_link_freqs);
+	if (ret) {
+		acpi_handle_info(handle, "Unable to get link frequencies (%d)\n",
+				 ret);
+		return;
+	}
+
+	port->ep_props[NEXT_PROPERTY(index, EP_LINK_FREQUENCIES)] =
+				PROPERTY_ENTRY_U64_ARRAY_LEN("link-frequencies",
+							     port->link_frequencies,
+							     num_link_freqs);
+}
+
+static void init_csi2_port(struct acpi_device *adev,
+			   struct acpi_device_software_nodes *swnodes,
+			   struct acpi_device_software_node_port *port,
+			   struct fwnode_handle *port_fwnode,
+			   unsigned int port_index)
+{
+	unsigned int ep_prop_index = ACPI_DEVICE_SWNODE_EP_CLOCK_LANES;
+	acpi_handle handle = acpi_device_handle(adev);
+	u8 val[ACPI_DEVICE_CSI2_DATA_LANES];
+	int num_lanes = 0;
+	int ret;
+
+	if (GRAPH_PORT_NAME(port->port_name, port->port_nr))
+		return;
+
+	swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)] =
+			SOFTWARE_NODE(port->port_name, port->port_props,
+				      &swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT]);
+
+	ret = fwnode_property_read_u8(port_fwnode, "mipi-img-clock-lane", val);
+	if (!ret)
+		port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_CLOCK_LANES)] =
+			PROPERTY_ENTRY_U32("clock-lanes", val[0]);
+
+	ret = fwnode_property_count_u8(port_fwnode, "mipi-img-data-lanes");
+	if (ret > 0) {
+		num_lanes = ret;
+
+		if (num_lanes > ACPI_DEVICE_CSI2_DATA_LANES) {
+			acpi_handle_info(handle, "Too many data lanes: %u\n",
+					 num_lanes);
+			num_lanes = ACPI_DEVICE_CSI2_DATA_LANES;
+		}
+
+		ret = fwnode_property_read_u8_array(port_fwnode,
+						    "mipi-img-data-lanes",
+						    val, num_lanes);
+		if (!ret) {
+			unsigned int i;
+
+			for (i = 0; i < num_lanes; i++)
+				port->data_lanes[i] = val[i];
+
+			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_DATA_LANES)] =
+				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
+							     port->data_lanes,
+							     num_lanes);
+		}
+	}
+
+	ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
+	if (ret * BITS_PER_TYPE(u8) >= num_lanes + 1) {
+		unsigned long mask = 0;
+		int byte_count = ret;
+		unsigned int i;
+
+		/*
+		 * The total number of lanes is ACPI_DEVICE_CSI2_DATA_LANES + 1
+		 * (data lanes + clock lane).  It is not expected to ever be
+		 * greater than the number of bits in an unsigned long
+		 * variable, but ensure that this is the case.
+		 */
+		BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <= ACPI_DEVICE_CSI2_DATA_LANES);
+
+		if (byte_count > ACPI_DEVICE_CSI2_DATA_LANES) {
+			acpi_handle_info(handle, "Too many lane polarities: %d\n",
+					 byte_count);
+			byte_count = ACPI_DEVICE_CSI2_DATA_LANES;
+		}
+		fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane-polarities",
+					      val, byte_count);
+
+		for (i = 0; BITS_PER_TYPE(u8) * i <= num_lanes; i++)
+			mask |= (unsigned long)val[i] << BITS_PER_TYPE(u8) * i;
+
+		for (i = 0; i <= num_lanes; i++)
+			port->lane_polarities[i] = test_bit(i, &mask);
+
+		port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_LANE_POLARITIES)] =
+				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
+							     port->lane_polarities,
+							     num_lanes + 1);
+	} else {
+		acpi_handle_info(handle, "Lane polarity bytes missing\n");
+	}
+
+	swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
+		SOFTWARE_NODE("endpoint@0", swnodes->ports[port_index].ep_props,
+			      &swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)]);
+
+	if (port->crs_csi2_local)
+		init_csi2_port_local(adev, port, port_fwnode, ep_prop_index);
+}
+
+#define MIPI_IMG_PORT_PREFIX "mipi-img-port-"
+
+static struct fwnode_handle *get_mipi_port_handle(struct fwnode_handle *adev_fwnode,
+						  unsigned int port_nr)
+{
+	char port_name[sizeof(MIPI_IMG_PORT_PREFIX) + 2];
+
+	if (snprintf(port_name, sizeof(port_name), "%s%u",
+		     MIPI_IMG_PORT_PREFIX, port_nr) >= sizeof(port_name))
+		return NULL;
+
+	return fwnode_get_named_child_node(adev_fwnode, port_name);
+}
+
+static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
+{
+	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
+	struct acpi_device_software_nodes *swnodes = csi2->swnodes;
+	acpi_handle handle = csi2->handle;
+	struct fwnode_handle *adev_fwnode;
+	struct acpi_device *adev;
+	acpi_status status;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * Bail out if the swnodes are not available (either they have not been
+	 * allocated or they have been assigned to the device already).
+	 */
+	if (!swnodes)
+		return;
+
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
+		return;
+
+	adev_fwnode = acpi_fwnode_handle(adev);
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_info(handle, "Unable to get the path name\n");
+		return;
+	}
+
+	swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT] =
+			SOFTWARE_NODE(buffer.pointer, swnodes->dev_props, NULL);
+
+	for (i = 0; i < swnodes->num_ports; i++) {
+		struct acpi_device_software_node_port *port = &swnodes->ports[i];
+		struct fwnode_handle *port_fwnode;
+
+		/*
+		 * The MIPI DisCo for Imaging specification defines _DSD device
+		 * properties for providing CSI-2 port parameters that can be
+		 * accessed through the generic device properties framework.  To
+		 * access them, it is first necessary to find the data node
+		 * representing the port under the given ACPI device object.
+		 */
+		port_fwnode = get_mipi_port_handle(adev_fwnode, port->port_nr);
+		if (!port_fwnode) {
+			acpi_handle_info(handle,
+					 "MIPI port name too long for port %u\n",
+					 port->port_nr);
+			continue;
+		}
+
+		init_csi2_port(adev, swnodes, port, port_fwnode, i);
+
+		fwnode_handle_put(port_fwnode);
+	}
+
+	ret = software_node_register_node_group(swnodes->nodeptrs);
+	if (ret < 0) {
+		acpi_handle_info(handle,
+				 "Unable to register software nodes (%d)\n", ret);
+		return;
+	}
+
+	adev->swnodes = swnodes;
+	adev_fwnode->secondary = software_node_fwnode(swnodes->nodes);
+
+	/*
+	 * Prevents the swnodes from this csi2 entry from being assigned again
+	 * or freed prematurely.
+	 */
+	csi2->swnodes = NULL;
+}
+
+/**
+ * acpi_mipi_init_crs_csi2_swnodes - Initialize _CRS CSI-2 software nodes
+ *
+ * Use MIPI DisCo for Imaging device properties to finalize the initialization
+ * of CSI-2 software nodes for all ACPI device objects that have been already
+ * enumerated.
+ */
+void acpi_mipi_init_crs_csi2_swnodes(void)
+{
+	struct crs_csi2 *csi2, *csi2_tmp;
+
+	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry)
+		init_crs_csi2_swnodes(csi2);
+}
+
 /**
  * acpi_mipi_crs_csi2_cleanup - Free _CRS CSI-2 temporary data
  */
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -287,6 +287,7 @@ static inline void acpi_init_lpit(void)
 
 void acpi_mipi_check_crs_csi2(acpi_handle handle);
 void acpi_mipi_scan_crs_csi2(void);
+void acpi_mipi_init_crs_csi2_swnodes(void);
 void acpi_mipi_crs_csi2_cleanup(void);
 
 #endif /* _ACPI_INTERNAL_H_ */
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2447,6 +2447,13 @@ static void acpi_scan_postponed_branch(a
 
 	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
 			    acpi_bus_check_add_2, NULL, NULL, (void **)&adev);
+
+	/*
+	 * Populate the ACPI _CRS CSI-2 software nodes for the ACPI devices that
+	 * have been added above.
+	 */
+	acpi_mipi_init_crs_csi2_swnodes();
+
 	acpi_bus_attach(adev, NULL);
 }
 
@@ -2516,11 +2523,12 @@ int acpi_bus_scan(acpi_handle handle)
 		return -ENODEV;
 
 	/*
-	 * Allocate ACPI _CRS CSI-2 software nodes using information extracted
+	 * Set up ACPI _CRS CSI-2 software nodes using information extracted
 	 * from the _CRS CSI-2 resource descriptors during the ACPI namespace
-	 * walk above.
+	 * walk above and MIPI DisCo for Imaging device properties.
 	 */
 	acpi_mipi_scan_crs_csi2();
+	acpi_mipi_init_crs_csi2_swnodes();
 
 	acpi_bus_attach(device, (void *)true);
 
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -366,10 +366,24 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+#define ACPI_DEVICE_SWNODE_ROOT			0
+
+/*
+ * The maximum expected number of CSI-2 data lanes.
+ *
+ * This number is not expected to ever have to be equal to or greater than the
+ * number of bits in an unsigned long variable, but if it needs to be increased
+ * above that limit, code will need to be adjusted accordingly.
+ */
 #define ACPI_DEVICE_CSI2_DATA_LANES		8
 
 #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH	8
 
+enum acpi_device_swnode_dev_props {
+	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
+	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
+};
+
 enum acpi_device_swnode_port_props {
 	ACPI_DEVICE_SWNODE_PORT_REG,
 	ACPI_DEVICE_SWNODE_PORT_NUM_OF,
@@ -425,12 +439,14 @@ struct acpi_device_software_node_port {
 
 /**
  * struct acpi_device_software_nodes - Software nodes for an ACPI device
+ * @dev_props: Device properties.
  * @nodes: Software nodes for root as well as ports and endpoints.
  * @nodeprts: Array of software node pointers, for (un)registering them.
  * @ports: Information related to each port and endpoint within a port.
  * @num_ports: The number of ports.
  */
 struct acpi_device_software_nodes {
+	struct property_entry dev_props[ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES];
 	struct software_node *nodes;
 	const struct software_node **nodeptrs;
 	struct acpi_device_software_node_port *ports;
@@ -455,6 +471,7 @@ struct acpi_device {
 	struct acpi_device_data data;
 	struct acpi_scan_handler *handler;
 	struct acpi_hotplug_context *hp;
+	struct acpi_device_software_nodes *swnodes;
 	const struct acpi_gpio_mapping *driver_gpios;
 	void *driver_data;
 	struct device dev;



