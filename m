Return-Path: <linux-kernel+bounces-77024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0812860039
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607271F25CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575E1586F9;
	Thu, 22 Feb 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVaDuEgx"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8429157E89;
	Thu, 22 Feb 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624743; cv=none; b=OYg0Sg4Kt9O2SRfQo9oaHWIVfMW1eF0uRzM3vyh5VuaTf2+EBAeKi+tytSm99JrAwtdsmaxbJwokRZMLwWXsx054lyAk7UjumGUi7FUiRMgIkneONna7YakHo6zM7940+zBh1y4fD9+QTX1H3iFuMmThkftY5Rs71mIHJrSL/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624743; c=relaxed/simple;
	bh=kP+bPj01i5XvLv/bChPOEWkzE3rhDS/Qc9Bv07ibpJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssLzfmpKAX+BiNWNEqflR0DnmhHaXRdEf4wgirYJCT6IJ2QkjaofzDBcD2mFztM8eA24Y8d8+VsVAN8wpC0WRV4PJmpY+22+QUZrhFvXQDfyzS5f+P1XHMn1wyXTT1LXUBKAAJgWZCdRUZawQqCw/Dzwu9alj612O7czR40b3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVaDuEgx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so579941fa.3;
        Thu, 22 Feb 2024 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624740; x=1709229540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH0T15OnUfP1zKLKNNl5grEVTc9u2KY09oUHUCmXOXI=;
        b=OVaDuEgxh9uXfmbDOiaGcQYQaxuaXMiJZTAyfO/GHT/7y0gRkG0TZmxRPRtCWB62Vn
         YhF5IaUfxyuuJVgyXqkD5BWvarS2wCvvPbxlfHssbWsB9jtbhTfQJ3egGTYLDz/UgEGE
         b5rAgLPUHIK0WgixGC7yQUy0aHjA/Kib9xx5u2fLmXoHrgKfkjMniw60+G8/GHY8TiRE
         j7nmWBPGUPDRdeLQvqWb9nEUbL3d+SNbLo978nB9KVryXBv6IUIY+gb9rRpbpYprN68E
         ALW2b9DuPWfmSJaZ+fLJUT+66hp7t1Lm2jQF2WLT0lzrh7oinLi3GWYeV36+Zq8loPEX
         HP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624740; x=1709229540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH0T15OnUfP1zKLKNNl5grEVTc9u2KY09oUHUCmXOXI=;
        b=dsINlsXk7numEQPKinnHxCJsmrBhEmzRATJOSj/Il7E2j4XcMK4vasNofOsg/eQ9ad
         yMzBwJ4CKnWR0U5LTjamK6xUedk0V9QIBQlclEPLpzPUk1ioxXjkRR8k2mgHljaYWlQ3
         plyumkISmpiUjnIUIdz6LjHSw7JNth8aqkEQsoOym6IuXjAdxw27a3O3JBrzSRkVlZi6
         LgHDiAnp0YSYc0E6cdbGXaaU1QFzRxFE9xRDUyub4DeMSpvix79UkPzAt6sSLQkjSvWc
         5UptYnXoxayZ5+XFgEtQ/oqxmVZcSdmEwDAW6Sar4d0aZjgNpVvdP5uFKoxHgR0GjI4Z
         vl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN4fZm16MVwuHQvhp5Er7SbC11J/pnlLq1JDbSFv1dwM6xEZVFGZO7lrLqh1Kcwle2gYaoVjiMrwhD5Pjh3Xo5An6sme0x2Qi2/z+ESI41JKsPrB7gPUldqySuV8hie+sDUdD2
X-Gm-Message-State: AOJu0YzGbU5/I1h7TIxw8sen1Nzh60vM9zV973r0B+PhT5v0HM75IKDQ
	Vl3GWBeuFoMzMniHr7i0+9omFl752L8A4oB3/EOyDtrfhqMoSNiJ
X-Google-Smtp-Source: AGHT+IHIkOef23Pm0dSclQaK6P87y6AMWfJ1jDRoVN7DxBBYhgDQybIibJWUwprz4AO8ax14LoWKKg==
X-Received: by 2002:a05:6512:3e14:b0:512:b932:7913 with SMTP id i20-20020a0565123e1400b00512b9327913mr8296418lfv.41.1708624739902;
        Thu, 22 Feb 2024 09:58:59 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2-20020ac25f42000000b00512b92ad710sm1461552lfz.168.2024.02.22.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:58:59 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: pcs: xpcs: Drop redundant workqueue.h include directive
Date: Thu, 22 Feb 2024 20:58:21 +0300
Message-ID: <20240222175843.26919-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222175843.26919-1-fancer.lancer@gmail.com>
References: <20240222175843.26919-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is nothing CM workqueue-related in the driver. So the respective
include directive can be dropped.

While at it add an empty line delimiter between the generic and local path
include directives to visually separate them.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/pcs/pcs-xpcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index dc7c374da495..7f8c63922a4b 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -10,7 +10,7 @@
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/mdio.h>
 #include <linux/phylink.h>
-#include <linux/workqueue.h>
+
 #include "pcs-xpcs.h"
 
 #define phylink_pcs_to_xpcs(pl_pcs) \
-- 
2.43.0


