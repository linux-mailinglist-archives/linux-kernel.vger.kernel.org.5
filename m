Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6C67F5EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbjKWMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345258AbjKWMPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:15:20 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8CBB0;
        Thu, 23 Nov 2023 04:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiQgvarukx+3LWK90rK5aibvmED4R+hNw18cPrevWUo0f4ofLh6qAC4+8BI+jdxtey94AcA5D/Q0BWfBvveNwS87x0ZZppOHVE7OESYhUw4Qsxnz9tS6fhR/BR0VoaJ8bpPIBjgIelLzFu1nAs+Wyps3yISOnOfd4L4mSeJfNeEm2UYGqPT0eumkj8xKT7D9vPz06gazx2DHIyWlCJm1H/niMJETtCUOX5iwoVYkAlB9jKhHbB1XQxppzlb0AEPMcM+C6WV0Jq8TZ+yuIIlUjutRxzrqryaZ/HgJsgd8j7DxgIjfA4ekV8HFa2da9I96NjbnZ4rWbd4hGZL+Z5iZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JilhQR4bpkCXt9IYs8UvLqkupZAiq1LzrwyzwcqWhIE=;
 b=es90r4lwXPbkgPBHrY9ToCs/1b7xdA+yfg8TwQ8H/JyvHEvTnc1T1qZoxipv9UpCmRvJQT8Z9gbQ3sFax4hb85cjV3iE2FAg4W6Q0Pa8xgZTzlvqcUzme2W0bGGhIlhG6+q4766Y49RKDVUBLowAJrjEqLyGkA/VWeGFqNj0iwey37wOXTtc1HnoEFGf04IwT2b1R6hTbWbagx7+VE93ALYfc6deKC3H3ulnw7LLmmvuvIxqOCRGQGccyYEFiV0nls82z6oS1fYie35BAU4se73sDrq36fyXYKCY/iVykhWN890FWYIy40G45zGzsT1emgK3ptnfPuhsnV0wohWinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JilhQR4bpkCXt9IYs8UvLqkupZAiq1LzrwyzwcqWhIE=;
 b=Gr2avZ+rtpibiKR8qJfchDgM0+jzZ29s0VGKpuHagtNauSbh1oVv19QHrhwHl98BsxyTcvFyZxmADvrV9HBgZTKQ3SfPqlB5tGArtGEZ2jkhp8qxx0ikqIFTXsrXqGtrH4yCHkyuMXeSSI92kHh1ebR6+ciQ0LloSyDg/ql6C1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB9406.eurprd08.prod.outlook.com (2603:10a6:10:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 12:15:03 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:15:03 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH RFC WIP 0/2] net: stmmac: dwmac-rk: add support for PHY
 wake on LAN
