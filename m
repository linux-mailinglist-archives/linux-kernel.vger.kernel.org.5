Return-Path: <linux-kernel+bounces-147440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A88A742B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA211F228F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C1139D0B;
	Tue, 16 Apr 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf1sV/s6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85221386D0;
	Tue, 16 Apr 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294116; cv=none; b=AqkXV2xbwF6joVwHX0dhsJmygQxw5z37pOxiIbtjQQdAf2qI3uTQz3PrtToAJAgpZ2lYQXz9is//2EI2aqOKvO+eWnySncRBJ8R5xp2QtAlaVXVX6lQH4/pnQECdbewNKiubKPpYiwqkrfDq5MwCBCUSOj4ePaEKb1d+lQh8FHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294116; c=relaxed/simple;
	bh=7L1j0x6OhKtrQNLFBM1nnXbMMwq5wuw0psNfkPFdO4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKemdiSCN8TNBjDjfjTTLR1yOSLbJLOwE5xVEAbieHbXoH3BbyBL9iYNwnqrqufoxTKVk4k7WVb9flqA8LnyOMtdHDgjbdD9dtBP+Hq28YTHL6LdBHyULUd+2WVg6ABihSWDcvsmQ4d+86iiMVou3/sX3MwALP2wScZRcUYFTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf1sV/s6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so5610804a12.0;
        Tue, 16 Apr 2024 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294113; x=1713898913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUzg9stfaBGBJD0DXmvP+Xu180vDdPP5gPXWEt3B/dA=;
        b=Lf1sV/s6zKfWtlSzl+7WV615qOt1FGmZSs2/tkPC0qtseIHEHnwYwVadeBNP6zI4zh
         xINI0rvft9YRc97JkWqXU+J2frbR7vLVC/+VU2seglWv1wlCAiWhjnkH1gEUCAho2rAz
         HFfwkGfhMp2WOODFezLGS1fnKp4uU6Vj9290xo5fv+ddveFnmBDjrHXU0S41qUqFgtz8
         Og7JtVs5j5bvULJWJiTaZEAJwk+Wua0nAShHPc9lNBVnB1v0d2hgqfslvWNnfxe/Yp2s
         +Jsm25Z6FDs7HqoB+SzSRQbyyftGtorl6mX0kKFC7u5h/o5E+bACLp/v0Xa6a/L0fpA3
         65ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294113; x=1713898913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUzg9stfaBGBJD0DXmvP+Xu180vDdPP5gPXWEt3B/dA=;
        b=Vf58iM7IpZIztmXWqW4vZV0Sf++kzTeedNBpLzwIP+xhQEvej4ShOhJ8DpPStfXnY0
         H4BYsCok0xjHoL91/Bi2AgxRi0bOZjIi6b8Y5oPZKCRNN7g7TAH3myZnWeu/gcT6M1cs
         +/THL17wIfRdAfwStBfsI7jrv2gTwi0XiXzy0l3UCFsfPR+tUlk4KCav4F4EGINCBZU9
         Gpdl0NiZkBvYYe5aTK8UZJagWEK8+PltF+Z+UWxq5cNR6+0TygcIGvRznwOC0RlrqouJ
         Qi9oy6GFSGgtI8oXk5II+gOCJmwFT6jMQNWbb7nmS4ZYhjR4rnPnBid6khTBA3+Bwjbw
         o4uA==
X-Forwarded-Encrypted: i=1; AJvYcCUVWwCSUEL8amfwEnokImov9OQnTrhM9uJlAXUXF/p6i0HwjimTiNGK7ypqH901i4p1JAnZ2r+UoWXfy7RHi9QTLtzscSaxW/Kv2K11
X-Gm-Message-State: AOJu0YzUJ0uBfTUnmNa/yKuK7NtUx+2+a/hRthLju1ETj9+v/Bsl6vn+
	E7lTf0naDv4BjxoJ8DKUMBZmE+rBWo+zcnuvX1E7ev6wLTWW7qfMmrdfGElA
X-Google-Smtp-Source: AGHT+IHiby57dumfGXRpJITan2ipUCR/MNemrzvBhF1c2p2KSHdpZ847RLQr1ppsTKjBqYG/VyaBrw==
X-Received: by 2002:a17:906:3c4d:b0:a52:28ba:2ce0 with SMTP id i13-20020a1709063c4d00b00a5228ba2ce0mr8156527ejg.29.1713294112720;
        Tue, 16 Apr 2024 12:01:52 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a524531a580sm5247981ejb.152.2024.04.16.12.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:01:52 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: dsa: vsc73xx: Add define for max num of ports
Date: Tue, 16 Apr 2024 21:00:54 +0200
Message-Id: <20240416190055.3277007-5-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416190055.3277007-1-paweldembicki@gmail.com>
References: <20240416190055.3277007-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 13 +------------
 drivers/net/dsa/vitesse-vsc73xx.h      | 11 +++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 8ed8fc997d6d..425999d7bf41 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1180,23 +1180,12 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		 vsc->addr[0], vsc->addr[1], vsc->addr[2],
 		 vsc->addr[3], vsc->addr[4], vsc->addr[5]);
 
-	/* The VSC7395 switch chips have 5+1 ports which means 5
-	 * ordinary ports and a sixth CPU port facing the processor
-	 * with an RGMII interface. These ports are numbered 0..4
-	 * and 6, so they leave a "hole" in the port map for port 5,
-	 * which is invalid.
-	 *
-	 * The VSC7398 has 8 ports, port 7 is again the CPU port.
-	 *
-	 * We allocate 8 ports and avoid access to the nonexistant
-	 * ports.
-	 */
 	vsc->ds = devm_kzalloc(dev, sizeof(*vsc->ds), GFP_KERNEL);
 	if (!vsc->ds)
 		return -ENOMEM;
 
 	vsc->ds->dev = dev;
-	vsc->ds->num_ports = 8;
+	vsc->ds->num_ports = VSC73XX_MAX_NUM_PORTS;
 	vsc->ds->priv = vsc;
 
 	vsc->ds->ops = &vsc73xx_ds_ops;
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 30b1f0a36566..fee1378508b5 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -3,6 +3,17 @@
 #include <linux/etherdevice.h>
 #include <linux/gpio/driver.h>
 
+/* The VSC7395 switch chips have 5+1 ports which means 5 ordinary ports and
+ * a sixth CPU port facing the processor with an RGMII interface. These ports
+ * are numbered 0..4 and 6, so they leave a "hole" in the port map for port 5,
+ * which is invalid.
+ *
+ * The VSC7398 has 8 ports, port 7 is again the CPU port.
+ *
+ * We allocate 8 ports and avoid access to the nonexistent ports.
+ */
+#define VSC73XX_MAX_NUM_PORTS	8
+
 /**
  * struct vsc73xx - VSC73xx state container
  */
-- 
2.34.1


