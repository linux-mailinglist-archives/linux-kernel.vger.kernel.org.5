Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7F75A2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGSXFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGSXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A651FFD;
        Wed, 19 Jul 2023 16:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9426E61867;
        Wed, 19 Jul 2023 23:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F77C433C7;
        Wed, 19 Jul 2023 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689807900;
        bh=l0yEHwStzvqj4s8/Evlo/5S98mMNxyw9kZlSzUXEqt0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=FA2zDK+pACfLUE2TNofB0iXqUJ45pD+BlUplaJfHl5b2tE/mL7SXBvdARwRTzZC1A
         zjKMQZ033mfbLw76n1pspdK/QF7egRa3Bjam0fziAZjjH96/mHBvewvAq5YI6qJvSn
         NGOIXub1bjdNqv12uN0qeZvehqnKQRJivPusWE0EkWR4P1zhAUHK6BlHMqY2tjwdyA
         rdyep9R0MM4JLtTSItI0sqB7Md7JfcRVYwOPfI1AXIBC7TxPKDhPkHHYLP1IgQDavz
         V/UJPUSNa3lzMkE2/7HwD9M5lZjUfDa5dryf5mZcGYWxHN0a1RiiTxlosdz/oLVvRx
         uPFLxTFUAV8+A==
Message-ID: <a658d0c6-cf34-9835-1e69-76427b8bce69@kernel.org>
Date:   Thu, 20 Jul 2023 08:04:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 6/6] block: implement NVMEM provider
To:     Daniel Golle <daniel@makrotopia.org>, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1689802933.git.daniel@makrotopia.org>
 <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 07:04, Daniel Golle wrote:
> On embedded devices using an eMMC it is common that one or more partitions
> on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
> data. Allow referencing the partition in device tree for the kernel and
> Wi-Fi drivers accessing it via the NVMEM layer.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  block/Kconfig           |   8 ++
>  block/Makefile          |   1 +
>  block/blk-nvmem.c       | 187 ++++++++++++++++++++++++++++++++++++++++
>  block/blk.h             |  13 +++
>  block/genhd.c           |   2 +
>  block/partitions/core.c |   2 +
>  6 files changed, 213 insertions(+)
>  create mode 100644 block/blk-nvmem.c
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459fe04..185573877964d 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -218,6 +218,14 @@ config BLK_MQ_VIRTIO
>  config BLK_PM
>  	def_bool PM
>  
> +config BLK_NVMEM
> +	bool "Block device NVMEM provider"
> +	depends on OF
> +	help
> +	  Allow block devices (or partitions) to act as NVMEM prodivers,
> +	  typically using if an eMMC is used to store MAC addresses or Wi-Fi

Odd grammar... May be "typically used with eMMC to store ..."