Date:   Thu, 23 Nov 2023 13:14:12 +0100
Message-Id: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRCX2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNj3ZTy3MRk3aLs+IKMyvjy/BxdgzRDi7Rks2Sj1GRTJaC2pMTiVN2
 kosS85AygxrzSnBygYEFRalpmBdieaKUgN2eQwnDPAKXY2loAoND2IYMAAAA=
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700741701; l=3745;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=BUf+xFswqG4qRn0mmG08oUr1XF8KzEU07nXyQjritd4=;
 b=cEgyDRJRuL0+Ix2Vi8ZCPewYqdUqE9kBKs51g/xOyT88P59oAN2KFLSHnaW9QO4DloIidv2bR
 xl/ZEeSHe3pA0bV/XoDmFjRRtgedv2QSe9EYFMlRHZik/E5LgLnukMk
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6f7e43-b57c-4ca9-3ba5-08dbec1dd239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wO5UOl/Y9U8n4E1Ib2+blbvEXxUflzM6Y6AWq//JVKM3nhllFBVAQ4oxJ7NyjCVQMblyvX7oQSiQmat1X+VIGZyQodsQgGFX1roZ39NcW81KA9xeVdVj8W7SPZzl8mUpLpkCBKv3bfeM+V0t29WcXTA9bRe2uMYCSsFVuKRiKHOAi5QjLb4/+kKZRnOXPi2W0rCA6SJV8dvYVuyZSmuqpIqCC6Y5B2PKlTIDNKMvcZtPRG0GIznpyAy5B1UxEplg1sgHqnMjINE3R401BJ98E+WCtWVvm6uEG+gaN3ut1JZc0BO1KdZuCzkZL+oZ2FvNS1Eb/fyj7wlGuFoOFSppEtaOtjDqS6mPnB0/mxPYFkmXA+JRbBOAVHc7/50+xD7ngL7+6PWbTq6RppZd/2op+KfKd6kf8Xs90fn9y+TGprB8xBtgISMK4BI2qP8q1bul6+k8MUPfEVBR8p4kRrI+ypTYPgcr+ZbA5VeiCI8hO3i7uDSCPeaDw1RuCGbcJfBEBUq7M9SDrrKVEGxqL4RpsJFd0AN5DcRd+XS+FL8Dc6lymaxlg9vHgeuniHOrfz3ITYs4bYQGmhREvqGnMMvT3quUMy7Ae5GR79fMp1HpE+p5ZeNJM88z8O3I5xUeiOq0APj085djfGwuBOYzXTSFTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39830400003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(66899024)(36756003)(83380400001)(41300700001)(921008)(38350700005)(316002)(6512007)(66946007)(66556008)(110136005)(6666004)(478600001)(66476007)(52116002)(5660300002)(8936002)(6506007)(6486002)(7416002)(26005)(2906002)(107886003)(86362001)(4326008)(44832011)(2616005)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFNlaWUzQ3FRbXp3WFBCdWZmbG4vVElHREtScjlXWjh3Mzc5eTJBOG5WdklD?=
 =?utf-8?B?c1pTVjlzZHQvQzhGcTJuVERXcHhXWU9zS29yOTRWRjQ5cHVoS0d3MGljUHdB?=
 =?utf-8?B?TWNiMGVkK1dOMzBaeHMvWkpGTSsySEFRQzBCNWlTV29najZJTEtQSWJpdzl6?=
 =?utf-8?B?VTZmMTJ6ZlBzcUxuZVA0SFB4TWZyOThINGZnMkVjYzFsQURvTHhhYVBRYnR1?=
 =?utf-8?B?bktzZkJZa2R6VU9iYzFtcjd4N3RhN1ZBZ2RIUjBPK0dxU3lwKzNMbTY5TVFH?=
 =?utf-8?B?Y2RCeENQM1FJOFg1NFAvNmd6WnI1Z1RiRU9mWUhMbDAvT3liTVRMbzl5SnZR?=
 =?utf-8?B?OGVsYUF5Y09IUFhHQ2tCdlJhcGIxejV4VWFlM2k1UFQ1SmJIdy9LQlJ5L2dZ?=
 =?utf-8?B?TFAyTzFLdUIvL1NDVWp4OWF6M2RlSDZyQU9mWHVmUW9KS2FSa0RCTlVubHpa?=
 =?utf-8?B?SHRZQlhOcEEraEozR2hSRmdkM1ZHeGZqNGhnLzJnNlFSd2NISnFGSzBnVGJF?=
 =?utf-8?B?ajk1ZmpQcy9MWjJwaWx5dDJVaFI5UUVLMVV6SEtGaVhzMVk0WkxCZjBtVmdB?=
 =?utf-8?B?dlpHenV2Q1N0cFZkR0FNSXV1YkpJTVBIeEg5YjUxWWpycmlMckNvdnpyZU1k?=
 =?utf-8?B?VE8rZTZvd3BHdm5iZnk1U2VYY2NNSUdsTGZQQnFoZHBTSXV4MFY5NjFSRVJO?=
 =?utf-8?B?VWR6c0U5RkY4Z3FzZENqVkhseXMvMENyVzJnblI3TytIN2xGMThoODViVzVS?=
 =?utf-8?B?WnZZZnBXL0ZqZVdsTW5Ma0F2aGxkMG4wcUhHYU1mQ0FlcEhMV1YwU3JCSldN?=
 =?utf-8?B?ZElFV0UwRk5FSDBQY2IyOTJvL3dlblZNdEpMNFhneHFUdnp5aEwyZGh2ZDhQ?=
 =?utf-8?B?Mm5IekVyejRRVk9vUG5ZcnNuOXVjdlZ6anUrY050cExXblYrMTlFNWpLeG1x?=
 =?utf-8?B?Q3ZJL1RzTWtpWUIza0Y3bG10dzhNbUNaTlN6MWo0c3VxOGt0cVRpNEhBd0hE?=
 =?utf-8?B?UUtsM0ZXSTZSZ3NDQUFlUDRJNXJHeklNTnVHbm8vdDdLM2psWW1WWXBRamJo?=
 =?utf-8?B?eXZRMVg1NFFFU0orOXcvaFlqSXRaY0tJRXNsS05pbWsyOURIeDRaSExHakQv?=
 =?utf-8?B?MXIxZ3VOb00vYmtEMEI3ejVRWDNFZlJPVWZBWlhFNXN0TXlTcEFCV0ZZT2pF?=
 =?utf-8?B?R0p6dWIxNmNCR1E4NW14WFJ5aTkxL2xiVFVFNDZGWXl3L3I3bi9CTXZlKyt3?=
 =?utf-8?B?Y0pkZ1phU2NMdjlrNVMyMndNaUk4R2pyTTgvTCtaRkkzUW53SThjL0JTMDhL?=
 =?utf-8?B?M3o0aWxXeG5KaWVia2NId09URmtJNFJoTzNMS1hxcUV6Q1YvQ0NnMks2VEJ6?=
 =?utf-8?B?L1pnbU0wUkJSdytVMVdkTmY1WWxwWjhIOG93aW5mS3EyZHl4QnFLaUVjMFB2?=
 =?utf-8?B?UDlPTmtTWEFSN0FCOXI0bzhiWFl4dW1vdjJHT3I5WmdQSmFxZHZQb3FnQ0c4?=
 =?utf-8?B?QTN3UFFXd2dtODhsTWRacmtDYzNPNlNXeXZhaWdRVFVNcHpmUCt6Uk51U0RZ?=
 =?utf-8?B?OXQzMGtSd2x3RjJiajRpdllOMml2cUJvMWpKQUNuQU5uSWNQUEk5SmQrMmVy?=
 =?utf-8?B?Nk9Rdnkxa0NYK0s4elM0Y3dDSis1MnRJVk11UE5YVlFVeXkvUlNOMEw4dXgx?=
 =?utf-8?B?aSsrV2VxNHN6Y3A0cGlLUWtRcDF5VnhkSkFSV3JDS0NyNzBzTDFGUmxHZ0JX?=
 =?utf-8?B?TUExaU45NzAwazNFMWJOK1dyUVYrMDB6VVVmbmR5MlVCN1BlZGNzZUpIcW5m?=
 =?utf-8?B?VUxrUExTbVRsRVd3QjB3c0dCSGtjMlhNZVFKazM4NXh1Y3NTQzBzWmIrbXJm?=
 =?utf-8?B?OHJYTWtDNTdxRjNudit3VGdFanRzVEppblpPbnBWQlFuTm5sUldtdGZMbERm?=
 =?utf-8?B?NkE0M3FiZERLS1RlTzc5ZTNMNWZOaEtPN1FFeENLNW4yRlhBRnFYZW1MRnlo?=
 =?utf-8?B?VG9QY2RBNE4wRWJoSGFxYjZaRGNxTG44clhJSFQxTk5LbkJ1aXY5NEdsaTAx?=
 =?utf-8?B?bDJzQmpBaTIwTXRhVzJ4VnhVTjd0MWUzckd6U0xEMGlFQzF1dXNCV0ZCM21B?=
 =?utf-8?B?TzJESkZGYWEzV1pXMXY4RGxkenNPMHpMWVlGckN3L2tvN2QwbVhjYzl1Lzlh?=
 =?utf-8?Q?SkMFMRFTAEizHLDaBW0f6EA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f7e43-b57c-4ca9-3ba5-08dbec1dd239
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:15:02.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIFMq3/ZIp140Wd1nyZC1ET5txIfxdANUOcuCMvoLsm8DzFN/7XIWqQzr0VKNbAaGgW9ddUPcKrWiwoyzC6fyeUQl7WJsvqqOCnaDYfP/qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to get rid of a nasty, out-of-tree hack to use PHY
wake on LAN via named gpio + irq (wakeup-souce) request. Instead, the
STMMAC_FLAG_USE_PHY_WOL flag is set if the rockchip,phy-wol property is
defined in a similar fashion as the mediatek dwmac does with the
mediatek,mac-wol property.

