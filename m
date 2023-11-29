Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C3E7FD69F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjK2MU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjK2MT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:19:56 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F11FC0;
        Wed, 29 Nov 2023 04:19:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PafScnOcqy4w3Px2rqrqsxUFDqjNJWEIyINzL141r1hWH3z3XMKckcbbHMKCewwso0acyC97q0pyDefqt+pbEW9XkOwtXibYVJsDSsc5Mgk8m2Y6VN9AS2FYRajNgAi10LQGAMOstSTPchbNdCJhhYoNq+oRBqCbKJzMpbqHqfoUJijASOWI1ANaMss7HeyXzYJRyCQVvFdXSUyvTh6YCsVKXsSrB7o6dRBHGbmxL9gfnKyB9m3KJe96H1LhJE3eE/KlpBYUNbpdybuVStRnTZEt60KTQ9XaTddzaxZM+0wO4m6jYVs4u4/GXQlqnMc04kU6va6XRSxTtV9pEpfZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGVUzERE2SiH9KvbY8uS88QjwnIqusg4rF8rjxMpllE=;
 b=Vc4sKQn7q2z+oj5CknGUsE40kHvrvdmOjox3JSMXGmpde/GBBlphW/8QSMUgBFAx458KBFTjivKYPxrd+tbctc5S6znWe6s8jJw0OSeVQmNR6IIvmawSqcuzYVcGTrmFmnuj7ygWvG2JQh6kqJAvpFSRbzgXiE0JvzZW/wnm4617I0gah3m85Tt/xhrEYxh8PPlOWsQ3naf1GUlG/WKPF3mETElArOmA3F+wiB6ZiFN0gQMsXcm3Ek6qwfSD4MnYxeAMOMFMlI4Zts2kTXWgzpJm+P4J05U/17xlNk/yHyAe21aMi48EbrKJb317yn7HhUUX80YMh6DAN+93cuMKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGVUzERE2SiH9KvbY8uS88QjwnIqusg4rF8rjxMpllE=;
 b=P+7d2NUYqA5EReIxP1ndV4qVqjNemOOA1V8Na7Om3I33kaj3tswTbakpp0DcN0i4tht+i1FLD5GZQdONwKycXtZnOCWJDJZJKdm9v/VFmic8Y6sKCR/6ykEcSbrQfICEEOTNM1fuoiS8w8FUZmFkaHITFLuHvd1gwTZmVaK6AuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6804.eurprd04.prod.outlook.com (2603:10a6:208:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 12:19:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 12:19:42 +0000
Date:   Wed, 29 Nov 2023 14:19:38 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: sja1105: Use units.h instead
 of the copy of a definition
Message-ID: <20231129121938.whkzbr37d455yluz@skbuf>
References: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: VI1PR0902CA0027.eurprd09.prod.outlook.com
 (2603:10a6:802:1::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb03e15-abe0-465e-f4bf-08dbf0d57746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcXkTJg3wPBCZKcZ6zzIVI1y9XRfJlokrWLcAVHMfjDLOhyKPARxwSWSOq85s8h9MY6uarLwtQgRHn8Cdi826O5Uxs0TYa2WBUxspQUPfikvTzn1cwHfBnkokduUhcdXkJpJoDjp9Xwg83rf0jqlZ2BIinckR25aFYP26sgxsHDZbLm1fzeicqGlhfbudIMbBBeJbJa3mv8IEVzCWPqh545s7cyFDpXAWcnzB4SMAQsNvyWbvmmJ34fIZoeCcRCpw/+bGiOFQl4xikFHqe1RwY6/d8vKpSwgx/0ftMMi+aJuVNNYZDLB5uNJVWzOboSxwGjYiQZanNpCA+JVqmHOlYxGWlR4+9Mpb/Y8AbQuoKppptIiJrm30ZwLUeDunlJjPsOBVdpjDg33bKj48hKL0GL5Lf1LWxm9Fr1qoRaWZmtTpTjcgBJtojs2NJdWBw5FZkXm39sAzXvT/Op8zVgdtcUtXkyacQ3dIeZPpN2w8g0mGqVC4NuNRgbMiDbDZJJiEHPCJCGvty9OkhCLcngjpK3t2qKjvPdhpVpIlf3749BlGeJjVJePPrKhYGhOI4Nj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(558084003)(86362001)(33716001)(316002)(8676002)(66556008)(66946007)(6512007)(6666004)(1076003)(66476007)(6506007)(9686003)(26005)(38100700002)(54906003)(6916009)(478600001)(6486002)(2906002)(5660300002)(44832011)(41300700001)(4326008)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c36ahqYnj7wcES+xUVX8dF80uO4bo7V32l703wuRtVqlN4A5GPwE+KvMsZ1Q?=
 =?us-ascii?Q?tKcT/Zb95gxdAXyq6B1iHvlc9lkdVGxj8r/i0Ma8cv2E1C7bXNg2ZVhDQePw?=
 =?us-ascii?Q?C8AVuiXSNvKaVCSFYqc3GAsDvolDYX2X3OZ5uP/atCS6Aqfo2ntIZ4l3cnqP?=
 =?us-ascii?Q?FjEvBNfFkUPiTNtVb4vOHV7PgcyoBMvgLjv5ru8WK3hvy3CSbPBcsbUVNe05?=
 =?us-ascii?Q?oqFRd5L9jJ8Q6g2ebYJb9eCPkXcpw1DIC8Nsh/qDr39Mi1k8n8p8+Z3+4qd8?=
 =?us-ascii?Q?jvYG33rg9EZex+WcxoEwJJV7GUuR7QBOa366q98qMWkL9IpHAj3e4btztL2i?=
 =?us-ascii?Q?drK0T69qGqFB2Fnf+g48Ena7lbM7oB5C5+J+2DH39bEZxBJ7GyklDF236QnS?=
 =?us-ascii?Q?YTfo2usGsCAHpK4RPWP8N2uRFpr8t16hutBE2zc1TWBVMeJkf08QWXtTHs9b?=
 =?us-ascii?Q?8uqdAZLIAAjKTYF7RPQXTueCrhzpMl7nuZ1JUVZzgqgkm4QqYky3EYFCEjMz?=
 =?us-ascii?Q?QtL5CmQ6UGub3oMv3c3s9GzLXfwOnHE33w+JP3KI5ICNygDG/5eQOFrBsNPk?=
 =?us-ascii?Q?fKtDpLItrrdZt8m6QyJtI9PD0g7p02fGP7Slq7DrFlGeEZLdcIiqzpa3OyIy?=
 =?us-ascii?Q?XmJtWZQSeJAqhDhg5emNU3wE55QxO5hzKo9sHM+fdP+vE01q1zqqw7giLtsW?=
 =?us-ascii?Q?6JEhbFxvUsS2pV1mzRLoCPlK4E+FV59hxF+rqR3JTcmZafSyV0fbMdoBQNm+?=
 =?us-ascii?Q?cDiThqyxWw6rkRoEgtaFg7f2jvjcFYoA22mJiJgaYzbtd5bcnNXfPapvothc?=
 =?us-ascii?Q?+bnFK9lyOtAzOKue3lSsyiwgob8qSJmGomHtshgnUT9kS/n5fp5+JeUueeGV?=
 =?us-ascii?Q?WM6VEtTER6ZZzug+HPR86DVyagNtdJfAazfQBEwkcQmhyJMKv5T9ECFTZ7Up?=
 =?us-ascii?Q?28clTZqDph4hz+bOd3EwiziUeCtdi9/VF03oHOcgi6+JM9W44knYaBHPaeU9?=
 =?us-ascii?Q?0XHcfvcK6j0KevtozTE9kkjWvjX9EdESSRIfv/UZU2b8aF/DmGEyRTgVdFE/?=
 =?us-ascii?Q?A5jEp7Z9qLXjrq04e/r2fEzu50Q3K8SRcFHkab/sJOKXHfbh3MuJYJWNW9Gk?=
 =?us-ascii?Q?0RJd/1t+p0DFgrs4UboZeqn7pUCtOTdQQIgwMHkME3fTfFOwF0yGX5/bxb9S?=
 =?us-ascii?Q?+pIDLJh+x/LqBFVJQF8VBVBbs5iMfeO0PWuTV5owQ1xCnjqJsgJxapc00ThT?=
 =?us-ascii?Q?nhdt4yNXMBv/oWVUubC1M8mMpXyqANgEs/GJaTGg90XHE5Yj2omBPrFTrAL1?=
 =?us-ascii?Q?zVOF5izYXTWilbTN/z5af4W9DSWTl/RQ8b3uA+CBD+UgLjceRQ6MIrgfgG2b?=
 =?us-ascii?Q?fq0cFWjK7Yhpzkectp2BJXeOZl2/XSVG+0B2XhJ+IcfdWo6sSNULiCgpgNJv?=
 =?us-ascii?Q?wN9gBDeDxGpUCz0uT3dGi8shwdsxNlHRNIRG7dSrDg0d1f7XIJbuZpZC7tgP?=
 =?us-ascii?Q?+hshw/zKmh0/SaKxk7GnoQGeG9OZ9FVlkEQnVEGZZehHTAQoEgQOnkSLAIRk?=
 =?us-ascii?Q?0scHqH1f2JkgqG5zmO8Tr9BbB3yG29WPRK7u9+r2VLc0h7NoNopm7eUGn/MA?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb03e15-abe0-465e-f4bf-08dbf0d57746
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 12:19:42.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lykXh89/QRM2MMwsZkyX3n3nSV+gAtispcRu25lFbnw/4nmZH9Z+oxDmlwiawPnwTuDAzbVRevqa5xRVO7aPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:50:27PM +0200, Andy Shevchenko wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
