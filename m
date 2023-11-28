Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706697FC11B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbjK1ORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345602AbjK1ORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:17:10 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CABD5B;
        Tue, 28 Nov 2023 06:17:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cbcc42e9d4so482313b3a.0;
        Tue, 28 Nov 2023 06:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701181037; x=1701785837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHJtFqAleD7W7XromXIqrJ2RQq+grf3ccSCOU/zLUZM=;
        b=gS6gEyD910SHYksTUIO9sZiFzgGl+cgkJIxbM4UROnBgxkZ6hkrsZy2clcRHWW1lHL
         SLU5ObZeQY4SHfKycrZ4M35i1/NKS0CpfUeZPdEfyvkwGqrQdeRUKhcoGnT2kApraASn
         6rDGnROgrAc6Nui2G0ezIpoLRylr5q8vJD0KVKimAqle4bv3xQEvjXRBQmcnKpjKNfPG
         BgEmfR/T2Rjf+Lq9MrMnC7Eh+8sYI8iD5IEE7wngatBpmfMfEVovwDBHUS0GIVpuxNuq
         aZzjk7GU1Dwgg8zPGdw+0ZUkSzq5DdxWve1285dSIEqaUOKjpWPHvH+vKrjKHyKpBI3t
         Hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181037; x=1701785837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHJtFqAleD7W7XromXIqrJ2RQq+grf3ccSCOU/zLUZM=;
        b=T2QkpMotwJ0v6dI65uguzXmR2efdibSXcIkLyz61xa/MdMFyLqQWFCQAJt58WVkhCU
         B4r//2tErWEr4/SZ+8BL4wr0wFRji+sanXs1zQ+u6JrojbksNx2gFM+nfTTnh6EBAhEf
         Q9WyaQURt+VdFDB+kDg24+Z6DTCLRhoQ0ERE3nsySskhFPo0InECw/5bnGeDwernRvt2
         d0G9d8d97pScAhi25L5ATUMd1Y1yVWbSRfwvx522NUS2xVVmLUc8UsRti8y+W1DXRp/4
         5fV+BeQfXhIlANphA3i+2uvD9XFgKBurdOtdsWk2fxGfwnfxUBNsgbt5evdMXjvK3HQO
         SmyQ==
X-Gm-Message-State: AOJu0YyRnWV1beefyLB1HNy7OrEpuM/U+uCmr9AdRHEhda7MI0lC2MBr
        0CEX5L/oNmo2WSLF53Gi6j12TXCJTm8=
X-Google-Smtp-Source: AGHT+IFgYLBF9c7I/u4+gYLhdlAjgi35N42VpKPkgvH4bCIUAWhCQoSZ2CBOymPkZVt7ZInzOUN+tg==
X-Received: by 2002:a05:6a20:7348:b0:187:ccb6:ddf1 with SMTP id v8-20020a056a20734800b00187ccb6ddf1mr17917163pzc.0.1701181036502;
        Tue, 28 Nov 2023 06:17:16 -0800 (PST)
Received: from abhinav.. ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id m7-20020a62f207000000b006cd950a38e4sm2919564pfh.94.2023.11.28.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:17:15 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, qiuxu.zhuo@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v3] driver : edac : Fix warning using plain integer as NULL
Date:   Tue, 28 Nov 2023 19:47:03 +0530
Message-Id: <20231128141703.614605-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CY8PR11MB7134D203710F24755B7651E889BCA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <CY8PR11MB7134D203710F24755B7651E889BCA@CY8PR11MB7134.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

The reason for this change is that use of numeric 0 for a null pointer is
unacceptable. See this link for the long description why:
Link: https://www.spinics.net/lists/linux-sparse/msg10066.html

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
v1 -> v2: 1. Fixed the comment section descrbing the current code.
          2. Added a reason for why this change is required.

v2 -> v3: 1. Reversed change made in comments by mistake.

 drivers/edac/i7core_edac.c |  2 +-
 drivers/edac/sb_edac.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 23d25724bae4..1177da186eea 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /*
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 0c779a0326b6..24ee6f28cfbe 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
 
 static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /* This changes depending if 1HA or 2HA:
@@ -505,7 +505,7 @@ static const struct pci_id_descr pci_dev_descr_ibridge[] = {
 
 static const struct pci_id_table pci_dev_descr_ibridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_ibridge, 12, 2, IVY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /* Haswell support */
@@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
 
 static const struct pci_id_table pci_dev_descr_haswell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /* Knight's Landing Support */
@@ -620,7 +620,7 @@ static const struct pci_id_descr pci_dev_descr_knl[] = {
 
 static const struct pci_id_table pci_dev_descr_knl_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_knl, ARRAY_SIZE(pci_dev_descr_knl), 1, KNIGHTS_LANDING),
-	{0,}
+	{NULL,}
 };
 
 /*
@@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
 
 static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 
-- 
2.39.2

