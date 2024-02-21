Return-Path: <linux-kernel+bounces-75659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4581B85ED03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DB31F22443
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428D912DD9C;
	Wed, 21 Feb 2024 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aVy5DJ6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C51E485
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558273; cv=none; b=XRyhkMx4pZPvHGEMCQehS0ExFmDXhhakkQ5kQ9zXjVS+ssB8Hp20EcSa/o7C1mwsIhb1CQ7Xi/spopodr4LAc6JC1hZ/IgPWkaiM4h1zXtpXD5refIRkUmgjb4HAHrj/iQW1dn50c8Arw+BuymbF5UAaLPRQ2UpQCsitMDsTWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558273; c=relaxed/simple;
	bh=BYJ0NZJqbtsDWKL5M2UsBKoeU9XD22jULrfryxgvv50=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=LDY5tdSr/DhXJFxBDt9lca4snHxBPkDn6oWkwPxvojBF5vOkU+UZcU0ijQvum/NS2wLoEhKzCDoxbSFPSvECRMcRGEY/ZveGLAveNAkMTS6j/0JxjR70jRUdpX90fXeQtNUh1wnvf7vQVGYKf0bHjLMMRday348iJpjkNdqwTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aVy5DJ6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6082ad43ca1so64080387b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708558247; x=1709163047; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=raWZBAYgki529t/WhxJsWod/PF9BbEcSvIxTt/14UCc=;
        b=0aVy5DJ6UiwYuSWxHynSSNBrX0riB5eUc556Vc1drbCSyrGPafZgvS5eb1yoFYTGVn
         Y5Bw4xsR1F70uv2NiiuhRxLG6WnzQdb8g0xsbLp2kqc7B1Jxa7qM1gD7LTKwCO+7dRqO
         ZOrE3dcCDAVZsuMdAlWC69x1VPhOwXW9PWq1G8hU9KDWxh+4Yo/Bm/YV582X+PICN5oa
         nSfxJnvoUeiKmJOS3QOLpQGbke2SIRIuVE6GG/vDaUXhLy8ZJ/4sge+c57KccfFbP1Qo
         miDEnOoh83N9QulTp8eB8YGOkA6cDzEumB2RAeQT8oo8vRwh4lpKHUrX2RXVRUrUw1qo
         uhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558247; x=1709163047;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raWZBAYgki529t/WhxJsWod/PF9BbEcSvIxTt/14UCc=;
        b=iLCpzi6D2Q429s9YQ3Toi0o7jOxMcvPYhOlrPr1dyutWOQ0P3IeJYJ8YtSBj2eYA0i
         B9GJA6GIpYEX+vIS3Jnl0vHeh5E5T+F7gXOqHF0mVxQtICsd/aid0jixGzudnAUpt/ra
         GlotB78zUoNIRFxPlsg31o5lKdF8jYCreNpxIe7kkcqdO34+mwfLQ9KHpH4HJZ00bxVJ
         ciE7dONv4AxposMhzsDER4od30Vx+C6mMgkEw0TFuDjqSV/PBg80DcH1jZXcVfnYS4fA
         PGf0WYj4I7WorN9WUfq7+7WEZymOBiJYUBqhravMr0CeeLF5KVkc5lRifgg/ewJgCbMp
         FZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1bZmH/HduBfN5fJJHCeZn5/w6BMqJtYV8O09Rv5zzVMqWojJM/nn8nyK61X7mjYHuthremm3wFR6JT8RcoYa9UJYj6NeOA+QE95q
X-Gm-Message-State: AOJu0Yza+oDu/RbNwh/gpeUTa3ngcFY/2QBTV7joVnWaaDd7uLQs+KiH
	m15xijAtlJe4ZjLpWAQKo6rYBhIy84aN2XzDsctTF3sZHWiIDEUrmVryObhpoXNctZ9qpDnesuN
	6acu6q4D4yGb0Ug==
X-Google-Smtp-Source: AGHT+IGgZQ1l5nN7Scny5xaRPZoni0Nwbb4vLb4HGhCMU5ZJL49Vr3OCwBeSk4ZIPAFozDNmtt8y5EkxJu29Ys4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4e1e:336a:2b30:13fe])
 (user=saravanak job=sendgmr) by 2002:a0d:d685:0:b0:607:7564:a830 with SMTP id
 y127-20020a0dd685000000b006077564a830mr3405493ywd.0.1708558246788; Wed, 21
 Feb 2024 15:30:46 -0800 (PST)
Date: Wed, 21 Feb 2024 15:30:24 -0800
In-Reply-To: <20240221233026.2915061-1-saravanak@google.com>
Message-Id: <20240221233026.2915061-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v3 4/4] of: property: fw_devlink: Add support for
 "post-init-providers" property
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
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
index bce849f21ae2..15ccad6cba4a 100644
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
+DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1349,6 +1355,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{
+		.parse_prop = parse_post_init_providers,
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
2.44.0.rc0.258.g7320e95886-goog


