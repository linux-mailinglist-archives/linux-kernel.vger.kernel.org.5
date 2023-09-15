Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C337A1B23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjIOJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjIOJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:47:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1923AA7;
        Fri, 15 Sep 2023 02:44:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0db66af1bso15040415ad.2;
        Fri, 15 Sep 2023 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771097; x=1695375897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8s+ls8Yw6NMJtaPKq6UHyd+YkBQYdgGHT2EXOl3gig=;
        b=FOKspa50HhSoe2yrFF0QK5naXLp/k6uGrVR89+mc1ShxWvvjYFcCgU7oYvFTPmCGM7
         /x+5LjlWBvpgKN8Ey2CWeWHtHj7RnOKt0sC6coQvpu9z2lljIGIb/Wz6IeXTjovIWKNI
         3rT6Li6IhRNYbw0mAojWk6dGnXFHW481fnnJNvQIXC783guMK7sTg4u1XTdfY6J0n2zb
         LcOf/FPyJ3zof28cVXMeEXq/9s/goDNFewmmhIsShutHdQ/AFChDRcRPmazgYkFK830p
         zcy9KNbRwoZ4X7AzW817yPHVJGS7MVPMmrlpQnbU/WJAlxAEOMJPAHtoRtV8KCdUjV7l
         ljvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771097; x=1695375897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8s+ls8Yw6NMJtaPKq6UHyd+YkBQYdgGHT2EXOl3gig=;
        b=hcLpsrPm+WNM76D2ZAwsgZzItIU8CoxzSaVoHGpSAldMcrfg/M7RGBPW1PpYahaoBZ
         F+ZQ3Rui+zkK9il9xcUhLzJV2KCMzfiYOjDwqQzuYLHw2RQfQUl8dFYZhyJTdbFl1ckF
         1p0U74Qc3Sax/CIjz9HgUKsI54x8hfVqIb+lbx9jqu2TRqBB0FdOsKep6j7IGFktjNV9
         RLR5UYUCM3TbWsY9MUBsWtw1y9MQPSk47bt2N5xlqj+bEeNg0EcQ5187449V4jUEEsUx
         7TL3a+MYK+GmrDk0SaaN/1T7bZh8fIqpL7AcRQckxivPW6lGWFDE+kpjx+b8q7uMRI8W
         7H3g==
X-Gm-Message-State: AOJu0YyegsXLvJI+XwNbFKNIeM41Vgz89S2JcuKa4OFxtZ+bhMcpYR8d
        SyVP9+I5W5DszafgfuLq5xc=
X-Google-Smtp-Source: AGHT+IGf/sF8BwiPsYcQYhP6nwir9rYqdLr7NuXwwOD6fR1iwrAParbR6bCd+iro6ZfxLo+6WabZ7g==
X-Received: by 2002:a17:90b:1e10:b0:268:4314:2dc6 with SMTP id pg16-20020a17090b1e1000b0026843142dc6mr932807pjb.37.1694771096797;
        Fri, 15 Sep 2023 02:44:56 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:56 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V12 21/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 15 Sep 2023 17:43:49 +0800
Message-Id: <20230915094351.11120-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915094351.11120-1-victorshihgli@gmail.com>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index add0eea55b24..517c497112f4 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1267,6 +1267,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5235f2da6568..300108cc255d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

