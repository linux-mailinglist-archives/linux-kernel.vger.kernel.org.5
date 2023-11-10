Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872E07E833B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjKJT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjKJT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:57:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CA19E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:57:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03042C433C8;
        Fri, 10 Nov 2023 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699646229;
        bh=pPeEBHJvQREKkTU30qYxMcqhI6GQEWa9vdngVVAWlco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HX4ifgLq+XwZy+KNkyT0S+JWropAdL44XUYyjluHGSYpALor868pJnwNCQ9wHe9eu
         tQxk3q8EDwspwZknT9Ge6BOV1BLRgnyE+n3UrEqyDlyIssNyitBD1TDWGrDOjwOWmB
         9OmkjDxk/zKY+YEN6EmDGy6eIrC/+R1vzyHHlqTRRhPqIqJrW0MACB6fVHDl/pipB+
         6h0Bae+FM7VCIWwtd1BBnPBVzPhpl7CeYFSbFgXU8OePRScmo6m3UQ2jFTDi5dcHj0
         tdwmOYOMfkN3IY0VJ1M9cQwkMli1RW2hQ+fTOWsDfH2hb4jrZdoTQWX04WQjKx7Uqp
         UICOwInuwywGg==
Date:   Fri, 10 Nov 2023 19:57:02 +0000
From:   Simon Horman <horms@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v6 3/4] net: phy: aquantia: add firmware
 load support
Message-ID: <20231110195628.GA673918@kernel.org>
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
 <20231109123253.3933-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109123253.3933-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:32:52PM +0100, Christian Marangi wrote:
> From: Robert Marko <robimarko@gmail.com>
> 
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
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Hi Christian and Robert,

thanks for your patch-set.

I spotted some minor endien issues which I have highlighted below.

...

> +/* load data into the phy's memory */
> +static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> +			      const u8 *data, size_t len)
> +{
> +	u16 crc = 0, up_crc;
> +	size_t pos;
> +
> +	/* PHY expect addr in LE */
> +	addr = cpu_to_le32(addr);

The type of addr is host byte-order,
but here it is assigned a little-endian value.

Flagged by Sparse.

> +
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));

VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR() performs a bit-shift on addr,
and applies a mask which is in host-byte order.
But, as highlighted above, addr is a little-endian value.
This does not seem right.

This is all hidden by a cast in VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR()
This seems dangerous to me.


> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));

There seem to be similar issues with the use of addr here.

> +
> +	/* We assume and enforce the size to be word aligned.
> +	 * If a firmware that is not word aligned is found, please report upstream.
> +	 */
> +	for (pos = 0; pos < len; pos += sizeof(u32)) {
> +		u32 word = get_unaligned((const u32 *)(data + pos));
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
> +		 * We convert word to big-endiang as PHY is BE and mailbox will
> +		 * return a BE CRC.
> +		 */
> +		word = cpu_to_be32(word);

Similarly here, Sparse flags that a little-endian value is assigned to a
host byte-order variable.

> +		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> +	}

...

pw-bot: changes-requested
