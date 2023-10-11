Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F497C53D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbjJKM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjJKM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:26:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096AE8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:26:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-69fc829d7b1so3601133b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697027163; x=1697631963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uv/rlRYitJnK0DrpOEwxamLSxws/97bJsaf1Cey2fBE=;
        b=ypOpv9MTQSM/x9I87a53UyCxwB6tAdg1RxsJvh5M8Dd1Hi7sWLmIrJrpCv/YaFScXg
         J/kwzjFtI+cPGnFaNP1TYRA/r8315yK4SfIAVxhrYP1oqXarshmmSpNcPFKYpm+0Mozz
         1q12WiXOG5YxhL+H30kJWg1d8PXiXVjlIoAQFxALMWKKmc+t8ULLpBqHZlFUmVOd2TuA
         FJvTUETUrzWwUddY/aLL7jOcGcvg7dEikmfkQv3W1GGFkB8i+LaBZd4O13O0Lb97ZvBk
         CnKYgjfzQ6CQndPr59kdSs4U+34WxMuHrFUbx3TCHHZctcIWxbC6tiZskLfa0kXb1XrF
         aqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697027163; x=1697631963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uv/rlRYitJnK0DrpOEwxamLSxws/97bJsaf1Cey2fBE=;
        b=w/dz+4AYRsGl8OjFN0P2G9qvH1HEMQrXnU45gXeJO7RHsj0X6WC02MGllBigXihwCT
         mDiGaJ/LEJ9sPJkeBtxJwO9rHvjlK95XCxDHZq4OqkYFINjKgPxgEqeLj4HKJ1zOpzz3
         PZQReGx5lsDFkm9wTKmc3hbNu0PRX4KUdmDI9upSBoP/rkARnZphNJmDChR5LkCYMW8K
         zW9ApXD58ggE+QN4xQAXHJR31cZRGaqQeghpGKgLOAsG52c4l6WFg/+cLJu9R7TKVImM
         bn6i9wznqLoC0Iq/Ym19sYe3pg4T7gMLqW7OPvYWATVXWnWbZf13ukWeM1T1DWLXLfd7
         PjGg==
X-Gm-Message-State: AOJu0Yyx/3z7bXaXX5AMlaC9nyCd7cYbepxGBn2uGqrhltsC+6GcStyd
        dvncYtsIAARzg0cpyOraSSNM
X-Google-Smtp-Source: AGHT+IHMgFvyP/ZNlgH1hd7LaMJ22CwW7IVsks4SREGW/bKUOs8S5+Yani2sRPyVQFYaval6GFImcQ==
X-Received: by 2002:a05:6a00:2d23:b0:690:c5cf:91f4 with SMTP id fa35-20020a056a002d2300b00690c5cf91f4mr23872761pfb.12.1697027163274;
        Wed, 11 Oct 2023 05:26:03 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id a19-20020aa78653000000b0068fb8080939sm9953620pfo.65.2023.10.11.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:26:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/5] UFS: Add OPP support
Date:   Wed, 11 Oct 2023 17:55:38 +0530
Message-Id: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds OPP (Operating Points) support to UFSHCD driver.

Motivation behind adding OPP support is to scale both clocks as well as
regulators/performance state dynamically. Currently, UFSHCD just scales
clock frequency during runtime with the help of "freq-table-hz" property
defined in devicetree. With the addition of OPP tables in devicetree (as
done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
both clocks and performance state of power domain which helps in power
saving.

For the addition of OPP support to UFSHCD, there are changes required to
the OPP framework and devfreq drivers. The OPP framework changes are already
merged and the devfreq change is added in this series.

Credits
=======

This series is a continuation of previous work by Krzysztof Kozlowski [1].

Testing
=======

This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
development boards.

Merging Strategy
================

Since the devfreq patch got an Ack from the maintainer, either it can be merged
to scsi tree with rest of the patches or merged separately through devfreq tree.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/

Changes in v5:

* Dropped the devfreq patch since it got applied
* Fixed the bindings issue reported by DT bot
* Rebased on top of mkp/scsi/for-next

Changes in v4:

* Rebased on top of v6.6-rc3

Changes in v3:

* Rebased on top of linux-next/master tag: next-20230731
* Dropped the already applied patches (dts, opp binding and framework)
* Moved the interconnect patches to a separate series:
  https://lore.kernel.org/linux-scsi/20230731145020.41262-1-manivannan.sadhasivam@linaro.org/
* Moved ufshcd_opp_config_clks() API to ufshcd.c to fix the build failure
  reported by Kbuild bot: https://lore.kernel.org/all/202307210542.KoLHRbU6-lkp@intel.com/
* Collected Acks
* v2: https://lore.kernel.org/all/20230720054100.9940-1-manivannan.sadhasivam@linaro.org/

Changes in v2:

* Added more description to the bindings patch 2/15
* Fixed dev_pm_opp_put() usage in patch 10/15
* Added a new patch for adding enums for UFS lanes 14/15
* Changed the icc variables to mem_bw and cfg_bw and used
  the enums for gears and lanes in bw_table
* Collected review tags
* Added SCSI list and folks
* Removed duplicate patches

Krzysztof Kozlowski (2):
  dt-bindings: ufs: common: add OPP table
  arm64: dts: qcom: sdm845: Add OPP table support to UFSHC

Manivannan Sadhasivam (3):
  scsi: ufs: core: Add OPP support for scaling clocks and regulators
  scsi: ufs: host: Add support for parsing OPP
  arm64: dts: qcom: sm8250: Add OPP table support to UFSHC

 .../devicetree/bindings/ufs/ufs-common.yaml   |  35 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  42 +++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  39 +++-
 drivers/ufs/core/ufshcd.c                     | 179 ++++++++++++++----
 drivers/ufs/host/ufshcd-pltfrm.c              |  78 ++++++++
 include/ufs/ufshcd.h                          |   7 +
 6 files changed, 325 insertions(+), 55 deletions(-)

-- 
2.25.1

