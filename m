Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98B786C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbjHXJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjHXJqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CF137;
        Thu, 24 Aug 2023 02:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB353615E2;
        Thu, 24 Aug 2023 09:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F7FC433C7;
        Thu, 24 Aug 2023 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692870407;
        bh=IIKZxYxnjfO3e6V6rnk/NYkRWHSz6S4eCzC3UWsqfZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bwFT2O/37VWKlpTrvpxkWL4+HKC96xJSaX3FNWTxoeGrICpnAOGbp5ZKLLCzNUQx4
         /0q8g1+5TUZQ7VnQsRJEVyjFP5K7KgYM2HJcKiaMu3NXrOZ+TgikovZoM7UG8DU3HV
         hCy5ZG3c6KH8zejWnz2Ty24dSqJLympVgiUzQuCjDG1jLIIwl3aSmwnRBdiOa5gbPt
         VQeTkTunArxRbJ2DnQ+Dc5p3Bn9t+XQ+Gosx7yiQtR/3jI2H9wRZhlzpqpS769+BkN
         TpGfGxEzmogrrqIMnQ7a3q25JhSddOGMF98Og9a3WPFTVWGi7y6uZSBwBjjT5iV5P+
         GNO9OL63+HAWw==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.6
Date:   Thu, 24 Aug 2023 12:46:33 +0300
Message-Id: <20230824094633.866043-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect updates for the 6.6-rc1 merge
window. In contains a mix of core and driver changes as usual. This time
it might look a bit bigger as lines of code, but 97.5% of these are related
to expanding some macros in drivers and bring no functional change. There
are also a few patches that touch qcom clock drivers and these are in
immutable branch that is pulled also by the qcom tree. It contains also a
debugfs patch that you acked recently. The complete summary and details
are in the signed tag.

All patches have been in linux-next during last few days. Please pull into
char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.6-rc1

for you to fetch changes up to 6ac3f01201fa1c453fc8a8ce5a7208da9cca254d:

  Merge branch 'icc-debugfs' into icc-next (2023-08-22 21:05:09 +0300)

----------------------------------------------------------------
interconnect changes for 6.6

This pull request contains the interconnect changes for the 6.6-rc1 merge
window which is a mix of core and driver changes with the following highlights:

Core changes:
- New generic test client driver that allows issuing bandwidth requests
  between endpoints via debugfs.
- Annotate all structs with flexible array members with the __counted_by
  attribute.
- Introduce new icc_bw_lock for cases where we need to serialize bandwidth
  aggregation and update to decouple that from paths that require memory
  allocation.

Driver changes:
- Move the Qualcomm SMD RPM bus-clocks from CCF to interconnect framework
  where they actually belong. This brings power management improvements
  and reduces the overhead and layering. These changes are in immutable
  branch that is being pulled also into the qcom tree.
- Fixes for QUP nodes on SM8250.
- Enable sync_state and keepalive for QCM2290.
- Enable sync_state for SM8450.
- Improve enable_mask-based BCMs handling and fix some bugs.
- Add compatible string for the OSM-L3 on SDM670.
- Add compatible strings for SC7180, SM8250 and SM6350 bandwidth monitors.
- Expand and retire the DEFINE_QNODE and DEFINE_QBCM macros, which have
  become ugly beasts with many different arguments.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (8):
      Merge branch 'qcom/20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git into icc-next
      interconnect: qcom: icc-rpm: Explicitly return 0 at the end of the function
      Merge branch 'icc-sm8250-qup' into icc-next
      Merge tag 'v6.5-rc6' into icc-next
      Merge branch 'icc-qcm2290' into icc-next
      Merge branch 'icc-enable-mask' into icc-next
      Merge branch 'icc-retire-macros' into icc-next
      Merge branch 'icc-debugfs' into icc-next

Kees Cook (3):
      interconnect: icc-clk: Annotate struct icc_clk_provider with __counted_by
      interconnect: Annotate struct icc_path with __counted_by
      interconnect: qcom: Annotate struct icc_onecell_data with __counted_by

Konrad Dybcio (52):
      dt-bindings: interconnect: qcom,bwmon: Document SC7180 BWMONs
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM8250 bwmon instances
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6350 bwmon instances
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
      interconnect: qcom: Define RPM bus clocks
      interconnect: qcom: sdm660: Hook up RPM bus clk definitions
      interconnect: qcom: msm8996: Hook up RPM bus clk definitions
      interconnect: qcom: qcs404: Hook up RPM bus clk definitions
      interconnect: qcom: msm8939: Hook up RPM bus clk definitions
      interconnect: qcom: msm8916: Hook up RPM bus clk definitions
      interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
      interconnect: qcom: icc-rpm: Control bus rpmcc from icc
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations
      dt-bindings: interconnect: qcom,rpmh: Add SM8250 QUP virt
      dt-bindings: interconnect: qcom,sm8250: Add QUP virt
      interconnect: qcom: sm8250: Fix QUP0 nodes
      interconnect: qcom: qcm2290: Enable keep_alive on all buses
      interconnect: qcom: qcm2290: Enable sync state
      interconnect: qcom: sm8450: Enable sync_state
      interconnect: qcom: bcm-voter: Improve enable_mask handling
      interconnect: qcom: bcm-voter: Use enable_maks for keepalive voting
      interconnect: qcom: sc7180: Retire DEFINE_QNODE
      interconnect: qcom: sdm670: Retire DEFINE_QNODE
      interconnect: qcom: sdm845: Retire DEFINE_QNODE
      interconnect: qcom: sdx55: Retire DEFINE_QNODE
      interconnect: qcom: sdx65: Retire DEFINE_QNODE
      interconnect: qcom: sm6350: Retire DEFINE_QNODE
      interconnect: qcom: sm8150: Retire DEFINE_QNODE
      interconnect: qcom: sm8250: Retire DEFINE_QNODE
      interconnect: qcom: sm8350: Retire DEFINE_QNODE
      interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
      interconnect: qcom: sc7180: Retire DEFINE_QBCM
      interconnect: qcom: sdm670: Retire DEFINE_QBCM
      interconnect: qcom: sdm845: Retire DEFINE_QBCM
      interconnect: qcom: sdx55: Retire DEFINE_QBCM
      interconnect: qcom: sdx65: Retire DEFINE_QBCM
      interconnect: qcom: sm6350: Retire DEFINE_QBCM
      interconnect: qcom: sm8150: Retire DEFINE_QBCM
      interconnect: qcom: sm8250: Retire DEFINE_QBCM
      interconnect: qcom: sm8350: Retire DEFINE_QBCM
      interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM

