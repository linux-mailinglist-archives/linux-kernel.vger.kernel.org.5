Return-Path: <linux-kernel+bounces-80264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1CA862CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84761F21D32
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7A1B941;
	Sun, 25 Feb 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORjPF8p9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBC1AAD0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891518; cv=none; b=V1+u3JXqMnGM/xA0Cz3eEB67RxlWOB9XHPorAqKBoNj+BWehltl/qtdXCMnoOFXo0dVzoU8yCccBaS78Yq/+3/mGiCse5ibaPEp/ksy/4N+axt6rpK0qTpci7IoK1OPTpQWW3/ISNiLg9k4dU8m15JQE03cncA38vCDdq4jPjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891518; c=relaxed/simple;
	bh=xSGvlZK/I+oRN7RGfMSKm6JzGeet0pyP8/2WBsDCkys=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DOyW6Riv8iUid0ttIg8Pq9sTpc5dS8DVONUIB7ijmoRV8lhcD8NpEAGSNF3BNqw0tFxTXEqWAmB+bmehuS50PwzviVnn5rYTh3e83A5Cuk5eKTVW4jrufhdxVzyzr2r9T6OlhEVw1P3M23Vq6rn3bWNrDOkXXjUEwp/qpWmJBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORjPF8p9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708891513; x=1740427513;
  h=date:from:to:cc:subject:message-id;
  bh=xSGvlZK/I+oRN7RGfMSKm6JzGeet0pyP8/2WBsDCkys=;
  b=ORjPF8p9BY/T1y7h/TQC/4seU9pr0f2tcdT5FPlXlqLXvt2Yqiu0DWgT
   nb6KsRRa/nU2wW6YhJAeB3jmn8wLomxWnAX5zUCpU5hh7m9qBS1uisoUf
   z2fTyER3/E7cQbkWR2ANfIv/8hXRfR5Bxf5VRVI3dver/pgUtOPk5Fa0s
   xi8rDnE9nqwGGV+ENnFmDVjN8owxMTw6/C3/aGsc0eVm5iZuEygNMcnC3
   tpWtk+vs7apd6/qMhtRUuXlhawNsd7YHn5QrqA03KG3Fqaep7xHZ4RyV2
   EpI7wlWxVJFHY6H7uWq7BD+C/8UrjwwbUIgMbCND6mO71X6fA7JdR46WY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3011879"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3011879"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:05:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6589886"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 Feb 2024 12:05:10 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reKkF-0009la-36;
	Sun, 25 Feb 2024 20:05:07 +0000
Date: Mon, 26 Feb 2024 04:04:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240223] BUILD REGRESSION
 b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4
Message-ID: <202402260434.1hqLWxJz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240223
branch HEAD: b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4  treewide: Address -Wflexible-array-member-not-at-end warnings

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402251943.zGBJ7sEO-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402252018.GR2eyulM-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402252045.eiZZhW0P-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

