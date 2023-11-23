Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A387F5ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbjKWMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345253AbjKWMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:15:16 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26003D5C;
        Thu, 23 Nov 2023 04:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKlLEQX04e4A+LKyJFrzVX7xpiN+al4REMJSjyG3w5n35L6wJSFRbp/LgN6XU0robopm77ppT/tGRHN3Qhw9gcd1pC6EIGa9CSEFgIsvhvWLAN4pdGuhKGHBDk7pfBrE0ijoxX/Py8S9t3XVwd9YIj3ZDXfMcK2V/Mrvua+7GsXm0P9dpkzfF/Pmd0gDpg6/Deu4bRJV67FXxzJZKp/EPdzLXWts4u7ue3j9S8tiI3ibJiYCUNdrljUxbWd1uQwtUF/ByCg2yar5lEr+If7J58s2l93RzZ/uj4m0gqSGtAw2MTYDnFNbCxWf0gnvo68d1XxNNyInOiWiBFlZq2cfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIfnaEo4N2Z/UP01LfKx32JgwuHl3fG1jrAMsr9MbfE=;
 b=NRfK34uDBnCE97LlboktJe5Vo4n+3a+OpZkyuo9SF7h3G4rFKOu8Mru8nimghunslYfJUcORCp2w+y9RsY9pY8Q2iLNxBOERaFv9LB8Rr5DESIIpz0smWDIde30bU86M0WM6OGTPYa6guZIR8zBx4+HlhVZYHrZv6zqVDZk2VQP46DjMecJv5cMxxa+hx040GFowydu56pL18hWmU7Sa2KQ1Oq3trL9pVrTGJ2A9yLfNHRRGTC/J9f5hXU8e82Lt+oD1pEPdocc/0XcH9Y0G+B7ykFJhOSyaUFpV70Qd81Ea7EvE6HTvdERZ9a1pHhY2SFuBkoacv7LB6Kw3Jitq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIfnaEo4N2Z/UP01LfKx32JgwuHl3fG1jrAMsr9MbfE=;
 b=1ggO+kOlnsXUHOAovCCunEaUvCrn3b7mZgqtPe1bFkLatzZPqZbWscKJqZ+c8/khv/vILkc3NDQFoCsbAeTJUbjsjCfkMo3OHY0bAGA5T8hKkAuayWVeN2tyGAcheaRIdxwXKzXBCnYVME1+I24zg/nWjuAFnx9HCZo2H6novIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8423.eurprd08.prod.outlook.com (2603:10a6:10:405::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 12:15:17 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:15:17 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 23 Nov 2023 13:14:14 +0100
Subject: [PATCH RFC WIP 2/2] net: stmmac: dwmac-rk: add support for PHY
 wake on LAN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-dwmac-rk_phy_wol-v1-2-bf4e718081b9@wolfvision.net>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
In-Reply-To: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700741701; l=948;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=L+4DG9qvsMLMaPm6QeM3H7V9nATvHLre3SHjaPYMid8=;
 b=pgp8Dm0BP4blHZcJ6r6YuxjSY6KhK5aZmtXcCHc46Fomuu2r6XJc9kJp3akfP8aSSdfvCmes1
 2MhbndH2oPCBVdU65liKUO8KJv5AeKbDvzTMGMEHvtavryS0STVmNvJ
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: ea339c67-63f0-46ae-1854-08dbec1dd37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUl1IOReLpf3dxNKBZ5HHm+HQLAXmOxuNx598HnUiyXD9dJWACLU86hvaQ0BbY1KZ5yDFv9S+sp1SXSLGmr03LQfRoJXsvuaGgD/h6ymjrV99dhcgvyuvHKEPq/s4GdPKRylyZ3Oeqr1ip3ZmuT233nS88DED/zfzCX1UGXPXQ6u+xMebMLakToFFy7cYI5k+UQebNCzW7aH7kQQK7qnTHovyC/hc/Bu5exnw5jvH3kOREz9aLdy0BPtsp/o9JHaJIKV45IXPYJPwD5ZEvnbEKJrN+ganF9TXHRgIIAibxj9gfZeU7/4o5IgZDxVC+mn/bHwho1keOfu7YWyQP1bh3puQs4eqZcWnrLaRt31CgldGlFhfhe3HgFvVfd/iJ0dSGJ9uBFUqnR33poOW5YDV0GSGJN0eELnJ7NGBwSCIZ1/NHbillvNtJVq/UfPurHrDYX4hnTMbizBtnop/OQyT4FSxo7dAZSG/Mt9K+shypOpO0ETAx5b6xYmwYZepvo9gYe1zR+Qix/II2RjRcDClegtjO9SZfmb2QAMpm2dC7kEWk2Loai4yhUAPh/9zSfB/QHimdXSIV5+KzWCVzcWE3W0skX2mhLbZw2dT6B6FeP3qz1b66poPwBlt1764Ea9K69UbR2CO4FxqLxGcpLWWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39850400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(921008)(26005)(2906002)(7416002)(4744005)(38100700002)(66556008)(66946007)(2616005)(107886003)(44832011)(5660300002)(41300700001)(8936002)(4326008)(8676002)(6486002)(86362001)(38350700005)(478600001)(66476007)(36756003)(110136005)(316002)(6512007)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVg3QkhHOTl2MlJEbDVvSW5DQ0NmZStVWDdJeTU1bUpYcFNQWUQzazIyQlpZ?=
 =?utf-8?B?ckNwbWdpdEd5UVgwcGlYM2dmSENsTmNmdS8xMlNTQnliY1NsRFI0enJLZ054?=
 =?utf-8?B?MUhzQWpBMzNFbjJhSXM2aGpPczdEUm5hMFJ3UjNhLzN2OFFaSmd2WUFlbEgy?=
 =?utf-8?B?RG5sKzltanN2d1o0ZVY4ZHJKZTRDTmxWS2U1QXRyK3I3VkdOOXpKL3JVUjJz?=
 =?utf-8?B?T1huWDkzMENjYUV3OHlRcDRQQVFlbzFXRVZBVWt6RmJNRFVVSHpJeFFrc2Zm?=
 =?utf-8?B?ZDhMZHhWR1d2TGRtdnQ2NXhibUFPRmViSktvUHVNZzlOdkJRV3Z5Z3FzLzFD?=
 =?utf-8?B?NGx2aUkxd1crekNLbHpvMGczTkN0elpHcWVKMW14MWFhUlA0RTZyYzdGN09O?=
 =?utf-8?B?K1A2Zmx1Zm5HTy9jRnVUejM2SlVrclBwVTZ4UW5IZXNxTnVGRzJVeG1qdFpn?=
 =?utf-8?B?WEdFWnlTdlVJaktSbzI4czRKL1JWeWVJWW9rQWhkRE0zSEhGYnNsWjBwQ01y?=
 =?utf-8?B?WktYUlJ0UFc3S3FSN3ZWSUxFQy94cjRLZnU5eUNKcnYrTk5HbU1BMmtCUUVq?=
 =?utf-8?B?QkRMdnQydURiNkJaNmxFSUpDRU5Fb2MvMVFYMHM1b3VGQW5UVm9EdVhFM3Js?=
 =?utf-8?B?ZlZ1S0VyT2gwS2Y0Vkd6VVRUWXRGdjY3SjZmWXRUSDEwNWJ0UHV4NmlJa3Rr?=
 =?utf-8?B?dHlvd3I2S2JkM3ZZQ3VZakxSbWU1SE92SGZwUDdPYjduZm5Qd2luaXlFQmhm?=
 =?utf-8?B?bWtCSDhGUXEwNjhUM2xLZUFlSGplVFJ3TFJUNXYxS05KRTRrbnpYeTdaWERt?=
 =?utf-8?B?Y0VmMEdaUitwZ3BUWW40OEI0Y21rRjV3N095OHVSVUU5RlhpdGNWdFRnQkJi?=
 =?utf-8?B?Z2FxWjdkOTNoQkZ4VFR1cm1rVE1DQlJFNDNYSE1kZGYzZlIvYS8zR0VoemNL?=
 =?utf-8?B?UEJzeW9QUjhySzNaOWQzYnVmQVNvOStXYm45bnRJN05BNTIrQWxRMld1a2w3?=
 =?utf-8?B?UE8zOFVEcVNjOGVnVXhvUUpKQkVIQjJqSlpSbDN2bHpsc2dlS0FQbW0wdmZG?=
 =?utf-8?B?RTNIWUVRcnBZUVhmak80RURCblE5RTd6RENaQ3NjenhlK0ZxZm05bWgvSjl2?=
 =?utf-8?B?dXFwRVl0OU85SVFZOFU5NWRkWVQwMFVXNVhWeWtkTmd0aXZqMHBTZWVLVVhn?=
 =?utf-8?B?R1FpQjJQZEJTU0VYR1FLcFJCK0xHTEFXOUZncStRMzFuTUFWSFljUDR6NlZo?=
 =?utf-8?B?ZVd2UTQxRE1sTU45bklIaEVqTHFpM0FFdUU2OS9IVHZidm1Qc0JuSmlTQ3dE?=
 =?utf-8?B?SG00cnp5Tm5hOU05aDUrUE9QMGFRL0QzNWZucTZSZWdUcHluc3Q3ZnJBUjgv?=
 =?utf-8?B?UGdPUmFMWkE0SU1DNFhVQWpnZHJqaklxTGlGakgraGkzM1Y4d21lZldjOFNX?=
 =?utf-8?B?L2pOa3U1TXNHVGdEa041WXdaYzJ6R25pdVBPVWdHOUZZUGxXNllrREhSbGJG?=
 =?utf-8?B?NUhIOXpSR3hlT21uWTRRUWd1NWgxMStWSGVONW1nK3pGUFZyNWFuQjlJWnVC?=
 =?utf-8?B?WGR5Y29MUngyd1JNbTRYbmhPeFFmTzk5cGFYYy80RUhVK3NDWDhDVTZWZmNQ?=
 =?utf-8?B?VzRmQkhWd3I0NUpLdXhyN1lLcm84QmlEQXVMTXRsNHVueHpkR01nK3c1UVpq?=
 =?utf-8?B?WFQva0RHRDFoVUhRZUJQUEJ3Z2lUNVNtU00xVWZpVW96Z3B1Mk83Qm1RS3lK?=
 =?utf-8?B?QUJlUkxpbWFQOGk2d3plZVBsc0dWMEN6WkR4SVBPRms5R1pmeXZCQ2I0ZlZD?=
 =?utf-8?B?M0dQYXE3V0N4NjV2a2kxb3hkd1BXNUJIckV2NUIxRWYxUVBPbTBpVjBrWUFS?=
 =?utf-8?B?QnBBY3FsNGxQQXBOM2xvM0E2UUNpSnhhZzROYldEMnZSWXdzY0pnWG1QU0pw?=
 =?utf-8?B?alV4UWs5bWI4YTMyTmR2eDZoVktiTXIwMjdxSWNvOU9YaGFLYzU3VHFsNENP?=
 =?utf-8?B?cU5VT1o4NUJtNTZLQ0FFTnphOGhENWpNU1lBZlBmcFVqeGpBTUl5SHc0cG9Z?=
 =?utf-8?B?VDFFTCtrdVBjZnM0bkV6UE9TaGVTSjNCMUk1aDljZmZhczZ6c2E5dCswZFNl?=
 =?utf-8?B?WVhrYWo0RjJGZ01mY2J4MEtmdy9uRXo2Y2ZBQStkWHdFNzlTRWJ3b3paRTlY?=
 =?utf-8?Q?HPHj2SW+E48yzhJbWxFXIng=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ea339c67-63f0-46ae-1854-08dbec1dd37b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:15:05.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUT45QtFPuoIXKLDaGmqkWphvweITQZnFmd5deET9wEJWYAqcagJZi4Lf/zlqisvzRQEjwPye9xGGPrjKAPchKnDlyOa06HkqAuptN3Mfeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY WOL will be used if the rockhip,phy-wol property is defined. MAC WOL
will be preferred otherwise.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 382e8de1255d..c543566b4f90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1694,6 +1694,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	dev_info(dev, "integrated PHY? (%s).\n",
 		 bsp_priv->integrated_phy ? "yes" : "no");
 
+	if (of_property_read_bool(dev->of_node, "rockchip,phy-wol"))
+		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
+	else
+		plat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
+
 	bsp_priv->pdev = pdev;
 
 	return bsp_priv;

-- 
2.39.2

