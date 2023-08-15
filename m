Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94177CF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjHOPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbjHOPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:34:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7CC198A;
        Tue, 15 Aug 2023 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mCMaRiXD+SX4iDd+124jIz0NjwtRlkHyRZGjSWdpLXU=; b=be3WlWR45D2YLBsaPl5M0GIyN4
        NX8ToHxHcuoz2oKYGrtVZ2dlXuokGFXO/NZJoODnu4FCoJNczN/2bUDJTcu5NRydKYakqpoOOk3+B
        YygYAhxbqkW4O1j/mK3RZitkMBqncwo0+oBIL5ZW3eLiycBp206Ij6L9Ff7pVkt4aGSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVw3E-004AX3-GL; Tue, 15 Aug 2023 17:33:44 +0200
Date:   Tue, 15 Aug 2023 17:33:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815143756.106623-2-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:37:55PM +0800, Justin Lai wrote:
> This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
> applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> 
> Below is a simplified block diagram of the chip and its relevant interfaces.
> 
>           *************************
>           *                       *
>           *  CPU network device   *
>           *    ____________       *
>           *   |            |      *
>           *   |  PCIE Host |      *
>           *************************
>                     ||
>                    PCIE
>                     ||
>   ****************************************
>   *          | PCIE Endpoint |           *
>   *          |---------------|           *
>   *              | GMAC |                *
>   *              |------|  Realtek       *
>   *                 ||   RTL90xx Series  *
>   *                 ||                   *
>   *    _____________||______________     *
>   *   |            |MAC|            |    *
>   *   |            |---|            |    *
>   *   |                             |    *
>   *   |     Ethernet Switch Core    |    *
>   *   |                             |    *
>   *   |  -----             -----    |    *
>   *   |  |MAC| ............|MAC|    |    *
>   *   |__|___|_____________|___|____|    *
>   *      |PHY| ............|PHY|         *
>   *      -----             -----         *
>   *********||****************||***********
> This driver is mainly used to control GMAC, but does not control the switch core, so it is not the same as DSA.
> In addition, the GMAC is not directly connected to the PHY, but directly connected to the mac of the switch core,
> so there is no need for PHY handing.

So this describes your board? Is the MAC and the swtich two separate
chips? Is it however possible to connect the GMAC to a PHY? Could some
OEM purchase the chipset and build a board with a PHY? We write MAC
drivers around what the MAC can do, not what one specific board
allows.

What MAC drivers do to support being connected to a switch like this
is use a fixed-link PHY, via phylink. This gives a virtual PHY, which
supports one speed. The MAC driver then just uses the phylink API as
normal.

On your board, how is the switch controlled? Is there an MDIO bus as
part of the MAC? If so, you should add an MDIO bus master driver.

> +/******************************************************************************
> + *  This product is covered by one or more of the following patents:
> + *  US6,570,884, US6,115,776, and US6,327,625.
> + ******************************************************************************/

How many other drivers mentions patents? I'm not a lawyer, but doesn't
the GPL say something about this?

> +/* 0x05F3 = 1522bye + 1 */
> +#define RX_BUF_SIZE 0x05F3u

Why not just use:

#define RX_BUF_SIZE 1522 + 1

You don't need the comment then. Better still if you can express this
in terms of ETH_FRAME_LEN, ETH_FCS_LEN etc.

> +/* write/read MMIO register */
> +#define RTL_W8(reg, val8)   writeb((val8), ioaddr + (reg))
> +#define RTL_W16(reg, val16) writew((val16), ioaddr + (reg))
> +#define RTL_W32(reg, val32) writel((val32), ioaddr + (reg))

macros should only access what is passed to them. ioaddr is not
passed...

Using small functions would be better, you can then do type checking,
ensure that val8 is a u8, val16 is a u16 etc.

> +/*****************************************************************************/
> +#define RTL_NETIF_RX_SCHEDULE_PREP(dev, napi) napi_schedule_prep(napi)
> +#define __RTL_NETIF_RX_SCHEDULE(dev, napi)    __napi_schedule(napi)

No wrappers. Also, it seems odd you are using a __foo
function. Anything with a __ prefix is mean to be hidden.

> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/cdev.h>
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/delay.h>
> +#include <linux/if_vlan.h>
> +#include <linux/crc32.h>
> +#include <linux/interrupt.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/tcp.h>
> +#include <linux/init.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/prefetch.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mdio.h>
> +#include <net/ip6_checksum.h>
> +#include <net/pkt_cls.h>
> +#include <linux/io.h>
> +#include <asm/irq.h>
> +
> +#include "rtase.h"
> +
> +/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
> + * The RTL chips use a 64 element hash table based on the Ethernet CRC.
> + */
> +#define _R(NAME, MAC, JUM_FRAME_SZ)                                       \
> +	{                                                                 \
> +		.name = NAME, .mcfg = MAC, .jumbo_frame_sz = JUM_FRAME_SZ \
> +	}
> +
> +static const struct {
> +	const char *name;
> +	u8 mcfg;
> +	u16 jumbo_frame_sz;
> +} rtl_chip_info[] = {_R("RTL9072", CFG_METHOD_1, JUMBO_FRAME_9K),
> +
> +		     _R("Unknown", CFG_METHOD_DEFAULT, JUMBO_FRAME_1K)};
> +#undef _R

The R macro just seems like obfuscation.

> +/******************************************************************************
> + * Module Parameters
> + ******************************************************************************/
> +static unsigned int txq_ctrl = 1;
> +static unsigned int func_txq_num = 1;
> +static unsigned int func_rxq_num = 1;
> +static unsigned int interrupt_num = 1;
> +static int rx_copybreak;
> +
> +module_param(txq_ctrl, uint, 0);
> +MODULE_PARM_DESC(txq_ctrl, "The maximum number of TX queues for PF.");
> +
> +module_param(func_txq_num, uint, 0);
> +MODULE_PARM_DESC(func_txq_num, "TX queue number for this function.");
> +
> +module_param(func_rxq_num, uint, 0);
> +MODULE_PARM_DESC(func_rxq_num, "RX queue number for this function.");
> +
> +module_param(interrupt_num, uint, 0);
> +MODULE_PARM_DESC(interrupt_num, "Interrupt Vector number for this function.");
> +
> +module_param(rx_copybreak, int, 0);
> +MODULE_PARM_DESC(rx_copybreak, "Copy breakpoint for copy-only-tiny-frames");

No module parameters. Please delete them.

> +static int rtase_open(struct net_device *dev);
> +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb, struct net_device *dev);
> +static void rtase_set_rx_mode(struct net_device *dev);
> +static int rtase_set_mac_address(struct net_device *dev, void *p);
> +static int rtase_change_mtu(struct net_device *dev, int new_mtu);
> +static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue);
> +static void rtase_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats);
> +static int rtase_vlan_rx_add_vid(struct net_device *dev, __be16 protocol, u16 vid);
> +static int rtase_vlan_rx_kill_vid(struct net_device *dev, __be16 protocol, u16 vid);
> +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data);
> +
> +static irqreturn_t rtase_interrupt(int irq, void *dev_instance);
> +static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance);
> +static void rtase_hw_config(struct net_device *dev);
> +static int rtase_close(struct net_device *dev);
> +static void rtase_down(struct net_device *dev);
> +static s32 rtase_init_ring(const struct net_device *dev);
> +static void rtase_init_netdev_ops(struct net_device *dev);
> +static void rtase_rar_set(const struct rtase_private *tp, const uint8_t *addr);
> +static void rtase_desc_addr_fill(const struct rtase_private *tp);
> +static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx);
> +static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx);
> +static void rtase_set_mar(const struct rtase_private *tp);
> +static s32 tx_handler(struct rtase_ring *ring, s32 budget);
> +static s32 rx_handler(struct rtase_ring *ring, s32 budget);
> +static int rtase_poll(struct napi_struct *napi, int budget);
> +static void rtase_sw_reset(struct net_device *dev);
> +static void rtase_hw_start(const struct net_device *dev);
> +static void rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t paddr);
> +static void mac_ocp_write(const struct rtase_private *tp, u16 reg_addr, u16 value);

Remove all these put the code in the right order so that they are not
needed. The only time you need forward definitions is for recursion.


    Andrew

---
pw-bot: cr
