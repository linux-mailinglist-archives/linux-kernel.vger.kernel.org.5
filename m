Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB27B675A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjJCLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjJCLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:12:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07767C6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:12:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c737d61a00so5663165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696331569; x=1696936369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tBABO7GPyJwZw3Nk8JykIKdvU51HhvEtWXYIL3h5YI=;
        b=PgHhF3Sdw9k3XNoVvq2aN22cVzV+dotmdsIJfOMyVWL16ZstbTSeiMCiVTkHhsrocc
         WQHs6RdXnHZv+w0Fep/WQPM4Gkls3mJh8Qa66x25yK/SgPEIvE5XPvTqxBSZUcWAtUfz
         +8vkxO0+i5KldeIffnIDVOkhqsn54N1FpKtErNBORz8FHt9SJm6RGrG3MjAfIV8tZ9QH
         men/1PgZ+mKutOw55lCn32r1b7yoXEMfzgfgmAT7GU7T4RqSzWAMLIMnJT78bR0I7umQ
         FQOMvFZjna5oqVbG6jMgHQDqq7hOm62dsHIEkgKHQeL5W97qrcM16Pl/iGuJpf4D+zSb
         iTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331569; x=1696936369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tBABO7GPyJwZw3Nk8JykIKdvU51HhvEtWXYIL3h5YI=;
        b=YzgdjMyjfeNSQbTdtNZOOO//QFe7PQO3WrH1XbapWS+AbSaV9WIy2lUZyhsIxoFoP/
         mIzqFJcpt2GIhPzaP+mHdthXV7+Ual8nK/Ua2TKLJryUqWdwfOg5hp3hP28jioGhhNtl
         nFaVg5N7kOYfJRsEWu7mVc2HIcdMANRRPTMvmS1T7uMSPB9Xb+tdQ6panGGQxP60bAcP
         OcUrSh6Moz/+lA4G9OpntnVTq7RvX0vR0lZ9dh4A5Vqtub6U7T/zklABGHhJlcCEqx43
         djALFQsxEpSdl+68wWZlnAKpmrtAdOhq+y7dr+oB2iKW0If5ZBcdNhEEoaSBSTXpL62s
         c5Pw==
X-Gm-Message-State: AOJu0Yw2GLVskyN49EO/zLXT+jCmG4EOW4WGtdFrK64SjASGdHjOKAY7
        dgM2WlawrZlEsew/mA67EOcn
X-Google-Smtp-Source: AGHT+IHzp+SOMu/BZxx+P/nC6osmYhEk82BGK9A+pP8pfPwut57hIo4DZE6nffFz8+zx+Z9d247D5w==
X-Received: by 2002:a17:902:c948:b0:1c4:4c73:94e6 with SMTP id i8-20020a170902c94800b001c44c7394e6mr16668612pla.51.1696331569220;
        Tue, 03 Oct 2023 04:12:49 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b001ab2b4105ddsm1250328plh.60.2023.10.03.04.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:12:48 -0700 (PDT)
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
Subject: [PATCH v4 0/6] UFS: Add OPP support
Date:   Tue,  3 Oct 2023 16:42:26 +0530
Message-Id: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Manivannan Sadhasivam (4):
  PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
    APIs
  scsi: ufs: core: Add OPP support for scaling clocks and regulators
  scsi: ufs: host: Add support for parsing OPP
  arm64: dts: qcom: sm8250: Add OPP table support to UFSHC

 .../devicetree/bindings/ufs/ufs-common.yaml   |  36 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  42 +++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  39 +++-
 drivers/devfreq/devfreq.c                     |  14 +-
 drivers/ufs/core/ufshcd.c                     | 179 ++++++++++++++----
 drivers/ufs/host/ufshcd-pltfrm.c              |  78 ++++++++
 include/ufs/ufshcd.h                          |   7 +
 7 files changed, 332 insertions(+), 63 deletions(-)

-- 
2.25.1

