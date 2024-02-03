Return-Path: <linux-kernel+bounces-51194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A584879F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E3C284A8F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C65F873;
	Sat,  3 Feb 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0ihNCHf"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5575FEEC;
	Sat,  3 Feb 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979236; cv=none; b=eyOShZdM0lFbDT+yuQwu0vbDpAIbRbF5bn4oXu6PpfDARHpzfFJY4UNtiDGipxIoujjDMFgzlSlikRrX5E5/Bfx5sXq76av9jD7cBOgjBx7ZPdV9lj1QgUqXGvgbjfCuSiVP+u9tXIo9Jb08g4vUJVThP0f3newOt84NV8uUZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979236; c=relaxed/simple;
	bh=jTqj5XKaGGFUl2JYellu+e3d0Q2gZopfMs1HUr32YHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2jU4yw4kTAIxb4QAf+CRPGruZPBSrR20aD/XK21jJoH48rLztYMJS7G0x7Twtfzb1j0c57/71YLgw/2BGWXTF7EU+RsgOI6fVemQgwUjBDAebyUojmZUTead3zHuCtsVeIOfub/yGv0QdJAm/YzBJ9sMqd6VCvgnVBTLi5tlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0ihNCHf; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed9c7d33fso126091139f.1;
        Sat, 03 Feb 2024 08:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979234; x=1707584034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTz41youk0MNhd57tDHSRqDDcqb1mXikbXnVvCDl5qs=;
        b=A0ihNCHfHXW5hHqz0P+x4F6jSVlokUXea5j+6Czt3DgFJkNMOq6LfXLWQA2Z1qrGdO
         //6dgeZ1gLXjLVN6VhWPhDi2/bv1Otlv/PqaHSmS4i5Zcj2/aIaHjdQQ2QlXJrBSyOk8
         lpgtt6gI6xn4G7WjLNNfPySsxrdONQbRw5hldYYY6qO5ZE1pSxP0ld/xIe3dv/6q15+w
         S/GxBjOI3bdbjSPN1ynClWf0L83svgzlCO3qdYu7NifuZDMmgnwUaAMouJPCNV1s7Zb6
         LaD+JQ/BhaIGGjqPlt2b77xSgGorvxDxM/0PV6nIS6ngEi15pUmsayqDq8/cDvZsdmBl
         yY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979234; x=1707584034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTz41youk0MNhd57tDHSRqDDcqb1mXikbXnVvCDl5qs=;
        b=SOpxOWvhOlHeyLN5imau6ynzJqxr/CaqtxJfJXiKLOvrqS77r8Z4Qt8zSOj2doV5lm
         voK47SKrjjJltFWMBEIaVH1Xyteplcv1maNEUYSrvGjAaDSBottuIFkXnxNLFckYj5rE
         GET8grbEvKBNWnUVmWyi0nr0giV/kTLKQka7e7bpLXfOldqFCUXhx91RHtbDt4BMQmIp
         zi4Lw4QNoUe1hW19pZVs/0DsLrozs/902UkHhR+BcVTEPlZZ24jXvP8YM8JzwXCNbcRz
         7hZjS7Gi+6kIXKsyaZcqlAUM3snEkIQDbt/o+7emRGZpNf2U0vUwXC0lG4a3onELvD3z
         Dq1w==
X-Gm-Message-State: AOJu0YxIJglc2UvYLnAMJA+CXE/hAYy1X6Q92EzfP3FBFuQMUbc5VKgi
	YockCAcqwyA432PpT8tfHFUdjcD6UMyrLUZnNiax+1FYIiGoRFIX
