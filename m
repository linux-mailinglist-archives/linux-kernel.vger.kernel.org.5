Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5A77F238
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347824AbjHQIcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348907AbjHQIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:32:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E87273C;
        Thu, 17 Aug 2023 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692261157; x=1723797157;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vmK2h68WjTJnIuo5vPQTovXCPE94MFgp1M+n5FnOZSA=;
  b=FuNWlLDttAO6dojIOHI99r6FWEcsAmxrUgdxJ882vgNA2Y81fUgQ+fZ9
   owdT9fKEesXVd075Ni1CLGA4MG3Id+EEWP9y1LCf8+uPEUnLLPHm+S+RC
   UfcchHJm8I4vaKlAHQ7Axa6rfQ5GwOkGxBM8Bs2rxHQ1gkJ8Qt8cb0ios
   3zcY2nUvmyDrR4neQDOka6JkfLgcqkuTx1yhWseyg9Lub/xIe507kLwNT
   rJ8Tq1Ztx9ukn3r73rzinzArl2ox2y6/dzXKWb2awFHkskZUOFgPdHOzm
   utjBO0S+vwpn1r4y2eZ2FQtl0Duo74yAnbUy8HIH7q65E2AsHz7/Q8OsQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436653700"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="436653700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="858151003"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="858151003"
Received: from lababeix-mobl1.ger.corp.intel.com ([10.251.212.52])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:30:52 -0700
Date:   Thu, 17 Aug 2023 11:30:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     David Thompson <davthompson@nvidia.com>
cc:     hdegoede@redhat.com, markgross@kernel.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        shravankr@nvidia.com
Subject: Re: [PATCH v1] mlxbf-bootctl: Support sysfs entries for MFG fields
In-Reply-To: <20230815213832.16698-1-davthompson@nvidia.com>
Message-ID: <e874042-d78-b73-5a49-8da9285cb3c1@linux.intel.com>
References: <20230815213832.16698-1-davthompson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023, David Thompson wrote:

> This patch extends the mlxbf-bootctl driver's sysfs entries
> to support read and write access for the manufacturing (MFG)
> fields in the board-level EEPROM.  The MFG fields are set
> once during the board manufacturing phase, and then the MFG
> fields are write-protected.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-bootctl.c | 456 ++++++++++++++++++++++
>  drivers/platform/mellanox/mlxbf-bootctl.h |   8 +
>  2 files changed, 464 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 0bf29eee1e70..bf6ce37e3dbb 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -11,6 +11,7 @@
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/delay.h>
> +#include <linux/if_ether.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -81,6 +82,50 @@ static const char * const mlxbf_rsh_log_level[] = {
>  
>  static DEFINE_MUTEX(icm_ops_lock);
>  static DEFINE_MUTEX(os_up_lock);
> +static DEFINE_MUTEX(mfg_ops_lock);
> +
> +/*
> + * Objects are stored within the MFG partition per type.
> + * Type 0 is not supported.
> + */
> +enum {
> +	MLNX_MFG_TYPE_OOB_MAC = 1,
> +	MLNX_MFG_TYPE_OPN_0,
> +	MLNX_MFG_TYPE_OPN_1,
> +	MLNX_MFG_TYPE_OPN_2,
> +	MLNX_MFG_TYPE_SKU_0,
> +	MLNX_MFG_TYPE_SKU_1,
> +	MLNX_MFG_TYPE_SKU_2,
> +	MLNX_MFG_TYPE_MODL_0,
> +	MLNX_MFG_TYPE_MODL_1,
> +	MLNX_MFG_TYPE_MODL_2,
> +	MLNX_MFG_TYPE_SN_0,
> +	MLNX_MFG_TYPE_SN_1,
> +	MLNX_MFG_TYPE_SN_2,
> +	MLNX_MFG_TYPE_UUID_0,
> +	MLNX_MFG_TYPE_UUID_1,
> +	MLNX_MFG_TYPE_UUID_2,
> +	MLNX_MFG_TYPE_UUID_3,
> +	MLNX_MFG_TYPE_UUID_4,
> +	MLNX_MFG_TYPE_REV,
> +};
> +
> +#define MLNX_MFG_OOB_MAC_LEN         ETH_ALEN

