Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADB7E0B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377851AbjKCWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376749AbjKCWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:54:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6D9D6F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:54:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5094727fa67so3379368e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699052054; x=1699656854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umt0TPj4nshu0V3EQdMVsdcmvgrR/dSt/qtZRwkMkUE=;
        b=geGjDyvKhC3YJZ1HIc8XwXs62hR2PGOzqRE8LaxeQh/SfZaUC5UweA6PZ+F2eU5Hce
         PDbCyz0+ZueUy8XEibxE8HhrFm3AtV2X+Y9nJwF/UDo+Fi2xxwFKvFxXjLCMkrl513Jh
         WloFNGpgN46FhB9JuY4/nHmlS7yz+CI2aqNVI85F4AG/VvVm8pNMWc3bQNjVOmMs5AIk
         CKNEZKbR7JsHu9Qmc/2jzS5wk0Wk4djiHPuGi7CozLXvPOBBjg8K43VHCq9xlflBlwfz
         Vgrxx7vfhLlF8Wx8c0cq7VVsQ+JoDgn1Lu0Xs/Wgcg7r26GOS7MaA4/3xcp/SABU+3R0
         eC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052054; x=1699656854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umt0TPj4nshu0V3EQdMVsdcmvgrR/dSt/qtZRwkMkUE=;
        b=X33StzXyf8SmCCGXhWfYDB8Sjdh2OivZ0QY2FeQ/dNt30TYIyeVyhcaBaXYtL0Hu1v
         QIOLaHt2q48tFeUilqoyBDqJGTh5kViWXXfOyAmoqJ/FabtEtL6w5masGItEv81wFQZ1
         fR6GcS/2YjdXHK1Yi4Z4WC6jJnbNpAAULKnKsnobiY+YivyWbQjlTetbyTjoq+4Bv6bb
         9wHZ2BuUUdz55x9AO6gLwu77WQgikQOS1uaygIaSP4f2URwI/Ghb7a/P2G6xKGzcY8fh
         Kt5sY8NF6DWKexe4HCxMuzJdz2l+Lrr8j8HLHfvL/eFpqHVnB31PqwkmLTxOyZEcVzN3
         L56g==
X-Gm-Message-State: AOJu0Yxiy2t+kaGb4PZUqsE7yk4MIc9WITjUexeJEDEuQcJfMFQKzgP9
        ZLP/MuAaVQSy9DWUFzl28oAqPw==
X-Google-Smtp-Source: AGHT+IEHhxBChb8k7T5rMq/zqfWwHN4Qghq3nc3Rm/+b0JrtGnrBUumdbXfZLWSA6oxuGMW4srCyJg==
X-Received: by 2002:ac2:5935:0:b0:503:1be5:24eb with SMTP id v21-20020ac25935000000b005031be524ebmr15688875lfi.50.1699052054588;
        Fri, 03 Nov 2023 15:54:14 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512318a00b00507aa6ab0ecsm335202lfe.248.2023.11.03.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:54:14 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: list all Qualcomm IOMMU drivers in the QUALCOMM IOMMU entry
Date:   Sat,  4 Nov 2023 00:54:13 +0200
Message-ID: <20231103225413.1479857-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
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

For historical reasons the 'QUALCOMM IOMMU' entry lists only one
Qualcomm IOMMU driver. However there are also the historical MSM IOMMU
driver, which is used for old 32-bit platforms, and the
Qualcomm-specific customisations for the generic ARM SMMU driver. List
all these files under the QUALCOMM IOMMU entry.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a7dc3e56e1e..ed1c864794aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17888,6 +17888,8 @@ L:	iommu@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/arm/arm-smmu/qcom_iommu.c
+F:	drivers/iommu/arm/arm-smmu/arm-smmu-qcom*
+F:	drivers/iommu/msm_iommu*
 
 QUALCOMM IPC ROUTER (QRTR) DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-- 
2.42.0

