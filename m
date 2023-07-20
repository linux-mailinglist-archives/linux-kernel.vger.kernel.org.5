Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150DB75B3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjGTP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjGTP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:59:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88FE44;
        Thu, 20 Jul 2023 08:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/hH28+k9YP44BxI3rE0TRBWv7W3foUvhxBPEsTFawXmTFyE6TknvHciSx7+lPkqPkbJMAGdVdQS4m5rI4PYZhUWNJDNlE5/6DuB32gbtrm6fUQroYhlN1VspwzGv1hrHPEHzoT5e6c1JlpGoj+mFfK6xQHCc8DfX4+rc/Mhj6ivH8N/o0wSb6eCfb0fbLo+0xM5WqsH956sxZKQ6aCJTFny+Bds0tDnluHKY+VIIzGS8xlCNVUxylWGee3mME7ikzS93UfqvqCVKOT5QhiU7Hear8od+WO1c8pFG+jfLcZcGXJXYhUuz7qSaayDRrLhvUB3znBFEBQKZkpMf/lmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFREafN22ENXYSSjS7Rl1McWLg37iewmT4jkTWP1JQA=;
 b=ZXAGNjQxPDgx5/0UDvKb4kxd2jVKo8iHnQdBHS4br7NctdY7GnzaSbZhczaF+uCzIIbA4dssPEGCc1itNP/eBsOc9Z1EtTBhwmhd6SWg9k1DIL47H8sKhXRXWE7QI09K1T9DRn5pLz/BvYT1ToHfnEYy13B4zcTdXJiT99PVQJQNPl0baPtqJa3CJFILQpuP8DYMm7YORUbJeVhX/rNNa8s2+CWItNDBV2ALmtGdDapnWO++GmJeDMzRF36ftkK+LULr7tzP1fF1plzULaN3n23oO/gATawaVygWMdOfxMPj/iSmNUbSiU0wuENYhV8xTIFKPDbbUIIB+drpxcIEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFREafN22ENXYSSjS7Rl1McWLg37iewmT4jkTWP1JQA=;
 b=POXvjXFm4sBJ3jWe1DGM/n4hBM6QKtFGwAapucARNdeI222ZibG5vWG4wRNi890cMTqBDCOUTmuCIdgRaK88T+kqyrx7MjC0lpkUdV283MqEDpw/gcVSDjz10ORntrOldYuwGWA/RqxjBev/7+Q9ZgcgtXHMUZzCBX26ni8OcPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH8PR13MB6184.namprd13.prod.outlook.com (2603:10b6:510:25b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 15:58:56 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 15:58:56 +0000
Date:   Thu, 20 Jul 2023 16:58:49 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v5 12/12] can: m_can: Implement transmit submission
 coalescing
Message-ID: <ZLlZudoYyarYmEjz@corigine.com>
References: <20230718075708.958094-1-msp@baylibre.com>
 <20230718075708.958094-13-msp@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718075708.958094-13-msp@baylibre.com>
