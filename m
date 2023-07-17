Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3B7569FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGQRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:17:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80AB5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:17:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3159da54e95so4313388f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689614231; x=1692206231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4Z4ndQxPvlU042D2Sffvs/STBs5DhPCeXrD5S+fgHE=;
        b=O3XHCFRX1uaiLT4EGg2b5TeByou4XdZ0/d6iVQHoWIRnqYP3URhDK2REkmEHmow7rz
         H/KtVE7CHlUZvFnkvUaHQCbHDRWtA2xHM82rhLlY0K+ywztbwmgvEdINeZsylQ3o8yz8
         Nc3ispHXmb5is1JMW3pEwB+jdqkCsv6wbJrN++63Ed9ufeNO//W9e4cCuUJd43f06Fsq
         ci1df5i55co+3nDLUmQSnsEWCF+Up2pNLwJFfJ9qVoAaC+oeq7rg6ZMafh5H4RNzr0mb
         lPxCPQRc9EGA1H1/MGdQ1j7DaRnkVXcSAQwqr6ZU2KWMd8VGdLe/Yi5njQkA5CWBCcDI
         oXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614231; x=1692206231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4Z4ndQxPvlU042D2Sffvs/STBs5DhPCeXrD5S+fgHE=;
        b=ffkHuw/B+7bJrK/Xr/LB8MMZvCvsM5i7JYzApKUWZZNL5gfEKED710xOPrPqbpbQ1O
         oAy9YDQLpFP4c33Rs8M2Kg5w6BoDQhCPvlgaNd2qUXgt9r17SQ65nilESXytJ8wzjgvI
         qfOCuX8qZ2JcnvabVYioZuUwnK5DQEW5SlHTAOpwF0NLRLW0LHQHBGq6TbJvgGMMTijS
         L2v8W5yMST4ZaExnEPeptKE0kXkEiMSAF87nqaDmiNRUzobRy+aCMSMzsc5yHTDp6OjP
         ak6eYV+ucM5djYdY4LmBwJjqEpNns1p2PCb5uN0wXHnLCDRT5Tu1Gq7xKXCsZwK+HAzg
         Z2KA==
X-Gm-Message-State: ABy/qLaw/oxm2SBBKgl+XnspyHwlBF5mbyVvaCnAcZk8a/qAhI5mLgL2
        38n9ItYmrAhmRC0gGoYf6GWdBw==
X-Google-Smtp-Source: APBJJlE8SQT5KSsfeMZZ5HoF4OqXcFaj3mkwxlUHV0eiH03tmZUiul4NgF+I6z3ufuroyppoe2YtDQ==
X-Received: by 2002:a5d:5544:0:b0:313:f907:ceed with SMTP id g4-20020a5d5544000000b00313f907ceedmr9868023wrw.39.1689614230739;
        Mon, 17 Jul 2023 10:17:10 -0700 (PDT)
Received: from localhost ([95.148.15.113])
        by smtp.gmail.com with ESMTPSA id s10-20020a5d69ca000000b0031134bcdacdsm10165wrw.42.2023.07.17.10.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:17:10 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     sudeep.holla@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH] firmware: smccc: Fix use of uninitialised results structure
Date:   Mon, 17 Jul 2023 18:17:02 +0100
Message-Id: <20230717171702.424253-1-punit.agrawal@bytedance.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum
T241-FABRIC-4") moved the initialisation of the SoC version to
arm_smccc_version_init() but forgot to update the results structure
and it's usage.

Fix the use of the uninitialised results structure and update the
error strings.

Fixes: 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4")
Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Vikram Sethi <vsethi@nvidia.com>
Cc: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/firmware/smccc/soc_id.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index 890eb454599a..1990263fbba0 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -34,7 +34,6 @@ static struct soc_device_attribute *soc_dev_attr;
 
 static int __init smccc_soc_init(void)
 {
-	struct arm_smccc_res res;
 	int soc_id_rev, soc_id_version;
 	static char soc_id_str[20], soc_id_rev_str[12];
 	static char soc_id_jep106_id_str[12];
@@ -49,13 +48,13 @@ static int __init smccc_soc_init(void)
 	}
 
 	if (soc_id_version < 0) {
-		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
+		pr_err("Invalid SoC Version: %x\n", soc_id_version);
 		return -EINVAL;
 	}
 
 	soc_id_rev = arm_smccc_get_soc_id_revision();
 	if (soc_id_rev < 0) {
-		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
+		pr_err("Invalid SoC Revision: %x\n", soc_id_rev);
 		return -EINVAL;
 	}
 
-- 
2.39.2