/usr/include/linux/kvm.h:1504:22: error: a parameter list without types is only allowed in a function definition
/usr/include/linux/kvm.h:1504:2: error: type name requires a specifier or qualifier
/usr/include/linux/kvm.h:1504:9: error: expected specifier-qualifier-list before 'struct_group_tagged'
/usr/include/linux/kvm.h:1505:14: error: expected ')'
/usr/include/linux/kvm.h:1505:8: error: unexpected type name '__u32': expected identifier
/usr/include/linux/kvm.h:1509:26: error: expected ';' at end of declaration list
/usr/include/linux/kvm.h:1510:2: error: expected member name or ';' after declaration specifiers
/usr/include/linux/virtio_pcidev.h:57:22: error: a parameter list without types is only allowed in a function definition
/usr/include/linux/virtio_pcidev.h:57:2: error: type name requires a specifier or qualifier
/usr/include/linux/virtio_pcidev.h:57:9: error: expected specifier-qualifier-list before 'struct_group_tagged'
/usr/include/linux/virtio_pcidev.h:58:13: error: expected ')'
/usr/include/linux/virtio_pcidev.h:58:8: error: unexpected type name '__u8': expected identifier
/usr/include/linux/virtio_pcidev.h:62:19: error: expected ';' at end of declaration list
/usr/include/linux/virtio_pcidev.h:63:2: error: expected member name or ';' after declaration specifiers
arch/x86/events/intel/ds.c:1758:41: error: incompatible pointer types passing 'struct perf_branch_stack_hdr *' to parameter of type 'struct perf_branch_stack *' [-Werror,-Wincompatible-pointer-types]
arch/x86/events/intel/ds.c:1758:55: error: passing argument 3 of 'perf_sample_save_brstack' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/firewire/core-cdev.c:1195:17: error: no member named 'header' in 'struct fw_iso_packet_hdr'
drivers/firewire/core-cdev.c:1195:30: error: 'struct fw_iso_packet_hdr' has no member named 'header'
drivers/net/ethernet/netronome/nfp/crypto/tls.c:184:9: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct nfp_crypto_req_add_front, struct nfp_crypto_req_add_front_hdr) || __builtin_types_compatible_p(struct nfp_crypto_req_add_front, void)': pointer type mismatch in container_of()
drivers/net/wireless/marvell/mwl8k.c:2485:8: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct mwl8k_cmd_pkt, struct mwl8k_cmd_pkt_hdr) || __builtin_types_compatible_p(struct mwl8k_cmd_pkt, void)': pointer type mismatch in container_of()
drivers/pci/controller/pci-hyperv.c:1442:47: error: no member named 'message' in 'struct pci_packet_hdr'
drivers/rpmsg/qcom_glink_native.c:832:7: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct glink_msg, struct glink_msg_hdr) || __builtin_types_compatible_p(struct glink_msg, void)': pointer type mismatch in container_of()
drivers/scsi/megaraid/megaraid_sas_fp.c:101:37: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
drivers/scsi/megaraid/megaraid_sas_fp.c:103:23: error: no member named 'ldSpanMap' in 'struct MR_DRV_RAID_MAP_hdr'
drivers/scsi/megaraid/megaraid_sas_fp.c:103:29: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
drivers/scsi/megaraid/megaraid_sas_fp.c:104:1: warning: control reaches end of non-void function [-Wreturn-type]
drivers/scsi/megaraid/megaraid_sas_fp.c:113:39: warning: parameter 'armIdx' set but not used [-Wunused-but-set-parameter]
drivers/scsi/megaraid/megaraid_sas_fp.c:123:35: warning: parameter 'span' set but not used [-Wunused-but-set-parameter]
drivers/scsi/megaraid/megaraid_sas_fp.c:171:26: error: incompatible pointer types initializing 'struct MR_DRV_RAID_MAP *' with an expression of type 'struct MR_DRV_RAID_MAP_hdr *' [-Werror,-Wincompatible-pointer-types]
drivers/scsi/megaraid/megaraid_sas_fp.c:171:47: error: initialization of 'struct MR_DRV_RAID_MAP *' from incompatible pointer type 'struct MR_DRV_RAID_MAP_hdr *' [-Werror=incompatible-pointer-types]
drivers/scsi/megaraid/megaraid_sas_fp.c:272:14: error: incompatible pointer types assigning to 'struct MR_FW_RAID_MAP *' from 'struct MR_FW_RAID_MAP_hdr *' [-Werror,-Wincompatible-pointer-types]
drivers/scsi/megaraid/megaraid_sas_fp.c:272:28: error: assignment to 'struct MR_FW_RAID_MAP *' from incompatible pointer type 'struct MR_FW_RAID_MAP_hdr *' [-Werror=incompatible-pointer-types]
drivers/scsi/megaraid/megaraid_sas_fp.c:319:14: error: incompatible pointer types assigning to 'struct MR_DRV_RAID_MAP *' from 'struct MR_DRV_RAID_MAP_hdr *' [-Werror,-Wincompatible-pointer-types]
drivers/scsi/megaraid/megaraid_sas_fp.c:319:21: error: assignment to 'struct MR_DRV_RAID_MAP *' from incompatible pointer type 'struct MR_DRV_RAID_MAP_hdr *' [-Werror=incompatible-pointer-types]
fs/notify/fdinfo.c:53:58: error: no member named 'f_handle' in 'struct file_handle_hdr'
fs/notify/fdinfo.c:53:64: error: 'struct file_handle_hdr' has no member named 'f_handle'
include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
mm/mmu_gather.c:148:13: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
mm/mmu_gather.c:148:13: error: incompatible pointer types assigning to 'struct mmu_gather_batch *' from 'struct mmu_gather_batch_hdr *' [-Werror,-Wincompatible-pointer-types]
mm/mmu_gather.c:148:20: error: assignment to 'struct mmu_gather_batch *' from incompatible pointer type 'struct mmu_gather_batch_hdr *' [-Werror=incompatible-pointer-types]
mm/mmu_gather.c:23:39: warning: comparison of distinct pointer types ('struct mmu_gather_batch *' and 'struct mmu_gather_batch_hdr *') [-Wcompare-distinct-pointer-types]
mm/mmu_gather.c:23:46: warning: comparison of distinct pointer types lacks a cast
mm/mmu_gather.c:87:23: error: incompatible pointer types passing 'struct mmu_gather_batch_hdr *' to parameter of type 'struct mmu_gather_batch *' [-Werror,-Wincompatible-pointer-types]
mm/mmu_gather.c:87:30: error: passing argument 1 of 'tlb_flush_rmap_batch' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/bluetooth/l2cap_core.c:3758:3: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct l2cap_ecred_conn_rsp, struct l2cap_ecred_conn_rsp_hdr) || __builtin_types_compatible_p(struct l2cap_ecred_conn_rsp, void)': pointer type mismatch in container_of()
net/bluetooth/l2cap_core.c:3758:3: error: static_assert failed due to requirement '__builtin_types_compatible_p(struct l2cap_ecred_conn_rsp, struct l2cap_ecred_conn_rsp_hdr) || __builtin_types_compatible_p(struct l2cap_ecred_conn_rsp, void)' "pointer type mismatch in container_of()"
net/smc/smc_clc.c:335:51: error: 'struct smc_clc_v2_extension' has no member named 'user_eids'
net/smc/smc_clc.h:145:11: error: expected identifier or '(' before '[' token
net/smc/smc_clc.h:145:33: error: brackets are not allowed here; to declare an array, place the brackets after the identifier
net/smc/smc_clc.h:146:1: warning: no semicolon at end of struct or union
security/integrity/ima/ima_api.c:289:44: error: incompatible pointer types passing 'struct ima_digest_data_hdr *' to parameter of type 'struct ima_digest_data *' [-Werror,-Wincompatible-pointer-types]
security/integrity/ima/ima_api.c:289:58: error: passing argument 3 of 'ima_calc_buffer_hash' from incompatible pointer type [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_api.c:291:51: error: passing argument 2 of 'ima_calc_file_hash' from incompatible pointer type [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_appraise.c:381:36: error: incompatible pointer types passing 'struct ima_digest_data_hdr *' to parameter of type 'struct ima_digest_data *' [-Werror,-Wincompatible-pointer-types]
security/integrity/ima/ima_appraise.c:381:64: error: passing argument 4 of 'calc_file_id_hash' from incompatible pointer type [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_init.c:56:17: error: incompatible pointer types assigning to 'struct ima_digest_data *' from 'struct ima_digest_data_hdr *' [-Werror,-Wincompatible-pointer-types]
security/integrity/ima/ima_init.c:56:24: error: assignment to 'struct ima_digest_data *' from incompatible pointer type 'struct ima_digest_data_hdr *' [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_init.c:73:36: error: incompatible pointer types passing 'struct ima_digest_data_hdr *' to parameter of type 'struct ima_digest_data *' [-Werror,-Wincompatible-pointer-types]
security/integrity/ima/ima_init.c:73:50: error: passing argument 1 of 'ima_calc_boot_aggregate' from incompatible pointer type [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_main.c:982:16: error: incompatible pointer types assigning to 'struct ima_digest_data *' from 'struct ima_digest_data_hdr *' [-Werror,-Wincompatible-pointer-types]
security/integrity/ima/ima_main.c:982:23: error: assignment to 'struct ima_digest_data *' from incompatible pointer type 'struct ima_digest_data_hdr *' [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_main.c:993:32: error: no member named 'digest' in 'struct ima_digest_data_hdr'
security/integrity/ima/ima_main.c:993:45: error: 'struct ima_digest_data_hdr' has no member named 'digest'
security/integrity/ima/ima_template_lib.c:361:37: error: incompatible pointer types passing 'struct ima_digest_data_hdr *' to parameter of type 'struct ima_digest_data *' [-Werror,-Wincompatible-pointer-types]
security/integrity/ima/ima_template_lib.c:361:58: error: passing argument 1 of 'ima_calc_boot_aggregate' from incompatible pointer type [-Werror=incompatible-pointer-types]
security/integrity/ima/ima_template_lib.c:371:25: error: no member named 'digest' in 'struct ima_digest_data_hdr'
security/integrity/ima/ima_template_lib.c:371:38: error: 'struct ima_digest_data_hdr' has no member named 'digest'
security/integrity/ima/ima_template_lib.c:382:55: error: passing argument 2 of 'ima_calc_file_hash' from incompatible pointer type [-Werror=incompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- arc-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- arc-randconfig-002-20240225
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- arm-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- arm-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- arm64-defconfig
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   `-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|-- csky-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- csky-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- csky-randconfig-002-20240225
|   |-- security-integrity-ima-ima_api.c:error:passing-argument-of-ima_calc_buffer_hash-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_api.c:error:passing-argument-of-ima_calc_file_hash-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_appraise.c:error:passing-argument-of-calc_file_id_hash-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_init.c:error:assignment-to-struct-ima_digest_data-from-incompatible-pointer-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-ima_init.c:error:passing-argument-of-ima_calc_boot_aggregate-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_main.c:error:assignment-to-struct-ima_digest_data-from-incompatible-pointer-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-ima_main.c:error:struct-ima_digest_data_hdr-has-no-member-named-digest
|   |-- security-integrity-ima-ima_template_lib.c:error:passing-argument-of-ima_calc_boot_aggregate-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_template_lib.c:error:passing-argument-of-ima_calc_file_hash-from-incompatible-pointer-type
|   `-- security-integrity-ima-ima_template_lib.c:error:struct-ima_digest_data_hdr-has-no-member-named-digest
|-- i386-allmodconfig
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- i386-allnoconfig
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-allyesconfig
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- i386-buildonly-randconfig-001-20240225
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   `-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|-- i386-buildonly-randconfig-002-20240225
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- usr-include-linux-kvm.h:error:expected-specifier-qualifier-list-before-struct_group_tagged
|   `-- usr-include-linux-virtio_pcidev.h:error:expected-specifier-qualifier-list-before-struct_group_tagged
|-- i386-randconfig-061-20240226
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- usr-include-linux-kvm.h:error:expected-specifier-qualifier-list-before-struct_group_tagged
|   `-- usr-include-linux-virtio_pcidev.h:error:expected-specifier-qualifier-list-before-struct_group_tagged
|-- loongarch-allmodconfig
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   `-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|-- loongarch-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-defconfig
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- m68k-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- microblaze-allmodconfig
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   `-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|-- microblaze-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- microblaze-allyesconfig
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- microblaze-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- nios2-allmodconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- nios2-defconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- openrisc-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- parisc-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- parisc-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc64-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- powerpc-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- riscv-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- riscv-randconfig-002-20240225
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- s390-allyesconfig
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   `-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|-- s390-randconfig-001-20240225
|   `-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|-- sh-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   `-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|-- sh-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- sparc-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-randconfig-001-20240225
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-randconfig-002-20240225
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- sparc64-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- sparc64-defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-randconfig-001-20240225
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-randconfig-002-20240225
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
|   |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
|   `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
|-- um-i386_defconfig
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-defconfig
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-121-20240226
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-122-20240226
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- security-integrity-ima-ima_api.c:error:passing-argument-of-ima_calc_buffer_hash-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_api.c:error:passing-argument-of-ima_calc_file_hash-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_init.c:error:assignment-to-struct-ima_digest_data-from-incompatible-pointer-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-ima_init.c:error:passing-argument-of-ima_calc_boot_aggregate-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_main.c:error:assignment-to-struct-ima_digest_data-from-incompatible-pointer-type-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-ima_main.c:error:struct-ima_digest_data_hdr-has-no-member-named-digest
|   |-- security-integrity-ima-ima_template_lib.c:error:passing-argument-of-ima_calc_boot_aggregate-from-incompatible-pointer-type
|   |-- security-integrity-ima-ima_template_lib.c:error:passing-argument-of-ima_calc_file_hash-from-incompatible-pointer-type
|   `-- security-integrity-ima-ima_template_lib.c:error:struct-ima_digest_data_hdr-has-no-member-named-digest
|-- x86_64-randconfig-123-20240226
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   |-- mm-mmu_gather.c:error:passing-argument-of-tlb_flush_rmap_batch-from-incompatible-pointer-type
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- usr-include-linux-kvm.h:error:expected-specifier-qualifier-list-before-struct_group_tagged
|   `-- usr-include-linux-virtio_pcidev.h:error:expected-specifier-qualifier-list-before-struct_group_tagged
|-- x86_64-randconfig-r133-20240226
|   |-- arch-x86-events-intel-ds.c:error:passing-argument-of-perf_sample_save_brstack-from-incompatible-pointer-type
|   |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- xtensa-allnoconfig
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- xtensa-randconfig-001-20240225
|   |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:assignment-to-struct-MR_FW_RAID_MAP-from-incompatible-pointer-type-struct-MR_FW_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:initialization-of-struct-MR_DRV_RAID_MAP-from-incompatible-pointer-type-struct-MR_DRV_RAID_MAP_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:struct-MR_DRV_RAID_MAP_hdr-has-no-member-named-ldSpanMap
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:control-reaches-end-of-non-void-function
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-armIdx-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-ld-set-but-not-used
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:warning:parameter-span-set-but-not-used
|   |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
|   |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
`-- xtensa-randconfig-002-20240225
    |-- drivers-firewire-core-cdev.c:error:struct-fw_iso_packet_hdr-has-no-member-named-header
    |-- fs-notify-fdinfo.c:error:struct-file_handle_hdr-has-no-member-named-f_handle
    |-- include-linux-build_bug.h:error:static-assertion-failed:pointer-type-mismatch-in-container_of()
    |-- mm-mmu_gather.c:error:assignment-to-struct-mmu_gather_batch-from-incompatible-pointer-type-struct-mmu_gather_batch_hdr
    |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
    |-- net-smc-smc_clc.c:error:struct-smc_clc_v2_extension-has-no-member-named-user_eids
    |-- net-smc-smc_clc.h:error:expected-identifier-or-(-before-token
    `-- net-smc-smc_clc.h:warning:no-semicolon-at-end-of-struct-or-union
clang_recent_errors
|-- arm-defconfig
|   `-- net-bluetooth-l2cap_core.c:error:static_assert-failed-due-to-requirement-__builtin_types_compatible_p(struct-l2cap_ecred_conn_rsp-struct-l2cap_ecred_conn_rsp_hdr)-__builtin_types_compatible_p(struct-l
|-- arm-randconfig-003-20240225
|   `-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|-- hexagon-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|   `-- net-bluetooth-l2cap_core.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-l2cap_ecred_conn_rsp-struct-l2cap_ecred_conn_rsp_hdr)-__builtin_types_compatible_p(struc
|-- hexagon-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|   `-- net-bluetooth-l2cap_core.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-l2cap_ecred_conn_rsp-struct-l2cap_ecred_conn_rsp_hdr)-__builtin_types_compatible_p(struc
|-- hexagon-defconfig
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- i386-buildonly-randconfig-003-20240225
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_DRV_RAID_MAP-from-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_FW_RAID_MAP-from-struct-MR_FW_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-initializing-struct-MR_DRV_RAID_MAP-with-an-expression-of-type-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:no-member-named-ldSpanMap-in-struct-MR_DRV_RAID_MAP_hdr
|   `-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|-- i386-defconfig
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- i386-randconfig-002-20240225
|   `-- net-bluetooth-l2cap_core.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-l2cap_ecred_conn_rsp-struct-l2cap_ecred_conn_rsp_hdr)-__builtin_types_compatible_p(struc
|-- i386-randconfig-011-20240225
|   |-- usr-include-linux-kvm.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- usr-include-linux-kvm.h:error:expected-)
|   |-- usr-include-linux-kvm.h:error:expected-at-end-of-declaration-list
|   |-- usr-include-linux-kvm.h:error:expected-member-name-or-after-declaration-specifiers
|   |-- usr-include-linux-kvm.h:error:type-name-requires-a-specifier-or-qualifier
|   |-- usr-include-linux-kvm.h:error:unexpected-type-name-__u32:expected-identifier
|   |-- usr-include-linux-virtio_pcidev.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- usr-include-linux-virtio_pcidev.h:error:expected-)
|   |-- usr-include-linux-virtio_pcidev.h:error:expected-at-end-of-declaration-list
|   |-- usr-include-linux-virtio_pcidev.h:error:expected-member-name-or-after-declaration-specifiers
|   |-- usr-include-linux-virtio_pcidev.h:error:type-name-requires-a-specifier-or-qualifier
|   `-- usr-include-linux-virtio_pcidev.h:error:unexpected-type-name-__u8:expected-identifier
|-- i386-randconfig-062-20240226
|   |-- arch-x86-events-intel-ds.c:error:incompatible-pointer-types-passing-struct-perf_branch_stack_hdr-to-parameter-of-type-struct-perf_branch_stack-Werror-Wincompatible-pointer-types
|   |-- fs-notify-fdinfo.c:error:no-member-named-f_handle-in-struct-file_handle_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-assigning-to-struct-mmu_gather_batch-from-struct-mmu_gather_batch_hdr-Werror-Wincompatible-pointer-types
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- powerpc-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_DRV_RAID_MAP-from-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_FW_RAID_MAP-from-struct-MR_FW_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-initializing-struct-MR_DRV_RAID_MAP-with-an-expression-of-type-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:no-member-named-ldSpanMap-in-struct-MR_DRV_RAID_MAP_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- powerpc-randconfig-003-20240225
|   `-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|-- powerpc64-randconfig-003-20240225
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- riscv-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-net-wireless-marvell-mwl8k.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-mwl8k_cmd_pkt-struct-mwl8k_cmd_pkt_hdr)-__builtin_types_compatible_p(struct-mw
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_DRV_RAID_MAP-from-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_FW_RAID_MAP-from-struct-MR_FW_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-initializing-struct-MR_DRV_RAID_MAP-with-an-expression-of-type-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:no-member-named-ldSpanMap-in-struct-MR_DRV_RAID_MAP_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|   `-- net-bluetooth-l2cap_core.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-l2cap_ecred_conn_rsp-struct-l2cap_ecred_conn_rsp_hdr)-__builtin_types_compatible_p(struc
|-- riscv-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_DRV_RAID_MAP-from-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_FW_RAID_MAP-from-struct-MR_FW_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-initializing-struct-MR_DRV_RAID_MAP-with-an-expression-of-type-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:no-member-named-ldSpanMap-in-struct-MR_DRV_RAID_MAP_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|   `-- net-bluetooth-l2cap_core.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-l2cap_ecred_conn_rsp-struct-l2cap_ecred_conn_rsp_hdr)-__builtin_types_compatible_p(struc
|-- riscv-defconfig
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- s390-allmodconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-net-ethernet-netronome-nfp-crypto-tls.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-nfp_crypto_req_add_front-struct-nfp_crypto_req_add_front_hdr)-__bui
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_DRV_RAID_MAP-from-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_FW_RAID_MAP-from-struct-MR_FW_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-initializing-struct-MR_DRV_RAID_MAP-with-an-expression-of-type-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:no-member-named-ldSpanMap-in-struct-MR_DRV_RAID_MAP_hdr
|   `-- net-smc-smc_clc.h:error:brackets-are-not-allowed-here-to-declare-an-array-place-the-brackets-after-the-identifier
|-- um-allmodconfig
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- um-allnoconfig
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- um-defconfig
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- um-randconfig-001-20240225
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- um-randconfig-002-20240225
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- um-x86_64_defconfig
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- x86_64-allnoconfig
|   |-- arch-x86-events-intel-ds.c:error:incompatible-pointer-types-passing-struct-perf_branch_stack_hdr-to-parameter-of-type-struct-perf_branch_stack-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-assigning-to-struct-mmu_gather_batch-from-struct-mmu_gather_batch_hdr-Werror-Wincompatible-pointer-types
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|-- x86_64-allyesconfig
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_DRV_RAID_MAP-from-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-assigning-to-struct-MR_FW_RAID_MAP-from-struct-MR_FW_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:incompatible-pointer-types-initializing-struct-MR_DRV_RAID_MAP-with-an-expression-of-type-struct-MR_DRV_RAID_MAP_hdr-Werror-Wincompatible-pointer-types
|   |-- drivers-scsi-megaraid-megaraid_sas_fp.c:error:no-member-named-ldSpanMap-in-struct-MR_DRV_RAID_MAP_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-passing-struct-mmu_gather_batch_hdr-to-parameter-of-type-struct-mmu_gather_batch-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|   |-- usr-include-linux-kvm.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- usr-include-linux-kvm.h:error:expected-)
|   |-- usr-include-linux-kvm.h:error:expected-at-end-of-declaration-list
|   |-- usr-include-linux-kvm.h:error:expected-member-name-or-after-declaration-specifiers
|   |-- usr-include-linux-kvm.h:error:type-name-requires-a-specifier-or-qualifier
|   |-- usr-include-linux-kvm.h:error:unexpected-type-name-__u32:expected-identifier
|   |-- usr-include-linux-virtio_pcidev.h:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   |-- usr-include-linux-virtio_pcidev.h:error:expected-)
|   |-- usr-include-linux-virtio_pcidev.h:error:expected-at-end-of-declaration-list
|   |-- usr-include-linux-virtio_pcidev.h:error:expected-member-name-or-after-declaration-specifiers
|   |-- usr-include-linux-virtio_pcidev.h:error:type-name-requires-a-specifier-or-qualifier
|   `-- usr-include-linux-virtio_pcidev.h:error:unexpected-type-name-__u8:expected-identifier
|-- x86_64-randconfig-161-20240225
|   |-- arch-x86-events-intel-ds.c:error:incompatible-pointer-types-passing-struct-perf_branch_stack_hdr-to-parameter-of-type-struct-perf_branch_stack-Werror-Wincompatible-pointer-types
|   |-- fs-notify-fdinfo.c:error:no-member-named-f_handle-in-struct-file_handle_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-assigning-to-struct-mmu_gather_batch-from-struct-mmu_gather_batch_hdr-Werror-Wincompatible-pointer-types
|   |-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
|   |-- security-integrity-ima-ima_api.c:error:incompatible-pointer-types-passing-struct-ima_digest_data_hdr-to-parameter-of-type-struct-ima_digest_data-Werror-Wincompatible-pointer-types
|   |-- security-integrity-ima-ima_appraise.c:error:incompatible-pointer-types-passing-struct-ima_digest_data_hdr-to-parameter-of-type-struct-ima_digest_data-Werror-Wincompatible-pointer-types
|   |-- security-integrity-ima-ima_init.c:error:incompatible-pointer-types-assigning-to-struct-ima_digest_data-from-struct-ima_digest_data_hdr-Werror-Wincompatible-pointer-types
|   |-- security-integrity-ima-ima_init.c:error:incompatible-pointer-types-passing-struct-ima_digest_data_hdr-to-parameter-of-type-struct-ima_digest_data-Werror-Wincompatible-pointer-types
|   |-- security-integrity-ima-ima_main.c:error:incompatible-pointer-types-assigning-to-struct-ima_digest_data-from-struct-ima_digest_data_hdr-Werror-Wincompatible-pointer-types
|   |-- security-integrity-ima-ima_main.c:error:no-member-named-digest-in-struct-ima_digest_data_hdr
|   |-- security-integrity-ima-ima_template_lib.c:error:incompatible-pointer-types-passing-struct-ima_digest_data_hdr-to-parameter-of-type-struct-ima_digest_data-Werror-Wincompatible-pointer-types
|   `-- security-integrity-ima-ima_template_lib.c:error:no-member-named-digest-in-struct-ima_digest_data_hdr
|-- x86_64-randconfig-r123-20240226
|   |-- arch-x86-events-intel-ds.c:error:incompatible-pointer-types-passing-struct-perf_branch_stack_hdr-to-parameter-of-type-struct-perf_branch_stack-Werror-Wincompatible-pointer-types
|   |-- drivers-firewire-core-cdev.c:error:no-member-named-header-in-struct-fw_iso_packet_hdr
|   |-- drivers-rpmsg-qcom_glink_native.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-glink_msg-struct-glink_msg_hdr)-__builtin_types_compatible_p(struct-glink_msg-voi
|   |-- fs-notify-fdinfo.c:error:no-member-named-f_handle-in-struct-file_handle_hdr
|   |-- mm-mmu_gather.c:error:incompatible-pointer-types-assigning-to-struct-mmu_gather_batch-from-struct-mmu_gather_batch_hdr-Werror-Wincompatible-pointer-types
|   `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)
`-- x86_64-rhel-8.3-rust
    |-- drivers-pci-controller-pci-hyperv.c:error:no-member-named-message-in-struct-pci_packet_hdr
    `-- mm-mmu_gather.c:warning:comparison-of-distinct-pointer-types-(-struct-mmu_gather_batch-and-struct-mmu_gather_batch_hdr-)

elapsed time: 730m

configs tested: 139
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240225   gcc  
arc                   randconfig-002-20240225   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240225   clang
arm                   randconfig-002-20240225   gcc  
arm                   randconfig-003-20240225   clang
arm                   randconfig-004-20240225   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240225   gcc  
arm64                 randconfig-002-20240225   clang
arm64                 randconfig-003-20240225   gcc  
arm64                 randconfig-004-20240225   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240225   gcc  
csky                  randconfig-002-20240225   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240225   clang
hexagon               randconfig-002-20240225   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240225   gcc  
i386         buildonly-randconfig-002-20240225   gcc  
i386         buildonly-randconfig-003-20240225   clang
i386         buildonly-randconfig-004-20240225   gcc  
i386         buildonly-randconfig-005-20240225   clang
i386         buildonly-randconfig-006-20240225   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240225   gcc  
i386                  randconfig-002-20240225   clang
i386                  randconfig-003-20240225   clang
i386                  randconfig-004-20240225   gcc  
i386                  randconfig-005-20240225   gcc  
i386                  randconfig-006-20240225   gcc  
i386                  randconfig-011-20240225   clang
i386                  randconfig-012-20240225   gcc  
i386                  randconfig-013-20240225   gcc  
i386                  randconfig-014-20240225   clang
i386                  randconfig-015-20240225   gcc  
i386                  randconfig-016-20240225   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240225   gcc  
loongarch             randconfig-002-20240225   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240225   gcc  
nios2                 randconfig-002-20240225   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240225   gcc  
parisc                randconfig-002-20240225   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240225   clang
powerpc               randconfig-002-20240225   clang
powerpc               randconfig-003-20240225   clang
powerpc64             randconfig-001-20240225   gcc  
powerpc64             randconfig-002-20240225   clang
powerpc64             randconfig-003-20240225   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240225   gcc  
riscv                 randconfig-002-20240225   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240225   gcc  
s390                  randconfig-002-20240225   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240225   gcc  
sh                    randconfig-002-20240225   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240225   gcc  
sparc64               randconfig-002-20240225   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240225   clang
um                    randconfig-002-20240225   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240225   gcc  
xtensa                randconfig-002-20240225   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

