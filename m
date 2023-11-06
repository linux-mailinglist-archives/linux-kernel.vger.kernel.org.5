Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8947E2A23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjKFQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:43:23 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19024125
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:43:17 -0800 (PST)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 09D5D1A8330;
        Mon,  6 Nov 2023 17:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1699288996;
        bh=1d060c5s7z54zTFRX/dnNNgY8RO3N5gfL7mYAJ5RjH4=;
        h=Date:From:To:Cc:Subject:From;
        b=hpQaLPX/3M/98sqeWa5dCc85q4GAJYA6NYy3Y/bDsi+2Iyeji/bHZzEaB+t/CN/1W
         PHQCd9JMIuY1bv2eCChC9i6qi4qPW5+d9rboZTgmqjQqBJEbSG5Jicv0WKHKFF0/xc
         uSsuUZGrH5KpaD5+QCWypyFnFSP3R3pUzEOGdr/OSS92emj1Q7Z6RXBj2K2+98ZvKv
         U7NFD80HwEbq/d9Rnom1vgIekpivN/r+p2UWozzt62YXIvwVm42rCqtR6a5i0uud0p
         lhKo+aBl/+tDmdrWgvBkzIbl0A3W4p2iOGfHzueZnn3DQbfN7J2W356oL99kXsW/Xs
         kU8pwdTTbozvg==
Date:   Mon, 6 Nov 2023 17:43:14 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.7
Message-ID: <ZUkXojmVf2CmkXHh@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ge33+DIG619z24fh"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ge33+DIG619z24fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Three things:

	1. Sorry for sending this PR late. I suffered some fever since
	   end of last week, which delayed it.

	2. There are conflicts with the current upstream code, mainly
	   from iommufd changes. My resolution is attached.

	3. This PR is based on v6.6-rc7 and includes a fix which was
	   already merged into v6.6.

With that in mind please consider:

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v6.7

for you to fetch changes up to e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2:

  Merge branches 'iommu/fixes', 'arm/tegra', 'arm/smmu', 'virtio', 'x86/vt-=
d', 'x86/amd', 'core' and 's390' into next (2023-10-27 09:13:40 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.7

Including:

	- Core changes:
	  - Make default-domains mandatory for all IOMMU drivers
	  - Remove group refcounting
	  - Add generic_single_device_group() helper and consolidate
	    drivers
	  - Cleanup map/unmap ops
	  - Scaling improvements for the IOVA rcache depot
	  - Convert dart & iommufd to the new domain_alloc_paging()

	- ARM-SMMU:
	  - Device-tree binding update:
	    - Add qcom,sm7150-smmu-v2 for Adreno on SM7150 SoC
	  - SMMUv2:
	    - Support for Qualcomm SDM670 (MDSS) and SM7150 SoCs
	  - SMMUv3:
	    - Large refactoring of the context descriptor code to
	      move the CD table into the master, paving the way
	      for '->set_dev_pasid()' support on non-SVA domains
	  - Minor cleanups to the SVA code

	- Intel VT-d:
	  - Enable debugfs to dump domain attached to a pasid
	  - Remove an unnecessary inline function.

	- AMD IOMMU:
	  - Initial patches for SVA support (not complete yet)

	- S390 IOMMU:
	  - DMA-API conversion and optimized IOTLB flushing

	- Some smaller fixes and improvements

----------------------------------------------------------------
Dan Carpenter (1):
      iommu: change iommu_map_sgtable to return signed values

Danila Tikhonov (2):
      dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
      iommu/arm-smmu-qcom: Add SM7150 SMMUv2

Gustavo A. R. Silva (1):
      iommu/virtio: Add __counted_by for struct viommu_request and use stru=
ct_size()

