Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1877FDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbjHQSXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354423AbjHQSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A73ABB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso1360497b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296501; x=1692901301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQTGF+g2uioZsuYxh2OZLeccAuWFaEAAqhYyJhrMno=;
        b=dwgSvvfqT9h8cnS2ANlfzc/bgIB0QsDd8CDnK3UIm0ECJPG5JtjbaBFo+m/YimJjK1
         FlcF7DYGVOnxlmxsuZmwGYkLyzXE/+YXllLknn+tZ0URfSeZ5ZQm2ooYJMUDaCgm9HD3
         EMRZmApldwJieHbJYGroUPtE8c2Vj1YgXUDFNmuw6MbqODyN/lDCN2SE2s0i09cVaycM
         IwOY8mSDO8eTap09s5EpC3UjfSkki/wTO7MZecQEtHfYnAOIxSA33Hg4SfFIAFGar366
         ucYHtFxnE0S6mZ5Oye/3L5iPNtWCHGNxHVp6H5k1FOv9CqWStIWrJaHE35yH0GApsM9x
         ZyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296501; x=1692901301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQTGF+g2uioZsuYxh2OZLeccAuWFaEAAqhYyJhrMno=;
        b=XFwI2ysUZMSt9O/d4x7sCD3ii7wfXtGe14tFWQbYgPj+4vo5GDzz6Qj6rVmkdu+IfQ
         UrEi4p7kS48GksHnZRbnYHLivnOCaZENXo4HnW1WsdCZhyBGdsiFULGbnByPC/V4wfiv
         UAJWrcFEVBuXYyp5asrosrVP8Y5gVnjvD2V8HFil6aQcIyFTfXZ5QPqc8GmCjbxQXaTE
         YGOVmTm07Q0Xnh8UmCwj9C4lI4DWoN3TtimKkwNrCnnUVdE2kpaQLKYE3RnYyZ6qvXr8
         hyZPPybb9F1EF5sjL8AEEf9ckg8c0XHsQ1UZxDb3c5rBe0GZEtm9TkzztDPdV4aqafWV
         7sAw==
X-Gm-Message-State: AOJu0YzYYa2THVQHiVIZAaAEpSNYRAp5CIGx68w/okI3tL3Yw9+BINEF
        iKoDywwOyyKyO7hNUzbXQuHRQ6Mt02D0
X-Google-Smtp-Source: AGHT+IGki4STCy0HIY6Al3kylQ4EKIZ5nbsBXL4XMwGt8Fl0igDhFp/d8IMaNrxqUESLF7rmYoeQWgvp+7e3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:ab8c:0:b0:d45:daf4:1fc5 with SMTP id
 v12-20020a25ab8c000000b00d45daf41fc5mr4372ybi.3.1692296500636; Thu, 17 Aug
 2023 11:21:40 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:29 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.7.I65dd382de382428dcb33333342b35405903ac768@changeid>
Subject: [RFC PATCH v1 7/8] iommu/arm-smmu-v3: check for domain initialization
 using pgtbl_ops
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove smmu_domain->smmu in the next commit

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7f88b2b19cbe5..c9f89f4f47721 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2918,7 +2918,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	int ret = 0;
 
 	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
+	if (smmu_domain->pgtbl_ops)
 		ret = -EPERM;
 	else
 		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-- 
2.42.0.rc1.204.g551eb34607-goog

