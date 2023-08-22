Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC37845AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjHVPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjHVPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BCECD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692718552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZe7DuaTtdrETFEBM5nNaFayzw83oL0InDYv06v7uVQ=;
        b=EvLCzH8IrA+2cUmmljC98DmNrZo5eoVclDyuEYJOcq+0AD+Ld5v4FtFuc+AYP5nHZnEIov
        Z17te+jC0eTzDyid51rX9Q2Ib6ciFXymi0JnvGtdti96wpl7oJsNAQCR4dpnxJEbHAbbkv
        lfbcjF5l8wepQba2kwr+8Sd1QX9sPkY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MaGYzRvrPV2F8bi4ZvQ4Iw-1; Tue, 22 Aug 2023 11:35:51 -0400
X-MC-Unique: MaGYzRvrPV2F8bi4ZvQ4Iw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99df23d6926so326616666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718550; x=1693323350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZe7DuaTtdrETFEBM5nNaFayzw83oL0InDYv06v7uVQ=;
        b=LNYuLvcpr8wstk3w0n0Av0bEv0BQxAQyMzy7I6Rn02DOyxIZOol5oRrZzlHq9HILhV
         ij3EsLGWm39258rVANUKBVF1YttSvPV2yIReWAUeXavZoMN88JCeLr+bFqX2n3yNQtFN
         TqPm03scV/w/4SJnhloHQCvR9M+69k9TbVfhpgVIQz3orrGNgQA462fim6GDtEgfs/pk
         /KJKdfqaiKuVcWUHUurX4UpFeERzlKuyIIUNVAA7wKahTcFr8cm6jiVgj0xXpynnENwY
         hFsIVwSu2a4iSVHBh8kzXshJ62kwCtnvgpJfdhs/aSesTJiD425HnKCDTK8USudD0TiS
         GVfA==
X-Gm-Message-State: AOJu0YxYaUc+yztSPtVZGKy8+yzek5r3ZVgsq5xwH0y78VXltCEjXDaN
        dYZXb3VRVhBavDuIrg1vEhbXhGS3TWgmw0jMPHEUl1z99+WmGdqWNPX/aPYraSu43yjaAOSSejC
        d/9jlO2qHT++CKZ4puI4sw/yV
X-Received: by 2002:a17:907:1dc9:b0:9a1:c221:4661 with SMTP id og9-20020a1709071dc900b009a1c2214661mr1220657ejc.0.1692718550228;
        Tue, 22 Aug 2023 08:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRgcF02nNjZKzucmCVXknGyM5G3Y5R7QDLT0lhMt9btD4gY7g0KZyEJbL9ulxU4Ys1u/2i+A==
X-Received: by 2002:a17:907:1dc9:b0:9a1:c221:4661 with SMTP id og9-20020a1709071dc900b009a1c2214661mr1220637ejc.0.1692718549818;
        Tue, 22 Aug 2023 08:35:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id lc14-20020a170906dfee00b009a18b1d77eesm5222859ejc.177.2023.08.22.08.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:35:49 -0700 (PDT)
Message-ID: <1916efdb-e509-9e6d-9775-fb2eb7b9fee7@redhat.com>
Date:   Tue, 22 Aug 2023 17:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] mlxbf-bootctl: Support sysfs entries for MFG fields
Content-Language: en-US
To:     David Thompson <davthompson@nvidia.com>, markgross@kernel.org,
        vadimp@nvidia.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        shravankr@nvidia.com
