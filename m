Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8A76955C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjGaL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGaL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:57:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0599E71
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:57:32 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RDxVx09BVzLnhq;
        Mon, 31 Jul 2023 19:54:49 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:57:28 +0800
Subject: Re: [PATCH V2 3/5] ubi: Add six fault injection type for testing
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
 <20230718085119.3885747-4-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ff35ce47-4d74-1bbf-3a77-72c0dd764099@huawei.com>
Date:   Mon, 31 Jul 2023 19:57:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230718085119.3885747-4-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/18 16:51, ZhaoLong Wang Ð´µÀ:
> This commit adds six fault injection type for testing to cover the
> abnormal path of the UBI driver.
> 
> Inject the following faults when the UBI reads the LEB:
>   +----------------------------+-----------------------------------+
>   |    Interface name          |       emulate behavior            |
>   +----------------------------+-----------------------------------+
>   |  emulate_eccerr            | ECC error                         |
>   +----------------------------+-----------------------------------+
>   |  emulate_read_failure      | read failure                      |
>   |----------------------------+-----------------------------------+
>   |  emulate_io_ff             | read content as all FF            |
>   |----------------------------+-----------------------------------+
>   |  emulate_io_ff_bitflips    | content FF with MTD err reported  |
>   +----------------------------+-----------------------------------+
>   |  emulate_bad_hdr           | bad leb header                    |
>   |----------------------------+-----------------------------------+
>   |  emulate_bad_hdr_ebadmsg   | bad header with ECC err           |
>   +----------------------------+-----------------------------------+
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/debug.c |  30 +++++++++
>   drivers/mtd/ubi/debug.h | 132 ++++++++++++++++++++++++++++++++++++++--
>   drivers/mtd/ubi/io.c    |  75 ++++++++++++++++++++++-
>   drivers/mtd/ubi/ubi.h   |  31 ++++++----
>   4 files changed, 248 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index 7826bc8166e8..016a861c5029 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -13,10 +13,16 @@
>   #include <linux/fault-inject.h>
>   
>   #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +static DECLARE_FAULT_ATTR(fault_eccerr_attr);
>   static DECLARE_FAULT_ATTR(fault_bitflips_attr);
> +static DECLARE_FAULT_ATTR(fault_read_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_write_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_erase_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_power_cut_attr);
> +static DECLARE_FAULT_ATTR(fault_io_ff_attr);
> +static DECLARE_FAULT_ATTR(fault_io_ff_bitflips_attr);
> +static DECLARE_FAULT_ATTR(fault_bad_hdr_attr);
> +static DECLARE_FAULT_ATTR(fault_bad_hdr_ebadmsg_attr);
>   
>   #define FAIL_ACTION(name, fault_attr)			\
>   bool should_fail_##name(void)				\
> @@ -24,10 +30,16 @@ bool should_fail_##name(void)				\
>   	return should_fail(&fault_attr, 1);		\
>   }
>   
> +FAIL_ACTION(eccerr,		fault_eccerr_attr)
>   FAIL_ACTION(bitflips,		fault_bitflips_attr)
> +FAIL_ACTION(read_failure,	fault_read_failure_attr)
>   FAIL_ACTION(write_failure,	fault_write_failure_attr)
>   FAIL_ACTION(erase_failure,	fault_erase_failure_attr)
>   FAIL_ACTION(power_cut,		fault_power_cut_attr)
> +FAIL_ACTION(io_ff,		fault_io_ff_attr)
> +FAIL_ACTION(io_ff_bitflips,	fault_io_ff_bitflips_attr)
> +FAIL_ACTION(bad_hdr,		fault_bad_hdr_attr)
> +FAIL_ACTION(bad_hdr_ebadmsg,	fault_bad_hdr_ebadmsg_attr)
>   #endif
>   
>   /**
> @@ -244,6 +256,12 @@ static void dfs_create_fault_entry(struct dentry *parent)
>   		return;
>   	}
>   
> +	fault_create_debugfs_attr("emulate_eccerr", dir,
> +				  &fault_eccerr_attr);
> +
> +	fault_create_debugfs_attr("emulate_read_failure", dir,
> +				  &fault_read_failure_attr);
> +
>   	fault_create_debugfs_attr("emulate_bitflips", dir,
>   				  &fault_bitflips_attr);
>   
> @@ -255,6 +273,18 @@ static void dfs_create_fault_entry(struct dentry *parent)
>   
>   	fault_create_debugfs_attr("emulate_power_cut", dir,
>   				  &fault_power_cut_attr);
> +
> +	fault_create_debugfs_attr("emulate_io_ff", dir,
> +				  &fault_io_ff_attr);
> +
> +	fault_create_debugfs_attr("emulate_io_ff_bitflips", dir,
> +				  &fault_io_ff_bitflips_attr);
> +
> +	fault_create_debugfs_attr("emulate_bad_hdr", dir,
> +				  &fault_bad_hdr_attr);
> +
> +	fault_create_debugfs_attr("emulate_bad_hdr_ebadmsg", dir,
> +				  &fault_bad_hdr_ebadmsg_attr);
>   }
>   #endif
>   
> diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
> index 6bc698b38e35..29fbd971964a 100644
> --- a/drivers/mtd/ubi/debug.h
> +++ b/drivers/mtd/ubi/debug.h
> @@ -85,20 +85,47 @@ static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
>    * precisely control the type and process of fault injection.
>    */
>   /* Emulate a power cut when writing EC/VID header */
> -#define MASK_POWER_CUT_EC	(1 << 1)
> -#define MASK_POWER_CUT_VID	(1 << 2)
> +#define MASK_POWER_CUT_EC		(1 << 0)
> +#define MASK_POWER_CUT_VID		(1 << 1)
>   
>   #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +/* Emulate a power cut when writing data*/
> +#define MASK_POWER_CUT_DATA		(1 << 2)
>   /* Emulate bit-flips */
> -#define MASK_BITFLIPS		(1 << 3)
> -/* Emulates -EIO during write/erase */
> -#define MASK_WRITE_FAILURE	(1 << 4)
> -#define MASK_ERASE_FAILURE	(1 << 5)
> +#define MASK_BITFLIPS			(1 << 3)
> +/* Emulate ecc error */
> +#define MASK_ECCERR			(1 << 4)
> +/* Emulates -EIO during data read */
> +#define MASK_READ_FAILURE		(1 << 5)
> +#define MASK_READ_FAILURE_EC		(1 << 6)
> +#define MASK_READ_FAILURE_VID		(1 << 7)
> +/* Emulates -EIO during data write */
> +#define MASK_WRITE_FAILURE		(1 << 8)
> +/* Emulates -EIO during erase a PEB*/
> +#define MASK_ERASE_FAILURE		(1 << 9)
> +/* Return UBI_IO_FF when reading EC/VID header */
> +#define MASK_IO_FF_EC			(1 << 10)
> +#define MASK_IO_FF_VID			(1 << 11)
> +/* Return UBI_IO_FF_BITFLIPS when reading EC/VID header */
> +#define MASK_IO_FF_BITFLIPS_EC		(1 << 12)
> +#define MASK_IO_FF_BITFLIPS_VID		(1 << 13)
> +/* Return UBI_IO_BAD_HDR when reading EC/VID header */
> +#define MASK_BAD_HDR_EC			(1 << 14)
> +#define MASK_BAD_HDR_VID		(1 << 15)
> +/* Return UBI_IO_BAD_HDR_EBADMSG when reading EC/VID header */
> +#define MASK_BAD_HDR_EBADMSG_EC		(1 << 16)
> +#define MASK_BAD_HDR_EBADMSG_VID	(1 << 17)
>   
> +extern bool should_fail_eccerr(void);
>   extern bool should_fail_bitflips(void);
> +extern bool should_fail_read_failure(void);
>   extern bool should_fail_write_failure(void);
>   extern bool should_fail_erase_failure(void);
>   extern bool should_fail_power_cut(void);
> +extern bool should_fail_io_ff(void);
> +extern bool should_fail_io_ff_bitflips(void);
> +extern bool should_fail_bad_hdr(void);
> +extern bool should_fail_bad_hdr_ebadmsg(void);
>   
>   static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
>   {
> @@ -192,6 +219,99 @@ static inline bool ubi_dbg_is_erase_failure(const struct ubi_device *ubi)
>   	return ubi_dbg_fail_erase(ubi);
>   }
>   
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +/**
> + * ubi_dbg_is_eccerr - if it is time to emulate ECC error.
> + * @ubi: UBI device description object
> + *
> + * Returns true if a ECC error should be emulated, otherwise returns false.
> + */
> +static inline bool ubi_dbg_is_eccerr(const struct ubi_device *ubi)
> +{
> +	if (ubi->dbg.emulate_failures & MASK_ECCERR)
> +		return should_fail_eccerr();
> +	return false;
> +}