> +	  calibration data on embedded devices.
> +
>  # do not use in new code
>  config BLOCK_HOLDER_DEPRECATED
>  	bool
> diff --git a/block/Makefile b/block/Makefile
> index 46ada9dc8bbfe..03c0bfa8642df 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
>  obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
>  obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
>  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
> +obj-$(CONFIG_BLK_NVMEM)		+= blk-nvmem.o
>  obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
>  obj-$(CONFIG_BLK_PM)		+= blk-pm.o
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
> diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> new file mode 100644
> index 0000000000000..8238511049f56
> --- /dev/null
> +++ b/block/blk-nvmem.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * block device NVMEM provider
> + *
> + * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
> + *
> + * Useful on devices using a partition on an eMMC for MAC addresses or
> + * Wi-Fi calibration EEPROM data.
> + */
> +
> +#include "blk.h"
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/pagemap.h>
> +#include <linux/property.h>
> +
> +/* List of all NVMEM devices */
> +static LIST_HEAD(nvmem_devices);
> +static DEFINE_MUTEX(devices_mutex);
> +
> +struct blk_nvmem {
> +	struct nvmem_device *nvmem;
> +	struct block_device *bdev;
> +	struct list_head list;
> +};
> +
> +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> +			      void *val, size_t bytes)
> +{
> +	pgoff_t f_index = from >> PAGE_SHIFT;
> +	struct address_space *mapping;
> +	struct blk_nvmem *bnv = priv;

Why not have bnv passed as argument directly ?

> +	size_t bytes_left = bytes;
> +	struct folio *folio;
> +	unsigned long offs, to_read;
> +	void *p;
> +
> +	if (!bnv->bdev)
> +		return -ENODEV;
> +
> +	offs = from & ((1 << PAGE_SHIFT) - 1);

offs = from & PAGE_MASK;

from being an int is really odd though.

> +	mapping = bnv->bdev->bd_inode->i_mapping;
> +
> +	while (bytes_left) {
> +		folio = read_mapping_folio(mapping, f_index++, NULL);
> +		if (IS_ERR(folio))
> +			return PTR_ERR(folio);
> +
> +		to_read = min_t(unsigned long, bytes_left, PAGE_SIZE - offs);
> +		p = folio_address(folio) + offset_in_folio(folio, offs);
> +		memcpy(val, p, to_read);
> +		offs = 0;
> +		bytes_left -= to_read;
> +		val += to_read;
> +		folio_put(folio);
> +	}
> +
> +	return bytes_left == 0 ? 0 : -EIO;

How can bytes_left be 0 here given the above loop with no break ?

> +}
> +
> +void blk_register_nvmem(struct block_device *bdev)
> +{
> +	struct fwnode_handle *fw_parts = NULL, *fw_part_c, *fw_part = NULL;
> +	struct nvmem_config config = {};
> +	const char *partname, *uuid;
> +	struct device *dev, *p0dev;
> +	struct blk_nvmem *bnv;
> +	u32 reg;
> +
> +	/*
> +	 * skip devices which set GENHD_FL_NO_NVMEM
> +	 *
> +	 * This flag is used for mtdblock and ubiblock devices because
> +	 * both, MTD and UBI already implement their own NVMEM provider.
> +	 * To avoid registering multiple NVMEM providers for the same
> +	 * device node, skip the block NVMEM provider.
> +	 */
> +	if (bdev->bd_disk->flags & GENHD_FL_NO_NVMEM)
> +		return;
> +
> +	/* skip too large devices */

Why ? Is that defined in some standards somewhere ?

> +	if (bdev_nr_bytes(bdev) > INT_MAX)
> +		return;
> +
> +	dev = &bdev->bd_device;
> +	if (!bdev_is_partition(bdev)) {
> +		fw_part = dev->fwnode;
> +
> +		if (!fw_part && dev->parent)
> +			fw_part = dev->parent->fwnode;
> +
> +		goto no_parts;
> +	}
> +
> +	p0dev = &bdev->bd_disk->part0->bd_device;
> +	fw_parts = device_get_named_child_node(p0dev, "partitions");
> +	if (!fw_parts)
> +		fw_parts = device_get_named_child_node(p0dev->parent, "partitions");
> +
> +	if (!fw_parts)
> +		return;
> +
> +	fwnode_for_each_child_node(fw_parts, fw_part_c) {
> +		if (!fwnode_property_read_string(fw_part_c, "uuid", &uuid) &&
> +		    (!bdev->bd_meta_info || strncmp(uuid,
> +						    bdev->bd_meta_info->uuid,
> +						    PARTITION_META_INFO_UUIDLTH)))
> +			continue;
> +
> +		if (!fwnode_property_read_string(fw_part_c, "partname", &partname) &&
> +		    (!bdev->bd_meta_info || strncmp(partname,
> +						    bdev->bd_meta_info->volname,
> +						    PARTITION_META_INFO_VOLNAMELTH)))
> +			continue;
> +
> +		/*
> +		 * partition addresses (reg) in device tree greater than
> +		 * DISK_MAX_PARTS can be used to match uuid or partname only
> +		 */
> +		if (!fwnode_property_read_u32(fw_part_c, "reg", &reg) &&
> +		    reg < DISK_MAX_PARTS && bdev->bd_partno != reg)
> +			continue;
> +
> +		fw_part = fw_part_c;
> +		break;
> +	}
> +
> +no_parts:
> +	if (!fwnode_device_is_compatible(fw_part, "nvmem-cells"))
> +		return;
> +
> +	bnv = kzalloc(sizeof(struct blk_nvmem), GFP_KERNEL);
> +	if (!bnv)
> +		return;
> +
> +	config.id = NVMEM_DEVID_NONE;
> +	config.dev = &bdev->bd_device;
> +	config.name = dev_name(&bdev->bd_device);
> +	config.owner = THIS_MODULE;
> +	config.priv = bnv;
> +	config.reg_read = blk_nvmem_reg_read;
> +	config.size = bdev_nr_bytes(bdev);
> +	config.word_size = 1;
> +	config.stride = 1;
> +	config.read_only = true;
> +	config.root_only = true;
> +	config.ignore_wp = true;
> +	config.of_node = to_of_node(fw_part);
> +
> +	bnv->bdev = bdev;
> +	bnv->nvmem = nvmem_register(&config);
> +	if (IS_ERR(bnv->nvmem)) {
> +		/* Just ignore if there is no NVMEM support in the kernel */

If there is not, why would this function even be called ?

> +		if (PTR_ERR(bnv->nvmem) != -EOPNOTSUPP)
> +			dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
> +				      "Failed to register NVMEM device\n");
> +
> +		kfree(bnv);
> +		return;
> +	}
> +
> +	mutex_lock(&devices_mutex);
> +	list_add_tail(&bnv->list, &nvmem_devices);
> +	mutex_unlock(&devices_mutex);
> +}
> +
> +void blk_unregister_nvmem(struct block_device *bdev)
> +{
> +	struct blk_nvmem *bnv_c, *bnv = NULL;
> +
> +	mutex_lock(&devices_mutex);
> +	list_for_each_entry(bnv_c, &nvmem_devices, list)
> +		if (bnv_c->bdev == bdev) {
> +			bnv = bnv_c;
> +			break;
> +		}

Curly brackets for list_for_each_entry() {} would be nice, even though they are
not strictly necessary in this case.

> +
> +	if (!bnv) {
> +		mutex_unlock(&devices_mutex);
> +		return;
> +	}
> +
> +	list_del(&bnv->list);
> +	mutex_unlock(&devices_mutex);
> +	nvmem_unregister(bnv->nvmem);
> +	kfree(bnv);
> +}
> diff --git a/block/blk.h b/block/blk.h
> index 686712e138352..7423d0d5494e9 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -515,4 +515,17 @@ static inline int req_ref_read(struct request *req)
>  	return atomic_read(&req->ref);
>  }
>  
> +#ifdef CONFIG_BLK_NVMEM
> +void blk_register_nvmem(struct block_device *bdev);
> +void blk_unregister_nvmem(struct block_device *bdev);
> +#else
> +static inline void blk_register_nvmem(struct block_device *bdev)
> +{
> +}

