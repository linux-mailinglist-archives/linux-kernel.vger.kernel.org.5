Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DFD7C859D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjJMMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJMMWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:22:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5124BF;
        Fri, 13 Oct 2023 05:22:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c746bc3bceso5602485ad.1;
        Fri, 13 Oct 2023 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697199764; x=1697804564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zx15p0SmnRH09BE0u4PUAnqk7+Zw8rJ36gokTY/TP8=;
        b=aMPVCWPLUm/yNcUul5Bcwo/D6XX9JAaqJKITX2A6quJxheuplRVWCdHO6GwLzoj4Xr
         5pC1OM5VTzufH80nfta7x7nbuXJpY95i+huY6UeFDFLk+tpLlyjleOfFQ3/8jjSeYixu
         hKGjdA3GRLNYNQ/ya3hfxCJ9z3lOHORW/GMNVjX3JuVw07EC3fBlr0k5aV0YpyJuYaZj
         oU8mu2yrgJwqD7mNyDoD29hTV2OALYYGRa/aq+yjW0nwOvqQ9TdbbpMYrSpjbX4uFg4h
         BWwLYT6+oEIjYM7Prsd2I1xptclx/1SoI0lnrg1B3ANAWFPCEsiKC12Rg3UMRTm7whz1
         /1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199764; x=1697804564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zx15p0SmnRH09BE0u4PUAnqk7+Zw8rJ36gokTY/TP8=;
        b=eh7et56HpvsJKViGmKR+QCVm6aC9tKGovQV2QZQnDIfj2OZW6NxZ/W+MpuqW28grhK
         b/gq7cvHSYyn4WiBmpxiyYyy40IaPTRTwh+PCHG6K6hSHBg0+U+hOt6b+LAq0d31xTyz
         kqBkKt3xAyk5acs6WJX8KmA5aarkNZ6hsGzVIpx3NyQQBSxNLoqJaBJplXrUiUd9qvmk
         H1hAsNM9vOdMzfXiB1XkQwPbpJr+pFRwnhMo7c8roaTt7Azqt09HNxlFfmkGsgeRuRwK
         fDqnB9wO1zVYAJAel5Ct+eaqbgOinwDU9M7Jz0AGPpym3K1VMABDo0l1PNIL1vIItRin
         1Mrw==
X-Gm-Message-State: AOJu0Yyy4IQR16RhsA8WR+BRxz7MzYGzyRjtOzn2eVVHP+2TekyN1p2y
        3B1Ie9/7KVsDRtKRf4/3NhM=
X-Google-Smtp-Source: AGHT+IGjkU4JcHIHWn7TBKy/+945CIIvrTtnhePZe+9GlhF00RheFqtdVD3cHO93AVyexdwWn60ibQ==
X-Received: by 2002:a05:6a20:4407:b0:133:6e3d:68cd with SMTP id ce7-20020a056a20440700b001336e3d68cdmr36263214pzb.3.1697199764020;
        Fri, 13 Oct 2023 05:22:44 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001bc930d4517sm3781802plb.42.2023.10.13.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:22:43 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     rafael@kernel.org, lenb@kernel.org, nvdimm@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] ACPI: NFIT: Optimize nfit_mem_cmp() for efficiency
Date:   Fri, 13 Oct 2023 20:22:36 +0800
Message-Id: <20231013122236.2127269-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012215903.2104652-1-visitorckw@gmail.com>
References: <20231012215903.2104652-1-visitorckw@gmail.com>
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

The original code used conditional branching in the nfit_mem_cmp
function to compare two values and return -1, 1, or 0 based on the
result. However, the list_sort comparison function only needs results
<0, >0, or =0. This patch optimizes the code to make the comparison
branchless, improving efficiency and reducing code size. This change
reduces the number of comparison operations from 1-2 to a single
subtraction operation, thereby saving the number of instructions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
v1 -> v2:
- Add explicit type cast in case the sizes of u32 and int differ.

 drivers/acpi/nfit/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f96bf32cd368..563a32eba888 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1138,11 +1138,7 @@ static int nfit_mem_cmp(void *priv, const struct list_head *_a,
 
 	handleA = __to_nfit_memdev(a)->device_handle;
 	handleB = __to_nfit_memdev(b)->device_handle;
-	if (handleA < handleB)
-		return -1;
-	else if (handleA > handleB)
-		return 1;
-	return 0;
+	return (int)handleA - (int)handleB;
 }
 
 static int nfit_mem_init(struct acpi_nfit_desc *acpi_desc)
-- 
2.25.1