X-Google-Smtp-Source: AGHT+IFyEA0Xii6DxXVLQmKqTt50wj06h7R4pQOHBCC/7rAn9AxwjHk/98owuv5mKfuaCa0UFjMBEQ==
X-Received: by 2002:a6b:fb03:0:b0:7c0:3e75:f46d with SMTP id h3-20020a6bfb03000000b007c03e75f46dmr4802889iog.1.1706979233728;
        Sat, 03 Feb 2024 08:53:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZdVoNbFEdixs+13RcadW8GCllVZ7xKVTj2NXM54/anl1fBuhrAHCat0rqnv3RhPASNx1opDJMA21l2z1ij3X8Rx12yVkcQF3JZTOK/TdeH+RaAtahnLEJQFr1EBEUsLv9uMvFjgkQj5cv+aAdNFwFbShA0kgja3hR3iG+/3YWHfTuV/1S1mP0chXWaEzo1MccDnVMn18czRjOnRdwS7S8EUhB/wt2V5/2+DD3jLoPD1YGeWMWIWwvNSPDn99bqMs6krYj7WIBM8uXm9uPmLjqWgjON/i6J4pg7Gd0ha42QIp6q8ORyMPm+DNgUlu+ZnGaGNxp7pw/60q7lPdfXZAwTb4x3OFApr+MUxTmbZOXDfUy89W0rZix+B3E3fOytm2w1Os/SuG+zS2jWyWAG49gtmBoWgVC9EN0+CjvIUNdxiAk0NCabImRXO4kvDZ/05GrkGmjNjwhmCwOHTNxNJ/VYPYDz8C+m20Zh3YXaeRs/ZzFi1qNX6Hbu6nGQgB53BFrrE7DW8wy7BerDEwfQN7OF6Lxf3q82TSpWlsu+op0Si2PXXkMX/A9CMmDR5IQNaxVjjL4V/4Ykpc/iOapGlUYY9hGaC4h9/BtwNDpSpu9qJs5ZIS6Pds7A8ARxvis4/LecvT0lPDtItXD1lA9gzCH9fIkyLGw/tO9z1GQdU5fJzgUlbZQcdA1S2vN/dobTHOkGlgkEkBEEypLuGbX/OJCO0DBcGp7xE8+MtJradWpWSB7zSmA0Sp2ghrlum17CIgR353mLSHpuhim31D3HFt5reRqCIhlV5aClUhtcLqzM/ACrx3JM79u06NOcVklVWAb5WPhjkdTaw2RJA+/DBN7RMsH9Ruthu4++IamxsZN0zGXu94y3o/HqeWtxxec24GM6y7XWNJl1u7NWvSf9ptVeauIDMqfUwFnszPpQr0AR4e3aUVEVEPFasL8tlOP00vcN+
 mpGj9R8UMZ1+rT0d+JO6gXS+Yd+LDUMkxu/IWny7gVOlL4rA/IwaPBq/NnhEmmHkNPit6gfH7urCstUx8uEBN6/fIb4pnzHC1PX52xvzvlMLFrlSyowHFSRg+imxQyt00NhHYnbLy7R8EvstG8GndKToyv0053jjyytesykhtwZRO2JKVkUX/w6GQUERQnIpcKJZJ6aWP9YjuMSDPAxUDfkw/dQPb++belRYOp318rrcFN+Sd0dXaZDCDwVPT5KRGQZqg2zIermNjiPcM=
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:53:51 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Adam Ford <aford173@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Sandor Yu <Sandor.yu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 04/12] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain
Date: Sat,  3 Feb 2024 10:52:44 -0600
Message-ID: <20240203165307.7806-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of
hdmi rx verification IP that should not enable for HDMI TX.
But actually if the clock is disabled before HDMI/LCDIF probe,
LCDIF will not get pixel clock from HDMI PHY and print the error
logs:

[CRTC:39:crtc-2] vblank wait timed out
WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634 drm_atomic_helper_wait_for_vblanks.part.0+0x23c/0x260

Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
V2:  No Change
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e488cf79b800..77e889165eed 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -55,7 +55,7 @@ struct imx8mp_blk_ctrl_domain_data {
 	const char *gpc_name;
 };
 
-#define DOMAIN_MAX_CLKS 2
+#define DOMAIN_MAX_CLKS 3
 #define DOMAIN_MAX_PATHS 3
 
 struct imx8mp_blk_ctrl_domain {
@@ -457,8 +457,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 	},
 	[IMX8MP_HDMIBLK_PD_LCDIF] = {
 		.name = "hdmiblk-lcdif",
-		.clk_names = (const char *[]){ "axi", "apb" },
-		.num_clks = 2,
+		.clk_names = (const char *[]){ "axi", "apb", "fdcc" },
+		.num_clks = 3,
 		.gpc_name = "lcdif",
 		.path_names = (const char *[]){"lcdif-hdmi"},
 		.num_paths = 1,
@@ -483,8 +483,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 	},
 	[IMX8MP_HDMIBLK_PD_HDMI_TX] = {
 		.name = "hdmiblk-hdmi-tx",
-		.clk_names = (const char *[]){ "apb", "ref_266m" },
-		.num_clks = 2,
+		.clk_names = (const char *[]){ "apb", "ref_266m", "fdcc" },
+		.num_clks = 3,
 		.gpc_name = "hdmi-tx",
 	},
 	[IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] = {
-- 
2.43.0