Jason Gunthorpe (43):
      iommu: Add iommu_ops->identity_domain
      iommu: Add IOMMU_DOMAIN_PLATFORM
      powerpc/iommu: Setup a default domain and remove set_platform_dma_ops
      iommu: Add IOMMU_DOMAIN_PLATFORM for S390
      iommu/fsl_pamu: Implement a PLATFORM domain
      iommu/tegra-gart: Remove tegra-gart
      iommu/mtk_iommu_v1: Implement an IDENTITY domain
      iommu: Reorganize iommu_get_default_domain_type() to respect def_doma=
in_type()
      iommu: Allow an IDENTITY domain as the default_domain in ARM32
      iommu/exynos: Implement an IDENTITY domain
      iommu/tegra-smmu: Implement an IDENTITY domain
      iommu/tegra-smmu: Support DMA domains in tegra
      iommu/omap: Implement an IDENTITY domain
      iommu/msm: Implement an IDENTITY domain
      iommu: Remove ops->set_platform_dma_ops()
      iommu/qcom_iommu: Add an IOMMU_IDENTITIY_DOMAIN
      iommu/ipmmu: Add an IOMMU_IDENTITIY_DOMAIN
      iommu/mtk_iommu: Add an IOMMU_IDENTITIY_DOMAIN
      iommu/sun50i: Add an IOMMU_IDENTITIY_DOMAIN
      iommu: Require a default_domain for all iommu drivers
      iommu: Add __iommu_group_domain_alloc()
      iommu: Add ops->domain_alloc_paging()
      iommu: Convert simple drivers with DOMAIN_DMA to domain_alloc_paging()
      iommu: Convert remaining simple drivers to domain_alloc_paging()
      iommu: Remove useless group refcounting
      iommu: Add generic_single_device_group()
      iommu/sun50i: Convert to generic_single_device_group()
      iommu/sprd: Convert to generic_single_device_group()
      iommu/rockchip: Convert to generic_single_device_group()
      iommu/ipmmu-vmsa: Convert to generic_single_device_group()
      iommu/omap: Convert to generic_single_device_group()
      iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled
      iommu: Fix return code in iommu_group_alloc_default_domain()
      powerpc/iommu: Do not do platform domain attach atctions after probe
      iommu: Move IOMMU_DOMAIN_BLOCKED global statics to ops->blocked_domain
      iommu/vt-d: Update the definition of the blocking domain
      iommu/vt-d: Use ops->blocked_domain
      iommufd: Convert to alloc_domain_paging()
      iommu/dart: Use static global identity domains
      iommu/dart: Move the blocked domain support to a global static
      iommu/dart: Convert to domain_alloc_paging()
      iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging=
()
      iommu/dart: Remove the force_bypass variable

Jiapeng Chong (2):
      iommu: Remove duplicate include
      iommu/vt-d: Remove unused function

Jingqi Liu (3):
      iommu/vt-d: debugfs: Dump entry pointing to huge page
      iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
      iommu/vt-d: debugfs: Support dumping a specified page table

Jinjie Ruan (1):
      iommu/tegra-smmu: Drop unnecessary error check for for debugfs_create=
_dir()

Joerg Roedel (3):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      Merge tag 'v6.6-rc7' into core
      Merge branches 'iommu/fixes', 'arm/tegra', 'arm/smmu', 'virtio', 'x86=
/vt-d', 'x86/amd', 'core' and 's390' into next

Lu Baolu (2):
      Revert "iommu/vt-d: Remove unused function"
      iommu: Avoid unnecessary cache invalidations

Michael Shavit (11):
      iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
      iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
      iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
      iommu/arm-smmu-v3: move stall_enabled to the cd table
      iommu/arm-smmu-v3: Refactor write_ctx_desc
      iommu/arm-smmu-v3: Move CD table to arm_smmu_master
      iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
      iommu/arm-smmu-v3: Update comment about STE liveness
      iommu/arm-smmu-v3: Rename cdcfg to cd_table
      iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
      iommu/arm-smmu-v3-sva: Remove bond refcount

