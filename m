Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125A281312D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjLNNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjLNNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:18:22 -0500
X-Greylist: delayed 100 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 05:18:27 PST
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE7510E;
        Thu, 14 Dec 2023 05:18:27 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SrXvK03FYz29g2T;
        Thu, 14 Dec 2023 21:17:17 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
        by mail.maildlp.com (Postfix) with ESMTPS id 77FC31A0190;
        Thu, 14 Dec 2023 21:18:25 +0800 (CST)
Received: from [10.67.120.135] (10.67.120.135) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 21:18:25 +0800
Subject: Re: [PATCH net-next v4 1/4] octeon_ep: add PF-VF mailbox
 communication
To:     Shinas Rasheed <srasheed@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
References: <20231213035816.2656851-1-srasheed@marvell.com>
 <20231213035816.2656851-2-srasheed@marvell.com>
From:   "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <cf45647c-f161-809f-e1c5-5fd82524ede4@huawei.com>
Date:   Thu, 14 Dec 2023 21:18:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20231213035816.2656851-2-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.135]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few nit comments


在 2023/12/13 11:58, Shinas Rasheed 写道:
> Implement mailbox communication between PF and VFs.
> PF-VF mailbox is used for all control commands from VF to PF and
> asynchronous notification messages from PF to VF.
>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>    - Include [1/4] in the subject for this patch, which was lost in V3
>
> V3: https://lore.kernel.org/all/20231211063355.2630028-2-srasheed@marvell.com/
>    - Corrected error cleanup logic for PF-VF mbox setup
>    - Removed double inclusion of types.h header file in octep_pfvf_mbox.c
>
> V2: https://lore.kernel.org/all/20231209081450.2613561-2-srasheed@marvell.com/
>    - Remove unused variable
>
> V1: https://lore.kernel.org/all/20231208070352.2606192-2-srasheed@marvell.com/
>
>   .../net/ethernet/marvell/octeon_ep/Makefile   |   2 +-
>   .../marvell/octeon_ep/octep_cn9k_pf.c         |  59 ++-
>   .../marvell/octeon_ep/octep_cnxk_pf.c         |  46 ++-
>   .../marvell/octeon_ep/octep_ctrl_mbox.h       |   4 +-
>   .../ethernet/marvell/octeon_ep/octep_main.c   |  83 ++++-
>   .../ethernet/marvell/octeon_ep/octep_main.h   |  45 ++-
>   .../marvell/octeon_ep/octep_pfvf_mbox.c       | 335 ++++++++++++++++++
>   .../marvell/octeon_ep/octep_pfvf_mbox.h       | 143 ++++++++
>   .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |   9 +
>   .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  13 +
>   .../net/ethernet/marvell/octeon_ep/octep_tx.h |  24 +-
>   11 files changed, 714 insertions(+), 49 deletions(-)
>   create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
>   create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/Makefile b/drivers/net/ethernet/marvell/octeon_ep/Makefile
> index 02a4a21bc298..62162ed63f34 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/Makefile
> +++ b/drivers/net/ethernet/marvell/octeon_ep/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_OCTEON_EP) += octeon_ep.o
>   
>   octeon_ep-y := octep_main.o octep_cn9k_pf.o octep_tx.o octep_rx.o \
>   	       octep_ethtool.o octep_ctrl_mbox.o octep_ctrl_net.o \
> -	       octep_cnxk_pf.o
> +	       octep_pfvf_mbox.o octep_cnxk_pf.o
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> index 9209f1ec1b52..b5805969404f 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> @@ -362,16 +362,55 @@ static void octep_setup_mbox_regs_cn93_pf(struct octep_device *oct, int q_no)
>   {
>   	struct octep_mbox *mbox = oct->mbox[q_no];
>   
> -	mbox->q_no = q_no;
> -
> -	/* PF mbox interrupt reg */
> -	mbox->mbox_int_reg = oct->mmio[0].hw_addr + CN93_SDP_EPF_MBOX_RINT(0);
> -
>   	/* PF to VF DATA reg. PF writes into this reg */
> -	mbox->mbox_write_reg = oct->mmio[0].hw_addr + CN93_SDP_R_MBOX_PF_VF_DATA(q_no);
> +	mbox->pf_vf_data_reg = oct->mmio[0].hw_addr + CN93_SDP_MBOX_PF_VF_DATA(q_no);
>   
>   	/* VF to PF DATA reg. PF reads from this reg */
> -	mbox->mbox_read_reg = oct->mmio[0].hw_addr + CN93_SDP_R_MBOX_VF_PF_DATA(q_no);
> +	mbox->vf_pf_data_reg = oct->mmio[0].hw_addr + CN93_SDP_MBOX_VF_PF_DATA(q_no);
> +}
> +
> +/* Poll for mailbox messages from VF */
> +static void octep_poll_pfvf_mailbox(struct octep_device *oct)
> +{
> +	u32 vf, active_vfs, active_rings_per_vf, vf_mbox_queue;
> +	u64 reg0, reg1;
> +
> +	reg0 = octep_read_csr64(oct, CN93_SDP_EPF_MBOX_RINT(0));
> +	reg1 = octep_read_csr64(oct, CN93_SDP_EPF_MBOX_RINT(1));
> +	if (reg0 || reg1) {
> +		active_vfs = CFG_GET_ACTIVE_VFS(oct->conf);
> +		active_rings_per_vf = CFG_GET_ACTIVE_RPVF(oct->conf);
> +		for (vf = 0; vf < active_vfs; vf++) {
> +			vf_mbox_queue = vf * active_rings_per_vf;
> +
> +			if (vf_mbox_queue < 64) {
> +				if (!(reg0 & (0x1UL << vf_mbox_queue)))
> +					continue;
> +			} else {
> +				if (!(reg1 & (0x1UL << (vf_mbox_queue - 64))))
> +					continue;
> +			}
> +
> +			if (!oct->mbox[vf_mbox_queue]) {
> +				dev_err(&oct->pdev->dev, "bad mbox vf %d\n", vf);
> +				continue;
> +			}
> +			schedule_work(&oct->mbox[vf_mbox_queue]->wk.work);
> +		}
> +		if (reg0)
> +			octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT(0), reg0);
> +		if (reg1)
> +			octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT(1), reg1);
> +	}
> +}
> +
> +/* PF-VF mailbox interrupt handler */
> +static irqreturn_t octep_pfvf_mbox_intr_handler_cn93_pf(void *dev)
> +{
> +	struct octep_device *oct = (struct octep_device *)dev;
> +
> +	octep_poll_pfvf_mailbox(oct);
> +	return IRQ_HANDLED;
>   }
>   
>   /* Poll OEI events like heartbeat */
> @@ -403,6 +442,7 @@ static irqreturn_t octep_oei_intr_handler_cn93_pf(void *dev)
>    */
>   static void octep_poll_non_ioq_interrupts_cn93_pf(struct octep_device *oct)
>   {
> +	octep_poll_pfvf_mailbox(oct);
>   	octep_poll_oei_cn93_pf(oct);
>   }
>   
> @@ -646,6 +686,8 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
>   
>   	octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT_ENA_W1S, intr_mask);
>   	octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT_ENA_W1S, intr_mask);
> +	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1S(0), -1ULL);
> +	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1S(1), -1ULL);
>   
>   	octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT_ENA_W1S(0), -1ULL);
>   	octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT_ENA_W1S(0), -1ULL);
> @@ -672,6 +714,8 @@ static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
>   
>   	octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT_ENA_W1C, intr_mask);
>   	octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT_ENA_W1C, intr_mask);
> +	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1C(0), -1ULL);
> +	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1C(1), -1ULL);
>   
>   	octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT_ENA_W1C(0), -1ULL);
>   	octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT_ENA_W1C(0), -1ULL);
> @@ -807,6 +851,7 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
>   	oct->hw_ops.setup_oq_regs = octep_setup_oq_regs_cn93_pf;
>   	oct->hw_ops.setup_mbox_regs = octep_setup_mbox_regs_cn93_pf;
>   
> +	oct->hw_ops.mbox_intr_handler = octep_pfvf_mbox_intr_handler_cn93_pf;
>   	oct->hw_ops.oei_intr_handler = octep_oei_intr_handler_cn93_pf;
>   	oct->hw_ops.ire_intr_handler = octep_ire_intr_handler_cn93_pf;
>   	oct->hw_ops.ore_intr_handler = octep_ore_intr_handler_cn93_pf;
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> index 098a0c5c4d1c..5de0b5ecbc5f 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> @@ -392,16 +392,44 @@ static void octep_setup_mbox_regs_cnxk_pf(struct octep_device *oct, int q_no)
>   {
>   	struct octep_mbox *mbox = oct->mbox[q_no];
>   
> -	mbox->q_no = q_no;
> -
> -	/* PF mbox interrupt reg */
> -	mbox->mbox_int_reg = oct->mmio[0].hw_addr + CNXK_SDP_EPF_MBOX_RINT(0);
> -
>   	/* PF to VF DATA reg. PF writes into this reg */
> -	mbox->mbox_write_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_MBOX_PF_VF_DATA(q_no);
> +	mbox->pf_vf_data_reg = oct->mmio[0].hw_addr + CNXK_SDP_MBOX_PF_VF_DATA(q_no);
>   
>   	/* VF to PF DATA reg. PF reads from this reg */
> -	mbox->mbox_read_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_MBOX_VF_PF_DATA(q_no);
> +	mbox->vf_pf_data_reg = oct->mmio[0].hw_addr + CNXK_SDP_MBOX_VF_PF_DATA(q_no);
> +}
> +
> +static void octep_poll_pfvf_mailbox_cnxk_pf(struct octep_device *oct)
> +{
> +	u32 vf, active_vfs, active_rings_per_vf, vf_mbox_queue;
> +	u64 reg0;
> +
> +	reg0 = octep_read_csr64(oct, CNXK_SDP_EPF_MBOX_RINT(0));
> +	if (reg0) {
> +		active_vfs = CFG_GET_ACTIVE_VFS(oct->conf);
> +		active_rings_per_vf = CFG_GET_ACTIVE_RPVF(oct->conf);
> +		for (vf = 0; vf < active_vfs; vf++) {
> +			vf_mbox_queue = vf * active_rings_per_vf;
> +			if (!(reg0 & (0x1UL << vf_mbox_queue)))
> +				continue;
> +
> +			if (!oct->mbox[vf_mbox_queue]) {
> +				dev_err(&oct->pdev->dev, "bad mbox vf %d\n", vf);
> +				continue;
> +			}
> +			schedule_work(&oct->mbox[vf_mbox_queue]->wk.work);
> +		}
> +		if (reg0)
the checking of reg0 here seems unnecessary.

> +			octep_write_csr64(oct, CNXK_SDP_EPF_MBOX_RINT(0), reg0);
> +	}
> +}
> +
> +static irqreturn_t octep_pfvf_mbox_intr_handler_cnxk_pf(void *dev)
> +{
> +	struct octep_device *oct = (struct octep_device *)dev;
> +
> +	octep_poll_pfvf_mailbox_cnxk_pf(oct);
> +	return IRQ_HANDLED;
>   }

