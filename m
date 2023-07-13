Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B777675183E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjGMFiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjGMFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:37:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2095.outbound.protection.outlook.com [40.107.96.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B025B119;
        Wed, 12 Jul 2023 22:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frAx1imPvdiUcENY5CbfyXPFvZ9KOya+3uydx3LBBkeN/IITF/q5IdWJ70SuRbzF6igVebhgl4MI/O8hGGl8fPLgjjJxSKFB2C7yt4lvQUXPn4GHWqX+ZbN8H2uLwyOEa0oMPwZm2MAyOHBvKAtoAWm/JmdiiRgIBDQUy0rsVwvjH+LgvueyoAiLiLWC3lJk+x6+Ba7DHKMYsVSMouSAtCBsrJZkSjtJN7hCZDGtKbj1t2WLY0BZWV4Y/IM3SNKbaKb0gY3PCIK7jsUHyG89RdoKHJEL6kG9o5/A3xnYALjq0zqtPDHiUIStquIR/WzY+13uKNJ8wb4OybnHRAO3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFsrFMty1EYeVZfALstKrXwq5InG4/CZ5HnQcFc1UkM=;
 b=DvKxIZ8ii0101ck0xwG4CRhY938NK6cikb+SmZ86YzW9XpBVKv7sRdMmaDxXj8wLpapVJgKS09LY4KtN+fZSLEh2VZl95fd1KYFfNg0JxRQCC86KEehIUlcwkdGThwHw+iAhwX7ddwA7HNZrMDofAdLCLsRKXxed2n/KZ6HCqXN/hfMeJMCoU9VeydrPVvEdQPlui8qmbTAxYemTQ2SGva6LDJn5ymqamU+Sh/DfauxrArVW2/awXx8Ilj7Bhhu+B8Yxf1DuHScrCh15EP1ljdexdz/Ab0ftnX5ZrfLlOh0kGmswWdHI4Ff0DwQrmFVZzGrineo3/6Q+4rUayGptRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFsrFMty1EYeVZfALstKrXwq5InG4/CZ5HnQcFc1UkM=;
 b=Wyc5xK+J+tqMX4WYIA0/ksjbI1qo9Y0LsowzKgaL8+DBh27Jp5XEtEaI5UbCVxMZV+J0wPmBoeW7dFkYVClPhtlCaNel9AtxnnALzzHKm8pGraVH+Wt+fzYSLeF6j7JwDkpSFOboNNxdd9frLjEErTo+oRDjxoDOwdoEyoy67Uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4834.namprd13.prod.outlook.com (2603:10b6:a03:36b::10)
 by PH7PR13MB6171.namprd13.prod.outlook.com (2603:10b6:510:242::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Thu, 13 Jul
 2023 05:37:45 +0000
Received: from BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::9e79:5a11:b59:4e2e]) by BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::9e79:5a11:b59:4e2e%7]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 05:37:44 +0000
Date:   Thu, 13 Jul 2023 06:37:33 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, quic_saahtoma@quicinc.com
Subject: Re: [PATCH 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Message-ID: <ZK+NnWadQcmUDp0A@corigine.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-5-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711093529.18355-5-quic_devipriy@quicinc.com>
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To BY3PR13MB4834.namprd13.prod.outlook.com
 (2603:10b6:a03:36b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4834:EE_|PH7PR13MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccf6407-7c3e-4731-d4d7-08db836347c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVdrHAbGdGOGnakIaHLaV4Hm1OoGa0ZOeayNFI9E8NHEbo/8GuVl7vpN18ncNDI92ddA47yFDC0ZS9MZ4lcGSkMe+txZenaPwsirENThB2lGt2Y+ZifEG+/5Cmt4PK5IIahtRKIcMzc/IQZClSyqoILFn6TYDcPo+MYSo1aK7rXLlcLbJWu7Dp0dfCI74+tXwk0YeRYd91tApLuqqNXSN0s9vzDPVs2zHZZvAEkQAa5iBZLaFmMY6AjxO3Xq/yQ8vwe1uWWxWEaLZJvNwLGnAO2fENnerhquJgAbdGyhom0ZJcKZ83VVfu+3qNn9QclWTOfSrPK59XSDBJU2UcAqlsy+vEGRpFEojfxFzG9ueIGbSNxLmQpa6RyO/lGPK+bHSFqFxB6pxNmL2mBJMyndxadM52uZ5TNOrNiHUwpWf9w7ZDbKIpOgyUfNnzU1tr2LPP5oC5t6xL3pTJmFZRS7oPiomtlOPpsyjcDMmAZ8UlzoKuZ51R1Px+HYTK5Eh6kIFMQyvCFX2N31DIxCFImpe3CQ6U4JW8QIdI5UpfwBIkJ15accS1Qadqo0445pADfvXSQoGi5WJsotCQ8P8RR5QcCNbHzoH2QPQkWCCpJQtOsfaN1trR+GNJ4dOFKgWQ21QbE21GLC1U5sZNXVjwflYkzp43j/S039fYQcpHcjHJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4834.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39840400004)(376002)(366004)(451199021)(36756003)(2616005)(83380400001)(38100700002)(86362001)(6486002)(6666004)(8936002)(44832011)(26005)(7416002)(6506007)(6512007)(8676002)(478600001)(6916009)(316002)(5660300002)(186003)(2906002)(66476007)(66556008)(66946007)(4326008)(41300700001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dVhOgQaRowTAlgMATWlbBh9nr38/GyXbM1+x/Xhrq05oajMqOC+LWbSMZ3pF?=
 =?us-ascii?Q?OOLFdJ2d0lp3IsQ2u/KladeLQA61k8Cnm58vUSamBBB7ai4pAZgM6QBzKy6N?=
 =?us-ascii?Q?XyP4W1Fotf2XySk2NLfT1sw3zEASOIb3mYBjFmmKm0MZem9tOFT/QWx0ER8l?=
 =?us-ascii?Q?j1gjVoBopNbTC2oT2qunqNSTiJ4F27pVl6xZ3tlBRNF5znLB4kbR03lRnNgw?=
 =?us-ascii?Q?M0s+/+55A0+i8CULZuzhK93wKkOZmzE/8G3uUlDVyWdQagarKqI2QKdcKbte?=
 =?us-ascii?Q?4X3jzkClk+5tLZ2jZv1fDrd4/aNndgmVZy+Oi32GJpndY7AlNbDvqAEteGV/?=
 =?us-ascii?Q?JWSQKbObCHsXOvIqEjr7n2V7UUtTwKXnbjupmbALCuSV1pI1uwefQ83IxpCe?=
 =?us-ascii?Q?I4rE1sfMb/kvzsHLzoZkygvEgTfy25EwyDJL2k+3EmTa+Q8e+2MBHd6zVMMi?=
 =?us-ascii?Q?qTEn0qlaoYp1zu4FWyYEcl9VQGLE9Dt9v12w/ynu1yd4mEwmBm3vndsxVS8w?=
 =?us-ascii?Q?XqAmLTY2O9GkD5mW6JR4FcOkj/9a/f4K5SxesMBFeFcoorbZH28cVaG0Esy6?=
 =?us-ascii?Q?UFA7/2GwlAOsXMVOPKCUR9YFa346KnzhA2OYFjVoliQhpyZ5DbddYkit6PiL?=
 =?us-ascii?Q?zKMiE73OMWC1qzme+cN3EFhuL9MufMoUI+QVmMcZ5cHjdoYN75Xv+9MTP8GY?=
 =?us-ascii?Q?JTZPVqfddLMLJDaPfZjs4qQnrHAylu4Uvxg8hAPQSTmw/kwXzKueeTvxVg9B?=
 =?us-ascii?Q?C5sXCuZ1zlQOmCxQzoyXfr67+/PqyTU9KH/9CPZkNPba9275/8qGhaeKGE6Q?=
 =?us-ascii?Q?QHQ8oYP1dNVuXurBkjMqfACMaxKLMI0CA481pl9NynGZTmGHLWKUoSeUXZ4W?=
 =?us-ascii?Q?uePnAE1EcR1cXGodi8fsK3dwwr82nmL03V0BF0XeqP2qwY5yz+nlVUdp4k6Q?=
 =?us-ascii?Q?ticy5MfF+6ETd8Kf0N3XnA6DPmKQP7lQBjPhYWPtlXsI4qs9ACG8ZIfriuQ/?=
 =?us-ascii?Q?yYh4RtZIgPMkIQaZJlQ4JyKUQh7BbxelLJpGPXwTHTB9lGLh77bIQM7euK1S?=
 =?us-ascii?Q?f8TRazBYl+4G9k+O1kCcJ3wIQi005ZHU7fGGPNdB0rkYT4dh1vaX2C1Bdpmt?=
 =?us-ascii?Q?33rbmuUxTGWCrIPNJem2yIgn0zzEriPrnhqETwHVW/CHtFzUS9Wbwa2m1KID?=
 =?us-ascii?Q?KuxQj2uMsu+ks/Ajv746xOv0h4itAG4dl1raaIqOoBoFX9B1FnkMl7Xm1lny?=
 =?us-ascii?Q?kUAMikGIj82Kw7bMyluKuwym9637MHVWDT9uNjSXWzrUD5k39VEhisAYItWV?=
 =?us-ascii?Q?xCcFJbnoTZ43a82TlMRXMPVMcyD+iL4sglL91Yjifx1TUPB6832sfe06/xiu?=
 =?us-ascii?Q?XJ5FhcDFPqIrFjZFSQK4q9BtWM8D39e4V0zHycKLd+r8GvpWIXyFe4Y9ef9y?=
 =?us-ascii?Q?/3gzD1injJLa7lIm8cC71ihaYsf0DPguD4hX11S0RTwose5VS3zoA4GpxJDV?=
 =?us-ascii?Q?rJEPShfp3okAJOjoucllZs/fyshCyC9kbn5GpU2/UOS9C3Hky9vRumWr03f3?=
 =?us-ascii?Q?3Sp/JkGUaRGv2m8gbHCkEnE7tiRZnXryFNfvAd9zmTUoEGJ5lKhIYwnLSjFb?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccf6407-7c3e-4731-d4d7-08db836347c2
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4834.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:37:44.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9wooerfjW3c7RLA87xyX3Kk95ZCOqTOTE2JZM2/6Y9gKrgKgWd6qGaDGzPW2y5mViKhwnJathIzdF5D+dzVlBXHkn3Qmk/3xZvkFT1f2O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6171
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:05:27PM +0530, Devi Priya wrote:
> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>

...

> +static const struct qcom_reset_map nss_cc_ipq9574_resets[] = {
> +	[NSS_CC_CE_BCR] = { 0x28400, 0 },
> +	[NSS_CC_CLC_BCR] = { 0x28600, 0 },
> +	[NSS_CC_EIP197_BCR] = { 0x16004, 0 },
> +	[NSS_CC_HAQ_BCR] = { 0x28300, 0 },
> +	[NSS_CC_IMEM_BCR] = { 0xe004, 0 },
> +	[NSS_CC_MAC_BCR] = { 0x28100, 0 },
> +	[NSS_CC_PPE_BCR] = { 0x28200, 0 },
> +	[NSS_CC_UBI_BCR] = { 0x28700, 0 },
> +	[NSS_CC_UNIPHY_BCR] = { 0x28900, 0 },
> +	[UBI3_CLKRST_CLAMP_ENABLE] = { 0x28A04, 9 },
> +	[UBI3_CORE_CLAMP_ENABLE] = { 0x28A04, 8 },
> +	[UBI2_CLKRST_CLAMP_ENABLE] = { 0x28A04, 7 },
> +	[UBI2_CORE_CLAMP_ENABLE] = { 0x28A04, 6 },
> +	[UBI1_CLKRST_CLAMP_ENABLE] = { 0x28A04, 5 },
> +	[UBI1_CORE_CLAMP_ENABLE] = { 0x28A04, 4 },
> +	[UBI0_CLKRST_CLAMP_ENABLE] = { 0x28A04, 3 },
> +	[UBI0_CORE_CLAMP_ENABLE] = { 0x28A04, 2 },
> +	[NSSNOC_NSS_CSR_ARES] = { 0x28A04, 1 },
> +	[NSS_CSR_ARES]  { 0x28A04, 0 },

Hi Devi,

There appears to be an '=' missing in the line above.

...