Niklas Schnelle (7):
      iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
      s390/pci: prepare is_passed_through() for dma-iommu
      s390/pci: Use dma-iommu layer
      iommu/s390: Disable deferred flush for ISM devices
      iommu/dma: Allow a single FQ in addition to per-CPU FQs
      iommu/dma: Use a large flush queue and timeout for shadow_on_flush
      s390/pci: Fix reset of IOMMU software counters

Richard Acayan (1):
      iommu/arm-smmu-qcom: Add SDM670 MDSS compatible

Robin Murphy (9):
      iommu/exynos: Update to {map,unmap}_pages
      iommu/omap: Update to {map,unmap}_pages
      iommu/rockchip: Update to {map,unmap}_pages
      iommu/sun50i: Update to {map,unmap}_pages
      iommu/tegra-smmu: Update to {map,unmap}_pages
      iommu: Retire map/unmap ops
      iommu: Improve map/unmap sanity checks
      iommu/iova: Make the rcache depot scale better
      iommu/iova: Manage the depot list size

Suravee Suthikulpanit (8):
      iommu/amd: Remove unused amd_io_pgtable.pt_root variable
      iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
      iommu/amd: Consolidate logic to allocate protection domain
      iommu/amd: Introduce helper functions for managing GCR3 table
      iommu/amd: Miscellaneous clean up when free domain
      iommu/amd: Consolidate feature detection and reporting logic
      iommu/amd: Modify logic for checking GT and PPR features
      iommu/amd: Introduce iommu_dev_data.ppr

Vasant Hegde (12):
      iommu/amd: Refactor protection domain allocation code
      iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
      iommu/amd: Rename ats related variables
      iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
      iommu/amd: Enable device ATS/PASID/PRI capabilities independently
      iommu/amd: Initialize iommu_device->max_pasids
      iommu/amd: Remove iommu_v2 module
      iommu/amd: Remove PPR support
      iommu/amd: Remove amd_iommu_device_info()
      iommu/amd: Remove unused EXPORT_SYMBOLS
      Revert "iommu: Fix false ownership failure on AMD systems with PASID =
activated"
      iommu/amd: Remove DMA_FQ type from domain allocation path

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/up=
dates

 Documentation/admin-guide/kernel-parameters.txt    |   9 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/configs/tegra_defconfig                   |   1 -
 arch/powerpc/kernel/iommu.c                        |  53 +-
 arch/s390/include/asm/pci.h                        |  11 -
 arch/s390/include/asm/pci_clp.h                    |   3 +
 arch/s390/include/asm/pci_dma.h                    | 121 +--
 arch/s390/pci/Makefile                             |   2 +-
 arch/s390/pci/pci.c                                |  35 +-
 arch/s390/pci/pci_bus.c                            |   5 -
 arch/s390/pci/pci_debug.c                          |  12 +-
 arch/s390/pci/pci_dma.c                            | 746 ---------------
 arch/s390/pci/pci_event.c                          |  17 +-
 arch/s390/pci/pci_sysfs.c                          |  19 +-
 drivers/iommu/Kconfig                              |  15 +-
 drivers/iommu/Makefile                             |   1 -
 drivers/iommu/amd/Kconfig                          |   9 -
 drivers/iommu/amd/Makefile                         |   1 -
 drivers/iommu/amd/amd_iommu.h                      |  35 +-
 drivers/iommu/amd/amd_iommu_types.h                |  52 +-
 drivers/iommu/amd/init.c                           | 117 +--
 drivers/iommu/amd/io_pgtable_v2.c                  |   8 +-
 drivers/iommu/amd/iommu.c                          | 577 +++++-------
 drivers/iommu/amd/iommu_v2.c                       | 996 -----------------=
