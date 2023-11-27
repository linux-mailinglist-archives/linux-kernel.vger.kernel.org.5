Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376107F9D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjK0KCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjK0KCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:02:53 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009EE1;
        Mon, 27 Nov 2023 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6gn5d7KUQfLRFLOyvCIufG4QhOPBca0kxJGMueryZQ0=; b=yWWws5U864Dp22dYB1WTv/gwrf
        vqdL8UM518iqSuLd6KgN8/JQBROV/eybM1E7XguQw477cPHp4nYVLjI40Qu/9VBCSXXAjyyCZWeM1
        eUJFVOuQnZ1r20jw8g5qsh9kisKUBVQhDKuE0MgzMn2S7pOO1NEmZnYEjMDH5srVHrSTEVUGEO+uF
        UpWBzBQcbS/4Y8NNaTMv2l/DreyEzRxgFNyejTEa32vWaNGOziB9ahh+tjAiN+itqd/RXqSYcVOJ8
        21ZYuqePg7DSgcvXHDDq5Ln5cXdVw3Fgk5r7lzCCtRkX3Nx8IwmFnORm/qjnC8yR/qNM50BJHx95r
        BG4AXsgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47392)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7YS3-0005bE-0f;
        Mon, 27 Nov 2023 10:02:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7YS3-0001oA-PQ; Mon, 27 Nov 2023 10:02:51 +0000
Date:   Mon, 27 Nov 2023 10:02:51 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v2] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
Message-ID: <ZWRpS9CL5OarIOkA@shell.armlinux.org.uk>
References: <20231127002924.22384-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127002924.22384-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 01:29:24AM +0100, Christian Marangi wrote:
> On further testing on BE target with kernel test robot, it was notice
> that the endianness conversion for addr and CRC in fw_load_memory was
> wrong and actually not needed. Values in define doesn't get converted
> and are passed as is and hardcoded values are already in what the PHY
> require, that is LE.
> 
> Use get_unaligned_le32 instead of get_unaligned for FW data word load to
> correctly convert data in the correct order to follow system endian.
> 
> Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> get_unaligned_be32 instead. The word is taken from firmware and is
> always LE, the mailbox will emit a BE CRC from BE word hence the
> word needs to be swapped on u8 to u32 cast on LE system.
> This is needed as crc_ccitt_false will recast u32 to u8 and read order
> changes between BE and LE system. By using get_unaligned_be32, word is
> swapped only when needed resulting in the correct CRC calculated.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311210414.sEJZjlcD-lkp@intel.com/
> Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
> Tested-by: Robert Marko <robimarko@gmail.com> # ipq8072 LE device
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Add further explaination in commit description
> - Fix wrong CRC conversion and swap only when needed
> 
>  drivers/net/phy/aquantia/aquantia_firmware.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index c5f292b1c4c8..c12e8a3acb77 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -93,9 +93,9 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
>  	u16 crc = 0, up_crc;
>  	size_t pos;
>  
> -	/* PHY expect addr in LE */
> -	addr = (__force u32)cpu_to_le32(addr);
> -
> +	/* PHY expect addr in LE. Hardcoded addr in defines are
> +	 * already in this format.
> +	 */

Please fix this comment. No, the address is not in LE. You program the
address into a register in the PHY. Bit 0 of the register is bit 0 of
the data field on the MDIO bus, and bit 0 of the value passed to
phy_write_mmd() which is in CPU endian. Bit 15 of the register is bit
15 of the data field on the MDIO bus, which is bit 15 of the value
passed to phy_write_mmd().

So the talk of "LE" here is meaningless. Please stop over-complicating
this.

>  	phy_write_mmd(phydev, MDIO_MMD_VEND1,
>  		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
>  		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> @@ -113,7 +113,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
>  		u32 word;
>  
>  		/* FW data is always stored in little-endian */
> -		word = get_unaligned((const u32 *)(data + pos));
> +		word = get_unaligned_le32((const u32 *)(data + pos));

This comment is appropriate, and get_unaligned_le32() is correct.

>  
>  		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
>  			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
> @@ -125,10 +125,10 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
>  			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
>  
>  		/* calculate CRC as we load data to the mailbox.
> -		 * We convert word to big-endian as PHY is BE and mailbox will
> +		 * We read word as big-endian as PHY is BE and mailbox will
>  		 * return a BE CRC.

Is that true (about returning a BE CRC) ?

>  		 */
> -		word = (__force u32)cpu_to_be32(word);
> +		word = get_unaligned_be32((const u32 *)(data + pos));
>  		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
>  	}

And you _still_ haven't taken on board my issue with this, sigh. No,
this will be subject to variation in result from CPU endianness.

For the sake of your education on the first point, do this:

	u16 le_crc = 0, be_crc = 0, up_crc;

...
		le_crc = crc_ccitt_false(le_crc, (u8 *)&word, sizeof(word));
		word = get_unaligned_be32((const u32 *)(data + pos));
		be_crc = crc_ccitt_false(be_crc, (u8 *)&word, sizeof(word));
	}

	printk("le_crc=0x%04x be_crc=0x%04x\n", le_crc, be_crc);

What you will find is that the two CRCs are _totally_ different - not
just different in endian, but different in value as well. The endianness
of the input data does not simply change the endianness of the resulting
CRC, it will change the value.

So, returning a "BE CRC" has no bearing on whether the data passed to
the CRC function needs to be in big endian order or not.

On the second point, as I have stated numerous times, and it seems I'm
not getting anywhere with:


	u32 word;
	int i;
	u8 *p;

	word = 0x01020304;

	p = (u8 *)&word;

	for (i = 0; i < sizeof(word); i++)
		printf("p[%d] = %02x\n", i, p[i]);

on little endian machines will print:

p[0] = 0x01
p[1] = 0x02
p[2] = 0x03
p[3] = 0x04

but on big endian machines will print:

p[0] = 0x04
p[1] = 0x03
p[2] = 0x02
p[3] = 0x01

The order in which you provide the bytes to a CRC function will change
the CRC value. So, the endianness of the machine/CPU your code will be
running on will change the resulting CRC.

Your code is buggy.

I've given you solutions to it, but you are very resistant to these
suggestions.

I know endianness can be difficult to those who don't understand it,
but I've described it numerous times, complete with code examples to
show how things change - including for the above issue. It seems I'm
demonstrably waiting my time because it's having very little effect.

Therefore, quite simply, NAK to this patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
