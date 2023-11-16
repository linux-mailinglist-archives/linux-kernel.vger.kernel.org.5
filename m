Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804C7EE65B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbjKPSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKPSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:06:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1AE11D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:06:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC29C433C8;
        Thu, 16 Nov 2023 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157975;
        bh=W30H6gj3P6m6Ol1y2bZRpyLOHWjyiFY0SiveHtAQ0vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWBKk1/tFeIS9KrBdXTlWr2RN6G2XLdDOmSylXLuqUUcAVQEN+YKPmDr6ZrBWm0Ym
         PeY6eCErvLxCL6Fd+//e4mzLqzR5gXNzXaTd6fTSLTSN5r4so43rSzcy9SJiyEVCVk
         TZZFFEdQz8cnOJ05sEe+rBOf+WqmEmyG8CplK9Ckg/GuU2oGmwx8bTDXFxvxYTxX9B
         MGjLRtJv8dp1Xb422IySbcG3M1CzKK2r/+CU1pAtCNZgyBaWYbBVnoURSt2AFx6fBN
         rdiUnMyajD5M3pJO36Oyj54nKvNw2oX6Xpd/O44y1bjRcxXrsUyYPLRhjqu8wtZsss
         ucotj7B+P0XyA==
Date:   Thu, 16 Nov 2023 18:06:10 +0000
From:   Simon Horman <horms@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
        larry.chiu@realtek.com
Subject: Re: [PATCH net-next v11 05/13] net:ethernet:realtek:rtase: Implement
 hardware configuration function
Message-ID: <20231116180610.GG109951@vergenet.net>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
 <20231115133414.1221480-6-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115133414.1221480-6-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:34:06PM +0800, Justin Lai wrote:
> Implement rtase_hw_config to set default hardware settings, including
> setting interrupt mitigation, tx/rx DMA burst, interframe gap time,
> rx packet filter, near fifo threshold and fill descriptor ring and
> tally counter address, and enable flow control. When filling the
> rx descriptor ring, the first group of queues needs to be processed
> separately because the positions of the first group of queues are not
> regular with other subsequent groups. The other queues are all newly
> added features, but we want to retain the original design. So they were
> not put together.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Hi Justin,

some minor feedback from my side.

* I think that "rtase: " would be a more appropriate prefix
  for the patches in this patch-set.

  Subject: [PATCH net-next vX m/n] rtase: ...

...

> diff --git a/drivers/net/ethernet/realtek/rtase/tt.c b/drivers/net/ethernet/realtek/rtase/tt.c

...

> new file mode 100644
> index 000000000000..5ea4d51fcc47
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/tt.c

...

> +static void rtase_tx_clear_range(struct rtase_ring *ring, u32 start, u32 n)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	struct tx_desc *desc_base = ring->desc;
> +	u32 i;

nit: Please consider using reverse xmas tree - longest line to shortest -
     for new Networking code.

...

> +static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
> +{
> +	u8 ip_protocol;
> +	u32 csum_cmd;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):
> +		csum_cmd = TX_IPCS_C;
> +		ip_protocol = ip_hdr(skb)->protocol;
> +		break;
> +
> +	case htons(ETH_P_IPV6):
> +		csum_cmd = TX_IPV6F_C;
> +		ip_protocol = ipv6_hdr(skb)->nexthdr;
> +		break;
> +
> +	default:
> +		ip_protocol = IPPROTO_RAW;
> +		break;

If the default branch is taken in this switch statement,
then csum_cmd is used uninitialised below.

As flagged by a clang-16 W=1 build

> +	}
> +
> +	if (ip_protocol == IPPROTO_TCP)
> +		csum_cmd |= TX_TCPCS_C;
> +	else if (ip_protocol == IPPROTO_UDP)
> +		csum_cmd |= TX_UDPCS_C;
> +	else
> +		WARN_ON_ONCE(1);
> +
> +	csum_cmd |= u32_encode_bits(skb_transport_offset(skb), TCPHO_MASK);
> +
> +	return csum_cmd;
> +}
> +
> +static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
> +			    u32 opts1, u32 opts2)
> +{
> +	const struct skb_shared_info *info = skb_shinfo(skb);
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	const u8 nr_frags = info->nr_frags;
> +	struct tx_desc *txd = NULL;
> +	u32 cur_frag, entry;
> +	u64 pkt_len_cnt = 0;

pkt_len_cnt is initialised here...

> +
> +	entry = ring->cur_idx;
> +	for (cur_frag = 0; cur_frag < nr_frags; cur_frag++) {
> +		const skb_frag_t *frag = &info->frags[cur_frag];
> +		dma_addr_t mapping;
> +		u32 status, len;
> +		void *addr;
> +
> +		entry = (entry + 1) % NUM_DESC;
> +
> +		txd = ring->desc + sizeof(struct tx_desc) * entry;
> +		len = skb_frag_size(frag);
> +		addr = skb_frag_address(frag);
> +		mapping = dma_map_single(&tp->pdev->dev, addr, len,
> +					 DMA_TO_DEVICE);
> +
> +		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> +			if (unlikely(net_ratelimit()))
> +				netdev_err(tp->dev,
> +					   "Failed to map TX fragments DMA!\n");
> +
> +			goto err_out;
> +		}
> +
> +		if (((entry + 1) % NUM_DESC) == 0)
> +			status = (opts1 | len | RING_END);
> +		else
> +			status = opts1 | len;
> +
> +		if (cur_frag == (nr_frags - 1)) {
> +			ring->skbuff[entry] = skb;
> +			status |= TX_LAST_FRAG;
> +		}
> +
> +		ring->mis.len[entry] = len;
> +		txd->addr = cpu_to_le64(mapping);
> +		txd->opts2 = cpu_to_le32(opts2);
> +
> +		/* make sure the operating fields have been updated */
> +		wmb();
> +		txd->opts1 = cpu_to_le32(status);
> +		pkt_len_cnt += len;

... and incremented here. But is otherwise unused.

As flagged by a clang-16 W=1 build.

> +	}
> +
> +	return cur_frag;
> +
> +err_out:
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
> +	return -EIO;
> +}

