Return-Path: <linux-kernel+bounces-55788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8F184C1C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6420F28819F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20EEDDA3;
	Wed,  7 Feb 2024 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJK4VpMx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545A9460
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268695; cv=none; b=ssuq6T5oNSDjgU9gCPqWf9Wx2oiTFC554pBnil4mMonUrJ5sSU6fW6hIxHE2DenbnPzZMyCNRatYYqVcPLocfhm9nFN89A68A592NYVp70XB4LsIjnMhC8D6qWYksj6vUz3Jjq+YVxS4cMS0sq2r5OpOQEgfyAr3QlDGfzaubyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268695; c=relaxed/simple;
	bh=/sB8l6KWYH6DGCMNn36V9/w/rBzTre/Ew1T/Fov0yTA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=EiaWZvF+HFjUxMecxdBsnsryfZnvu98sCG5DwMF2Oh6rxA8YuDAqmf3ww1e02CdGXp9EFaLke8WaUcIlswNuk9hdThfS823c+NmCGePWIkE7JJo/ST/Pll/64b6LJ+9Cj0Wcwy3rL/oRppZxVBsRR898YQYdSe6bSi77NLdcLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJK4VpMx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so313389276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 17:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707268693; x=1707873493; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nuaW4jYZxVUVmSijc5joqXItCJVV2wzRbkaJo6WoHUs=;
        b=WJK4VpMxU4QTcyBxl96JWvvQu4iGzy7oe9i0fqN8z80g7jni06UaAYhxEK4F/bK0Rh
         oUB16eYgKY+PoanKIZxEsAsi/1WErAXefawXyPBDgmy8PLiEcginrXZtCv9PaeOIrP24
         fpW8MOPu1UKXXksZNPyEnNedyeroPT+iJADCnIuuEpO5ly8CngPdsGUJJcSgrhnccLrX
         iyOtB3LVc/LrA+UFtEpctQO++UVqRTy3SQjmDmzkBLh8ibzZ78FJMZNSYcKNsM11gL4J
         bgxTOZHEYE9eTtqZhORpUhxa4ByA70fySxIhQxNo5xcYJq90binsOAlGVllpyrEnjhw4
         Gibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707268693; x=1707873493;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuaW4jYZxVUVmSijc5joqXItCJVV2wzRbkaJo6WoHUs=;
        b=w1PFRYINyv0AHYcJMlQOPM+wZN58HzO4Yz8SiZ5PrfKQ/aA/pE6DTVd04lSY8RFddA
         LiWS0wUKM4o1+dJFb5dc+uCisJP8O03Y2xnT9fdQcj5jMeG3+ohjos/ly2nYaOXkf3Pc
         UMthx8IWu1/Kb1JDOzwc6YIpPdiTHEouyco0f0gOX6/0fYLxFh/qum2zsX+x2SwzZin9
         qVWjmFFfpZ/pzgrjALc1C8t19/k93cpYutb9E0KWjxivArttoFYAXUCOK5Kqg0/soDpA
         2biCTkOn9qGvZvCSHSFaY3AkK01iWkjTlQJSxmCfydRXxk8BhXoRNUjDTymhr4IBkrbw
         XN3Q==
X-Gm-Message-State: AOJu0YwYCiZS6s5Tbb/OX7sgR/sVWl/oD+/C8k6FjRQm7k5Kc292XsOx
	c21nPaXTdCkhZ0hinR1YNa1N+YnAcm56admWiHNN2v9xu50iTFG/3d7d6xGmqKqaRWnsU1Jgsa0
	1bUWOMQMZOj9lxw==
X-Google-Smtp-Source: AGHT+IEwboo8+/tjNQ/s5pGJKHWDjeFlgB70RN5OuTbjiwqwhnO+MKLTbJv+/GxEoj3g4xpPxYrf1MNH+TesvQ0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:dc84:66b8:120:935a])
 (user=saravanak job=sendgmr) by 2002:a25:ce0a:0:b0:dc7:31a4:23f6 with SMTP id
 x10-20020a25ce0a000000b00dc731a423f6mr73359ybe.2.1707268693254; Tue, 06 Feb
 2024 17:18:13 -0800 (PST)
Date: Tue,  6 Feb 2024 17:18:00 -0800
In-Reply-To: <20240207011803.2637531-1-saravanak@google.com>
Message-Id: <20240207011803.2637531-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 1/3] of: property: Improve finding the consumer of a
 remote-endpoint property
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have a more accurate function to find the right consumer of a
remote-endpoint property instead of searching for a parent with
compatible string property. So, use that instead. While at it, make the
code to find the consumer a bit more flexible and based on the property
being parsed.

Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 47 +++++++++----------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 641a40cf5cf3..da70aaa62ca3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1063,36 +1063,6 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 	return of_device_get_match_data(dev);
 }
 
-static struct device_node *of_get_compat_node(struct device_node *np)
-{
-	of_node_get(np);
-
-	while (np) {
-		if (!of_device_is_available(np)) {
-			of_node_put(np);
-			np = NULL;
-		}
-
-		if (of_property_present(np, "compatible"))
-			break;
-
-		np = of_get_next_parent(np);
-	}
-
-	return np;
-}
-
-static struct device_node *of_get_compat_node_parent(struct device_node *np)
-{
-	struct device_node *parent, *node;
-
-	parent = of_get_parent(np);
-	node = of_get_compat_node(parent);
-	of_node_put(parent);
-
-	return node;
-}
-
 static void of_link_to_phandle(struct device_node *con_np,
 			      struct device_node *sup_np)
 {
@@ -1222,10 +1192,10 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  *  parse_prop.prop_name: Name of property holding a phandle value
  *  parse_prop.index: For properties holding a list of phandles, this is the
  *		      index into the list
+ * @get_con_dev: If the consumer node containing the property is never converted
+ *		 to a struct device, implement this ops so fw_devlink can use it
+ *		 to find the true consumer.
  * @optional: Describes whether a supplier is mandatory or not
- * @node_not_dev: The consumer node containing the property is never converted
- *		  to a struct device. Instead, parse ancestor nodes for the
- *		  compatible property to find a node corresponding to a device.
  *
  * Returns:
  * parse_prop() return values are
@@ -1236,8 +1206,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
 struct supplier_bindings {
 	struct device_node *(*parse_prop)(struct device_node *np,
 					  const char *prop_name, int index);
+	struct device_node *(*get_con_dev)(struct device_node *np);
 	bool optional;
-	bool node_not_dev;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1352,7 +1322,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_pinctrl6, },
 	{ .parse_prop = parse_pinctrl7, },
 	{ .parse_prop = parse_pinctrl8, },
-	{ .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
+	{
+		.parse_prop = parse_remote_endpoint,
+		.get_con_dev = of_graph_get_port_parent,
+	},
 	{ .parse_prop = parse_pwms, },
 	{ .parse_prop = parse_resets, },
 	{ .parse_prop = parse_leds, },
@@ -1403,8 +1376,8 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
 			struct device_node *con_dev_np;
 
-			con_dev_np = s->node_not_dev
-					? of_get_compat_node_parent(con_np)
+			con_dev_np = s->get_con_dev
+					? s->get_con_dev(con_np)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-- 
2.43.0.594.gd9cf4e227d-goog


