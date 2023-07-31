Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9E76946C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjGaLPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGaLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:15:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92EE4A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:15:44 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDwbr5Fq5zVjt0;
        Mon, 31 Jul 2023 19:14:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:15:41 +0800
Subject: Re: [PATCH V2 1/5] ubi: Use the fault injection framework to enhance
 the fault injection capability
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
 <20230718085119.3885747-2-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6a63f026-d12e-1514-f682-f44af40ee6d2@huawei.com>
Date:   Mon, 31 Jul 2023 19:15:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230718085119.3885747-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/18 16:51, ZhaoLong Wang Ð´µÀ:
> To make debug parameters configurable at run time, use the
> fault injection framework to reconstruct the debugfs interface,
> and retain the legacy fault injection interface.
> 
> Now, the file emulate_failures and fault_attr files control whether
> to enable fault emmulation.
> 
> The file emulate_failures receives a mask that controls type and
> process of fault injection. Generally, for ease of use, you can
> directly enter a mask with all 1s.
> 
> echo 0xffff > /sys/kernel/debug/ubi/ubi0/emulate_failures
> 
> And you need to configure other fault-injection capabilities for
> testing purpose:
> 
> echo 100 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/probability
> echo 15 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/space
> echo 2 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/verbose
> echo -1 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/times
> 
> The CONFIG_MTD_UBI_FAULT_INJECTION to enable the Fault Injection is
> added to kconfig.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
> V2:
>    - Retain the original interface.
>    - When both the new and original interfaces are enabled, the original
>      interface takes precedence over the new interface.
>    - Adjusted the order of masks to be compatible with original interfaces.
> 
>   drivers/mtd/ubi/Kconfig |   9 +++
>   drivers/mtd/ubi/debug.c |  68 +++++++++++++++++--
>   drivers/mtd/ubi/debug.h | 142 +++++++++++++++++++++++++++++++++-------
>   drivers/mtd/ubi/io.c    |  10 ++-
>   drivers/mtd/ubi/ubi.h   |  15 ++---
>   5 files changed, 202 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
> index 2ed77b7b3fcb..138fae7e8f96 100644
> --- a/drivers/mtd/ubi/Kconfig
> +++ b/drivers/mtd/ubi/Kconfig
> @@ -104,4 +104,13 @@ config MTD_UBI_BLOCK
>   
>   	   If in doubt, say "N".
>   
> +config MTD_UBI_FAULT_INJECTION
> +	bool "Fault injection capability of UBI device"
> +	default n
> +	depends on FAULT_INJECTION_DEBUG_FS
> +	help
> +	   this option enable fault-injection support for UBI devices for
> +	   testing purposes.
> +
> +	   If in doubt, say "N".
>   endif # MTD_UBI
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index 27168f511d6d..9ca584da32c6 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -10,7 +10,23 @@
>   #include <linux/uaccess.h>
>   #include <linux/module.h>
>   #include <linux/seq_file.h>
> +#include <linux/fault-inject.h>
>   
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +static DECLARE_FAULT_ATTR(fault_bitflips_attr);
> +static DECLARE_FAULT_ATTR(fault_io_failures_attr);
> +static DECLARE_FAULT_ATTR(fault_power_cut_attr);
> +
> +#define FAIL_ACTION(name, fault_attr)			\
> +bool should_fail_##name(void)				\
> +{							\
> +	return should_fail(&fault_attr, 1);		\
> +}
> +
> +FAIL_ACTION(bitflips,		fault_bitflips_attr)
> +FAIL_ACTION(io_failures,	fault_io_failures_attr)
> +FAIL_ACTION(power_cut,		fault_power_cut_attr)
> +#endif
>   
>   /**
>    * ubi_dump_flash - dump a region of flash.
> @@ -212,6 +228,31 @@ void ubi_dump_mkvol_req(const struct ubi_mkvol_req *req)
>    */
>   static struct dentry *dfs_rootdir;
>   
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +static void dfs_create_fault_entry(struct dentry *parent)
> +{
> +	struct dentry *dir;
> +
> +	dir = debugfs_create_dir("fault_inject", parent);
> +	if (IS_ERR_OR_NULL(dir)) {
> +		int err = dir ? PTR_ERR(dir) : -ENODEV;
> +
> +		pr_warn("UBI error: cannot create \"fault_inject\" debugfs directory, error %d\n",
> +			err);
> +		return;
> +	}
> +
> +	fault_create_debugfs_attr("emulate_bitflips", dir,
> +				  &fault_bitflips_attr);
> +
> +	fault_create_debugfs_attr("emulate_io_failures", dir,
> +				  &fault_io_failures_attr);
> +
> +	fault_create_debugfs_attr("emulate_power_cut", dir,
> +				  &fault_power_cut_attr);
> +}
> +#endif
> +
>   /**
>    * ubi_debugfs_init - create UBI debugfs directory.
>    *
> @@ -232,6 +273,10 @@ int ubi_debugfs_init(void)
>   		return err;
>   	}
>   
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +	dfs_create_fault_entry(dfs_rootdir);
> +#endif
> +
>   	return 0;
>   }
>   
> @@ -272,7 +317,12 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
>   		val = d->emulate_bitflips;
>   	else if (dent == d->dfs_emulate_io_failures)
>   		val = d->emulate_io_failures;
> -	else if (dent == d->dfs_emulate_power_cut) {
> +	else if (dent == d->dfs_emulate_failures) {
> +		snprintf(buf, sizeof(buf), "%u\n", d->emulate_failures);
> +		count = simple_read_from_buffer(user_buf, count, ppos,
> +							buf, strlen(buf));
> +		goto out;
> +	} else if (dent == d->dfs_emulate_power_cut) {
>   		snprintf(buf, sizeof(buf), "%u\n", d->emulate_power_cut);
>   		count = simple_read_from_buffer(user_buf, count, ppos,
>   						buf, strlen(buf));
> @@ -287,8 +337,7 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
>   		count = simple_read_from_buffer(user_buf, count, ppos,
>   						buf, strlen(buf));
>   		goto out;
> -	}
> -	else {
> +	} else {
>   		count = -EINVAL;
>   		goto out;
>   	}
> @@ -330,7 +379,11 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
>   		goto out;
>   	}
>   
> -	if (dent == d->dfs_power_cut_min) {
> +	if (dent == d->dfs_emulate_failures) {
> +		if (kstrtouint(buf, 0, &d->emulate_failures) != 0)
> +			count = -EINVAL;
> +		goto out;
> +	} else if (dent == d->dfs_power_cut_min) {
>   		if (kstrtouint(buf, 0, &d->power_cut_min) != 0)
>   			count = -EINVAL;
>   		goto out;
> @@ -559,6 +612,11 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
>   	debugfs_create_file("detailed_erase_block_info", S_IRUSR, d->dfs_dir,
>   			    (void *)ubi_num, &eraseblk_count_fops);
>   
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +	d->dfs_emulate_failures = debugfs_create_file("emulate_failures", mode,
> +						      d->dfs_dir, (void *)ubi_num,
> +						      &dfs_fops);
> +#endif
>   	return 0;
>   }
>   
> @@ -600,7 +658,5 @@ int ubi_dbg_power_cut(struct ubi_device *ubi, int caller)
>   	if (ubi->dbg.power_cut_counter)
>   		return 0;
>   
> -	ubi_msg(ubi, "XXXXXXXXXXXXXXX emulating a power cut XXXXXXXXXXXXXXXX");
> -	ubi_ro_mode(ubi);
>   	return 1;
>   }
> diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
> index 23676f32b681..fc4234c9a90a 100644
> --- a/drivers/mtd/ubi/debug.h
> +++ b/drivers/mtd/ubi/debug.h
> @@ -53,56 +53,153 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi);
>   void ubi_debugfs_exit_dev(struct ubi_device *ubi);
>   
>   /**
> - * ubi_dbg_is_bgt_disabled - if the background thread is disabled.
> + * The following function is a legacy implementation of UBI fault-injection
> + * hook. When using more powerful fault injection capabilities, the legacy
> + * fault injection interface should be retained.
> + */
> +int ubi_dbg_power_cut(struct ubi_device *ubi, int caller);
> +
> +static inline int ubi_dbg_bitflip(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_bitflips)
> +		return !get_random_u32_below(200);
> +	return 0;
> +}
> +
> +static inline int ubi_dbg_write_failure(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_io_failures)
> +		return !get_random_u32_below(500);
> +	return 0;
> +}
> +
> +static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_io_failures)
> +		return !get_random_u32_below(400);
> +	return 0;
> +}
> +
> +/**
> + * MASK_XXX: Mask for emulate_failures in ubi_debug_info.The mask is used to
> + * precisely control the type and process of fault injection.
> + */
> +/* Emulate a power cut when writing EC/VID header */
> +#define MASK_POWER_CUT_EC	(1 << 1)
> +#define MASK_POWER_CUT_VID	(1 << 2)