...

> +static void rtase_dump_state(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters;
> +	int max_reg_size = RTASE_PCI_REGS_SIZE;
> +	const struct rtase_ring *ring;
> +	u32 dword_rd;
> +	int n = 0;
> +
> +	ring = &tp->tx_ring[0];
> +	netdev_err(dev, "Tx descriptor info:\n");
> +	netdev_err(dev, "Tx curIdx = 0x%x\n", ring->cur_idx);
> +	netdev_err(dev, "Tx dirtyIdx = 0x%x\n", ring->dirty_idx);
> +	netdev_err(dev, "Tx phyAddr = 0x%llx\n", ring->phy_addr);
> +
> +	ring = &tp->rx_ring[0];
> +	netdev_err(dev, "Rx descriptor info:\n");
> +	netdev_err(dev, "Rx curIdx = 0x%x\n", ring->cur_idx);
> +	netdev_err(dev, "Rx dirtyIdx = 0x%x\n", ring->dirty_idx);
> +	netdev_err(dev, "Rx phyAddr = 0x%llx\n", ring->phy_addr);
> +
> +	netdev_err(dev, "Device Registers:\n");
> +	netdev_err(dev, "Chip Command = 0x%02x\n", rtase_r8(tp, RTASE_CHIP_CMD));
> +	netdev_err(dev, "IMR = %08x\n", rtase_r32(tp, RTASE_IMR0));
> +	netdev_err(dev, "ISR = %08x\n", rtase_r32(tp, RTASE_ISR0));
> +	netdev_err(dev, "Boot Ctrl Reg(0xE004) = %04x\n",
> +		   rtase_r16(tp, RTASE_BOOT_CTL));
> +	netdev_err(dev, "EPHY ISR(0xE014) = %04x\n",
> +		   rtase_r16(tp, RTASE_EPHY_ISR));
> +	netdev_err(dev, "EPHY IMR(0xE016) = %04x\n",
> +		   rtase_r16(tp, RTASE_EPHY_IMR));
> +	netdev_err(dev, "CLKSW SET REG(0xE018) = %04x\n",
> +		   rtase_r16(tp, RTASE_CLKSW_SET));
> +
> +	netdev_err(dev, "Dump PCI Registers:\n");
> +
> +	while (n < max_reg_size) {
> +		if ((n % RTASE_DWORD_MOD) == 0)
> +			netdev_err(tp->dev, "0x%03x:\n", n);
> +
> +		pci_read_config_dword(tp->pdev, n, &dword_rd);
> +		netdev_err(tp->dev, "%08x\n", dword_rd);
> +		n += 4;
> +	}
> +
> +	netdev_err(dev, "Dump tally counter:\n");
> +	counters = tp->tally_vaddr;
> +	rtase_dump_tally_counter(tp);
> +
> +	netdev_err(dev, "tx_packets %lld\n",
> +		   le64_to_cpu(counters->tx_packets));

tx_packets is __le16 not __le64, so I think you want:

	netdev_err(dev, "rx_missed %d\n",
		   le16_to_cpu(counters->rx_missed));

Likewise for align_errors, tx_aborted, and tx_underun.

As flagged by Sparse

> +	netdev_err(dev, "rx_packets %lld\n",
> +		   le64_to_cpu(counters->rx_packets));
> +	netdev_err(dev, "tx_errors %lld\n",
> +		   le64_to_cpu(counters->tx_errors));
> +	netdev_err(dev, "rx_missed %lld\n",
> +		   le64_to_cpu(counters->rx_missed));
> +	netdev_err(dev, "align_errors %lld\n",
> +		   le64_to_cpu(counters->align_errors));
> +	netdev_err(dev, "tx_one_collision %lld\n",
> +		   le64_to_cpu(counters->tx_one_collision));

Similarly, tx_one_collision is __le32 not __le64, so I think you want:
.
	netdev_err(dev, "tx_one_collision %d\n",
		   le32_to_cpu(counters->tx_one_collision));

Likewise for tx_multi_collision, and rx_multicast.

There area also similar problems in rtase_main.c:rtase_dump_state(),
added elsewhere in this patch-set.

> +	netdev_err(dev, "tx_multi_collision %lld\n",
> +		   le64_to_cpu(counters->tx_multi_collision));
> +	netdev_err(dev, "rx_unicast %lld\n",
> +		   le64_to_cpu(counters->rx_unicast));
> +	netdev_err(dev, "rx_broadcast %lld\n",
> +		   le64_to_cpu(counters->rx_broadcast));
> +	netdev_err(dev, "rx_multicast %lld\n",
> +		   le64_to_cpu(counters->rx_multicast));
> +	netdev_err(dev, "tx_aborted %lld\n",
> +		   le64_to_cpu(counters->tx_aborted));
> +	netdev_err(dev, "tx_underun %lld\n",
> +		   le64_to_cpu(counters->tx_underun));
> +}

