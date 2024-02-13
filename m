Return-Path: <linux-kernel+bounces-64437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F2853E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263561C22ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FA7866B;
	Tue, 13 Feb 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRCPqLSu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E977F39;
	Tue, 13 Feb 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861991; cv=none; b=RCiUEeGIEpb+eLZ9Q84RR/oT73xB7PKfmSOT7h4Q5qrezA1Altg8lx4j8mHb8x7VprW0owdjSDh9GO2Y1ZuvKa3OdtBf8jPrAdBDyWUQqml9pF6H+qEv3O1T6Id1vSSau7llUWwuH3s5wuhoGJcR96M9OynBLvERcUfsoFWmIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861991; c=relaxed/simple;
	bh=tqxykmJnjc+t9OZKEIA9fiqhEZrLIlF9e6epDeBzR7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNpn6mhxGDw2J5CqZOxgYZZ1uCkdTkeFg/qmiDFEq78L1+fq9oM4w0zqnhdrvU9OkongQywk+phuXlKVCGCUpHPhanH/08nvc+DVmgw/00YXd2ickxKB6Cf9CCaTpVizEgmLSKG6pn9jfnMNuU7TBqKdbtosmJTqUxFLHzP5TqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRCPqLSu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso150031066b.1;
        Tue, 13 Feb 2024 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861987; x=1708466787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdHuk5ughM3e+Z5D0Z5R0C1DnmENSSx3TlDfYYFTKI0=;
        b=iRCPqLSuX0xy8+EDAjaF/U5QDF/XozMFI/zWd5cUbmtB0eu7KOU/4yzYyDUxyZzGJx
         4wVczj1aZ9fRNNdiRjE/7IugYARioPj/6DFekiVWvRO21FpgCxxvCFK2qy3rGrRoNZXD
         oRFECNcvml4LjR5npIXfh9DA/bdq101mIf4YGSzOIZx9ZQYS18Il54dNkZX39YixXglX
         oSL0sscpOc7UVyhZyF+C562jmWGtGBo6oqBFANw5KNUAZvadgp6avOEr8k80bqBViP2v
         slyIbROcFRyhESTGK/hWV5EuH953SMQ/A2/F5XRsFq9RTAEqr2iO/xXIkLcXSt9rP1NK
         a3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861987; x=1708466787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdHuk5ughM3e+Z5D0Z5R0C1DnmENSSx3TlDfYYFTKI0=;
        b=FeNPbkJL3MaFcP0sKXNagU4Kx+sviehGx/nPmB6lTPKnEvbR48IcoYz3TwugrW0DW8
         dZ0t6RCAwTzh/CfUbb36ol70HJA0cIG5xhuAymGV727lLIUGEbYGcrnCsUpss9EuqhHy
         FLlq9pkgZZ+XWX3bzHGR2CgDoRLakzjLQCt2vuu808d0B8KwOqO24Ue56Ac2+WPeP1hM
         un0MN9YJ3nl/PskYqaFXha9VFTQFu4vd5UPNG8n841Cg0HHgMSzvClnTAw2wRuK/aC1A
         KKMRkrN4Gkgd/71c5vrvK/oXjWh7YIbslU9KWs/fyzeuTWGkzYVDFgPyx6iFBll2x8i6
         jpEw==
X-Forwarded-Encrypted: i=1; AJvYcCXPfLjeiEHt2zg+GlOFYQSV+mUWPxDShULfRl3z98aqXDztIZ2ZpLjQrxKq50dnCgMe6YqmYmHrEqX6rYZHCshURZLLFLdJ7rM9RBU4
X-Gm-Message-State: AOJu0YxEamZzaaue15j8yqufNcL8jrauKOqb5WxLpGAIU28cZJEbWt9Y
	FLTI3bdsV0eXDV7bge1BQW1mfCUgC2RGsjLxLGO+xm5AiN3m+tM8r3rVTYDG3AM=
X-Google-Smtp-Source: AGHT+IFGujdPsKw3SRnEv1IWCGv78SR/COTAjTrsM2RTRpPIwr+ywNUzEnrCqFcwh1VGfw/CdT3xHA==
X-Received: by 2002:a17:906:7c9:b0:a3c:1402:e042 with SMTP id m9-20020a17090607c900b00a3c1402e042mr388757ejc.37.1707861987378;
        Tue, 13 Feb 2024 14:06:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTLZa1aLuYKMp0xw8j6FTHAlWMyQ1Oc2lhyEpjW3LHjjlbWFrJdDnAVnsGJrsvYo7wHyP30IbdL2Obfx2lXqsGMVdNUBfTk5sCdsXQc2nbmpv7mdchHGxjVq63UZTjEy8k+6wx/yO/eOtYXRETJXTSvsG4S9czLiIs0yHLKgB99kJBX714Gn/gxP3KZZhUP9yRuzDBJ9rBV46NajErjjDqDYPkoq/kQQXsGMKBArWNm3rm5AeJ2QvgpleiUC0U8sgod/Vgp4nh/4v/HsSqlbwhB4Ys7JFNLpKmUzmJFFR5qWi7wqFCFrYs6wK5wVNXXSaL80piyORBQxZ11AGTOaWTc9JtOK16GOS9tQF+6SjgeYVEhOrrKexNojKTlY+y0sD7pgezqPRYF66WbiO3+Ul0HwrdCx6CEUUlbLCWkh0JuF8HB/86i3Gpwql0IBovmtDZA50suV5g5g==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:06:27 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 15/15] net: dsa: vsc73xx: Add bridge support
Date: Tue, 13 Feb 2024 23:03:28 +0100
Message-Id: <20240213220331.239031-16-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - remove forward configuration after stp patch refactoring
  - implement new define with max num of bridges for tag8021q devices
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 9f94ae8c763a..ade90a48c53f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -675,6 +675,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1536,6 +1539,22 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	*tx_fwd_offload = true;
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -1657,6 +1676,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


