Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2A7F4FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbjKVSyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:54:02 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850A1B3;
        Wed, 22 Nov 2023 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9mN26oXnsGSUTNXCrfc25Xqi3h24CgPhQwQcmOWKmtQ=; b=Rp8rTiZ+O8UqGbubCwroGF8zur
        4cOhBwFn2bjNzvoHOCKnsG4BX4F14h36kZT83vwN7EKHMRLJkIKw7jc1/hZZN29H6Nyzrv0iuo2BI
        ytPCWimRHldZL1GYtID7RmVbPsQ9//EKtwhh2DV8x8dCsYzUn/iOUuWzRY/n3EmSdV45zdBa0MGex
        21BVuNawD9C3UTzwTiAcL+W4piuPACk0/mGxwDQRWSr0ec0BxZsJd0uUKDdsp1q3hR4bSmzkDbU5X
        TTJqaPvWjq/lOzbORUQKGQ9zr/4rlAg/VDzlkf+1hcREI9AzemkSACk78mDXf6uHcSb2u4t4PP+Hk
        3ABNDpHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58024)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5sMA-0000eE-2A;
        Wed, 22 Nov 2023 18:53:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5sMA-0005Q7-K6; Wed, 22 Nov 2023 18:53:50 +0000
Date:   Wed, 22 Nov 2023 18:53:50 +0000
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
Message-ID: <ZV5OPr5ee2x/yMCQ@shell.armlinux.org.uk>
References: <20231122170813.1222-1-ansuelsmth@gmail.com>
 <ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
 <655e4025.df0a0220.50550.3d70@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655e4025.df0a0220.50550.3d70@mx.google.com>
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

On Wed, Nov 22, 2023 at 06:53:39PM +0100, Christian Marangi wrote:
> On Wed, Nov 22, 2023 at 05:24:33PM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 22, 2023 at 06:08:13PM +0100, Christian Marangi wrote:
> > > On further testing on BE target with kernel test robot, it was notice
> > > that the endianness conversion for addr and CRC in fw_load_memory was
> > > wrong and actually not needed. Values in define doesn't get converted
> > > and are passed as is and hardcoded values are already in what the PHY
> > > require, that is LE.
> > > 
> > > Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> > > _swab32 instead, the word is taked from firmware and is always LE, the
> > 
> >                                taken
> > 
> > > mailbox will emit a BE CRC hence the word needs to be always swapped and
> > > the endianness of the host needs to be ignored.
> > 
> > I'm not convinced. If the firmware is a bytestream (as most "files" are)
> > then for val = get_unaligned((u32 *)ptr), where ptr is an array of u8:
> > 
> > ptr[0]	ptr[1]	ptr[2]	ptr[3]	val on LE	val on BE
> > 0x01	0x02	0x03	0x04	0x04030201	0x01020304
> > 
> > So, endianness matters here, and I think as Jakub already suggested, you
> > need to use get_unaligned_le32().
> >
> 
> So they DO get converted to the HOST endian on reading the firmware from
> an nvmem cell or a filesystem?

I don't like "converted". It's *not* a conversion. It's a fundamental
property of accessing memory using different sizes of access.

As I attempted to explain above, if you have a file, and byte 0
contains 0xAA, byte 1 of the file contains 0xBB, byte 2 contains
0xCC, and byte 3 contains 0xDD, then if you read that file byte by
byte, you will get 0xAA, then 0xBB, then 0xCC and then 0xDD.

If you map that file into memory, e.g. in userspace, using mmap(),
or allocating memory and reading four bytes into memory, and access
it using bytes, then at offset 0, you will find 0xAA, offset 1 will
be 0xBB, etc.

The problems with endianness start when you move away from byte
access.

