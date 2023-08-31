Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9378E4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbjHaCWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjHaCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:22:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370291BF;
        Wed, 30 Aug 2023 19:21:55 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RblHd32b9z1L9N6;
        Thu, 31 Aug 2023 10:20:13 +0800 (CST)
Received: from [10.67.121.249] (10.67.121.249) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 31 Aug 2023 10:21:52 +0800
Message-ID: <8a73f9cb-b1e8-3b54-4b6c-7cfb19244560@huawei.com>
Date:   Thu, 31 Aug 2023 10:21:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] crypto: hisilicon/zip - Remove driver
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <ardb@kernel.org>, <kees@kernel.org>,
        <linux-kernel@vger.kernel.org>, <enlin.mu@unisoc.com>,
        <ebiggers@google.com>, <gpiccoli@igalia.com>,
        <willy@infradead.org>, <yunlong.xing@unisoc.com>,
        <yuxiaozhang@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        <qat-linux@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7v-009Bvf-CA@formenos.hmeau.com>
From:   Yang Shen <shenyang39@huawei.com>
In-Reply-To: <E1qbI7v-009Bvf-CA@formenos.hmeau.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.249]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

It's a pity to see that there is no user in the kernel of zlib-deflate. 
However, there may still be hidden
users in the current kernel who may be using the zlib-deflate algorithm. 
Such as zswap, it can use
user-specified algorithm. So there are still some benefits to be gained 
from zlib hardware.

What's more, hisilicon zip driver also does other work besides 
supporting the zlib-deflate:
1.Support gzip algorithm.
2.Support a user space cdev hisi-zip which can accelerate user space 
process via uacce subsystem.
So if the zlib-deflate must be removed, the hisilicon zip driver should 
only remove the zlib-deflate registration.

Thanks,
Yang