POWER_CUT_EC_WRITE=0x1, POWER_CUT_VID_WRITE=0x02
To be compatible with old interface, please define MASK_POWER_CUT_EC as 
(1 << 0) and define MASK_POWER_CUT_VID (1<<1)

> +
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +/* Emulate bit-flips */
> +#define MASK_BITFLIPS		(1 << 3)
> +/* Emulates -EIO during write/erase */
> +#define MASK_IO_FAILURE		(1 << 4)
> +
> +extern bool should_fail_bitflips(void);
> +extern bool should_fail_io_failures(void);
> +extern bool should_fail_power_cut(void);
> +
> +static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_failures & MASK_BITFLIPS)
> +		return should_fail_bitflips();
> +	return false;
> +}
> +
> +static inline bool ubi_dbg_fail_write(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_failures & MASK_IO_FAILURE)
> +		return should_fail_io_failures();
> +	return false;
> +}
> +
> +static inline bool ubi_dbg_fail_erase(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_failures & MASK_IO_FAILURE)
> +		return should_fail_io_failures();
> +	return false;
> +}
> +
> +static inline bool ubi_dbg_fail_power_cut(const struct ubi_device *ubi,
> +					unsigned int caller)
> +{
> +	if (ubi->dbg.emulate_failures & caller)
> +		return should_fail_power_cut();
> +	return false;
> +}
> +
> +#else /* CONFIG_MTD_UBI_FAULT_INJECTION */
> +
> +#define ubi_dbg_fail_bitflip(u)           false
> +#define ubi_dbg_fail_write(u)             false
> +#define ubi_dbg_fail_erase(u)             false
> +#define ubi_dbg_fail_power_cut(u,c)       false
> +#endif
> +
> +/**
> + * ubi_dbg_is_power_cut - if it is time to emulate power cut.
>    * @ubi: UBI device description object
>    *
> - * Returns non-zero if the UBI background thread is disabled for testing
> - * purposes.
> + * Returns true if power cut should be emulated, otherwise returns false.
>    */
> -static inline int ubi_dbg_is_bgt_disabled(const struct ubi_device *ubi)
> +static inline bool ubi_dbg_is_power_cut(struct ubi_device *ubi,
> +					unsigned int caller)
>   {
> -	return ubi->dbg.disable_bgt;
> +	if (ubi_dbg_power_cut(ubi, caller))
> +		return true;
> +	return ubi_dbg_fail_power_cut(ubi, caller);
>   }
>   
>   /**
>    * ubi_dbg_is_bitflip - if it is time to emulate a bit-flip.
>    * @ubi: UBI device description object
>    *
> - * Returns non-zero if a bit-flip should be emulated, otherwise returns zero.
> + * Returns true if a bit-flip should be emulated, otherwise returns false.
>    */
> -static inline int ubi_dbg_is_bitflip(const struct ubi_device *ubi)
> +static inline bool ubi_dbg_is_bitflip(const struct ubi_device *ubi)
>   {
> -	if (ubi->dbg.emulate_bitflips)
> -		return !get_random_u32_below(200);
> -	return 0;
> +	if (ubi_dbg_bitflip(ubi))
> +		return true;
> +	return ubi_dbg_fail_bitflip(ubi);
>   }
>   
>   /**
>    * ubi_dbg_is_write_failure - if it is time to emulate a write failure.
>    * @ubi: UBI device description object
>    *
> - * Returns non-zero if a write failure should be emulated, otherwise returns
> - * zero.
> + * Returns true if a write failure should be emulated, otherwise returns
> + * false.
>    */
> -static inline int ubi_dbg_is_write_failure(const struct ubi_device *ubi)
> +static inline bool ubi_dbg_is_write_failure(const struct ubi_device *ubi)
>   {
> -	if (ubi->dbg.emulate_io_failures)
> -		return !get_random_u32_below(500);
> -	return 0;
> +	if (ubi_dbg_write_failure(ubi))
> +		return true;;
> +	return ubi_dbg_fail_write(ubi);
>   }
>   
>   /**
>    * ubi_dbg_is_erase_failure - if its time to emulate an erase failure.
>    * @ubi: UBI device description object
>    *
> - * Returns non-zero if an erase failure should be emulated, otherwise returns
> - * zero.
> + * Returns true if an erase failure should be emulated, otherwise returns
> + * false.
>    */
> -static inline int ubi_dbg_is_erase_failure(const struct ubi_device *ubi)
> +static inline bool ubi_dbg_is_erase_failure(const struct ubi_device *ubi)
>   {
> -	if (ubi->dbg.emulate_io_failures)
> -		return !get_random_u32_below(400);
> -	return 0;
> +	if (ubi_dbg_erase_failure(ubi))
> +		return true;
> +	return ubi_dbg_fail_erase(ubi);
> +}
> +
> +/**
> + * ubi_dbg_is_bgt_disabled - if the background thread is disabled.
> + * @ubi: UBI device description object
> + *
> + * Returns non-zero if the UBI background thread is disabled for testing
> + * purposes.
> + */
> +static inline int ubi_dbg_is_bgt_disabled(const struct ubi_device *ubi)
> +{
> +	return ubi->dbg.disable_bgt;
>   }
>   
>   static inline int ubi_dbg_chk_io(const struct ubi_device *ubi)
> @@ -125,5 +222,4 @@ static inline void ubi_enable_dbg_chk_fastmap(struct ubi_device *ubi)
>   	ubi->dbg.chk_fastmap = 1;
>   }
>   
> -int ubi_dbg_power_cut(struct ubi_device *ubi, int caller);
>   #endif /* !__UBI_DEBUG_H__ */
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index 01b644861253..ffa7bbf27bc2 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -821,8 +821,11 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int pnum,
>   	if (err)
>   		return err;
>   
> -	if (ubi_dbg_power_cut(ubi, POWER_CUT_EC_WRITE))
> +	if (ubi_dbg_is_power_cut(ubi, MASK_POWER_CUT_EC)) {
> +		ubi_warn(ubi, "XXXXX emulating a power cut when writing EC header XXXXX");
> +		ubi_ro_mode(ubi);
>   		return -EROFS;
> +	}
>   
>   	err = ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
>   	return err;
> @@ -1071,8 +1074,11 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
>   	if (err)
>   		return err;
>   
> -	if (ubi_dbg_power_cut(ubi, POWER_CUT_VID_WRITE))
> +	if (ubi_dbg_is_power_cut(ubi, MASK_POWER_CUT_VID)) {
> +		ubi_warn(ubi, "XXXXX emulating a power cut when writing VID header XXXXX");
> +		ubi_ro_mode(ubi);
>   		return -EROFS;
> +	}
>   
>   	err = ubi_io_write(ubi, p, pnum, ubi->vid_hdr_aloffset,
>   			   ubi->vid_hdr_alsize);
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index c8f1bd4fa100..41f57d5717b2 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -142,17 +142,6 @@ enum {
>   	UBI_BAD_FASTMAP,
>   };
>   
> -/*
> - * Flags for emulate_power_cut in ubi_debug_info
> - *
> - * POWER_CUT_EC_WRITE: Emulate a power cut when writing an EC header
> - * POWER_CUT_VID_WRITE: Emulate a power cut when writing a VID header
> - */
> -enum {
> -	POWER_CUT_EC_WRITE = 0x01,
> -	POWER_CUT_VID_WRITE = 0x02,
> -};
> -
>   /**
>    * struct ubi_vid_io_buf - VID buffer used to read/write VID info to/from the
>    *			   flash.
> @@ -401,6 +390,7 @@ struct ubi_volume_desc {
>    * @power_cut_counter: count down for writes left until emulated power cut
>    * @power_cut_min: minimum number of writes before emulating a power cut
>    * @power_cut_max: maximum number of writes until emulating a power cut
> + * @emulate_failures: emulate failures for testing purposes
>    * @dfs_dir_name: name of debugfs directory containing files of this UBI device
>    * @dfs_dir: direntry object of the UBI device debugfs directory
>    * @dfs_chk_gen: debugfs knob to enable UBI general extra checks
> @@ -412,6 +402,7 @@ struct ubi_volume_desc {
>    * @dfs_emulate_power_cut: debugfs knob to emulate power cuts
>    * @dfs_power_cut_min: debugfs knob for minimum writes before power cut
>    * @dfs_power_cut_max: debugfs knob for maximum writes until power cut
> + * @dfs_emulate_failures: debugfs entry to control the fault injection type
>    */
>   struct ubi_debug_info {
>   	unsigned int chk_gen:1;
> @@ -424,6 +415,7 @@ struct ubi_debug_info {
>   	unsigned int power_cut_counter;
>   	unsigned int power_cut_min;
>   	unsigned int power_cut_max;
> +	unsigned int emulate_failures;
>   	char dfs_dir_name[UBI_DFS_DIR_LEN + 1];
>   	struct dentry *dfs_dir;
>   	struct dentry *dfs_chk_gen;
> @@ -435,6 +427,7 @@ struct ubi_debug_info {
>   	struct dentry *dfs_emulate_power_cut;
>   	struct dentry *dfs_power_cut_min;
>   	struct dentry *dfs_power_cut_max;
> +	struct dentry *dfs_emulate_failures;
>   };
>   
>   /**
> 

