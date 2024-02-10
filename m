Return-Path: <linux-kernel+bounces-60313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65C850312
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E655B240DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F208C39FC4;
	Sat, 10 Feb 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jz/ArCb7"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C738F91
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548995; cv=none; b=lL5/9yyXHCiDkQaf/fbOe4J7rUPU3J4QI4Ir2yY+OuSc3PAuWRGTZiSOcPInpcAenybSkqVFqhecEzalrRM2+RV5ZQt03SKQGyuVMkbF6oUfKyY7fHQCACOkJszbh7ZV9kqllcwQhis8xrM/XRn2Hg/WQXzd23eiU5EAEEZdzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548995; c=relaxed/simple;
	bh=Mzv0e8b5maH+R5VJl6DotCRRWAOOTWYpXPhTaIdR8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPa+xCSmQxmRwYtOrjVeNK2kgiFX3ytv5PL0c6LDJ7ZBjqgE6KzxA6TYMww0Rc1j0DsQwOrBWkrizRGY3R9sQdjnVjx7A/CmmeTUEECTmNwVpZ6ZLChO+k7xMhCy6ib+WyPZWy1LEc/4q7Kf3DvgFNTxlaykQMzzKKzvOUdeBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jz/ArCb7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e12d0af927so1090964a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548992; x=1708153792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zER2Ilw0QhxMBzy8PRis9D7e+HIgnB5hYCQzM4YYso=;
        b=jz/ArCb7aEf0XnTaxG1zjmhkLoFwyxZZaMLIe+xtmyAQQnbAY24szJImOrWBYYXqYQ
         s2fWTnNfG1703YCto5g2pF4m5/7itmj/NfS1smC/ix2iJ008hcD/8TM2hqOmKGEIhwLU
         e9tJQTKxexhottbvJNZsp8nD7CmBkB87TuaME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548992; x=1708153792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zER2Ilw0QhxMBzy8PRis9D7e+HIgnB5hYCQzM4YYso=;
        b=hZecS59S3DFmiQkmX+CYHrGdozinuAsCJzoH/Wvo4pj4mb45m0WvHTIrKXb0jqu4Ji
         5UVEdZs9fI+MvrXi85HFRk6sbMrswM8PRU+9fEI1p30YmKIeEgR9tytGlCo+kg7fD1p1
         7nmPxbwHoaYCEy28ezXf6FPUsvHiItnoeo/P54MB8ZfYA+zMMmi3h0UQlxGcZ9Dc2iOS
         bEvnvCG2Cz4EOvy7OxBh9i0XZUlZc+CBvyob9o6hkcRUABBg0hV0axgcjxM61g92jCvj
         2TkfkHQqMu34Pvi/BWeT9i2R4WoiU2V0CteXvzc4B0AvD8/hJltRAhWYHNVw+bJG+8Dx
         zKUQ==
X-Gm-Message-State: AOJu0Yws1bViS3vSEubEetxA9/m0QCw63reAUPh1TxVRNkr6yuVpLhP5
	6hJSlhxMHiskYZVw+E9t8z1s5vJZPiGNJFwlarIN09RN9XUO3fWB6VWr9u6+XA==
X-Google-Smtp-Source: AGHT+IGycCUB3DMpwmXjgXOSlrrSzr1olN6zo2Ub4XCvqi0LH8LyLdUzUKkoFY+1tflxHElqI+m7OA==
X-Received: by 2002:a9d:76d6:0:b0:6dd:dd86:ad81 with SMTP id p22-20020a9d76d6000000b006dddd86ad81mr1490798otl.14.1707548992033;
        Fri, 09 Feb 2024 23:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWItJfkduQ4ZlMb/4WI7wMAHcsdDlwLJlkD/syq6yJf1sHeXjYYBIe/frbmiy2XGR50jAWFjh9GanqxX17f+9vt7lUWBccaf/pksRS1ZUnaOkGP4dsQwnsx4zPGeqe43Z6C2X4iWLb/Q42Ko20wMp5+d7KTL4cQ0T9VPc0Z0x02Q6Dx+CIG4ziunVGuwntKCgGgDiMcyfUKwU01vEtnRrfZLHGsZYtXzK1umwuiFrXDznvJZnpN1VFqnk5qw9F5CIHJXQ1cNUpESF9mPy5SkuKua+aAdxO81ycYVQ5ClhPOQzHr0mfcZyUwh1ey7EDduqAuq8v/zJkwd3HDl1vSknkzlzPO7ws3fFF/Y2v5CZTUXwtR5EqYwwhLJWXoBzwaCdlC/28MFNSXvMPPPRS7GI0YN9O/JgHHx4MIJV0YthaE583CCVMKPD+5cQolzSPifOhy/9eGQxmb6hzwiZvi6CIRfuQj0SobOxZPh36DEJ68I7dl368YlcYb8kCiQAG7fmsAbs7ru8zRdnRsnNg1IU3FltumjwDbfwJBAj2zz0JksLQHKZL5Co94BVGmDzEL63lWOxFLaBnGEPWOW3aYiRUfa8JGVlNmH2cAikNC+tptaFMse3Aqg5sDg8eq1nQur7Ss0h+xuFfTmw3DIvxVR35+3g983eWVTucCBMlQeVx9fuGCIEgJ4+4zhcPsG3j/oVi1hhfegECRwMJ0NePewQjjHsJnyBsiGvmWFdp4RQfFg/wj6T7sZdPV0KdSPX93F2ZbOok58pOGEzxthPwChtL+GP4mm0ENWmjuf8+xS6KNk/rlaETSsg3C5saKLtn8j9epQEnkJQ==
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id y30-20020a63b51e000000b005dc5289c4edsm2717207pge.64.2024.02.09.23.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:09:51 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 07/22] device property: Add remote endpoint to devcon matcher
Date: Fri,  9 Feb 2024 23:09:18 -0800
Message-ID: <20240210070934.2549994-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a single DT node has a graph connected to more than one
usb-c-connector node we can't differentiate which typec switch
registered for the device is associated with the USB connector because
the devcon matcher code assumes a 1:1 relationship between remote node
and typec switch. Furthermore, we don't have a #typec-switch-cells
property so there can only be one node per typec switch.