在 2023/8/30 18:08, Herbert Xu 写道:
> Remove the hisilicon zip driver as it only contains algorithms that
> nobody uses in the kernel.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>
>   Documentation/ABI/testing/debugfs-hisi-zip |  138 --
>   MAINTAINERS                                |    8
>   drivers/crypto/hisilicon/Kconfig           |   11
>   drivers/crypto/hisilicon/Makefile          |    1
>   drivers/crypto/hisilicon/zip/Makefile      |    2
>   drivers/crypto/hisilicon/zip/zip.h         |   88 -
>   drivers/crypto/hisilicon/zip/zip_crypto.c  |  839 -----------------
>   drivers/crypto/hisilicon/zip/zip_main.c    | 1357 -----------------------------
>   8 files changed, 2444 deletions(-)
>
> diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
> deleted file mode 100644
> index fd3f314cf8d1..000000000000
> --- a/Documentation/ABI/testing/debugfs-hisi-zip
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/comp_core[01]/regs
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump of compression cores related debug registers.
> -		Only available for PF.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/decomp_core[0-5]/regs
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump of decompression cores related debug registers.
> -		Only available for PF.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/clear_enable
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Compression/decompression core debug registers read clear
> -		control. 1 means enable register read clear, otherwise 0.
> -		Writing to this file has no functional effect, only enable or
> -		disable counters clear after reading of these registers.
> -		Only available for PF.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/current_qm
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	One ZIP controller has one PF and multiple VFs, each function
> -		has a QM. Select the QM which below qm refers to.
> -		Only available for PF.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/alg_qos
> -Date:		Jun 2021
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	The <bdf> is related the function for PF and VF.
> -		ZIP driver supports to configure each function's QoS, the driver
> -		supports to write <bdf> value to alg_qos in the host. Such as
> -		"echo <bdf> value > alg_qos". The qos value is 1~1000, means
> -		1/1000~1000/1000 of total QoS. The driver reading alg_qos to
> -		get related QoS in the host and VM, Such as "cat alg_qos".
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/regs
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump of QM related debug registers.
> -		Available for PF and VF in host. VF in guest currently only
> -		has one debug register.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/current_q
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	One QM may contain multiple queues. Select specific queue to
> -		show its debug registers in above regs.
> -		Only available for PF.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/clear_enable
> -Date:		Nov 2018
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	QM debug registers(regs) read clear control. 1 means enable
> -		register read clear, otherwise 0.
> -		Writing to this file has no functional effect, only enable or
> -		disable counters clear after reading of these registers.
> -		Only available for PF.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/err_irq
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the number of invalid interrupts for
> -		QM task completion.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/aeq_irq
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the number of QM async event queue interrupts.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/abnormal_irq
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the number of interrupts for QM abnormal event.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/create_qp_err
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the number of queue allocation errors.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/mb_err
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the number of failed QM mailbox commands.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/status
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the status of the QM.
> -		Four states: initiated, started, stopped and closed.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/diff_regs
> -Date:		Mar 2022
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	QM debug registers(regs) read hardware register value. This
> -		node is used to show the change of the qm registers value. This
> -		node can be help users to check the change of register values.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/diff_regs
> -Date:		Mar 2022
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	ZIP debug registers(regs) read hardware register value. This
> -		node is used to show the change of the registers value. this
> -		node can be help users to check the change of register values.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/send_cnt
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the total number of sent requests.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/recv_cnt
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the total number of received requests.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/send_busy_cnt
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the total number of requests received
> -		with returning busy.
> -		Available for both PF and VF, and take no other effect on ZIP.
> -
> -What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/err_bd_cnt
> -Date:		Apr 2020
> -Contact:	linux-crypto@vger.kernel.org
> -Description:	Dump the total number of BD type error requests
> -		to be received.
> -		Available for both PF and VF, and take no other effect on ZIP.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64602d4169d0..c2872aeac0d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9433,14 +9433,6 @@ S:	Maintained
>   W:	http://www.hisilicon.com
>   F:	drivers/spi/spi-hisi-sfc-v3xx.c
>   
> -HISILICON ZIP Controller DRIVER
> -M:	Yang Shen <shenyang39@huawei.com>
> -M:	Zhou Wang <wangzhou1@hisilicon.com>
> -L:	linux-crypto@vger.kernel.org
> -S:	Maintained
> -F:	Documentation/ABI/testing/debugfs-hisi-zip
> -F:	drivers/crypto/hisilicon/zip/
> -
>   HMM - Heterogeneous Memory Management
>   M:	Jérôme Glisse <jglisse@redhat.com>
>   L:	linux-mm@kvack.org
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 4137a8bf131f..a4ad616ce3e1 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -49,17 +49,6 @@ config CRYPTO_DEV_HISI_QM
>   	  HiSilicon accelerator engines use a common queue management
>   	  interface. Specific engine driver may use this module.
>   
> -config CRYPTO_DEV_HISI_ZIP
> -	tristate "Support for HiSilicon ZIP accelerator"
> -	depends on PCI_MSI
> -	depends on ARM64 || (COMPILE_TEST && 64BIT)
> -	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
> -	depends on UACCE || UACCE=n
> -	depends on ACPI
> -	select CRYPTO_DEV_HISI_QM
> -	help
> -	  Support for HiSilicon ZIP Driver
> -
>   config CRYPTO_DEV_HISI_HPRE
>   	tristate "Support for HISI HPRE accelerator"
>   	depends on PCI_MSI
> diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
> index 8595a5a5d228..b342d7562eb5 100644
> --- a/drivers/crypto/hisilicon/Makefile
> +++ b/drivers/crypto/hisilicon/Makefile
> @@ -4,5 +4,4 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
>   obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
>   obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
>   hisi_qm-objs = qm.o sgl.o debugfs.o
> -obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
>   obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
> diff --git a/drivers/crypto/hisilicon/zip/Makefile b/drivers/crypto/hisilicon/zip/Makefile
> deleted file mode 100644
> index a936f099ee22..000000000000
> --- a/drivers/crypto/hisilicon/zip/Makefile
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += hisi_zip.o
> -hisi_zip-objs = zip_main.o zip_crypto.o
> diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
> deleted file mode 100644
> index f2e6da3240ae..000000000000
> --- a/drivers/crypto/hisilicon/zip/zip.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (c) 2019 HiSilicon Limited. */
> -#ifndef HISI_ZIP_H
> -#define HISI_ZIP_H
> -
> -#undef pr_fmt
> -#define pr_fmt(fmt)	"hisi_zip: " fmt
> -
> -#include <linux/list.h>
> -#include <linux/hisi_acc_qm.h>
> -
> -enum hisi_zip_error_type {
> -	/* negative compression */
> -	HZIP_NC_ERR = 0x0d,
> -};
> -
> -struct hisi_zip_dfx {
> -	atomic64_t send_cnt;
> -	atomic64_t recv_cnt;
> -	atomic64_t send_busy_cnt;
> -	atomic64_t err_bd_cnt;
> -};
> -
> -struct hisi_zip_ctrl;
> -
> -struct hisi_zip {
> -	struct hisi_qm qm;
> -	struct hisi_zip_ctrl *ctrl;
> -	struct hisi_zip_dfx dfx;
> -};
> -
> -struct hisi_zip_sqe {
> -	u32 consumed;
> -	u32 produced;
> -	u32 comp_data_length;
> -	/*
> -	 * status: 0~7 bits
> -	 * rsvd: 8~31 bits
> -	 */
> -	u32 dw3;
> -	u32 input_data_length;
> -	u32 dw5;
> -	u32 dw6;
> -	/*
> -	 * in_sge_data_offset: 0~23 bits
> -	 * rsvd: 24~27 bits
> -	 * sqe_type: 29~31 bits
> -	 */
> -	u32 dw7;
> -	/*
> -	 * out_sge_data_offset: 0~23 bits
> -	 * rsvd: 24~31 bits
> -	 */
> -	u32 dw8;
> -	/*
> -	 * request_type: 0~7 bits
> -	 * buffer_type: 8~11 bits
> -	 * rsvd: 13~31 bits
> -	 */
> -	u32 dw9;
> -	u32 dw10;
> -	u32 dw11;
> -	u32 dw12;
> -	/* tag: in sqe type 0 */
> -	u32 dw13;
> -	u32 dest_avail_out;
> -	u32 dw15;
> -	u32 dw16;
> -	u32 dw17;
> -	u32 source_addr_l;
> -	u32 source_addr_h;
> -	u32 dest_addr_l;
> -	u32 dest_addr_h;
> -	u32 dw22;
> -	u32 dw23;
> -	u32 dw24;
> -	u32 dw25;
> -	/* tag: in sqe type 3 */
> -	u32 dw26;
> -	u32 dw27;
> -	u32 rsvd1[4];
> -};
> -
> -int zip_create_qps(struct hisi_qp **qps, int qp_num, int node);
> -int hisi_zip_register_to_crypto(struct hisi_qm *qm);
> -void hisi_zip_unregister_from_crypto(struct hisi_qm *qm);
> -bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg);
> -#endif
> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
> deleted file mode 100644
> index 6608971d10cd..000000000000
> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> +++ /dev/null
> @@ -1,839 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2019 HiSilicon Limited. */
> -#include <crypto/internal/acompress.h>
> -#include <linux/bitfield.h>
> -#include <linux/bitmap.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/scatterlist.h>
> -#include "zip.h"
> -
> -/* hisi_zip_sqe dw3 */
> -#define HZIP_BD_STATUS_M			GENMASK(7, 0)
> -/* hisi_zip_sqe dw7 */
> -#define HZIP_IN_SGE_DATA_OFFSET_M		GENMASK(23, 0)
> -#define HZIP_SQE_TYPE_M				GENMASK(31, 28)
> -/* hisi_zip_sqe dw8 */
> -#define HZIP_OUT_SGE_DATA_OFFSET_M		GENMASK(23, 0)
> -/* hisi_zip_sqe dw9 */
> -#define HZIP_REQ_TYPE_M				GENMASK(7, 0)
> -#define HZIP_ALG_TYPE_ZLIB			0x02
> -#define HZIP_ALG_TYPE_GZIP			0x03
> -#define HZIP_BUF_TYPE_M				GENMASK(11, 8)
> -#define HZIP_PBUFFER				0x0
> -#define HZIP_SGL				0x1
> -
> -#define HZIP_ZLIB_HEAD_SIZE			2
> -#define HZIP_GZIP_HEAD_SIZE			10
> -
> -#define GZIP_HEAD_FHCRC_BIT			BIT(1)
> -#define GZIP_HEAD_FEXTRA_BIT			BIT(2)
> -#define GZIP_HEAD_FNAME_BIT			BIT(3)
> -#define GZIP_HEAD_FCOMMENT_BIT			BIT(4)
> -
> -#define GZIP_HEAD_FLG_SHIFT			3
> -#define GZIP_HEAD_FEXTRA_SHIFT			10
> -#define GZIP_HEAD_FEXTRA_XLEN			2UL
> -#define GZIP_HEAD_FHCRC_SIZE			2
> -
> -#define HZIP_GZIP_HEAD_BUF			256
> -#define HZIP_ALG_PRIORITY			300
> -#define HZIP_SGL_SGE_NR				10
> -
> -#define HZIP_ALG_ZLIB				GENMASK(1, 0)
> -#define HZIP_ALG_GZIP				GENMASK(3, 2)
> -
> -static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
> -static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {
> -	0x1f, 0x8b, 0x08, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x03
> -};
> -
> -enum hisi_zip_alg_type {
> -	HZIP_ALG_TYPE_COMP = 0,
> -	HZIP_ALG_TYPE_DECOMP = 1,
> -};
> -
> -enum {
> -	HZIP_QPC_COMP,
> -	HZIP_QPC_DECOMP,
> -	HZIP_CTX_Q_NUM
> -};
> -
> -#define COMP_NAME_TO_TYPE(alg_name)					\
> -	(!strcmp((alg_name), "zlib-deflate") ? HZIP_ALG_TYPE_ZLIB :	\
> -	 !strcmp((alg_name), "gzip") ? HZIP_ALG_TYPE_GZIP : 0)		\
> -
> -#define TO_HEAD_SIZE(req_type)						\
> -	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? sizeof(zlib_head) :	\
> -	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? sizeof(gzip_head) : 0)	\
> -
> -#define TO_HEAD(req_type)						\
> -	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? zlib_head :		\
> -	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? gzip_head : NULL)		\
> -
> -struct hisi_zip_req {
> -	struct acomp_req *req;
> -	u32 sskip;
> -	u32 dskip;
> -	struct hisi_acc_hw_sgl *hw_src;
> -	struct hisi_acc_hw_sgl *hw_dst;
> -	dma_addr_t dma_src;
> -	dma_addr_t dma_dst;
> -	u16 req_id;
> -};
> -
> -struct hisi_zip_req_q {
> -	struct hisi_zip_req *q;
> -	unsigned long *req_bitmap;
> -	rwlock_t req_lock;
> -	u16 size;
> -};
> -
> -struct hisi_zip_qp_ctx {
> -	struct hisi_qp *qp;
> -	struct hisi_zip_req_q req_q;
> -	struct hisi_acc_sgl_pool *sgl_pool;
> -	struct hisi_zip *zip_dev;
> -	struct hisi_zip_ctx *ctx;
> -};
> -
> -struct hisi_zip_sqe_ops {
> -	u8 sqe_type;
> -	void (*fill_addr)(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req);
> -	void (*fill_buf_size)(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req);
> -	void (*fill_buf_type)(struct hisi_zip_sqe *sqe, u8 buf_type);
> -	void (*fill_req_type)(struct hisi_zip_sqe *sqe, u8 req_type);
> -	void (*fill_tag)(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req);
> -	void (*fill_sqe_type)(struct hisi_zip_sqe *sqe, u8 sqe_type);
> -	u32 (*get_tag)(struct hisi_zip_sqe *sqe);
> -	u32 (*get_status)(struct hisi_zip_sqe *sqe);
> -	u32 (*get_dstlen)(struct hisi_zip_sqe *sqe);
> -};
> -
> -struct hisi_zip_ctx {
> -	struct hisi_zip_qp_ctx qp_ctx[HZIP_CTX_Q_NUM];
> -	const struct hisi_zip_sqe_ops *ops;
> -};
> -
> -static int sgl_sge_nr_set(const char *val, const struct kernel_param *kp)
> -{
> -	int ret;
> -	u16 n;
> -
> -	if (!val)
> -		return -EINVAL;
> -
> -	ret = kstrtou16(val, 10, &n);
> -	if (ret || n == 0 || n > HISI_ACC_SGL_SGE_NR_MAX)
> -		return -EINVAL;
> -
> -	return param_set_ushort(val, kp);
> -}
> -
> -static const struct kernel_param_ops sgl_sge_nr_ops = {
> -	.set = sgl_sge_nr_set,
> -	.get = param_get_ushort,
> -};
> -
> -static u16 sgl_sge_nr = HZIP_SGL_SGE_NR;
> -module_param_cb(sgl_sge_nr, &sgl_sge_nr_ops, &sgl_sge_nr, 0444);
> -MODULE_PARM_DESC(sgl_sge_nr, "Number of sge in sgl(1-255)");
> -
> -static u32 get_extra_field_size(const u8 *start)
> -{
> -	return *((u16 *)start) + GZIP_HEAD_FEXTRA_XLEN;
> -}
> -
> -static u32 get_name_field_size(const u8 *start)
> -{
> -	return strlen(start) + 1;
> -}
> -
> -static u32 get_comment_field_size(const u8 *start)
> -{
> -	return strlen(start) + 1;
> -}
> -
> -static u32 __get_gzip_head_size(const u8 *src)
> -{
> -	u8 head_flg = *(src + GZIP_HEAD_FLG_SHIFT);
> -	u32 size = GZIP_HEAD_FEXTRA_SHIFT;
> -
> -	if (head_flg & GZIP_HEAD_FEXTRA_BIT)
> -		size += get_extra_field_size(src + size);
> -	if (head_flg & GZIP_HEAD_FNAME_BIT)
> -		size += get_name_field_size(src + size);
> -	if (head_flg & GZIP_HEAD_FCOMMENT_BIT)
> -		size += get_comment_field_size(src + size);
> -	if (head_flg & GZIP_HEAD_FHCRC_BIT)
> -		size += GZIP_HEAD_FHCRC_SIZE;
> -
> -	return size;
> -}
> -
> -static u32 __maybe_unused get_gzip_head_size(struct scatterlist *sgl)
> -{
> -	char buf[HZIP_GZIP_HEAD_BUF];
> -
> -	sg_copy_to_buffer(sgl, sg_nents(sgl), buf, sizeof(buf));
> -
> -	return __get_gzip_head_size(buf);
> -}
> -
> -static int add_comp_head(struct scatterlist *dst, u8 req_type)
> -{
> -	int head_size = TO_HEAD_SIZE(req_type);
> -	const u8 *head = TO_HEAD(req_type);
> -	int ret;
> -
> -	ret = sg_copy_from_buffer(dst, sg_nents(dst), head, head_size);
> -	if (unlikely(ret != head_size)) {
> -		pr_err("the head size of buffer is wrong (%d)!\n", ret);
> -		return -ENOMEM;
> -	}
> -
> -	return head_size;
> -}
> -
> -static int get_comp_head_size(struct acomp_req *acomp_req, u8 req_type)
> -{
> -	if (unlikely(!acomp_req->src || !acomp_req->slen))
> -		return -EINVAL;
> -
> -	if (unlikely(req_type == HZIP_ALG_TYPE_GZIP &&
> -		     acomp_req->slen < GZIP_HEAD_FEXTRA_SHIFT))
> -		return -EINVAL;
> -
> -	switch (req_type) {
> -	case HZIP_ALG_TYPE_ZLIB:
> -		return TO_HEAD_SIZE(HZIP_ALG_TYPE_ZLIB);
> -	case HZIP_ALG_TYPE_GZIP:
> -		return TO_HEAD_SIZE(HZIP_ALG_TYPE_GZIP);
> -	default:
> -		pr_err("request type does not support!\n");
> -		return -EINVAL;
> -	}
> -}
> -
> -static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
> -						struct hisi_zip_qp_ctx *qp_ctx,
> -						size_t head_size, bool is_comp)
> -{
> -	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
> -	struct hisi_zip_req *q = req_q->q;
> -	struct hisi_zip_req *req_cache;
> -	int req_id;
> -
> -	write_lock(&req_q->req_lock);
> -
> -	req_id = find_first_zero_bit(req_q->req_bitmap, req_q->size);
> -	if (req_id >= req_q->size) {
> -		write_unlock(&req_q->req_lock);
> -		dev_dbg(&qp_ctx->qp->qm->pdev->dev, "req cache is full!\n");
> -		return ERR_PTR(-EAGAIN);
> -	}
> -	set_bit(req_id, req_q->req_bitmap);
> -
> -	write_unlock(&req_q->req_lock);
> -
> -	req_cache = q + req_id;
> -	req_cache->req_id = req_id;
> -	req_cache->req = req;
> -
> -	if (is_comp) {
> -		req_cache->sskip = 0;
> -		req_cache->dskip = head_size;
> -	} else {
> -		req_cache->sskip = head_size;
> -		req_cache->dskip = 0;
> -	}
> -
> -	return req_cache;
> -}
> -
> -static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
> -				struct hisi_zip_req *req)
> -{
> -	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
> -
> -	write_lock(&req_q->req_lock);
> -	clear_bit(req->req_id, req_q->req_bitmap);
> -	write_unlock(&req_q->req_lock);
> -}
> -
> -static void hisi_zip_fill_addr(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
> -{
> -	sqe->source_addr_l = lower_32_bits(req->dma_src);
> -	sqe->source_addr_h = upper_32_bits(req->dma_src);
> -	sqe->dest_addr_l = lower_32_bits(req->dma_dst);
> -	sqe->dest_addr_h = upper_32_bits(req->dma_dst);
> -}
> -
> -static void hisi_zip_fill_buf_size(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
> -{
> -	struct acomp_req *a_req = req->req;
> -
> -	sqe->input_data_length = a_req->slen - req->sskip;
> -	sqe->dest_avail_out = a_req->dlen - req->dskip;
> -	sqe->dw7 = FIELD_PREP(HZIP_IN_SGE_DATA_OFFSET_M, req->sskip);
> -	sqe->dw8 = FIELD_PREP(HZIP_OUT_SGE_DATA_OFFSET_M, req->dskip);
> -}
> -
> -static void hisi_zip_fill_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
> -{
> -	u32 val;
> -
> -	val = sqe->dw9 & ~HZIP_BUF_TYPE_M;
> -	val |= FIELD_PREP(HZIP_BUF_TYPE_M, buf_type);
> -	sqe->dw9 = val;
> -}
> -
> -static void hisi_zip_fill_req_type(struct hisi_zip_sqe *sqe, u8 req_type)
> -{
> -	u32 val;
> -
> -	val = sqe->dw9 & ~HZIP_REQ_TYPE_M;
> -	val |= FIELD_PREP(HZIP_REQ_TYPE_M, req_type);
> -	sqe->dw9 = val;
> -}
> -
> -static void hisi_zip_fill_tag_v1(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
> -{
> -	sqe->dw13 = req->req_id;
> -}
> -
> -static void hisi_zip_fill_tag_v2(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
> -{
> -	sqe->dw26 = req->req_id;
> -}
> -
> -static void hisi_zip_fill_sqe_type(struct hisi_zip_sqe *sqe, u8 sqe_type)
> -{
> -	u32 val;
> -
> -	val = sqe->dw7 & ~HZIP_SQE_TYPE_M;
> -	val |= FIELD_PREP(HZIP_SQE_TYPE_M, sqe_type);
> -	sqe->dw7 = val;
> -}
> -
> -static void hisi_zip_fill_sqe(struct hisi_zip_ctx *ctx, struct hisi_zip_sqe *sqe,
> -			      u8 req_type, struct hisi_zip_req *req)
> -{
> -	const struct hisi_zip_sqe_ops *ops = ctx->ops;
> -
> -	memset(sqe, 0, sizeof(struct hisi_zip_sqe));
> -
> -	ops->fill_addr(sqe, req);
> -	ops->fill_buf_size(sqe, req);
> -	ops->fill_buf_type(sqe, HZIP_SGL);
> -	ops->fill_req_type(sqe, req_type);
> -	ops->fill_tag(sqe, req);
> -	ops->fill_sqe_type(sqe, ops->sqe_type);
> -}
> -
> -static int hisi_zip_do_work(struct hisi_zip_req *req,
> -			    struct hisi_zip_qp_ctx *qp_ctx)
> -{
> -	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
> -	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
> -	struct acomp_req *a_req = req->req;
> -	struct hisi_qp *qp = qp_ctx->qp;
> -	struct device *dev = &qp->qm->pdev->dev;
> -	struct hisi_zip_sqe zip_sqe;
> -	int ret;
> -
> -	if (unlikely(!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen))
> -		return -EINVAL;
> -
> -	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
> -						    req->req_id << 1, &req->dma_src);
> -	if (IS_ERR(req->hw_src)) {
> -		dev_err(dev, "failed to map the src buffer to hw sgl (%ld)!\n",
> -			PTR_ERR(req->hw_src));
> -		return PTR_ERR(req->hw_src);
> -	}
> -
> -	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->dst, pool,
> -						    (req->req_id << 1) + 1,
> -						    &req->dma_dst);
> -	if (IS_ERR(req->hw_dst)) {
> -		ret = PTR_ERR(req->hw_dst);
> -		dev_err(dev, "failed to map the dst buffer to hw slg (%d)!\n",
> -			ret);
> -		goto err_unmap_input;
> -	}
> -
> -	hisi_zip_fill_sqe(qp_ctx->ctx, &zip_sqe, qp->req_type, req);
> -
> -	/* send command to start a task */
> -	atomic64_inc(&dfx->send_cnt);
> -	ret = hisi_qp_send(qp, &zip_sqe);
> -	if (unlikely(ret < 0)) {
> -		atomic64_inc(&dfx->send_busy_cnt);
> -		ret = -EAGAIN;
> -		dev_dbg_ratelimited(dev, "failed to send request!\n");
> -		goto err_unmap_output;
> -	}
> -
> -	return -EINPROGRESS;
> -
> -err_unmap_output:
> -	hisi_acc_sg_buf_unmap(dev, a_req->dst, req->hw_dst);
> -err_unmap_input:
> -	hisi_acc_sg_buf_unmap(dev, a_req->src, req->hw_src);
> -	return ret;
> -}
> -
> -static u32 hisi_zip_get_tag_v1(struct hisi_zip_sqe *sqe)
> -{
> -	return sqe->dw13;
> -}
> -
> -static u32 hisi_zip_get_tag_v2(struct hisi_zip_sqe *sqe)
> -{
> -	return sqe->dw26;
> -}
> -
> -static u32 hisi_zip_get_status(struct hisi_zip_sqe *sqe)
> -{
> -	return sqe->dw3 & HZIP_BD_STATUS_M;
> -}
> -
> -static u32 hisi_zip_get_dstlen(struct hisi_zip_sqe *sqe)
> -{
> -	return sqe->produced;
> -}
> -
> -static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
> -{
> -	struct hisi_zip_qp_ctx *qp_ctx = qp->qp_ctx;
> -	const struct hisi_zip_sqe_ops *ops = qp_ctx->ctx->ops;
> -	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
> -	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
> -	struct device *dev = &qp->qm->pdev->dev;
> -	struct hisi_zip_sqe *sqe = data;
> -	u32 tag = ops->get_tag(sqe);
> -	struct hisi_zip_req *req = req_q->q + tag;
> -	struct acomp_req *acomp_req = req->req;
> -	u32 status, dlen, head_size;
> -	int err = 0;
> -
> -	atomic64_inc(&dfx->recv_cnt);
> -	status = ops->get_status(sqe);
> -	if (unlikely(status != 0 && status != HZIP_NC_ERR)) {
> -		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
> -			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
> -			sqe->produced);
> -		atomic64_inc(&dfx->err_bd_cnt);
> -		err = -EIO;
> -	}
> -
> -	dlen = ops->get_dstlen(sqe);
> -
> -	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
> -	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
> -
> -	head_size = (qp->alg_type == 0) ? TO_HEAD_SIZE(qp->req_type) : 0;
> -	acomp_req->dlen = dlen + head_size;
> -
> -	if (acomp_req->base.complete)
> -		acomp_request_complete(acomp_req, err);
> -
> -	hisi_zip_remove_req(qp_ctx, req);
> -}
> -
> -static int hisi_zip_acompress(struct acomp_req *acomp_req)
> -{
> -	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
> -	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_COMP];
> -	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
> -	struct hisi_zip_req *req;
> -	int head_size;
> -	int ret;
> -
> -	/* let's output compression head now */
> -	head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
> -	if (unlikely(head_size < 0)) {
> -		dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
> -				    head_size);
> -		return head_size;
> -	}
> -
> -	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
> -	if (IS_ERR(req))
> -		return PTR_ERR(req);
> -
> -	ret = hisi_zip_do_work(req, qp_ctx);
> -	if (unlikely(ret != -EINPROGRESS)) {
> -		dev_info_ratelimited(dev, "failed to do compress (%d)!\n", ret);
> -		hisi_zip_remove_req(qp_ctx, req);
> -	}
> -
> -	return ret;
> -}
> -
> -static int hisi_zip_adecompress(struct acomp_req *acomp_req)
> -{
> -	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
> -	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_DECOMP];
> -	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
> -	struct hisi_zip_req *req;
> -	int head_size, ret;
> -
> -	head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
> -	if (unlikely(head_size < 0)) {
> -		dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
> -				    head_size);
> -		return head_size;
> -	}
> -
> -	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, false);
> -	if (IS_ERR(req))
> -		return PTR_ERR(req);
> -
> -	ret = hisi_zip_do_work(req, qp_ctx);
> -	if (unlikely(ret != -EINPROGRESS)) {
> -		dev_info_ratelimited(dev, "failed to do decompress (%d)!\n",
> -				     ret);
> -		hisi_zip_remove_req(qp_ctx, req);
> -	}
> -
> -	return ret;
> -}
> -
> -static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *qp_ctx,
> -			     int alg_type, int req_type)
> -{
> -	struct device *dev = &qp->qm->pdev->dev;
> -	int ret;
> -
> -	qp->req_type = req_type;
> -	qp->alg_type = alg_type;
> -	qp->qp_ctx = qp_ctx;
> -
> -	ret = hisi_qm_start_qp(qp, 0);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to start qp (%d)!\n", ret);
> -		return ret;
> -	}
> -
> -	qp_ctx->qp = qp;
> -
> -	return 0;
> -}
> -
> -static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *qp_ctx)
> -{
> -	hisi_qm_stop_qp(qp_ctx->qp);
> -	hisi_qm_free_qps(&qp_ctx->qp, 1);
> -}
> -
> -static const struct hisi_zip_sqe_ops hisi_zip_ops_v1 = {
> -	.sqe_type		= 0,
> -	.fill_addr		= hisi_zip_fill_addr,
> -	.fill_buf_size		= hisi_zip_fill_buf_size,
> -	.fill_buf_type		= hisi_zip_fill_buf_type,
> -	.fill_req_type		= hisi_zip_fill_req_type,
> -	.fill_tag		= hisi_zip_fill_tag_v1,
> -	.fill_sqe_type		= hisi_zip_fill_sqe_type,
> -	.get_tag		= hisi_zip_get_tag_v1,
> -	.get_status		= hisi_zip_get_status,
> -	.get_dstlen		= hisi_zip_get_dstlen,
> -};
> -
> -static const struct hisi_zip_sqe_ops hisi_zip_ops_v2 = {
> -	.sqe_type		= 0x3,
> -	.fill_addr		= hisi_zip_fill_addr,
> -	.fill_buf_size		= hisi_zip_fill_buf_size,
> -	.fill_buf_type		= hisi_zip_fill_buf_type,
> -	.fill_req_type		= hisi_zip_fill_req_type,
> -	.fill_tag		= hisi_zip_fill_tag_v2,
> -	.fill_sqe_type		= hisi_zip_fill_sqe_type,
> -	.get_tag		= hisi_zip_get_tag_v2,
> -	.get_status		= hisi_zip_get_status,
> -	.get_dstlen		= hisi_zip_get_dstlen,
> -};
> -
> -static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type, int node)
> -{
> -	struct hisi_qp *qps[HZIP_CTX_Q_NUM] = { NULL };
> -	struct hisi_zip_qp_ctx *qp_ctx;
> -	struct hisi_zip *hisi_zip;
> -	int ret, i, j;
> -
> -	ret = zip_create_qps(qps, HZIP_CTX_Q_NUM, node);
> -	if (ret) {
> -		pr_err("failed to create zip qps (%d)!\n", ret);
> -		return -ENODEV;
> -	}
> -
> -	hisi_zip = container_of(qps[0]->qm, struct hisi_zip, qm);
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
> -		/* alg_type = 0 for compress, 1 for decompress in hw sqe */
> -		qp_ctx = &hisi_zip_ctx->qp_ctx[i];
> -		qp_ctx->ctx = hisi_zip_ctx;
> -		ret = hisi_zip_start_qp(qps[i], qp_ctx, i, req_type);
> -		if (ret) {
> -			for (j = i - 1; j >= 0; j--)
> -				hisi_qm_stop_qp(hisi_zip_ctx->qp_ctx[j].qp);
> -
> -			hisi_qm_free_qps(qps, HZIP_CTX_Q_NUM);
> -			return ret;
> -		}
> -
> -		qp_ctx->zip_dev = hisi_zip;
> -	}
> -
> -	if (hisi_zip->qm.ver < QM_HW_V3)
> -		hisi_zip_ctx->ops = &hisi_zip_ops_v1;
> -	else
> -		hisi_zip_ctx->ops = &hisi_zip_ops_v2;
> -
> -	return 0;
> -}
> -
> -static void hisi_zip_ctx_exit(struct hisi_zip_ctx *hisi_zip_ctx)
> -{
> -	int i;
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
> -		hisi_zip_release_qp(&hisi_zip_ctx->qp_ctx[i]);
> -}
> -
> -static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
> -{
> -	u16 q_depth = ctx->qp_ctx[0].qp->sq_depth;
> -	struct hisi_zip_req_q *req_q;
> -	int i, ret;
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
> -		req_q = &ctx->qp_ctx[i].req_q;
> -		req_q->size = q_depth;
> -
> -		req_q->req_bitmap = bitmap_zalloc(req_q->size, GFP_KERNEL);
> -		if (!req_q->req_bitmap) {
> -			ret = -ENOMEM;
> -			if (i == 0)
> -				return ret;
> -
> -			goto err_free_comp_q;
> -		}
> -		rwlock_init(&req_q->req_lock);
> -
> -		req_q->q = kcalloc(req_q->size, sizeof(struct hisi_zip_req),
> -				   GFP_KERNEL);
> -		if (!req_q->q) {
> -			ret = -ENOMEM;
> -			if (i == 0)
> -				goto err_free_comp_bitmap;
> -			else
> -				goto err_free_decomp_bitmap;
> -		}
> -	}
> -
> -	return 0;
> -
> -err_free_decomp_bitmap:
> -	bitmap_free(ctx->qp_ctx[HZIP_QPC_DECOMP].req_q.req_bitmap);
> -err_free_comp_q:
> -	kfree(ctx->qp_ctx[HZIP_QPC_COMP].req_q.q);
> -err_free_comp_bitmap:
> -	bitmap_free(ctx->qp_ctx[HZIP_QPC_COMP].req_q.req_bitmap);
> -	return ret;
> -}
> -
> -static void hisi_zip_release_req_q(struct hisi_zip_ctx *ctx)
> -{
> -	int i;
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
> -		kfree(ctx->qp_ctx[i].req_q.q);
> -		bitmap_free(ctx->qp_ctx[i].req_q.req_bitmap);
> -	}
> -}
> -
> -static int hisi_zip_create_sgl_pool(struct hisi_zip_ctx *ctx)
> -{
> -	u16 q_depth = ctx->qp_ctx[0].qp->sq_depth;
> -	struct hisi_zip_qp_ctx *tmp;
> -	struct device *dev;
> -	int i;
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
> -		tmp = &ctx->qp_ctx[i];
> -		dev = &tmp->qp->qm->pdev->dev;
> -		tmp->sgl_pool = hisi_acc_create_sgl_pool(dev, q_depth << 1,
> -							 sgl_sge_nr);
> -		if (IS_ERR(tmp->sgl_pool)) {
> -			if (i == 1)
> -				goto err_free_sgl_pool0;
> -			return -ENOMEM;
> -		}
> -	}
> -
> -	return 0;
> -
> -err_free_sgl_pool0:
> -	hisi_acc_free_sgl_pool(&ctx->qp_ctx[HZIP_QPC_COMP].qp->qm->pdev->dev,
> -			       ctx->qp_ctx[HZIP_QPC_COMP].sgl_pool);
> -	return -ENOMEM;
> -}
> -
> -static void hisi_zip_release_sgl_pool(struct hisi_zip_ctx *ctx)
> -{
> -	int i;
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
> -		hisi_acc_free_sgl_pool(&ctx->qp_ctx[i].qp->qm->pdev->dev,
> -				       ctx->qp_ctx[i].sgl_pool);
> -}
> -
> -static void hisi_zip_set_acomp_cb(struct hisi_zip_ctx *ctx,
> -				  void (*fn)(struct hisi_qp *, void *))
> -{
> -	int i;
> -
> -	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
> -		ctx->qp_ctx[i].qp->req_cb = fn;
> -}
> -
> -static int hisi_zip_acomp_init(struct crypto_acomp *tfm)
> -{
> -	const char *alg_name = crypto_tfm_alg_name(&tfm->base);
> -	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(&tfm->base);
> -	struct device *dev;
> -	int ret;
> -
> -	ret = hisi_zip_ctx_init(ctx, COMP_NAME_TO_TYPE(alg_name), tfm->base.node);
> -	if (ret) {
> -		pr_err("failed to init ctx (%d)!\n", ret);
> -		return ret;
> -	}
> -
> -	dev = &ctx->qp_ctx[0].qp->qm->pdev->dev;
> -
> -	ret = hisi_zip_create_req_q(ctx);
> -	if (ret) {
> -		dev_err(dev, "failed to create request queue (%d)!\n", ret);
> -		goto err_ctx_exit;
> -	}
> -
> -	ret = hisi_zip_create_sgl_pool(ctx);
> -	if (ret) {
> -		dev_err(dev, "failed to create sgl pool (%d)!\n", ret);
> -		goto err_release_req_q;
> -	}
> -
> -	hisi_zip_set_acomp_cb(ctx, hisi_zip_acomp_cb);
> -
> -	return 0;
> -
> -err_release_req_q:
> -	hisi_zip_release_req_q(ctx);
> -err_ctx_exit:
> -	hisi_zip_ctx_exit(ctx);
> -	return ret;
> -}
> -
> -static void hisi_zip_acomp_exit(struct crypto_acomp *tfm)
> -{
> -	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(&tfm->base);
> -
> -	hisi_zip_set_acomp_cb(ctx, NULL);
> -	hisi_zip_release_sgl_pool(ctx);
> -	hisi_zip_release_req_q(ctx);
> -	hisi_zip_ctx_exit(ctx);
> -}
> -
> -static struct acomp_alg hisi_zip_acomp_zlib = {
> -	.init			= hisi_zip_acomp_init,
> -	.exit			= hisi_zip_acomp_exit,
> -	.compress		= hisi_zip_acompress,
> -	.decompress		= hisi_zip_adecompress,
> -	.base			= {
> -		.cra_name		= "zlib-deflate",
> -		.cra_driver_name	= "hisi-zlib-acomp",
> -		.cra_module		= THIS_MODULE,
> -		.cra_priority           = HZIP_ALG_PRIORITY,
> -		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
> -	}
> -};
> -
> -static int hisi_zip_register_zlib(struct hisi_qm *qm)
> -{
> -	int ret;
> -
> -	if (!hisi_zip_alg_support(qm, HZIP_ALG_ZLIB))
> -		return 0;
> -
> -	ret = crypto_register_acomp(&hisi_zip_acomp_zlib);
> -	if (ret)
> -		dev_err(&qm->pdev->dev, "failed to register to zlib (%d)!\n", ret);
> -
> -	return ret;
> -}
> -
> -static void hisi_zip_unregister_zlib(struct hisi_qm *qm)
> -{
> -	if (!hisi_zip_alg_support(qm, HZIP_ALG_ZLIB))
> -		return;
> -
> -	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
> -}
> -
> -static struct acomp_alg hisi_zip_acomp_gzip = {
> -	.init			= hisi_zip_acomp_init,
> -	.exit			= hisi_zip_acomp_exit,
> -	.compress		= hisi_zip_acompress,
> -	.decompress		= hisi_zip_adecompress,
> -	.base			= {
> -		.cra_name		= "gzip",
> -		.cra_driver_name	= "hisi-gzip-acomp",
> -		.cra_module		= THIS_MODULE,
> -		.cra_priority           = HZIP_ALG_PRIORITY,
> -		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
> -	}
> -};
> -
> -static int hisi_zip_register_gzip(struct hisi_qm *qm)
> -{
> -	int ret;
> -
> -	if (!hisi_zip_alg_support(qm, HZIP_ALG_GZIP))
> -		return 0;
> -
> -	ret = crypto_register_acomp(&hisi_zip_acomp_gzip);
> -	if (ret)
> -		dev_err(&qm->pdev->dev, "failed to register to gzip (%d)!\n", ret);
> -
> -	return ret;
> -}
> -
> -static void hisi_zip_unregister_gzip(struct hisi_qm *qm)
> -{
> -	if (!hisi_zip_alg_support(qm, HZIP_ALG_GZIP))
> -		return;
> -
> -	crypto_unregister_acomp(&hisi_zip_acomp_gzip);
> -}
> -
> -int hisi_zip_register_to_crypto(struct hisi_qm *qm)
> -{
> -	int ret = 0;
> -
> -	ret = hisi_zip_register_zlib(qm);
> -	if (ret)
> -		return ret;
> -
> -	ret = hisi_zip_register_gzip(qm);
> -	if (ret)
> -		hisi_zip_unregister_zlib(qm);
> -
> -	return ret;
> -}
> -
> -void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
> -{
> -	hisi_zip_unregister_zlib(qm);
> -	hisi_zip_unregister_gzip(qm);
> -}
> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
> deleted file mode 100644
> index f3ce34198775..000000000000
> --- a/drivers/crypto/hisilicon/zip/zip_main.c
> +++ /dev/null
> @@ -1,1357 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2019 HiSilicon Limited. */
> -#include <linux/acpi.h>
> -#include <linux/bitops.h>
> -#include <linux/debugfs.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/seq_file.h>
> -#include <linux/topology.h>
> -#include <linux/uacce.h>
> -#include "zip.h"
> -
> -#define PCI_DEVICE_ID_HUAWEI_ZIP_PF	0xa250
> -
> -#define HZIP_QUEUE_NUM_V1		4096
> -
> -#define HZIP_CLOCK_GATE_CTRL		0x301004
> -#define HZIP_DECOMP_CHECK_ENABLE	BIT(16)
> -#define HZIP_FSM_MAX_CNT		0x301008
> -
> -#define HZIP_PORT_ARCA_CHE_0		0x301040
> -#define HZIP_PORT_ARCA_CHE_1		0x301044
> -#define HZIP_PORT_AWCA_CHE_0		0x301060
> -#define HZIP_PORT_AWCA_CHE_1		0x301064
> -#define HZIP_CACHE_ALL_EN		0xffffffff
> -
> -#define HZIP_BD_RUSER_32_63		0x301110
> -#define HZIP_SGL_RUSER_32_63		0x30111c
> -#define HZIP_DATA_RUSER_32_63		0x301128
> -#define HZIP_DATA_WUSER_32_63		0x301134
> -#define HZIP_BD_WUSER_32_63		0x301140
> -
> -#define HZIP_QM_IDEL_STATUS		0x3040e4
> -
> -#define HZIP_CORE_DFX_BASE		0x301000
> -#define HZIP_CLOCK_GATED_CONTL		0X301004
> -#define HZIP_CORE_DFX_COMP_0		0x302000
> -#define HZIP_CORE_DFX_COMP_1		0x303000
> -#define HZIP_CORE_DFX_DECOMP_0		0x304000
> -#define HZIP_CORE_DFX_DECOMP_1		0x305000
> -#define HZIP_CORE_DFX_DECOMP_2		0x306000
> -#define HZIP_CORE_DFX_DECOMP_3		0x307000
> -#define HZIP_CORE_DFX_DECOMP_4		0x308000
> -#define HZIP_CORE_DFX_DECOMP_5		0x309000
> -#define HZIP_CORE_REGS_BASE_LEN		0xB0
> -#define HZIP_CORE_REGS_DFX_LEN		0x28
> -
> -#define HZIP_CORE_INT_SOURCE		0x3010A0
> -#define HZIP_CORE_INT_MASK_REG		0x3010A4
> -#define HZIP_CORE_INT_SET		0x3010A8
> -#define HZIP_CORE_INT_STATUS		0x3010AC
> -#define HZIP_CORE_INT_STATUS_M_ECC	BIT(1)
> -#define HZIP_CORE_SRAM_ECC_ERR_INFO	0x301148
> -#define HZIP_CORE_INT_RAS_CE_ENB	0x301160
> -#define HZIP_CORE_INT_RAS_NFE_ENB	0x301164
> -#define HZIP_CORE_INT_RAS_FE_ENB        0x301168
> -#define HZIP_CORE_INT_RAS_FE_ENB_MASK	0x0
> -#define HZIP_OOO_SHUTDOWN_SEL		0x30120C
> -#define HZIP_SRAM_ECC_ERR_NUM_SHIFT	16
> -#define HZIP_SRAM_ECC_ERR_ADDR_SHIFT	24
> -#define HZIP_CORE_INT_MASK_ALL		GENMASK(12, 0)
> -#define HZIP_SQE_SIZE			128
> -#define HZIP_PF_DEF_Q_NUM		64
> -#define HZIP_PF_DEF_Q_BASE		0
> -
> -#define HZIP_SOFT_CTRL_CNT_CLR_CE	0x301000
> -#define HZIP_SOFT_CTRL_CNT_CLR_CE_BIT	BIT(0)
> -#define HZIP_SOFT_CTRL_ZIP_CONTROL	0x30100C
> -#define HZIP_AXI_SHUTDOWN_ENABLE	BIT(14)
> -#define HZIP_WR_PORT			BIT(11)
> -
> -#define HZIP_DEV_ALG_MAX_LEN		256
> -#define HZIP_ALG_ZLIB_BIT		GENMASK(1, 0)
> -#define HZIP_ALG_GZIP_BIT		GENMASK(3, 2)
> -#define HZIP_ALG_DEFLATE_BIT		GENMASK(5, 4)
> -#define HZIP_ALG_LZ77_BIT		GENMASK(7, 6)
> -
> -#define HZIP_BUF_SIZE			22
> -#define HZIP_SQE_MASK_OFFSET		64
> -#define HZIP_SQE_MASK_LEN		48
> -
> -#define HZIP_CNT_CLR_CE_EN		BIT(0)
> -#define HZIP_RO_CNT_CLR_CE_EN		BIT(2)
> -#define HZIP_RD_CNT_CLR_CE_EN		(HZIP_CNT_CLR_CE_EN | \
> -					 HZIP_RO_CNT_CLR_CE_EN)
> -
> -#define HZIP_PREFETCH_CFG		0x3011B0
> -#define HZIP_SVA_TRANS			0x3011C4
> -#define HZIP_PREFETCH_ENABLE		(~(BIT(26) | BIT(17) | BIT(0)))
> -#define HZIP_SVA_PREFETCH_DISABLE	BIT(26)
> -#define HZIP_SVA_DISABLE_READY		(BIT(26) | BIT(30))
> -#define HZIP_SHAPER_RATE_COMPRESS	750
> -#define HZIP_SHAPER_RATE_DECOMPRESS	140
> -#define HZIP_DELAY_1_US		1
> -#define HZIP_POLL_TIMEOUT_US	1000
> -
> -/* clock gating */
> -#define HZIP_PEH_CFG_AUTO_GATE		0x3011A8
> -#define HZIP_PEH_CFG_AUTO_GATE_EN	BIT(0)
> -#define HZIP_CORE_GATED_EN		GENMASK(15, 8)
> -#define HZIP_CORE_GATED_OOO_EN		BIT(29)
> -#define HZIP_CLOCK_GATED_EN		(HZIP_CORE_GATED_EN | \
> -					 HZIP_CORE_GATED_OOO_EN)
> -
> -static const char hisi_zip_name[] = "hisi_zip";
> -static struct dentry *hzip_debugfs_root;
> -
> -struct hisi_zip_hw_error {
> -	u32 int_msk;
> -	const char *msg;
> -};
> -
> -struct zip_dfx_item {
> -	const char *name;
> -	u32 offset;
> -};
> -
> -struct zip_dev_alg {
> -	u32 alg_msk;
> -	const char *algs;
> -};
> -
> -static const struct zip_dev_alg zip_dev_algs[] = { {
> -		.alg_msk = HZIP_ALG_ZLIB_BIT,
> -		.algs = "zlib\n",
> -	}, {
> -		.alg_msk = HZIP_ALG_GZIP_BIT,
> -		.algs = "gzip\n",
> -	}, {
> -		.alg_msk = HZIP_ALG_DEFLATE_BIT,
> -		.algs = "deflate\n",
> -	}, {
> -		.alg_msk = HZIP_ALG_LZ77_BIT,
> -		.algs = "lz77_zstd\n",
> -	},
> -};
> -
> -static struct hisi_qm_list zip_devices = {
> -	.register_to_crypto	= hisi_zip_register_to_crypto,
> -	.unregister_from_crypto	= hisi_zip_unregister_from_crypto,
> -};
> -
> -static struct zip_dfx_item zip_dfx_files[] = {
> -	{"send_cnt", offsetof(struct hisi_zip_dfx, send_cnt)},
> -	{"recv_cnt", offsetof(struct hisi_zip_dfx, recv_cnt)},
> -	{"send_busy_cnt", offsetof(struct hisi_zip_dfx, send_busy_cnt)},
> -	{"err_bd_cnt", offsetof(struct hisi_zip_dfx, err_bd_cnt)},
> -};
> -
> -static const struct hisi_zip_hw_error zip_hw_error[] = {
> -	{ .int_msk = BIT(0), .msg = "zip_ecc_1bitt_err" },
> -	{ .int_msk = BIT(1), .msg = "zip_ecc_2bit_err" },
> -	{ .int_msk = BIT(2), .msg = "zip_axi_rresp_err" },
> -	{ .int_msk = BIT(3), .msg = "zip_axi_bresp_err" },
> -	{ .int_msk = BIT(4), .msg = "zip_src_addr_parse_err" },
> -	{ .int_msk = BIT(5), .msg = "zip_dst_addr_parse_err" },
> -	{ .int_msk = BIT(6), .msg = "zip_pre_in_addr_err" },
> -	{ .int_msk = BIT(7), .msg = "zip_pre_in_data_err" },
> -	{ .int_msk = BIT(8), .msg = "zip_com_inf_err" },
> -	{ .int_msk = BIT(9), .msg = "zip_enc_inf_err" },
> -	{ .int_msk = BIT(10), .msg = "zip_pre_out_err" },
> -	{ .int_msk = BIT(11), .msg = "zip_axi_poison_err" },
> -	{ .int_msk = BIT(12), .msg = "zip_sva_err" },
> -	{ /* sentinel */ }
> -};
> -
> -enum ctrl_debug_file_index {
> -	HZIP_CLEAR_ENABLE,
> -	HZIP_DEBUG_FILE_NUM,
> -};
> -
> -static const char * const ctrl_debug_file_name[] = {
> -	[HZIP_CLEAR_ENABLE] = "clear_enable",
> -};
> -
> -struct ctrl_debug_file {
> -	enum ctrl_debug_file_index index;
> -	spinlock_t lock;
> -	struct hisi_zip_ctrl *ctrl;
> -};
> -
> -/*
> - * One ZIP controller has one PF and multiple VFs, some global configurations
> - * which PF has need this structure.
> - *
> - * Just relevant for PF.
> - */
> -struct hisi_zip_ctrl {
> -	struct hisi_zip *hisi_zip;
> -	struct ctrl_debug_file files[HZIP_DEBUG_FILE_NUM];
> -};
> -
> -enum zip_cap_type {
> -	ZIP_QM_NFE_MASK_CAP = 0x0,
> -	ZIP_QM_RESET_MASK_CAP,
> -	ZIP_QM_OOO_SHUTDOWN_MASK_CAP,
> -	ZIP_QM_CE_MASK_CAP,
> -	ZIP_NFE_MASK_CAP,
> -	ZIP_RESET_MASK_CAP,
> -	ZIP_OOO_SHUTDOWN_MASK_CAP,
> -	ZIP_CE_MASK_CAP,
> -	ZIP_CLUSTER_NUM_CAP,
> -	ZIP_CORE_TYPE_NUM_CAP,
> -	ZIP_CORE_NUM_CAP,
> -	ZIP_CLUSTER_COMP_NUM_CAP,
> -	ZIP_CLUSTER_DECOMP_NUM_CAP,
> -	ZIP_DECOMP_ENABLE_BITMAP,
> -	ZIP_COMP_ENABLE_BITMAP,
> -	ZIP_DRV_ALG_BITMAP,
> -	ZIP_DEV_ALG_BITMAP,
> -	ZIP_CORE1_ALG_BITMAP,
> -	ZIP_CORE2_ALG_BITMAP,
> -	ZIP_CORE3_ALG_BITMAP,
> -	ZIP_CORE4_ALG_BITMAP,
> -	ZIP_CORE5_ALG_BITMAP,
> -	ZIP_CAP_MAX
> -};
> -
> -static struct hisi_qm_cap_info zip_basic_cap_info[] = {
> -	{ZIP_QM_NFE_MASK_CAP, 0x3124, 0, GENMASK(31, 0), 0x0, 0x1C57, 0x7C77},
> -	{ZIP_QM_RESET_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0xC57, 0x6C77},
> -	{ZIP_QM_OOO_SHUTDOWN_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0x4, 0x6C77},
> -	{ZIP_QM_CE_MASK_CAP, 0x312C, 0, GENMASK(31, 0), 0x0, 0x8, 0x8},
> -	{ZIP_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x7FE, 0x1FFE},
> -	{ZIP_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x7FE, 0x7FE},
> -	{ZIP_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x2, 0x7FE},
> -	{ZIP_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
> -	{ZIP_CLUSTER_NUM_CAP, 0x313C, 28, GENMASK(3, 0), 0x1, 0x1, 0x1},
> -	{ZIP_CORE_TYPE_NUM_CAP, 0x313C, 24, GENMASK(3, 0), 0x2, 0x2, 0x2},
> -	{ZIP_CORE_NUM_CAP, 0x313C, 16, GENMASK(7, 0), 0x8, 0x8, 0x5},
> -	{ZIP_CLUSTER_COMP_NUM_CAP, 0x313C, 8, GENMASK(7, 0), 0x2, 0x2, 0x2},
> -	{ZIP_CLUSTER_DECOMP_NUM_CAP, 0x313C, 0, GENMASK(7, 0), 0x6, 0x6, 0x3},
> -	{ZIP_DECOMP_ENABLE_BITMAP, 0x3140, 16, GENMASK(15, 0), 0xFC, 0xFC, 0x1C},
> -	{ZIP_COMP_ENABLE_BITMAP, 0x3140, 0, GENMASK(15, 0), 0x3, 0x3, 0x3},
> -	{ZIP_DRV_ALG_BITMAP, 0x3144, 0, GENMASK(31, 0), 0xF, 0xF, 0xF},
> -	{ZIP_DEV_ALG_BITMAP, 0x3148, 0, GENMASK(31, 0), 0xF, 0xF, 0xFF},
> -	{ZIP_CORE1_ALG_BITMAP, 0x314C, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
> -	{ZIP_CORE2_ALG_BITMAP, 0x3150, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
> -	{ZIP_CORE3_ALG_BITMAP, 0x3154, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
> -	{ZIP_CORE4_ALG_BITMAP, 0x3158, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
> -	{ZIP_CORE5_ALG_BITMAP, 0x315C, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
> -	{ZIP_CAP_MAX, 0x317c, 0, GENMASK(0, 0), 0x0, 0x0, 0x0}
> -};
> -
> -enum {
> -	HZIP_COMP_CORE0,
> -	HZIP_COMP_CORE1,
> -	HZIP_DECOMP_CORE0,
> -	HZIP_DECOMP_CORE1,
> -	HZIP_DECOMP_CORE2,
> -	HZIP_DECOMP_CORE3,
> -	HZIP_DECOMP_CORE4,
> -	HZIP_DECOMP_CORE5,
> -};
> -
> -static const u64 core_offsets[] = {
> -	[HZIP_COMP_CORE0]   = 0x302000,
> -	[HZIP_COMP_CORE1]   = 0x303000,
> -	[HZIP_DECOMP_CORE0] = 0x304000,
> -	[HZIP_DECOMP_CORE1] = 0x305000,
> -	[HZIP_DECOMP_CORE2] = 0x306000,
> -	[HZIP_DECOMP_CORE3] = 0x307000,
> -	[HZIP_DECOMP_CORE4] = 0x308000,
> -	[HZIP_DECOMP_CORE5] = 0x309000,
> -};
> -
> -static const struct debugfs_reg32 hzip_dfx_regs[] = {
> -	{"HZIP_GET_BD_NUM                ",  0x00ull},
> -	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
> -	{"HZIP_GET_ERROR_BD              ",  0x08ull},
> -	{"HZIP_DONE_BD_NUM               ",  0x0cull},
> -	{"HZIP_WORK_CYCLE                ",  0x10ull},
> -	{"HZIP_IDLE_CYCLE                ",  0x18ull},
> -	{"HZIP_MAX_DELAY                 ",  0x20ull},
> -	{"HZIP_MIN_DELAY                 ",  0x24ull},
> -	{"HZIP_AVG_DELAY                 ",  0x28ull},
> -	{"HZIP_MEM_VISIBLE_DATA          ",  0x30ull},
> -	{"HZIP_MEM_VISIBLE_ADDR          ",  0x34ull},
> -	{"HZIP_CONSUMED_BYTE             ",  0x38ull},
> -	{"HZIP_PRODUCED_BYTE             ",  0x40ull},
> -	{"HZIP_COMP_INF                  ",  0x70ull},
> -	{"HZIP_PRE_OUT                   ",  0x78ull},
> -	{"HZIP_BD_RD                     ",  0x7cull},
> -	{"HZIP_BD_WR                     ",  0x80ull},
> -	{"HZIP_GET_BD_AXI_ERR_NUM        ",  0x84ull},
> -	{"HZIP_GET_BD_PARSE_ERR_NUM      ",  0x88ull},
> -	{"HZIP_ADD_BD_AXI_ERR_NUM        ",  0x8cull},
> -	{"HZIP_DECOMP_STF_RELOAD_CURR_ST ",  0x94ull},
> -	{"HZIP_DECOMP_LZ77_CURR_ST       ",  0x9cull},
> -};
> -
> -static const struct debugfs_reg32 hzip_com_dfx_regs[] = {
> -	{"HZIP_CLOCK_GATE_CTRL           ",  0x301004},
> -	{"HZIP_CORE_INT_RAS_CE_ENB       ",  0x301160},
> -	{"HZIP_CORE_INT_RAS_NFE_ENB      ",  0x301164},
> -	{"HZIP_CORE_INT_RAS_FE_ENB       ",  0x301168},
> -	{"HZIP_UNCOM_ERR_RAS_CTRL        ",  0x30116C},
> -};
> -
> -static const struct debugfs_reg32 hzip_dump_dfx_regs[] = {
> -	{"HZIP_GET_BD_NUM                ",  0x00ull},
> -	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
> -	{"HZIP_GET_ERROR_BD              ",  0x08ull},
> -	{"HZIP_DONE_BD_NUM               ",  0x0cull},
> -	{"HZIP_MAX_DELAY                 ",  0x20ull},
> -};
> -
> -/* define the ZIP's dfx regs region and region length */
> -static struct dfx_diff_registers hzip_diff_regs[] = {
> -	{
> -		.reg_offset = HZIP_CORE_DFX_BASE,
> -		.reg_len = HZIP_CORE_REGS_BASE_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_COMP_0,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_COMP_1,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_DECOMP_0,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_DECOMP_1,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_DECOMP_2,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_DECOMP_3,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_DECOMP_4,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	}, {
> -		.reg_offset = HZIP_CORE_DFX_DECOMP_5,
> -		.reg_len = HZIP_CORE_REGS_DFX_LEN,
> -	},
> -};
> -
> -static int hzip_diff_regs_show(struct seq_file *s, void *unused)
> -{
> -	struct hisi_qm *qm = s->private;
> -
> -	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.acc_diff_regs,
> -					ARRAY_SIZE(hzip_diff_regs));
> -
> -	return 0;
> -}
> -DEFINE_SHOW_ATTRIBUTE(hzip_diff_regs);
> -static const struct kernel_param_ops zip_uacce_mode_ops = {
> -	.set = uacce_mode_set,
> -	.get = param_get_int,
> -};
> -
> -/*
> - * uacce_mode = 0 means zip only register to crypto,
> - * uacce_mode = 1 means zip both register to crypto and uacce.
> - */
> -static u32 uacce_mode = UACCE_MODE_NOUACCE;
> -module_param_cb(uacce_mode, &zip_uacce_mode_ops, &uacce_mode, 0444);
> -MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
> -
> -static int pf_q_num_set(const char *val, const struct kernel_param *kp)
> -{
> -	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_ZIP_PF);
> -}
> -
> -static const struct kernel_param_ops pf_q_num_ops = {
> -	.set = pf_q_num_set,
> -	.get = param_get_int,
> -};
> -
> -static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
> -module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
> -MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 2-4096, v2 2-1024)");
> -
> -static const struct kernel_param_ops vfs_num_ops = {
> -	.set = vfs_num_set,
> -	.get = param_get_int,
> -};
> -
> -static u32 vfs_num;
> -module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
> -MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63), 0(default)");
> -
> -static const struct pci_device_id hisi_zip_dev_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_PF) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF) },
> -	{ 0, }
> -};
> -MODULE_DEVICE_TABLE(pci, hisi_zip_dev_ids);
> -
> -int zip_create_qps(struct hisi_qp **qps, int qp_num, int node)
> -{
> -	if (node == NUMA_NO_NODE)
> -		node = cpu_to_node(smp_processor_id());
> -
> -	return hisi_qm_alloc_qps_node(&zip_devices, qp_num, 0, node, qps);
> -}
> -
> -bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
> -{
> -	u32 cap_val;
> -
> -	cap_val = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_DRV_ALG_BITMAP, qm->cap_ver);
> -	if ((alg & cap_val) == alg)
> -		return true;
> -
> -	return false;
> -}
> -
> -static int hisi_zip_set_qm_algs(struct hisi_qm *qm)
> -{
> -	struct device *dev = &qm->pdev->dev;
> -	char *algs, *ptr;
> -	u32 alg_mask;
> -	int i;
> -
> -	if (!qm->use_sva)
> -		return 0;
> -
> -	algs = devm_kzalloc(dev, HZIP_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
> -	if (!algs)
> -		return -ENOMEM;
> -
> -	alg_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_DEV_ALG_BITMAP, qm->cap_ver);
> -
> -	for (i = 0; i < ARRAY_SIZE(zip_dev_algs); i++)
> -		if (alg_mask & zip_dev_algs[i].alg_msk)
> -			strcat(algs, zip_dev_algs[i].algs);
> -
> -	ptr = strrchr(algs, '\n');
> -	if (ptr)
> -		*ptr = '\0';
> -
> -	qm->uacce->algs = algs;
> -
> -	return 0;
> -}
> -
> -static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
> -{
> -	u32 val;
> -	int ret;
> -
> -	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
> -		return;
> -
> -	/* Enable prefetch */
> -	val = readl_relaxed(qm->io_base + HZIP_PREFETCH_CFG);
> -	val &= HZIP_PREFETCH_ENABLE;
> -	writel(val, qm->io_base + HZIP_PREFETCH_CFG);
> -
> -	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_PREFETCH_CFG,
> -					 val, !(val & HZIP_SVA_PREFETCH_DISABLE),
> -					 HZIP_DELAY_1_US, HZIP_POLL_TIMEOUT_US);
> -	if (ret)
> -		pci_err(qm->pdev, "failed to open sva prefetch\n");
> -}
> -
> -static void hisi_zip_close_sva_prefetch(struct hisi_qm *qm)
> -{
> -	u32 val;
> -	int ret;
> -
> -	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
> -		return;
> -
> -	val = readl_relaxed(qm->io_base + HZIP_PREFETCH_CFG);
> -	val |= HZIP_SVA_PREFETCH_DISABLE;
> -	writel(val, qm->io_base + HZIP_PREFETCH_CFG);
> -
> -	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_SVA_TRANS,
> -					 val, !(val & HZIP_SVA_DISABLE_READY),
> -					 HZIP_DELAY_1_US, HZIP_POLL_TIMEOUT_US);
> -	if (ret)
> -		pci_err(qm->pdev, "failed to close sva prefetch\n");
> -}
> -
> -static void hisi_zip_enable_clock_gate(struct hisi_qm *qm)
> -{
> -	u32 val;
> -
> -	if (qm->ver < QM_HW_V3)
> -		return;
> -
> -	val = readl(qm->io_base + HZIP_CLOCK_GATE_CTRL);
> -	val |= HZIP_CLOCK_GATED_EN;
> -	writel(val, qm->io_base + HZIP_CLOCK_GATE_CTRL);
> -
> -	val = readl(qm->io_base + HZIP_PEH_CFG_AUTO_GATE);
> -	val |= HZIP_PEH_CFG_AUTO_GATE_EN;
> -	writel(val, qm->io_base + HZIP_PEH_CFG_AUTO_GATE);
> -}
> -
> -static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
> -{
> -	void __iomem *base = qm->io_base;
> -	u32 dcomp_bm, comp_bm;
> -
> -	/* qm user domain */
> -	writel(AXUSER_BASE, base + QM_ARUSER_M_CFG_1);
> -	writel(ARUSER_M_CFG_ENABLE, base + QM_ARUSER_M_CFG_ENABLE);
> -	writel(AXUSER_BASE, base + QM_AWUSER_M_CFG_1);
> -	writel(AWUSER_M_CFG_ENABLE, base + QM_AWUSER_M_CFG_ENABLE);
> -	writel(WUSER_M_CFG_ENABLE, base + QM_WUSER_M_CFG_ENABLE);
> -
> -	/* qm cache */
> -	writel(AXI_M_CFG, base + QM_AXI_M_CFG);
> -	writel(AXI_M_CFG_ENABLE, base + QM_AXI_M_CFG_ENABLE);
> -
> -	/* disable FLR triggered by BME(bus master enable) */
> -	writel(PEH_AXUSER_CFG, base + QM_PEH_AXUSER_CFG);
> -	writel(PEH_AXUSER_CFG_ENABLE, base + QM_PEH_AXUSER_CFG_ENABLE);
> -
> -	/* cache */
> -	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_0);
> -	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_1);
> -	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_0);
> -	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_1);
> -
> -	/* user domain configurations */
> -	writel(AXUSER_BASE, base + HZIP_BD_RUSER_32_63);
> -	writel(AXUSER_BASE, base + HZIP_BD_WUSER_32_63);
> -
> -	if (qm->use_sva && qm->ver == QM_HW_V2) {
> -		writel(AXUSER_BASE | AXUSER_SSV, base + HZIP_DATA_RUSER_32_63);
> -		writel(AXUSER_BASE | AXUSER_SSV, base + HZIP_DATA_WUSER_32_63);
> -		writel(AXUSER_BASE | AXUSER_SSV, base + HZIP_SGL_RUSER_32_63);
> -	} else {
> -		writel(AXUSER_BASE, base + HZIP_DATA_RUSER_32_63);
> -		writel(AXUSER_BASE, base + HZIP_DATA_WUSER_32_63);
> -		writel(AXUSER_BASE, base + HZIP_SGL_RUSER_32_63);
> -	}
> -
> -	/* let's open all compression/decompression cores */
> -	dcomp_bm = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -				       ZIP_DECOMP_ENABLE_BITMAP, qm->cap_ver);
> -	comp_bm = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -				      ZIP_COMP_ENABLE_BITMAP, qm->cap_ver);
> -	writel(HZIP_DECOMP_CHECK_ENABLE | dcomp_bm | comp_bm, base + HZIP_CLOCK_GATE_CTRL);
> -
> -	/* enable sqc,cqc writeback */
> -	writel(SQC_CACHE_ENABLE | CQC_CACHE_ENABLE | SQC_CACHE_WB_ENABLE |
> -	       CQC_CACHE_WB_ENABLE | FIELD_PREP(SQC_CACHE_WB_THRD, 1) |
> -	       FIELD_PREP(CQC_CACHE_WB_THRD, 1), base + QM_CACHE_CTL);
> -
> -	hisi_zip_enable_clock_gate(qm);
> -
> -	return 0;
> -}
> -
> -static void hisi_zip_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
> -{
> -	u32 val1, val2;
> -
> -	val1 = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
> -	if (enable) {
> -		val1 |= HZIP_AXI_SHUTDOWN_ENABLE;
> -		val2 = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -				ZIP_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
> -	} else {
> -		val1 &= ~HZIP_AXI_SHUTDOWN_ENABLE;
> -		val2 = 0x0;
> -	}
> -
> -	if (qm->ver > QM_HW_V2)
> -		writel(val2, qm->io_base + HZIP_OOO_SHUTDOWN_SEL);
> -
> -	writel(val1, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
> -}
> -
> -static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
> -{
> -	u32 nfe, ce;
> -
> -	if (qm->ver == QM_HW_V1) {
> -		writel(HZIP_CORE_INT_MASK_ALL,
> -		       qm->io_base + HZIP_CORE_INT_MASK_REG);
> -		dev_info(&qm->pdev->dev, "Does not support hw error handle\n");
> -		return;
> -	}
> -
> -	nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_NFE_MASK_CAP, qm->cap_ver);
> -	ce = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CE_MASK_CAP, qm->cap_ver);
> -
> -	/* clear ZIP hw error source if having */
> -	writel(ce | nfe | HZIP_CORE_INT_RAS_FE_ENB_MASK, qm->io_base + HZIP_CORE_INT_SOURCE);
> -
> -	/* configure error type */
> -	writel(ce, qm->io_base + HZIP_CORE_INT_RAS_CE_ENB);
> -	writel(HZIP_CORE_INT_RAS_FE_ENB_MASK, qm->io_base + HZIP_CORE_INT_RAS_FE_ENB);
> -	writel(nfe, qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
> -
> -	hisi_zip_master_ooo_ctrl(qm, true);
> -
> -	/* enable ZIP hw error interrupts */
> -	writel(0, qm->io_base + HZIP_CORE_INT_MASK_REG);
> -}
> -
> -static void hisi_zip_hw_error_disable(struct hisi_qm *qm)
> -{
> -	u32 nfe, ce;
> -
> -	/* disable ZIP hw error interrupts */
> -	nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_NFE_MASK_CAP, qm->cap_ver);
> -	ce = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CE_MASK_CAP, qm->cap_ver);
> -	writel(ce | nfe | HZIP_CORE_INT_RAS_FE_ENB_MASK, qm->io_base + HZIP_CORE_INT_MASK_REG);
> -
> -	hisi_zip_master_ooo_ctrl(qm, false);
> -}
> -
> -static inline struct hisi_qm *file_to_qm(struct ctrl_debug_file *file)
> -{
> -	struct hisi_zip *hisi_zip = file->ctrl->hisi_zip;
> -
> -	return &hisi_zip->qm;
> -}
> -
> -static u32 clear_enable_read(struct hisi_qm *qm)
> -{
> -	return readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
> -		     HZIP_SOFT_CTRL_CNT_CLR_CE_BIT;
> -}
> -
> -static int clear_enable_write(struct hisi_qm *qm, u32 val)
> -{
> -	u32 tmp;
> -
> -	if (val != 1 && val != 0)
> -		return -EINVAL;
> -
> -	tmp = (readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
> -	       ~HZIP_SOFT_CTRL_CNT_CLR_CE_BIT) | val;
> -	writel(tmp, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
> -
> -	return  0;
> -}
> -
> -static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
> -					size_t count, loff_t *pos)
> -{
> -	struct ctrl_debug_file *file = filp->private_data;
> -	struct hisi_qm *qm = file_to_qm(file);
> -	char tbuf[HZIP_BUF_SIZE];
> -	u32 val;
> -	int ret;
> -
> -	ret = hisi_qm_get_dfx_access(qm);
> -	if (ret)
> -		return ret;
> -
> -	spin_lock_irq(&file->lock);
> -	switch (file->index) {
> -	case HZIP_CLEAR_ENABLE:
> -		val = clear_enable_read(qm);
> -		break;
> -	default:
> -		goto err_input;
> -	}
> -	spin_unlock_irq(&file->lock);
> -
> -	hisi_qm_put_dfx_access(qm);
> -	ret = scnprintf(tbuf, sizeof(tbuf), "%u\n", val);
> -	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
> -
> -err_input:
> -	spin_unlock_irq(&file->lock);
> -	hisi_qm_put_dfx_access(qm);
> -	return -EINVAL;
> -}
> -
> -static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
> -					 const char __user *buf,
> -					 size_t count, loff_t *pos)
> -{
> -	struct ctrl_debug_file *file = filp->private_data;
> -	struct hisi_qm *qm = file_to_qm(file);
> -	char tbuf[HZIP_BUF_SIZE];
> -	unsigned long val;
> -	int len, ret;
> -
> -	if (*pos != 0)
> -		return 0;
> -
> -	if (count >= HZIP_BUF_SIZE)
> -		return -ENOSPC;
> -
> -	len = simple_write_to_buffer(tbuf, HZIP_BUF_SIZE - 1, pos, buf, count);
> -	if (len < 0)
> -		return len;
> -
> -	tbuf[len] = '\0';
> -	ret = kstrtoul(tbuf, 0, &val);
> -	if (ret)
> -		return ret;
> -
> -	ret = hisi_qm_get_dfx_access(qm);
> -	if (ret)
> -		return ret;
> -
> -	spin_lock_irq(&file->lock);
> -	switch (file->index) {
> -	case HZIP_CLEAR_ENABLE:
> -		ret = clear_enable_write(qm, val);
> -		if (ret)
> -			goto err_input;
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		goto err_input;
> -	}
> -
> -	ret = count;
> -
> -err_input:
> -	spin_unlock_irq(&file->lock);
> -	hisi_qm_put_dfx_access(qm);
> -	return ret;
> -}
> -
> -static const struct file_operations ctrl_debug_fops = {
> -	.owner = THIS_MODULE,
> -	.open = simple_open,
> -	.read = hisi_zip_ctrl_debug_read,
> -	.write = hisi_zip_ctrl_debug_write,
> -};
> -
> -static int zip_debugfs_atomic64_set(void *data, u64 val)
> -{
> -	if (val)
> -		return -EINVAL;
> -
> -	atomic64_set((atomic64_t *)data, 0);
> -
> -	return 0;
> -}
> -
> -static int zip_debugfs_atomic64_get(void *data, u64 *val)
> -{
> -	*val = atomic64_read((atomic64_t *)data);
> -
> -	return 0;
> -}
> -
> -DEFINE_DEBUGFS_ATTRIBUTE(zip_atomic64_ops, zip_debugfs_atomic64_get,
> -			 zip_debugfs_atomic64_set, "%llu\n");
> -
> -static int hisi_zip_regs_show(struct seq_file *s, void *unused)
> -{
> -	hisi_qm_regs_dump(s, s->private);
> -
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(hisi_zip_regs);
> -
> -static int hisi_zip_core_debug_init(struct hisi_qm *qm)
> -{
> -	u32 zip_core_num, zip_comp_core_num;
> -	struct device *dev = &qm->pdev->dev;
> -	struct debugfs_regset32 *regset;
> -	struct dentry *tmp_d;
> -	char buf[HZIP_BUF_SIZE];
> -	int i;
> -
> -	zip_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CORE_NUM_CAP, qm->cap_ver);
> -	zip_comp_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CLUSTER_COMP_NUM_CAP,
> -						qm->cap_ver);
> -
> -	for (i = 0; i < zip_core_num; i++) {
> -		if (i < zip_comp_core_num)
> -			scnprintf(buf, sizeof(buf), "comp_core%d", i);
> -		else
> -			scnprintf(buf, sizeof(buf), "decomp_core%d",
> -				  i - zip_comp_core_num);
> -
> -		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
> -		if (!regset)
> -			return -ENOENT;
> -
> -		regset->regs = hzip_dfx_regs;
> -		regset->nregs = ARRAY_SIZE(hzip_dfx_regs);
> -		regset->base = qm->io_base + core_offsets[i];
> -		regset->dev = dev;
> -
> -		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
> -		debugfs_create_file("regs", 0444, tmp_d, regset,
> -				    &hisi_zip_regs_fops);
> -	}
> -
> -	return 0;
> -}
> -
> -static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
> -{
> -	struct dfx_diff_registers *hzip_regs = qm->debug.acc_diff_regs;
> -	struct hisi_zip *zip = container_of(qm, struct hisi_zip, qm);
> -	struct hisi_zip_dfx *dfx = &zip->dfx;
> -	struct dentry *tmp_dir;
> -	void *data;
> -	int i;
> -
> -	tmp_dir = debugfs_create_dir("zip_dfx", qm->debug.debug_root);
> -	for (i = 0; i < ARRAY_SIZE(zip_dfx_files); i++) {
> -		data = (atomic64_t *)((uintptr_t)dfx + zip_dfx_files[i].offset);
> -		debugfs_create_file(zip_dfx_files[i].name,
> -				    0644, tmp_dir, data,
> -				    &zip_atomic64_ops);
> -	}
> -
> -	if (qm->fun_type == QM_HW_PF && hzip_regs)
> -		debugfs_create_file("diff_regs", 0444, tmp_dir,
> -				      qm, &hzip_diff_regs_fops);
> -}
> -
> -static int hisi_zip_ctrl_debug_init(struct hisi_qm *qm)
> -{
> -	struct hisi_zip *zip = container_of(qm, struct hisi_zip, qm);
> -	int i;
> -
> -	for (i = HZIP_CLEAR_ENABLE; i < HZIP_DEBUG_FILE_NUM; i++) {
> -		spin_lock_init(&zip->ctrl->files[i].lock);
> -		zip->ctrl->files[i].ctrl = zip->ctrl;
> -		zip->ctrl->files[i].index = i;
> -
> -		debugfs_create_file(ctrl_debug_file_name[i], 0600,
> -				    qm->debug.debug_root,
> -				    zip->ctrl->files + i,
> -				    &ctrl_debug_fops);
> -	}
> -
> -	return hisi_zip_core_debug_init(qm);
> -}
> -
> -static int hisi_zip_debugfs_init(struct hisi_qm *qm)
> -{
> -	struct device *dev = &qm->pdev->dev;
> -	struct dentry *dev_d;
> -	int ret;
> -
> -	dev_d = debugfs_create_dir(dev_name(dev), hzip_debugfs_root);
> -
> -	qm->debug.sqe_mask_offset = HZIP_SQE_MASK_OFFSET;
> -	qm->debug.sqe_mask_len = HZIP_SQE_MASK_LEN;
> -	qm->debug.debug_root = dev_d;
> -	ret = hisi_qm_regs_debugfs_init(qm, hzip_diff_regs, ARRAY_SIZE(hzip_diff_regs));
> -	if (ret) {
> -		dev_warn(dev, "Failed to init ZIP diff regs!\n");
> -		goto debugfs_remove;
> -	}
> -
> -	hisi_qm_debug_init(qm);
> -
> -	if (qm->fun_type == QM_HW_PF) {
> -		ret = hisi_zip_ctrl_debug_init(qm);
> -		if (ret)
> -			goto failed_to_create;
> -	}
> -
> -	hisi_zip_dfx_debug_init(qm);
> -
> -	return 0;
> -
> -failed_to_create:
> -	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
> -debugfs_remove:
> -	debugfs_remove_recursive(hzip_debugfs_root);
> -	return ret;
> -}
> -
> -/* hisi_zip_debug_regs_clear() - clear the zip debug regs */
> -static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
> -{
> -	int i, j;
> -
> -	/* enable register read_clear bit */
> -	writel(HZIP_RD_CNT_CLR_CE_EN, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
> -	for (i = 0; i < ARRAY_SIZE(core_offsets); i++)
> -		for (j = 0; j < ARRAY_SIZE(hzip_dfx_regs); j++)
> -			readl(qm->io_base + core_offsets[i] +
> -			      hzip_dfx_regs[j].offset);
> -
> -	/* disable register read_clear bit */
> -	writel(0x0, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
> -
> -	hisi_qm_debug_regs_clear(qm);
> -}
> -
> -static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
> -{
> -	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
> -
> -	debugfs_remove_recursive(qm->debug.debug_root);
> -
> -	if (qm->fun_type == QM_HW_PF) {
> -		hisi_zip_debug_regs_clear(qm);
> -		qm->debug.curr_qm_qp_num = 0;
> -	}
> -}
> -
> -static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
> -{
> -	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
> -	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
> -	struct qm_debug *debug = &qm->debug;
> -	void __iomem *io_base;
> -	u32 zip_core_num;
> -	int i, j, idx;
> -
> -	zip_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CORE_NUM_CAP, qm->cap_ver);
> -
> -	debug->last_words = kcalloc(core_dfx_regs_num * zip_core_num + com_dfx_regs_num,
> -				    sizeof(unsigned int), GFP_KERNEL);
> -	if (!debug->last_words)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < com_dfx_regs_num; i++) {
> -		io_base = qm->io_base + hzip_com_dfx_regs[i].offset;
> -		debug->last_words[i] = readl_relaxed(io_base);
> -	}
> -
> -	for (i = 0; i < zip_core_num; i++) {
> -		io_base = qm->io_base + core_offsets[i];
> -		for (j = 0; j < core_dfx_regs_num; j++) {
> -			idx = com_dfx_regs_num + i * core_dfx_regs_num + j;
> -			debug->last_words[idx] = readl_relaxed(
> -				io_base + hzip_dump_dfx_regs[j].offset);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void hisi_zip_show_last_regs_uninit(struct hisi_qm *qm)
> -{
> -	struct qm_debug *debug = &qm->debug;
> -
> -	if (qm->fun_type == QM_HW_VF || !debug->last_words)
> -		return;
> -
> -	kfree(debug->last_words);
> -	debug->last_words = NULL;
> -}
> -
> -static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
> -{
> -	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
> -	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
> -	u32 zip_core_num, zip_comp_core_num;
> -	struct qm_debug *debug = &qm->debug;
> -	char buf[HZIP_BUF_SIZE];
> -	void __iomem *base;
> -	int i, j, idx;
> -	u32 val;
> -
> -	if (qm->fun_type == QM_HW_VF || !debug->last_words)
> -		return;
> -
> -	for (i = 0; i < com_dfx_regs_num; i++) {
> -		val = readl_relaxed(qm->io_base + hzip_com_dfx_regs[i].offset);
> -		if (debug->last_words[i] != val)
> -			pci_info(qm->pdev, "com_dfx: %s \t= 0x%08x => 0x%08x\n",
> -				 hzip_com_dfx_regs[i].name, debug->last_words[i], val);
> -	}
> -
> -	zip_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CORE_NUM_CAP, qm->cap_ver);
> -	zip_comp_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CLUSTER_COMP_NUM_CAP,
> -						qm->cap_ver);
> -	for (i = 0; i < zip_core_num; i++) {
> -		if (i < zip_comp_core_num)
> -			scnprintf(buf, sizeof(buf), "Comp_core-%d", i);
> -		else
> -			scnprintf(buf, sizeof(buf), "Decomp_core-%d",
> -				  i - zip_comp_core_num);
> -		base = qm->io_base + core_offsets[i];
> -
> -		pci_info(qm->pdev, "==>%s:\n", buf);
> -		/* dump last word for dfx regs during control resetting */
> -		for (j = 0; j < core_dfx_regs_num; j++) {
> -			idx = com_dfx_regs_num + i * core_dfx_regs_num + j;
> -			val = readl_relaxed(base + hzip_dump_dfx_regs[j].offset);
> -			if (debug->last_words[idx] != val)
> -				pci_info(qm->pdev, "%s \t= 0x%08x => 0x%08x\n",
> -					 hzip_dump_dfx_regs[j].name,
> -					 debug->last_words[idx], val);
> -		}
> -	}
> -}
> -
> -static void hisi_zip_log_hw_error(struct hisi_qm *qm, u32 err_sts)
> -{
> -	const struct hisi_zip_hw_error *err = zip_hw_error;
> -	struct device *dev = &qm->pdev->dev;
> -	u32 err_val;
> -
> -	while (err->msg) {
> -		if (err->int_msk & err_sts) {
> -			dev_err(dev, "%s [error status=0x%x] found\n",
> -				err->msg, err->int_msk);
> -
> -			if (err->int_msk & HZIP_CORE_INT_STATUS_M_ECC) {
> -				err_val = readl(qm->io_base +
> -						HZIP_CORE_SRAM_ECC_ERR_INFO);
> -				dev_err(dev, "hisi-zip multi ecc sram num=0x%x\n",
> -					((err_val >>
> -					HZIP_SRAM_ECC_ERR_NUM_SHIFT) & 0xFF));
> -			}
> -		}
> -		err++;
> -	}
> -}
> -
> -static u32 hisi_zip_get_hw_err_status(struct hisi_qm *qm)
> -{
> -	return readl(qm->io_base + HZIP_CORE_INT_STATUS);
> -}
> -
> -static void hisi_zip_clear_hw_err_status(struct hisi_qm *qm, u32 err_sts)
> -{
> -	u32 nfe;
> -
> -	writel(err_sts, qm->io_base + HZIP_CORE_INT_SOURCE);
> -	nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_NFE_MASK_CAP, qm->cap_ver);
> -	writel(nfe, qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
> -}
> -
> -static void hisi_zip_open_axi_master_ooo(struct hisi_qm *qm)
> -{
> -	u32 val;
> -
> -	val = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
> -
> -	writel(val & ~HZIP_AXI_SHUTDOWN_ENABLE,
> -	       qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
> -
> -	writel(val | HZIP_AXI_SHUTDOWN_ENABLE,
> -	       qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
> -}
> -
> -static void hisi_zip_close_axi_master_ooo(struct hisi_qm *qm)
> -{
> -	u32 nfe_enb;
> -
> -	/* Disable ECC Mbit error report. */
> -	nfe_enb = readl(qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
> -	writel(nfe_enb & ~HZIP_CORE_INT_STATUS_M_ECC,
> -	       qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
> -
> -	/* Inject zip ECC Mbit error to block master ooo. */
> -	writel(HZIP_CORE_INT_STATUS_M_ECC,
> -	       qm->io_base + HZIP_CORE_INT_SET);
> -}
> -
> -static void hisi_zip_err_info_init(struct hisi_qm *qm)
> -{
> -	struct hisi_qm_err_info *err_info = &qm->err_info;
> -
> -	err_info->fe = HZIP_CORE_INT_RAS_FE_ENB_MASK;
> -	err_info->ce = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_QM_CE_MASK_CAP, qm->cap_ver);
> -	err_info->nfe = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -					    ZIP_QM_NFE_MASK_CAP, qm->cap_ver);
> -	err_info->ecc_2bits_mask = HZIP_CORE_INT_STATUS_M_ECC;
> -	err_info->qm_shutdown_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -							 ZIP_QM_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
> -	err_info->dev_shutdown_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -							  ZIP_OOO_SHUTDOWN_MASK_CAP, qm->cap_ver);
> -	err_info->qm_reset_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -						      ZIP_QM_RESET_MASK_CAP, qm->cap_ver);
> -	err_info->dev_reset_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
> -						       ZIP_RESET_MASK_CAP, qm->cap_ver);
> -	err_info->msi_wr_port = HZIP_WR_PORT;
> -	err_info->acpi_rst = "ZRST";
> -}
> -
> -static const struct hisi_qm_err_ini hisi_zip_err_ini = {
> -	.hw_init		= hisi_zip_set_user_domain_and_cache,
> -	.hw_err_enable		= hisi_zip_hw_error_enable,
> -	.hw_err_disable		= hisi_zip_hw_error_disable,
> -	.get_dev_hw_err_status	= hisi_zip_get_hw_err_status,
> -	.clear_dev_hw_err_status = hisi_zip_clear_hw_err_status,
> -	.log_dev_hw_err		= hisi_zip_log_hw_error,
> -	.open_axi_master_ooo	= hisi_zip_open_axi_master_ooo,
> -	.close_axi_master_ooo	= hisi_zip_close_axi_master_ooo,
> -	.open_sva_prefetch	= hisi_zip_open_sva_prefetch,
> -	.close_sva_prefetch	= hisi_zip_close_sva_prefetch,
> -	.show_last_dfx_regs	= hisi_zip_show_last_dfx_regs,
> -	.err_info_init		= hisi_zip_err_info_init,
> -};
> -
> -static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
> -{
> -	struct hisi_qm *qm = &hisi_zip->qm;
> -	struct hisi_zip_ctrl *ctrl;
> -	int ret;
> -
> -	ctrl = devm_kzalloc(&qm->pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> -	if (!ctrl)
> -		return -ENOMEM;
> -
> -	hisi_zip->ctrl = ctrl;
> -	ctrl->hisi_zip = hisi_zip;
> -	qm->err_ini = &hisi_zip_err_ini;
> -	qm->err_ini->err_info_init(qm);
> -
> -	ret = hisi_zip_set_user_domain_and_cache(qm);
> -	if (ret)
> -		return ret;
> -
> -	hisi_zip_open_sva_prefetch(qm);
> -	hisi_qm_dev_err_init(qm);
> -	hisi_zip_debug_regs_clear(qm);
> -
> -	ret = hisi_zip_show_last_regs_init(qm);
> -	if (ret)
> -		pci_err(qm->pdev, "Failed to init last word regs!\n");
> -
> -	return ret;
> -}
> -
> -static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
> -{
> -	int ret;
> -
> -	qm->pdev = pdev;
> -	qm->ver = pdev->revision;
> -	qm->mode = uacce_mode;
> -	qm->sqe_size = HZIP_SQE_SIZE;
> -	qm->dev_name = hisi_zip_name;
> -
> -	qm->fun_type = (pdev->device == PCI_DEVICE_ID_HUAWEI_ZIP_PF) ?
> -			QM_HW_PF : QM_HW_VF;
> -	if (qm->fun_type == QM_HW_PF) {
> -		qm->qp_base = HZIP_PF_DEF_Q_BASE;
> -		qm->qp_num = pf_q_num;
> -		qm->debug.curr_qm_qp_num = pf_q_num;
> -		qm->qm_list = &zip_devices;
> -	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
> -		/*
> -		 * have no way to get qm configure in VM in v1 hardware,
> -		 * so currently force PF to uses HZIP_PF_DEF_Q_NUM, and force
> -		 * to trigger only one VF in v1 hardware.
> -		 *
> -		 * v2 hardware has no such problem.
> -		 */
> -		qm->qp_base = HZIP_PF_DEF_Q_NUM;
> -		qm->qp_num = HZIP_QUEUE_NUM_V1 - HZIP_PF_DEF_Q_NUM;
> -	}
> -
> -	ret = hisi_qm_init(qm);
> -	if (ret) {
> -		pci_err(qm->pdev, "Failed to init zip qm configures!\n");
> -		return ret;
> -	}
> -
> -	ret = hisi_zip_set_qm_algs(qm);
> -	if (ret) {
> -		pci_err(qm->pdev, "Failed to set zip algs!\n");
> -		hisi_qm_uninit(qm);
> -	}
> -
> -	return ret;
> -}
> -
> -static void hisi_zip_qm_uninit(struct hisi_qm *qm)
> -{
> -	hisi_qm_uninit(qm);
> -}
> -
> -static int hisi_zip_probe_init(struct hisi_zip *hisi_zip)
> -{
> -	u32 type_rate = HZIP_SHAPER_RATE_COMPRESS;
> -	struct hisi_qm *qm = &hisi_zip->qm;
> -	int ret;
> -
> -	if (qm->fun_type == QM_HW_PF) {
> -		ret = hisi_zip_pf_probe_init(hisi_zip);
> -		if (ret)
> -			return ret;
> -		/* enable shaper type 0 */
> -		if (qm->ver >= QM_HW_V3) {
> -			type_rate |= QM_SHAPER_ENABLE;
> -
> -			/* ZIP need to enable shaper type 1 */
> -			type_rate |= HZIP_SHAPER_RATE_DECOMPRESS << QM_SHAPER_TYPE1_OFFSET;
> -			qm->type_rate = type_rate;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> -{
> -	struct hisi_zip *hisi_zip;
> -	struct hisi_qm *qm;
> -	int ret;
> -
> -	hisi_zip = devm_kzalloc(&pdev->dev, sizeof(*hisi_zip), GFP_KERNEL);
> -	if (!hisi_zip)
> -		return -ENOMEM;
> -
> -	qm = &hisi_zip->qm;
> -
> -	ret = hisi_zip_qm_init(qm, pdev);
> -	if (ret) {
> -		pci_err(pdev, "Failed to init ZIP QM (%d)!\n", ret);
> -		return ret;
> -	}
> -
> -	ret = hisi_zip_probe_init(hisi_zip);
> -	if (ret) {
> -		pci_err(pdev, "Failed to probe (%d)!\n", ret);
> -		goto err_qm_uninit;
> -	}
> -
> -	ret = hisi_qm_start(qm);
> -	if (ret)
> -		goto err_dev_err_uninit;
> -
> -	ret = hisi_zip_debugfs_init(qm);
> -	if (ret)
> -		pci_err(pdev, "failed to init debugfs (%d)!\n", ret);
> -
> -	ret = hisi_qm_alg_register(qm, &zip_devices);
> -	if (ret < 0) {
> -		pci_err(pdev, "failed to register driver to crypto!\n");
> -		goto err_qm_stop;
> -	}
> -
> -	if (qm->uacce) {
> -		ret = uacce_register(qm->uacce);
> -		if (ret) {
> -			pci_err(pdev, "failed to register uacce (%d)!\n", ret);
> -			goto err_qm_alg_unregister;
> -		}
> -	}
> -
> -	if (qm->fun_type == QM_HW_PF && vfs_num > 0) {
> -		ret = hisi_qm_sriov_enable(pdev, vfs_num);
> -		if (ret < 0)
> -			goto err_qm_alg_unregister;
> -	}
> -
> -	hisi_qm_pm_init(qm);
> -
> -	return 0;
> -
> -err_qm_alg_unregister:
> -	hisi_qm_alg_unregister(qm, &zip_devices);
> -
> -err_qm_stop:
> -	hisi_zip_debugfs_exit(qm);
> -	hisi_qm_stop(qm, QM_NORMAL);
> -
> -err_dev_err_uninit:
> -	hisi_zip_show_last_regs_uninit(qm);
> -	hisi_qm_dev_err_uninit(qm);
> -
> -err_qm_uninit:
> -	hisi_zip_qm_uninit(qm);
> -
> -	return ret;
> -}
> -
> -static void hisi_zip_remove(struct pci_dev *pdev)
> -{
> -	struct hisi_qm *qm = pci_get_drvdata(pdev);
> -
> -	hisi_qm_pm_uninit(qm);
> -	hisi_qm_wait_task_finish(qm, &zip_devices);
> -	hisi_qm_alg_unregister(qm, &zip_devices);
> -
> -	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
> -		hisi_qm_sriov_disable(pdev, true);
> -
> -	hisi_zip_debugfs_exit(qm);
> -	hisi_qm_stop(qm, QM_NORMAL);
> -	hisi_zip_show_last_regs_uninit(qm);
> -	hisi_qm_dev_err_uninit(qm);
> -	hisi_zip_qm_uninit(qm);
> -}
> -
> -static const struct dev_pm_ops hisi_zip_pm_ops = {
> -	SET_RUNTIME_PM_OPS(hisi_qm_suspend, hisi_qm_resume, NULL)
> -};
> -
> -static const struct pci_error_handlers hisi_zip_err_handler = {
> -	.error_detected	= hisi_qm_dev_err_detected,
> -	.slot_reset	= hisi_qm_dev_slot_reset,
> -	.reset_prepare	= hisi_qm_reset_prepare,
> -	.reset_done	= hisi_qm_reset_done,
> -};
> -
> -static struct pci_driver hisi_zip_pci_driver = {
> -	.name			= "hisi_zip",
> -	.id_table		= hisi_zip_dev_ids,
> -	.probe			= hisi_zip_probe,
> -	.remove			= hisi_zip_remove,
> -	.sriov_configure	= IS_ENABLED(CONFIG_PCI_IOV) ?
> -					hisi_qm_sriov_configure : NULL,
> -	.err_handler		= &hisi_zip_err_handler,
> -	.shutdown		= hisi_qm_dev_shutdown,
> -	.driver.pm		= &hisi_zip_pm_ops,
> -};
> -
> -struct pci_driver *hisi_zip_get_pf_driver(void)
> -{
> -	return &hisi_zip_pci_driver;
> -}
> -EXPORT_SYMBOL_GPL(hisi_zip_get_pf_driver);
> -
> -static void hisi_zip_register_debugfs(void)
> -{
> -	if (!debugfs_initialized())
> -		return;
> -
> -	hzip_debugfs_root = debugfs_create_dir("hisi_zip", NULL);
> -}
> -
> -static void hisi_zip_unregister_debugfs(void)
> -{
> -	debugfs_remove_recursive(hzip_debugfs_root);
> -}
> -
> -static int __init hisi_zip_init(void)
> -{
> -	int ret;
> -
> -	hisi_qm_init_list(&zip_devices);
> -	hisi_zip_register_debugfs();
> -
> -	ret = pci_register_driver(&hisi_zip_pci_driver);
> -	if (ret < 0) {
> -		hisi_zip_unregister_debugfs();
> -		pr_err("Failed to register pci driver.\n");
> -	}
> -
> -	return ret;
> -}
> -
> -static void __exit hisi_zip_exit(void)
> -{
> -	pci_unregister_driver(&hisi_zip_pci_driver);
> -	hisi_zip_unregister_debugfs();
> -}
> -
> -module_init(hisi_zip_init);
> -module_exit(hisi_zip_exit);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
> -MODULE_DESCRIPTION("Driver for HiSilicon ZIP accelerator");
>