X-ClientProxiedBy: LO2P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH8PR13MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ae774b-d8f9-48e1-5f13-08db893a394b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjwpr6/HF3ASVJXU2fQ37NEj7B9qf004BeRsOLB4r/SIdchBnlveOR2BH5qBUi4svL4PpafQLx0Dp+JrUjWDjpixO0wEaqP3M04wylnHYwLg/MGtn3nUKwp6PEQ6VkeXkDM7OINR0nBNnjMseB33VYf8+Yg+xfDEOCCHBQVW+dLVA6DIE5BM9w+QndzJgt8B8Hjs1RPJnOacgzYr8AQBKMdYdl2KZ7qNU4merwG1F+DSmiB1emH/vfy9x23ZH6izk2xuQsNSssRDBmH7mO10fykc6DRxmu2isOCeD97rMnMpchy/U2yiWqq8fDnBxzKofW8GLcwjqfQBOTu8ni4LdbM+SyQfbGDBmIcDl5NOFlRAIkD4Hwe+CHsZmJqEbg5hd0yQKofr31j94UGKvkHWd0NR/zdI36LKCF676zX79d9qvI9qrkAtvR43lrgNsGfmZ3wMg3ThyNXVGHL7UHe+xKGWZiU0w48wzzsKbFX1a/YODnZqPuRB0AEhuO3Bg4S+NTZHQleOPWNHeYBuBXreSBglABqbBzK46IDhJU4MOQseAIJE9eMTf/DRELAfes8PcAnbYzOggZa4VoCtt8Dqlhy8BPEaod5Rv7zz7FxEf/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39830400003)(136003)(396003)(346002)(366004)(451199021)(6512007)(6506007)(55236004)(26005)(8936002)(66476007)(66946007)(36756003)(38100700002)(7416002)(44832011)(54906003)(316002)(6916009)(2906002)(5660300002)(6486002)(4744005)(8676002)(4326008)(41300700001)(66556008)(86362001)(478600001)(6666004)(2616005)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEV+Z5JX7jXzccnJREoWLqJmQolXhki5j5YCajdINblQK6I4oIYVup7Rs2pN?=
 =?us-ascii?Q?1jXcqFBeCVQCxlv43t5qr6MvI9sfgrFdTvGnAX405d6o3UWd0bAidujIZe03?=
 =?us-ascii?Q?TGczu1NLHyiu/zyLCjUHobEQpIl+90A9SdRy+tI8UBgomy29yEXswDlSIE0O?=
 =?us-ascii?Q?bqaRgxFc0AA6H+RzEFHG4sJMmt1UpQatnwzSEp4fElr0wAS5qsq1bnFhRCs5?=
 =?us-ascii?Q?wc2DXEwYHm3mp4JVBMlqSYUPN4N2b///h5uQZLIVJ0AI93LQc3j/h3TxzRcn?=
 =?us-ascii?Q?8GkM+zMEazAFG2xtv8RauhBs65st9YHN9GprHqT6uOPacunfGQ+HNiSkzGUP?=
 =?us-ascii?Q?YHSPyWKspcz0jMMy6xZWRGyDptwTetnY8AZk73DxkaX9uGz+hiM5kfQNs0Mu?=
 =?us-ascii?Q?O65RnShyCJN4MN0n0c0wmTVw6y6NqkvxVfsrrbiPitY39IkRZPIv/OjhAPIj?=
 =?us-ascii?Q?dicFjcarfye6vY/0yIZVGD/AO/bI/ydI/sVOZ07/pG1qBSeBnTB4w20LtGXZ?=
 =?us-ascii?Q?R8bbjWKEFUzVE11IFcaJbSshrmeb2cQVSjPJHNDbQqe6MAIGirDOefdF2shj?=
 =?us-ascii?Q?bJChvVAZeF+3usT49OePB30thCDq97O5i0XZKIHuHOiqvfxlR2bhYqbUhZiQ?=
 =?us-ascii?Q?LJKAmt9BirSgJ5w5ZG+hHRpIOqQI+WwUV/4fdy5ppivocHHvNJPLhSLxoOyl?=
 =?us-ascii?Q?l/mHJQlg1jPJLGPIadT1hnpxVeuWbx27OGYtpQuQLDrV0lqHwOAHSS0OmSfN?=
 =?us-ascii?Q?aU6EJqOPNCYGCIz+gUA7xtQWDojCYl0ZYy5lyHlwwi3rUNZ733EOnje80/D/?=
 =?us-ascii?Q?kel3A9yd/9d5cza+V0RAVz9fMTynk+rLvF11fCwsE0ZHICKEWlzW7ArXzdJ9?=
 =?us-ascii?Q?j8sqg0tcrkoNfiQVpJJvqytvaO/HGcj1BMX83qnYkg5k+HVsz6BgBYiXjosf?=
 =?us-ascii?Q?1v9xxZ1N9svd14cRL5GAZRyBiR0lOpF2BFIiaa6tvSteyQB4DeaU2d0eY9b1?=
 =?us-ascii?Q?qIzVm9yIUc/+Ior4P4KaV04zdiByGZXAmZAfjMoubJ/6UpEA2rC62TumYKGw?=
 =?us-ascii?Q?FVxwnKDHIaXa7etsDeo0QDQPxiLOv6tLg7xDlrPPmYjTbkMSjOP0Ryjz1Qpy?=
 =?us-ascii?Q?Za4M+SELnJpoGSOdVGcFn0qmFtBzC97bH9mHZ9HZn0+UsWhcIuOc4ienuepq?=
 =?us-ascii?Q?tps1TTqH6pz1z/xnBLd2fHGEi6HXF8CfjfKxT2WDgoPLd1ofbJwwBivwJjlf?=
 =?us-ascii?Q?8f5bxhNLXb/Mq2vcMcHPmFYNGB63Ol/un8Q6cJJI2Y0kW7RCsRBRLGZP8UAc?=
 =?us-ascii?Q?2de3/MAqWxt0Vj/8XACV8TfID//GE22Th+VKIs5/6Hp4wzZSNl4bz2q4/wB1?=
 =?us-ascii?Q?sG919EurepUrXMpUjjnAu6EKrkfLL8XenB96mYTVfVyYJlfOkRr2mhia3SE5?=
 =?us-ascii?Q?KbMu0FzSg3CX4X5cmC1aBSVCtLkBue3fbhCp920wYBM0UZf0hEoBDqg4cNcJ?=
 =?us-ascii?Q?3VbbnuNTsr97Cf0kqWaL0VlGFnTLi76keHfkxJ3rMG/53GiiOraD3E5p19Qv?=
 =?us-ascii?Q?sAJBn2M3rnk1GwcFDvatctkf9t5hnlCVQZqK43XdB9XeH/alhg4eaxNlajmD?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ae774b-d8f9-48e1-5f13-08db893a394b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:58:56.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCTaoZqZ1E2QDw8ySJD4xS2tMpJ50oCXFj8zuVz2ICUOvit780jl0hLNQ2CEbEm3huvjx4vPzSKn5X07ltBplvWlQFA9cSi/vxpFkNNWoDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6184
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:57:08AM +0200, Markus Schneider-Pargmann wrote:
> m_can supports submitting multiple transmits with one register write.
> This is an interesting option to reduce the number of SPI transfers for
> peripheral chips.
> 
> The m_can_tx_op is extended with a bool that signals if it is the last
> transmission and the submit should be executed immediately.
> 
> The worker then writes the skb to the FIFO and submits it only if the
> submit bool is set. If it isn't set, the worker will write the next skb
> which is waiting in the workqueue to the FIFO, etc.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

