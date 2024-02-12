Return-Path: <linux-kernel+bounces-62396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE2851FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C2BB226EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C110E4E1B3;
	Mon, 12 Feb 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHBx6F9b"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED64E1BA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773527; cv=none; b=l0a4FObi3ryzkKcCpiIEVn7JBNYRmgJvgOO9s/XzALTkzlDvPlMFQy75vMPE7PioEhzTEasUoReehWwH0TjyKFeUk+WzO3RaCOlCF2u4zPV4gsNvGQ7WssDVp+gkf2o1Gx7l9JMJXKqyrHTbzAmMma0G8o8BnXRXhi63JD2VtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773527; c=relaxed/simple;
	bh=09nOuvy1xCjK1iYqCopDQXrnPVKpNm2a5rJaJXsm9lU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=gPTObIHDc3YOxhcWmHFVs4isG0eS0Idwf1jxzziL218mtx/JUjF2VR2sZsYbi3QYnpkK+3Myuw/AZiavasZrYZrElQEXdE3K5Dgh0GsR0vpC+Hzhu1I4NHwEji2Q+oX+wVE7rb+yzQ3aHve8K71RQO3jvqvxrjGOnm1fflxAyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHBx6F9b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60761bdbd4cso19722607b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773524; x=1708378324; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5s7UC2LI5606ztlkySRh4zEDw9ZNIX2+7Suzh+XsVU=;
        b=OHBx6F9bhwsJvj9SRIzninQd62CTd0mat67Ry0G4dzfpMXC9lLLH/2cqAtkPZBKWOs
         rCJlNGFOdzUHHSyx00VaV5roKpsat69I49vXVWf9nM10D5g6AdFuX3akbE1MiBcmwf/3
         U//fWlNw92ilZqOqSovV9mdpvdT5dJ202Xq3Gnl5XmSg5+K/5u0KYaPEpqu1aRUQ7I8R
         bMzmPnomy8vPKmO1iyBgm0mVL9Emn4B+OM9TotHLWNPRZjnhPKrNz83/FOQvMN7JijYp
         UeCGftAtQwFbnm3brtQMnWqc1osOv0HsjGW9FkVb887vW7Th/2S/CTchqaHupDFuZYjz
         CGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773524; x=1708378324;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5s7UC2LI5606ztlkySRh4zEDw9ZNIX2+7Suzh+XsVU=;
        b=UgR019Y3597SWfbEaG3CYAEgb4XdC/hs+D7erI+FfFm6ExlN5HFDnjdzm5zZMDDVhK
         DqvgV3Tl7TsdSBwY65xGq3SVNA46DVj9SaNBOQ0UReWdsKsd17YuYRtSShFCDU7c1MX1
         E7RIOa8OK75OnzWCq/sr5MCIDTh7sBIqo8MCuOQFIrcJxrnKba3xQCWGfgBjse4/o8U2
         f0B9TYPaq7Z+gLrYiQFmjP6qIqn1Gspd61hl6gndyJEK9OICfF/9v0PjJ7y8SzQdm7dN
         dRpIoGK6wuyYmrMONPSeosnNaYQPzEr+TF+f57cG+oTXB1Cq72F/YHW02tkGiEULvaJP
         GRKw==
X-Forwarded-Encrypted: i=1; AJvYcCVzVLz9U0qXd+uKYShnhwiSa9/GqS1ssxTkY7rpSVeEnH7QAXBYXPR3cwRIMD/aw4uAAEgz1G7WfLfXjsk06rn3E+sJKz20twECfHhx
X-Gm-Message-State: AOJu0YwzlZ5/Um/pDRecvzHUf6wiTQGenhP5wJQHWtAq7Zw9HFAdLnWI
	Xt9g01dTQF1KasV9HHfaJxR1BW71QS+WoMTeLVEsRhkF9O3Rfvr1tjpnL9J8DGynPc/b2hdyVIa
	Jd5o0YdgCT6C9/w==
X-Google-Smtp-Source: AGHT+IHiNYw+GukjhfLl9L/fVI79H8vPnI8fJB4kfhzgTN7MWnsY3Vn7qmvxy/2wW9UUYOelc46oL3dxnDIBR8A=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:496d:5de1:a404:8bee])
 (user=saravanak job=sendgmr) by 2002:a05:6902:120b:b0:dc7:6efe:1aab with SMTP
 id s11-20020a056902120b00b00dc76efe1aabmr1793262ybu.6.1707773524580; Mon, 12
 Feb 2024 13:32:04 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:45 -0800
In-Reply-To: <20240212213147.489377-1-saravanak@google.com>
Message-Id: <20240212213147.489377-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v2 4/4] of: property: fw_devlink: Add support for
 "post-init-supplier" property
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for this property so that dependency cycles can be broken and
fw_devlink can do better probe/suspend/resume ordering between devices in a
dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 751c11a28f33..dce451161c99 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1066,7 +1066,8 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 }
 
 static void of_link_to_phandle(struct device_node *con_np,
-			      struct device_node *sup_np)
+			      struct device_node *sup_np,
+			      u8 flags)
 {
 	struct device_node *tmp_np = of_node_get(sup_np);
 
@@ -1085,7 +1086,8 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np),
+			flags);
 }
 
 /**
@@ -1198,6 +1200,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  *		 to a struct device, implement this ops so fw_devlink can use it
  *		 to find the true consumer.
  * @optional: Describes whether a supplier is mandatory or not
+ * @fwlink_flags: Optional fwnode link flags to use when creating a fwnode link
+ *		  for this property.
  *
  * Returns:
  * parse_prop() return values are
@@ -1210,6 +1214,7 @@ struct supplier_bindings {
 					  const char *prop_name, int index);
 	struct device_node *(*get_con_dev)(struct device_node *np);
 	bool optional;
+	u8 fwlink_flags;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1240,6 +1245,7 @@ DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
+DEFINE_SIMPLE_PROP(post_init_supplier, "post-init-supplier", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1349,6 +1355,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{
+		.parse_prop = parse_post_init_supplier,
+		.fwlink_flags = FWLINK_FLAG_IGNORE,
+	},
 	{}
 };
 
@@ -1393,7 +1403,8 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-			of_link_to_phandle(con_dev_np, phandle);
+			of_link_to_phandle(con_dev_np, phandle,
+					   s->fwlink_flags);
 			of_node_put(phandle);
 			of_node_put(con_dev_np);
 		}
-- 
2.43.0.687.g38aa6559b0-goog


