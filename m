Return-Path: <linux-kernel+bounces-55789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828884C1C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4421C2476F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3EDE55F;
	Wed,  7 Feb 2024 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlxjDbVI"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB8DDB3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268698; cv=none; b=GOuR19FLZbovcBcZY16wOaJvJzw4THwil1R3ShCebIDsVc9BIIo0OaOrZ1v2oyUQbCNwovC47Tyy9r3GkqGdTXUvmDjUsiqMhD5LCMcgUOvMUf1bZBJEfk74jXDQYV5UPLhXp1xlEX5fooFqyovsnm9tsPEXygOEgyY9VFQsYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268698; c=relaxed/simple;
	bh=T62blaTiqzQLizGlfVWivOeIOmYziapjvmFfizRpV/g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jht1oxlFbu18aHiCoWsWi/xnrYAt4Vq62ixapMCctTZLZjnM7A3P3R/miDsb9MbgV2p3GKW80rB5EfLy8HBhyEUFvzT31yL99AmMWpnio0kl6OI8p9JagimqarzU2pH+CtTZtzK/mdpFPT3HeLFUhougIuYq2kaTC8jhNzWUa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlxjDbVI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041dbb7a78so2167707b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707268696; x=1707873496; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzwZNLSU6r/5TPCVrrLL62lmP2jEiRWNyfq6bcL8Mo0=;
        b=XlxjDbVIImD32kab5Kwo4YlVC7p8+E8aqJhRxHw3ADM7ebhWgRPO248dnC29vQAOaG
         8fs2LK5ke80mt3oM3xQ7xaHCMTPvghS7nxPe7wS9M6vPWvfIP9wgqDxI04Pj2nxE2cV0
         TWqzX4gBKVZ7cVirmgAZGQVCNDU/GdonLXs8DZ3z39gyU/9X/lo72EYCOvCoOsnRUUKi
         pH/LJfuVjZSoU6ounkkuxr2ptpwITbHFlTk2hlfc+Et5z0jLiJRvhIF9FHFqyME4N1Hk
         gPTHPItW5S3AMDYmuA0Q/mwPUwI8zJkX6tLZjWFQS3XUtMQzYhYiNhQaUQqF8W0pa0cl
         TBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707268696; x=1707873496;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzwZNLSU6r/5TPCVrrLL62lmP2jEiRWNyfq6bcL8Mo0=;
        b=lDNgWEpV+qwITySQ/wes1wv7Ncpisin73+4ReGvHi0XOKJ74Ml2EDjxzoUN7/TzY0o
         viBL6sKHJ6g4LHHqRjTJ2wuS19b22bD8WYk7SistcNy35EZlOQd1LM6QPYT9/9UKjDTS
         5tuRAfwQuBwWhnKbR4lQ0NxdafJ8IxrqMEy15wv2sz2+Ss+irRVOOcN7anK98T0C9ArM
         KhK40kJHVgrQIRIZjY3uBwZJ9vnakRepTk9CYui2aHPMBD6ynA83eBbuzs8HZnK1q6o+
         ON24jcv3aYV7nvTgIaYBZh4xt+1SuL2UeI5dgiPWCIahoRA4jSSTQJsu7CCsn1QJUZ2q
         fgSA==
X-Gm-Message-State: AOJu0YypHRFFQTBGuOQwF0avdCZZAEVvjotahzMsmU7sG5m86gUta6yi
	rNUSmJxnYS7M1m7LEYbdYCU+qoWoug5Fup2/8rWygxOCbkJPLOgBdwWN31UpFndMfWyriQdwIiS
	W1itVVOxmaL3J/g==
X-Google-Smtp-Source: AGHT+IG3z+4r/hvV7+1dLnMRbxeMCicoD6AFIsr/18VUeXwbdI/EtTCFNbIV8rOJfhHGjy6+ovOrP/JrgoY+n/Q=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:dc84:66b8:120:935a])
 (user=saravanak job=sendgmr) by 2002:a81:9b82:0:b0:5fb:7e5b:b87f with SMTP id
 s124-20020a819b82000000b005fb7e5bb87fmr677991ywg.1.1707268695967; Tue, 06 Feb
 2024 17:18:15 -0800 (PST)
Date: Tue,  6 Feb 2024 17:18:01 -0800
In-Reply-To: <20240207011803.2637531-1-saravanak@google.com>
Message-Id: <20240207011803.2637531-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 2/3] of: property: Improve finding the supplier of a
 remote-endpoint property
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After commit 4a032827daa8 ("of: property: Simplify of_link_to_phandle()"),
remote-endpoint properties created a fwnode link from the consumer device
to the supplier endpoint. This is a tiny bit inefficient (not buggy) when
trying to create device links or detecting cycles. So, improve this the
same way we improved finding the consumer of a remote-endpoint property.

Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index da70aaa62ca3..7bb2d8e290de 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
 DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
 DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
 DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
-DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
 DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
@@ -1298,6 +1297,17 @@ static struct device_node *parse_interrupts(struct device_node *np,
 	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
 }
 
+static struct device_node *parse_remote_endpoint(struct device_node *np,
+						 const char *prop_name,
+						 int index)
+{
+	/* Return NULL for index > 0 to signify end of remote-endpoints. */
+	if (!index || strcmp(prop_name, "remote-endpoint"))
+		return NULL;
+
+	return of_graph_get_remote_port_parent(np);
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
-- 
2.43.0.594.gd9cf4e227d-goog