Why add this own define and not use ETH_ALEN directly?

> +#define MLNX_MFG_OPN_VAL_LEN         24
> +#define MLNX_MFG_SKU_VAL_LEN         24
> +#define MLNX_MFG_MODL_VAL_LEN        24
> +#define MLNX_MFG_SN_VAL_LEN          24
> +#define MLNX_MFG_UUID_VAL_LEN        40
> +#define MLNX_MFG_REV_VAL_LEN         8
> +#define MLNX_MFG_VAL_QWORD_CNT(type) \
> +	(MLNX_MFG_##type##_VAL_LEN / sizeof(u64))
> +
> +/*
> + * The MAC address consists of 6 bytes (2 digits each) separated by ':'.
> + * The expected format is: "XX:XX:XX:XX:XX:XX"
> + */
> +#define MLNX_MFG_OOB_MAC_FORMAT_LEN \
> +	((MLNX_MFG_OOB_MAC_LEN * 2) + (MLNX_MFG_OOB_MAC_LEN - 1))
>  
>  /* ARM SMC call which is atomic and no need for lock. */
>  static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
> @@ -454,6 +499,401 @@ static ssize_t os_up_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t oob_mac_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	char mac_str[MLNX_MFG_OOB_MAC_FORMAT_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	u8 *mac_byte_ptr;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC, 0, 0, 0,
> +		      0, 0, 0, &res);
> +	mutex_unlock(&mfg_ops_lock);
> +	if (res.a0)
> +		return -EPERM;
> +
> +	mac_byte_ptr = (u8 *)&res.a1;
> +
> +	sprintf(mac_str, "%02X:%02X:%02X:%02X:%02X:%02X",
> +		mac_byte_ptr[0], mac_byte_ptr[1], mac_byte_ptr[2],
> +		mac_byte_ptr[3], mac_byte_ptr[4], mac_byte_ptr[5]);

Always use snprintf() with sizeof(). Please check 
Documentation/core-api/printk-formats.rst for MAC address format 
specifier.

> +	return snprintf(buf, PAGE_SIZE, "%s", mac_str);

Can't you use sysfs_format_mac()?

> +}
> +
> +static ssize_t oob_mac_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int byte[MLNX_MFG_OOB_MAC_FORMAT_LEN] = { 0 };
> +	struct arm_smccc_res res;
> +	int byte_idx, len;
> +	u64 mac_addr = 0;
> +	u8 *mac_byte_ptr;
> +
> +	if ((count - 1) != MLNX_MFG_OOB_MAC_FORMAT_LEN)
> +		return -EINVAL;
> +
> +	len = sscanf(buf, "%02x:%02x:%02x:%02x:%02x:%02x",
> +		     &byte[0], &byte[1], &byte[2],
> +		     &byte[3], &byte[4], &byte[5]);

Why is byte int, unsigned int at minimum.

