Return-Path: <linux-kernel+bounces-77597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2108607EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB5A1F2340B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C141C121;
	Fri, 23 Feb 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQP7kBy5"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E5B642
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708649911; cv=none; b=BNDjeJVkW9C/n1TogjJsNKM+zYz8tuh7cTtb0dB5OkYRO6J56clFONXHmM17tu/+LvdLEKAq/FcziO/VshZNgdsLWIbSWiYrOcFvmOfFJtfNN7ILaZbT96/yK9GAQXo3LkfASqoLQ4gUqK1wcSYNgnYe9UD2sVr2w7vFyXH3OPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708649911; c=relaxed/simple;
	bh=v27iEZktilH2OnIdu1MjAvZd2ZBk3RvhRJ0/3icnfgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH1ZVhBhlEfWVKKlBW+UYD3j2NI4oylFS/RtWsDa4XO1A0/xZFuvf5sSZ3WMu83ooNlKWhsrqbhfnJW5ml7j/ftgcNG/4W7ZEPw+9mn1u2Tvm0ekBk2nLImEylB1PZiR0LLpN46HOxCRJCb/GcM8Oy6oyNDV4VWW5fA1gg1XN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YQP7kBy5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29951f5c2e7so326770a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708649909; x=1709254709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFIGIcteJ9nUdBATIDe99Xci9kTl4VUk6xpdoWZYz+c=;
        b=YQP7kBy5Xy3MOEWlVIcw/TuOWvCiTYhxMIIqKjBK770Lm1+Bik8jBQL77HFVwQzGgN
         cV4F/HZg+qPmiftfWx4MQUEJYRF17FZpqhRTHFivQcOSLw07Xr4/GEbKDP/TI+J4DaQi
         W5ggriQwi2juyi8Q+UMWoGVrIKTcuELuVaoRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708649909; x=1709254709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFIGIcteJ9nUdBATIDe99Xci9kTl4VUk6xpdoWZYz+c=;
        b=g1M4KSRJ4wdHKA00YUz7P/yZkzaLyVyOGcuiQLu7134uaiAU/8e736FpWiftHo2NOB
         EOERYt8y6nH5abVnEXuqW5LZNh4dn+flN/8uZzAKdRLhVGHR2MzDdP4H8ySxMj23cPhQ
         tLxkhRiwSQo/IOBBmNBRd7P+0lySUiIFEzmc9qDXy7xK8jnAik67t8inIBqzHbQ+aufQ
         zx67FttI8anbpc7ct78V1j9epo2IWmb2nCAaqhh1SozImlXw9Xk50tM5ClaQyrD32bNg
         MLL0dHPB1Etj/rz+gfTnwuhUOsSbXvWAH4lV55yodU/47CvP66gVEIesBHxViYrIA2D5
         uNiQ==
X-Gm-Message-State: AOJu0YxFXotJsz8BxlPpGidPcNBsd4ii952EFZBGhwvRzwj2d3z5wtK2
	VgQ7u4HrN48m4RRespbzK3ReGW6+7hXk7LtOUafhIsB5aTQxImL6YA/C2LaIrpxPfLtK05Th3zo
	=
X-Google-Smtp-Source: AGHT+IEBSCPkUmGUKRjkDv90CVcgR82fYuR4QpNUMg52O6n0E9LSt3G7aVY3l3oPEr/4l3QpXW0TZw==
X-Received: by 2002:a17:90a:5ae2:b0:299:4397:621c with SMTP id n89-20020a17090a5ae200b002994397621cmr440115pji.43.1708649909121;
        Thu, 22 Feb 2024 16:58:29 -0800 (PST)
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id m21-20020a17090ab79500b00298e11b600dsm116430pjr.27.2024.02.22.16.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 16:58:28 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Roy Luo <royluo@google.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-usb@vger.kernel.org,
	maciek swiech <drmasquatch@google.com>
Subject: [PATCH v2 2/2] usb: core: Set connect_type of ports based on DT node
Date: Thu, 22 Feb 2024 16:58:21 -0800
Message-ID: <20240223005823.3074029-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240223005823.3074029-1-swboyd@chromium.org>
References: <20240223005823.3074029-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a USB hub is described in DT, such as any device that matches the
onboard-hub driver, the connect_type is set to "unknown" or
USB_PORT_CONNECT_TYPE_UNKNOWN. This makes any device plugged into that
USB port report their 'removable' device attribute as "unknown".
ChromeOS userspace would like to know if the USB device is actually
removable or not so that security policies can be applied. Improve the
connect_type attribute for ports, and in turn the removable attribute
for USB devices, by looking for child devices with a reg property or an
OF graph when the device is described in DT.

If the graph exists, endpoints that are connected to a remote node must
be something like a usb-{a,b,c}-connector compatible node, or an
intermediate node like a redriver, and not a hardwired USB device on the
board. Set the connect_type to USB_PORT_CONNECT_TYPE_HOT_PLUG in this
case because the device is going to be plugged in. Set the connect_type
to USB_PORT_CONNECT_TYPE_HARD_WIRED if there's a child node for the port
like 'device@2' for port2. Set the connect_type to USB_PORT_NOT_USED if
there isn't an endpoint or child node corresponding to the port number.