References: <20230821183939.3229-1-davthompson@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230821183939.3229-1-davthompson@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/23 20:39, David Thompson wrote:
> This patch extends the mlxbf-bootctl driver's sysfs entries
> to support read and write access for the manufacturing (MFG)
> fields in the board-level EEPROM.  The MFG fields are set
> once during the board manufacturing phase, and then the MFG
> fields are write-protected.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v2->v3
>    - Updated Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> v1->v2
>    - use ETH_ALEN instead of custom #define (MLNX_MFG_OOB_MAC_LEN)
>    - changes to xxx_show() methods:
>       a) removed unnecessary memcpy() calls, instead use data from xxx_data[]
>       b) increment size of xxx_data[] by 1 to ensure null termination
>    - changed "byte[]" variable to unsigned int in oob_mac_store()
>    - use sysfs_format_mac() in oob_mac_show()
> ---
>  .../testing/sysfs-platform-mellanox-bootctl   |  68 +++
>  drivers/platform/mellanox/mlxbf-bootctl.c     | 438 ++++++++++++++++++
>  drivers/platform/mellanox/mlxbf-bootctl.h     |   8 +
>  3 files changed, 514 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> index 4c5c02d8f870..33cabddc5c34 100644
> --- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -84,3 +84,71 @@ Description:
>  		The file used to write BlueField boot log with the format
>                  "[INFO|WARN|ERR|ASSERT ]<msg>". Log level 'INFO' is used by
>                  default if not specified.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/oob_mac
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "oob_mac" sysfs attribute holds the MAC address for
> +                the out-of-band 1Gbps Ethernet port.  This MAC address is
> +                provided on a board-level label.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/opn
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "opn" sysfs attribute holds the board's part number.
> +                This value is provided on a board-level label.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/sku
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "sku" sysfs attribute holds the board's SKU number.
> +                This value is provided on a board-level label.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/modl
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "modl" sysfs attribute holds the board's model number.
> +                This value is provided on a board-level label.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/sn
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "sn" sysfs attribute holds the board's serial number.
> +                This value is provided on a board-level label.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/uuid
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "uuid" sysfs attribute holds the board's UUID.
> +                This value is provided by the manufacturing team.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/rev
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "rev" sysfs attribute holds the board's revision.
> +                This value is provided on a board-level label.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/mfg_lock
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	"David Thompson <davthompson@nvidia.com>"
> +Description:
> +		The "mfg_lock" sysfs attribute is write-only.
> +                A succesful write to this attribute will latch the
> +                board-level attributes into EEPROM, making them read-only.
> +
> +
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 0bf29eee1e70..4ee7bb431b7c 100644
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
> @@ -81,6 +82,49 @@ static const char * const mlxbf_rsh_log_level[] = {
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
> +	((ETH_ALEN * 2) + (ETH_ALEN - 1))
>  
>  /* ARM SMC call which is atomic and no need for lock. */
>  static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
> @@ -454,6 +498,384 @@ static ssize_t os_up_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t oob_mac_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
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
> +	return sysfs_format_mac(buf, mac_byte_ptr, ETH_ALEN);
> +}
> +
> +static ssize_t oob_mac_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	unsigned int byte[MLNX_MFG_OOB_MAC_FORMAT_LEN] = { 0 };
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
> +	if (len != ETH_ALEN)
> +		return -EINVAL;
> +
> +	mac_byte_ptr = (u8 *)&mac_addr;
> +
> +	for (byte_idx = 0; byte_idx < ETH_ALEN; byte_idx++)
> +		mac_byte_ptr[byte_idx] = (u8)byte[byte_idx];
> +
> +	mutex_lock(&mfg_ops_lock);
> +	arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC,
> +		      ETH_ALEN, mac_addr, 0, 0, 0, 0, &res);
> +	mutex_unlock(&mfg_ops_lock);
> +
> +	return res.a0 ? -EPERM : count;
> +}
> +
> +static ssize_t opn_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	u64 opn_data[MLNX_MFG_VAL_QWORD_CNT(OPN) + 1] = { 0 };
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
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", (char *)opn_data);
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
> +	u64 sku_data[MLNX_MFG_VAL_QWORD_CNT(SKU) + 1] = { 0 };
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
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", (char *)sku_data);
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
> +	u64 modl_data[MLNX_MFG_VAL_QWORD_CNT(MODL) + 1] = { 0 };
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
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", (char *)modl_data);
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
> +	u64 sn_data[MLNX_MFG_VAL_QWORD_CNT(SN) + 1] = { 0 };
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
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", (char *)sn_data);
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
> +	u64 uuid_data[MLNX_MFG_VAL_QWORD_CNT(UUID) + 1] = { 0 };
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
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", (char *)uuid_data);
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
> +	u64 rev_data[MLNX_MFG_VAL_QWORD_CNT(REV) + 1] = { 0 };
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
> +
> +	return snprintf(buf, PAGE_SIZE, "%s", (char *)rev_data);
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
> @@ -463,6 +885,14 @@ static DEVICE_ATTR_WO(fw_reset);
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
> @@ -474,6 +904,14 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
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