> +	if (len != MLNX_MFG_OOB_MAC_LEN)
> +		return -EINVAL;
> +
> +	mac_byte_ptr = (u8 *)&mac_addr;
> +
> +	for (byte_idx = 0; byte_idx < MLNX_MFG_OOB_MAC_LEN; byte_idx++)
> +		mac_byte_ptr[byte_idx] = (u8)byte[byte_idx];
> +
> +	mutex_lock(&mfg_ops_lock);
> +	arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC,
> +		      MLNX_MFG_OOB_MAC_LEN, mac_addr, 0, 0, 0, 0, &res);
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return res.a0 ? -EPERM : count;
> +}
> +
> +static ssize_t opn_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	u64 opn_data[MLNX_MFG_VAL_QWORD_CNT(OPN)] = { 0 };
> +	char opn[MLNX_MFG_OPN_VAL_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(OPN); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
> +			      MLNX_MFG_TYPE_OPN_0 + word,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +		opn_data[word] = res.a1;
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +	memcpy(opn, opn_data, MLNX_MFG_OPN_VAL_LEN);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", opn);
> +}
> +
> +static ssize_t opn_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	u64 opn[MLNX_MFG_VAL_QWORD_CNT(OPN)] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	if (count > MLNX_MFG_OPN_VAL_LEN)
> +		return -EINVAL;
> +
> +	memcpy(opn, buf, count);
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(OPN); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
> +			      MLNX_MFG_TYPE_OPN_0 + word,
> +			      sizeof(u64), opn[word], 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t sku_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	u64 sku_data[MLNX_MFG_VAL_QWORD_CNT(SKU)] = { 0 };
> +	char sku[MLNX_MFG_SKU_VAL_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SKU); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
> +			      MLNX_MFG_TYPE_SKU_0 + word,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +		sku_data[word] = res.a1;
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +	memcpy(sku, sku_data, MLNX_MFG_SKU_VAL_LEN);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", sku);
> +}
> +
> +static ssize_t sku_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	u64 sku[MLNX_MFG_VAL_QWORD_CNT(SKU)] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	if (count > MLNX_MFG_SKU_VAL_LEN)
> +		return -EINVAL;
> +
> +	memcpy(sku, buf, count);
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SKU); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
> +			      MLNX_MFG_TYPE_SKU_0 + word,
> +			      sizeof(u64), sku[word], 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t modl_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	u64 modl_data[MLNX_MFG_VAL_QWORD_CNT(MODL)] = { 0 };
> +	char modl[MLNX_MFG_MODL_VAL_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(MODL); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
> +			      MLNX_MFG_TYPE_MODL_0 + word,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +		modl_data[word] = res.a1;
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +	memcpy(modl, modl_data, MLNX_MFG_MODL_VAL_LEN);

Why are these memcpy()s needed?

> +	return snprintf(buf, PAGE_SIZE, "%s", modl);
> +}
> +
> +static ssize_t modl_store(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	u64 modl[MLNX_MFG_VAL_QWORD_CNT(MODL)] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	if (count > MLNX_MFG_MODL_VAL_LEN)
> +		return -EINVAL;
> +
> +	memcpy(modl, buf, count);
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(MODL); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
> +			      MLNX_MFG_TYPE_MODL_0 + word,
> +			      sizeof(u64), modl[word], 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t sn_show(struct device *dev,
> +		       struct device_attribute *attr, char *buf)
> +{
> +	u64 sn_data[MLNX_MFG_VAL_QWORD_CNT(SN)] = { 0 };
> +	char sn[MLNX_MFG_SN_VAL_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SN); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
> +			      MLNX_MFG_TYPE_SN_0 + word,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +		sn_data[word] = res.a1;
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +	memcpy(sn, sn_data, MLNX_MFG_SN_VAL_LEN);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", sn);
> +}
> +
> +static ssize_t sn_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	u64 sn[MLNX_MFG_VAL_QWORD_CNT(SN)] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	if (count > MLNX_MFG_SN_VAL_LEN)
> +		return -EINVAL;
> +
> +	memcpy(sn, buf, count);
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SN); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
> +			      MLNX_MFG_TYPE_SN_0 + word,
> +			      sizeof(u64), sn[word], 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t uuid_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	u64 uuid_data[MLNX_MFG_VAL_QWORD_CNT(UUID)] = { 0 };
> +	char uuid[MLNX_MFG_UUID_VAL_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(UUID); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
> +			      MLNX_MFG_TYPE_UUID_0 + word,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +		uuid_data[word] = res.a1;
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +	memcpy(uuid, uuid_data, MLNX_MFG_UUID_VAL_LEN);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", uuid);
> +}
> +
> +static ssize_t uuid_store(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	u64 uuid[MLNX_MFG_VAL_QWORD_CNT(UUID)] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	if (count > MLNX_MFG_UUID_VAL_LEN)
> +		return -EINVAL;
> +
> +	memcpy(uuid, buf, count);
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(UUID); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
> +			      MLNX_MFG_TYPE_UUID_0 + word,
> +			      sizeof(u64), uuid[word], 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t rev_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	u64 rev_data[MLNX_MFG_VAL_QWORD_CNT(REV)] = { 0 };
> +	char rev[MLNX_MFG_REV_VAL_LEN + 1] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(REV); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
> +			      MLNX_MFG_TYPE_REV + word,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +		rev_data[word] = res.a1;
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +	memcpy(rev, rev_data, MLNX_MFG_REV_VAL_LEN);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", rev);
> +}
> +
> +static ssize_t rev_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	u64 rev[MLNX_MFG_VAL_QWORD_CNT(REV)] = { 0 };
> +	struct arm_smccc_res res;
> +	int word;
> +
> +	if (count > MLNX_MFG_REV_VAL_LEN)
> +		return -EINVAL;
> +
> +	memcpy(rev, buf, count);
> +
> +	mutex_lock(&mfg_ops_lock);
> +	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(REV); word++) {
> +		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
> +			      MLNX_MFG_TYPE_REV + word,
> +			      sizeof(u64), rev[word], 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			mutex_unlock(&mfg_ops_lock);
> +			return -EPERM;
> +		}
> +	}
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t mfg_lock_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long val;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&mfg_ops_lock);
> +	arm_smccc_smc(MLXBF_BOOTCTL_LOCK_MFG_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(post_reset_wdog);
>  static DEVICE_ATTR_RW(reset_action);
>  static DEVICE_ATTR_RW(second_reset_action);
> @@ -463,6 +903,14 @@ static DEVICE_ATTR_WO(fw_reset);
>  static DEVICE_ATTR_WO(rsh_log);
>  static DEVICE_ATTR_RW(large_icm);
>  static DEVICE_ATTR_WO(os_up);
> +static DEVICE_ATTR_RW(oob_mac);
> +static DEVICE_ATTR_RW(opn);
> +static DEVICE_ATTR_RW(sku);
> +static DEVICE_ATTR_RW(modl);
> +static DEVICE_ATTR_RW(sn);
> +static DEVICE_ATTR_RW(uuid);
> +static DEVICE_ATTR_RW(rev);
> +static DEVICE_ATTR_WO(mfg_lock);
>  
>  static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_post_reset_wdog.attr,
> @@ -474,6 +922,14 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_rsh_log.attr,
>  	&dev_attr_large_icm.attr,
>  	&dev_attr_os_up.attr,
> +	&dev_attr_oob_mac.attr,
> +	&dev_attr_opn.attr,
> +	&dev_attr_sku.attr,
> +	&dev_attr_modl.attr,
> +	&dev_attr_sn.attr,
> +	&dev_attr_uuid.attr,
> +	&dev_attr_rev.attr,
> +	&dev_attr_mfg_lock.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
> index 613963d448f2..1299750a8661 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.h
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.h
> @@ -81,6 +81,14 @@
>   */
>  #define MLXBF_BOOTCTL_FW_RESET  0x8200000D
>  
> +/*
> + * SMC function IDs to set, get and lock the manufacturing information
> + * stored within the eeprom.
> + */
> +#define MLXBF_BOOTCTL_SET_MFG_INFO    0x8200000E
> +#define MLXBF_BOOTCTL_GET_MFG_INFO    0x8200000F
> +#define MLXBF_BOOTCTL_LOCK_MFG_INFO   0x82000011
> +
>  /*
>   * SMC function IDs to set and get the large ICM carveout size
>   * stored in the eeprom.
> 

-- 
 i.

