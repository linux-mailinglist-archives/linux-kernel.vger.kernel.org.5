Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCD7EB513
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjKNQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjKNQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:42:54 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51F182
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:42:48 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2wUvroyuPy6Qa2wUvrFwKl; Tue, 14 Nov 2023 17:42:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699980166;
        bh=QVCWaVtsfj67lsleFFewQkVZBIvHs6icaAj7eQrDp4A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WxNHnOVRSXie5ZC1eBjlITHPmCAFVcBPn+4y1BnZd/evWslOdQdVMnCslFPvxk854
         atKuremXfNabRpEPWqpd8rI0F7AIVAPdrgbZMkJgl7jjL/y2W303Nc6uPiXNJFExsh
         3YF/Yn1lWWeTuEzkjesh5CDewUawDpZXzZ08sF43GPIRhryCu8pDnGAzWUUkPTM2K3
         OMTirDfVRRff+3qryriSzIipOAgbu0RrA49p3ocLhrH0UW7JBffWCHJ56vTihN6M2k
         PL0joO8204OLZ8uRS+f821nggFtyRMnYryRjUlEgPzQUU79acE1ROsIBANdwS24nAu
         eSIv/pegGj0Vg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Nov 2023 17:42:46 +0100
X-ME-IP: 86.243.2.178
Message-ID: <dd6f8eb0-0cca-4bb0-bceb-8c2e76ff0bc5@wanadoo.fr>
Date:   Tue, 14 Nov 2023 17:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2: Fix klockwork and coverity issues
To:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        lcherian@marvell.com, jerinj@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>
References: <20231101074919.2614608-1-sumang@marvell.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231101074919.2614608-1-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/11/2023 à 08:49, Suman Ghosh a écrit :
> Fix all klockwork and coverity issues reported on AF and PF/VF driver.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>   .../net/ethernet/marvell/octeontx2/af/cgx.c   | 14 ++++-
>   .../marvell/octeontx2/af/mcs_rvu_if.c         |  8 ++-
>   .../net/ethernet/marvell/octeontx2/af/ptp.c   | 11 +++-
>   .../ethernet/marvell/octeontx2/af/rvu_cpt.c   |  2 +-
>   .../marvell/octeontx2/af/rvu_debugfs.c        |  8 ++-
>   .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  2 +-
>   .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  2 +-
>   .../marvell/octeontx2/nic/otx2_common.c       |  8 +--
>   .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  3 +
>   .../ethernet/marvell/octeontx2/nic/otx2_reg.h | 55 ++++++++++---------
>   .../marvell/octeontx2/nic/otx2_txrx.c         |  2 +-
>   .../net/ethernet/marvell/octeontx2/nic/qos.c  |  7 ++-
>   12 files changed, 77 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 6c70c8498690..5a672888577e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -457,12 +457,19 @@ int cgx_lmac_addr_max_entries_get(u8 cgx_id, u8 lmac_id)
>   u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
>   {
>   	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
> -	struct lmac *lmac = lmac_pdata(lmac_id, cgx_dev);
>   	struct mac_ops *mac_ops;
> +	struct lmac *lmac;
>   	int index;
>   	u64 cfg;
>   	int id;
>   
> +	if (!cgx_dev)
> +		return 0;
> +
> +	lmac = lmac_pdata(lmac_id, cgx_dev);
> +	if (!lmac)
> +		return 0;
> +
>   	mac_ops = cgx_dev->mac_ops;
>   
>   	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
> @@ -955,6 +962,9 @@ int cgx_lmac_pfc_config(void *cgxd, int lmac_id, u8 tx_pause,
>   
>   	/* Write source MAC address which will be filled into PFC packet */
>   	cfg = cgx_lmac_addr_get(cgx->cgx_id, lmac_id);
> +	if (!cfg)
> +		return -ENODEV;
> +
>   	cgx_write(cgx, lmac_id, CGXX_SMUX_SMAC, cfg);
>   
>   	return 0;
> @@ -1617,7 +1627,7 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
>   static int cgx_lmac_init(struct cgx *cgx)
>   {
>   	struct lmac *lmac;
> -	u64 lmac_list;
> +	u64 lmac_list = 0;

This is not needed.
The static checker is not good enough to see it, that's all :).

>   	int i, err;
>   
>   	/* lmac_list specifies which lmacs are enabled
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> index dfd23580e3b8..1b0b022f5493 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> @@ -625,8 +625,8 @@ int rvu_mbox_handler_mcs_free_resources(struct rvu *rvu,
>   {
>   	u16 pcifunc = req->hdr.pcifunc;
>   	struct mcs_rsrc_map *map;
> +	int rc = -EINVAL;
>   	struct mcs *mcs;
> -	int rc = 0;

This should be argumented.

This changes the behavior of the code. Why should we return -EINVAL if 
nothing in the switch below matches?

>   
>   	if (req->mcs_id >= rvu->mcs_blk_cnt)
>   		return MCS_AF_ERR_INVALID_MCSID;
> @@ -675,8 +675,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
>   {
>   	u16 pcifunc = req->hdr.pcifunc;
>   	struct mcs_rsrc_map *map;
> +	int rsrc_id = -EINVAL, i;
>   	struct mcs *mcs;
> -	int rsrc_id, i;

Same

>   
>   	if (req->mcs_id >= rvu->mcs_blk_cnt)
>   		return MCS_AF_ERR_INVALID_MCSID;
> @@ -737,6 +737,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
>   			rsp->rsrc_cnt++;
>   		}
>   		break;
> +	default:
> +		goto exit;
>   	}
>   
>   	rsp->rsrc_type = req->rsrc_type;
> @@ -849,7 +851,7 @@ int rvu_mbox_handler_mcs_ctrl_pkt_rule_write(struct rvu *rvu,
>   static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
>   {
>   	struct mcs *mcs = mcs_get_pdata(0);
> -	unsigned long lmac_bmap;
> +	unsigned long lmac_bmap = 0;
>   	int cgx, lmac, port;
>   
>   	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> index bcc96eed2481..a199b1123ba7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> @@ -518,6 +518,7 @@ static int ptp_probe(struct pci_dev *pdev,
>   		     const struct pci_device_id *ent)
>   {
>   	struct ptp *ptp;
> +	void __iomem * const *base;
>   	int err;
>   
>   	ptp = kzalloc(sizeof(*ptp), GFP_KERNEL);
> @@ -536,7 +537,15 @@ static int ptp_probe(struct pci_dev *pdev,
>   	if (err)
>   		goto error_free;
>   
> -	ptp->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> +	base = pcim_iomap_table(pdev);
> +	if (!base)
> +		goto error_free;
> +
> +	ptp->reg_base = base[PCI_PTP_BAR_NO];
> +	if (!ptp->reg_base) {
> +		err = -ENODEV;
> +		goto error_free;
> +	}
>   
>   	pci_set_drvdata(pdev, ptp);
>   	if (!first_ptp_block)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> index f047185f38e0..a1a919fcda47 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> @@ -43,7 +43,7 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
>   	struct rvu *rvu = block->rvu;
>   	int blkaddr = block->addr;
>   	u64 reg, val;
> -	int i, eng;
> +	int i, eng = 0;

Why is this the correct value if nothing else matches in the switch below?

>   	u8 grp;
>   
>   	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index bd817ee88735..307942ff1b10 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -519,12 +519,16 @@ RVU_DEBUG_SEQ_FOPS(mcs_rx_secy_stats, mcs_rx_secy_stats_display, NULL);
>   static void rvu_dbg_mcs_init(struct rvu *rvu)
>   {
>   	struct mcs *mcs;
> -	char dname[10];
> +	char *dname = NULL;

=NULL is not needed, but see below.

>   	int i;
>   
>   	if (!rvu->mcs_blk_cnt)
>   		return;
>   
> +	dname = kmalloc_array(rvu->mcs_blk_cnt, sizeof(char), GFP_KERNEL);

Hi,

I think that kmalloc() would be enough here.

More importantly, I think it is wrong.
This dbname buffer is used to store "mcs%d". %d can be up to 
rvu->mcs_blk_cnt, but it does not require that amount of memory.

(if mcs_blk_cnt = 1000, we need 3 + 4 + 1 = 8 byte ("mcs" + "1000" + 
\0), not 1000 bytes.

If mcs_blk_cnt is small, we under-allocate, if it is high we allocate 
way too much memory.

Maybe kasprintf()/kfree() would be a cleaner option.


> +	if (!dname)
> +		return;
> +
>   	rvu->rvu_dbg.mcs_root = debugfs_create_dir("mcs", rvu->rvu_dbg.root);
>   
>   	for (i = 0; i < rvu->mcs_blk_cnt; i++) {
> @@ -568,6 +572,8 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
>   		debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_tx, mcs,
>   				    &rvu_dbg_mcs_tx_port_stats_fops);
>   	}
> +
> +	kfree(dname);
>   }
>   

...

(I have not looked the code below that)

