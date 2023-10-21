Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843717D1C69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjJUKPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjJUKP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:15:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB110D5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso2317375e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883314; x=1698488114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzDHqn7UNaJzOjgCcjrENJmpRSweOhwpG6H5CfyFDbc=;
        b=DgcHoxtWbIxRFvKJyMy8A4MyHnWN/rab08Eyo/x/7dsKpn7gNcmR5cwdXshkg5Nes9
         q7weat9GaRFX76Mptfi1VgUc8Fox/EEhzBwHB8k7FO9S2JsEHVO+Qx8PNT2Getevs6mf
         QUsijHc32hB8FLaBVU4Iwd9ASXtEKlHLXqP39VRDNgNRFj1XpDt3udOXJDidRD9i4BeW
         Yjs5gctd9rC5hw2BYNzIKEeKlEORteSJs7TWkAA7wvybhMoYU48AGMteL7di0fXAEZhh
         4qPKuMfnw92JUJ3iIVKa4APKl/s6FDVeaTt9w6PHDqK0zOjhCDBj7xsAm+Zc6SBI5BWQ
         HAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883314; x=1698488114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzDHqn7UNaJzOjgCcjrENJmpRSweOhwpG6H5CfyFDbc=;
        b=sCm73HhJXTHBDOW1Rx+SlQjpbPrccDCDznLUiRvBE+fuV5t/cLLxkzvIdc4VIuB7H5
         J1XaY5iogxXpNd/rNDLaQO419bIrQ/3iHy9nM7aWXI75nzrv83flUyXDdgO4JUz6YFjd
         3qoqACOG0Jv/jO3s3mL2qZTSub/7sbMGFVIBhh8MFV683QhfD8bNELM0Fi5arefC/XRX
         ruf/unS9QtwvF7z6HUBFktHQSphLNVVBRaf8BVH1+ZQZd6cpC0SLtU5aVq6SOvZ3Sbqg
         5IEx8DxCozhZsdqelhdonlhdf72eKNlgBmArKbjIH+h4ayYuNBK/Lc95TOXeu+tW/ScY
         hMgQ==
X-Gm-Message-State: AOJu0YzQz0KMHJIsN4mJdeo7yxonYdiufMzIjNV70Z9HOyAeMrvyJWHW
        MczNqPtXJ6bG7S5VCHvkigw=
X-Google-Smtp-Source: AGHT+IHDPVY4sNcclDFYWhFX/VrTw2vslXmMeCj+Hasg4Lr25V58WfbCv/H1hTrGtHIo3nN9NFVlIg==
X-Received: by 2002:a05:6512:baa:b0:500:acf1:b432 with SMTP id b42-20020a0565120baa00b00500acf1b432mr3336978lfv.63.1697883313787;
        Sat, 21 Oct 2023 03:15:13 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:15:13 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 7/7] staging: octeon: Fix introduction of new typedef cvmx_pko_port_status_t in octeon driver
Date:   Sat, 21 Oct 2023 12:12:38 +0200
Message-Id: <20231021101238.81466-8-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
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

This patch removes the introduction of a new struct typedef
cvmx_pko_port_status_t in the octeon driver and then fixes the
implementations which used it.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:                                                                 
v1 -> v2: Fix breaking change spread across multiple patches                
v2 -> v3: Break changes up into individual patches for each removed        
          typedef

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 8c48acab49e4..8e1f4b987a25 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -202,7 +202,7 @@ EXPORT_SYMBOL(cvm_oct_free_work);
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
 	struct cvmx_pip_port_status rx_status;
-	cvmx_pko_port_status_t tx_status;
+	struct cvmx_pko_port_status tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
 	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 33a0e1d5f961..cf7f77061eb9 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -409,11 +409,11 @@ struct cvmx_pip_port_status {
 	uint16_t inb_errors;
 };
 
-typedef struct {
+struct cvmx_pko_port_status {
 	uint32_t packets;
 	uint64_t octets;
 	uint64_t doorbell;
-} cvmx_pko_port_status_t;
+};
 
 union cvmx_pip_frm_len_chkx {
 	uint64_t u64;
@@ -1262,7 +1262,7 @@ static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pko_port_status_t *status)
+					    struct cvmx_pko_port_status *status)
 { }
 
 static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
-- 
2.40.1

