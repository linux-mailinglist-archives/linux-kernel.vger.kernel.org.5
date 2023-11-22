Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9E7F4E53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbjKVRYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbjKVRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:24:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF111F;
        Wed, 22 Nov 2023 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5tYxnOuPUqzNOKLt2AL3c7hUpep0PfnAkdrgsn/M+9U=; b=jGhJ4bWOHwut3GxjAU7FUeCXmS
        l/3VIZSM2aRJ1QAod/QYaU44u0WV4uVnRAJkoimLZBod9Rr0sUnOQbz8aS4sHIjxkTVwws+UUVrl8
        o8IoZ1FqMLpL+QCErGBfCq0cl1nWH5fkeFhH1CGbLioB7wzsI2pRGbJhktjpkM/vTVZB1jDsTZOP0
        USx5SPcAITZ39g7E9E0T98F1141qRB2atBjr3HJf3xgf3k61ugn/5YV5qRK+TOdu9qyesJMXT4xjo
        fQqJqvtGfJu06TpHaBg67xRmj6/a57SEphLt5eRMXJOAIjfOJgQokV4ss0X2204oIieKbkMSacwhx
        eahQJgAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46456)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5qxk-0000X7-2x;
        Wed, 22 Nov 2023 17:24:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5qxl-0005Mp-U8; Wed, 22 Nov 2023 17:24:33 +0000
Date:   Wed, 22 Nov 2023 17:24:33 +0000
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
Subject: Re: [net-next PATCH] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
Message-ID: <ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
References: <20231122170813.1222-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170813.1222-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:08:13PM +0100, Christian Marangi wrote:
> On further testing on BE target with kernel test robot, it was notice
> that the endianness conversion for addr and CRC in fw_load_memory was
> wrong and actually not needed. Values in define doesn't get converted
> and are passed as is and hardcoded values are already in what the PHY
> require, that is LE.
> 
> Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> _swab32 instead, the word is taked from firmware and is always LE, the

                               taken

> mailbox will emit a BE CRC hence the word needs to be always swapped and
> the endianness of the host needs to be ignored.

I'm not convinced. If the firmware is a bytestream (as most "files" are)
then for val = get_unaligned((u32 *)ptr), where ptr is an array of u8:

ptr[0]	ptr[1]	ptr[2]	ptr[3]	val on LE	val on BE
0x01	0x02	0x03	0x04	0x04030201	0x01020304

So, endianness matters here, and I think as Jakub already suggested, you
need to use get_unaligned_le32().

> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index c5f292b1c4c8..bd093633d0cf 100644
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
>  	phy_write_mmd(phydev, MDIO_MMD_VEND1,
>  		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
>  		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> @@ -128,7 +128,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
>  		 * We convert word to big-endian as PHY is BE and mailbox will
>  		 * return a BE CRC.
>  		 */
> -		word = (__force u32)cpu_to_be32(word);
> +		word = __swab32(word);
>  		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));

Again, I think you need to be careful with the endianness here again.
From what I understand here, it seems the CRC needs to be generated by
looking at the byte at ptr[3] first, then ptr[2], ptr[1] and finally
ptr[0] ?

If that is the case, the problem is using __swab32() on LE will do the
job for you, but on BE machines, it will be wrong.

I would make this explicit:

		u8 crc_data[4];

		...

		/* CRC is calculated using BE order */
		crc_data[0] = word >> 24;
		crc_data[1] = word >> 16;
		crc_data[2] = word >> 8;
		crc_data[3] = word;

		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));

which will be (a) completely unambiguous, and (b) completely
independent of the host endianness.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