Support multiple USB typec switches exposed by one node by passing the
remote endpoint node in addition to the remote node to the devcon
matcher function (devcon_match_fn_t). With this change, typec switch
drivers can register switches with the device node pointer for a graph
endpoint so that they can support more than one typec switch if
necessary. Either way, a DT property like 'mode-switch' is always in the
graph's parent node and not in the endpoint node.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/property.c     | 7 +++++--
 drivers/usb/roles/class.c   | 4 ++--
 drivers/usb/typec/mux.c     | 8 ++++++++
 drivers/usb/typec/retimer.c | 7 ++++++-
 include/linux/property.h    | 5 +++--
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..cae81ed4e298 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1289,6 +1289,7 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
 {
 	struct fwnode_handle *node;
 	struct fwnode_handle *ep;
+	struct fwnode_handle *remote_ep;
 	unsigned int count = 0;
 	void *ret;
 
@@ -1304,7 +1305,9 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
 			continue;
 		}
 
-		ret = match(node, con_id, data);
+		remote_ep = fwnode_graph_get_remote_endpoint(ep);
+		ret = match(node, remote_ep, con_id, data);
+		fwnode_handle_put(remote_ep);
 		fwnode_handle_put(node);
 		if (ret) {
 			if (matches)
@@ -1334,7 +1337,7 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
 		if (IS_ERR(node))
 			break;
 
-		ret = match(node, NULL, data);
+		ret = match(node, NULL, NULL, data);
 		fwnode_handle_put(node);
 		if (ret) {
 			if (matches)
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index ae41578bd014..9a0ef5fa0a19 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -89,8 +89,8 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static void *usb_role_switch_match(const struct fwnode_handle *fwnode, const char *id,
-				   void *data)
+static void *usb_role_switch_match(const struct fwnode_handle *fwnode, const struct fwnode_handle *endpoint,
+				   const char *id, void *data)
 {
 	struct device *dev;
 
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 80dd91938d96..3eabd0d62f47 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -33,6 +33,7 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
 }
 
 static void *typec_switch_match(const struct fwnode_handle *fwnode,
+				const struct fwnode_handle *endpoint,
 				const char *id, void *data)
 {
 	struct device *dev;
@@ -55,6 +56,9 @@ static void *typec_switch_match(const struct fwnode_handle *fwnode,
 	 */
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
+	if (!dev)
+		dev = class_find_device(&typec_mux_class, NULL, endpoint,
+				switch_fwnode_match);
 
 	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
@@ -263,6 +267,7 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 }
 
 static void *typec_mux_match(const struct fwnode_handle *fwnode,
+			     const struct fwnode_handle *endpoint,
 			     const char *id, void *data)
 {
 	struct device *dev;
@@ -280,6 +285,9 @@ static void *typec_mux_match(const struct fwnode_handle *fwnode,
 
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
+	if (!dev)
+		dev = class_find_device(&typec_mux_class, NULL, endpoint,
+					mux_fwnode_match);
 
 	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 4a7d1b5c4d86..eb74abee6619 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -22,7 +22,9 @@ static int retimer_fwnode_match(struct device *dev, const void *fwnode)
 	return is_typec_retimer(dev) && device_match_fwnode(dev, fwnode);
 }
 
-static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char *id, void *data)
+static void *typec_retimer_match(const struct fwnode_handle *fwnode,
+				 const struct fwnode_handle *endpoint,
+				 const char *id, void *data)
 {
 	struct device *dev;
 
@@ -31,6 +33,9 @@ static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char
 
 	dev = class_find_device(&retimer_class, NULL, fwnode,
 				retimer_fwnode_match);
+	if (!dev)
+		dev = class_find_device(&retimer_class, NULL, endpoint,
+					retimer_fwnode_match);
 
 	return dev ? to_typec_retimer(dev) : ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 9f2585d705a8..0f20df1f0a49 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -455,8 +455,9 @@ unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
 int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
 
-typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode, const char *id,
-				   void *data);
+typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode,
+				   const struct fwnode_handle *endpoint,
+				   const char *id, void *data);
 
 void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
-- 
https://chromeos.dev