Unfortunately my current approach does not suffice and therefore some
advice would be more than welcome, so this use case gets support
upstream.

The goal is to use WOL in suspend-to-RAM, where we disable the MAC power
supply to increase power savings, leaving the PHY running as the wakeup
source. The system is based on a Rockchip SoC and the PHY is a
TI DP83826E, which can generate interrupts upon reception of magic
packets.

Setting the USE_PHY_WOL flag configures the PHY as expected (its driver
writes the MAC address and the interrupt configuration into the PHY
registers) and an interrupt is generated with every magic packet,
but only during normal operation i.e. there is no interrupt generation
in suspend-to-RAM.
Moreover, WOL stops working in freeze mode (where the MAC is still
powered) and it only works again if the rockchip,phy-wol property is
removed.

A (probably naive) wakeup-source property in the dt node does not help.
So now I am trying to find out why the PHY does not react in suspend and
why its interrupt is ignored in freeze mode, but I might be overlooking
some other important point to consider.

My biggest concern is that I might be overlooking the fact that there is
no way to use WOL even with the USE_PHY_WOL flag if the MAC is not
powered and the hack must stay forever. I still have hope because then WOL
should still work in freeze mode, so there must be something else to
consider.

In case it might help, this is the current device tree snippet with
the new property:

&gmac0 {
        assigned-clocks = <&cru SCLK_GMAC0_RX_TX>,
                          <&cru SCLK_GMAC0>;
        assigned-clock-parents = <&cru SCLK_GMAC0_RMII_SPEED>,
                          <&gmac0_clkin>;
        clock_in_out = "input";
        phy-handle = <&dp83826>;
        phy-mode = "rmii";
        phy-supply = <&vcc3v3_eth>;  /* always-on regulator */
        pinctrl-names = "default";
        pinctrl-0 = <&gmac0_miim
                     &gmac0_clkinout
                     &gmac0_rx_er
                     &gmac0_rx_bus2
                     &gmac0_tx_bus2>;
        rockchip,phy-wol;  /* NEW PROPERTY */
        status = "okay";
};

&mdio0 {
        #address-cells = <1>;
        #size-cells = <0>;

        dp83826: ethernet-phy@0 {
                compatible = "ethernet-phy-ieee802.3-c22";
                reg = <0x0>;
                interrupt-parent = <&gpio0>;
                interrupts = <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
                pinctrl-names = "default";
                pinctrl-0 = <&eth_wake_intn &eth_phy_rstn>;
                reset-assert-us = <1000>;
                reset-deassert-us = <2000>;
                reset-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_LOW>;
                // wakeup-source; <--- no effect
        };
};

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      dt-bindings: net: rockchip-dwmac: add rockchip,phy-wol property
      net: stmmac: dwmac-rk: add support for PHY wake on LAN

 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c            | 5 +++++
 2 files changed, 11 insertions(+)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231123-dwmac-rk_phy_wol-0f18fc6c2ec5

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