If you use 16-bit accessors, then, a little endian machine is defined
that a 16-bit load from memory will result in the first byte being put
into the LSB of the 16-bit value, and the second byte will be put into
the MSB of the 16-bit value. So that would be 0xBBAA. However, on a big
endian machine, a 16-bit load will result in the first byte being put
into the MSB of the 16-bit value, and the second byte will be put into
the LSB of that value - meaning the 16-bit value will be 0xAABB.

The second 16-bit value uses the next two bytes, and the order at which
these two bytes are placed into the 16-bit value reflects the same as
the first two bytes. So LE will be 0xDDCC and BE would be 0xCCDD.

The same "swapping" happens with 32-bit, but of course instead of just
two bytes, it covers four bytes. On LE, a 32-bit access will give
0xDDCCBBAA. On BE, that will be 0xAABBCCDD.

Again, this is not to do with any kind of "conversion" happening in
software. It's a property of how the memory subsystem inside the CPU
works.

> Again this is really dumping raw data from the read file directly to the
> mailbox. Unless phy_write does some conversion internally, but in that
> case how does it know what endian is the PHY internally?

phy_write() does *no* conversion. The MDIO bus defines that a 16-bit
register value will be transferred, and the MDIO bus specifies that
bit 15 will be sent first, followed by subsequent bits down to bit 0.

The access to the hardware to make this happen is required to ensure
that the value passed to phy_write() and read using phy_read() will
reflect this. So, if one does this:

	val = phy_read(phydev, 0);

	for (i = 15; i >= 0; i--)
		printk("%u", !!(val & BIT(i)));

	printk("\n");

This will give you the stream of bits in the _order_ that they appeared
on the MDIO bus when phy_read() accessed. Doing the same with a value
to be written will produce the bits in the same value that they will
be placed on the MDIO bus.

So, this means that if the BMCR contains 0x1234 in the PHY, phy_read()
will return 0x1234. Passing 0x1234 into phy_write() will write 0x1234
in that register. The host endian is entirely irrelevant here.

> > I would make this explicit:
> > 
> > 		u8 crc_data[4];
> > 
> > 		...
> > 
> > 		/* CRC is calculated using BE order */
> > 		crc_data[0] = word >> 24;
> > 		crc_data[1] = word >> 16;
> > 		crc_data[2] = word >> 8;
> > 		crc_data[3] = word;
> > 
> > 		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
> > 
> > which will be (a) completely unambiguous, and (b) completely
> > independent of the host endianness.
> 
> But isn't this exactly what is done with ___constant_swab32 ?
> __swab32 should not change if the HOST is BE or LE.

Let try again to make this clear. If one has this code:

		u32 word = 0x01020304;
		u8 *ptr;
		int i;

		ptr = (u8 *)&word;

		for (i = 0; i < 4; i++)
			printk(" %02x", ptr[i]);
		printk("\n");

Then, on a:
- LE machine, this will print " 04 03 02 01"
- BE machine, this will print " 01 02 03 04"

Now, if you look at the definition of crc_ccitt_false(), it is
defined to do:

        while (len--)
                crc = crc_ccitt_false_byte(crc, *buffer++);

So, on a LE machine, this will feed the above bytes in the order of
0x04, 0x03, 0x02, 0x01 in a LE machine, and 0x01, 0x02, 0x03, 0x04
on a BE machine.

> The real question is if word is converted. (by either the read API on
> reading the FW or by phy_write on writing the thing to mailbox) (the
> test are done on a LE HOST)

There are no conversions - where a conversion I define as something
that the software explicitly has to do rather than what the underlying
machine hardware does.

> Our theory is that mailbox takes LE and internally converts to BE (as
> the PHY is BE) but the CRC reg calculates the CRC out of the converted
> data aka it does calculates the CRC from the BE data (converted
> internally).

I think the talk about the endian-ness of the PHY is entirely
unhelpful and is probably adding to confusion. The endian-ness of the
PHY is *not* exposed to the host because the MDIO interface to the PHY
is defined in terms of 16-bit register quantities, and bit 0 of the
register will be bit 0 on the host irrespective of host endian.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