I prefer to keep the same style as ubi_dbg_fail_bitflip, which means 
that define two functions corresponding to enabling 
CONFIG_MTD_UBI_FAULT_INJECTION and disabling CONFIG_MTD_UBI_FAULT_INJECTION.

> +
> +/**
> + * ubi_dbg_is_read_failure - if it is time to emulate a read failure.
> + * @ubi: UBI device description object
> + *
> + * Returns true if a read failure should be emulated, otherwise returns
> + * false.
> + */
> +static inline bool ubi_dbg_is_read_failure(const struct ubi_device *ubi,
> +					   unsigned int caller)
> +{
> +	if (ubi->dbg.emulate_failures & caller)
> +		return should_fail_read_failure();
> +	return false;
> +}
> +
> +/**
> + * ubi_dbg_is_ff - if it is time to emulate that read region is only 0xFF.
> + * @ubi: UBI device description object
> + *
> + * Returns true if read region should be emulated 0xFF, otherwise
> + * returns false.
> + */
> +static inline bool ubi_dbg_is_ff(const struct ubi_device *ubi,
> +				 unsigned int caller)
> +{
> +	if (ubi->dbg.emulate_failures & caller)
> +		return should_fail_io_ff();
> +	return false;
> +}
> +
> +/**
> + * ubi_dbg_is_ff_bitflips - if it is time to emulate that read region is only 0xFF
> + * with error reported by the MTD driver
> + *
> + * @ubi: UBI device description object
> + *
> + * Returns true if read region should be emulated 0xFF and error
> + * reported by the MTD driver, otherwise returns false.
> + */
> +static inline bool ubi_dbg_is_ff_bitflips(const struct ubi_device *ubi,
> +					  unsigned int caller)
> +{
> +	if (ubi->dbg.emulate_failures & caller)
> +		return should_fail_io_ff_bitflips();
> +	return false;
> +}
> +
> +/**
> + * ubi_dbg_is_bad_hdr - if it is time to emulate a bad header
> + * @ubi: UBI device description object
> + *
> + * Returns true if a bad header error should be emulated, otherwise
> + * returns false.
> + */
> +static inline bool ubi_dbg_is_bad_hdr(const struct ubi_device *ubi,
> +				      unsigned int caller)
> +{
> +	if (ubi->dbg.emulate_failures & caller)
> +		return should_fail_bad_hdr();
> +	return false;
> +}
> +
> +/**
> + * ubi_dbg_is_bad_hdr_ebadmsg - if it is time to emulate a bad header with
> + * ECC error.
> + *
> + * @ubi: UBI device description object
> + *
> + * Returns true if a bad header with ECC error should be emulated, otherwise
> + * returns false.
> + */
> +static inline bool ubi_dbg_is_bad_hdr_ebadmsg(const struct ubi_device *ubi,
> +					      unsigned int caller)
> +{
> +	if (ubi->dbg.emulate_failures & caller)
> +		return should_fail_bad_hdr_ebadmsg();
> +	return false;
> +}
> +#endif
>   /**
>    * ubi_dbg_is_bgt_disabled - if the background thread is disabled.
>    * @ubi: UBI device description object
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index ffa7bbf27bc2..059032132bdd 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -197,6 +197,19 @@ int ubi_io_read(const struct ubi_device *ubi, void *buf, int pnum, int offset,
>   			dbg_gen("bit-flip (emulated)");
>   			err = UBI_IO_BITFLIPS;
>   		}
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +		if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE)) {
> +			ubi_warn(ubi, "cannot read %d bytes from PEB %d:%d (emulated)",
> +				 len, pnum, offset);
> +			return -EIO;
> +		}
> +
> +		if (ubi_dbg_is_eccerr(ubi)) {
> +			ubi_warn(ubi, "ECC error (emulated) while reading %d bytes from PEB %d:%d, read %zd bytes",
> +				 len, pnum, offset, read);
> +			return -EBADMSG;
> +		}
> +#endif
>   	}
>   
>   	return err;
> @@ -782,7 +795,36 @@ int ubi_io_read_ec_hdr(struct ubi_device *ubi, int pnum,
>   	 * If there was %-EBADMSG, but the header CRC is still OK, report about
>   	 * a bit-flip to force scrubbing on this PEB.
>   	 */
> -	return read_err ? UBI_IO_BITFLIPS : 0;
> +	if (read_err)
> +		return UBI_IO_BITFLIPS;
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +	if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE_EC)) {
> +		ubi_warn(ubi, "cannot read EC header from PEB %d(emulated)",
> +			 pnum);
> +		return -EIO;
> +	}
> +
> +	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_EC)) {
> +		ubi_warn(ubi, "bit-all-ff (emulated)");
> +		return UBI_IO_FF;
> +	}
> +
> +	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_EC)) {
> +		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)");
> +		return UBI_IO_FF_BITFLIPS;
> +	}
> +
> +	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_EC)) {
> +		ubi_warn(ubi, "bad_hdr (emulated)");
> +		return UBI_IO_BAD_HDR;
> +	}
> +
> +	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_EC)) {
> +		ubi_warn(ubi, "bad_hdr with ECC error (emulated)");
> +		return UBI_IO_BAD_HDR_EBADMSG;
> +	}
> +#endif
> +	return 0;
>   }
>   
>   /**
> @@ -1032,7 +1074,36 @@ int ubi_io_read_vid_hdr(struct ubi_device *ubi, int pnum,
>   		return -EINVAL;
>   	}
>   
> -	return read_err ? UBI_IO_BITFLIPS : 0;
> +	if (read_err)
> +		return UBI_IO_BITFLIPS;
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +	if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE_VID)) {
> +		ubi_warn(ubi, "cannot read VID header from PEB %d(emulated)",
> +			 pnum);
> +		return -EIO;
> +	}
> +
> +	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_VID)) {
> +		ubi_warn(ubi, "bit-all-ff (emulated)\n");
> +		return UBI_IO_FF;
> +	}
> +
> +	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_VID)) {
> +		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)\n");
> +		return UBI_IO_FF_BITFLIPS;
> +	}
> +
> +	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_VID)) {
> +		ubi_warn(ubi, "bad_hdr (emulated)\n");
> +		return UBI_IO_BAD_HDR;
> +	}
> +
> +	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_VID)) {
> +		ubi_warn(ubi, "bad_hdr with ECC error (emulated)\n");
> +		return UBI_IO_BAD_HDR_EBADMSG;
> +	}
> +#endif
> +	return 0;
>   }
>   
>   /**
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index 41f57d5717b2..36d46425ed4c 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -1117,18 +1117,6 @@ static inline struct ubi_vid_hdr *ubi_get_vid_hdr(struct ubi_vid_io_buf *vidb)
>   	return vidb->hdr;
>   }
>   
> -/*
> - * This function is equivalent to 'ubi_io_read()', but @offset is relative to
> - * the beginning of the logical eraseblock, not to the beginning of the
> - * physical eraseblock.
> - */
> -static inline int ubi_io_read_data(const struct ubi_device *ubi, void *buf,
> -				   int pnum, int offset, int len)
> -{
> -	ubi_assert(offset >= 0);
> -	return ubi_io_read(ubi, buf, pnum, offset + ubi->leb_start, len);
> -}
> -
>   /*
>    * This function is equivalent to 'ubi_io_write()', but @offset is relative to
>    * the beginning of the logical eraseblock, not to the beginning of the
> @@ -1154,6 +1142,25 @@ static inline void ubi_ro_mode(struct ubi_device *ubi)
>   	}
>   }
>   
> +/*
> + * This function is equivalent to 'ubi_io_read()', but @offset is relative to
> + * the beginning of the logical eraseblock, not to the beginning of the
> + * physical eraseblock.
> + */
> +static inline int ubi_io_read_data(struct ubi_device *ubi, void *buf,
> +				   int pnum, int offset, int len)

I thought you want to modify 'ubi_io_write_data'.

> +{
> +	ubi_assert(offset >= 0);
> +#ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +	if (ubi_dbg_power_cut(ubi, MASK_POWER_CUT_DATA)) {
> +		ubi_warn(ubi, "XXXXX emulating a power cut when writing data XXXXX");
> +		ubi_ro_mode(ubi);
> +		return -EROFS;
> +	}
> +#endif
> +	return ubi_io_read(ubi, buf, pnum, offset + ubi->leb_start, len);
> +}
> +
>   /**
>    * vol_id2idx - get table index by volume ID.
>    * @ubi: UBI device description object
> 