These could go at the end of the static inline line.

> +
> +static inline void blk_unregister_nvmem(struct block_device *bdev)
> +{
> +}
> +#endif
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/block/genhd.c b/block/genhd.c
> index 3d287b32d50df..b306e0f407bb2 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -527,6 +527,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	disk_update_readahead(disk);
>  	disk_add_events(disk);
>  	set_bit(GD_ADDED, &disk->state);
> +	blk_register_nvmem(disk->part0);
>  	return 0;
>  
>  out_unregister_bdi:
> @@ -569,6 +570,7 @@ static void blk_report_disk_dead(struct gendisk *disk)
>  		if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
>  			bdev->bd_holder_ops->mark_dead(bdev);
>  		mutex_unlock(&bdev->bd_holder_lock);
> +		blk_unregister_nvmem(bdev);
>  
>  		put_device(&bdev->bd_device);
>  		rcu_read_lock();
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 13a7341299a91..68bd655f5e68e 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -404,6 +404,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	/* suppress uevent if the disk suppresses it */
>  	if (!dev_get_uevent_suppress(ddev))
>  		kobject_uevent(&pdev->kobj, KOBJ_ADD);
> +
> +	blk_register_nvmem(bdev);
>  	return bdev;
>  
>  out_del:

-- 
Damien Le Moal
Western Digital Research

