Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5775805E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjLEStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjLESs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:48:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4BD1A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:49:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d072f50a44so10046145ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701802143; x=1702406943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAOApdPILCdz/7NHT0OHgRBW5hnPP0BdQ0o84+NjOww=;
        b=X3OP25Y9cGtbJfxd/TpsfVR5t5AMcrx/bRiB811CBgxscBISvPbkE8Qxdxn/E/ee8f
         d1IIsu88aXlGnr2n5/Eh5ozyuumTFbEhOu4V2pfu1d8+efJgUiLG7kIJS23upwVl88+5
         y1XvRxGzRPoHyQIR5D6LsHM/wUI84w1gRWP6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802143; x=1702406943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAOApdPILCdz/7NHT0OHgRBW5hnPP0BdQ0o84+NjOww=;
        b=tPKPbB8OawCCd29hVTW8A3SRNL0fQ7v8tQVaCsgJK9w9nXbUMz5PAgo45nhxMnvnIe
         2S9uCGD0M34P7+z53LLAkfE1YF5rDZ00jb7HZJN0kHBjcLjJqQ5C2X0cQTKd+rumcJh0
         Erv4PZp11RFlgafnxtcMRCQjPPTMZfD5kppz1I2LLOi6IY91IhInv7PoWRzDnOaw6E0L
         F/8oYehiyVjclBpWhUWaYA1RCm5XCXSwOcuq8JIxmgGYogltPZlCvBioZeEcdLjI2NTw
         2SWVTSt0FsfkHiJwnsIikyxUfMQo58QgeOGdnw3FIc+c4DlKeIz4yU4HqsQCOOdoXoYd
         eGdA==
X-Gm-Message-State: AOJu0YzosoD4ni9WZzJuDGSpkN6jV5904TheZ1Z7kgQ+1jf5zd776qzn
        lsNdv4C8SkfZR22wAZZdgSZCng==
X-Google-Smtp-Source: AGHT+IEZojP/nyAWpgMigLVhprQ+6SsnFxupIzO7E7slzYCKwS+2sSVt+xGjKRttOqRPDieBqvJUCA==
X-Received: by 2002:a17:903:1cf:b0:1d0:83bc:5648 with SMTP id e15-20020a17090301cf00b001d083bc5648mr9728581plh.2.1701802143229;
        Tue, 05 Dec 2023 10:49:03 -0800 (PST)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b001d06b93c66dsm7219130plb.233.2023.12.05.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:49:02 -0800 (PST)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id 8AAEBD08; Tue,  5 Dec 2023 10:48:37 -0800 (PST)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] memory: brcmstb_dpfe: introduce best-effort API detection
Date:   Tue,  5 Dec 2023 10:47:37 -0800
Message-ID: <20231205184741.3092376-5-mmayer@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205184741.3092376-1-mmayer@broadcom.com>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a best-effort probe function that tries all known DPFE versions to
see if one might actually work. This helps in cases where device tree
doesn't provide the proper version information for whatever reason. In
that case, the driver may still be able to register if one of the known
API versions ends up working.

Caveat: we have to skip "v1" during our best effort attempts. This is
due to the fact that attempting a firmware download as required by v1
will result in a memory access violation on anything but v1 hardware.
This would crash the kernel. Since we don't know the HW version, we need
to play it safe and skip v1.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 58 ++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 0b0a9b85b605..15f4ee3b8535 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -879,6 +879,50 @@ static int brcmstb_dpfe_resume(struct platform_device *pdev)
 	return brcmstb_dpfe_download_firmware(priv);
 }
 
+static int brcmstb_dpfe_probe_best_effort(struct platform_device *pdev)
+{
+	const char versioned_compat[] = "brcm,dpfe-cpu-v";
+	const char v1_str[] = "-v1";
+	const struct of_device_id *matches;
+	const struct dpfe_api *orig_dpfe_api;
+	struct device *dev = &pdev->dev;
+	struct brcmstb_dpfe_priv *priv;
+	int ret = -ENODEV;
+
+	priv = dev_get_drvdata(dev);
+	orig_dpfe_api = priv->dpfe_api;
+	matches = dev->driver->of_match_table;
+
+	/* Loop over all compatible strings */
+	for (; matches->compatible[0]; matches++) {
+		const char *compat = matches->compatible;
+		/* Find the ones that start with "brcm,dpfe-cpu-v" */
+		if (strstr(compat, versioned_compat) == compat) {
+			char *v1_ptr = strstr(compat, v1_str);
+			/*
+			 * We must skip v1, since we don't know the hardware
+			 * version and attempting a firmware download on v2 and
+			 * newer would crash the kernel due to a memory access
+			 * violation.
+			 * We make sure to match "-v1" at the end of the string
+			 * only.
+			 */
+			if (v1_ptr && v1_ptr[sizeof(v1_str)] == '\0')
+				continue;
+			priv->dpfe_api = matches->data;
+			/* Fingers crossed... */
+			ret = brcmstb_dpfe_download_firmware(priv);
+			if (!ret)
+				return 0;
+		}
+	}
+
+	/* It didn't work, so let's clean up. */
+	priv->dpfe_api = orig_dpfe_api;
+
+	return ret;
+}
+
 static int brcmstb_dpfe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -923,8 +967,20 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 	}
 
 	ret = brcmstb_dpfe_download_firmware(priv);
+	if (ret && ret != -EPROBE_DEFER) {
+		/*
+		 * If the information provided by Device Tree didn't work, let's
+		 * try all known version. Maybe one will work.
+		 */
+		dev_warn(dev,
+			"DPFE v%d didn't work, reverting to best-effort\n",
+			priv->dpfe_api->version);
+		dev_warn(dev,
+			"Device Tree and / or the driver should be updated\n");
+		ret = brcmstb_dpfe_probe_best_effort(pdev);
+	}
 	if (ret)
-		return dev_err_probe(dev, ret, "Couldn't download firmware\n");
+		return dev_err_probe(dev, ret, "Unable to talk to DCPU\n");
 
 	ret = sysfs_create_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs);
 	if (!ret)
-- 
2.43.0