----
 drivers/iommu/apple-dart.c                         | 138 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  71 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 251 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  17 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   2 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  45 +-
 drivers/iommu/dma-iommu.c                          | 200 ++++-
 drivers/iommu/exynos-iommu.c                       |  83 +-
 drivers/iommu/fsl_pamu_domain.c                    |  41 +-
 drivers/iommu/intel/debugfs.c                      | 215 ++++-
 drivers/iommu/intel/iommu.c                        |  19 +-
 drivers/iommu/intel/iommu.h                        |  14 +
 drivers/iommu/iommu.c                              | 458 +++++-----
 drivers/iommu/iommufd/selftest.c                   |  30 +-
 drivers/iommu/iova.c                               |  95 +-
 drivers/iommu/ipmmu-vmsa.c                         |  72 +-
 drivers/iommu/msm_iommu.c                          |  35 +-
 drivers/iommu/mtk_iommu.c                          |  35 +-
 drivers/iommu/mtk_iommu_v1.c                       |  28 +-
 drivers/iommu/omap-iommu.c                         |  69 +-
 drivers/iommu/omap-iommu.h                         |   2 +-
 drivers/iommu/rockchip-iommu.c                     |  59 +-
 drivers/iommu/s390-iommu.c                         | 424 ++++++++-
 drivers/iommu/sprd-iommu.c                         |  36 +-
 drivers/iommu/sun50i-iommu.c                       |  80 +-
 drivers/iommu/tegra-gart.c                         | 371 --------
 drivers/iommu/tegra-smmu.c                         |  58 +-
 drivers/iommu/virtio-iommu.c                       |   4 +-
 drivers/memory/tegra/mc.c                          |  34 -
 drivers/memory/tegra/tegra20.c                     |  28 -
 include/linux/amd-iommu.h                          | 120 ---
 include/linux/iommu.h                              |  38 +-
 include/soc/tegra/mc.h                             |  26 -
 58 files changed, 2140 insertions(+), 3906 deletions(-)
 delete mode 100644 arch/s390/pci/pci_dma.c
 delete mode 100644 drivers/iommu/amd/iommu_v2.c
 delete mode 100644 drivers/iommu/tegra-gart.c

Please pull.

Thanks,

	Joerg

diff --cc drivers/iommu/Kconfig
index ee9e2a2edbf5,3199fd54b462..7673bb82945b
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@@ -95,7 -91,7 +95,7 @@@ config IOMMU_DEBUGF
  choice
  	prompt "IOMMU default domain type"
  	depends on IOMMU_API
- 	default IOMMU_DEFAULT_DMA_LAZY if X86
 -	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64 || S390
++	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390
  	default IOMMU_DEFAULT_DMA_STRICT
  	help
  	  Choose the type of IOMMU domain used to manage DMA API usage by
@@@ -150,7 -146,7 +150,7 @@@ config OF_IOMM
 =20
  # IOMMU-agnostic DMA-mapping layer
  config IOMMU_DMA
- 	def_bool ARM64 || X86
 -	def_bool ARM64 || IA64 || X86 || S390
++	def_bool ARM64 || X86 || S390
  	select DMA_OPS
  	select IOMMU_API
  	select IOMMU_IOVA
diff --cc drivers/iommu/amd/iommu.c
index b399c5741378,089886485895..fcc987f5d4ed
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@@ -66,9 -63,7 +64,8 @@@ LIST_HEAD(hpet_map)
  LIST_HEAD(acpihid_map);
 =20
  const struct iommu_ops amd_iommu_ops;
 +const struct iommu_dirty_ops amd_dirty_ops;
 =20
