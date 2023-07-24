Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3809275FA55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGXPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGXPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:01:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781FE56;
        Mon, 24 Jul 2023 08:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpjAnVRVnk+O5vQ+Zye9vXOj5RbZC8TnmA6HvFxEmfX2DiZy1xlBGMLYdWv42UN1SBFsKnY0IDE/u4FxjwKar63izo4pJ4IFCLxeQAbIE7Dmjz9mQx5WVrMbJBW+d+YnpCc5wvwFIkzzUlelML8jMZLFVPbZMAFVut/sIpXlKvkvLAf4NsFARTXQiBAEwDEz/TgO5OpIuSgNEnyGQn6OnRKoAHN42dHFt9rxiCuHXlORJ12cz8iizBm4+/ZU9WTXDDxMm6fOuPwdrpsFo80YJ9UcqJFThdbXzr72K/iIIoFXQFqfjdJRx4wsnvO49fhl39mQV9+lutYbFJg+yM80AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyeiz5wX9Vwody+tcoC2vRgG0ZBVBV1Q8bugTxWZPug=;
 b=lbvKvuUN95PCWR4Tex2Io2el3pQwrYaa5lRiNZlLgPjYGpOye1YaLfc1kvgT2R+mdN8KNRS+6dQLkDjlCu44UfMfsRoj5qlpwvkgUz1GZjxml/GbaPAKPMo00j6pC1F2dQzyQgEFpkEoZa9ezhzYZRKZsx3lxiHQnQDgf7djnOhD/ooAaS99GSOjnqFrm6D3SJuV/rJYyyRQC7KBm9EGIpDQVejBQIVk7sPXuxLNQ9S0O996nNOry+Agz9UNYkU1yBbRDEFuxIsr6T/EOtHTK/pJmyz/u5H87ZDGzWxXR7OuN6yxSsGvoNo0v0Gprnqbs3pKHWmob42TWb0em4F1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyeiz5wX9Vwody+tcoC2vRgG0ZBVBV1Q8bugTxWZPug=;
 b=GtCjnLD4M/30bF3SQc58Cs3eDQa3XsDDw8cCcQYaytXNAGpMGkn9dBXwt+47dcuAJhMV7GepSONLaX6mfxTJB2pCTmSlXgCXtyklgk5n0HCQ25BphPJuctjdqJYUjiAya0Xr8OnLzIC4FpfW+CGOxa6m3orVehT6NvjtZu0bT6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5709.namprd13.prod.outlook.com (2603:10b6:806:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 15:01:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:01:31 +0000
Date:   Mon, 24 Jul 2023 17:01:24 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <ZL6SRE0ikLX0BS+M@corigine.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-5-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-5-nick.hawkins@hpe.com>
X-ClientProxiedBy: AM8P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: cab48c88-e117-461d-800d-08db8c56dd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHONOvhuSDlWFdOBwoVSECg0gS04ksscOwEEjZJRrNMrEOFH0VhuC2/Sx0Po1rQ5gIs22TOQYE2T280HnubfYzj7YV40bPXG8cXWwacqSsqDjv1mBoEseXV96Ee+bM0VSGjyTqsKf7sOiDY9orBHLcyyLISarY9nlGFxlME8USbXEtRhICb/O+5F/jubfaeOOKy4qPRg41SiNe5CZ7nol8+YhqQTHD+XGDrp8hOHQFKIeuDJVuCMXXnlAV4oIt2vcHVg1svbQ+U01TWI5xETLCcYQvDD5/ipUU7q6KDIQKq8EUp8rx0rGYjCZ+4OnvCzL1vTD5K8F+iLizNR6hHQDjawcJpsQD3DiYDbEkZMkxI+L6zoDwAKG02iSwIi89Nm7AeDM5y35Y1sczb1PHV5RrBUR9+0ZXq8ZTabQWS9yXflAixceN/5/Cxj6qnRKpH9lVK8HhWXQ7usNIILxQ5bTMK4s23kZvtKZMDo6vnitAQ1pyvG/F37QjsPi0MNOXRCBPPzB6Ra3BNKVNqaSLgFvQsQqCbD4LOQidWQOUVnEQ+VoITRpHynE40LPAvNEOSl7Tp26PfcrkiVwYtgFpclSW3XksGTTssvXAtU0h6100tdCahA6mLls+k2pBAjVj2Uza3lzOgFoT7KeKn7IlUNcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39840400004)(376002)(346002)(451199021)(5660300002)(8936002)(8676002)(7416002)(44832011)(6916009)(4326008)(66556008)(66476007)(66946007)(316002)(296002)(41300700001)(2906002)(6666004)(6486002)(966005)(6512007)(6506007)(186003)(2616005)(83380400001)(478600001)(38100700002)(36756003)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dInF6GjNUBmmPLs7zzp1Y9yiyoxwKfjZW7cs4O9RQeHtzESBZG803jS+1GQq?=
 =?us-ascii?Q?Pl7MfmDWYkCGZyPehS3T9fihUJyccOSmuC15VBUdtf1Vz3QhA99fRaip5v8K?=
 =?us-ascii?Q?2IacuGN0d1HfdNZ+gY4lz/lxt4d9RD+rYt1uHtA1XE2nS1wTRGFIKzzwM3uw?=
 =?us-ascii?Q?WY61PHci5eeEzFs05q3SiApv7gHQDE2C5zfCBUPmS9F7eKGbNFV7l+ooO42H?=
 =?us-ascii?Q?jGEPezJ98v/rSucJG1TnEfMHCE83gkCxajM+bIIpzmBrNvI/pVHv+fHDUu98?=
 =?us-ascii?Q?PMfZ/26piG2wbhlSvV3UkNY49EpZzJ9zDu6bTtrhm2dU19TFpBQo01ODlHBL?=
 =?us-ascii?Q?xdIIWiqSCuXWWRRM/y2u9k3igPaFQzTs5xNvOUwvHszKgBDvlDXT42FmIVDv?=
 =?us-ascii?Q?6FP+uboix5igZMFJ3gnNzAOqFDVzwkmnXeoVXdrAK9NmShWGF+ucp7yxuuDC?=
 =?us-ascii?Q?zah8C8b9W9ennRnMvUXJsWImZw4G1Gctno1qZsq8WlgfY0RqRpgC935zNnTY?=
 =?us-ascii?Q?tt9H4QaDmL1JtoXVwlJhfHCriJ+J918tGzyibhtPAgcywTTCRh1uQkYKFweY?=
 =?us-ascii?Q?VX7rFYAPHZrCXPQg0ia7/grs57wqNoSMrHvmrSC3FnYbmFhk4KC0YoOBMCjz?=
 =?us-ascii?Q?+UyfDzMVTUhTfTCcLZOxBmQBrnLXUzet75jPlvyve3jim+xi8pcRccRlSwmg?=
 =?us-ascii?Q?04vY6LelHbvhYIy5xhaMJt2vRh8Uu82tCNaEI297bf0FSD3XtrNUZ/pwm6Qg?=
 =?us-ascii?Q?nnxvK6xD0/UTSyPL9pOv7KUgN1D2D5dLeMlcYcdgJQa/RMAjxZB+CX4c56RL?=
 =?us-ascii?Q?dCAFu0M8gxK+pWjvyqXv2oPklhcoPFALWqnGgXSawSoePQGRyVZMlIA2t4jx?=
 =?us-ascii?Q?u+9KOHct3kSwcUFQkZ7UNuDWzZAJZhYCSOmebNQxQer2Wp4Q6mGULABO3zku?=
 =?us-ascii?Q?PrWxh5iI8JC5UPcBRLJ2slIZzsy3dpTzJz2RVG5nTA5JGEPpcNLo6VVZ7me5?=
 =?us-ascii?Q?mhYzegsZN/QERfUcDePhho/dbhPyl0eZPZTTOV4S5xZSenJtGrJ+pIb2EKuY?=
 =?us-ascii?Q?d82NeeV8Z+uQwQGhw1tq5hb1rWHwbfSkAsrZNCT25x2HEbvUb2otSp0oMLP3?=
 =?us-ascii?Q?BHFrpnU1fSExLsrqpoUNyGBG4pt5VHJ+JYwEu9Xyflx0J1gqQ5h3eLgzNQ7m?=
 =?us-ascii?Q?5DY9gCF+VCZKi9xSnwhLKIbLvCkh1dLbg3dRQAVJo0cesHald3wXyTJwYxX7?=
 =?us-ascii?Q?VoSQL+9J3uuYKmpOI0cURiml8Dmtflv7E9NOIu/F7Kj1mMjZGJWl8LYjCklQ?=
 =?us-ascii?Q?4AlKGZZ143MRYgs3scwfIdrziRX2mFZp78hDSoK1GKw1wzLBL+/kexAVkZYu?=
 =?us-ascii?Q?5zjS8xPmUv+LxX+xqYUZlOF37BIxTeMRIIKWbYbABob0AQXrkuqQ5fwCustP?=
 =?us-ascii?Q?xoy+P2NBmiWWIeq24PZSzztZlTmmPVNk2MlEW4MN1TDZsqBeROHlgXXe1V0/?=
 =?us-ascii?Q?1WuGKYUBzyv9DYso+aThMKN0feHQtN8LUnu/Atrkw/Zvr4Dq20Y+a2QhBwtG?=
 =?us-ascii?Q?HotfTzFu/JkBkg9Als/ZDLQ5jTMbKZHsshrgyI6e1LlCJ6cpQ7aO65wtsUy0?=
 =?us-ascii?Q?+5+is7UrxMceZAK1OwXDHff7fLKbcsGif74YSHQGydXJThunU5EzmQe57UuT?=
 =?us-ascii?Q?98aM0g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab48c88-e117-461d-800d-08db8c56dd5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:01:31.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQBGaQVz0ioDVntYPzmDja0IJQnKt2K8fTfk7Wt2Us76cUAHnTn0B23y9x7TjNDph4X+M3dP/g5kzimg9MiQcuZ14Ba2eCaGEfa0Cl6W3DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5709
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:20:43PM -0500, nick.hawkins@hpe.com wrote:

