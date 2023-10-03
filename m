Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117D07B6CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjJCPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJCPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:20:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BEBB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:20:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B73DC433CC;
        Tue,  3 Oct 2023 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696346412;
        bh=B9aRfdqIE7RbWkkETKISrpJ4KaIc5r01R4PIwvSQEV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e07kazDDDZwmEg3SFgO/ITwOA07wD2ap4EuBIRXPMNkfm1GV/nMnb5rTKXxBNP/mJ
         nkLOGuAiWdtN1ENiwrUG8p9+zuMKqw7zg9zOfHOIkYLTXtO/rbHgwAleExAAmVqxFA
         GYfWcu/WYyZDgpZ9YrlyqVItJI3sQTwM4W8Kc9Gts5WVy2mGyhL+uiAmdpwijTZT1i
         sTJHdoLePLaq0jmiGdxG1QOm+dF4ZvFr+ZKpVh9A79uh2W0cXX7a2c4856E0A5DyML
         N1T27ClljF1bnFI4m126mNJ5PWzEt5YUr5Zm6CvAr9jjCvY1HiaqJUmGXFusca5wmn
         aghr7kQvFTjcg==
Date:   Tue, 3 Oct 2023 17:20:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <ZRwxJwtAsU/z76+5@kernel.org>
References: <20230930104008.234831-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930104008.234831-1-robimarko@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 12:39:44PM +0200, Robert Marko wrote:
> Aquantia PHY-s require firmware to be loaded before they start operating.
> It can be automatically loaded in case when there is a SPI-NOR connected
> to Aquantia PHY-s or can be loaded from the host via MDIO.
> 
> This patch adds support for loading the firmware via MDIO as in most cases
> there is no SPI-NOR being used to save on cost.
> Firmware loading code itself is ported from mainline U-boot with cleanups.
> 
> The firmware has mixed values both in big and little endian.
> PHY core itself is big-endian but it expects values to be in little-endian.
> The firmware is little-endian but CRC-16 value for it is stored at the end
> of firmware in big-endian.
> 
> It seems the PHY does the conversion internally from firmware that is
> little-endian to the PHY that is big-endian on using the mailbox
> but mailbox returns a big-endian CRC-16 to verify the written data
> integrity.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

...

> diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c

...

> @@ -677,6 +735,142 @@ static int aqr107_wait_processor_intensive_op(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/* load data into the phy's memory */
> +static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
> +				const u8 *data, size_t len)
> +{
> +	u16 crc = 0, up_crc;
> +	size_t pos;
> +
> +	/* PHY expect addr in LE */
> +	addr = cpu_to_le32(addr);

Hi Christian and Robert,


The type of addr us u32, but here it is assigned a __le32 value.

As flagged by Sparse.

> +
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));
> +
> +	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
> +		u32 word = 0;
> +
> +		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE6,
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(word));
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE1,
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
> +
> +		/* calculate CRC as we load data to the mailbox.
> +		 * We convert word to big-endiang as PHY is BE and ailbox will
> +		 * return a BE crc.
> +		 */
> +		word = cpu_to_be32(word);
> +		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> +	}
> +
> +	up_crc = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE2);
> +	if (crc != up_crc) {
> +		phydev_err(phydev, "CRC mismatch: calculated 0x%04x PHY 0x%04x\n",
> +			   crc, up_crc);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size)
> +{
> +	const struct aqr_fw_header *header;
> +	u32 iram_offset = 0, iram_size = 0;
> +	u32 dram_offset = 0, dram_size = 0;
> +	char version[VERSION_STRING_SIZE];
> +	u16 calculated_crc, read_crc;
> +	u32 primary_offset = 0;
> +	int ret;
> +
> +	/* extract saved crc at the end of the fw */
> +	memcpy(&read_crc, data + size - 2, sizeof(read_crc));
> +	/* crc is saved in big-endian as PHY is BE */
> +	read_crc = be16_to_cpu(read_crc);

The type of read_crc is u16.
But be16_to_cpu expects a __be16 argument.

As flagged by Sparse.


> +	calculated_crc = crc_ccitt_false(0, data, size - 2);
> +	if (read_crc != calculated_crc) {
> +		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
> +			   read_crc, calculated_crc);
> +		return -EINVAL;
> +	}
> +
> +	/* Get the primary offset to extract DRAM and IRAM sections. */
> +	memcpy(&primary_offset, data + PRIMARY_OFFSET_OFFSET, sizeof(u16));
> +	primary_offset = PRIMARY_OFFSET(le32_to_cpu(primary_offset));

Similarly here.

> +
> +	/* Find the DRAM and IRAM sections within the firmware file. */
> +	header = (struct aqr_fw_header *)(data + primary_offset + HEADER_OFFSET);
> +	memcpy(&iram_offset, &header->iram_offset, sizeof(u8) * 3);
> +	memcpy(&iram_size, &header->iram_size, sizeof(u8) * 3);
> +	memcpy(&dram_offset, &header->dram_offset, sizeof(u8) * 3);
> +	memcpy(&dram_size, &header->dram_size, sizeof(u8) * 3);
> +
> +	/* offset are in LE and values needs to be converted to cpu endian */
> +	iram_offset = le32_to_cpu(iram_offset);
> +	iram_size = le32_to_cpu(iram_size);
> +	dram_offset = le32_to_cpu(dram_offset);
> +	dram_size = le32_to_cpu(dram_size);

And here (x4).

> +
> +	/* Increment the offset with the primary offset. */
> +	iram_offset += primary_offset;
> +	dram_offset += primary_offset;
> +
> +	phydev_dbg(phydev, "primary %d IRAM offset=%d size=%d DRAM offset=%d size=%d\n",
> +		   primary_offset, iram_offset, iram_size, dram_offset, dram_size);
> +
> +	strscpy(version, (char *)data + dram_offset + VERSION_STRING_OFFSET,
> +		VERSION_STRING_SIZE);
> +	phydev_info(phydev, "loading firmware version '%s'\n", version);
> +
> +	/* stall the microcprocessor */
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
> +		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL | VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD);
> +
> +	phydev_dbg(phydev, "loading DRAM 0x%08x from offset=%d size=%d\n",
> +		   DRAM_BASE_ADDR, dram_offset, dram_size);
> +	ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR, data + dram_offset,
> +				   dram_size);
> +	if (ret)
> +		return ret;
> +
> +	phydev_dbg(phydev, "loading IRAM 0x%08x from offset=%d size=%d\n",
> +		   IRAM_BASE_ADDR, iram_offset, iram_size);
> +	ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR, data + iram_offset,
> +				   iram_size);
> +	if (ret)
> +		return ret;
> +
> +	/* make sure soft reset and low power mode are clear */
> +	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_SC,
> +			   VEND1_GLOBAL_SC_SOFT_RESET | VEND1_GLOBAL_SC_LOW_POWER);
> +
> +	/* Release the microprocessor. UP_RESET must be held for 100 usec. */
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
> +		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL |
> +		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD |
> +		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_RST);
> +	usleep_range(UP_RESET_SLEEP, UP_RESET_SLEEP * 2);
> +
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
> +		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD);
> +
> +	return 0;
> +}

...
