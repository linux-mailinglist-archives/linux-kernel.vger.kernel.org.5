Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93078FEC2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349899AbjIAOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbjIAOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:11:13 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7CA010EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:11:07 -0700 (PDT)
Received: from 8bytes.org (pd9fe9d6f.dip0.t-ipconnect.de [217.254.157.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 66933269FFB;
        Fri,  1 Sep 2023 16:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1693577465;
        bh=nSFtFeyXTuklogjUQuXzaAJdkKneyZ9AvBVAjwoFtOA=;
        h=Date:From:To:Cc:Subject:From;
        b=uvOzyfE2DUYVspUDvfPYOuDqaQrrPd5FO/ik5gGgBsiHA2J2Jy+z1eXS3x2ws9fy7
         yyK9DP5H8bBUWhR1STNuSotsQ2Qj1Noftkq7NaOU6vf3H4JCzwdeGC+1jdZp12/grX
         lKRi0cAOoPclVaOzyv0jDYL+Bg1+xNFLMg0JO5GHEdD+xUKsFSndObxVXyaVd1iwFA
         3pdY2C3q7PzwPqxQW9FJktA4U6TMQ/OI4taixToGbYmIiO+341htRYHH+HIzHZpobt
         MPk2y10aPadJe+Yjd3u1mxM1rA/ztHvNFUx9dKJHMvq8R/4XhNwMja/Yz1aU3tBbj4
         NmKqLzO7BDFtw==
Date:   Fri, 1 Sep 2023 16:11:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.6
Message-ID: <ZPHw-MSyehz1wF7c@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="admroTXvaqUJoes2"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--admroTXvaqUJoes2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Two things to notice on this PR:

	1. It includes another try of optimizing the IOVA allocation
	   path for cases when the first 4GB begin to fill up. Previous
	   tries to do so have caused issues and got reverted, so this
	   time the optimization is explicitly disabled for PCI devices
	   (which are the primary reason of this allocation strategy
	    anyway). The change has been in linux-next for several weeks
	   and no problems were reported. So I am confident that it is a
	   real improvement this time and will not cause major issues.

	2. Stephen reported merge conflicts with iommfd tree, but I
	   couldn't reproduce them in my test-merge with your latest
	   tree. This might be due to removal of some problematic
	   patches from the IOMMU tree last week, as the iommufd tree
	   updates seem to be merged already. Anyway, if you run into
	   any problems please let me know.

With that said:

The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.6

for you to fetch changes up to d8fe59f11096d6470b5f53739e49cdce67f3e127:

  Merge branches 'apple/dart', 'arm/mediatek', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/amd' and 'core' into next (2023-08-21 14:18:43 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.6

Including:

	- Core changes:
	  - Consolidate probe_device path
	  - Make the PCI-SAC IOVA allocation trick PCI-only

	- AMD IOMMU:
	  - Consolidate PPR log handling
	  - Interrupt handling improvements
	  - Refcount fixes for amd_iommu_v2 driver

	- Intel VT-d driver:
	  - Enable idxd device DMA with pasid through iommu dma ops.
	  - Lift RESV_DIRECT check from VT-d driver to core.
	  - Miscellaneous cleanups and fixes.

	- ARM-SMMU drivers:
	  - Device-tree binding updates:
	    - Add additional compatible strings for Qualcomm SoCs
	    - Allow ASIDs to be configured in the DT to work around Qualcomm's
	      broken hypervisor
	    - Fix clocks for Qualcomm's MSM8998 SoC
	  - SMMUv2:
	    - Support for Qualcomm's legacy firmware implementation featured on
	      at least MSM8956 and MSM8976.
	    - Match compatible strings for Qualcomm SM6350 and SM6375 SoC variants
	  - SMMUv3:
	    - Use 'ida' instead of a bitmap for VMID allocation

	  - Rockchip IOMMU:
	    - Lift page-table allocation restrictions on newer hardware

	  - Mediatek IOMMU:
	    - Add MT8188 IOMMU Support

	  - Renesas IOMMU:
	    - Allow PCIe devices

	- Usual set of cleanups an smaller fixes

----------------------------------------------------------------
AngeloGioacchino Del Regno (6):
      dt-bindings: iommu: qcom,iommu: Add qcom,ctx-asid property
      dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and MSM8976 compatibles
      iommu/qcom: Use the asid read from device-tree if specified
      iommu/qcom: Disable and reset context bank before programming
      iommu/qcom: Index contexts by asid number to allow asid 0
      iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts

Chengci.Xu (5):
      dt-bindings: mediatek: mt8188: Add binding for MM & INFRA IOMMU
      iommu/mediatek: Fix two IOMMU share pagetable issue
      iommu/mediatek: Adjust mtk_iommu_config flow
      iommu/mediatek: Add enable IOMMU SMC command for INFRA masters
      iommu/mediatek: Add MT8188 IOMMU Support

Daniel Marcovitch (1):
      iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind

Dawei Li (1):
      iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Convert to read_poll_timeout_atomic()

Jacob Pan (3):
      iommu: Generalize PASID 0 for normal DMA w/o PASID
      iommu: Move global PASID allocation from SVA to core
      dmaengine/idxd: Re-enable kernel workqueue under DMA API

Jason Gunthorpe (11):
      iommu: Have __iommu_probe_device() check for already probed devices
      iommu: Use iommu_group_ref_get/put() for dev->iommu_group
      iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()
      iommu: Simplify the __iommu_group_remove_device() flow
      iommu: Add iommu_init/deinit_device() paired functions
      iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()
      iommu: Do not export iommu_device_link/unlink()
      iommu: Always destroy the iommu_group during iommu_release_device()
      iommu: Split iommu_group_add_device()
      iommu: Avoid locking/unlocking for iommu_probe_device()
      iommu/sprd: Add missing force_aperture

Joerg Roedel (2):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'apple/dart', 'arm/mediatek', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'unisoc', 'x86/vt-d', 'x86/amd' and 'core' into next

Jonas Karlman (2):
      iommu: rockchip: Fix directory table address encoding
      iommu: rockchip: Allocate tables from all available memory for IOMMU v2

Konrad Dybcio (5):
      dt-bindings: arm-smmu: Fix MSM8998 clocks description
      iommu/arm-smmu-qcom: Sort the compatible list alphabetically
      iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      iommu/arm-smmu-qcom: Add SM6350 DPU compatible
      iommu/arm-smmu-qcom: Add SM6375 SMMUv2

Lu Baolu (7):
      iommu/vt-d: Add domain_flush_pasid_iotlb()
      iommu/vt-d: Remove pasid_mutex
      iommu/vt-d: Make prq draining code generic
      iommu/vt-d: Prepare for set_dev_pasid callback
      iommu/vt-d: Add set_dev_pasid callback for dma domain
      iommu: Prevent RESV_DIRECT devices from blocking domains
      iommu/vt-d: Remove rmrr check in domain attaching device path

Min-Hua Chen (1):
      iommu/apple-dart: mark apple_dart_pm_ops static

Rob Herring (1):
      iommu: Explicitly include correct DT includes

Robin Murphy (1):
      iommu: Optimise PCI SAC address trick

Vasant Hegde (9):
      iommu/amd/iommu_v2: Clear pasid state in free path
      iommu/amd: Generalize log overflow handling
      iommu/amd: Handle PPR log overflow
      iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs
      iommu/amd: Enable separate interrupt for PPR and GA log
      iommu/amd: Disable PPR log/interrupt in iommu_disable()
      iommu/amd: Consolidate PPR log enablement
      iommu/amd: Enable PPR/GA interrupt after interrupt handler setup
      iommu/amd: Rearrange DTE bit definations

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Yanfei Xu (2):
      iommu/vt-d: Fix to flush cache of PASID directory table
      iommu/vt-d: Fix to convert mm pfn to dma pfn

Yangtao Li (1):
      iommu/arm-smmu: Clean up resource handling during Qualcomm context probe

Yong Wu (2):
      iommu/mediatek: mt8188: Add iova_region_larb_msk
      MAINTAINERS: iommu/mediatek: Update the header file name

Yoshihiro Shimoda (1):
      iommu/ipmmu-vmsa: Allow PCIe devices

Yue Haibing (1):
      iommu/amd: Remove unused declarations

YueHaibing (2):
      iommu/amd: Remove unsued extern declaration amd_iommu_init_hardware()
      iommu/vt-d: Remove unused extern declaration dmar_parse_dev_scope()

Zhu Wang (1):
      iommu: Remove kernel-doc warnings

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  41 ++
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  12 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |  22 +-
 MAINTAINERS                                        |   1 +
 drivers/acpi/scan.c                                |   2 +-
 drivers/dma/idxd/device.c                          |  39 +-
 drivers/dma/idxd/dma.c                             |   5 +-
 drivers/dma/idxd/idxd.h                            |   9 +
 drivers/dma/idxd/init.c                            |  54 ++-
 drivers/dma/idxd/sysfs.c                           |   7 -
 drivers/iommu/amd/amd_iommu.h                      |   7 +-
 drivers/iommu/amd/amd_iommu_types.h                |  22 +-
 drivers/iommu/amd/init.c                           | 131 ++++--
 drivers/iommu/amd/iommu.c                          |  86 ++--
 drivers/iommu/amd/iommu_v2.c                       |   7 +-
 drivers/iommu/apple-dart.c                         |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  45 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   7 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  71 ++-
 drivers/iommu/dma-iommu.c                          |  26 +-
 drivers/iommu/dma-iommu.h                          |   8 +
 drivers/iommu/intel/iommu.c                        | 244 ++++++----
 drivers/iommu/intel/iommu.h                        |   9 +
 drivers/iommu/intel/pasid.c                        |   4 +-
 drivers/iommu/intel/pasid.h                        |   2 -
 drivers/iommu/intel/svm.c                          |  62 +--
 drivers/iommu/iommu-sva.c                          |  29 +-
 drivers/iommu/iommu-sysfs.c                        |   8 -
 drivers/iommu/iommu.c                              | 483 +++++++++++---------
 drivers/iommu/ipmmu-vmsa.c                         |  21 +-
 drivers/iommu/mtk_iommu.c                          | 151 +++++--
 drivers/iommu/of_iommu.c                           |   2 +-
 drivers/iommu/rockchip-iommu.c                     |  50 +--
 drivers/iommu/sprd-iommu.c                         |   2 +
 drivers/iommu/tegra-smmu.c                         |   2 +-
 drivers/iommu/virtio-iommu.c                       |   2 +-
 .../memory/mediatek,mt8188-memory-port.h           | 489 +++++++++++++++++++++
 include/linux/amd-iommu.h                          |   1 -
 include/linux/dmar.h                               |   2 -
 include/linux/iommu.h                              |  15 +
 include/soc/mediatek/smi.h                         |   1 +
 45 files changed, 1518 insertions(+), 672 deletions(-)
 create mode 100644 include/dt-bindings/memory/mediatek,mt8188-memory-port.h

Please pull.

Thanks,

	Joerg

--admroTXvaqUJoes2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmTx8PEACgkQK/BELZcB
GuNYqBAAqYa4yaGWkTWhVALiy16JMJU2TaBtrQwA94wVrCYp6eHIqg+pn9bsKywj
0TDWcUgDGMu928plR7KrAVHicSa8JMVp9oHx24VCcZbRL6R6BtV1CEyCiFIVPB2k
F8JHHTRmVgOzyBROKi2e0qRzo+ajvrdnl+rGwmtGjYOkdzfs/WZtz37aTF945X2W
RSsgHRdGz0+Vs0he18mT6PcZUyzM+Bvxng57V+yCTJyP5BKRmi8VEvYXFAWon9qZ
CAYSoV10r8WsQ2200vY2hVSGee09alnQ14SnMVixmoEcrTPavGGyeR8Rc1a8hJ0n
izp3ub1+GRGnXoaWa1f1l76IzWCCSpEqh4NDEMEePp8VO8/gRGa+k6i8Eo4iNaJ5
a5M/NNtL9kv2vHnuNG+S8xbwt3DWJkYZ0zK9KFUgH9uhVWC2hl1P3Kq0+I3Fk/U4
QOkcyZjErysSY34gtw8fZpGt5F9Sw7c8nyh6aMv0Lr0mGxfS21/Uq5fR3BWTInrb
tqWrmxW5sg+23CZV2LxtsU7E/+FVx/JT5vbjLEdH/zMdalFDyj8ScTucKzQKF9Z+
K6uwcbYJ8cAfaaoqFw3J0yfxP3RZO1UQjwB7kAND7JhWRCoQ3GOrMc9kWQhEW9Eo
tpSA3m+MEb0P4D4DdnLcEAx+soR/3B9RxtII1BDn0AfPWw97qEo=
=+gaV
-----END PGP SIGNATURE-----

--admroTXvaqUJoes2--