...

Hi Nick,

> diff --git a/drivers/net/ethernet/hpe/gxp-umac.c b/drivers/net/ethernet/hpe/gxp-umac.c

...

> +static void umac_set_mac_address(struct net_device *ndev, void *p_addr)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	char *addr = (char *)p_addr;
> +	unsigned int value;
> +
> +	/* update address to register */
> +	value = addr[0] << 8 | addr[1];
> +	writel(value, umac->base + UMAC_MAC_ADDR_HI);
> +	value = addr[2] << 8 | addr[3];
> +	writel(value, umac->base + UMAC_MAC_ADDR_MID);
> +	value = addr[4] << 8 | addr[5];
> +	writel(value, umac->base + UMAC_MAC_ADDR_LO);
> +}
> +
> +static int umac_eth_mac_addr(struct net_device *ndev, void *p)
> +{
> +	int ret;
> +	struct sockaddr *addr = p;

Please use reverse xmas tree - longest like to shortest - for
new Networking code. Likewise in some other places in this patch/series.

This tool can be helpful in this regard.
https://github.com/ecree-solarflare/xmastree

...

> +static int umac_init_hw(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	unsigned int value;
> +
> +	/* initialize tx and rx rings to first entry */
> +	writel(0, umac->base + UMAC_RING_PTR);
> +
> +	/* clear the missed bit */
> +	writel(0, umac->base + UMAC_CLEAR_STATUS);
> +
> +	/* disable checksum generation */
> +	writel(0, umac->base + UMAC_CKSUM_CONFIG);
> +
> +	/* write the ring size register */
> +	value = ((UMAC_RING_SIZE_256 << UMAC_TX_RING_SIZE_SHIFT) &
> +			UMAC_TX_RING_SIZE_MASK) |
> +		((UMAC_RING_SIZE_256 << UMAC_RX_RING_SIZE_SHIFT) &
> +			UMAC_RX_RING_SIZE_MASK);
> +	writel(value, umac->base + UMAC_RING_SIZE);
> +
> +	/* write rx ring base address */
> +	writel(cpu_to_le32(umac->rx_descs_dma_addr),
> +	       umac->base + UMAC_RX_RING_ADDR);

It is my understanding that writel will convert the value
from host byte order to little endien. If so then pre-converting value
seems incorrect. Perhaps this should be:

	writel(umac->rx_descs_dma_addr, umac->base + UMAC_RX_RING_ADDR);

Flagged by Sparse.

> +
> +	/* write tx ring base address */
> +	writel(cpu_to_le32(umac->tx_descs_dma_addr),
> +	       umac->base + UMAC_TX_RING_ADDR);

Ditto.

> +
> +	/* write burst size */
> +	writel(0x22, umac->base + UMAC_DMA_CONFIG);
> +
> +	umac_channel_disable(umac);
> +
> +	/* disable clocks and gigabit mode (leave channels disabled) */
> +	value = readl(umac->base + UMAC_CONFIG_STATUS);
> +	value &= 0xfffff9ff;
> +	writel(value, umac->base + UMAC_CONFIG_STATUS);
> +	udelay(2);
> +
> +	if (umac->use_ncsi) {
> +		/* set correct tx clock */
> +		value &= UMAC_CFG_TX_CLK_EN;
> +		value &= ~UMAC_CFG_GTX_CLK_EN;
> +		value &= ~UMAC_CFG_GIGABIT_MODE; /* RMII mode */
> +		value |= UMAC_CFG_FULL_DUPLEX; /* full duplex */
> +	} else {
> +		if (ndev->phydev->duplex)
> +			value |= UMAC_CFG_FULL_DUPLEX;
> +		else
> +			value &= ~UMAC_CFG_FULL_DUPLEX;
> +
> +		if (ndev->phydev->speed == SPEED_1000) {
> +			value &= ~UMAC_CFG_TX_CLK_EN;
> +			value |= UMAC_CFG_GTX_CLK_EN;
> +			value |= UMAC_CFG_GIGABIT_MODE;
> +		} else {
> +			value |= UMAC_CFG_TX_CLK_EN;
> +			value &= ~UMAC_CFG_GTX_CLK_EN;
> +			value &= ~UMAC_CFG_GIGABIT_MODE;
> +		}
> +	}
> +	writel(value, umac->base + UMAC_CONFIG_STATUS);
> +	udelay(2);
> +
> +	umac_channel_enable(umac);
> +
> +	return 0;
> +}

...

> diff --git a/drivers/net/ethernet/hpe/gxp-umac.h b/drivers/net/ethernet/hpe/gxp-umac.h

...

> +struct umac_rx_desc_entry {
> +	u32  dmaaddress;   // Start address for DMA operationg

1. operationg -> operating
2. It appears that this field is used to hold __le32 values.
   Perhaps it's type should be __le32.
   As is, Sparse complains about this.

> +	u16  status;       // Packet tx status and ownership flag
> +	u16  count;        // Number of bytes received
> +	u16  checksum;     // On-the-fly packet checksum
> +	u16  control;      // Checksum-in-time flag
> +	u32  reserved;
> +} __aligned(16);
> +
> +struct umac_rx_descs {
> +	struct umac_rx_desc_entry entrylist[UMAC_MAX_RX_DESC_ENTRIES];
> +	u8 framelist[UMAC_MAX_RX_DESC_ENTRIES][UMAC_MAX_RX_FRAME_SIZE];
> +} __packed;
> +
> +struct umac_tx_desc_entry {
> +	u32  dmaaddress;   // Start address for DMA operationg

Ditto.

> +	u16  status;       // Packet rx status, type, and ownership flag
> +	u16  count;        // Number of bytes received
> +	u32  cksumoffset;  // Specifies where to place packet checksum
> +	u32  reserved;
> +} __aligned(16);
> +
> +struct umac_tx_descs {
> +	struct umac_tx_desc_entry entrylist[UMAC_MAX_TX_DESC_ENTRIES];
> +	u8 framelist[UMAC_MAX_TX_DESC_ENTRIES][UMAC_MAX_TX_FRAME_SIZE];
> +} __packed;
> +
> +#endif
> -- 
> 2.17.1
> 
> 