- static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
  int amd_iommu_max_glx_val =3D -1;
 =20
  /*
@@@ -1607,14 -1735,9 +1737,12 @@@ static void set_dte_entry(struct amd_io
  	if (ats)
  		flags |=3D DTE_FLAG_IOTLB;
 =20
- 	if (ppr) {
- 		if (iommu_feature(iommu, FEATURE_EPHSUP))
- 			pte_root |=3D 1ULL << DEV_ENTRY_PPR;
- 	}
+ 	if (ppr)
+ 		pte_root |=3D 1ULL << DEV_ENTRY_PPR;
 =20
 +	if (domain->dirty_tracking)
 +		pte_root |=3D DTE_FLAG_HAD;
 +
  	if (domain->flags & PD_IOMMUV2_MASK) {
  		u64 gcr3 =3D iommu_virt_to_phys(domain->gcr3_tbl);
  		u64 glx  =3D domain->glx;
diff --cc drivers/iommu/intel/iommu.c
index d1037280abf7,d5d191a71fe0..3531b956556c
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@@ -4061,57 -4056,9 +4059,57 @@@ static struct iommu_domain *intel_iommu
  	return NULL;
  }
 =20
 +static struct iommu_domain *
 +intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 +			      struct iommu_domain *parent,
 +			      const struct iommu_user_data *user_data)
 +{
 +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
 +	bool dirty_tracking =3D flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 +	bool nested_parent =3D flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 +	struct intel_iommu *iommu =3D info->iommu;
 +	struct iommu_domain *domain;
 +
 +	/* Must be NESTING domain */
 +	if (parent) {
 +		if (!nested_supported(iommu) || flags)
 +			return ERR_PTR(-EOPNOTSUPP);
 +		return intel_nested_domain_alloc(parent, user_data);
 +	}
 +
 +	if (flags &
 +	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 +		return ERR_PTR(-EOPNOTSUPP);
 +	if (nested_parent && !nested_supported(iommu))
 +		return ERR_PTR(-EOPNOTSUPP);
 +	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 +		return ERR_PTR(-EOPNOTSUPP);
 +
 +	/*
 +	 * domain_alloc_user op needs to fully initialize a domain before
 +	 * return, so uses iommu_domain_alloc() here for simple.
 +	 */
 +	domain =3D iommu_domain_alloc(dev->bus);
 +	if (!domain)
 +		return ERR_PTR(-ENOMEM);
 +
 +	if (nested_parent)
 +		to_dmar_domain(domain)->nested_parent =3D true;
 +
 +	if (dirty_tracking) {
 +		if (to_dmar_domain(domain)->use_first_level) {
 +			iommu_domain_free(domain);
 +			return ERR_PTR(-EOPNOTSUPP);
 +		}
 +		domain->dirty_ops =3D &intel_dirty_ops;
 +	}
 +
 +	return domain;
 +}
 +
  static void intel_iommu_domain_free(struct iommu_domain *domain)
  {
- 	if (domain !=3D &si_domain->domain && domain !=3D &blocking_domain)
+ 	if (domain !=3D &si_domain->domain)
  		domain_exit(to_dmar_domain(domain));
  }
 =20
