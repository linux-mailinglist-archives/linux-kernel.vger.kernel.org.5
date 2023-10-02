Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF7E7B5BE6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjJBUS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:18:27 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594A2B7;
        Mon,  2 Oct 2023 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xn3+HJeASNLi6Bxxpih08r0KtwhwbXCe716RaBhG288=; b=HcBw+VQyOqeJxrqsHPEF14fWR7
        H3mS1uwbV36Xo6KpGGDeSfPCbJQJoJvsohNSO80ZHrOy+t595RRK9G+qUT0JNYZnotzTcyDBqFm1Z
        PaDsSn4gmNm7bEs09koDJ1o8c4YxrVDud2vK/HKeoqw9zNydkEUSqsl44MseDvEvwlvQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qnPMj-0083Dd-H5; Mon, 02 Oct 2023 22:18:05 +0200
Date:   Mon, 2 Oct 2023 22:18:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robimarko@gmail.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <df89a28e-0886-4db0-9e68-5f9af5bec888@lunn.ch>
References: <20230930104008.234831-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930104008.234831-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* load data into the phy's memory */
> +static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
> +				const u8 *data, size_t len)
> +{
> +	u16 crc = 0, up_crc;
> +	size_t pos;
> +
> +	/* PHY expect addr in LE */
> +	addr = cpu_to_le32(addr);
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

_m_ailbox.

And i would consistently uses CRC in comments.

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
> +	calculated_crc = crc_ccitt_false(0, data, size - 2);
> +	if (read_crc != calculated_crc) {
> +		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
> +			   read_crc, calculated_crc);
> +		return -EINVAL;
> +	}
> +
> +	/* Get the primary offset to extract DRAM and IRAM sections. */
> +	memcpy(&primary_offset, data + PRIMARY_OFFSET_OFFSET, sizeof(u16));

Please add some sanity checks. We should not fully trust the
firmware. Is PRIMARY_OFFSET_OFFSET + sizeof(u16) actually inside the
firmware blob?

> +	primary_offset = PRIMARY_OFFSET(le32_to_cpu(primary_offset));
> +
> +	/* Find the DRAM and IRAM sections within the firmware file. */
> +	header = (struct aqr_fw_header *)(data + primary_offset + HEADER_OFFSET);

Is header actually inside the firmware blob?

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

Is version inside the blob....

> +static int aqr_firmware_load_nvmem(struct phy_device *phydev)
> +{
> +	struct nvmem_cell *cell;
> +	size_t size;
> +	u8 *buf;
> +	int ret;
> +
> +	cell = nvmem_cell_get(&phydev->mdio.dev, "firmware");

Does this need properties in device tree? Please update the binding.

> +
> +static int aqr_firmware_load_sysfs(struct phy_device *phydev)

_sysfs seems a bit odd here. Does request_firmware still use the user
mode helper? I _thought_ it just went direct to the filesystem?

> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw;
> +	const char *fw_name;
> +	int ret;
> +
> +	ret = of_property_read_string(dev->of_node, "firmware-name",
> +				      &fw_name);

Please update the device tree binding.

> +static int aqr_firmware_load(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
> +	if (ret > 0)
> +		goto exit;

I assume this means a value of 0 indicates there is no firmware
running? Maybe a comment or a #define for 0?

	 Andrew