...

> +static const char rtase_gstrings[][ETH_GSTRING_LEN] = {
> +	"tx_packets",
> +	"rx_packets",
> +	"tx_errors",
> +	"rx_errors",
> +	"rx_missed",
> +	"align_errors",
> +	"tx_single_collisions",
> +	"tx_multi_collisions",
> +	"unicast",
> +	"broadcast",
> +	"multicast",
> +	"tx_aborted",
> +	"tx_underrun",
> +};
> +
> +static void rtase_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		memcpy(data, *rtase_gstrings, sizeof(rtase_gstrings));

Compilers don't think this is seem correct, because *rtase_gsrings is the
first element of that array, rather than the entire array. And thus
is only ETH_GSTRING_LEN bytes long, rather than n * ETH_GSTRING_LEN bytes
long.

I think what you want is (compile tested only!):

		memcpy(data, rtase_gstrings, sizeof(rtase_gstrings));

Flagged by a clang-16 W=1 build.

> +		break;
> +	}
> +}

...

> +static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
> +			    void __iomem **ioaddr_out)
> +{
> +	struct net_device *dev;
> +	void __iomem *ioaddr;
> +	int ret = -ENOMEM;
> +
> +	/* dev zeroed in alloc_etherdev */
> +	dev = alloc_etherdev_mq(sizeof(struct rtase_private),
> +				RTASE_FUNC_TXQ_NUM);
> +	if (!dev)
> +		goto err_out;
> +
> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret < 0)
> +		goto err_out_free_dev;
> +
> +	/* make sure PCI base addr 1 is MMIO */
> +	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM)) {
> +		ret = -ENODEV;
> +		goto err_out_disable;
> +	}
> +
> +	/* check for weird/broken PCI region reporting */
> +	if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
> +		ret = -ENODEV;
> +		goto err_out_disable;
> +	}
> +
> +	ret = pci_request_regions(pdev, KBUILD_MODNAME);
> +	if (ret < 0)
> +		goto err_out_disable;
> +
> +	if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
> +		dev->features |= NETIF_F_HIGHDMA;
> +	else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
> +		goto err_out_free_res;
> +	else
> +		dev_info(&pdev->dev, "DMA_BIT_MASK: 32\n");
> +
> +	pci_set_master(pdev);
> +
> +	/* ioremap MMIO region */
> +	ioaddr = ioremap(pci_resource_start(pdev, 2),
> +			 pci_resource_len(pdev, 2));
> +	if (!ioaddr) {
> +		ret = -EIO;
> +		goto err_out_free_res;
> +	}
> +
> +	*ioaddr_out = ioaddr;
> +	*dev_out = dev;
> +	goto out;

nit: I think it's slightly more idiomatic to simply return 0 here,
     and drop the out label below.

> +
> +err_out_free_res:
> +	pci_release_regions(pdev);
> +
> +err_out_disable:
> +	pci_disable_device(pdev);
> +
> +err_out_free_dev:
> +	free_netdev(dev);
> +
> +err_out:
> +	*ioaddr_out = NULL;
> +	*dev_out = NULL;
> +
> +out:
> +	return ret;
> +}

...

> diff --git a/drivers/net/ethernet/realtek/rtase/tt.h b/drivers/net/ethernet/realtek/rtase/tt.h
> new file mode 100644
> index 000000000000..9239c518c504
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/tt.h
> @@ -0,0 +1,353 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + *  rtase is the Linux device driver released for Realtek Automotive Switch
> + *  controllers with PCI-Express interface.
> + *
> + *  Copyright(c) 2023 Realtek Semiconductor Corp.
> + */
> +
> +#ifndef _RTASE_H_
> +#define _RTASE_H_

If the code in tt.h is only used in tt.c, then perhaps the
code can simply be moved into tt.c.

...
