Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14C775DE84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGVU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVU1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:27:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16356E6E;
        Sat, 22 Jul 2023 13:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8apI6C99qVxYwt6BfxRve8QrJTuockd4HqeZqtJAwm7sZeFaZCvRowOphbsCq9/M2zFbGA/DPNGZDWhJzRIlbzzonD0qVjLUxfapbpGqtElWtdQ3PnK+yTC2hA0Zuo5j3yEfBmkaHjy0NducgioRtHUmyzkqbctszS9shQE7O6goV2rukhCiQ9hwyweaRLn1R43e1t3kDPhC/RBvynFH5JqKYWoXG7qtVI8Rs35bn5vkYcyIO8wsk2urrZZA69w3IkmAwegHNunjuxLDIjItbM5wE42Vsmn5Kx/ykaIIjzUS0hWK6swSq2RV6ZnfQOpktwN2JQvT8Qx15K8pzgp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/50JlhsDWpo98egp8gr+A04vwJVYUcgz+95NAH1SZCw=;
 b=ItEAVEs7cPCjr+JxWpiCSCAHCLqMijqYz5X6GnpLrbs8xc5Q1t5jAMlAdvDYDBdU651zIL84uhcgu42uvJ+oMdbGgcPiLeYIDHkLFBPtSGjUxzAY4BRLh6PORL8NUzkHI4bVLrCe7G7L6CpegMWg2i+OS8BIy8xhDYEUcvhZHAxv8illO/8HrsNXQH/G7i0dCi5t7fRxpI9n6+MAuUYVo8FPDxdXq4usgACC1dFdUAZ/q+5fgVnmROvFm0UQhwb7FxvCm87wLyxli2c02jOpgvFGC2vy4ZT46ufX8QjxDnOot0Y/1tpZ4z1aTJZ9pEoZ0cGlGJCk8zg6DgT9zpK/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/50JlhsDWpo98egp8gr+A04vwJVYUcgz+95NAH1SZCw=;
 b=K58le5fKkb/woTliNBXOm5tKNWtR9Ypy7hC13F6IEyVZYLPJYy8OVZl0yooSieqAw8tIg2qA14DQEnF3yRuxb8RV9XGqZo0Cr2CK3QcO6z3KcvU+CnUccSaiTVAr3VnBLxpJS/XXmE73MBLctU8aSsQ33a3j6QijR0T2XE2WbiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN7PR13MB6278.namprd13.prod.outlook.com (2603:10b6:806:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 20:27:41 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 20:27:41 +0000
Date:   Sat, 22 Jul 2023 21:27:33 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
        andrew@lunn.ch, linux@armlinux.org.uk, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Message-ID: <ZLw7tVV0vs9CRiZs@corigine.com>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
X-ClientProxiedBy: LO2P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN7PR13MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 643eee27-5109-4554-60d2-08db8af21919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJj8vkgmspyPWJNPUyYjYgxsorak14u+dcm2l64/A29uy309K0mGWqT//ZrHxIWsNaOC5gyQlNRKYgicv8BjecWHWCGdXdpU5/cdQ5GcJCUq+5VOGCby6AIYR9nCG6wduHKbPYhB/KuFu4AHIuOI1TfvU3YvVxhoOlvuVazMQJOd4/SE2GX8J0TPV9ZPsrqoXR2otPO1wb43BvWOPyhwMaseGvuOpFijSxR3DxbXWlLjM7dflY4cpLA/qrH8itA7b6JN1VvfFf6oWNw9f5uNYgXV5Ogp5+6av055nGeLSn4MpZhcsjdcxdMA/zJexxfejcbzFMaY9M3xtS4Y9eDJAHJdKRj0rGWJ/pXe+GcCAPFqGuO6CgudQ1dFm9akwIWbqbM6ZO6DBIh6rBZ+F/Iu31x17iFhTS3HzH6P7AKV4cZbwOJ0Sf1uUklehSzzNyCA/fpLsDA/T16L7hljqaWI6Q5HoI0geuGlM58x+X68fGd6Brp90uRfa3x2oeFiItQ6sFbwcWQyeIyYeJyRYlzrM7budvwVy96eP1xgCDAL/2Pi7E97zf93K9q4QumQBzsHjNS1R//K3RPnz7XIyjADKPxV8T6gBpHelLwIIawhuHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39830400003)(376002)(346002)(451199021)(6512007)(6486002)(6666004)(186003)(83380400001)(36756003)(2616005)(86362001)(38100700002)(55236004)(26005)(6506007)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(8676002)(8936002)(316002)(478600001)(5660300002)(44832011)(41300700001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9KkN7jyIYdRhcI+J1Vv0V+zZv+R81EVA7TpBxUA6DJvN/EohD5sTaEb0gqp?=
 =?us-ascii?Q?WYzSCMStnL0u8ceBipMX3OnOhBUc+XP98Li7rkIf+oBbG+x32pr7fkMK9i4f?=
 =?us-ascii?Q?Z99EXLHNyUl7sc4jtA0EP6mUpmDfmw7pTpFhyWq79ObR1iculzIDciPxgjrk?=
 =?us-ascii?Q?hy3oIhncOKxLpVTXcsPkmcUWiqrX46BeXUYvbN3SGw2EJ0xpQCHnv274R0Mw?=
 =?us-ascii?Q?lowDVjrv+w5tRkYpN9yZ7Kt2f8tJ3lfzETuQ6Vr17X4Yn/uyPNnHRIMyloEm?=
 =?us-ascii?Q?RKuy+F9s3urLM6nuorGG0X+F776IiOz1Y04nfX9xDswEbuI3We7CMuCgeVUF?=
 =?us-ascii?Q?06yzm8KHYobzvHB3Ag/9vOe3WZ41qoNznyMN1KfDbXEITFf7VMw2rMChBKWH?=
 =?us-ascii?Q?143aB2fM/YAgUwmf4tA7gJqtw6+xjTvLhFJbqJlylukpQuQw3SKS+G+HXesd?=
 =?us-ascii?Q?zAPgMf0hDAamZaI1VIyRqwCMdTNHY6/uwiRtNce0xrSV3CKwtBq41DmLKGKG?=
 =?us-ascii?Q?I+UmocHD+NBId5YpXzy5agv3qbD4BLXHt8N8P/lYjk+xEy2mlytnMTRf40lA?=
 =?us-ascii?Q?KiN1TD3Y0pSMnxiDdF8TrJOM/mzpq3+mpIPooNGMdqsxDnKFrpZx5uB1cYDF?=
 =?us-ascii?Q?oRXbaF11XjdgXZpXgP5nIhMXkKM+HTxudbb687xzgpAbM1ZeVAfTXXO3/noA?=
 =?us-ascii?Q?sbv+wDl8EGikPrhOjfpsA/VWRPN2fKOb8FcnFfD6VCXM08iHbkxJagu5xFY7?=
 =?us-ascii?Q?JsE2k5EGUxPPHUowYs1tmNT44CaAKJ/Wb7FGam6yQ/63l4asPUe/j1ey05mU?=
 =?us-ascii?Q?5+69jUfH6TLvvfBTAgz5IDiuTYFl0d63Vii89bmYuaX6wwXjtGTs8V8MeGcE?=
 =?us-ascii?Q?d1JkgfteyRbluSsr48WHH2ht20pJzrwQ+VYyHDFSoQT1oYZxxKHXHOolcZ0s?=
 =?us-ascii?Q?8Q+svVluaYdykhXvYVCpBzOibFK890Mhjdg4xdh4Gcx56EBF9ZsBTRQyS2Cb?=
 =?us-ascii?Q?LCfVVZiQcRxhGMvyD9BViS92toPVdZ+sC/0iXRtal5tBwpSSKq9zhio09Chm?=
 =?us-ascii?Q?vwmEXEW5Jp6jZEHUbo3RkWdpX9sJf4KhDz1v1zglYvuQ/nWOkUKy1mmTJDM3?=
 =?us-ascii?Q?B5H+isRkbSJu4Y9+B2XxK3R2rRgmnwoy5Yl8qVuvPBo4UN8XOa+9kCZzjO6U?=
 =?us-ascii?Q?rUmeBPGTgWyXiXXswNqDB9ipxAbTTIPvm+JHS/7/8vEG1IzJe8dWB7xapr2B?=
 =?us-ascii?Q?EC0iK/DtuUC7Z/0mP6W45hMC3u3nm9w9Mw8DxjrWiIvbsYx27Ac31TfCT6zQ?=
 =?us-ascii?Q?WfiyOqh+XiUnNCOAomwOaZw5ku1P8MB/J4jtN6eQtc6m61W/fXrq3DZP5gA4?=
 =?us-ascii?Q?LBXnqEZTvg0pECb0/Y1+aFNbMDG1xYIK0RkalMBSzbitaRUCppc4Ig1Xso9k?=
 =?us-ascii?Q?q+ygQgo2oXgc8AM0Hug9loaQo142UZ7NqVybqayQf9tIJDopO8936q2rAVwp?=
 =?us-ascii?Q?DOPUYKm0rBai8td2Swm1Ub9W3Hyo2NKa0hpHFMnUQhXViGvY38Q07EholGrB?=
 =?us-ascii?Q?2HoGlN+1Hf0zYCXHHwHJQPjIsEWhhPzd9y+92nPRpa+0ZtEXs7aGAibT+TUT?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643eee27-5109-4554-60d2-08db8af21919
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 20:27:41.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMASgUg4Kijw/9xT9kQ0iEOHee35C8OT4CQoDVIBP/96b6C+q2JfOktYQiWlSlNeyJhqKU8TvMFpvLz88clsa9FGnhEeHrKVuBx/W/22aYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6278
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:30:17AM +0530, Raju Lakkaraju wrote:

...

> +static void lan743x_phylink_mac_config(struct phylink_config *config,
> +				       unsigned int link_an_mode,
> +				       const struct phylink_link_state *state)
> +{
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	bool status;
> +	int ret;
> +
> +	lan743x_mac_cfg_update(adapter, state->link, state->speed,
> +			       state->advertising);
> +
> +	if (!state->link && adapter->is_sgmii_en) {
> +		ret = lan743x_sgmii_aneg_update(adapter);
> +		if (ret < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "error %d SGMII cfg failed\n", ret);

Hi Raju,

Maybe "error" is appropriate here and in other similar error messages
in this patch.

> +			return;
> +		}

...