Mike Tipton (3):
      debugfs: Add write support to debugfs_create_str()
      interconnect: Reintroduce icc_get()
      interconnect: Add debugfs test client

Richard Acayan (1):
      dt-bindings: interconnect: OSM L3: add SDM670 compatible

Rob Clark (2):
      interconnect: Fix locking for runpm vs reclaim
      interconnect: Teach lockdep about icc_bw_lock order

Rob Herring (1):
      interconnect: Explicitly include correct DT includes

Stephan Gerhold (1):
      soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    6 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    1 +
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml  |   18 +-
 Documentation/driver-api/interconnect.rst                      |   25 +
 drivers/clk/qcom/clk-smd-rpm.c                                 |  314 +-
 drivers/interconnect/Makefile                                  |    2 +-
 drivers/interconnect/core.c                                    |   84 +-
 drivers/interconnect/debugfs-client.c                          |  168 +
 drivers/interconnect/icc-clk.c                                 |    2 +-
 drivers/interconnect/imx/imx8mp.c                              |    1 -
 drivers/interconnect/internal.h                                |    5 +-
 drivers/interconnect/qcom/Makefile                             |    2 +-
 drivers/interconnect/qcom/bcm-voter.c                          |   43 +-
 drivers/interconnect/qcom/bcm-voter.h                          |    8 -
 drivers/interconnect/qcom/icc-rpm-clocks.c                     |   77 +
 drivers/interconnect/qcom/icc-rpm.c                            |  224 +-
 drivers/interconnect/qcom/icc-rpm.h                            |   56 +-
 drivers/interconnect/qcom/icc-rpmh.c                           |    5 +-
 drivers/interconnect/qcom/icc-rpmh.h                           |   10 -
 drivers/interconnect/qcom/msm8916.c                            |    7 +-
 drivers/interconnect/qcom/msm8939.c                            |    8 +-
 drivers/interconnect/qcom/msm8974.c                            |    7 +-
 drivers/interconnect/qcom/msm8996.c                            |   13 +-
 drivers/interconnect/qcom/osm-l3.c                             |    4 +-
 drivers/interconnect/qcom/qcm2290.c                            |   18 +-
 drivers/interconnect/qcom/qcs404.c                             |    7 +-
 drivers/interconnect/qcom/qdu1000.c                            |    3 +-
 drivers/interconnect/qcom/sa8775p.c                            |    3 +-
 drivers/interconnect/qcom/sc7180.c                             | 1616 ++++++-
 drivers/interconnect/qcom/sc7280.c                             |    3 +-
 drivers/interconnect/qcom/sc8180x.c                            |    3 +-
 drivers/interconnect/qcom/sc8280xp.c                           |    3 +-
 drivers/interconnect/qcom/sdm660.c                             |   11 +-
 drivers/interconnect/qcom/sdm670.c                             | 1389 +++++-
 drivers/interconnect/qcom/sdm845.c                             | 1658 ++++++-
 drivers/interconnect/qcom/sdx55.c                              |  846 +++-
 drivers/interconnect/qcom/sdx65.c                              |  833 +++-
 drivers/interconnect/qcom/sm6350.c                             | 1529 +++++-
 drivers/interconnect/qcom/sm8150.c                             | 1689 ++++++-
 drivers/interconnect/qcom/sm8250.c                             | 1822 +++++++-
 drivers/interconnect/qcom/sm8250.h                             |    6 +
 drivers/interconnect/qcom/sm8350.c                             | 1801 ++++++-
 drivers/interconnect/qcom/sm8450.c                             |    5 +-
 drivers/interconnect/qcom/sm8550.c                             |    4 +-
 drivers/interconnect/qcom/smd-rpm.c                            |   25 +-
 drivers/interconnect/qcom/smd-rpm.h                            |   15 -
 drivers/soc/qcom/smd-rpm.c                                     |   17 +-
 fs/debugfs/file.c                                              |   48 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h                |   13 +
 include/dt-bindings/interconnect/qcom,sm8250.h                 |    7 +
 include/linux/interconnect-provider.h                          |    2 +-
 include/linux/soc/qcom/smd-rpm.h                               |   20 +-
 52 files changed, 12766 insertions(+), 1720 deletions(-)
 create mode 100644 drivers/interconnect/debugfs-client.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-clocks.c
 delete mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,rpm-icc.h