To make sure things don't change, only set the port to not used if
there are child nodes. This way an onboard hub connect_type doesn't
change until ports are added or child nodes are added to describe
hardwired devices. It's assumed that all ports or no ports will be
described for a device.

Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: maciek swiech <drmasquatch@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/usb/core/of.c   | 71 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/port.c |  2 ++
 include/linux/usb/of.h  |  7 ++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
index db4ccf9ce3d9..f1a499ee482c 100644
--- a/drivers/usb/core/of.c
+++ b/drivers/usb/core/of.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/usb/of.h>
 
 /**
@@ -75,6 +76,76 @@ bool usb_of_has_combined_node(struct usb_device *udev)
 }
 EXPORT_SYMBOL_GPL(usb_of_has_combined_node);
 
+static bool usb_of_has_devices_or_graph(const struct usb_device *hub)
+{
+	const struct device_node *np = hub->dev.of_node;
+	struct device_node *child;
+
+	if (of_graph_is_present(np))
+		return true;
+
+	for_each_child_of_node(np, child)
+		if (of_property_present(child, "reg"))
+			return true;
+
+	return false;
+}
+
+/**
+ * usb_of_get_connect_type() - get a USB hub's port connect_type
+ * @hub: hub to which port is for @port1
+ * @port1: one-based index of port
+ *
+ * Get the connect_type of @port1 based on the device node for @hub. If the
+ * port is described in the OF graph, the connect_type is "hotplug". If the
+ * @hub has a child device has with a 'reg' property equal to @port1 the
+ * connect_type is "hard-wired". If there isn't an OF graph or child node at
+ * all then the connect_type is "unknown". Otherwise, the port is considered
+ * "unused" because it isn't described at all.
+ *
+ * Return: A connect_type for @port1 based on the device node for @hub.
+ */
+enum usb_port_connect_type usb_of_get_connect_type(struct usb_device *hub, int port1)
+{
+	struct device_node *np, *child, *ep, *remote_np;
+	enum usb_port_connect_type connect_type;
+
+	/* Only set connect_type if binding has ports/hardwired devices. */
+	if (!usb_of_has_devices_or_graph(hub))
+		return USB_PORT_CONNECT_TYPE_UNKNOWN;
+
+	/* Assume port is unused if there's a graph or a child node. */
+	connect_type = USB_PORT_NOT_USED;
+
+	np = hub->dev.of_node;
+	/*
+	 * Hotplug ports are connected to an available remote node, e.g.
+	 * usb-a-connector compatible node, in the OF graph.
+	 */
+	if (of_graph_is_present(np)) {
+		ep = of_graph_get_endpoint_by_regs(np, port1, -1);
+		if (ep) {
+			remote_np = of_graph_get_remote_port_parent(ep);
+			of_node_put(ep);
+			if (of_device_is_available(remote_np))
+				connect_type = USB_PORT_CONNECT_TYPE_HOT_PLUG;
+			of_node_put(remote_np);
+		}
+	}
+
+	/*
+	 * Hard-wired ports are child nodes with a reg property corresponding
+	 * to the port number, i.e. a usb device.
+	 */
+	child = usb_of_get_device_node(hub, port1);
+	if (of_device_is_available(child))
+		connect_type = USB_PORT_CONNECT_TYPE_HARD_WIRED;
+	of_node_put(child);
+
+	return connect_type;
+}
+EXPORT_SYMBOL_GPL(usb_of_get_connect_type);
+
 /**
  * usb_of_get_interface_node() - get a USB interface node
  * @udev: USB device of interface
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc907..da910d3e40f6 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
 #include <linux/component.h>
+#include <linux/usb/of.h>
 
 #include "hub.h"
 
@@ -708,6 +709,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		return -ENOMEM;
 	}
 
+	port_dev->connect_type = usb_of_get_connect_type(hdev, port1);
 	hub->ports[port1 - 1] = port_dev;
 	port_dev->portnum = port1;
 	set_bit(port1, hub->power_bits);
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index 98487fd7ab11..de42f14bd280 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_USB_OF_H
 #define __LINUX_USB_OF_H
 
+#include <linux/usb.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/phy.h>
@@ -17,6 +18,7 @@ enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0);
 bool of_usb_host_tpl_support(struct device_node *np);
 int of_usb_update_otg_caps(struct device_node *np,
 			struct usb_otg_caps *otg_caps);
+enum usb_port_connect_type usb_of_get_connect_type(struct usb_device *hub, int port1);
 struct device_node *usb_of_get_device_node(struct usb_device *hub, int port1);
 bool usb_of_has_combined_node(struct usb_device *udev);
 struct device_node *usb_of_get_interface_node(struct usb_device *udev,
@@ -37,6 +39,11 @@ static inline int of_usb_update_otg_caps(struct device_node *np,
 {
 	return 0;
 }
+static inline enum usb_port_connect_type
+usb_of_get_connect_type(const struct usb_device *hub, int port1)
+{
+	return USB_PORT_CONNECT_TYPE_UNKNOWN;
+}
 static inline struct device_node *
 usb_of_get_device_node(struct usb_device *hub, int port1)
 {
-- 
https://chromeos.dev