...

> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mutex.h>
> +#include <linux/jiffies.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <linux/etherdevice.h>
> +
> +#include "octep_config.h"
> +#include "octep_main.h"
> +#include "octep_pfvf_mbox.h"
> +#include "octep_ctrl_net.h"
> +
> +static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
redundant space before "u32 vf_id"

> +					union octep_pfvf_mbox_word cmd,
> +					union octep_pfvf_mbox_word *rsp)
> +{
> +	u32 vf_version = (u32)cmd.s_version.version;
> +
> +	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
> +		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +	else
> +		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +}

...
> +static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
> +				  union octep_pfvf_mbox_word cmd,
> +				  union octep_pfvf_mbox_word *rsp)
> +{
> +	int err;
> +
> +	err = octep_ctrl_net_dev_remove(oct, vf_id);
> +	if (err) {
> +		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +		dev_err(&oct->pdev->dev, "Failed to acknowledge fw of vf %d removal\n",
> +			vf_id);
> +		return;
> +	}
> +	rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +}
> +
> +int octep_setup_pfvf_mbox(struct octep_device *oct)
> +{
> +	int i = 0, num_vfs = 0, rings_per_vf = 0;
looks unnecessary initialiazation here.

> +	int ring = 0;
> +
> +	num_vfs = oct->conf->sriov_cfg.active_vfs;
> +	rings_per_vf = oct->conf->sriov_cfg.max_rings_per_vf;
> +
> +	for (i = 0; i < num_vfs; i++) {
> +		ring  = rings_per_vf * i;
redundant space after 'ring'? also exist at other places.
> +		oct->mbox[ring] = vzalloc(sizeof(*oct->mbox[ring]));
> +
> +		if (!oct->mbox[ring])
> +			goto free_mbox;
> +
> +		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
> +		mutex_init(&oct->mbox[ring]->lock);
> +		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
> +		oct->mbox[ring]->wk.ctxptr = oct->mbox[ring];
> +		oct->mbox[ring]->oct = oct;
> +		oct->mbox[ring]->vf_id = i;
> +		oct->hw_ops.setup_mbox_regs(oct, ring);
> +	}
> +	return 0;
> +
> +free_mbox:
> +	while (i) {
> +		i--;
> +		ring  = rings_per_vf * i;
> +		cancel_work_sync(&oct->mbox[ring]->wk.work);
> +		mutex_destroy(&oct->mbox[ring]->lock);
> +		vfree(oct->mbox[ring]);
> +		oct->mbox[ring] = NULL;
> +	}
> +	return -ENOMEM;
> +}
> +
> +void octep_delete_pfvf_mbox(struct octep_device *oct)
> +{
> +	int rings_per_vf = oct->conf->sriov_cfg.max_rings_per_vf;
> +	int num_vfs = oct->conf->sriov_cfg.active_vfs;
> +	int i = 0, ring = 0, vf_srn = 0;
> +
> +	for (i = 0; i < num_vfs; i++) {
> +		ring  = vf_srn + rings_per_vf * i;
> +		if (!oct->mbox[ring])
> +			continue;
> +
> +		if (work_pending(&oct->mbox[ring]->wk.work))
> +			cancel_work_sync(&oct->mbox[ring]->wk.work);
> +
> +		mutex_destroy(&oct->mbox[ring]->lock);
> +		vfree(oct->mbox[ring]);
> +		oct->mbox[ring] = NULL;
> +	}
> +}
> +
> +static void octep_pfvf_pf_get_data(struct octep_device *oct,
> +				   struct octep_mbox *mbox, int vf_id,
> +				   union octep_pfvf_mbox_word cmd,
> +				   union octep_pfvf_mbox_word *rsp)
> +{
> +	int length = 0;
> +	int i = 0;
> +	int err;
> +	struct octep_iface_link_info link_info;
> +	struct octep_iface_rx_stats rx_stats;
> +	struct octep_iface_tx_stats tx_stats;
Variables should be placed with Revert-Chris Tree  sequency


...
