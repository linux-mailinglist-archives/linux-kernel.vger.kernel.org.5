Return-Path: <linux-kernel+bounces-161405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA78B4B98
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AEE1F21667
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6665E02;
	Sun, 28 Apr 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXT0KNyV"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9572F29;
	Sun, 28 Apr 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714305550; cv=none; b=IP1otd5V7lDPJXKoilff7X0L5350aUw5/MvUr/PwriVPLO/KDuwQrwivhYEFcUvfizA0b9M8jC984jbXm0efSpiyGl5Dor0OfwTHIYlE63EjyLg3XNQBwBFflbfV62WOyXsKeJ/DjliIORcE1SqaxsCjQsrU64qwtMLbmXp3HL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714305550; c=relaxed/simple;
	bh=7dEusFxZFJ1Y5U18wib9rq2M+q9J2wbC2q2//EWKbio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAbHWp78wV8/VB9c+sJD3cDhITD9ccOVKcpIBixa68u5CRYKd+pnxZExEA69SI+zbBWe+zhsIiS/30rf3pFsMQnN90jY/Pv/kY54tlD4H6suq4SLcn+iLnrWVrJoS7zQTxJ6jc+LjibOBXqAg+KVjuMW/VuVEay4FARg+2bvb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXT0KNyV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso2866132b3a.1;
        Sun, 28 Apr 2024 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714305548; x=1714910348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOsaocwjFT1pz2ngVnKxeRZbtnK8Ubq+Yt8uQGBS4j4=;
        b=LXT0KNyVpGzwDhjg5IvqjJV5H/LqzItNwyp9SC0b/CBTt1eRnQPzKM8dpKCeEOVsHQ
         DO4n++YGw2mKyVvznULeSPWxRXpKIq5uviuC9gsKFzbxOE/HOdygq9CTtyk90YdeFgI5
         U6iAcHM/rjF4y7tuaowUzmfZdOlTEoH4Vg7mQKSmjYSUpB0Da+urc0rXIIU2/CTZQ/DR
         NiG/ZwU18pvHztNzJlNs87833yqW1143xp6RRMelXNuaJ5jooAYAOE4UqzUHrsDX7Bd9
         RHDFjXHIrYnyuD5qX5MQZ2KZam1BtYm/Fp1t55hSWBkHXDMzwLXwP3UhBHMC50xKDH7u
         QF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714305548; x=1714910348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOsaocwjFT1pz2ngVnKxeRZbtnK8Ubq+Yt8uQGBS4j4=;
        b=DjQedJ03+elgdVaREMsdd0wB4C5bltsobTqqJKqE46eyDhGNDWLh3JlVyzBa1amCk4
         TI4cMrv9I9yLC1H6fGATAbQ54yxkzgdEO+bWCxeC8V4rRKzJIAxj49MpXgGP/c1SvkeV
         bhppd41dBIhJ12vUSD+EjkvK4U1fxqNQfcXsRUr8DqLRqcU0G+eEWa2Oy4Sk3JCyzlMF
         RZCzeNfcjp+KJBUViTm0rlzIUlFF0xzOHav5QHrVI3YB5jbGqHeSC1otQ8VgZNWhd0JQ
         kIAij/UiGGwCRFRuasoUzZyEe0WxIJvRtofWR3Uf1g+Xz4c0lmzL6jSRJh9mdPePXFT4
         dALQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/qdiVB4lQ3XKNZRg3zzGEuOmSkiKgTrrALLH9UfHGMUPHxA0w+fbCrnuK2UHOIYrYgX4EsgqBuckTh6wkZ73H9ZyVcopzOwaEsYUu
X-Gm-Message-State: AOJu0YxyRtGfpNbtyTLSWb9mUQs7ThcMTPCECoPl72bE6iZRqfxMTAK3
	W2+IsfPxGNBdFI+AeZuUWz8XN7+uNJ0dm+eLwGMuMHp3mKC9P4Nz
X-Google-Smtp-Source: AGHT+IF1zETYOo1e1RYilJpjwP/DCPA3/FY8ol+QqaxDXzQmLI6VS8l1ku1pJ7AlQg1Mbu5xEsqsUA==
X-Received: by 2002:a05:6a20:979a:b0:1a9:c3ac:c6d4 with SMTP id hx26-20020a056a20979a00b001a9c3acc6d4mr7078163pzc.62.1714305548036;
        Sun, 28 Apr 2024 04:59:08 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.221])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001e431fb1336sm18341187plk.31.2024.04.28.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 04:59:07 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH][next] of: property: Use scope based cleanup on port_node
Date: Sun, 28 Apr 2024 17:22:27 +0530
Message-ID: <20240428115226.41345-2-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free cleanup handler which ensures that the resource is freed when
it goes out of scope, thus removing the need to manually clean it up
using of_node_put.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Rob Herring <robh@kernel.org> sent a patch fixing similar cases in
property.c but seems to have missed this one. Please let me know if this
is mistake, or if it was left unchanged for a reason.

 drivers/of/property.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6d5ae58a7ac9..abc8613b471f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -576,7 +576,8 @@ EXPORT_SYMBOL_GPL(of_prop_next_string);
 int of_graph_parse_endpoint(const struct device_node *node,
 			    struct of_endpoint *endpoint)
 {
-	struct device_node *port_node = of_get_parent(node);
+	struct device_node *port_node __free(device_node) =
+			    of_get_parent(node);
 
 	WARN_ONCE(!port_node, "%s(): endpoint %pOF has no parent node\n",
 		  __func__, node);
@@ -591,8 +592,6 @@ int of_graph_parse_endpoint(const struct device_node *node,
 	of_property_read_u32(port_node, "reg", &endpoint->port);
 	of_property_read_u32(node, "reg", &endpoint->id);
 
-	of_node_put(port_node);
-
 	return 0;
 }
 EXPORT_SYMBOL(of_graph_parse_endpoint);
-- 
2.44.0