@@@ -4847,84 -4793,8 +4853,85 @@@ static void *intel_iommu_hw_info(struc
  	return vtd;
  }
 =20
 +static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 +					  bool enable)
 +{
 +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
 +	struct device_domain_info *info;
 +	int ret;
 +
 +	spin_lock(&dmar_domain->lock);
 +	if (dmar_domain->dirty_tracking =3D=3D enable)
 +		goto out_unlock;
 +
 +	list_for_each_entry(info, &dmar_domain->devices, link) {
 +		ret =3D intel_pasid_setup_dirty_tracking(info->iommu,
 +						       info->domain, info->dev,
 +						       IOMMU_NO_PASID, enable);
 +		if (ret)
 +			goto err_unwind;
 +	}
 +
 +	dmar_domain->dirty_tracking =3D enable;
 +out_unlock:
 +	spin_unlock(&dmar_domain->lock);
 +
 +	return 0;
 +
 +err_unwind:
 +	list_for_each_entry(info, &dmar_domain->devices, link)
 +		intel_pasid_setup_dirty_tracking(info->iommu, dmar_domain,
 +						 info->dev, IOMMU_NO_PASID,
 +						 dmar_domain->dirty_tracking);
 +	spin_unlock(&dmar_domain->lock);
 +	return ret;
 +}
 +
 +static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 +					    unsigned long iova, size_t size,
 +					    unsigned long flags,
 +					    struct iommu_dirty_bitmap *dirty)
 +{
 +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
 +	unsigned long end =3D iova + size - 1;
 +	unsigned long pgsize;
 +
 +	/*
 +	 * IOMMUFD core calls into a dirty tracking disabled domain without an
 +	 * IOVA bitmap set in order to clean dirty bits in all PTEs that might
 +	 * have occurred when we stopped dirty tracking. This ensures that we
 +	 * never inherit dirtied bits from a previous cycle.
 +	 */
 +	if (!dmar_domain->dirty_tracking && dirty->bitmap)
 +		return -EINVAL;
 +
 +	do {
 +		struct dma_pte *pte;
 +		int lvl =3D 0;
 +
 +		pte =3D pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &lvl,
 +				     GFP_ATOMIC);
 +		pgsize =3D level_size(lvl) << VTD_PAGE_SHIFT;
 +		if (!pte || !dma_pte_present(pte)) {
 +			iova +=3D pgsize;
 +			continue;
 +		}
 +
 +		if (dma_sl_pte_test_and_clear_dirty(pte, flags))
 +			iommu_dirty_bitmap_record(dirty, iova, pgsize);
 +		iova +=3D pgsize;
 +	} while (iova < end);
 +
 +	return 0;
 +}
 +
 +const struct iommu_dirty_ops intel_dirty_ops =3D {
 +	.set_dirty_tracking =3D intel_iommu_set_dirty_tracking,
 +	.read_and_clear_dirty =3D intel_iommu_read_and_clear_dirty,
 +};
 +
  const struct iommu_ops intel_iommu_ops =3D {
+ 	.blocked_domain		=3D &blocking_domain,
  	.capable		=3D intel_iommu_capable,
  	.hw_info		=3D intel_iommu_hw_info,
  	.domain_alloc		=3D intel_iommu_domain_alloc,
diff --cc drivers/iommu/iommufd/selftest.c
index d43a87737c1e,ee6079847091..679652b1815b
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@@ -432,28 -272,9 +427,20 @@@ static phys_addr_t mock_domain_iova_to_
 =20
  static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
  {
 -	return cap =3D=3D IOMMU_CAP_CACHE_COHERENCY;
 +	struct mock_dev *mdev =3D container_of(dev, struct mock_dev, dev);
 +
 +	switch (cap) {
 +	case IOMMU_CAP_CACHE_COHERENCY:
 +		return true;
 +	case IOMMU_CAP_DIRTY_TRACKING:
 +		return !(mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY);
 +	default:
 +		break;
 +	}
 +
 +	return false;
  }
 =20
- static void mock_domain_set_plaform_dma_ops(struct device *dev)
- {
- 	/*
- 	 * mock doesn't setup default domains because we can't hook into the
- 	 * normal probe path
- 	 */
- }
-=20
  static struct iommu_device mock_iommu_device =3D {
  };
 =20
@@@ -466,10 -293,8 +459,10 @@@ static const struct iommu_ops mock_ops=20
  	.owner =3D THIS_MODULE,
  	.pgsize_bitmap =3D MOCK_IO_PAGE_SIZE,
  	.hw_info =3D mock_domain_hw_info,
 +	.domain_alloc =3D mock_domain_alloc,
 +	.domain_alloc_user =3D mock_domain_alloc_user,
+ 	.domain_alloc_paging =3D mock_domain_alloc_paging,
  	.capable =3D mock_domain_capable,
- 	.set_platform_dma_ops =3D mock_domain_set_plaform_dma_ops,
  	.device_group =3D generic_device_group,
  	.probe_device =3D mock_probe_device,
  	.default_domain_ops =3D
diff --cc include/linux/iommu.h
index 8fb1b41b4d15,ddc25d239106..6925866ba247
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -66,10 -64,8 +66,11 @@@ struct iommu_domain_geometry=20
  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 =20
  #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
+ #define __IOMMU_DOMAIN_PLATFORM	(1U << 5)
 =20
 +#define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space ne=
sted
 +					      on a stage-2 translation        */
 +
  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
  /*
   * This are the possible domain-types
@@@ -96,7 -94,7 +99,8 @@@
  				 __IOMMU_DOMAIN_DMA_API |	\
  				 __IOMMU_DOMAIN_DMA_FQ)
  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 +#define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
+ #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
 =20
  struct iommu_domain {
  	unsigned type;
@@@ -327,19 -238,9 +331,21 @@@ static inline int __iommu_copy_struct_f
   *           op is allocated in the iommu driver and freed by the caller =
after
   *           use. The information type is one of enum iommu_hw_info_type =
defined
   *           in include/uapi/linux/iommufd.h.
 - * @domain_alloc: allocate iommu domain
 + * @domain_alloc: allocate and return an iommu domain if success. Otherwi=
se
 + *                NULL is returned. The domain is not fully initialized u=
ntil
 + *                the caller iommu_domain_alloc() returns.
 + * @domain_alloc_user: Allocate an iommu domain corresponding to the input
 + *                     parameters as defined in include/uapi/linux/iommuf=
d.h.
 + *                     Unlike @domain_alloc, it is called only by IOMMUFD=
 and
 + *                     must fully initialize the new domain before return.
 + *                     Upon success, if the @user_data is valid and the @=
parent
 + *                     points to a kernel-managed domain, the new domain =
must be
 + *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent m=
ust be
 + *                     NULL while the @user_data can be optionally provid=
ed, the
 + *                     new domain must support __IOMMU_DOMAIN_PAGING.
 + *                     Upon failure, ERR_PTR must be returned.
+  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
+  *                       UNMANAGED, DMA, and DMA_FQ domain types.
   * @probe_device: Add device to iommu driver handling
   * @release_device: Remove device from iommu driver handling
   * @probe_finalize: Do final setup work after the device is added to an I=
OMMU
@@@ -372,9 -277,7 +382,10 @@@ struct iommu_ops=20
 =20
  	/* Domain allocation and freeing by the iommu driver */
  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 +	struct iommu_domain *(*domain_alloc_user)(
 +		struct device *dev, u32 flags, struct iommu_domain *parent,
 +		const struct iommu_user_data *user_data);
+ 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 =20
  	struct iommu_device *(*probe_device)(struct device *dev);
  	void (*release_device)(struct device *dev);

--ge33+DIG619z24fh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmVJF6IACgkQK/BELZcB
GuN1zRAAgPJHms0GrPnqLyBF04DHJ34RinIVEaN/c0d9EoqqzY8QFiCZ97zmQMcs
GpqlPxvuhNb2IuofyYay8JwO6jvpg2GcLabYLMOSvTWDSVy7vNN9oA+FKYI4rKpE
XiSDTBtiqKGrugLtXbjllo3AJakhYqxzlzOR7Ke5QVYpyczjuO0u2PkaQnGhysFo
doYpXRtEN7MHOCQXI89dVCjE+PClYD9luo4UFaZ2GmWGCSZ+HPa/fWNzjj0tp4jA
DfDsiJyH+Qsi00pbz1imt03HJIjv8Cezr0t63QwcTHYLp0f41uqvQmn3x6Ng8FiU
xeDo+r0hRvkEpKZGuVfIj9VaBV7B5T4rWdwhaEQdTkDHwMhWgY4Yn4VZA7zf0ZvY
58fYPhzUuOWHag+eg//wLkfRVx/0ECycqP7yFAiKtXbrNMZXIYPT/SjcuIzd1i+R
UpdnCHoWadzQBiPMX1PEdMaG3VxaXcV+3IeGcgX7PqpD7O62sCZLGqe598zb8fHH
v3JYe+yWifubUda9hwYUfEXr6N8Xdv+3brQlcpn16LaIFNAaym6k6obSvy3WkQ6U
atUcROjmB6yxu+KAcffUHppS8lrnbv0WeNBI5z+qSVEcGfnJUhHU5pHEQqHkhwhH
6bwJ5bLfi8D/LWCLwKZPJspxM19d3rX0mw/ucLvYVxUDL5hiBGU=
=rIlR
-----END PGP SIGNATURE-----

--ge33+DIG619z24fh--
